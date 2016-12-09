################
# Alias Section
################
alias l.='ls -d .* --color=tty'
alias ll='ls -lh --color=tty'
alias lo="ls -o"
alias la="ls -la"
alias ls='ls -ph --color=auto'
alias sl="ls"
alias vb="vim ~/.bashrc"
alias vv="vim ~/.vimrc"

alias reload="source ~/.bashrc"
alias waf="cd /mnt/ext/waf"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias folders='find . -maxdepth 1 -type d -print0 | xargs -0 du -hsk | sort -rn'
alias agrep='egrep -iIRn --color=auto'
alias vi='vim'
alias gs="git status"
alias gl="git log"
#alias gc="git commit"
alias ga="git add"
alias gd="git diff"
alias glp="git log --pretty=format:'%C(yellow)%h|%Cred%ad|%C(cyan)%an|%Cgreen%d %Creset%s' --date=local"
#| column -ts'|' | less -r"
#alias glg="git log --graph --full-history --all --color --pretty=format:'\''%C(yellow)%h|%Cred%ad|%Cblue%an|%Cgreen%d %Creset%s'\'' --date=local"
#alias glg='git log --graph --full-history --all --color --pretty=format:"%x1b[31m%hx09%x1b[32m%d%x1b[0m%x20%s"'
alias glp='git log HEAD~..origin/elcon-no-stats --oneline --decorate=full --pretty=format:'\''%C(yellow)%h %Cred%ad %Cblue%<(15)%an%Cgreen%d %Creset%s'\'' --date=short'
#alias ag="ag --nogroup --color"

###############
# Check NFS
################
#(/etc/init.d/nfs-kernel-server status | grep "nfsd running" > /dev/null) || (echo "NFS server not started. Login as root and execute \"/etc/init.d/nfs-kernel-server start\"")


################
# Variables
################
export HISTTIMEFORMAT="%F %T "
export https_proxy=$http_proxy
export stc_path=/opt/stc
export PATH=~/apps/firefox:~/apps:/usr/local/bin:/bin:/usr/bin:/usr/sbin::/sbin:/mnt/ext/buildroot/output/host/usr/bin/:/u/ahumphre/code/scripts/:/usr/games/
export LD_LIBRARY_PATH=/usr/local/lib

# ignore duplicate entries
export HISTCONTROL=ignoredups

# leave some commands out of history log
export HISTIGNORE="&:??:[ ]*:clear:exit:logout"

# Colour codes
RESET='\[$(tput sgr0)\]'
BOLD='\[$(tput bold)\]'
BLACK='\[$(tput setaf 0)\]'
RED='\[$(tput setaf 1)\]'
GREEN='\[$(tput setaf 2)\]'
YELLOW='\[$(tput setaf 3)\]'
BLUE='\[$(tput setaf 4)\]'
PURPLE='\[$(tput setaf 5)\]'
CYAN='\[$(tput setaf 6)\]'
WHITE='\[$(tput setaf 7)\]'
SELECT="if [ \$? = 0 ]; then echo \"${SMILEY}\"; else echo \"${FROWNY}\"; fi"
__git_branch='`git branch 2> /dev/null | grep -e ^* | sed -E s/^\\\\\*\ \(.+\)$/\(\\\\\1\)\ /`'

# Default prompt
#export PS1="${RED}\h:${GREEN}\W ${YELLOW}\$ ${RESET}"
export PS1="${RED}\h:${GREEN}\W ${CYAN}${__git_branch}${YELLOW}\$ ${RESET}"

# define color to additional file types
export LS_COLORS="*.c=0;36:*.h=0;34:*.py=0;35:*.exp=0;33"

###############
# Functions
###############

# Telnet to board
function tn {
        if [ -z "$1" ] ; then
                echo "No IP address given."
        else
                telnet 192.168.50.$1
        fi
}

# Extract various archives
extract () {
   if [ -f $1 ] ; then
       case $1 in
           *.tar.bz2)   tar xvjf $1    ;;
           *.tar.gz)    tar xvzf $1    ;;
           *.bz2)       bunzip2 $1     ;;
           *.rar)       unrar x $1       ;;
           *.gz)        gunzip $1      ;;
           *.tar)       tar xvf $1     ;;
           *.tbz2)      tar xvjf $1    ;;
           *.tgz)       tar xvzf $1    ;;
           *.zip)       unzip $1       ;;
           *.Z)         uncompress $1  ;;
           *.7z)        7z x $1        ;;
           *)           echo "don't know how to extract '$1'..." ;;
       esac
   else
       echo "'$1' is not a valid file!"
   fi
 }

# Creates an archive from given directory
mktar() { tar cvf  "${1%%/}.tar"     "${1%%/}/"; }
mktgz() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }
mktbz() { tar cvjf "${1%%/}.tar.bz2" "${1%%/}/"; }

# Build cscope database
function scope {
    echo -ne "Finding c/h/dpl/tcl files..."
    find . -name "*.c" -o -name "*.h" -o -name "*.dpl" -o -name "*.tcl" > cscope.files
    sed -i '/cfgdelta/d' cscope.files
    echo " done."
    echo -ne "Building database..."
    cscope -q -R -b -i cscope.files
    echo " done."
}

# Build py cscope database
function pyscope {
    echo -ne "Finding py files..."
    find . -name "*.py" > cscope.files
    sed -i '/cfgdelta/d' cscope.files
    echo " done."
    echo -ne "Building database..."
    cscope -q -R -b -i cscope.files
    echo " done."
}

function printLsStats {
    # fs stats
    echo "`df -hT .`"
    echo ""
    echo -n "[`pwd`:"
    # count files
    echo -n " <`find . -maxdepth 1 -mindepth 1 -type f | wc -l | tr -d '[:space:]'` files>"
    # count sub-dirs
    echo -n " <`find . -maxdepth 1 -mindepth 1 -type d | wc -l | tr -d '[:space:]'` dirs/>"
    # count links
    echo -n " <`find . -maxdepth 1 -mindepth 1 -type l | wc -l | tr -d '[:space:]'` links@>"
    # total disk space used by this directory and all subdirs
    echo " <~`du -sh . 2> /dev/null | cut -f1`>]"
    ROWS=`stty size | cut -d' ' -f1`
    FILES=`find . -maxdepth 1 -mindepth 1 | wc -l | tr -d '[:space:]'`
    # if the terminal has enough lines, do a long listing
    #if [`expr "${ROWS}" - 6` -lt "{FILES}" ]; then
    ls -ACF
    #else
    #ls -hlAF --full-time
    #fi
}

function cs () {
    clear
    # only change dir if dir is specified
    [ -n "${1}" ] && cd $1
    printLsStats
}

function cls {
    clear
    printLsStats
}

export OWN_TOOL_PATH=/mnt/ext/buildroot/output/host/usr/bin
export DEFAULT_WAF_BUILD_CMD="make TARGET_TOOLCHAIN_PATH=$OWN_TOOL_PATH TARGET_CROSS_COMPILE=mips-linux-"
function build {
    target=$1
    if [ $# -eq 2 ]
    then
        echo "arg"
        WAF_CONFIG="WAF_CONFIG=$2"
    else
        echo "No arg"
        WAF_CONFIG=""
    fi
    shift
    shift
    echo "$DEFAULT_WAF_BUILD_CMD TARGET=${target}linux ${WAF_CONFIG} $*"
    $DEFAULT_WAF_BUILD_CMD TARGET=${target}linux ${WAF_CONFIG} $*
}

. ~/.git-completion.bash

