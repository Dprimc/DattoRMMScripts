#!/bin/bash

# Make sure you add policy "ThreatLocker Configuration Profile" to the company
# download the installer from ThreatLocker portal upload it to Addigy 
# remove the installer from Addigy after the installations


# Set attributes
GroupKey="Chekc for the key on ThreatLocekr Portal" # get the Key "GroupKey="36E16E2F-9C9D-4BD1-A148-84E038181F72"
InstallerName="Download the installer from ThreatLocekr portal" # get the instaler "InstallerName="ThreatLocker Installer-a77740a788ac78a12217a4aa.pkg"
InstallerPath="/Library/Addigy/ansible/packages/change the folder/$InstallerName" # Change the folder "DOIT - ThreatLocker (1.0)"

# Check system extension state
check_system_extension_state() {
    extensionIdentifier="com.threatlocker.app.agent"
    extensionStates=$(systemextensionsctl list | grep "$extensionIdentifier")
    activatedEnabledFound=false

    while IFS= read -r line; do
        if [[ $line == *"activated enabled"* ]]; then
            echo "ThreatLocker installed."
            return 0
        elif [[ $line == *"activated waiting for user"* ]]; then
            echo "ThreatLocker installed; waiting on user input to permit system extension."
            return 1
        fi
    done <<< "$extensionStates"

    return 2
}

# Install the app
echo "Installing the app..."
sudo installer -pkg "$InstallerPath" -target /

echo "Installation complete."




# to uninstall the threat Locker first disable Tamper Protection Feature in the ThreatLocker Portal.
# On the Mac click on the ThreatLocker icon in the tray. Select 'Quit'.
# Run the following Terminal command: 
# open /Applications/ThreatLocker.app --args -uninstall 