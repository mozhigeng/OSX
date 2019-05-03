"--------------Vim基本设置------------------
set nu	"行号
syntax on "语法高亮
set cursorline "高亮当前行
set autoindent "自动缩进
set tabstop=4 "缩进长度
set nobackup	"取消自动保存
set noswapfile	"取消临时文件
set showmatch "大括号配对
set mouse=a	"支持鼠标
filetype on	"检测文件类型
"执行pathogen插件
execute pathogen#infect()  

"---自动载入模板----
autocmd BufNewFile *.c 0r ~/.vim/template/c.tlp
autocmd BufNewFile *.cpp 0r ~/.vim/template/cpp.tlp
autocmd BufNewFile *.php 0r ~/.vim/template/php.tlp
autocmd BufNewFile *.js 0r ~/.vim/template/js.tlp
autocmd BufNewFile *.py 0r ~/.vim/template/py.tlp
        
"--Emmet插件--
let g:user_emmet_leader_key=',' "修改快捷键
let g:user_emmet_install_global = 0 "控制生效文件
autocmd FileType php,html,css EmmetInstall "仅仅允许指定文件生效

"--Tabular插件--
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction



"-------配置主题--------------------
"配色：blue darkblue default delek elflord evening koehler morning murphy  pablo peachpuff ron shine slate  torte  zellner
"set background=dark
"colorscheme  github
"显示配对的括号花括号




"------------------Tlist 显示和定位代码中的变量和函数 注意 该插件需要配合ctags使用 ！mac下需要使用brew重新安装，不要使用系统默认的-------------

"这是tags命令所在的目录 mac下使用 
let Tlist_Ctags_Cmd='/usr/local/Cellar/ctags/5.8_1/bin/ctags'
set autochdir



"启动vim时打开Tlist,这里关闭，因为winmanager已经设置一起启动
let Tlist_Auto_Open=0
"控制Tlist窗口的位置，1右边 0 左边 
let Tlist_Use_Right_Window=1
"当Tlist为最后一个窗口的时候，退出Vim
let Tlist_Exit_OnlyWindow=1
"0 显示多个窗口的tags 1 只显示当前窗口的tags
let Tlist_Show_One_File=0
"0 展开所有tags  1只展开当前窗口tags
let Tlist_File_Fold_Auto_Close=1




"-----------------Winmanager-------------------
"开启vim同时开启winmanager
let g:AutoOpenWinMananger=1
"设置界面布局，|在一起 ，分割开来
let g:winManagerWindowLayout='FileExplorer,TagList'
"设置宽度
let g:winManagerWidth=30
"切换开关窗口,注意冒号前的一个空格,nmap表示仅normal模式下生效
nmap wm :WMToggle<cr>

"--------------------Airline--------------
"查看帮助-> :help airline
"让airline在任何状态下出现
set laststatus=2
"左边分界符
let g:airline_left_sep=' '
"右边分界符
let g:airline_right_sep=' '
"
let g:airline_powerline_fonts=0

"------------------------------------------------------------------------foundation---------------------------------------------------------------- -
"-XY格栅

ab gx .grid-x>.cell
ab gpadding .grid-x.grid-padding-x
ab gmargin .grid-x.grid-margin-x

ab lcell .large-12.cell
ab l4s3 .large-4.small-3.cell+.large-8.small-9.cell
ab l6s6 .large-6.small-6.cell+.large-6.small-6.cell
"
ab gcontainer .grid-container

"控件
ab callout <!--Callout开始--><Enter>.callout>h3{Replace-Title-Here}+p{text}+p{text-more-you-want}+.grid-x.grid-padding-x*2>.large-4.medium-4.cell*3>p>a{Link $}+br+lorem<Enter><!--Callout结束--><Esc>kA
ab form <!-- 表格 --><Enter>h5{Register your information below:}+.form>.grid-x.grid-padding-x>.large-12.cell>label{Input Label}+input[placeholder="large-12.cell" type="text"]<Enter><!--表格结束-->



"---PHP---
ab header- header('Content-Type:text/html;charset=utf-8');
ab in- include('');<ESC>hhh


"------------------------------------------------------------------------Smarty---------------------------------------------------------------- -
ab -- {}<Esc>i
ab foreach-- {*遍历数组*}<Enter>{foreach $arrs as $arr}<Enter><Tab>{foreach $arr as $k=>$v}<Enter><Tab>{$k} : {$v}<br/><Enter><BackSpace>{/foreach}<Enter><BackSpace>{/foreach}<Esc>kkA 
ab section-- {*遍历一维索引数组 $smarty.sec_name.index .index_prev .index_next .loop .total .first .last .iteration*}<Enter>{section loop=$list name=sec_name start=0 step=1 max=100000 show=true}<Enter><Tab>{$list[sec_name]}<br/><Enter><BackSpace>{/section}<Esc>kA
