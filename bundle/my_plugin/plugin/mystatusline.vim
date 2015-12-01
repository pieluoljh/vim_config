" function! Statuslineinit()

  " set statusline=
  " set statusline+=%7*%{EchoFuncGetStatusLine()}[%n]                              " buffernr
  " set statusline+=%1*\ %<%F\                                                     " File+path
  " set statusline+=%2*\ %y\                                                       " FileType
  " set statusline+=%3*\ %{''.(&fenc!=''?&fenc:&enc).''}                           " Encoding
  " set statusline+=%3*\ %{(&bomb?\",BOM\":\"\")}\                                 " Encoding2
  " set statusline+=%4*\ %{&ff}\                                                   " FileFormat (dos/unix..)
  " set statusline+=%5*\ %{&spelllang}\%{HighlightSearch()}%{&paste?'[paste]':''}\ " Spellanguage & Highlight on?
  " set statusline+=%#error#%{StatuslineLongLineWarning()}
  " set statusline+=%{StatuslineTabWarning()}
  " set statusline+=%{StatuslineTrailingSpaceWarning()}
  " set statusline+=%8*%=\ %{StatuslineCurrentHighlight()}row:%l/%L\ (%03p%%)\     " Rownumber/total (%)
  " set statusline+=%9*\ col:%03c\                                                 " Colnr
  " set statusline+=%0*\ \ %m%r%w\ %P\ %{FileSize()}\ \                            " Modified? Readonly? Top/bot.

" endfunction

