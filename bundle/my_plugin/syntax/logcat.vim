" Vim syntax file
" Language:		logcat
" Maintainers:		Naseer Ahmed <naseer.ahmed@gmail.com>
"			Lertsenem <lertsenem@yahoo.fr>
" Latest Revision:	2013-06-19

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
au BufWinEnter * if exists('b:ft') && b:ft == "logcat" | call clearmatches() | endif
au BufWinLeave * if exists('b:ft') && b:ft == "logcat" | call setmatches(b:matches) | endif
" Define colors
"set background=dark
highlight Normal guibg=Black guifg=White
hi def log_date_color ctermfg=darkgrey ctermbg=lightgrey guibg=darkgrey guifg=lightgrey
hi def log_hour_color ctermfg=197 guifg=red
hi def log_millisec_color ctermfg=205 guifg=lightred
hi def log_num_color ctermfg=grey guifg=grey

hi def log_processNumber_color ctermfg=178 guifg=darkyellow
hi def log_processName_color cterm=bold guifg=white gui=bold

hi def dbg_color ctermbg=red guifg=red

" Violet
hi def kw_fatal_color ctermfg=177 guifg=red
hi def kw_error_color ctermfg=red guifg=darkred
hi def kw_warning_color ctermfg=130 guifg=lightred
hi def kw_info_color ctermfg=darkgreen guifg=darkgreen
hi def kw_debug_color ctermfg=lightblue guifg=SlateBlue
hi def kw_verbose_color ctermfg=grey guifg=grey



" Define matches
syn match log_date contained '\d\d-\d\d' nextgroup=log_hour skipwhite
syn match log_hour contained '\d\d:\d\d:\d\d' nextgroup=log_millisec skipwhite
syn match log_millisec contained '\.\d\d\d' nextgroup=log_num skipwhite
syn match log_num contained '\v(\[.*\])' containedin=reg_date

syn match log_processName contained '\v\C(F|E|W|I|D|V)/[a-zA-Z0-9-_\.]*\ze(\(|\s)'
    \ nextgroup=log_processNumber skipwhite contains=log_fatal,log_error,log_warning,log_info,log_debug,log_verbose
    \ containedin=reg_infos

" Define keywords
syn match log_fatal contained   '\vF\ze/'
syn match log_error contained   '\vE\ze/'
syn match log_warning contained '\vW\ze/'
syn match log_info contained    '\vI\ze/'
syn match log_debug contained   '\vD\ze/'
syn match log_verbose contained '\vV\ze/'

syn match log_processNumber contained '\v(\(.*\))' containedin=reg_infos


" Define regions
syn region reg_infos start="\v\C(F|E|W|I|D|V)/" end="\v[^0-9]\ze:" fold contained transparent contains=log_processName,log_processNumber keepend

syn region reg_fatal  excludenl  start='F/' end='$' contains=reg_infos keepend oneline
syn region reg_error  excludenl  start='E/' end='$' contains=reg_infos keepend oneline
syn region reg_warning excludenl start='W/' end='$' contains=reg_infos keepend oneline
syn region reg_info   excludenl  start='I/' end='$' contains=reg_infos keepend oneline
syn region reg_debug  excludenl  start='D/' end='$' contains=reg_infos keepend oneline
syn region reg_verbose excludenl start='V/' end='$' contains=reg_infos keepend oneline

syn region reg_date start="^" end="\v.\C\ze\s+[FEWIDV]/" fold transparent skipwhite
    \ contains=log_date,log_hour,log_millisec,log_num keepend "nextgroup=reg_fatal,reg_error,reg_warning,reg_info,reg_debug,reg_verbose

" Define links
hi def link log_date log_date_color
hi def link log_hour log_hour_color
hi def link log_millisec log_millisec_color
hi def link log_num log_num_color

hi def link log_processNumber log_processNumber_color
hi def link log_processName log_processName_color

hi def link log_fatal kw_fatal_color
hi def link log_error kw_error_color
hi def link log_warning kw_warning_color
hi def link log_info kw_info_color
hi def link log_debug kw_debug_color
hi def link log_verbose kw_verbose_color

hi def link reg_fatal kw_fatal_color
hi def link reg_error kw_error_color
hi def link reg_warning kw_warning_color
hi def link reg_info kw_info_color
hi def link reg_debug kw_debug_color
hi def link reg_verbose kw_verbose_color
