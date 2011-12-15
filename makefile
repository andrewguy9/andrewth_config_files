all: gitconfig vimrc

gitconfig:
	cp gitconfig ~/.gitconfig

vimrc:
	cp vimrc ~/.vimrc

.PHONY : all gitconfig vimrc
