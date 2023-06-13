
if [[ "$(python --version)" != "Python 3.11"* ]] ; then 
    echo "Python version changed!  Please adjust unlink-code-to-system.sh"; 
    exit 1
fi
rw
kvmd_location=/usr/lib/python3.11/site-packages/kvmd
test ! -L "${kvmd_location}" && echo already unlinked && exit 0
unlink ${kvmd_location}
for file in `ls -1 /usr/share/kvmd`; do 
    sudo unlink /usr/share/kvmd/$file 
done
for name in 'ipmi' 'janus' 'janus-static' 'vnc'; do
    sudo unlink /usr/share/kvmd/extras/$name 2>/dev/null;
done
sudo unlink /etc/kvmd/override.d/999-debug-ipmi
sudo pacman -Syu --noconfirm kvmd kvmd-webterm
sudo systemctl restart kvmd.service
echo "source unlinked, replaced by official kvmd"
