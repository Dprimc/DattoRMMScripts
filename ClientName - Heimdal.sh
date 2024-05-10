#!/bin/bash

# Define variables
filename="HeimdalPackage.pkg"
key="Chnage the Key"
silent="silent-install.sh"

# Constants
installer_path="/Library/Addigy/ansible/packages/DOIT - Heimdal (1.0)/$filename"       #change DOIT - Heimdal (1.0) 
silent_path="/Library/Addigy/ansible/packages/DOIT - Heimdal (1.0)/$silent"            #change DOIT - Heimdal (1.0)

sudo sh "$silent_path" "$installer_path" "$key"
