alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias untar.gz='tar xvzf'
alias untar.bz2='tar xfvj'
alias untar='untar.gz'
alias filec='ls | wc -l'

alias sint='sinteractive --account project_2003986 --cores 8 --time 7-00:00:00  --mem 76000 --tmp 720'
alias sq='squeue -u dmeister'
alias qwatch='watch -n3 squeue -u dmeister'