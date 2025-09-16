$ErrorActionPreference = "Stop"

function Get-GuildWars2InstallPath {
    $ExpectedSubPath = "Games\Guild Wars 2"
    $ExpectedExe = "Gw2-64.exe"

    foreach ($drive in Get-PSDrive -PSProvider FileSystem) {
        $CandidatePath = Join-Path $drive.Root $ExpectedSubPath
        if (Test-Path (Join-Path $CandidatePath $ExpectedExe)) {
            return $CandidatePath
        }
    }

    $DefaultPath = "C:\Program Files\Guild Wars 2"
    if (Test-Path (Join-Path $DefaultPath $ExpectedExe)) {
        return $DefaultPath
    }

    throw "Guild Wars 2 installation not found."
}

$SourceUrl = "https://www.deltaconnected.com/arcdps/x64/d3d11.dll"
$ChecksumUrl = "https://www.deltaconnected.com/arcdps/x64/d3d11.dll.md5sum"

$DownloadsDirectory = "$env:USERPROFILE\Downloads"
$SourcePath = Join-Path $DownloadsDirectory "d3d11.dll"
$ChecksumPath = Join-Path $DownloadsDirectory "d3d11.dll.md5sum"

$TargetPath = Join-Path (Get-GuildWars2InstallPath) "d3d11.dll"

Invoke-WebRequest -Uri $SourceUrl -OutFile $SourcePath
Invoke-WebRequest -Uri $ChecksumUrl -OutFile $ChecksumPath

$ExpectedChecksum = (Get-Content $ChecksumPath).Split(" ")[0].Trim()
$ActualChecksum = (Get-FileHash -Algorithm MD5 $SourcePath).Hash.ToLower()

if ($ExpectedChecksum -ne $ActualChecksum) {
  throw "Checksum mismatch. Expected $ExpectedChecksum but got $ActualChecksum"
}

Copy-Item -Path $SourcePath -Destination $TargetPath -Force
Remove-Item $SourcePath, $ChecksumPath -Force

Write-Host "ArcDPS has been updated successfully."
