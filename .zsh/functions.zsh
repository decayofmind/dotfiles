kpst() {
  if ( $SPACESHIP_KUBECONTEXT_SHOW ); then
    export SPACESHIP_KUBECONTEXT_SHOW=false
  else
    export SPACESHIP_KUBECONTEXT_SHOW=true
  fi
}

weather() {
	curl "http://wttr.in/$1"
}

myip() {
	curl "ifconfig.co"
}

zbench() {
  for i in $(seq 1 10); do
    /usr/bin/time /usr/local/bin/zsh -i -c exit
  done
}
