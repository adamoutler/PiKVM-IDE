screen -S kvmd-vnc -X quit 2>&1 > /dev/null
python -c "import debugpy" 2>&1 || pacman -Syu --noconfirm python-debugpy
systemctl stop kvmd-vnc.service
screen -dmS kvmd-vnc sudo -u kvmd-vnc python -m debugpy --wait-for-client --listen 5678 /usr/bin/kvmd-vnc --run 
sleep 5
