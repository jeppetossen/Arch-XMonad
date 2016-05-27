red="#FF6E84"
magenta="#F299FC"
green="#B5FF57"
blue="#57DAFF"
blue2="#85D7FF"
orange="#FFB557"
pink="#FFB1ED"
yellow="#FFF585"

conky -c ~/scripts/spotify/conkyfy

done | dzen2 -p -w 42 -x 0 -y 1004 -ta r -h 22 -bg "#101010" -fn "M+ 1m-8" -e 'button3=' -title-name dzencorner && sleep .01s && transset-df -n dzencorner 0.9
