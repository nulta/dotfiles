#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

function status {
    date +'%Y-%m-%d, %H:%M:%S (%Z)'
    echo "[Battery] $(cat /sys/class/power_supply/BAT1/status), $(cat /sys/class/power_supply/BAT1/capacity)%"
    echo "[Brightness] $(cat /sys/class/backlight/intel_backlight/brightness) / 255"
    echo "[Network]"
    nmcli d wifi list
}

PS1='\[\033[94m\]\u@\h\[\033[97m\]:\[\033[93m\]\w \[\033[96m\]\$\[\033[97m\] '
PS0='\[\033[0m\]'
