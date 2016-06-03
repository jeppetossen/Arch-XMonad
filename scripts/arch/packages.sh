#!/bin/sh

# init
function pause(){
   read -p "$*"
}

#pause 'Press [Enter] key to continue...'

ipkg="$HOME/scripts/arch/data/ipkg"
while read -r line
do
    name="$line"
    sudo pacman -S --needed --noconfirm $name
done < "$ipkg"

if [ -f "$HOME/scripts/arch/data/ipkg" ]; then
    aur="$HOME/scripts/arch/data/aur"
    while read -r line
    do
        name="$line"
        apacman -S --needed --noconfirm --noedit $name
    done < "$aur"
fi
