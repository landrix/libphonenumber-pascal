<#
  Shared helpers for the C# NuGet reference oracle.

  Four scripts need the oracle: generate_reference_cases.ps1,
  generate_aytf_cases.ps1 and run_mass_differential.ps1 load it, and
  refresh_vendor_versions.ps1 has to record which package version that was.
  Before this file each of them carried its own copy of the pin, the cache
  layout, the restore and the version gate - four places that had to agree and
  no mechanism that made them.

  This file is the single source of all four:

    Get-OraclePin            the canonical package id / version / TFM
    Resolve-OraclePinValue   "" -> pin default, anything else passes through
    Get-OracleAssemblyPath   cache resolution plus (optional) dotnet restore
    Import-OracleAssembly    dependency preload, Add-Type, version gate

  Dot-source it:  . (Join-Path $PSScriptRoot "oracle_helpers.ps1")

  All of it needs PowerShell 7 at USE time (the oracle targets net8.0); the
  callers assert that themselves so the message can name the calling script.
#>

function Get-OraclePin {
  <#
    THE canonical reference oracle pin. Change it here and nowhere else.

    The version is the metadata release matching the pinned Java baseline; it
    is recorded in vendor/versions.md by refresh_vendor_versions.ps1, which
    reads it from this function.
  #>
  return [pscustomobject]@{
    PackageId       = "libphonenumber-csharp"
    PackageVersion  = "9.0.42"
    TargetFramework = "net8.0"
  }
}

function Resolve-OraclePinValue {
  <#
    Returns $Value when the caller supplied one, otherwise the canonical pin
    value of $Name (PackageId, PackageVersion or TargetFramework). This is what
    lets the four scripts declare their parameters as "" instead of repeating
    the pin as a parameter default.
  #>
  param(
    [string]$Value,
    [Parameter(Mandatory = $true)][ValidateSet("PackageId", "PackageVersion", "TargetFramework")][string]$Name
  )

  if (-not [string]::IsNullOrWhiteSpace($Value)) {
    return $Value
  }

  $pin = Get-OraclePin
  $resolved = [string]$pin.$Name
  if ([string]::IsNullOrWhiteSpace($resolved)) {
    throw "The canonical oracle pin has no value for '$Name' (tools/oracle_helpers.ps1, Get-OraclePin)."
  }
  return $resolved
}

function Get-OracleCacheRoot {
  <#
    Default cache root: tools/.nuget-oracle (git ignored).
  #>
  param([string]$Root)

  if (-not [string]::IsNullOrWhiteSpace($Root)) {
    return $Root
  }
  return (Join-Path $PSScriptRoot ".nuget-oracle")
}

function Get-OracleAssemblyPath {
  <#
    Resolves - and unless -NoRestore is given, restores - the oracle assembly.

    The cache layout is <Root>/<Id>.<Version>.<Framework>/publish, with a
    .oracle-complete marker next to PhoneNumbers.dll that records the triple the
    directory was published for. A publish directory without a matching marker
    is treated as incomplete and restored again.

    -NoRestore turns a missing cache into an error instead of a restore; that is
    what generate_aytf_cases.ps1 wants, which is a follow-up generator on a
    cache the reference generator has already produced.
  #>
  param(
    [Parameter(Mandatory = $true)][string]$Root,
    [Parameter(Mandatory = $true)][string]$Id,
    [Parameter(Mandatory = $true)][string]$Version,
    [Parameter(Mandatory = $true)][string]$Framework,
    [switch]$Refresh,
    [switch]$NoRestore,
    [switch]$Quiet
  )

  $projectDir = Join-Path $Root ("{0}.{1}.{2}" -f $Id, $Version, $Framework)
  $projectFile = Join-Path $projectDir "oracle.csproj"
  $publishDir = Join-Path $projectDir "publish"
  $assemblyPath = Join-Path $publishDir "PhoneNumbers.dll"
  $markerPath = Join-Path $publishDir ".oracle-complete"
  $markerContent = "{0}|{1}|{2}" -f $Id, $Version, $Framework

  function Write-OracleInfo {
    param([string]$Message)
    if (-not $Quiet) {
      Write-Host $Message
    }
  }

  if ($Refresh -and (Test-Path -LiteralPath $projectDir)) {
    if ($NoRestore) {
      throw "-Refresh and -NoRestore are mutually exclusive."
    }
    Write-OracleInfo "Refreshing oracle cache: $projectDir"
    Remove-Item -LiteralPath $projectDir -Recurse -Force
  }

  if ((Test-Path -LiteralPath $assemblyPath) -and (Test-Path -LiteralPath $markerPath)) {
    $cachedMarker = (Get-Content -LiteralPath $markerPath -Raw -Encoding UTF8).Trim()
    if ($cachedMarker -eq $markerContent) {
      Write-OracleInfo "Using cached oracle assembly."
      return $assemblyPath
    }
    Write-OracleInfo "Oracle cache marker does not match ('$cachedMarker'); restoring again."
  }
  elseif (Test-Path -LiteralPath $publishDir) {
    Write-OracleInfo "Oracle cache is incomplete (missing assembly or completion marker); restoring again."
  }

  if ($NoRestore) {
    throw "Oracle assembly not found: $assemblyPath. Run tools/generate_reference_cases.ps1 first to restore the NuGet oracle cache."
  }

  Write-OracleInfo "Restoring oracle package $Id $Version ($Framework)..."
  [void](New-Item -ItemType Directory -Force -Path $projectDir)

  if (Test-Path -LiteralPath $markerPath) {
    Remove-Item -LiteralPath $markerPath -Force
  }

  $projectXml = @"
<Project Sdk="Microsoft.NET.Sdk">

  <!-- Generated by tools/oracle_helpers.ps1. Local NuGet oracle host; do not commit. -->
  <PropertyGroup>
    <TargetFramework>$Framework</TargetFramework>
    <OutputType>Library</OutputType>
    <AssemblyName>PhoneNumbersOracleHost</AssemblyName>
    <RootNamespace>PhoneNumbersOracleHost</RootNamespace>
    <Nullable>disable</Nullable>
    <ImplicitUsings>disable</ImplicitUsings>
    <GenerateDocumentationFile>false</GenerateDocumentationFile>
  </PropertyGroup>

  <ItemGroup>
    <PackageReference Include="$Id" Version="[$Version]" />
  </ItemGroup>

</Project>
"@

  Set-Content -LiteralPath $projectFile -Value $projectXml -Encoding UTF8

  & dotnet publish $projectFile -c Release -f $Framework -o $publishDir --nologo 2>&1 | Out-Host
  if ($LASTEXITCODE -ne 0) {
    throw "dotnet publish failed for oracle package '$Id' $Version ($Framework)."
  }
  if (-not (Test-Path -LiteralPath $assemblyPath)) {
    throw "Oracle package '$Id' $Version did not provide PhoneNumbers.dll in: $publishDir"
  }

  Set-Content -LiteralPath $markerPath -Value $markerContent -Encoding UTF8
  return $assemblyPath
}

