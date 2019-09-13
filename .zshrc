# zmodload zsh/zprof && zprof

if [[ ! -d ~/.zplugin ]]; then
  mkdir ~/.zplugin
  git clone https://github.com/zdharma/zplugin.git ~/.zplugin/bin
fi

source ~/.zplugin/bin/zplugin.zsh


zplg ice svn lucid wait'1'; zplg snippet PZT::modules/environment
zplg ice svn lucid wait'1'; zplg snippet PZT::modules/gnu-utility
zplg ice svn lucid wait'1'; zplg snippet PZT::modules/utility
zplg ice svn lucid wait'1' pick'init.zsh'
zplg snippet PZT::modules/directory
zplg ice svn silent; zplg snippet PZT::modules/history
zplg ice svn silent; zplg snippet PZT::modules/completion

zstyle ':prezto:module:editor' key-bindings 'bindings'
zstyle ':prezto:module:editor' dot-expansion 'yes'
zstyle ':prezto:module:editor' ps-context 'yes'
zplg ice svn silent; zplg snippet PZT::modules/editor

# zplg load "jreese/zsh-titles"
zstyle ':prezto:module:terminal' auto-title 'yes'
zstyle ':prezto:module:terminal:window-title' format '%n@%m: %s'
zstyle ':prezto:module:terminal:tab-title' format '%m: %s'
zplg ice svn silent; zplg snippet PZT::modules/terminal


zplg ice svn lucid wait'1'; zplg snippet PZT::modules/osx
zplg ice svn lucid wait'1'; zplg snippet PZT::modules/python
zplg ice svn lucid wait'1'; zplg snippet PZT::modules/gpg

zplg ice wait'1' as"completion" lucid
zplg snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker
zplg ice wait'1' as"completion" lucid
zplg snippet https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/terraform/_terraform

zplg light mafredri/zsh-async
zplg ice depth'1'; zplg light denysdovhan/spaceship-prompt

zplg ice svn wait'0' lucid atinit"local ZSH_CACHE_DIR=~/.cache"
zplg snippet OMZ::plugins/fasd

zplg ice lucid wait'1'
zplg light davidparsson/zsh-pyenv-lazy
# zplg ice svn wait'2' silent; zplg snippet OMZ::plugins/pyenv

zplg ice svn silent; zplg snippet OMZ::plugins/vi-mode

zplg ice wait"0" blockf lucid
zplg light zsh-users/zsh-completions

zplg light zsh-users/zsh-history-substring-search
  zmodload zsh/terminfo
  [ -n "${terminfo[kcuu1]}" ] && bindkey "${terminfo[kcuu1]}" history-substring-search-up
  [ -n "${terminfo[kcud1]}" ] && bindkey "${terminfo[kcud1]}" history-substring-search-down
  bindkey -M emacs '^P' history-substring-search-up
  bindkey -M emacs '^N' history-substring-search-down
  bindkey -M vicmd 'k' history-substring-search-up
  bindkey -M vicmd 'j' history-substring-search-down

zplg ice wait"0" lucid; zplg load zdharma/history-search-multi-word

zplg ice lucid wait"0" atclone"sed -ie 's/fc -rl 1/fc -rli 1/' shell/key-bindings.zsh" \
  atpull"%atclone" multisrc"shell/{completion,key-bindings}.zsh" id-as"junegunn/fzf_completions" \
  pick"/dev/null"
zplg light junegunn/fzf

zplg ice wait"0" lucid; zplg light marzocchi/zsh-notify

# Colors
zplg ice atclone"dircolors -b src/dir_colors > c.zsh" \
            atpull'%atclone' \
            pick"c.zsh" \
            nocompile'!'
zplg load arcticicestudio/nord-dircolors

zplg light 'chrissicool/zsh-256color'
zplg ice pick"async.sh" src"scripts/base16-chalk.sh"
zplg light "chriskempson/base16-shell"

zplg ice lucid wait'0' \
	    src'bash/base16-chalk.config' \
	    pick'bash/base16-chalk.config' nocompile'!'
zplg light 'nicodebo/base16-fzf'

zplg ice wait"1" atinit"zpcompinit; zpcdreplay" lucid
zplg light zdharma/fast-syntax-highlighting

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

export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd -t d ."
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
export HOMEBREW_NO_ANALYTICS=1

SPACESHIP_PROMPT_SEPARATE_LINE=false
SPACESHIP_PROMPT_ORDER=(dir host vi_mode jobs char)
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
SPACESHIP_RPROMPT_ORDER=(terraform kubecontext venv git exit_code)
