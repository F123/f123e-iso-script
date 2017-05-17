setopt singlelinezle
	flock -n /run/talk-to-me.lck talk-to-me
~/.automated_script.sh

play /usr/share/livecd-sound/sounds/uke.mp3 2> /dev/null

