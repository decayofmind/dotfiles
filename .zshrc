# vim:foldlevel=0
# vim:foldmethod=marker

# zmodload zsh/zprof && zprof

# Zinit {{{
if [[ ! -d ~/.zinit ]]; then
  mkdir ~/.zinit
  git clone https://github.com/zdharma/zinit.git ~/.zinit/bin
fi

source ~/.zinit/bin/zinit.zsh

# Prezto {{{
zinit snippet PZT::modules/environment/init.zsh
zinit snippet PZT::modules/gnu-utility/init.zsh
# zstyle ':prezto:module:utility' safe-ops 'no'
zinit snippet PZT::modules/utility/init.zsh
zinit ice wait'1' lucid; zplg snippet PZT::modules/directory/init.zsh
zinit snippet PZT::modules/history/init.zsh
zinit snippet PZT::modules/completion/init.zsh
zinit snippet PZT::modules/osx/init.zsh
zinit snippet PZT::modules/gpg/init.zsh

zstyle ':prezto:module:editor' dot-expansion 'yes'
zstyle ':prezto:module:editor' key-bindings 'vi'
zstyle ':prezto:module:editor' ps-context 'yes'
zstyle ':prezto:module:prompt' managed 'yes'
zinit snippet PZT::modules/editor/init.zsh

# zinit load "jreese/zsh-titles"
zstyle ':prezto:module:terminal' auto-title 'yes'
zinit snippet PZT::modules/terminal/init.zsh
# }}}

zinit ice wait'0' lucid; zplg snippet OMZ::plugins/git/git.plugin.zsh

zinit ice wait'0' lucid; zplg light "akarzim/zsh-docker-aliases"
zinit ice wait'1' as"completion" lucid
zinit snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker
zinit ice wait'1' as"completion" lucid
zinit snippet https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/terraform/_terraform

zinit light mafredri/zsh-async
zinit ice depth'1'; zplg light denysdovhan/spaceship-prompt

# Python {{{
zinit ice lucid wait'1' atinit"local ZSH_PYENV_LAZY_VIRTUALENV=true" \
  atload"pyenv virtualenvwrapper_lazy"
zinit light davidparsson/zsh-pyenv-lazy
# zinit ice svn wait'2' silent; zplg snippet OMZ::plugins/pyenv
# }}}

zinit ice wait'0' lucid atload"unalias d"
zinit snippet OMZ::plugins/fasd/fasd.plugin.zsh

zinit ice wait'0' blockf lucid
zinit light zsh-users/zsh-completions

zinit ice wait"0" lucid; zplg load zdharma/history-search-multi-word

zinit ice lucid wait"0" atclone"sed -ie 's/fc -rl 1/fc -rli 1/' shell/key-bindings.zsh" \
  atpull"%atclone" multisrc"shell/{completion,key-bindings}.zsh" id-as"junegunn/fzf_completions" \
  pick"/dev/null"
zinit light junegunn/fzf

zinit ice wait"0" lucid; zplg light marzocchi/zsh-notify

# iTerm2 integration {{{
zinit ice silent if"[[ $+ITERM_PROFILE ]]"; zplg snippet OMZ::plugins/iterm2/iterm2.plugin.zsh
zinit ice as"command" pick"bin/*" \
  atclone'./_utils/download_files.sh' \
  atpull'%atclone' if"[[ $+ITERM_PROFILE ]]"
zinit light decayofmind/zsh-iterm2-utilities
zinit snippet 'https://raw.githubusercontent.com/gnachman/iterm2-website/master/source/shell_integration/zsh'
# }}}

# Programs {{{
zinit ice as"program" make'!' \
            atclone'./direnv hook zsh > zhook.zsh' \
            atpull'%atclone' src"zhook.zsh"
zinit light direnv/direnv

zinit ice from"gh-r" as"program" bpick"krew.tar.gz" \
            mv"krew-darwin_amd64 -> krew" pick"krew" \
            atclone"rm -f krew-* && ./krew install krew && ./krew update" \
            atpull"%atclone" has"kubectl"
zinit light kubernetes-sigs/krew
zinit ice wait'0' lucid; zplg snippet OMZ::plugins/kubectl/kubectl.plugin.zsh

zinit ice from"gh-r" as"program" bpick"*darwin_amd64*" pick"terraform-lsp"
zinit light juliosueiras/terraform-lsp
# }}}

# Colors {{{
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


zinit ice from'gh-r' as'program'
zinit light sei40kr/fast-alias-tips-bin
zinit light sei40kr/zsh-fast-alias-tips

# zsh-autosuggestions
zinit ice lucid wait"1" lucid atload"!_zsh_autosuggest_start"
zinit load "zsh-users/zsh-autosuggestions"
zinit ice wait"1" atinit"zpcompinit; zpcdreplay" lucid
zinit light zdharma/fast-syntax-highlighting
zinit light zsh-users/zsh-history-substring-search
  zmodload zsh/terminfo
  [ -n "${terminfo[kcuu1]}" ] && bindkey "${terminfo[kcuu1]}" history-substring-search-up
  [ -n "${terminfo[kcud1]}" ] && bindkey "${terminfo[kcud1]}" history-substring-search-down
  bindkey -M emacs '^P' history-substring-search-up
  bindkey -M emacs '^N' history-substring-search-down
  bindkey -M vicmd 'k' history-substring-search-up
  bindkey -M vicmd 'j' history-substring-search-down

# }}}

if (which zprof > /dev/null) ;then
  zprof | less
fi

autoload -Uz compinit

if [ $(date +'%j') != $(/usr/bin/stat -f '%Sm' -t '%j' ${ZDOTDIR:-$HOME}/.zcompdump) ]; then
  compinit;
else
  compinit -C;
fi

for file in ${HOME}/.zsh/*.zsh; do
  source $file
done

# FZF {{{
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd -t d ."
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
# }}}

# Spaceship prompt {{{
SPACESHIP_PROMPT_SEPARATE_LINE=false
SPACESHIP_PROMPT_ORDER=(
  dir
  host
  vi_mode
  jobs
  char
)
SPACESHIP_RPROMPT_ORDER=(
  terraform
  kubectl_context
  venv
  git
  exit_code
)
SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_CHAR_SYMBOL='❯ '
SPACESHIP_VI_MODE_SUFFIX='❯'
SPACESHIP_VI_MODE_INSERT='❯'
SPACESHIP_VI_MODE_NORMAL='❮'
SPACESHIP_VI_MODE_COLOR='magenta'
SPACESHIP_DIR_TRUNC_REPO=false
SPACESHIP_KUBECONTEXT_SHOW=false
SPACESHIP_KUBECONTEXT_SYMBOL='⎈  '
SPACESHIP_PYENV_SHOW=false
SPACESHIP_EXIT_CODE_SHOW=true
SPACESHIP_EXIT_CODE_SYMBOL='✘ '
SPACESHIP_GIT_STATUS_PREFIX=' '
SPACESHIP_GIT_STATUS_SUFFIX=''
SPACESHIP_GIT_STATUS_COLOR='magenta'
SPACESHIP_TERRAFORM_SYMBOL=' '
# }}}

export HOMEBREW_NO_ANALYTICS=1
export KEYTIMEOUT=1
