export GOPATH="$HOME/go"
export PATH="$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin:$PATH"

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
  autoload -Uz compinit
  compinit
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# load zsh plugins
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Keybindings
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# History config
HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase # duplicates are removed
setopt appendhistory # append commands instead of overwrite
setopt sharehistory # share history across all shell sessions
setopt hist_ignore_space # commands prepended with a space are excluded
setopt hist_ignore_all_dups # prevent dups from being recorded
setopt hist_save_no_dups # same
setopt hist_ignore_dups # same
setopt hist_find_no_dups # prevent dups from being shown when searched

# zsh aliases
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias c="clear"
alias ll="ls -lah --color"
alias sed="gsed"
alias vim="nvim"
alias zshrc="vim ~/.zshrc"
alias date="gdate"

# brew
alias b="brew"
alias bi="brew install"
alias bic="brew install --cask"
alias bui="brew uninstall"
alias bup="brew upgrade"

# thefuck
eval $(thefuck --alias)

# fzf
eval "$(fzf --zsh)"

# docker
alias dpsa="docker ps -a"

# git
alias g="git"
alias gb="git branch"
alias gca="git commit --amend"
alias gcma="git commit -am"
alias gp="git push"
alias gl="git log"
alias gd="git diff"
alias gpl="git pull"
alias gr="git reset"
alias gsh="git stash"
alias gpum="git pull upstream master"
alias gpu="git pull upstream"
alias gcb="git checkout -b"
alias gbd="git branch -D"
alias gc="git checkout"
alias gbda="git branch | grep -vE '^(master|main|\*)' | xargs git branch -D"

# terraform/tofu
alias tf="tofu"
alias tfaa="tofu apply -auto-approve"
alias tfp="tofu plan"

# kubectl
alias k="kubectl"
alias kg="kubectl get"
alias kgpn="kubectl get pods -n"
alias kgpa="kubectl get pods -A"
alias kaf="kubectl apply -f"
alias kdf="kubectl delete -f"
alias krr="kubectl rollout restart"
alias krrd="kubectl rollout restart deploy"
alias krrsts="kubectl rollout restart statefulset"
alias kak="kubectl apply -k"
alias kd="kubectl describe"
alias ke="kubectl exec"
alias kl="kubectl logs"
alias kex="kubectl exec -it"
alias kpf="kubectl port-forward"
alias klo="kubectl logs -f"
alias ksys="kubectl --namespace=kube-system"
alias kall="kubectl get all --all-namespaces"

# alias cd to use zoxide
eval "$(zoxide init --cmd cd zsh)"
