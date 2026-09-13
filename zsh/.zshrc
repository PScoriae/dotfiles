export GOPATH="$HOME/go"

# Homebrew (Apple Silicon / Intel / Linux)
if command -v brew &>/dev/null; then
  eval "$(brew shellenv)"
elif [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# GNU coreutils without freezing the system PATH
if [[ -n "${HOMEBREW_PREFIX:-}" && -d "$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin" ]]; then
  export PATH="$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin:$PATH"
fi
case ":$PATH:" in
  *":$HOME/go/bin:"*) ;;
  *) export PATH="$PATH:$HOME/go/bin" ;;
esac
case ":$PATH:" in
  *":$HOME/.local/bin:"*) ;;
  *) export PATH="$HOME/.local/bin:$PATH" ;;
esac

if command -v brew &>/dev/null; then
  FPATH="$(brew --prefix)/share/zsh-completions:$FPATH"
  autoload -Uz compinit
  [[ -d ~/.cache/zsh ]] || mkdir -p ~/.cache/zsh
  compinit -u -d ~/.cache/zsh/zcompdump
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# load zsh plugins (skip silently if not installed yet)
for _plug in powerlevel10k/powerlevel10k.zsh-theme zsh-syntax-highlighting/zsh-syntax-highlighting.zsh zsh-autosuggestions/zsh-autosuggestions.zsh; do
  [[ -r "${HOMEBREW_PREFIX:-/opt/homebrew}/share/$_plug" ]] && source "${HOMEBREW_PREFIX:-/opt/homebrew}/share/$_plug"
done
unset _plug

# Keybindings
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# History config
HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase               # duplicates are removed
setopt appendhistory        # append commands instead of overwrite
setopt sharehistory         # share history across all shell sessions
setopt hist_ignore_space    # commands prepended with a space are excluded
setopt hist_ignore_all_dups # prevent dups from being recorded
setopt hist_save_no_dups    # same
setopt hist_ignore_dups     # same
setopt hist_find_no_dups    # prevent dups from being shown when searched

# zsh aliases
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias c="clear"
if command -v gls &>/dev/null; then
  alias ll="gls -lah --color"
elif ls --color -d . &>/dev/null; then
  alias ll="ls -lah --color"
else
  alias ll="ls -lah"
fi
command -v gsed &>/dev/null && alias sed="gsed"
command -v nvim &>/dev/null && alias vim="nvim"
alias zshrc="vim ~/.zshrc"
command -v gdate &>/dev/null && alias date="gdate"

# brew
alias b="brew"
alias bi="brew install"
alias bic="brew install --cask"
alias bui="brew uninstall"
alias bup="brew upgrade"

# thefuck
command -v thefuck &>/dev/null && eval "$(thefuck --alias)"

# fzf
command -v fzf &>/dev/null && eval "$(fzf --zsh)"

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
alias t="terraform"
alias taa="terraform apply -auto-approve"
alias tp="terraform plan"

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
command -v zoxide &>/dev/null && eval "$(zoxide init --cmd cd zsh)"

# BEGIN savemytokens-path
# Keep ~/.local/bin on PATH so claude-smt and smt work in this shell.
case ":$PATH:" in
  *":$HOME/.local/bin:"*) ;;
  *) export PATH="$HOME/.local/bin:$PATH" ;;
esac
# END savemytokens-path

# Trust Gen Digital/Zscaler SSL-inspection CA for Node-based tools
[[ -f "$HOME/Downloads/ZScerts.pem" ]] && export NODE_EXTRA_CA_CERTS="$HOME/Downloads/ZScerts.pem"
[[ -x "${HOMEBREW_PREFIX:-/opt/homebrew}/opt/mysql-client@8.0/bin/mysql" ]] && alias mysql80="${HOMEBREW_PREFIX:-/opt/homebrew}/opt/mysql-client@8.0/bin/mysql"
