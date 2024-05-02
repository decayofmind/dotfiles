# vim:foldlevel=0
# vim:foldmethod=marker

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Start profiler
if [[ "${ZSH_PROFILE}" == 1 ]]; then
    zmodload zsh/zprof
else
    ZSH_PROFILE=0
fi

# Zinit {{{
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

zinit ice depth"1" atload'!source ~/.p10k.zsh'
zinit light romkatv/powerlevel10k

zinit light-mode depth"1" for \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-bin-gem-node \
    NICHOLAS85/z-a-eval \
    zsh-users/zsh-completions

# Prezto {{{
zinit snippet PZTM::gnu-utility

zstyle ':prezto:module:utility' safe-ops 'no'
zinit snippet PZTM::utility

zinit snippet PZTM::history
# zinit snippet PZT::modules/completion/init.zsh
zinit snippet PZTM::gpg

zstyle ':prezto:module:editor' dot-expansion 'yes'
zstyle ':prezto:module:editor' key-bindings 'vi'
zstyle ':prezto:module:editor' ps-context 'yes'
zinit snippet PZTM::editor

zstyle ':prezto:module:terminal' auto-title 'yes'
zinit snippet PZTM::terminal
# }}}

zinit light mafredri/zsh-async

zinit ice depth'1'
zinit light jeffreytse/zsh-vi-mode

zinit ice wait'0' lucid
zinit light ajeetdsouza/zoxide

zinit ice wait"0" lucid; zinit load zdharma-continuum/history-search-multi-word

zinit ice lucid wait"0" atclone"sed -ie 's/fc -rl 1/fc -rli 1/' shell/key-bindings.zsh" \
  atpull"%atclone" multisrc"shell/{completion,key-bindings}.zsh" id-as"junegunn/fzf_completions" \
  pick"/dev/null"
zinit light junegunn/fzf

zinit ice wait lucid blockf
zinit light Aloxaf/fzf-tab
  zstyle ':completion:*:git-checkout:*' sort false
  zstyle ':completion:*:descriptions' format '[%d]'
  zstyle ':fzf-tab:*' prefix ''
  zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
  zstyle ':fzf-tab:complete:cd:*' fzf-preview 'lsd -1 --color=always $realpath'
  zstyle ':fzf-tab:*' switch-group ',' '.'
  zstyle -d ':completion:*' format
  zstyle ':completion:*' use-cache on
  zstyle ':completion:*' cache-path ${XDG_CACHE_HOME:-$HOME/.cache}/zsh

zinit ice wait"0" lucid if'[[ ! $TERM =~ ".*kitty" ]]'; zinit light marzocchi/zsh-notify

zinit ice depth"1" \
  pick"shell_integration/zsh" \
  sbin"utilities/*" if"[[ $+ITERM_PROFILE ]]"
zinit load gnachman/iTerm2-shell-integration

zinit ice lucid atload"unalias gcd"
zinit snippet OMZP::git

zinit snippet OMZP::asdf
zinit snippet OMZP::brew

# Programs {{{
zinit ice wait lucid from"gh-r" \
    mv"direnv* -> direnv" sbin"direnv" \
    eval"./direnv hook zsh"
zinit load direnv/direnv

zinit ice wait"0" lucid
zinit light "akarzim/zsh-docker-aliases"
zinit ice wait"1" as"completion" lucid
zinit snippet OMZP::docker

zinit ice lucid
zinit snippet OMZP::aws

zinit ice wait'1' as"completion" lucid
zinit snippet OMZP::terraform/_terraform

zinit ice wait lucid from"gh-r" bpick"krew-darwin_amd64.tar.gz" \
            mv"krew-darwin_amd64 -> krew" \
            sbin"krew" has"kubectl"
zinit load kubernetes-sigs/krew

# zinit ice wait'0' lucid
zinit snippet OMZP::kubectl
# }}}

# Colors and highlight {{{
zinit light 'chrissicool/zsh-256color'
zinit ice wait"2" lucid eval"dircolors -b src/dir_colors" \
zinit light arcticicestudio/nord-dircolors

zinit ice atload"base16_${BASE16_THEME}"
zinit light chriskempson/base16-shell
zinit ice lucid wait'1' \
            eval"bash/base16-${BASE16_THEME}.config"
zinit light nicodebo/base16-fzf
# }}}

zinit ice from"gh-r"
# zinit ice atclone"make build" atpull"%atclone"
zinit light decayofmind/zsh-fast-alias-tips

zinit wait"1" lucid for \
  atload"_zsh_autosuggest_start" zsh-users/zsh-autosuggestions \
  atinit"zpcompinit;zpcdreplay" zdharma-continuum/fast-syntax-highlighting

zinit light zsh-users/zsh-history-substring-search
  zmodload zsh/terminfo
  [ -n "${terminfo[kcuu1]}" ] && bindkey "${terminfo[kcuu1]}" history-substring-search-up
  [ -n "${terminfo[kcud1]}" ] && bindkey "${terminfo[kcud1]}" history-substring-search-down
  bindkey -M emacs '^P' history-substring-search-up
  bindkey -M emacs '^N' history-substring-search-down
  bindkey -M vicmd 'k' history-substring-search-up
  bindkey -M vicmd 'j' history-substring-search-down
# }}}

# End Profiler
if [[ "${ZSH_PROFILE}" == 1 ]]; then
  zprof | less
fi

autoload -Uz compinit

if [ $(date +'%j') != $(date -r ${ZDOTDIR:-$HOME}/.zcompdump +'%j') ]; then
  compinit;
else
  compinit -C;
fi

zinit cdreplay -q

# FZF {{{
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd -t d ."
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
# }}}

export ZVM_KEYTIMEOUT=0.1
export ZVM_CURSOR_STYLE_ENABLED=false
export ZVM_VI_HIGHLIGHT_BACKGROUND=gray
export ZVM_VI_HIGHLIGHT_FOREGROUND=gray

export ZSH_FAST_ALIAS_TIPS_EXCLUDES="_ sl l"

export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_ENV_HINTS=1
export KEYTIMEOUT=1

typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
typeset -g POWERLEVEL9K_VCS_BRANCH_ICON='\UE0A0 '
typeset -g POWERLEVEL9K_VCS_GIT_ICON=
typeset -g POWERLEVEL9K_HOME_ICON=''
typeset -g POWERLEVEL9K_HOME_SUB_ICON=''
typeset -g POWERLEVEL9K_FOLDER_ICON=''
typeset -g POWERLEVEL9K_ETC_ICON=''
typeset -g POWERLEVEL9K_APPLE_ICON=''

for file in ${HOME}/.zsh/*.zsh; do
  source $file
done
