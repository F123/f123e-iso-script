setopt singlelinezle
~/.automated_script.sh
flock -n /run/talk-to-me.lck talk-to-me
wget http://public.f123.org/experimental/f123e.sh >& /dev/null || exit 0
chmod u+x f123e.sh
~/f123e.sh
