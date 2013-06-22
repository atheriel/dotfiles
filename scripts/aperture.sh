#!/bin/bash

# ===============================================
# Portal-Archey-OSX Script
# ===============================================
# 
# In action: http://i.imgur.com/r5nnhAM.png
# 
# Based on the ports of archey to osx at
#       https://github.com/metamorfos/archey-osx
#       https://github.com/joshfinnie/archey-osx
#       https://github.com/Gary00/archey-osx
# 
# Draws a portal-themed ascii image as opposed to
# the generic apple icon.
# 
# Written by <atheriel@gmail.com>
# 
# Licensed under the terms of the GNU GPL v2
#
# Usage:
#       aperture.sh [--cake | --cube]
# 
# ===============================================

if [ "$2" ]; then
        echo "usage: archey.sh [--cake | --cube]"
        exit 1
fi

esc=""

# Load required colors
initializeANSI()
{
  redf="${esc}[31m"
  yellowf="${esc}[33m"
  bluef="${esc}[34m"
  reset="${esc}[0m"
}

initializeANSI

user=$(whoami)
hostname=$(hostname | sed 's/.local//g')
kernel=$(uname -rms | sed 's/\(x.*\)/\(\1\)/')
distro="Mac OS X $(sw_vers -productVersion)"
uptime=$(uptime | sed 's/.*up \([^,]*\), .*/\1/')

raw_term_info=$(osascript -e 'tell application "Terminal"' -e 'set a to get current settings of front window' -e 'set b to {get name of a, get font name of a, get font size of a}' -e 'end tell')
theme=$(echo "${raw_term_info}" | sed 's/\(.*\), \(.*\), \(.*\)/\1/')
font=$(echo "${raw_term_info}" | sed 's/\(.*\), \(.*\), \(.*\)/\2 \3pt/' | sed 's/\-/\ /')

shell=`echo -n $SHELL | sed 's/\/bin\///'`
terminal="$TERM"
packages="`brew list -l 2>/dev/null | wc -l | awk '{print ($1) }'`"

cpu=$(sysctl -n machdep.cpu.brand_string | sed 's/(R)//' | sed 's/(TM)//' | sed 's/Core2/Core 2/' | sed 's/CPU\(.\)*T9600//' | sed 's/[\ ][\ ][\ ]*/\ /')

mem=$(sysctl -n hw.memsize)
memfree=$(vm_stat | head -2 | tail -1 | sed 's/Pages free:[\ ]*\(.*\)./\1/')
ram="$((memfree * 4096 / 1000000)) of $((mem/1000000)) MB free"

disksize=`df -g | head -2 | tail -1 | awk '{print $2}'`
diskfree=`df -g | head -2 | tail -1 | awk '{print $3}'`
disk="${diskfree} of ${disksize} GB free"

case $1 in

    --cake)
        echo "
    ${yellowf}            ,:/+/-                        ${reset}
    ${yellowf}            /M/              .,-=;//;-    ${reset}    ${redf}The cake is a lie.${reset}
    ${yellowf}       .:/= ;MH/,    ,=/+%\$XH@MM#@:      ${reset}
    ${yellowf}      -\$##@+\$###@H@MMM#######H:.    -/H#${reset}      ${bluef}User: ${reset}${user}
    ${yellowf} .,H@H@ X######@ -H#####@+-     -+H###@X  ${reset}    ${bluef}Hostname: ${reset}${hostname}
    ${yellowf}  .,@##H;      +XM##M/,     =%@###@X;-    ${reset}    ${bluef}Kernel: ${reset}${kernel}
    ${yellowf}X%-  :M##########$.    .:%M###@%:         ${reset}    ${bluef}System: ${reset}${distro}
    ${yellowf}M##H,   +H@@@$/-.  ,;\$M###@%,          - ${reset}     ${bluef}Uptime: ${reset}${uptime}
    ${yellowf}M####M=,,---,.-%%H####M$:          ,+@##  ${reset}
    ${yellowf}@##################@/.         :%H##@\$-  ${reset}     ${bluef}Theme: ${reset}${theme}
    ${yellowf}M###############H,         ;HM##M$=       ${reset}    ${bluef}Font: ${reset}${font}
    ${yellowf}#################.    .=\$M##M$=          ${reset}
    ${yellowf}################H..;XM##M$=          .:+  ${reset}    ${bluef}Shell: ${reset}${shell}
    ${yellowf}M###################@%=           =+@MH%  ${reset}    ${bluef}Terminal: ${reset}${terminal}
    ${yellowf}@################M/.          =+H#X%=     ${reset}    ${bluef}Brew Packages: ${reset}${packages}
    ${yellowf}=+M##############M,       -/X#X+;.        ${reset}
    ${yellowf}  .;XM##########H=    ,/X#H+:,            ${reset}    ${bluef}CPU: ${reset}${cpu}${bluef}
    ${yellowf}     .=+HM######M+/+HM@+=.                ${reset}    ${bluef}Memory: ${reset}${ram}
    ${yellowf}         ,:/%XM####H/.                    ${reset}    ${bluef}Disk: ${reset}${disk}
    ${yellowf}              ,.:=-.                      ${reset}