function Import-OracleAssembly {
  <#
    Preloads the publish output's dependencies, loads PhoneNumbers.dll and runs
    the version gate: the loaded assembly's major.minor.build must match the
    requested package version. Returns the assembly path plus both version
    strings.

    Add-Type is process global, so a second load of a different build inside one
    pwsh session cannot work; the gate's message says so.
  #>
  param(
    [Parameter(Mandatory = $true)][string]$AssemblyPath,
    [Parameter(Mandatory = $true)][string]$ExpectedPackageVersion,
    [switch]$Quiet
  )

  if (-not (Test-Path -LiteralPath $AssemblyPath)) {
    throw "Oracle assembly not found: $AssemblyPath"
  }

  $publishDir = Split-Path -Parent $AssemblyPath

  foreach ($dependency in @(Get-ChildItem -LiteralPath $publishDir -Filter "*.dll" -File)) {
    if ($dependency.Name -in @("PhoneNumbers.dll", "PhoneNumbersOracleHost.dll")) {
      continue
    }
    try {
      Add-Type -Path $dependency.FullName
    }
    catch {
      if (-not $Quiet) {
        Write-Warning "Could not preload oracle dependency '$($dependency.Name)': $($_.Exception.Message)"
      }
    }
  }

  Add-Type -Path $AssemblyPath

  $loaded = [System.AppDomain]::CurrentDomain.GetAssemblies() |
    Where-Object { $_.GetName().Name -eq "PhoneNumbers" } |
    Select-Object -First 1
  if ($null -eq $loaded) {
    throw "PhoneNumbers assembly was not loaded from: $AssemblyPath"
  }

  $loadedVersion = $loaded.GetName().Version.ToString()
  $informationalVersion = $loadedVersion
  $informationalAttribute = $loaded.GetCustomAttributes([System.Reflection.AssemblyInformationalVersionAttribute], $false) |
    Select-Object -First 1
  if ($null -ne $informationalAttribute) {
    $informationalVersion = $informationalAttribute.InformationalVersion
  }

  $expectedCore = ($ExpectedPackageVersion -split '[-+]')[0]
  $expectedVersion = $null
  if ([System.Version]::TryParse($expectedCore, [ref]$expectedVersion)) {
    $actualVersion = $loaded.GetName().Version
    $expectedPatch = if ($expectedVersion.Build -lt 0) { 0 } else { $expectedVersion.Build }

    if ($actualVersion.Major -ne $expectedVersion.Major -or
        $actualVersion.Minor -ne $expectedVersion.Minor -or
        $actualVersion.Build -ne $expectedPatch) {
      throw ("Oracle version mismatch: expected {0}.{1}.{2} (from package version '{3}') but loaded {4} from '{5}'. " -f
        $expectedVersion.Major, $expectedVersion.Minor, $expectedPatch, $ExpectedPackageVersion, $loadedVersion, $AssemblyPath) +
        "Re-run with -RefreshOracle to rebuild the package cache, or start a fresh pwsh session if another PhoneNumbers assembly is already loaded."
    }
  }
  else {
    Write-Warning "Could not parse package version '$ExpectedPackageVersion' as a version; skipping the oracle version gate."
  }

  if (-not $Quiet) {
    Write-Host "Loaded oracle version: $loadedVersion (informational: $informationalVersion)"
  }

  return [pscustomobject]@{
    AssemblyPath         = $AssemblyPath
    PublishDir           = $publishDir
    Version              = $loadedVersion
    InformationalVersion = $informationalVersion
  }
}
