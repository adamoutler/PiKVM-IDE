
#python3 -m pip install types-aiofiles types-PyYAML pytest
echo "mypy can take up to 3 minutes to run depending on the environment."
echo "current reported system time"
mkdir -p /tmp/pypycache
cd /home/code/kvmd
function cursorBack() {
  echo -en "\033[$1D"
}
function shutdown() {
  tput cnorm # reset cursor
}
trap shutdown EXIT
charwidth=1
spin='⣾⣽⣻⢿⡿⣟⣯⣷'
TZ=0 date  +"%Y-%m-%dT%H:%M:%S%z"
time mypy --config-file=testenv/linters/mypy.ini --cache-dir=/tmp/mypycache kvmd testenv/tests *.py &
pid=$!
echo -ne "   Running mypy"
tput civis # cursor invisible
while kill -0 $pid 2>/dev/null; do
i=$(((i + $charwidth) % ${#spin}))
    printf "%s" "${spin:$i:$charwidth}"
    cursorBack 1
    sleep .1
done
tput cnorm
wait $pid # capture exit code
