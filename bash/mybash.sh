# sendemail.smtpserver=smtp.googlemail.com
# sendemail.smtpuser=yalin.wang2010@gmail.com
# sendemail.smtpserverport=587
# sendemail.smtpencryption=tls
# sendemail.smtppass
# core.excludesfile=~/.gitignore_global
# commit.template=/Users/yalin1/.git_template.txt

# git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
# git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
# git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git
# git://android.git.linaro.org/platform/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9
# http://releases.linaro.org/14.09/components/toolchain/binaries/gcc-linaro-aarch64-linux-gnu-4.9-2014.09_linux.tar.xz
# export AARCH64_PREFIX=$HOME/aarch64-linux-android-4.9/bin/aarch64-linux-android-
export AARCH64_PREFIX=$HOME/gcc-linaro-aarch64-linux-gnu-4.9-2014.09_linux/bin/aarch64-linux-gnu-

function cgit() {
	if (git rev-parse --show-toplevel); then
		cd $(git rev-parse --show-toplevel)
		return 0
	fi
	return 1
}

function git_ref() {
	(
		cgit
		# c:/cygwin/home/yalin/work/mav13/.git/objects
		echo "$@" >> .git/objects/info/alternates
	)
}

function auto_sync() {
	if [ -n "$*" ]; then
		for i in "$@"; do
			for d in ` find "$i" -name .git -type d -maxdepth 3 `; do
				( echo "sync $d"; cd `dirname "$d"` && git pull; )
			done
		done

	fi
}

function gen_kernel_tag() {
	(
		cgit
		make tags "ALLSOURCE_ARCHS=arm arm64"
		make cscope "ALLSOURCE_ARCHS=arm arm64"
	)
}

function my_find() {
	local path="$1"
	shift
	find "$path" \( -type d \( -name .svn -o -name .git \) -prune \) -o "$@"
}

function my_git_status() {
	git status -s "$@" | awk '{print $2}'
}

function gen_tags() {
	(
		cgit
		echo "GEN cscope"
		my_find . -type f \( -name '*.java' -o -name '*.[mchxsS]' -o -name '*.cpp' \
			-o -name '*.py' -o -name '*.pl' -o -name '*.cmm' -o -name '*.xml' \
			-o -name 'SConscript' -o -name 'Make*' -o -name '*.sh' -o -name '*.scl' \
			-o -name '*.cmd' -o -name '*.scons' -o -name "Kconfig" \) > cscope.files
		cscope -b -q -k
		echo "GEN ctags"
		ctags -R --langmap=python:+\(SConscript\) --tag-relative=yes --c++-kinds=+p --fields=+iaS --extra=+q --sort=foldcase --tag-relative=yes --exclude=.git --exclude=.repo .
	)

}
function make_kernel_x86_64() {
	(
		cgit
		# ppa:ubuntu-toolchain-r/test
		make O=../kernel_out_x86_64 ARCH=x86_64 CC=gcc-5 "$@"
	)
}

function make_kernel_x86() {
	(
		cgit
		make O=../kernel_out_x86 ARCH=x86 CC=gcc-5 "$@"
	)
}

function make_kernel_arm() {
	(
		cgit
		make O=../kernel_out_arm CROSS_COMPILE=arm-none-eabi- ARCH=arm "$@"
	)
}

function make_kernel_arm64() {
	(
		cgit
		make O=../kernel_out_arm64 CROSS_COMPILE=$AARCH64_PREFIX ARCH=arm64 "$@"
	)
}

function check_patch() {
	$(git rev-parse --show-toplevel)/scripts/checkpatch.pl "$@"
	return $?
}

function get_maintainer() {
	$(git rev-parse --show-toplevel)/scripts/get_maintainer.pl "$@"
	return $?
}

function get_email() {
	local OPTIND opt prefix suffix
	prefix=''
	suffix=''
	while getopts p:s: opt; do
		case $opt in
			p)
				prefix="$OPTARG"
				;;
			s)
				suffix="$OPTARG"
				;;
			\?)
				echo "ivnalid options"
				return 1
				;;
		esac
	done
	shift $((OPTIND-1))
	if [ -z "$*" ]; then
		local cmd="`cat << END
import re
import sys
email=[]
for l in sys.stdin:
	email.extend(re.findall(r'[-\w.]+@[-\w.]+', l))
email=' '.join(email)
email=re.sub(r'([-\w.]+@[-\w.]+)', r"$prefix\1$suffix", email)
print(email)
END
`"
		python -c "$cmd"
	else
		python << END
import re
email=' '.join(re.findall(r'[-\w.]+@[-\w.]+', r'''$@'''))
email=re.sub(r'([-\w.]+@[-\w.]+)', r"$prefix\1$suffix", email)
print(email)
END
	fi
}

function my_sendpatch() {
	local option file force
	for o in "$@"; do
		case $o in
			-f)
			force="true"
			;;
			-*)
			option="$option $o"
			;;
			*)
			file="$file $o"
			;;

		esac
	done

	if (check_patch $file) || [ -n "$force" ]; then
		git send-email `get_maintainer $file | get_email -p --to=` $option $file
	else
		echo "check_patch failed.."
		return 1
	fi
}
explain () {
  if [ "$#" -eq 0 ]; then
    while read  -p "Command: " cmd; do
      curl -Gs "https://www.mankier.com/api/explain/?cols="$(tput cols) --data-urlencode "q=$cmd"
    done
    echo "Bye!"
  elif [ "$#" -eq 1 ]; then
    curl -Gs "https://www.mankier.com/api/explain/?cols="$(tput cols) --data-urlencode "q=$1"
  else
    echo "Usage"
    echo "explain                  interactive mode."
    echo "explain 'cmd -o | ...'   one quoted command to explain it."
  fi
}

export T32SYS=$HOME/T32
export T32TMP=$HOME/tmp
export T32ID=T32
export PATH=$PATH:~/arm-cs-tools/bin:/usr/local/opt/llvm/bin
export mysymbols="/Users/yalin1/Library/Developer/Xcode/iOS DeviceSupport/8.3 (12F66)/Symbols/"
export mywin_work="/Volumes/C/cygwin/home/yalin/work"
export US_aprica="/SWE/Teams/Baseband/bbconfiguration/aprica"
alias mountB='~luna/bin/mountebuild'
export PYTHONSTARTUP="$(dirname ${BASH_SOURCE[0]})/.pythonrc"

function rsync_from_device() {
	rsync -av "rsync://root@localhost:10873/root/$1" "$2"
}

function rsync_to_device() {
	rsync -av "$1" "rsync://root@localhost:10873/root/$2"
}

function mywork() {
	cd "$mywin_work"
}
