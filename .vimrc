"===========================================================
"Normal Config
"===========================================================
set lbr
set fo+=mB
set sm
set mousemodel=popup

"set list
"set listchars=tab:>\ ,trail:·
set redrawtime=10000
"set updatetime=300
"let mapleader=","

" 显示中文帮助
if version >= 603
    set helplang=cn
    set encoding=utf-8
endif

syntax on
set cul "高亮光标所在行
"set cuc
set shortmess=atI   " 启动的时候不显示那个援助乌干达儿童的提示  
set go=             " 不要图形按钮  


"set guifont=Courier_New:h10:cANSI   " 设置字体  
"autocmd InsertLeave * se nocul  " 用浅色高亮当前行  
autocmd InsertEnter * se cul    " 用浅色高亮当前行  

set ruler           " 显示标尺  
"set cursorline     " 突出显示当前行
set showcmd         " 输入的命令显示出来，看的清楚些  
"set whichwrap+=<,>,h,l   " 允许backspace和光标键跨越行边界(不建议)  

set scrolloff=3     " 光标移动到buffer的顶部和底部时保持3行距离  
set sidescrolloff=8

"set foldenable      " 允许折叠  
"set foldmethod=manual   " 手动折叠  
set foldcolumn=0
set foldmethod=syntax
set nofoldenable
set foldlevel=3


" 自动缩进
set autoindent
set cindent
set smartindent

" Tab键的宽度
set tabstop=4

" 统一缩进为4
set softtabstop=4
set shiftwidth=4

" 使用空格代替制表符
set expandtab

" 在行和段开始处使用制表符
set smarttab

" 显示行号
set number

" 历史记录数
set history=1000

"搜索逐字符高亮
set hlsearch
set incsearch

"编码设置
set iskeyword+=.
set termencoding=utf-8
set encoding=utf8
set fileencodings=utf8,ucs-bom,gbk,cp936,gb2312,gb18030

" 总是显示状态行
set cmdheight=2

" 保存全局变量
set viminfo+=!
" 带有如下符号的单词不要被换行分割
set iskeyword+=_,$,@,%,#,-


" 设置当文件被改动时自动载入
set autoread
"代码补全 
set completeopt=preview,menu 

"共享剪贴板  
"set clipboard+=unnamed 

"自动保存
set autowrite

set magic
set guioptions-=T           " 隐藏工具栏
set guioptions-=m           " 隐藏菜单栏


" 不要使用vi的键盘模式，而是vim自己的
set nocompatible
" 去掉输入错误的提示声音
set noeb
" 在处理未保存或只读文件的时候，弹出确认
set confirm
"禁止生成临时文件
set nobackup
set noswapfile
"搜索忽略大小写
"set ignorecase


set linespace=0
" 增强模式中的命令行自动完成操作
set wildmenu
" 使回格键（backspace）正常处理indent, eol, start等
set backspace=2
" 允许backspace和光标键跨越行边界
set whichwrap+=<,>,h,l
" 可以在buffer的任何地方使用鼠标（类似office中在工作区双击鼠标定位）
set mouse=a
set selection=exclusive
set selectmode=mouse,key
" 通过使用: commands命令，告诉我们文件的哪一行被改变过
set report=0
" 在被分割的窗口间显示空白，便于阅读
set fillchars=vert:\ ,stl:\ ,stlnc:\
" 高亮显示匹配的括号
set showmatch
" 匹配括号高亮的时间（单位是十分之一秒）
set matchtime=1


"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}   "状态行显示的内容  
"set laststatus=2    " 启动显示状态行(1),总是显示状态行(2)  

let g:indentLine_char = '┊'


" 侦测文件类型
filetype on
" 载入文件类型插件
filetype plugin on
" 为特定文件类型载入相关缩进文件
filetype indent on


