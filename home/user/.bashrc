
case $- in
  *i*)
  ;;
  *)
    return
  ;;
esac

shopt -s histappend
shopt -s checkwinsize
shopt -s globstar

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]
  then debian_chroot=$(cat /etc/debian_chroot)
fi

case "$TERM" in
  xterm-color|xterm-256color|screen-color|screen-256color)
    color_prompt=yes
  ;;
  *)
    if [ -n "$force_color_prompt" ]; then
      if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null
        then color_prompt=yes
        else color_prompt=
      fi
    fi
  ;;
esac

if [ "$color_prompt" = yes ]; then
  PS1="\[\033[1;32m\]\u \[\033[0;34m\]\w\[\033[00m\]"
  PS1+="\[\033[0;35m\]\$(__git_ps1)\[\033[00m\]"
  PS1+="\[\033[1;32m\] → \[\033[00m\]"
else
  PS1='${debian_chroot:+(
    $debian_chroot
  )}\u@\h:\w\$ '
fi

unset force_color_prompt
unset -f ___bashrc_color_prompt_set_git_information_ps1
unset -f ___bashrc_color_prompt_set_base_ps1
unset color_prompt

case "$TERM" in
  xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
  ;;
esac

if ! shopt -oq posix; then
  [ -f $HOME/.bash_completion ] && . $HOME/.bash_completion
  [ -f /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion
  [ -f /etc/bash_completion ] && . /etc/bash_completion
fi

[ -f $HOME/.bash_private ] && . $HOME/.bash_private
[ -f $HOME/.bash_functions ] && . $HOME/.bash_functions
[ -f $HOME/.bash_environment ] && . $HOME/.bash_environment
[ -f $HOME/.bash_aliases ] && . $HOME/.bash_aliases

# Just incase you decide that you would prefer a directory of them.
[ -d $HOME/.bash_functions ] && for file in $HOME/.bash_functions/{*,**/*}; do
  if [ -f "$f" ]; then . $file; fi
done
