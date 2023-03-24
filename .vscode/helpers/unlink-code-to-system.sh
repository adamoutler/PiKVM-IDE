if [[ "$(python --version)" != "Python 3.10"* ]] ; then 
    echo "Python version changed!  Please adjust unlink-code-to-system.sh"; 
    exit 1
fi
rw
kvmd_location=/usr/lib/python3.10/site-packages/kvmd
test ! -L "${kvmd_location}" && echo already unlinked && exit 0
unlink ${kvmd_location}
pacman -Syu --noconfirm kvmd
echo "source unlinked, replaced by official kvmd"