function test_for_program {
	TEST_RES="$( which $* 2>&1 )"
	TEST_NO1="$( echo "$TEST_RES" | cut -b 1-3 )"
	TEST_NO2="$( echo "$TEST_RES" | cut -d : -f 2 | cut -b 2-4 )"
	TEST_NO3="$( echo "$TEST_RES" | grep "command not found" )"
	if [ "$TEST_NO1" == "no " ] || [ "$TEST_NO2" == "no " ] || [ ! -z "$TEST_NO3" ]; then
		return 0;
	fi
	return 1;
}

alias del='gvfs-trash'
alias dir='ls -lF --color=auto'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias ls='ls -F --color=auto'
alias screen='screen -xRR'

test_for_program 'less'
if [ $? != 0 ]; then
	export PAGER=less
else
	alias less=more
fi

test_for_program 'vim'
if [ $? != 0 ]; then
	alias vi='vim'
fi


# Below are the color init strings for the basic file types. A color init
# string consists of one or more of the following numeric codes:
# Attribute codes:
# 00=none 01=bold 04=underscore 05=blink 07=reverse 08=concealed
# Text color codes:
# 30=black 31=red 32=green 33=yellow 34=blue 35=magenta 36=cyan 37=white
# Background color codes:
# 40=black 41=red 42=green 43=yellow 44=blue 45=magenta 46=cyan 47=white
LS_COLORS="no=00" # global default; everything should override this
LS_COLORS="${LS_COLORS}:fi=00" # file
LS_COLORS="${LS_COLORS}:di=01;34" # directory
LS_COLORS="${LS_COLORS}:ln=01;36" # symbolic link; if set to "target" then it inherits the color of the file to which it points
LS_COLORS="${LS_COLORS}:pi=40;33" # pipe / FIFO
LS_COLORS="${LS_COLORS}:so=01;35" # socket
LS_COLORS="${LS_COLORS}:do=40;33;01" # door
LS_COLORS="${LS_COLORS}:bd=40;33;01" # block devide driver
LS_COLORS="${LS_COLORS}:cd=40;33;01" # character device driver
LS_COLORS="${LS_COLORS}:or=01;05;37;41" # symlink to non-stat'able file
LS_COLORS="${LS_COLORS}:mi=01;05;37;41" # missing?
LS_COLORS="${LS_COLORS}:su=37;41" # setuid (u+s)
LS_COLORS="${LS_COLORS}:sg=30;43" # setgid (g+s)
LS_COLORS="${LS_COLORS}:tw=30;42" # sticky, other-writable dir (+t,o+w)
LS_COLORS="${LS_COLORS}:ow=30;42" # other-writable dir (o+w)
LS_COLORS="${LS_COLORS}:st=37;44" # sticky dir (+t)
LS_COLORS="${LS_COLORS}:ex=01;32" # executable file
#LS_COLORS="${LS_COLORS}:lc=" # LEFTCODE
#LS_COLORS="${LS_COLORS}:rc=" # RIGHTCODE
#LS_COLORS="${LS_COLORS}:ec=" # ENDCODE
#LS_COLORS="${LS_COLORS}:wo=" # WRITEOTHERS (dirs)
#LS_COLORS="${LS_COLORS}:wt=" # WRITEOTHERSTICKY

# per extension settings
# -- executables are bright green
for T in bat btm cmd com csh exe sh; do
	LS_COLORS="${LS_COLORS}:*.${T}=01;32"
done
# -- archives are bright red
for T in 7z ace arj bz bz2 cpio deb dz gz jar lzh lzma rar rpm rz svgz tar taz tbz2 tgz tz z Z zip zoo; do
	LS_COLORS="${LS_COLORS}:*.${T}=01;31"
done
# -- images are bright magenta
for T in asf avi bmp dl flc fli gif gl jpeg jpg m2v m4v mkv mng mov mp4 mp4v mpeg mpg nuv ogm pbm pcx pgm png ppm qt rm rmvb svg tga tif tiff vob wmv xbm xcf xpm xwd yuv; do
	LS_COLORS="${LS_COLORS}:*.${T}=01;35"
done
# -- html, php are bright yellow
for T in htm html php; do
	LS_COLORS="${LS_COLORS}:*.${T}=01;33"
done
# -- audio files are bright cyan
for T in aac au flac mid midi mka mp3 mpc ogg ra wav; do
	LS_COLORS="${LS_COLORS}:*.${T}=01;36"
done
export LS_COLORS

HISTCONTROL=ignoreboth
HISTFILE=/home/fidian/.bash_history
HISTFILESIZE=500
HISTSIZE=500
export HISTCONTROL HISTFILE HISTFILESIZE HISTSIZE

# Color Variables for Prompt
NONE='\[\033[00m\]'
HBLU='\[\033[01;34m\]'
GRN='\[\033[00;32m\]'
YEL='\[\033[00;33m\]'
PRPL='\[\033[00;35m\]'
RED='\[\033[00;31m\]'

if [ "`whoami`" == "root" ]; then
	export PS1=$GRN'\A'$NONE' '$PRPL'\h'$NONE':'$HBLU'\w'$RED'#'$NONE' '
else
	export PS1=$GRN'\A'$NONE' '$PRPL'\h'$NONE':'$HBLU'\w'$NONE'\$ '
fi
export PS2=$YEL'>'$NONE' '
export PS3=$YEL'#?'$NONE' '
export PS4=$YEL'+'$NONE' '

