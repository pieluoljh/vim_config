" writen by yalin.wang@sonymobile.com  call me , if  you found any bug!!

" Set Common {{{1
set nocompatible                    "关闭 VI 兼容模式
let g:my_vimrc_path = fnamemodify(resolve(expand('<sfile>:p')), ':h')
let g:my_vimrc_file = fnamemodify(resolve(expand('<sfile>:p')), ':p')
execute "set rtp+=".g:my_vimrc_path

if (has("win32") || has("win64") || has("win32unix"))
	let g:isWin = 1
else
	let g:isWin = 0
endif


let g:pathogen_disabled = []
" call add(g:pathogen_disabled, "neosnippet")
" call add(g:pathogen_disabled, "python-mode")

call pathogen#infect()
call pathogen#incubate("after")
call pathogen#helptags()

if g:isWin
	let $PATH = g:my_vimrc_path . "/bin/windows" . ";" . $PATH
else
	let $PATH = g:my_vimrc_path. "/bin/linux" . ":" . $PATH
endif

" 依次尝试使用该列表编码,如果成功,则设置fileencoding为该值,失败使用encoding的值
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set fileencoding=utf-8              " 设置此缓冲区所在文件的字符编码
set encoding=utf-8                  " 设置 Vim 内部使用的字符编码
set fileformat=unix                 " 给出当前缓冲区的 <EOL> 格式
set nobomb                          " 不使用 Unicode签名
set shortmess=atI                   " 启动的时候不显示那个援助索马里儿童的提示
" set ssl                             " 路径中使用正斜线
set tags+=./tags;
set clipboard=autoselect,unnamed,exclude:.*              " 与Windows共享剪贴板
set helplang=cn,en                  " 使用中文帮助
set whichwrap=s,<,>,[,]             " 光标从行首和行末可以跳到另一行
set sessionoptions-=curdir          " 不保存/恢复当前目录
set sessionoptions+=sesdir          " 保存/恢复会话文件所在的目录会成为当前目录
set number                          " 显示行号
set showmatch                       " 插入括号时,短暂地跳转到匹配的对应括号
set tabstop=8                       " 设定 tab 长度为 8
set softtabstop=8                   " 使得按退格键时可以一次删掉 8 个空格
set shiftwidth=8                    " 设定 << 和 >> 命令移动时的宽度为 8
set noexpandtab                       " /
set smarttab                        " /
set si                              " 开启新行时使用智能自动缩进 (smartindent)
"set wrap                            " 改变文本显示的方式,超过窗口宽度的行将回绕
set hi=400                          " 历史记录数 (history)
" set nolz                            " 关闭延迟重画 (lazyredraw)
set so=7                            " 光标上下两侧最少保留的屏幕行数 (scrolloff)
set cmdheight=2                     " 命令行使用的屏幕行数
set laststatus=2                    " 总是显示状态行
set hidden                          " Change buffer - without saving
"set noerrorbells                   " 关闭错误信息响铃(默认关闭)
"set novisualbell                   " 关闭可视响铃代替鸣叫,置空错误铃声的终端代码(默认关闭)
set t_vb=                           " 置空错误铃声的终端代码
set showcmd                         " 在屏幕最后一行显示(部分的)命令
set mat=4                           " 显示配对括号的十分之一秒数(matchtime)
set nobackup                        " /
set nowb                            " / 关闭备份
set noswapfile                      " /
set backspace=start,indent,eol      " 使回格键（backspace）正常处理indent, eol, start等
set ignorecase
" set smartcase                       " smartcase
set incsearch                       " 输入搜索内容时就显示搜索结果
set completeopt=menu,menuone,longest
set wildmenu                        " 增强模式中的命令行自动完成操作
set wildmode=longest:full,full      " 使用最大公共串补全,如果结果未变长,使用完成匹配补全
set formatoptions+=tcroql           " 控制 Vim 如何对文本进行排版
"set textwidth=80                   " 插入文本的最大宽度
"set cursorline                     " 突出显示当前行
"set cursorcolumn                   " 突出显示当前列
set viminfo='100,:200,<50,s10,h,n~/.viminfo     " 初始化时读入 viminfo 文件，退出 Vim 时写回
set foldenable                      " 开启折叠
set foldmethod=manual               " 手动建立折叠
"set foldmethod= marker             " 标志用于折叠
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<,nbsp:.         " 设置tab,eol字符
"set keywordprg=pman
set ambiwidth=single                " 对"不明宽度"字符的的宽度设置为双倍字符宽度(中文字符宽度)
"set autoread                       " 当文件在VIM之外修改过,VIM里面没有的话,重新载入
set report=0                        " 报告改变行数的阈值,0时总是得到消息
set diffopt+=vertical,context:3     " diff模式选项(垂真分割,差异文周围不被折叠的行数)

