#!/usr/bin/env bash

sudo apt update
sudo apt install -y python3-pip
sudo pip3 install flask
sudo mkdir /opt/myapp
sudo bash -c "cat > /opt/myapp/myapp.py <<EOF
#!/usr/bin/env python3

from flask import Flask


myapp = Flask(__name__)

@myapp.route('/')
def default():

	return 'Hello World!'

if(__name__ == '__main__'):
	myapp.run(host='0.0.0.0', port=80)

EOF"
sudo chmod +x /opt/myapp/myapp.py

sudo bash -c "cat > /lib/systemd/system/myapp.service <<EOF
[Unit]
Description=My awesome application

[Service]
Type=oneshot
ExecStart=/usr/bin/env python3 /opt/myapp/myapp.py

[Install]
WantedBy=multi-user.target
EOF"

sudo systemctl daemon-reload
sudo systemctl enable myapp
sudo systemctl start myapp
