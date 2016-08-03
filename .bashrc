# System-wide .bashrc file for interactive bash(1) shells.

# To enable the settings / commands in this file for login shells as well,
# this file has to be sourced in /etc/profile.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, overwrite the one in /etc/profile)
PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '

# Commented out, don't overwrite xterm -T "title" -n "icontitle" by default.
# If this is an xterm set the title to user@host:dir
#case "$TERM" in
#xterm*|rxvt*)
#    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
#    ;;
#*)
#    ;;
#esac

# enable bash completion in interactive shells
#if ! shopt -oq posix; then
#  if [ -f /usr/share/bash-completion/bash_completion ]; then
#    . /usr/share/bash-completion/bash_completion
#  elif [ -f /etc/bash_completion ]; then
#    . /etc/bash_completion
#  fi
#fi

# sudo hint
if [ ! -e "$HOME/.sudo_as_admin_successful" ] && [ ! -e "$HOME/.hushlogin" ] ; then
    case " $(groups) " in *\ admin\ *)
    if [ -x /usr/bin/sudo ]; then
	cat <<-EOF
	To run a command as administrator (user "root"), use "sudo <command>".
	See "man sudo_root" for details.
	
	EOF
    fi
    esac
fi

# if the command-not-found package is installed, use it
if [ -x /usr/lib/command-not-found -o -x /usr/share/command-not-found/command-not-found ]; then
	function command_not_found_handle {
	        # check because c-n-f could've been removed in the meantime
                if [ -x /usr/lib/command-not-found ]; then
		   /usr/lib/command-not-found -- "$1"
                   return $?
                elif [ -x /usr/share/command-not-found/command-not-found ]; then
		   /usr/share/command-not-found/command-not-found -- "$1"
                   return $?
		else
		   printf "%s: command not found\n" "$1" >&2
		   return 127
		fi
	}
fi


# 自定义环境变量

if [ "${PS1+set}" = set ]
then PS1="[\u@\h: \w] \$ "
fi


source ~/.git-completion.bash



# some more aliases
alias ll='ls -AhlF'
alias d='sudo shutdown -h now'
alias rbt='sudo reboot'
alias s='sudo pm-suspend'
alias h='sudo pm-hibernate'
alias free='free -h'
alias rm='rm -vi'
alias scb='source ~/.bashrc'
alias df='df -h'
alias u2d='unix2dos'
alias d2u='dos2unix'

alias ud='apt-get update'
alias ug='apt-get update;apt-get dist-upgrade'
alias install='apt-get update;apt-get install'

alias tgz='tar -zxvf'
alias tbz='tar -jxvf'


alias e='emacs &'
alias ed='emacs --debug-init &'
alias xx='xmodmap ~/.xmodmap'
alias xe='xmodmap ~/.xmodmap; emacs &'
alias ..='cd ../'
alias ...='cd ../../'
alias ad='cd ~/code/Adaptive/'

alias s='sudo pm-suspend'
alias h='sudo pm-hibernate'

#git
alias gb='git branch'
alias gco='git checkout'
alias gcm='git commit'
alias ga='git add'


GTAGSLIBPATH=$HOME/code/.gtags/