" filetype
au FileType php setlocal dict+=~/.vim/dict/php_funclist.dict
au FileType css setlocal dict+=~/.vim/dict/css.dict
au FileType c setlocal dict+=~/.vim/dict/c.dict
au FileType cpp setlocal dict+=~/.vim/dict/cpp.dict
au FileType scale setlocal dict+=~/.vim/dict/scale.dict
au FileType javascript setlocal dict+=~/.vim/dict/javascript.dict
au FileType html setlocal dict+=~/.vim/dict/javascript.dict
au FileType html setlocal dict+=~/.vim/dict/css.dict

"markdown配置
au BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn}   set filetype=mkd
au BufRead,BufNewFile *.{go}   set filetype=go
au BufRead,BufNewFile *.{js}   set filetype=javascript
"rkdown to HTML  
"nmap md :!~/.vim/markdown.pl % > %.html <CR><CR>
"nmap fi :!firefox %.html & <CR><CR>


if has("autocmd")
      autocmd BufReadPost *
          \ if line("'\"") > 0 && line("'\"") <= line("$") |
          \   exe "normal g`\"" |
          \ endif
endif
"当打开vim且没有文件时自动打开NERDTree
autocmd vimenter * if !argc() | NERDTree | endif
" 只剩 NERDTree时自动关闭
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" quickfix模式
autocmd FileType c,cpp map <buffer> <leader><space> :w<cr>:make<cr>


"syntastic相关
execute pathogen#infect()
let g:syntastic_python_checkers=['pylint']
let g:syntastic_php_checkers=['php', 'phpcs', 'phpmd']
"golang
"Processing... % (ctrl+c to stop)
let g:fencview_autodetect=0
set rtp+=$GOROOT/misc/vim



"===========================================================
"New file template
"===========================================================
"新建.c,.h,.sh,.java文件，自动插入文件头 
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.rb,*.java,*.py exec ":call SetTitle()" 

""定义函数SetTitle，自动插入文件头 
func SetTitle() 
    "如果文件类型为.sh文件 
    if &filetype == 'sh' 
        call setline(1,"\#!/bin/bash") 
        call append(line("."), "") 

    elseif &filetype == 'python'
        call setline(1, "#/*************************************************************************") 
        call append(line("."), "#    > File Name: ".expand("%")) 
        call append(line(".")+1, "#    > Author: racle") 
        call append(line(".")+2, "#    > Mail: racleray@qq.com") 
        "call append(line(".")+3, "#    > Created Time: ".strftime("%c")) 
        call append(line(".")+3, "#    > Created Time: ")
        call append(line(".")+4, "# ************************************************************************/") 
        call append(line(".")+5,"# coding=utf-8")
        call append(line(".")+6, "") 
        call append(line(".")+7, "")
        call append(line(".")+8, "")
        call append(line(".")+9, "if __name__=='__main__':")
        call append(line(".")+10, "")

    elseif &filetype == 'ruby'
        call setline(1,"#!/usr/bin/env ruby")
        call append(line("."),"# encoding: utf-8")
        call append(line(".")+1, "")

"    elseif &filetype == 'mkd'
"        call setline(1,"<head><meta charset=\"UTF-8\"></head>")
    else 
        call setline(1, "/*************************************************************************") 
        call append(line("."), "    > File Name: ".expand("%")) 
        call append(line(".")+1, "    > Author: racle") 
        call append(line(".")+2, "    > Mail: racleray@qq.com") 
        "call append(line(".")+3, "    > Created Time: ".strftime("%c")) 
        call append(line(".")+3, "    > Created Time: ")
        call append(line(".")+4, " ************************************************************************/") 
        call append(line(".")+5, "")
    endif

    if expand("%:e") == 'cpp'
        call append(line(".")+6, "#include<iostream>")
        call append(line(".")+7, "#include<bits/stdc++.h>")
        call append(line(".")+8, "using namespace std;")
        call append(line(".")+9, "")
        call append(line(".")+10, "int main(int argc, char *argv[]) {")
        call append(line(".")+11, "")
        call append(line(".")+12, "    return 0;")
        call append(line(".")+13, "}")
    endif
    
    if &filetype == 'c'
        call append(line(".")+6, "#include<stdio.h>")
        call append(line(".")+7, "#include<stdlib.h>")
        call append(line(".")+8, "#include<string.h>")
        call append(line(".")+9, "")
        call append(line(".")+10, "int main() {")
        call append(line(".")+11, "")
        call append(line(".")+12, "    return 0;")
        call append(line(".")+13, "}")
    endif
    if expand("%:e") == 'h'
        call append(line(".")+6, "#ifndef _".toupper(expand("%:r"))."_H")
        call append(line(".")+7, "#define _".toupper(expand("%:r"))."_H")
        call append(line(".")+8, "#endif")
    endif
    if &filetype == 'java'
        call append(line(".")+6,"public class ".expand("%:r"))
        call append(line(".")+7,"")
    endif
    "新建文件后，自动定位到文件末尾
