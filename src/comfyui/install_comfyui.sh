#!/usr/bin/env bash
set -ex
SCRIPT_PATH="$( cd "$(dirname "$0")" ; pwd -P )"

apt-get update
apt-get install -y python3-venv

mkdir -p /opt/
cd /opt
git clone https://github.com/comfyanonymous/ComfyUI.git
cd ComfyUI
python3 -m venv venv
source venv/bin/activate
pip uninstall torch
pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu130

pip3 install -r requirements.txt
chown -R 1000:1000 /opt/ComfyUI

cat >/usr/share/applications/comfyui.desktop <<EOL
[Desktop Entry]
Version=1.0
Name=ComfyUI
Comment=2D to 3D video converter
TryExec=/opt/ComfyUI/launcher.sh
Exec=/opt/ComfyUI/launcher.sh -- %u
Icon=/opt/ComfyUI/comfyui.png
Terminal=false
StartupWMClass=ComfyUI
Type=Application
Categories=Multimedia;
EOL

chmod +x /usr/share/applications/comfyui.desktop
chown 1000:1000 /usr/share/applications/comfyui.desktop
cp /usr/share/applications/comfyui.desktop $HOME/Desktop/comfyui.desktop
chown 1000:1000 $HOME/Desktop/comfyui.desktop
