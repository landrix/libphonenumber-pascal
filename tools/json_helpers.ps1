function Copy-JsonObject {
  param(
    [Parameter(Mandatory = $true)]$InputObject,
    [int]$Depth = 100
  )

  return ($InputObject | ConvertTo-Json -Depth $Depth | ConvertFrom-Json)
}

function Remove-JsonPropertyPath {
  param(
    [Parameter(Mandatory = $true)]$InputObject,
    [Parameter(Mandatory = $true)][string]$PropertyPath
  )

  if ([string]::IsNullOrWhiteSpace($PropertyPath)) {
    return
  }

  $segments = $PropertyPath.Split('.')
  $current = $InputObject

  for ($i = 0; $i -lt $segments.Length - 1; $i++) {
    if ($null -eq $current) {
      return
    }

    $name = $segments[$i]
    $prop = $current.PSObject.Properties[$name]
    if ($null -eq $prop) {
      return
    }

    $current = $prop.Value
  }

  if ($null -eq $current) {
    return
  }

  $leaf = $segments[$segments.Length - 1]
  $leafProp = $current.PSObject.Properties[$leaf]
  if ($null -ne $leafProp) {
    [void]$current.PSObject.Properties.Remove($leaf)
  }
}

function Test-JsonEquivalent {
  param(
    [Parameter(Mandatory = $true)]$ExistingObject,
    [Parameter(Mandatory = $true)]$NewObject,
    [string[]]$IgnorePaths = @(),
    [int]$Depth = 100
  )

  $existingComparable = Copy-JsonObject -InputObject $ExistingObject -Depth $Depth
  $newComparable = Copy-JsonObject -InputObject $NewObject -Depth $Depth

  foreach ($path in $IgnorePaths) {
    Remove-JsonPropertyPath -InputObject $existingComparable -PropertyPath $path
    Remove-JsonPropertyPath -InputObject $newComparable -PropertyPath $path
  }

  $existingJson = $existingComparable | ConvertTo-Json -Depth $Depth -Compress
  $newJson = $newComparable | ConvertTo-Json -Depth $Depth -Compress

  return ($existingJson -eq $newJson)
}

function Write-JsonFile {
  param(
    [Parameter(Mandatory = $true)]$InputObject,
    [Parameter(Mandatory = $true)][string]$Path,
    [int]$Depth = 100,
    [string[]]$IgnorePathsForChangeDetection = @(),
    [switch]$ForceWrite
  )

  $shouldWrite = $true

  if ((-not $ForceWrite) -and (Test-Path $Path)) {
    try {
      $existing = Get-Content -Path $Path -Raw -Encoding UTF8 | ConvertFrom-Json
      if ($null -ne $existing) {
        if (Test-JsonEquivalent -ExistingObject $existing -NewObject $InputObject -IgnorePaths $IgnorePathsForChangeDetection -Depth $Depth) {
          $shouldWrite = $false
        }
      }
    }
    catch {
      # If existing JSON is invalid, overwrite with the new content.
      $shouldWrite = $true
    }
  }

  if (-not $shouldWrite) {
    return $false
  }

  $jsonText = ($InputObject | ConvertTo-Json -Depth $Depth) + "`n"
  $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
  [System.IO.File]::WriteAllText($Path, $jsonText, $utf8NoBom)

  return $true
}