endfunc 
autocmd BufNewFile * normal G



"===========================================================
"Key map
"===========================================================
:nmap <silent> <F9> <ESC>:Tlist<RETURN>

" shift tab pages
nmap <S-Left> :tabp<CR>
nmap <S-Right> :tabn<CR>

"将tab替换为空格
nmap tt :%s/\t/    /g<CR>

map! <C-Z> <Esc>zzi
"map! <C-O> <C-Y>,

map <C-A> ggVG$"+y
"map <F12> gg=G

map <C-w> <C-w>w

imap <C-j> <ESC>
imap jjj <Esc>

"选中状态下 Ctrl+c 复制
"map <C-v> "*pa
imap <C-v> <Esc>"*pa
imap <C-a> <Esc>^
imap <C-e> <Esc>$i

vmap <C-c> "+y
"set clipboard=unnamed

"去空行  
nnoremap <F2> :g/^\s*$/d<CR> 
"比较文件  
nnoremap <C-F2> :vert diffsplit 


"C，C++ 按F5编译运行
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        exec "!g++ % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'java' 
        exec "!javac %" 
        exec "!time java %<"
    elseif &filetype == 'sh'
        :!time bash %
    elseif &filetype == 'python'
        exec "!time python %"
    elseif &filetype == 'html'
        exec "!firefox % &"
    elseif &filetype == 'go'
"        exec "!go build %<"
        exec "!time go run %"
    elseif &filetype == 'mkd'
        exec "!~/.vim/markdown.pl % > %.html &"
        exec "!firefox %.html &"
    endif
endfunc

"C,C++的调试
map <F8> :call Rungdb()<CR>
func! Rungdb()
    exec "w"
    exec "!g++ % -g -o %<"
    exec "!gdb ./%<"
endfunc


"代码格式优化化  file 从多级父目录中查找 .clang-format 文件
nmap <F6> :%!clang-format --style=file<CR>

"环境中需要安装对应的工具，最好在sudo模式下安装，否则可能装在了local文件夹，全局查不到
map <F7> :call FormartSrc()<CR><CR>
"定义FormartSrc()
func FormartSrc()
    exec "w"
    if &filetype == 'c'
        exec "!astyle --style=ansi -a --suffix=none %"
    elseif &filetype == 'cpp' || &filetype == 'hpp'
        exec "r !astyle --style=ansi --one-line=keep-ments -a --suffix=none %> /dev/null 2>&1"
    elseif &filetype == 'perl'
        exec "!astyle --style=gnu --suffix=none %"
    elseif &filetype == 'py'|| &filetype == 'python'
        exec "r !autopep8 -i --aggressive %"
    elseif &filetype == 'java'
        exec "!astyle --style=java --suffix=none %"
    elseif &filetype == 'jsp'
        exec "!astyle --style=gnu --suffix=none %"
    elseif &filetype == 'xml'
        exec "!astyle --style=gnu --suffix=none %"
    else
        exec "normal gg=G"
        return
    endif
    exec "e! %"
endfunc
"结束定义FormartSrc


