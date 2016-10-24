setopt singlelinezle
~/.automated_script.sh
	flock -n /run/talk-to-me.lck talk-to-me
