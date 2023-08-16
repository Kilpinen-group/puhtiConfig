# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

if [ -f ~/.bash_export ]; then
    source ~/.bash_export
fi

export PS1='\[\e[0;38;5;159m\]\h \[\e[0;38;5;228m\]\W \[\e[0m\]'