"自动补全括号
:inoremap ( ()<ESC>i
:inoremap ) <c-r>=ClosePair(')')<CR>
:inoremap { {<CR>}<ESC>O
:inoremap } <c-r>=ClosePair('}')<CR>
:inoremap [ []<ESC>i
:inoremap ] <c-r>=ClosePair(']')<CR>
:inoremap " ""<ESC>i
:inoremap ' ''<ESC>i
function! ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endfunction

filetype plugin indent on 
"打开文件类型检测, 加了这句才可以用智能补全
set completeopt=longest,menu


"===========================================================
"Ctags Config
"===========================================================
let Tlist_Sort_Type = "name"    " 按照名称排序  
let Tlist_Use_Right_Window = 1  " 在右侧显示窗口  
let Tlist_Compart_Format = 1    " 压缩方式  
let Tlist_Exist_OnlyWindow = 1  " 如果只有一个buffer，kill窗口也kill掉buffer  
"let Tlist_File_Fold_Auto_Close = 0  " 不要关闭其他文件的tags  
"let Tlist_Enable_Fold_Column = 0    " 不要显示折叠树  
"let Tlist_Show_One_File=1            "不同时显示多个文件的tag，只显示当前文件的

"设置tags  
set tags=tags;
set tags+=~/.vim/systags
set autochdir

"默认打开Taglist 
let Tlist_Auto_Open=0 

let Tlist_Ctags_Cmd = '/usr/local/bin/ctags' 
let Tlist_Show_One_File = 1 "不同时显示多个文件的tag，只显示当前文件的 
let Tlist_File_Fold_Auto_Close = 1
let Tlist_Exit_OnlyWindow = 1 "如果taglist窗口是最后一个窗口，则退出vim 
let Tlist_Use_Right_Window = 1 "在右侧窗口中显示taglist窗口
" minibufexpl插件的一般设置
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1  

nmap tl :Tlist<cr>


"python补全
let g:pydiction_location = '~/.vim/after/complete-dict'
let g:pydiction_menu_height = 20
let Tlist_Ctags_Cmd='/usr/local/bin/ctags'
" let g:miniBufExplMapWindowNavVim = 1
" let g:miniBufExplMapWindowNavArrows = 1
" let g:miniBufExplMapCTabSwitchBufs = 1
" let g:miniBufExplModSelTarget = 1

autocmd FileType python set omnifunc=pythoncomplete#Complete




"===========================================================
"Package Manage
"===========================================================
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'https://gitee.com/suyelu/vundle'

" My Bundles here:
"Bundle 'https://gitee.com/suyelu/vim-fugitive'

"Vim basic function
Bundle 'https://gitee.com/suyelu/L9'
" Show vertical lines at each indentation level
Bundle 'https://gitee.com/suyelu/indentLine' 
" require L9, quickly find
Bundle 'https://gitee.com/suyelu/FuzzyFinder' 
" ruby based file finder
" Bundle 'https://gitee.com/suyelu/command-t' 
" fuzzy file finder, like FuzzyFinder
Bundle 'https://gitee.com/suyelu/ctrlp.vim'    
" function finder
Bundle 'https://gitee.com/suyelu/ctrlp-funky'  
Bundle 'https://gitee.com/suyelu/ctrlp-modified.vim'
" Script manage
Bundle 'https://gitee.com/suyelu/Vim-Script-Updater'  

" Faster input
Bundle 'https://gitee.com/suyelu/Auto-Pairs'
" mark and back, even cross buffer
Bundle 'https://gitee.com/suyelu/last_edit_marker.vim' 
" tool other pack used
Bundle 'https://gitee.com/suyelu/synmark.vim'  
" comment quicker
Bundle 'https://gitee.com/suyelu/The-NERD-Commenter'  

"JS
"Bundle 'https://gitee.com/suyelu/Javascript-OmniCompletion-with-YUI-and-j'
"Bundle 'JavaScript-Indent'
"Bundle 'Better-Javascript-Indentation'
"Bundle 'https://gitee.com/suyelu/jslint.vim'
"Bundle 'https://gitee.com/suyelu/vim-javascript'
"Bundle 'https://gitee.com/suyelu/jsbeautify'