execute "set dictionary=" . g:my_vimrc_path . "/dict/words"
let c_gnu = 1
let c_curly_error =1
if has('mouse') && has("gui_running")
	set mouse=a                     " 在所有模式下使用鼠标
	nnoremap <silent> <2-LeftMouse> :let @/='\V\<'.escape(expand('<cword>'), '\').'\>'<cr>:set hls<cr>
endif
let mapleader = '\'                                     " 设置mapleader使用`,`代替 `\`

function! TabMessage(cmd)
	redir => message
	silent execute a:cmd
	redir END
	tabnew
	silent put=message
	set nomodified
endfunction
command! -nargs=+ -complete=command TabMessage call TabMessage(<q-args>)

function! IndentFormat(...) range
	let l:indent = ""
	let arg = "  "
	let tab = &softtabstop ? &softtabstop : &tabstop
	for item in a:000
		let arg = arg . " " . item
	endfor
	if g:isWin
		if !executable("indent.exe")
			echoerr "Don't install indent.exe.... abort!"
			return
		endif
		let l:indent = "indent.exe"
	else
		if !executable("indent")
			echoerr "Don't install indent.... abort!"
			return
		endif
		let l:indent = "indent"
	endif
	execute a:firstline . "," . a:lastline . "!" . l:indent . " -linux -npro" .
				\ (&expandtab? (" --no-tabs  --tab-size" .
				\ tab . " -i" . tab) :
				\"  ") . arg

	let pos = getpos(".")
	execute "normal ". a:firstline."G"
	execute "normal =".a:lastline."G"
	call setpos(".", pos)

endfunction

com! -nargs=* -range=% LinuxKernelFormat <line1>,<line2> call IndentFormat("-ut -ts8 -i8 -il0 -cp1 -cbi0", <q-args>)
com! -nargs=* -range=% AndroidFormat
			\ if &ft == "cpp" | <line1>,<line2>call IndentFormat("-nut -ts4 -i4 -brf", <q-args>)|
			\ else | <line1>,<line2>call IndentFormat("-nut -ts4 -i4 -blf", <q-args>) | endif

let g:my_tab=4
" allow toggling between local and default mode
function! TabToggle()
  if &expandtab
    set shiftwidth=8
    set softtabstop=0
    set noexpandtab
  else
    execute "set shiftwidth=".g:my_tab
    execute "set softtabstop=".g:my_tab
    set expandtab
  endif
endfunction
nmap <F12> :execute TabToggle()<CR>

function! DeleteInactiveBufs(bang)
    "From tabpagebuflist() help, get a list of all buffers in all tabs
    let tablist = []
    for i in range(tabpagenr('$'))
        call extend(tablist, tabpagebuflist(i + 1))
    endfor

    "Below originally inspired by Hara Krishna Dara and Keith Roberts
    "http://tech.groups.yahoo.com/group/vim/message/56425
    let nWipeouts = 0
    for i in range(1, bufnr('$'))
        if bufexists(i) && (!getbufvar(i,"&mod") || a:bang == "!") && index(tablist, i) == -1
        "bufno exists AND isn't modified AND isn't in the list of buffers open in windows and tabs
            silent exec 'bwipeout!' i
            let nWipeouts = nWipeouts + 1
        endif
    endfor
    echomsg nWipeouts . ' buffer(s) wiped out'
endfunction
command! -bang Bdi :call DeleteInactiveBufs("<bang>")

call clearmatches()


if g:isWin
	language messages zh_cn.utf-8       " 设置当前语言(locale)
endif

" }}}
" Gui-running & Autocmd {{{1
" Gui-running {{{2
if has("gui_running")
	set guioptions=m                  " 使用菜单栏
	set winaltkeys=no
	"set guioptions=t                 " 使用菜单项
	"set linespace=2                  " 设置行间距
	syntax enable                     " 开启语法高亮
	set hlsearch                      " 高亮搜索字符

	if g:isWin
		set guifont=DejaVu\ Sans\ Mono:h10,SimHei:h11:cGB2312  " 设置字体
		set guifontwide=SimHei:h10:cGB2312,Yahei\ Mono:h9:cGB2312,NSimSun:h12:cGB2312
		source $VIMRUNTIME/delmenu.vim  " /
		source $VIMRUNTIME/menu.vim     " / 重置menu菜单
		au GUIEnter * simalt ~x
	else
		set guifont=DejaVu\ Sans\ Mono\ 10
	endif

	colorscheme my_molokai " 配色方案
	set columns=104
	set lines=33
else
	" 防止退出时终端乱码e
	" set t_fs=(B
	" set t_IE=(B
	syntax enable                     " 开启语法高亮
	if &term =~ "256color"
		" 在不同模式下使用不同颜色的光标
		set cursorline
		colorscheme my_molokai
	endif

	if &term =~ "xterm" || &term =~ "linux"
		" silent !echo -ne "\e]12;Green\007"
		" let &t_SI="\e]12;RoyalBlue1\007"
		" let &t_EI="\e]12;HotPink\007"
		let &t_Co=256
		" autocmd VimLeave * :!echo -ne "\e]12;green\007"
		colorscheme my_molokai
	else
		colorscheme my_molokai
		" 在Linux文本终端下非插入模式显示块状光标
		if &term == "linux"
			set t_ve+=[?6c
			autocmd InsertEnter * set t_ve-=[?6c
			autocmd InsertLeave * set t_ve+=[?6c
			autocmd VimLeave * set t_ve-=[?6c
		endif
	endif
endif


if has("autocmd")
	" Enable filetype plugin
	filetype plugin indent on

	augroup myvimrchooks
		au!
		autocmd bufwritepost _vimrc source $MYVIMRC
		autocmd bufwritepost .vimrc source $MYVIMRC
		execute "autocmd bufwritepost ".g:my_vimrc_file ." source ".g:my_vimrc_file
	augroup END

	autocmd BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|
				\exe("norm '\"")|else|exe "norm $"|endif|endif      " 保存光标位置
	autocmd BufWinEnter *
				\ if &omnifunc == "" |
				\   setlocal omnifunc=syntaxcomplete#Complete |
				\ endif

	autocmd BufWinEnter *.cmm setlocal cinkeys +=0(|
				\ setlocal cinwords=|

	function! AutocheckCC()
		let l:cc = 0
		if &ft=="c"||&ft=="cpp"
			let l:cc = 81
		elseif &ft=="gitcommit"
			let l:cc = 73
			setlocal spell
		elseif &ft=="java"
			let l:cc = 101
		endif
		if v:version >= 703
			execute "setlocal cc=" . l:cc
		endif
	endfunction

	function! AutoCheckDictionary()
		let l:file = g:my_vimrc_path . "/dict/" . &ft . ".dict"
		if filereadable(l:file)
			execute "setlocal dictionary^=" . l:file
		endif
	endfunction

	autocmd FileType * call AutocheckCC() | call AutoCheckDictionary()
	let s:default_path = escape(&path, '\ ') " store default value of 'path'
	" Always add the current file's directory to the path and tags list if not
	" already there. Add it to the beginning to speed up searches.
	autocmd BufRead *
				\ let s:tempPath=escape(escape(expand("%:p:h"), ' '), '\ ') |
				\ exec "set path-=".s:tempPath |
				\ exec "set path-=".s:default_path |
				\ exec "set path^=".s:tempPath |
				\ exec "set path^=".s:default_path
	au FilterWritePost * if &diff | set background=dark | colorscheme peaksea | else | colorscheme my_molokai | endif
	set autoindent      " 开启新行时,从当前行复制缩进距离
endif



" Plugin configuration {{{1
" javascript.vim(syntax/) {{{2
let b:javascript_fold=1             " 打开javascript折叠(层数)
let javascript_enable_domhtmlcss=1  " 打开javascript对dom、html和css的支持

"tagbar
" let g:tagbar_left = 0
map <silent> <leader>tb :TagbarToggle<CR>
map <silent> <leader>t :TagbarOpen fj<CR>
let g:tagbar_map_zoomwin = 'A'
let g:tagbar_autofocus = 1

" supertab.vim {{{2
let g:SuperTabRetainCompletionDuration = "insert"
let g:SuperTabDefaultCompletionType = "\<C-X><C-U>"
let g:SuperTabCrMapping = 1
let g:SuperTabLongestEnhanced = 1
let g:SuperTabLongestHighlight = 1
let g:SuperTabNoCompleteBefore = ['\k']
let g:SuperTabNoCompleteAfter = [',', '\s', '(', ')']

" fencview.vim {{{2
let g:fencview_autodetect = 0  "打开文件时自动识别编码
"let g:fencview_checklines = 10 "检查前后10行来判断编码

" bufexplorer.vim {{{2
let g:bufExplorerDefaultHelp=1
let g:bufExplorerDetailedHelp=0
let g:bufExplorerSortBy='mru'
nmap <F3> :BufExplorer<CR>
"let g:bufExplorerWidth = 60


" NERDTree.vim {{{2
let NERDShutUp = 1
map <F9> :NERDTreeToggle<CR>

if executable("cp")
	let g:NERDTreeCopyCmd= 'cp -r '
endif

"nerdtree tab
" Open NERDTree on gvim/macvim startup
let g:nerdtree_tabs_open_on_gui_startup = 0

" Open NERDTree on console vim startup
let g:nerdtree_tabs_open_on_console_startup = 0

" NERD_commenter.vim
let NERDSpaceDelims=1       " 让注释符与语句之间留一个空格
" let NERDCompactSexyComs=1   " 多行注释时样子更好看

"ctrlp
let g:ctrlp_show_hidden = 1
" let g:ctrlp_lazy_update = 1
let g:ctrlp_custom_ignore = {
			\ 'dir':  '\v[\/]\.(repo|git|hg|svn)$',
			\ 'file': '\v\.(exe|so|dll|o|apk|ko|a|zip|rar|gz|jar)$',
			\ 'link': 'some_bad_symbolic_links',
			\ }
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_max_files = 0
let g:ctrlp_use_caching = 1
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_mruf_exclude = '\c/tmp/.*\|/temp/.*\|^C:\\.*\\tmp\\.*\|\.git[/\\].*'
" let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:10,results:200'
" If ag is available use it as filename list generator instead of 'find'
if executable("ag")
	set grepprg=ag\ --vimgrep\ --hidden
				\\ --ignore\ \".hg\"\ --ignore\ \".hg\"\ --ignore\ \".svn\"
				\\ --ignore\ \".repo\"\ --ignore\ \".git\"\ --ignore\ \".DS_Store\"
				\\ --ignore\ \"**/*.pyc\"\ --ignore\ \".o\"\ --ignore\ \".class\"
				\\ --ignore\ \".so\"\ --ignore\ \".exe\"\ $*
	set grepformat=%f:%l:%c%m
	let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup
				\ --ignore ".hg" --ignore ".svn" --ignore ".repo" --ignore ".git" --ignore ".DS_Store"
				\ --ignore "**/*.pyc" --ignore ".o" --ignore ".class" --ignore ".so" --ignore ".exe"
				\ --hidden -g .'
endif

if has('python')
	" echo 'In order to use pymatcher plugin, you need +python compiled vim'
	let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch'  }
endif

nnoremap <Leader>b :CtrlPBuffer<CR>
nnoremap <C-P><C-M> :CtrlPMRUFiles<CR>
nnoremap <C-P><C-T> :CtrlPSmartTabs<CR>
nnoremap <Leader>c :CtrlPCurWD<CR>
nnoremap <C-P><C-D> :CtrlPDir<CR>
nnoremap <Leader>f :CtrlPCurFile<CR>
noremap <C-P><C-K> :CtrlPDigraphs<CR>
noremap <C-P><C-L> :CtrlPLine %<CR>
noremap <C-P>l :CtrlPLine<CR>
noremap <C-P>q :CtrlPQuickfix<CR>
noremap <C-P><C-Q> :CtrlPQuickfix<CR>
noremap <C-P><C-R> :CtrlPRTS<CR>
noremap <C-P><C-U> :CtrlPUndo<CR>
noremap <C-P>F :CtrlPFiletype<CR>
noremap <C-P><C-C> :CtrlPCmdline<CR>
noremap <Leader>C :CtrlPCmdPalette<CR>
noremap <C-P>m :CtrlPMenu<CR>
noremap <Leader>S :CtrlPSwitch<CR>
noremap <C-P><C-S> :CtrlPSwitch<CR>
nnoremap <C-P>t :CtrlPBufTag %<CR>
nnoremap <C-P>T :CtrlPBufTagAll<CR>
nnoremap <Leader>F :CtrlPFunky<CR>
nnoremap g<C-]> :CtrlPtjump<CR>
vnoremap g<C-]> :CtrlPtjumpVisual<CR>

"targets.vim
let g:targets_argSeparator = '[,;]'

"yankround
nmap p <Plug>(yankround-p)
xmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap gp <Plug>(yankround-gp)
xmap gp <Plug>(yankround-gp)
nmap gP <Plug>(yankround-gP)
nmap - <Plug>(yankround-prev)
nmap + <Plug>(yankround-next)

"unicode.vim
nmap <F11> <Plug>(MakeDigraph)

"table-mode
let g:table_mode_map_prefix = '<Leader>T'

"translategoogle
let g:translategoogle_languages = ["en", "zh", "ja"]
let g:translategoogle_default_sl = "en"
let g:translategoogle_default_tl = "zh"

"delimitMate
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1
let delimitMate_jump_expansion = 1
let delimitMate_balance_matchpairs = 1
" let delimitMate_excluded_ft = "mail,txt"
au FileType vim,html let b:delimitMate_matchpairs = "(:),[:],{:},<:>"
au FileType mail let b:delimitMate_autoclose = 0 | let b:delimitMate_expand_cr = 1
au FileType html,vim let b:delimitMate_quotes = "\" '"
au FileType python let b:delimitMate_nesting_quotes = ['"']
" au FileType c,perl let b:delimitMate_eol_marker = ";"

"Indentline
let g:indentLine_color_term = 239

"indentguides
let g:indent_guides_enable_on_vim_startup = 0
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree']

"rainbow parentheses
" au VimEnter * RainbowParenthesesToggleAll
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
map <silent> <Leader>R :RainbowParenthesesToggleAll<CR>

"easymotion
map <Space> <Plug>(easymotion-prefix)

"fugitive
autocmd BufReadPost fugitive://* set bufhidden=delete

"Session manager
let g:session_autosave = 'yes'
let g:session_autoload = 'no'
let g:session_command_aliases = 1

"dragvisuals
vmap  <expr>  <LEFT>   DVB_Drag('left')
vmap  <expr>  <RIGHT>  DVB_Drag('right')
vmap  <expr>  <DOWN>   DVB_Drag('down')
vmap  <expr>  <UP>     DVB_Drag('up')
vmap  <expr>  D        DVB_Duplicate()

"vmath.vim
vmap <expr>  <Leader>++  VMATH_YankAndAnalyse()
nmap         <Leader>++  vip++

"Gundo
nnoremap <F7> :GundoToggle<CR>

"CSAPPROX
if !has("gui") || has("gui_running")
	let g:CSApprox_loaded = 1
else
	runtime! plugin/CSApprox.vim
endif

"vim-shell
let g:shell_mappings_enabled = 0
inoremap <Leader>fs <C-o>:Fullscreen<CR>
nnoremap <Leader>fs :Fullscreen<CR>
inoremap <Leader>ms <C-o>:Maximize<CR>
nnoremap <Leader>ms :Maximize<CR>
inoremap <Leader>op <C-o>:Open<CR>
nnoremap <Leader>op :Open<CR>

"python-mode
let g:pymode_rope = 0
let g:pymode_rope_regenerate_on_write = 0
let g:pymode_breakpoint_bind = '<leader><leader>b'
let g:pymode_lint_on_write = 0
let g:pymode_lint_unmodified = 0
let g:pymode_trim_whitespaces = 0

"litecorrect
augroup litecorrect
autocmd!
autocmd FileType markdown call litecorrect#init()
autocmd FileType textile call litecorrect#init()
autocmd FileType gitcommit call litecorrect#init()
augroup END

"Omnicppcomplete
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD", "android"]
" automatically open and close the popup menu / preview window
" au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif

" 快速切换缓冲区
map <C-k> <C-W>k
map <C-j> <C-W>j
map <C-h> <C-W>h
map <C-l> <C-W>l

" 插入模式下模拟eclipse在当前行上/下开启新行
imap <C-Enter> <C-o>o
imap <S-Enter> <C-o>O


"选择模式下缩进
vnoremap < <gv
vnoremap > >gv

" 设置状态栏样式
function! CurrectDir()
	let curdir = substitute(getcwd(), "", "", "g")
	return curdir
endfunction

" set statusline=\ [File]\ %F%m%r%h[%{&fileencoding}]\ %w\ \ [PWD]\ %r%{CurrectDir()}%h\ \ %=[Line]\ %l,%c\ %=\ %P

" Move lines
nmap <C-Down> :<C-u>move .+1<CR>
nmap <C-Up> :<C-u>move .-2<CR>
imap <C-Down> <C-o>:<C-u>move .+1<CR>
imap <C-Up> <C-o>:<C-u>move .-2<CR>
vmap <C-Down> :move '>+1<CR>gv
vmap <C-Up> :move '<-2<CR>gv



" 映射Alt-0_9快捷键快速选择标签
for temp in [0,1,2,3,4,5,6,7,8,9]
	exe 'map <A-' . temp . '> ' . temp . 'gt'
	exe 'map! <A-' . temp . '> ' .'<Esc>'. temp . 'gt'
endfor
" }}}
" Leader commands {{{1
" 快速修改 .vimrc
map <leader>v :tabf $MYVIMRC<CR>
" 切换至当前目录
map <leader>cd :cd %:p:h<CR>
"vim rooter
map  <Leader>cr <Plug>RooterChangeToRootDirectory
" 快速保存
map <leader>s :w! <CR>
" 默认程序打开当前缓冲区文件
map <Leader>x :silent ! start "1" "%:p"<CR>
" 重新加载 .vimrc
"nmap <Leader>s :source $MYVIMRC<CR>
" 显示行号
map <leader>nu :set nu<CR>
" 显示相对于光标所在的行的行号
map <leader>rnu :set rnu<CR>
" 删除 ^M
map <Leader>dm :%s/<C-V><CR>//ge<CR>
" 停止`hlsearch`的选项的高亮显示
map <silent> <leader><CR> :set hlsearch!<CR>
" 快速切换`set list` or `set nolist`
map <leader>l :set list!<CR>
" 在当前缓冲区打开当前文件目录下的文件
map <leader><leader>ee :e <C-R>=expand("%:p:h") . "/" <CR>
" 以水平分割的方式打开当前文件目录下的文件
map <leader><leader>es :sp <C-R>=expand("%:p:h") . "/" <CR>
" 以垂直分割的方式打开当前文件目录下的文件
map <leader><leader>ev :vsp <C-R>=expand("%:p:h") . "/" <CR>
" 以Tab标签的方式打开当前文件目录下的文件
map <leader><leader>et :tabe <C-R>=expand("%:p:h") . "/" <CR>
" 折叠标签
map <leader>ft Vatzf
"close windows mapping
map <leader>q <C-W><C-C>
"buffer delete
map <leader>bd <Plug>Kwbd
map <leader>D :Bdi<CR>
map <leader>DD :Bdi!<CR>
"command mode word move
cnoremap <C-J> <C-Right>
cnoremap <C-K> <C-Left>
nmap <silent> <C-N> :tag<CR>

"vimshell
nmap <Leader>te :VimShellPop<CR>
" Use current directory as vimshell prompt.
let g:vimshell_prompt_expr =
			\'escape(fnamemodify(getcwd(), ":~").">", "\\[]()?! ")." "'
let g:vimshell_prompt_pattern = '^\%(\f\|\\.\)\+> '

" 重载当前文件
nmap <F5> :e!<CR>
nmap <silent> <Leader>tt :tabnew<CR>
nmap <Leader>ta ggVG

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
" let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
let g:neocomplcache_enable_quick_match = 1
let g:neocomplcache_enable_ignore_case = 0
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_enable_fuzzy_completion = 0
let g:neocomplcache_disable_auto_complete = 0
let g:neocomplcache_enable_prefetch = 1
let g:neocomplcache_enable_insert_char_pre = 0
" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {'default' : ''}

if v:version >= 704
	for f in glob(g:my_vimrc_path . "/dict/**/*.dict", 0, 1)
		let ft =  fnamemodify( f, ":t:r")
		let g:neocomplcache_dictionary_filetype_lists[ft] = f
	endfor
else
	for f in split(glob(g:my_vimrc_path . "/dict/**/*.dict"), '\n')
		let ft =  fnamemodify( f, ":t:r" )
		let g:neocomplcache_dictionary_filetype_lists[ft] = f
	endfor
endif

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
	let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Enable heavy omni completion.
autocmd BufWinEnter,BufRead * if !empty(tagfiles()) |
			\if !exists('g:neocomplcache_omni_patterns') |
			\  let g:neocomplcache_omni_patterns = {} |
			\endif |
			\let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::' |
			\let g:neocomplcache_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)' |
			\let g:neocomplcache_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::' |
			\let g:neocomplcache_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::' |
			\endif

" let g:neocomplcache_temporary_dir = substitute(tempname(),
			" \'\c\(temp[\\/]\|tmp[\\/]\).*$', '\1', '') . ".neocomplcache"

" Plugin key-mappings.
" imap <expr><C-g>     pumvisible() ? neocomplcache#undo_completion():"\<C-g>"
imap <expr><C-l>     neocomplcache#complete_common_string()
" Recommended key-mappings.
" <CR>: close popup and save indent.
imap <expr><CR> pumvisible() ? "<C-y>": "<Plug>delimitMateCR<Plug>DiscretionaryEnd"
" <TAB>: completion.
inoremap <expr><TAB> pumvisible() ? "\<C-N>" : "\<TAB>"
inoremap <expr><C-J> pumvisible() ? "\<C-N>" : "\<C-J>"
inoremap <expr><C-K> pumvisible() ? "\<C-P>" : "\<C-N>"
" <C-h>, <BS>: close popup and delete backword char.
imap <expr><C-h> pumvisible() ? "\<C-h>" :  "\<Plug>delimitMateBS"
imap <expr><BS>  pumvisible() ? "\<BS>" :  "\<Plug>delimitMateBS"
imap <expr><C-e> pumvisible() ?  neocomplcache#cancel_popup() : "\<C-e>"

let g:xptemplate_nav_next = "<C-j>"
let g:xptemplate_nav_prev = "<C-k>"
" let g:xptemplate_nav_cancel = "<C-c>"
let g:xptemplate_fallback = ""
" let g:xptemplate_goback = "<C-b>"
" g:xptemplate_hook_before_cr
" let g:xptemplate_debug_log = $HOME . '/.xpt.log'
let g:xptemplate_pum_tab_nav = 1
let g:xptemplate_strict = 2
let g:xptemplate_break_undo = 1
let g:xptemplate_close_pum = 1
let g:xptemplate_vars = '$author=yalin.wang&$email=yalin_wang@apple.com'
" }}}

"cppcheck
if executable("cppcheck")
	let g:cppcheck_version = substitute(system("cppcheck --version"), '^\ccppcheck\s*', '', '')

	function! CppCheck()
		let source_tempname = tempname()
		call writefile(getline(1, line("$")), source_tempname)
		let command = "cppcheck -q -f --enable=style --enable=performance ".
					\"--enable=portability --enable=information "
		if g:cppcheck_version >= 1.6
			let command .= "--enable=warning "
		endif

		if &ft == 'cpp'
			let command .= "-D__cplusecpluse "
		else
			let command .= "-U__cplusecpluse "
		endif

		let command .= '"' . source_tempname . '"'
		let result = system(command)
		call delete(source_tempname)

		let result = substitute(result, '\m\[\zs[^\]]*\ze:', expand("%:p"), 'g')

		return result
	endfunction

	function! CppQuickFixCheck(q)

		if &ft == "c" || &ft == "cpp"
			let save_makeefm=&efm
			let &efm= "\[%f:%l\]%m"
			echo "cppcheck file:" . expand("%:p")
			let result = CppCheck()
			execute a:q . "getexpr result"
			let &efm = save_makeefm
			execute a:q ."window"
		else
			echoerr "Wrong filetype for cppcheck:" . &ft
		endif

	endfunction

	function!  BufWriteCppCheck()
		if &ft == "c" || &ft == "cpp"
			let result = CppCheck()
			if result =~# '\m (error) '
				echohl errmsg
				echoerr "File[" . &ft . "]:" . expand("%:p") . " syntax error.."
				let decision = input("Do you want still save the file? (y)es/(n)o: ", "n")
				echohl
				if decision =~? '\vy|yes'
					return
				else
					call CppQuickFixCheck("l")
					echoerr
				endif
			endif
		endif
	endfunction

	nmap <Leader>qc :call CppQuickFixCheck("c")<CR>
	nmap <Leader>lc :call CppQuickFixCheck("l")<CR>
	" autocmd BufWritePre * call BufWriteCppCheck()
endif

" vim: nowrap fdm=marker
