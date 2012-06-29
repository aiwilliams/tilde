######### Homebrew ##########
# Please check your /etc/paths to be sure that /usr/local/bin is first in order

source $HOME/lib/git-completion.bash
source $HOME/lib/git-prompt.sh
complete -C $HOME/lib/rake-complete.rb -o default rake

export PS1='\[\e[36m\]\[\e[0m\]\w\[\e[35m\]$(__git_ps1 " %s")\[\e[0m\] '

export EDITOR="mvim"
export LESS="-R"
export GEMEDITOR="mvim"
export GUARD_NOTIFY=false

#### Android Development ####
export ANDROID_HOME="/Users/aiwilliams/Workspaces/android/android-sdk-macosx"

######### MacVim ##########
defaults write org.vim.MacVim MMVerticalSplit 1
defaults write org.vim.MacVim MMZoomBoth 1

######### GIT ##########
export GIT_EDITOR='mvim -gf '
alias gl='git log -n1000 --no-merges --pretty=format:"* %s (%cn) %b"'
alias gitx='gitx --all'

######### Bundler ##########
alias b="bundle"
alias bi="b install"
alias bu="b update"
alias be="b exec"

######### rbenv ##########
eval "$(rbenv init -)"
export PATH="./bin:$HOME/bin:$PATH"

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
