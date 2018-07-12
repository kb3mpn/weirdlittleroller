#!/bin/bash
#
# This is my weird little dice roller. --Emmett
#
#
SND=sounds
HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=8
BACKTITLE="weird little roller v.01"
TITLE="Dice"
MENU="Choose one of the following dice:"

OPTIONS=(1 "d20"
         2 "d12"
         3 "d10"
	 4 "d8"
	 5 "d6"
         6 "d4")

CHOICE=$(dialog \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                3>&1 1>&2 2>&3 3>&- \
		)

case $CHOICE in
        1)
            ROLL=$(shuf -i1-20 -n1)
            ;;
        2)
            ROLL=$(shuf -i1-12 -n1)
            ;;
        3)
            ROLL=$(shuf -i1-10 -n1)
            ;;
        4)
            ROLL=$(shuf -i1-8 -n1)
            ;;
        5)
            ROLL=$(shuf -i1-6 -n1)
            ;;
        6)
            ROLL=$(shuf -i1-4 -n1)
            ;;
esac
display_center(){
    columns="$(tput cols)"
    while IFS= read -r line; do
        printf "%*s\n" $(( (${#line} + columns) / 2)) "$line"
    done < "$1"
}
echo $ROLL > roll.txt
clear
display_center roll.txt
rm roll.txt
aplay -q $SND/roll.wav $SND/$ROLL.wav
