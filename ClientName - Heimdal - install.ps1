# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! change the key !!!!!!!!!!!!!!!!!!!!!!!!!!!!!

# Define variables
$installFolder = "C:\DOIT\Apps"
$installerName = "Heimdal.msi"
$installerURL = "https://digitalorchardit.sharepoint.com/:u:/s/public-files/EWN--nOvmcVAhXU9P-84MSUBxkTYG9uzwhRLvd8O9WwMEA?e=nrC0Uf"
$installParams = "/qn HEIMDALKEY=!!!!!!!!!!!CHANGE THE KEY!!!!!!!!!!!"


# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

# Check if the installation folder exists, if not, create it
if (-not (Test-Path -Path $installFolder)) {
    Write-Host "Installation folder does not exist. Creating folder..."
    New-Item -ItemType Directory -Path $installFolder | Out-Null
    if (-not (Test-Path -Path $installFolder)) {
        Write-Host "Failed to create installation folder. Exiting script."
        Exit 1
    }
    Write-Host "Installation folder created successfully."
}

# Check if Heimdal is already installed
if (Get-ItemProperty -Path HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Where-Object {$_.DisplayName -eq "Heimdal"}) {
    Write-Host "Heimdal is already installed."
} else {
    # Check if the installer exists in the install folder
    $installerPath = Join-Path -Path $installFolder -ChildPath $installerName
    if (-not (Test-Path -Path $installerPath)) {
        # If not found, download the installer
        Write-Host "Downloading Heimdal installer..."
        Invoke-WebRequest -Uri $installerURL -OutFile $installerPath

        # Check if the download was successful
        if (Test-Path -Path $installerPath) {
            Write-Host "Installer downloaded successfully."
        } else {
            Write-Host "Failed to download the installer."
            Exit 1
        }
    }

    # Install Heimdal quietly
    Write-Host "Installing Heimdal..."
    $installProcess = Start-Process -FilePath "msiexec.exe" -ArgumentList "/i `"$installerPath`" $installParams" -PassThru -Wait

    # Check if the installation was successful
    if ($installProcess.ExitCode -eq 0) {
        Write-Host "Heimdal installation completed successfully."
        
        # Remove the installer file
        Write-Host "Removing installer file..."
        Remove-Item -Path $installerPath -Force
        if (-not (Test-Path -Path $installerPath)) {
            Write-Host "Installer file removed successfully."
        } else {
            Write-Host "Failed to remove installer file."
        }
    }
}