"html
""write HTML code faster
"Bundle 'https://gitee.com/suyelu/sparkup', {'rtp': 'vim/'} 

"python
"" auto add packages
Bundle 'https://gitee.com/suyelu/python-imports.vim'  
"https://github.com/nvie/vim-flake8
"Bundle 'nvie/vim-flake8'  
"Bundle 'Python-mode-klen'
"Bundle 'https://gitee.com/suyelu/django_templates.vim'
"Bundle 'https://gitee.com/suyelu/Django-Projects'
"Bundle 'djangojump'
"Bundle 'https://gitee.com/suyelu/SQLComplete.vim'

"Visual
Bundle 'https://gitee.com/racleray/lightline.vim'
Bundle 'luochen1990/rainbow'
Bundle 'https://gitee.com/zgpio/onedark.vim'
Bundle 'https://gitee.com/racleray/dracula', { 'name': 'dracula' }
Bundle 'https://gitee.com/racleray/ayuclone'
Bundle 'https://gitee.com/racleray/everblush'
Bundle 'https://gitee.com/racleray/papercolor'
Bundle 'https://gitee.com/racleray/vim-one'


"Code hint and more like VSCode
Bundle 'neoclide/coc.nvim', {'branch': 'release'}

"golang
"Bundle 'fatih/vim-go'

"Rust
"Bundle 'tpope/vim-rails.git'

" Optional, syntax highlight
"Bundle 'sheerun/vim-polyglot'   
" When GUI enabed, not for Server
"Bundle 'voldikss/vim-floaterm'  


"call vundle#end()



"=========================================================
"" colorscheme settings
"color ron

"color slate

"color autumn2

" https://github.com/joshdick/onedark.vim
" 可能需要手动配置onedark.vim文件，见文档
color onedark

"color dracula

" ayu
"set termguicolors
"let ayucolor="light"
"let ayucolor="mirage"
"let ayucolor="dark"
"color ayu


" everblush
"" To enable
"let g:everblushNR=1 " default
"" To disable
"let g:everblushNR=1
"" Remember to reload colorscheme after changing the variable
"color everblush


" papercolor
set t_Co=256   " This is may or may not needed.
"set background=light
set background=dark
"let g:PaperColor_Theme_Options = {
  "\   'theme': {
  "\     'default': {
  "\       'transparent_background': 1,
  "\       'override' : {
  "\         'color00' : ['#080808', '232'],
  "\         'linenumber_bg' : ['#080808', '232']
  "\       }
  "\     }
  "\   }
  "\ }
let g:PaperColor_Theme_Options = {
  \   'theme': {
  \     'default.dark': {
  \       'transparent_background': 1,
  \       'allow_bold': 1,
  \       'allow_italic': 1
  \     }
  \   },
  \   'language': {
  \     'python': {
  \       'highlight_builtins' : 1
  \     },
  \     'cpp': {
  \       'highlight_standard_library': 1
  \     },
  \     'c': {
  \       'highlight_builtins' : 1
  \     }
  \   }
  \ }
"colorscheme PaperColor


" one
"set background=dark " for the dark version
"let g:one_allow_italics = 1
" set background=light " for the light version
"colorscheme one



"=========================================================
"" sparkup settings
"let g:html_indent_inctags = "html,body,head,tbody"
"let g:html_indent_script1 = "inc"
"let g:html_indent_style1 = "inc"



"=========================================================
"" fuzzy finder settings
nmap fb :FufBuffer<CR>
nmap ff :FufFile<CR>
nmap fc :FufCoverageFile<CR>
nmap fd :FufDir<CR>


"=========================================================
"" auto pairs : 和自定义的有冲突，选一个使用 
"let g:AutoPairsFlyMode = 1
"let g:AutoPairsShortcutBackInsert = '<M-b>'



