#!/bin/bash

#    version         Addigy
#    author          Denis Primc
#    Got script from "https://community.automox.com/community-worklets-12/worklet-install-sentinelone-agent-macos-1805" and modified for Addigy 

filename="SentinelOneMac.pkg"
site_token="change the right token" # change the token

# CONSTANTS
installer="/Library/Addigy/ansible/packages/DOIT - SentinelOne (1.0)/$filename"
target="/Library/"
token_file="/tmp/com.sentinelone.registration-token"

function is_sentinelone_installed() {
  if /usr/local/bin/sentinelctl status > /dev/null; then
    true
  else
    false
  fi
}

# Check if SentinelOne is already installed
if is_sentinelone_installed; then
  echo "Software is already installed"
  exit 0
fi

# Write site token to temp file
echo "$site_token" > "$token_file"

# Install SentinelOne agent
cp "$installer" "/tmp"
tmp_installer="/tmp/$filename"

echo "Installing $installer to $target"
/usr/sbin/installer -pkg "$tmp_installer" -target "$target"

# Cleanup temp file
rm "$tmp_installer" "$token_file"
