# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"

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

# bash
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ll="ls -la"
alias sed="gsed"
alias vim="nvim"
alias zshrc="vim ~/.zshrc"
alias srczsh="source ~/.zshrc"

# brew
alias bi="brew install"
alias bic="brew install --cask"
alias bui="brew uninstall"
alias bup="brew upgrade"

# thefuck
eval $(thefuck --alias)

# docker/nerdctl
alias n="nerdctl"
alias docker="nerdctl"
alias npsa="n ps -a"
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

# terraform
alias tf="terraform"

# kubectl
alias k="kubectl"
alias kg="kubectl get"
alias kgpn="kubectl get pods -n"
alias kgpa="kubectl get pods -A"
alias kaf="kubectl apply -f"
alias kdf="kubectl delete -f"
alias krr="kubectl rollout restart"
alias kak="kubectl apply -k"
alias kd="kubectl describe"
alias ke="kubectl exec"
alias kl="kubectl logs"
alias kex="kubectl exec -it"
alias kpf="kubectl port-forward"
alias klo="kubectl logs -f"
alias ksys="kubectl --namespace=kube-system"
alias kall="kubectl get all --all-namespaces"

eval "$(zoxide init --cmd cd zsh)"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/pcesario/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