"=========================================================
"
" ctrlp设置
"
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.png,*.jpg,*.gif     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe,*.pyc,*.png,*.jpg,*.gif  " Windows

let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = '\v\.(exe|so|dll)$'
let g:ctrlp_extensions = ['funky']

" default
"let g:ctrlp_map = '<c-p>'
"let g:ctrlp_cmd = 'CtrlP'

" CtrlPFunky
" 函数名查找
nmap <Leader>fu :CtrlPFunky<Cr>
nmap <C-n> :CtrlPFunky<Cr>



"=========================================================
"
" last mark设置
"
" Z   marked
" go back
nmap gb g`Z


"=========================================================
" Nerd tree
"列出当前目录文件  
map <F3> :NERDTreeToggle<CR>
imap <F3> <ESC> :NERDTreeToggle<CR>
"打开树状文件目录  
map <C-F3> \be
:autocmd BufRead,BufNewFile *.dot map <F5> :w<CR>:!dot -Tjpg -o %<.jpg % && eog %<.jpg  <CR><CR> && exec "redr!"
let NERDTreeIgnore=['\.pyc']



"=========================================================
" ==== itchyny/lightline.vim ====
" 若出错没有显示正确，使用 第147，148行的配置
" 或者直接  git clone https://github.com/itchyny/lightline.vim ~/.vim/pack/plugins/start/lightline
set laststatus=2
if !has('gui_running')
    set t_Co=256
endif
" -- INSERT -- is unnecessary anymore because the mode infomation is displayed
"  in the statusline.
set noshowmode

let g:lightline = {
      \ 'colorscheme': 'one',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified', 'charvaluehex' ] ]
      \ },
      \ 'component': {
      \   'charvaluehex': '0x%B'
      \ },
      \ }



"=========================================================
" ==== luochen1990/rainbow ====
let g:rainbow_active = 1



"=========================================================
" ==== neoclide/coc.nvim ====
" 需要先安装 nodejs  yarn  clangd，coc 文档中可查找插件
" jedi-language-server 使用pip安装，若没有sudo，可能找不到文件，解决: https://www.guyrutenberg.com/2021/08/14/coc-nvim-unhandledrejection-launching-server-jedi-using-command-jedi-language-server-failed/
" clangd 若没有sudo 可能出问题，解决：https://blog.csdn.net/qq_34548075/article/details/120147824
" https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions
"功能：
"  TAB 键为下一个补全候选项
"  Shift + TAB 组合键为上一个补全候选项
"  Ctrl + Enter 组合键为呼出候选菜单
"  Enter 键为确定当前补全候选项（当有候选项被选中时）
"  普通模式下 K 键会新开前窗口打开光标对应位置代码的说明文档
   "\rn为 批量重命名 操作
"  \f 为 格式化(format)选中代码 操作

"  gd 和 gD 跳转到定义
"  gy 跳转到type definition
"  gi 跳转到实现
"  gr 跳转到引用

" coc extensions
let g:coc_global_extensions = [
      \ 'coc-json',
      \ 'coc-vimlsp',
      \ 'coc-clangd',
      \ 'coc-pyright',
      \ 'coc-pairs',
      \ 'coc-markdownlint',
      \ ]

set signcolumn=yes
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" <CR> to comfirm selected candidate
" only when there's selected complete item
if exists('*complete_info')
  inoremap <silent><expr> <CR> complete_info(['selected'])['selected'] != -1 ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use M to show documentation in preview window
nnoremap <silent> M :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end


" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD :tab sp<CR><Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

function! s:generate_compile_commands()
  if empty(glob('CMakeLists.txt'))
    echo "Can't find CMakeLists.txt"
    return
  endif
  if empty(glob('.vscode'))
    execute 'silent !mkdir .vscode'
  endif
  execute '!cmake -DCMAKE_BUILD_TYPE=debug
      \ -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -S . -B .vscode'
endfunction
command! -nargs=0 Gcmake :call s:generate_compile_commands()





