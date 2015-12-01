fun! s:DetectLogcat()
	" Detect from first line
	if getline(1) =~# '\v^\<\d\>\[\s*\d+\.\d+\]' ||
		\getline(2) =~# '\v^\<\d\>\[\s*\d+\.\d+\]'
		set filetype=kernellog
	endif
endfun

au BufNewFile,BufRead * call s:DetectLogcat()