"
        ;;

    --cube)
        echo "
    ${yellowf}+@##########M/             :@#########@/  ${reset}
    ${yellowf}##############\$;H#######@;+############# ${reset}     ${redf}Will you be my friend?${reset}
    ${yellowf}###############M########################  ${reset}
    ${yellowf}##############X,-/++/+%+/,%#############  ${reset}    ${bluef}User: ${reset}${user}
    ${yellowf}############M\$:           -X############ ${reset}     ${bluef}Hostname: ${reset}${hostname}
    ${yellowf}##########H;.      ,--.     =X##########  ${reset}    ${bluef}Kernel: ${reset}${kernel}
    ${yellowf}:X######M;     -\$H@M##MH%:    :H#######@ ${reset}     ${bluef}System: ${reset}${distro}
    ${yellowf}  =%#M+=,   ,+@#######M###H:    -=/M#%    ${reset}    ${bluef}Uptime: ${reset}${uptime}
    ${yellowf}  %M##@+   .X##$, ./+- ./###;    +M##%    ${reset}
    ${yellowf}  %####M.  /###=         @##M.   X###%    ${reset}    ${bluef}Theme: ${reset}${theme}
    ${yellowf}  %####M.  ;M##H:.     =\$###X.   \$###%  ${reset}
    ${yellowf}  %####@.   /####M\$-./@#####:    %###%   ${reset}     ${bluef}Shell: ${reset}${shell}
    ${yellowf}  %H#M/,     /H###########@:     ./M#%    ${reset}    ${bluef}Terminal: ${reset}${terminal}
    ${yellowf} ;\$H##@@H:    .;\$HM#MMMH$;,   ./H@M##M$=${reset}      ${bluef}Brew Packages: ${reset}${packages}
    ${yellowf}X#########%.      ..,,.     .;@#########  ${reset}
    ${yellowf}###########H+:.           ./@###########  ${reset}    ${bluef}CPU: ${reset}${cpu}${bluef}
    ${yellowf}##############/ ./%%%%+/.-M#############  ${reset}    ${bluef}Memory: ${reset}${ram}
    ${yellowf}##############H\$@#######@@############## ${reset}     ${bluef}Disk: ${reset}${disk}
    ${yellowf}##############X%########M\$M############# ${reset}
    ${yellowf}+M##########H:            .\$##########X= ${reset}
"
        ;;

    *)

        echo "
    ${yellowf}            .,-;;//;\=,.                ${reset}
    ${yellowf}         . 1H@@@MM@M#H/ ,+;,            ${reset}    ${redf}We do what we must, because we can.${reset}
    ${yellowf}      ,/X+ +M@@M@MM% ,-%HMMM@X/,        ${reset}
    ${yellowf}    -+@MM; SM@@MH+- ;XMMMM@MMMM@+-      ${reset}    ${bluef}User: ${reset}${user}
    ${yellowf}   ,@M@@M- XM@X;. -+XXXXXHHH@M@M.--.    ${reset}    ${bluef}Hostname: ${reset}${hostname}
    ${yellowf}  ,%MM@@MH ,@%=            ..--=-=;=,.  ${reset}    ${bluef}Kernel: ${reset}${kernel}
    ${yellowf}  +@#@@@MX .,              -%HXSS%%%+;  ${reset}    ${bluef}System: ${reset}${distro}
    ${yellowf} =; .@M@M$                  .;@MMMM@MM; ${reset}    ${bluef}Uptime: ${reset}${uptime}
    ${yellowf} X@= -#MM/                    .+MM@@@M#;${reset}
    ${yellowf},@M@H; ;@1                     . =X#@@@@${reset}    ${bluef}Theme: ${reset}${theme}
    ${yellowf},@@@MMX, .                    /H- ;@M@M=${reset}
    ${yellowf}.H@@@@M@+,                    %MM+. %#$.${reset}    ${bluef}Shell: ${reset}${shell}
    ${yellowf} /MMMM@MMH\.                  XM@MH; =; ${reset}    ${bluef}Terminal: ${reset}${terminal}
    ${yellowf}  /%+%SXHH@#=              , .H@@@@MX,  ${reset}    ${bluef}Brew Packages: ${reset}${packages}
    ${yellowf}   .,,.,,..,,,           -%H ,@@@@@MX,  ${reset}
    ${yellowf}    %MM@@@HHHXM++;;-- .;SMMX =M@@MM%.   ${reset}    ${bluef}CPU: ${reset}${cpu}${bluef}
    ${yellowf}     =XMCAMAMAGUEY ,-+HMM@M+ /MMMX=     ${reset}    ${bluef}Memory: ${reset}${ram}
    ${yellowf}       =%@M@M#@S .=#@MM@@@M; %M%=       ${reset}    ${bluef}Disk: ${reset}${disk}
    ${yellowf}         ,;+#+- /H#MMMMMMM@= =,         ${reset}
    ${yellowf}           --. =++%%%%+/;-.             ${reset}
"
        ;;
esac