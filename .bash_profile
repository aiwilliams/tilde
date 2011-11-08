######### Homebrew ##########
# Please check your /etc/paths to be sure that /usr/local/bin is first in order

source ~/lib/git-completion.bash
complete -C $HOME/lib/rake-complete.rb -o default rake

export PS1='\[\e[36m\]\[\e[0m\]\w\[\e[35m\]$(__git_ps1 " %s")\[\e[0m\] '

export EDITOR="mvim"
export LESS="-R"
export GEMEDITOR="mvim"
export GUARD_NOTIFY=false

######### MacVim ##########
defaults write org.vim.MacVim MMVerticalSplit 1
defaults write org.vim.MacVim MMZoomBoth 1

# https://github.com/robgleeson/hammer.vim/issues/8
# https://github.com/robgleeson/hammer.vim/issues/12
mvim()
{
  (unset GEM_PATH GEM_HOME; command mvim "$@")
}

######### GIT ##########
alias gl='git log -n1000 --no-merges --pretty=format:"* %s (%cn) %b"'

######### Bundler ##########
alias b="bundle"
alias bi="b install --path vendor"
alias bu="b update"
alias be="b exec"
alias binit="bi && b package && echo 'vendor/ruby' >> .gitignore"

######### RVM ##########
[[ -s ~/.rvm/scripts/rvm ]] && source ~/.rvm/scripts/rvm

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
