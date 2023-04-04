sudo systemctl stop kvmd.service
if [[ "$(python --version)" != "Python 3.10"* ]] ; then 
    echo "Python version changed!  Please adjust unlink-code-to-system.sh"; 
    exit 1
fi
rw
loaded=false
kvmd_location=/usr/lib/python3.10/site-packages/kvmd
usrsharekvmd_location=/usr/share/kvmd/
test -L "${kvmd_location}" && loaded=true
if ! ${loaded}; then
    source_location="$PWD"/../kvmd
    sudo rm -Rf ${kvmd_location}
    ln -s ${source_location}/kvmd "${kvmd_location}"
    echo "KVMD replaced with source code"
    rm -Rf ${usrsharekvmd_location}/web
    ln -s ${source_location}/web "${usrsharekvmd_location}/web"
    echo "Web replaced with source code"
    rm -Rf ${usrsharekvmd_location}/extras
    ln -s ${source_location}/extras "${usrsharekvmd_location}/extras" 
    echo "Extras replaced with source code"
    rm -Rf ${usrsharekvmd_location}/hid
    ln -s ${source_location}/hid "${usrsharekvmd_location}/hid" 
    echo "HID replaced with source code"
    
fi
sudo chmod -R ag+w /usr/share/kvmd
sudo chmod -R ag+w /etc/kvmd
