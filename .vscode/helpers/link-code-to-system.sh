sudo systemctl stop kvmd.service
if [[ "$(python --version)" != "Python 3.12"* ]] ; then 
    echo "Python version changed!  Please adjust link-code-to-system.sh"; 
    exit 1
fi
rw
loaded=false
kvmd_location=/usr/lib/python3.12/site-packages/kvmd
usrsharekvmd_location=/usr/share/kvmd/
test -L "${kvmd_location}" && loaded=true
if ! ${loaded}; then
    pip install debugpy aiohttp_basicauth asyncio pytest_asyncio pytest-mock types-PyYAML
    source_location="$PWD"/../kvmd
    rm -Rf ${usrsharekvmd_location}/web
    ln -s ${source_location}/web "${usrsharekvmd_location}/web"
    echo "Web replaced with source code"
    for name in 'ipmi' 'janus' 'janus-static' 'vnc'; do
        rm -Rf "${usrsharekvmd_location}/extras/${name}"
        ln -s "${source_location}/extras/${name}" "${usrsharekvmd_location}/extras/${name}" 
        echo "Extras ${name} replaced with source code";
    done;
    rm -Rf ${usrsharekvmd_location}/hid
    ln -s ${source_location}/hid "${usrsharekvmd_location}/hid" 
    echo "HID replaced with source code"
    sudo rm -Rf ${kvmd_location}
    ln -s ${source_location}/kvmd "${kvmd_location}"
    echo "KVMD replaced with source code"
    
fi
sudo chmod -R ag+w /usr/share/kvmd
sudo chmod -R ag+w /etc/kvmd
