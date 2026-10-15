
# Install Windows App Runtime 1.4.7 (x64)
$ErrorActionPreference = 'Stop'

$InstallerUrl = 'https://aka.ms/windowsappsdk/1.4/1.4.240802001/windowsappruntimeinstall-x64.exe'
$InstallerPath = Join-Path $env:TEMP 'WindowsAppRuntimeInstall-x64.exe'

try {
    Write-Output 'Downloading Windows App Runtime 1.4.7...'

    Invoke-WebRequest `
        -Uri $InstallerUrl `
        -OutFile $InstallerPath `
        -UseBasicParsing

    if (-not (Test-Path $InstallerPath)) {
        throw 'Installer download failed.'
    }

    Write-Output 'Installing Windows App Runtime 1.4.7...'

    $Process = Start-Process `
        -FilePath $InstallerPath `
        -ArgumentList '--quiet' `
        -Wait `
        -PassThru

    if ($Process.ExitCode -ne 0) {
        throw "Windows App Runtime installer failed with exit code $($Process.ExitCode)."
    }

    Write-Output 'Windows App Runtime installation completed successfully.'
}
finally {
    if (Test-Path $InstallerPath) {
        Remove-Item $InstallerPath -Force
    }
}

