######### Homebrew ##########
# Please check your /etc/paths to be sure that /usr/local/bin is first in order

source $HOME/.bash_privates
source $HOME/lib/git-completion.bash
source $HOME/lib/git-prompt.sh
complete -C $HOME/lib/rake-complete.rb -o default rake

export PS1='\[\e[36m\]\[\e[0m\]\w\[\e[35m\]$(__git_ps1 " %s")\[\e[0m\] '

export EDITOR="vim"
export LESS="-R"
export GEMEDITOR="vim"
export GUARD_NOTIFY=false

#### Helpers ####
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1])"'
alias urldecode='python -c "import sys, urllib as ul; print ul.unquote_plus(sys.argv[1])"'

#### DevOps ####
export VAGRANT_DEFAULT_PROVIDER="vmware_fusion"

#### Ubuntu Launchpad ####
export DEBUSERNAME="aiwilliams"
export DEBFULLNAME="Adam Williams"
export DEBEMAIL="adam@thewilliams.ws"

######### MacVim ##########
defaults write org.vim.MacVim MMVerticalSplit 1
defaults write org.vim.MacVim MMZoomBoth 1

######### GIT ##########
export GIT_EDITOR='vim'
alias gl='git log -n1000 --no-merges --pretty=format:"* %s (%cn) %b"'
alias gitx='gitx --all'

######### Bundler ##########
alias b="bundle"
alias bi="b install"
alias bu="b update"
alias be="b exec"
[ -f ~/.bundler-exec.sh ] && source ~/.bundler-exec.sh

######### rbenv ##########
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
export PATH="./bin:$HOME/bin:$PATH"

######### plenv ##########
if which plenv > /dev/null; then eval "$(plenv init -)"; fi

######### pyenv ##########
export PYENV_ROOT=/usr/local/opt/pyenv
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

#### Riak ####
ulimit -n 2048

#### Node.js, npm ####
export PATH="/usr/local/share/npm/bin:$PATH"

######### SSH ##########
# http://www.shocm.com/2011/01/ssh-autocomplete-on-osx/
_complete_ssh_hosts ()
{
        COMPREPLY=()
        cur="${COMP_WORDS[COMP_CWORD]}"
        comp_ssh_hosts=`cat ~/.ssh/known_hosts | \
                        cut -f 1 -d ' ' | \
                        sed -e s/,.*//g | \
                        grep -v ^# | \
                        uniq | \
                        grep -v "\[" ;
                cat ~/.ssh/config | \
                        grep "^Host " | \
                        awk '{print $2}'
                `
        COMPREPLY=( $(compgen -W "${comp_ssh_hosts}" -- $cur))
        return 0
}
complete -F _complete_ssh_hosts ssh
