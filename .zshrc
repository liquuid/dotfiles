export TERM="xterm-256color"
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/liquuid/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
PROMPT='%F{green}%n%f@%F{blue}%m%f %F{yellow}%1~%f %# '
export PATH=$PATH:~/go/bin
export PATH=$PATH:~/bin
export PATH=$PATH:~/.local/bin
export PATH=$PATH:/usr/local/bin
export GOPATH=~/go
export PATH=$PATH:$HOME/.gem/ruby/2.6.0/bin
export PATH=$PATH:/var/lib/snapd/snap/bin
export PATH=$PATH:$HOME/.cargo/bin
export LC_ALL="pt_BR.UTF-8"
#alias ls="exa"
alias ls="ls --color"
#alias steam="flatpak run com.valvesoftware.Steam"
alias ddu="du -h --max-depth=1"
alias -s txt=vim
alias gnome-boxes="GTK_THEME=Adwaita:light gnome-boxes"
#export VAGRANT_DEFAULT_PROVIDER=libvirt
bindkey "${terminfo[khome]}" beginning-of-line
bindkey "${terminfo[kend]}" end-of-line
# key bindings
bindkey "e[1~" beginning-of-line
bindkey "e[4~" end-of-line
bindkey "e[5~" beginning-of-history
bindkey "e[6~" end-of-history
bindkey "e[3~" delete-char
bindkey "e[2~" quoted-insert
bindkey "e[5C" forward-word
bindkey "eOc" emacs-forward-word
bindkey "e[5D" backward-word
bindkey "eOd" emacs-backward-word
bindkey "ee[C" forward-word
bindkey "ee[D" backward-word
bindkey "^H" backward-delete-word
# for rxvt
bindkey "e[8~" end-of-line
bindkey "e[7~" beginning-of-line
# for non RH/Debian xterm, can't hurt for RH/DEbian xterm
bindkey "eOH" beginning-of-line
bindkey "eOF" end-of-line
# for freebsd console
bindkey "e[H" beginning-of-line
bindkey "e[F" end-of-line
# completion in the middle of a line
bindkey '^i' expand-or-complete-prefix

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Home]="$terminfo[khome]"
key[End]="$terminfo[kend]"
key[Insert]="$terminfo[kich1]"
key[Backspace]="$terminfo[kbs]"
key[Delete]="$terminfo[kdch1]"
key[Up]="$terminfo[kcuu1]"
key[Down]="$terminfo[kcud1]"
key[Left]="$terminfo[kcub1]"
key[Right]="$terminfo[kcuf1]"
key[PageUp]="$terminfo[kpp]"
key[PageDown]="$terminfo[knp]"

# setup key accordingly
[[ -n "$key[Home]"      ]] && bindkey -- "$key[Home]"      beginning-of-line
[[ -n "$key[End]"       ]] && bindkey -- "$key[End]"       end-of-line
[[ -n "$key[Insert]"    ]] && bindkey -- "$key[Insert]"    overwrite-mode
[[ -n "$key[Backspace]" ]] && bindkey -- "$key[Backspace]" backward-delete-char
[[ -n "$key[Delete]"    ]] && bindkey -- "$key[Delete]"    delete-char
[[ -n "$key[Up]"        ]] && bindkey -- "$key[Up]"        up-line-or-history
[[ -n "$key[Down]"      ]] && bindkey -- "$key[Down]"      down-line-or-history
[[ -n "$key[Left]"      ]] && bindkey -- "$key[Left]"      backward-char
[[ -n "$key[Right]"     ]] && bindkey -- "$key[Right]"     forward-char

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        echoti smkx
    }
    function zle-line-finish () {
        echoti rmkx
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi
source $HOME/.powerlevel10k/powerlevel10k.zsh-theme
source $HOME/.zsh_functions
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs virtualenv pyenv dir_writable) 
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs disk_usage )
POWERLEVEL9K_DIR_PATH_ABSOLUTE=false
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
eval $( dircolors $HOME/.LS_COLORS) 
export EDITOR=/usr/bin/vim
export SECRET_KEY="secret"
#export DATABASE_URL="postgres://liquuid:qwe@localhost:5432/liquuid"
#export DATABASE_URL="postgres://saleor:saleor@localhost:5432/saleor"
export ALLOWED_HOSTS="*"
export DEFAULT_FROM_EMAIL="from@email.com"
alias manage='python $VIRTUAL_ENV/../manage.py'
alias clear_docker="docker rmi `docker images | awk '{ print $3 }'`"
alias l="ls -l"
alias la="ls -la"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
