autoload -U promptinit compinit
promptinit
compinit
prompt walters

export HISTFILE=~/.zsh_history
export HISTSIZE=50000
export SAVEHIST=50000

eval `dircolors`

#bindkey '^[[3~^' delete-char
bindkey    "\e[3~"    delete-char

##################################################################
# Stuff to make my life easier

# allow approximate
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# tab completion for PID :D
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always

# cd not select parent dir. 
zstyle ':completion:*:cd:*' ignore-parents parent pwd

# Skip history
setopt hist_ignore_space
setopt hist_ignore_dups   

# Correct commands
#setopt correctall

# PS1
export PS1="$(print '%{\e[1;31m%}$%{\e[0m%}:>')"


#Alias
alias ls='ls --color=auto -F'
alias cd..='cd ..'
alias py='python'
alias dvd='cd /media/dvd'
alias mplayerff='mplayer -vfm ffmpeg -lavdopts lowres=0:fast:skiploopfilter=all'
alias df='df -h'
alias mbz2='tar cjfv'
alias halt='sudo /sbin/shutdown -h now'
alias reboot='sudo /sbin/shutdown -r now'
alias cpr='cp -r'
alias userlist='awk -F":" '{ print "username: " $1 "\t\tuid:" $3 }' /etc/passwd'
alias tc='sudo truecrypt'
alias vi='vim'
alias stx='startx &> ~/startx.log'
alias cropalpha="mogrify -crop 655x974+512+0 *.jpg"

# Directorie alias
setopt auto_name_dirs # initialize named dirs automagically
hash -d data=/mnt/data
hash -d music=/mnt/trantor/Musique/
hash -d multimedia=/mnt/earth/multimedia
hash -d torrent=/mnt/earth/download/Torrents

#fortune linuxcookie

###################################################################
# Functions
###################################################################

# myip - Search current IP
function myip ()
{
	lynx -dump -hiddenlinks=ignore -nolist http://checkip.dyndns.org:8245/ | awk '{ print $4 }' | sed '/^$/d; s/^[ ]*//g; s/[ ]*$//g' 
}

# netinfo - shows network information for your system
function netinfo ()
{
	echo "--------------- Network Information ---------------"
	/sbin/ifconfig | awk /'inet addr/ {print $2}'
	/sbin/ifconfig | awk /'Bcast/ {print $3}'
	/sbin/ifconfig | awk /'inet addr/ {print $4}'
	/sbin/ifconfig | awk /'HWaddr/ {print $4,$5}'
	myip
	echo "---------------------------------------------------"
}

#shot - takes a screenshot of your current window
function shot ()
{
	import -frame -strip -quality 75 "$HOME/capture-$(date +%s).png"
}

propstring () {
  echo -n 'Property '
  xprop WM_CLASS | sed 's/.*"\(.*\)", "\(.*\)".*/= "\1,\2" {/g'
  echo '}'
}

#extract - extract all file
function extract () {
     if [ -f $1 ] ; then
         case $1 in
             *.tar.bz2)   tar xjf $1        ;;
             *.tar.gz)    tar xzf $1     ;;
             *.bz2)       bunzip2 $1       ;;
             *.rar)       unrar x $1     ;;
             *.gz)        gunzip $1     ;;
             *.tar)       tar xf $1        ;;
             *.tbz2)      tar xjf $1      ;;
             *.tgz)       tar xzf $1       ;;
             *.zip)       unzip $1     ;;
             *.Z)         uncompress $1  ;;
             *.7z)        7z x $1    ;;
			 *.lzh)	  lha x $1    ;;
			 *.tar.xz)	  tar xfJv $1 ;;
             *)           echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}

function cdl () {
	cd $1 && ls
}

function encode () {
     if [ -f $1 ] ; then
         ffmpeg -i $1 -vcodec libx264 -acodec copy $2.mp4
     else
         echo "'$1' is not a valid file"
     fi
}

function zhist() {
    cat ~/.zsh_history | grep $1
}
