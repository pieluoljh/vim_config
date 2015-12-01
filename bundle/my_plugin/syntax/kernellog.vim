 " writen by yalin.wang@sonymobile.com  call me , if  you found any bug!!

if exists("b:current_syntax")
    finish
endif

if !has('gui_running') && &t_Co < 256
    setlocal t_Co=256
endif

" Particular settings
setlocal nonumber
"colorscheme default
let b:ft=&ft
if exists('&colorcolumn')
    setlocal colorcolumn&
endif
let b:matches = getmatches()
au BufWinEnter * if exists('b:ft') && b:ft == "kernellog" | call clearmatches() | endif
au BufWinLeave * if exists('b:ft') && b:ft == "kernellog" | call setmatches(b:matches) | endif

highlight Normal guibg=Black guifg=White

" Define regions
" syn region reg_date start="^" end="$" fold transparent contains=log_level,log_time
syn region log_data start="\v^\<\d\>" end="\v$" fold transparent contains=log_tag0,
			\log_tag1,llog_tag2,log_tag3,log_tag4,log_tag5,log_tag6,log_tag7 keepend

syn match log_time contained "\v\<\d\>\zs\[\s*\d+\.\d+\]"
syn match log_tag0 "\v^\<0\>.*$" containedin=log_data contains=log_time
syn match log_tag1 "\v^\<1\>.*$" containedin=log_data contains=log_time
syn match log_tag2 "\v^\<2\>.*$" containedin=log_data contains=log_time
syn match log_tag3 "\v^\<3\>.*$" containedin=log_data contains=log_time
syn match log_tag4 "\v^\<4\>.*$" containedin=log_data contains=log_time
syn match log_tag5 "\v^\<5\>.*$" containedin=log_data contains=log_time
syn match log_tag6 "\v^\<6\>.*$" containedin=log_data contains=log_time
syn match log_tag7 "\v^\<7\>.*$" containedin=log_data contains=log_time

hi def KERN_EMERG_cloor  ctermfg=white guifg=white ctermbg=darkred guibg=darkred
hi def KERN_ALERT_cloor  ctermfg=white guifg=white ctermbg=red guibg=red
hi def KERN_CRIT_cloor   ctermfg=white guifg=white ctermbg=brown guibg=brown
hi def KERN_ERR_cloor    ctermfg=red guifg=red
hi def KERN_WARNIN_cloor ctermfg=brown guifg=brown
hi def KERN_NOTICE_cloor ctermfg=darkmagenta guifg=darkmagenta
hi def KERN_INFO_cloor   ctermfg=darkgreen guifg=darkgreen
hi def KERN_DEBUG_cloor  ctermfg=green guifg=green
hi def log_time_color    ctermfg=black ctermbg=darkgrey guibg=darkgrey guifg=black

hi def link log_tag0 KERN_EMERG_cloor
hi def link log_tag1 KERN_ALERT_cloor
hi def link log_tag2 KERN_CRIT_cloor
hi def link log_tag3 KERN_ERR_cloor
hi def link log_tag4 KERN_WARNIN_cloor
hi def link log_tag5 KERN_NOTICE_cloor
hi def link log_tag6 KERN_INFO_cloor
hi def link log_tag7 KERN_DEBUG_cloor
hi def link log_time log_time_color
