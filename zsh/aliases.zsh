### LS aliases
alias lt='ls -l -t -h'
alias lth='ls -l -t -h --color | head'

### APT-GET aliases
alias alu='apt list --upgradable'
alias acs='apt search'
alias acw='apt show'
alias agu='sudo apt update'
alias agg='sudo apt upgrade'
alias aggdist='sudo apt dist-upgrade'
alias agi='sudo apt install'
alias aga='sudo apt autoremove'
alias agc='sudo apt clean'
alias agr='sudo apt remove'
alias agp='sudo apt remove --purge'

### NALA aliases (nala must be installed)
alias nud='sudo nala update'
alias nug='sudo nala upgrade'
alias nc='sudo nala clean'
alias ni='sudo nala install'
alias nr='sudo nala remove'
alias np='sudo nala purge'
alias nlu='nala list --upgradable'
alias ns='nala search'
alias nw='nala show'

### DPKG aliases
alias dpkgi='sudo dpkg -i'

### Show directories tree
alias treed='tree -d'
alias treex='tree --prune -I'

### Remove packages marked as rc by dpkg
alias purgerc='dpkg --list | grep "^rc" | cut -d " " -f 3 | xargs sudo dpkg --purge'

### Remove packages showed as orpahned by deborphan
alias purgeorph='sudo apt remove --purge $(deborphan)'

### Tmuxinator shortcut
alias mux='tmuxinator'

### Aliases for rails commands via docker
alias dcr='docker-compose run --rm web'
# Migrate both development and test environments
alias dcr-mig='docker-compose run --rm web rails db:migrate db:test:prepare'
alias dcr-spec='docker-compose run -e "RAILS_ENV=test" --rm web bundle exec rspec'
alias dcr-cl='docker-compose run --rm web rake log:clear'

### Other aliases for docker
alias dclft='docker compose logs -f --tail=50'
alias dps='docker ps -a --format "table {{.Names}}\t{{.Status}}\t{{.Image}}" | (sed -u 1q; sort)'
alias dpsup='docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}\t{{.Image}}" | (sed -u 1q; sort)'
alias dilss='docker images | (sed -u 1q; sort)'
# Inspect network and get container name with IP
function dnip() { echo "Containers in network $1"; docker network inspect --format '{{ json .Containers }}' $1 | jq --raw-output '.[] | "\(.IPv4Address) --> \(.Name)"'; }

### Other alias for git
alias ggrh='git reset --hard origin/$(current_branch)'
alias 'ggpushf!'='git push --force-with-lease origin $(current-branch)'
alias grbiom='git rebase --interactive origin/master'
# Show history of a single file; usage glff <path/of/file>
alias glff='git log --follow -p --'
# git flow manage bugfix branches
alias gflb='git flow bugfix'
alias gflbs='git flow bugfix start'
alias gflbf='git flow bugfix finish'
alias gflbp='git flow bugfix publish'
alias gflbpll='git flow bugfix pull'
alias gflbfc='git flow bugfix finish ${$(git_current_branch)#bugfix/}'
alias gflbpc='git flow bugfix publish ${$(git_current_branch)#bugfix/}'

### Reload zshrc
alias zshrc='source $HOME/.zshrc'

### Use wget with tor
alias tget='torsocks wget'

### Show $PATH nicely formatted and sorted
alias path='tr ":" "\n" <<< "$PATH" | sort'

### Show history with datetime ISO8601 format (zsh only!)
alias history='history -i'

### Shortcut to common used directories
alias proj='[ -d $HOME/Projects ] && (cd $HOME/Projects) || (echo "Directory $HOME/Projects not exists")'
alias devel='[ -d $HOME/devel ] && (cd $HOME/devel) || (echo "Directory $HOME/devel not exists")'

### Query cheat.sh for a range of linux commands
alias cheat='_curl_cheat() { curl cheat.sh/"$1"; }; _curl_cheat'

### Print running services
alias running_services='systemctl list-units --type=service --state=running'
