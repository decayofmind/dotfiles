# vim:foldlevel=0
# vim:foldmethod=marker

# Start profiler
if [[ "${ZSH_PROFILE}" == 1 ]]; then
    zmodload zsh/zprof
else
    ZSH_PROFILE=0
fi

# Zinit {{{
ZINIT_HOME="${XDG_DATA_HOME:-${HOME:-~/.local/share}}/zinit"

if [[ ! -d $ZINIT_HOME ]]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME/repo"
fi

source "${ZINIT_HOME}/repo/zinit.zsh"

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit light-mode for \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-bin-gem-node \
    NICHOLAS85/z-a-eval

# Prezto {{{
zinit snippet PZT::modules/environment/init.zsh
zinit snippet PZT::modules/gnu-utility/init.zsh

zstyle ':prezto:module:utility' safe-ops 'no'
zinit snippet PZTM::utility

zinit ice wait'1' lucid; zinit snippet PZT::modules/directory/init.zsh
zinit snippet PZT::modules/history/init.zsh
zinit snippet PZT::modules/completion/init.zsh
zinit snippet PZT::modules/osx/init.zsh
zinit snippet PZT::modules/gpg/init.zsh

zstyle ':prezto:module:editor' dot-expansion 'yes'
zstyle ':prezto:module:editor' key-bindings 'vi'
zstyle ':prezto:module:editor' ps-context 'yes'
zstyle ':prezto:module:prompt' managed 'yes'
zinit snippet PZTM::editor

# zinit load "jreese/zsh-titles"
zstyle ':prezto:module:terminal' auto-title 'yes'
zinit snippet PZT::modules/terminal/init.zsh
# }}}

zinit ice lucid atload"unalias gcd"
zinit snippet OMZP::git

zinit ice wait'0' lucid; zinit light "akarzim/zsh-docker-aliases"
zinit ice wait'1' as"completion" lucid
zinit snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker
zinit ice wait'1' as"completion" lucid
zinit snippet https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/terraform/_terraform

zinit light mafredri/zsh-async

zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode

zinit ice depth=1 atload'!source ~/.p10k.zsh'
zinit light romkatv/powerlevel10k

# Python {{{
# zinit ice lucid wait'1' atinit"local ZSH_PYENV_LAZY_VIRTUALENV=true" \
#   atload"pyenv virtualenvwrapper_lazy"
# zinit light davidparsson/zsh-pyenv-lazy
# zinit ice svn wait'2' silent; zinit snippet OMZ::plugins/pyenv
# }}}

zinit ice wait'0' lucid atload"unalias d"
zinit snippet OMZP::fasd

zinit ice wait'0' blockf lucid
zinit light zsh-users/zsh-completions

zinit ice wait"0" lucid; zinit load zdharma-continuum/history-search-multi-word

zinit ice lucid wait"0" atclone"sed -ie 's/fc -rl 1/fc -rli 1/' shell/key-bindings.zsh" \
  atpull"%atclone" multisrc"shell/{completion,key-bindings}.zsh" id-as"junegunn/fzf_completions" \
  pick"/dev/null"
zinit light junegunn/fzf

zinit ice wait lucid blockf
zinit light Aloxaf/fzf-tab
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
zstyle ':fzf-tab:*' switch-group ',' '.'

zinit ice wait"0" lucid if'[[ ! $TERM =~ ".*kitty" ]]'; zinit light marzocchi/zsh-notify

zinit ice depth"1" \
  pick"shell_integration/zsh" \
  sbin"utilities/*" if"[[ $+ITERM_PROFILE ]]"
zinit load gnachman/iTerm2-shell-integration

# Programs {{{
zinit ice wait lucid from"gh-r" \
    mv="direnv* -> direnv" sbin="direnv" \
    atclone="./direnv hook zsh > zhook.zsh" \
    atpull="%atclone" \
    src="zhook.zsh" nocompile'!'
zinit load direnv/direnv

zinit ice wait lucid from"gh-r" bpick"krew.tar.gz" \
            mv"krew-darwin_amd64 -> krew" \
            sbin"krew" has"kubectl"
zinit load kubernetes-sigs/krew

zinit ice wait'0' lucid; zinit snippet OMZP::kubectl
# }}}

# Colors and highlight {{{
zinit light 'chrissicool/zsh-256color'
zinit ice atclone"dircolors -b src/dir_colors > c.zsh" \
            atpull'%atclone' \
            pick"c.zsh" \
            nocompile'!'
zinit light arcticicestudio/nord-dircolors
zinit ice atload"base16_${BASE16_THEME}"
zinit light "chriskempson/base16-shell"
zinit ice lucid wait'0' \
            src"bash/base16-${BASE16_THEME}.config" \
            pick"bash/base16-${BASE16_THEME}.config" nocompile'!'
zinit light 'nicodebo/base16-fzf'
# }}}

zinit ice from'gh-r' sbin'def-matcher'
zinit light sei40kr/fast-alias-tips-bin
zinit light sei40kr/zsh-fast-alias-tips

zinit wait lucid for \
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

. $(brew --prefix asdf)/asdf.sh

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

export HOMEBREW_NO_ANALYTICS=1
export KEYTIMEOUT=1

for file in ${HOME}/.zsh/*.zsh; do
  source $file
done
