
# Define the installation folder and file paths
$installFolder = "C:\DOIT\Apps"
$installerPath = Join-Path -Path $installFolder -ChildPath "SentinelOne.msi"

# Define the download URL
$downloadUrl = "https://digitalorchardit.sharepoint.com/:u:/s/public-files/EbHH48ET_nxNgBYR-JTxVmwBimgyalhm_rFv1a3mdqMigA?e=6foMd3"

# !!!!!!!!!!!!!!!! Chnage the token !!!!!!!!!!!!!! 
# Define the management token
$siteToken = "!!!!!!!!!!!!!!!!!!Change the token!!!!!!!!!!!!!!!!!!!"

# Check if the SentinelOne installer exists in the installation folder
if (Test-Path $installerPath) {
    Write-Host "SentinelOne installer already exists. Proceeding with installation..."
} else {
    # Download the SentinelOne installer
    Write-Host "Downloading SentinelOne installer..."
    Invoke-WebRequest -Uri $downloadUrl -OutFile $installerPath -ErrorAction Stop
}

# Install SentinelOne using the MSI installer
Write-Host "Installing SentinelOne..."
Start-Process -FilePath "msiexec.exe" -ArgumentList "/i `"$installerPath`" SITE_TOKEN=$siteToken /qn /norestart" -NoNewWindow
# Check the installation status
if ($LASTEXITCODE -eq 0) {
    Write-Host "SentinelOne installed successfully."
} else {
    Write-Host "Failed to install SentinelOne."
}
