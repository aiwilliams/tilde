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