function! Statuslineinit()

  set statusline=
  set statusline+=%0*\ %<%F\                                                     " File+path
  set statusline+=%0*\ %y\                                                       " FileType
  set statusline+=%0*\ %{''.(&fenc!=''?&fenc:&enc).''}                           " Encoding
  set statusline+=%0*\ %{(&bomb?\",BOM\":\"\")}\                                 " Encoding2
  set statusline+=%0*\ %{&ff}\                                                   " FileFormat (dos/unix..)
  set statusline+=%0*\ %{&spelllang}\%{HighlightSearch()}%{&paste?'[paste]':''}\ " Spellanguage & Highlight on?
  set statusline+=%0*%{StatuslineLongLineWarning()}
  set statusline+=%{StatuslineTabWarning()}
  set statusline+=%{StatuslineTrailingSpaceWarning()}
  set statusline+=%0*%=\ %{StatuslineCurrentHighlight()}row:%l/%L\ (%03p%%)\     " Rownumber/total (%)
  set statusline+=%0*\ col:%03c\                                                 " Colnr
  set statusline+=%0*\ \ %m%r%w\ %P\ %{FileSize()}\ \                            " Modified? Readonly? Top/bot.

endfunction

function! HighLightInit()

  hi User1 guifg=#000000 guibg=#7dcc7d gui=NONE ctermfg=0 ctermbg=2 cterm=NONE
  hi User2 guifg=#ffffff guibg=#ff0000 gui=bold ctermfg=15 ctermbg=9 cterm=bold
  hi User3 guifg=#ffff00 guibg=#5b7fbb gui=bold ctermfg=190 ctermbg=67 cterm=bold
  hi User4 guifg=#ffffff guibg=#810085 gui=NONE ctermfg=15 ctermbg=53 cterm=NONE
  hi User5 guifg=#ffffff guibg=#000000 ctermfg=15 ctermbg=0
  hi User6 guifg=#ffffff guibg=#ff00ff ctermfg=15 ctermbg=5
  hi User7 guifg=#ff00ff guibg=#000000 gui=bold ctermfg=207 ctermbg=0 cterm=bold
  hi User8 guifg=#000000 guibg=#00ffff gui=NONE ctermfg=0 ctermbg=51 cterm=NONE
  hi User9 guifg=#ffffff guibg=#810085 gui=bold ctermfg=200 ctermbg=0 cterm=bold
  hi User0 guifg=#ffffff guibg=#094afe gui=bold ctermfg=150 ctermbg=51 cterm=bold

endfunction


call Statuslineinit()
autocmd ColorScheme * hi StatusLine   guifg=#000000 guibg=#00ffff gui=NONE ctermfg=0 ctermbg=51 cterm=NONE
            \|hi StatusLineNC ctermfg=249 guifg=#b2b2b2 ctermbg=237 guibg=#3a3a3a cterm=none gui=none

autocmd BufWinEnter * call Statuslineinit() | call HighLightInit()
hi StatusLine   guifg=#000000 guibg=#00ffff gui=NONE ctermfg=0 ctermbg=51 cterm=NONE
hi StatusLineNC ctermfg=249 guifg=#b2b2b2 ctermbg=237 guibg=#3a3a3a cterm=none gui=none

function! HighlightSearch()
  if &hls
    return 'H'
  else
    return ''
  endif
endfunction

function! FileSize()
  let bytes = getfsize(expand("%:p"))
  if bytes <= 0
    return ""
  endif
  if bytes < 1024
    return bytes
  else
    return (bytes / 1024) . "K"
  endif
endfunction

"recalculate the trailing whitespace warning when idle, and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning

"return '[\s]' if trailing white space is detected
"return '' otherwise
function! StatuslineTrailingSpaceWarning()
    if !exists("b:statusline_trailing_space_warning")

        if !&modifiable
            let b:statusline_trailing_space_warning = ''
            return b:statusline_trailing_space_warning
        endif

        if search('\s\+$', 'nw') != 0
            let b:statusline_trailing_space_warning = '[\s]'
        else
            let b:statusline_trailing_space_warning = ''
        endif
    endif
    return b:statusline_trailing_space_warning
endfunction


"return the syntax highlight group under the cursor ''
function! StatuslineCurrentHighlight()
    let name = synIDattr(synID(line('.'),col('.'),1),'name')
    if name == ''
        return ''
    else
        return '[' . name . ']'
    endif
endfunction

"recalculate the tab warning flag when idle and after writing
autocmd cursorhold,bufwritepost * unlet! b:statusline_tab_warning

"return '[&et]' if &et is set wrong
"return '[mixed-indenting]' if spaces and tabs are used to indent
"return an empty string if everything is fine
function! StatuslineTabWarning()
    if !exists("b:statusline_tab_warning")
        let b:statusline_tab_warning = ''

        if !&modifiable
            return b:statusline_tab_warning
        endif

        let tabs = search('^\t', 'nw') != 0

        "find spaces that arent used as alignment in the first indent column
        let spaces = search('^ \{' . &ts . ',}[^\t]', 'nw') != 0

        if tabs && spaces
            let b:statusline_tab_warning =  '[mixed-indenting]'
        elseif (spaces && !&et) || (tabs && &et)
            let b:statusline_tab_warning = '[&et]'
        endif
    endif
    return b:statusline_tab_warning
endfunction

"recalculate the long line warning when idle and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_long_line_warning

"return a warning for "long lines" where "long" is either &textwidth or 80 (if
"no &textwidth is set)
"
"return '' if no long lines
"return '[#x,my,$z] if long lines are found, were x is the number of long
"lines, y is the median length of the long lines and z is the length of the
"longest line
function! StatuslineLongLineWarning()
    if !exists("b:statusline_long_line_warning")

        if !&modifiable
            let b:statusline_long_line_warning = ''
            return b:statusline_long_line_warning
        endif

        let long_line_lens = s:LongLines()

        if len(long_line_lens) > 0
            let b:statusline_long_line_warning = "[" .
                        \ '#' . len(long_line_lens) . "," .
                        \ 'm' . s:Median(long_line_lens) . "," .
                        \ '$' . max(long_line_lens) . "]"
        else
            let b:statusline_long_line_warning = ""
        endif
    endif
    return b:statusline_long_line_warning
endfunction

"return a list containing the lengths of the long lines in this buffer
function! s:LongLines()
    let threshold = (&tw ? &tw : &cc ? &cc : 80)
    let spaces = repeat(" ", &ts)
    let line_lens = map(getline(1,'$'), 'len(substitute(v:val, "\\t", spaces, "g"))')
    return filter(line_lens, 'v:val > threshold')
endfunction

"find the median of the given array of numbers
function! s:Median(nums)
    let nums = sort(a:nums)
    let l = len(nums)

    if l % 2 == 1
        let i = (l-1) / 2
        return nums[i]
    else
        return (nums[l/2] + nums[(l/2)-1]) / 2
    endif
endfunction
