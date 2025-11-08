# Ensure script runs with administrative privileges
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Please run this script as Administrator." -ForegroundColor Red
    exit
}

# Function to install a package via winget
function Install-PackageIfMissing {
    param (
        [string]$PackageId
    )

    $package = winget list --id $PackageId -e
    if ($package) {
        Write-Host "$PackageId is already installed."
    } else {
        Write-Host "Installing $PackageId..."
        winget install --id $PackageId --silent --accept-package-agreements --accept-source-agreements
    }
}

# Install Figma
Install-PackageIfMissing -PackageId "Figma.Figma"

# Install Git
Install-PackageIfMissing -PackageId "Git.Git"

# Install VSCodium
Install-PackageIfMissing -PackageId "VSCodium.VSCodium"

Write-Host "Installation complete!" -ForegroundColor Green
