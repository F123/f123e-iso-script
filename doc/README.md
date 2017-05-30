
# Notes

At the moment this file is for my notes while i put together the build-system for the Arch Linux 
version of F123e.

## Custom Repository

Using the `repo-add` command:

	repo-add /path/to/repo.db.tar.gz /path/to/*.pkg.tar.xz

Each subsequent call to repo-add does not append, it overwrites.

*.pkg.tar.xz package files *MUST* be in the same directory as the db.

The name of the db file must match what is between square-brackets in pacman.conf.



## Git Tagging

List tags:

	git tag

Annotated tag creation:

	git tag -a v1.4 -m "my version 1.4"

If you don't give the `-m` switch git opens the editor for your message.

Show everything about a tag:

	git show v1.4


