#!/bin/bash

PASSWORD_FILE=${password_file}
curl -o /opt/dpg-passwords.txt $PASSWORD_FILE

# Create the script to execute login requests from a password file
cat << 'EOF' > /opt/dpg
${dpg_script_rendered}
EOF
chmod +x /opt/dpg

# Create a systemd service to get it to run in the background
cat << 'SVC' > /etc/systemd/system/dpg.service
${service_rendered}
SVC

systemctl daemon-reload
systemctl start dpg
