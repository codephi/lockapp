#!/bin/bash

# URL of the ZIP file to be downloaded
zip_url="https://github.com/codephi/blckpp/archive/refs/tags/<VERSION>.zip"

# Path to the extraction destination folder
extract_dir="blckpp-extracted"

# Download the ZIP file
echo "Downloading $zip_url..."
wget -O blckpp.zip $zip_url

# Extract the ZIP file
echo "Extracting the ZIP file..."
unzip blckpp.zip -d $extract_dir

# Path to the extracted folder
extracted_path="$PWD/$extract_dir/blckpp-<VERSION>"

# Path to the application
app_path="$extracted_path/bin/blckpp"

# Service name
service_name="blckpp"

# Content of the service file
service_content="[Unit]
Description=BLCKPP
After=network.target

[Service]
Type=simple
ExecStart=$app_path
Restart=always

[Install]
WantedBy=default.target"

# Path to the systemd services directory
systemd_dir="/etc/systemd/system"

# Full name of the service file
service_file="$systemd_dir/$service_name.service"

# Write the service content to the file
echo "$service_content" | sudo tee $service_file

# Reload systemd to recognize the new service
sudo systemctl daemon-reload

# Enable the service to start on boot
sudo systemctl enable $service_name

# Start the service
sudo systemctl start $service_name

# Copy to /usr/bin
sudo cp $app_path /usr/bin/blckpp

echo "Installation completed."
