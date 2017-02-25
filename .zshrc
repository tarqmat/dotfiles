# alias vi="nvim"
alias ls="ls -G"
alias ll="ls -la"

setopt auto_menu
setopt auto_name_dirs
setopt auto_remove_slash
setopt auto_param_keys
setopt auto_param_slash
setopt auto_pushd
setopt no_beep
setopt no_case_glob
setopt complete_in_word
setopt correct
setopt extended_glob
setopt extended_history
setopt no_flow_control
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt list_packed
setopt list_types
setopt magic_equal_subst
setopt print_eight_bit
setopt pushd_ignore_dups
setopt rm_star_silent
setopt sh_word_split

if [[ -f $HOME/.zplug/init.zsh ]]; then
  source ~/.zplug/init.zsh

  zplug 'zplug/zplug', hook-build:'zplug --self-manage'
  zplug "zsh-users/zsh-syntax-highlighting", defer:3
  zplug "zsh-users/zsh-completions"
  zplug "zsh-users/zsh-history-substring-search"
  zplug "bhilburn/powerlevel9k", use:powerlevel9k.zsh-theme

  if ! zplug check --verbose; then
    printf "[zplug] Install plugins? [y/N]: "
    if read -q; then
      echo; zplug install
    fi
  fi

  zplug load
fi


# Powerlevel9k
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(context status history time)
POWERLEVEL9K_STATUS_VERBOSE=false
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_middle"
POWERLEVEL9K_SHORTEN_DIR_LENGTH=3

function chpwd() { ll }

# based on http://qiita.com/b4b4r07/items/01359e8a3066d1c37edc
function is_exists() { type "$1" >/dev/null 2>&1; return $?; }
function is_osx() { [[ $OSTYPE == darwin* ]]; }
function is_screen_running() { [ ! -z "$STY" ]; }
function is_tmux_runnning() { [ ! -z "$TMUX" ]; }
function is_screen_or_tmux_running() { is_screen_running || is_tmux_runnning; }
function shell_has_started_interactively() { [ ! -z "$PS1" ]; }
function is_ssh_running() { [ ! -z "$SSH_CONECTION" ]; }
function tmux_automatically_attach_session()
{
  if is_screen_or_tmux_running; then
    ! is_exists 'tmux' && return 1

    if is_tmux_runnning; then
      echo "${fg_bold[red]} [--<TMUX>--<TMUX>--<TMUX>--<TMUX>--<TMUX>--<TMUX>--<TMUX>--<TMUX>--<TMUX>] ${reset_color}"
    elif is_screen_running; then
      echo "This is on screen."
    fi
  else
    if shell_has_started_interactively && ! is_ssh_running; then
      if ! is_exists 'tmux'; then
        echo 'Error: tmux command not found' 2>&1
        return 1
      fi

      if tmux has-session >/dev/null 2>&1 && tmux list-sessions | grep -qE '.*]$'; then
        # detached session exists
        tmux list-sessions
        echo -n "Tmux: attach? (y/N/num) "
        read
        if [[ "$REPLY" =~ ^[Yy]$ ]] || [[ "$REPLY" == '' ]]; then
          tmux attach-session
          if [ $? -eq 0 ]; then
            echo "$(tmux -V) attached session"
            return 0
          fi
        elif [[ "$REPLY" =~ ^[0-9]+$ ]]; then
          tmux attach -t "$REPLY"
          if [ $? -eq 0 ]; then
            echo "$(tmux -V) attached session"
            return 0
          fi
        fi
      fi

      if is_osx && is_exists 'reattach-to-user-namespace'; then
        # on OS X force tmux's default command
        # to spawn a shell in the user's namespace
        tmux_config=$(cat $HOME/.tmux.conf <(echo 'set-option -g default-command "reattach-to-user-namespace -l $SHELL"'))
        tmux -f <(echo "$tmux_config") new-session && echo "$(tmux -V) created new session supported OS X"
      else
        tmux new-session && echo "tmux created new session"
      fi
    fi
  fi
}
tmux_automatically_attach_session
