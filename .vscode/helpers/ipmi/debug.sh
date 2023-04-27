sudo systemctl start kvmd.service
sudo systemctl stop kvmd-ipmi.service
bash .vscode/helpers/link-code-to-system.sh
config_file="/etc/kvmd/override.d/999-debug-ipmi"
if [ ! -L /etc/kvmd/override.d/999-debug-ipmi ]; then
    rm ${config_file} 2> /dev/null
    ln -s ${PWD}/.vscode/helpers/ipmi/999-debug-ipmi ${config_file}
fi
chmod 777 ${config_file}
screen -S kvmd-ipmi -X quit 2>&1 > /dev/null
#python -c "import debugpy" 2>&1 || pacman -Syu --noconfirm python-debugpy
#systemctl stop kvmd-ipmi.service
screen -dmS kvmd-ipmi sudo -u kvmd-ipmi -g kvmd-ipmi python -m debugpy --wait-for-client --listen 5676 /usr/bin/kvmd-ipmi --run
sleep 2
