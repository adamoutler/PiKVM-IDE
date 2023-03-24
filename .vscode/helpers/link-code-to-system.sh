if [[ "$(python --version)" != "Python 3.10"* ]] ; then 
    echo "Python version changed!  Please adjust unlink-code-to-system.sh"; 
    exit 1
fi
rw
kvmd_location=/usr/lib/python3.10/site-packages/kvmd
test -L "${kvmd_location}" && echo already linked && exit 0
source_location="$PWD"/../kvmd/kvmd/
rm -Rf ${kvmd_location}
ln -s ${source_location} "${kvmd_location}"
echo "KVMD replaced with source code"
