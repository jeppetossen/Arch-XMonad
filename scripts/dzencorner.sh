red="#FF6E84"
magenta="#F299FC"
green="#B5FF57"
blue="#57DAFF"
blue2="#85D7FF"
orange="#FFB557"
pink="#FFB1ED"
yellow="#FFF585" 

hour="date +%R"
day="date +%A | tr '[:lower:]' '[:upper:]'"
date="date +%d"
month="date +%B | tr '[:lower:]' '[:upper:]'"
year="date +%Y"

while :; do
echo "
^fg($red)$(date +%R) \
^fg($green)$(date +%A | tr '[:lower:]' '[:upper:]')^fg() \
^fg($red)$(date +%d) \
^fg($green)$(date +%B | tr '[:lower:]' '[:upper:]') \
^fg($red)$(date +%Y) " #\
sleep 1
done | dzen2 -p -w 660 -x 700 -y 1004 -ta r -h 22 -bg "#101010" -fn "M+ 1m-8" -e 'button3=' -title-name dzencorner && sleep .01s && transset-df -n dzencorner 0.9