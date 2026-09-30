# Startup profiling: ZPROF=1 zsh -i -c exit
[[ -n "${ZPROF:-}" ]] && zmodload zsh/zprof

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input must go above this block.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export GOPATH="$HOME/go"
typeset -U path fpath  # drop duplicate entries that nested shells add again
[[ -d ~/.cache/zsh ]] || mkdir -p ~/.cache/zsh

# Like `eval "$(cmd args)"`, but caches the output. Each fork costs ~10-45 ms.
# The cache refreshes when the binary's resolved path (its Cellar version) changes.
# ponytail: brew's path has no version; `rm ~/.cache/zsh/*-init.zsh` to force a refresh.
_cached_eval() {
  local bin=${commands[$1]:A} cache=~/.cache/zsh/$1-init.zsh first
  [[ -n $bin ]] || return 0
  [[ -r $cache ]] && read -r first < $cache
  [[ $first == "# $bin" ]] || { print -r -- "# $bin"; "$@" } >| $cache
  source $cache
}

# Homebrew (Apple Silicon / Intel)
if [[ -z ${commands[brew]} ]]; then
  for _b in /opt/homebrew/bin /usr/local/bin; do
    [[ -x $_b/brew ]] && { path=($_b $path); break }
  done
  unset _b
fi
_cached_eval brew shellenv

# GNU coreutils without freezing the system PATH
if [[ -n "${HOMEBREW_PREFIX:-}" && -d "$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin" ]]; then
  export PATH="$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin:$PATH"
fi
path=(~/.local/bin $path ~/go/bin)

# Completion init: full security check at most once a day, cached otherwise
if command -v brew &>/dev/null; then
  FPATH="$HOMEBREW_PREFIX/share/zsh-completions:$FPATH"
fi
autoload -Uz compinit
# Glob into an array: [[ ]] ignores glob qualifiers unless extendedglob is set
_stale_dump=(~/.cache/zsh/zcompdump(N.mh+24))
if (( $#_stale_dump )); then
  compinit -u -d ~/.cache/zsh/zcompdump
  touch ~/.cache/zsh/zcompdump  # compinit skips the rewrite when nothing changed
else
  compinit -C -d ~/.cache/zsh/zcompdump  # also builds the dump when it is missing
fi
unset _stale_dump

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
setopt sharehistory         # share history across all shell sessions
setopt hist_ignore_space    # commands prepended with a space are excluded
setopt hist_ignore_all_dups # prevent dups from being recorded
setopt hist_save_no_dups    # same
setopt hist_find_no_dups    # prevent dups from being shown when searched

# zsh aliases
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias c="clear"
alias ll="ls -lah --color"  # GNU ls and macOS 13+ ls both accept --color
command -v gsed &>/dev/null && alias sed="gsed"
command -v nvim &>/dev/null && alias vim="nvim"
alias zshrc="vim ~/.zshrc"

# brew
alias b="brew"
alias bi="brew install"
alias bic="brew install --cask"
alias bui="brew uninstall"
alias bup="brew upgrade"

# fzf
_cached_eval fzf --zsh

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
alias gbda="git branch | grep -vE '^[*+]|^  (main|master)$' | xargs git branch -D"

# tofu
alias t="tofu"
alias taa="tofu apply -auto-approve"
alias tp="tofu plan"

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
_cached_eval zoxide init --cmd cd zsh

# Trust Gen Digital/Zscaler SSL-inspection CA for Node-based tools
[[ -f "$HOME/.config/certs/ZScerts.pem" ]] && export NODE_EXTRA_CA_CERTS="$HOME/.config/certs/ZScerts.pem"
[[ -x "${HOMEBREW_PREFIX:-/opt/homebrew}/opt/mysql-client@8.0/bin/mysql" ]] && alias mysql80="${HOMEBREW_PREFIX:-/opt/homebrew}/opt/mysql-client@8.0/bin/mysql"

# Print the startup profile (see top of file); `if` keeps the rc exit status 0
if [[ -n "${ZPROF:-}" ]]; then zprof; fi
