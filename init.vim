let $XDG_RUNTIME_DIR = expand('/run/user/501')
let $XDG_CACHE_HOME = expand($HOME.'/.cache')
let $XDG_CONFIG_DIRS = expand('/etc/xdg')
let $XDG_CONFIG_HOME = expand($HOME.'/.config')
let $XDG_DATA_DIRS = expand('/usr/local/share:/usr/share')
let $XDG_DATA_HOME = expand($HOME.'/.local/share')

" -------------------------------------------------------------------------------------------------
" GlobalAutoCmd:

" Syntax highlight: ~/.nvim/after/syntax/vim.vim
augroup GlobalAutoCmd
  autocmd!
augroup END
command! -nargs=* Gautocmd   autocmd GlobalAutoCmd <args>
command! -nargs=* Gautocmdft autocmd GlobalAutoCmd FileType <args>

" -------------------------------------------------------------------------------------------------
" Global Settings:

set autoindent
set backup
set backupdir=$XDG_DATA_HOME/nvim/backup
set belloff=all
set cinoptions+=:0,g0,N-1,m1
set clipboard=unnamed,unnamedplus
set cmdheight=2
set colorcolumn=79
set complete=.  " default: .,w,b,u,t
set completeopt=menu,longest,noinsert,noselect
set concealcursor=niv
set conceallevel=2
set directory=$XDG_DATA_HOME/nvim/swap
set expandtab
set fillchars="diff:⣿,fold: ,vert:│"
set foldcolumn=0
set foldmethod=indent
set foldnestmax=1  " maximum fold depth
set formatoptions+=c  " Autowrap comments using textwidth
set formatoptions+=j  " Delete comment character when joining commented lines
set formatoptions+=l  " do not wrap lines that have been longer when starting insert mode already
set formatoptions+=n  " Recognize numbered lists
" set formatoptions+=o  " Insert comment leader after hitting o or O in normal mode
set formatoptions+=q  " Allow formatting of comments with "gq".
set formatoptions+=r  " Insert comment leader after hitting <Enter>
set formatoptions+=t  " Auto-wrap text using textwidth
set helplang& helplang=en,ja " Hey, if true Vim master, use English help language.
set hidden
set history=10000
set ignorecase
set inccommand=nosplit
set laststatus=2
set linebreak
set list
set listchars=nbsp:%,tab:»-,trail:_
set makeprg="make -j9"
set matchtime=0
set maxmempattern=2000000
set modeline
set modelines=1
set mouse=a
set noswapfile
set number
set path=$PWD/**
set previewheight=15
set pumheight=25
set regexpengine=2
set ruler
set scrolljump=1
set scrolloff=10
set secure
set shiftround
set shiftwidth=4
set shortmess+=c  " default: shortmess=filnxtToO
set showfulltag
set showmatch
set showmode
set showtabline=2
set sidescrolloff=3
set smartcase
set smartindent
set softtabstop=4
set splitbelow
set splitright
set switchbuf=useopen
set synmaxcol=0  " 0: unlimited
set tabstop=4
set tags=./tags;  " http://d.hatena.ne.jp/thinca/20090723/1248286959
set termguicolors
set textwidth=0
set timeout  " mappnig timeout
set timeoutlen=400
set ttimeout  " keycode timeout
set ttimeoutlen=5
set undodir=$XDG_DATA_HOME/nvim/undo
set undofile
set undolevels=10000
set updatetime=500
set wildignore+=*.jpg,*.jpeg,*.bmp,*.gif,*.png            " image
set wildignore+=*.manifest                                " gb
set wildignore+=*.o,*.obj,*.exe,*.dll,*.so,*.out,*.class  " compiler
set wildignore+=*.swp,*.swo,*.swn                         " vim
set wildignore+=*.ycm_extra_conf.py,*.ycm_extra_conf.pyc  " YCM
set wildignore+=*/.git,*/.hg,*/.svn                       " vcs
set wildignore+=tags,*.tags                               " tags
set wildmode=longest,list:full  " http://stackoverflow.com/a/526940/5228839
set wrap

set noautochdir
set noerrorbells
set nofoldenable
set nojoinspaces
set nolazyredraw
set noshiftround
set noshowcmd
set nostartofline
set noswapfile
set notitle
set novisualbell
set nowrapscan
set nowritebackup

if has('mac')
  set wildignore+=*.DS_Store  " macOS only
  Gautocmdft c,cpp,objc,objcpp source $XDG_CONFIG_HOME/nvim/macOS_header.vim  " only Go and C family filetype
endif

" -------------------------------------------------------------------------------------------------
" Neovim Configs:

let g:python3_host_prog = '/usr/local/bin/python3'
" Terminel settings
let g:terminal_scrollback_buffer_size = 100000
let s:num = 0
"        black      red        green      yellow     blue       magenta    cyan       white
for s:color in [
      \ '#101112', '#b24e4e', '#9da45a', '#f0c674', '#5f819d', '#85678f', '#5e8d87', '#707880',
      \ '#373b41', '#cc6666', '#a0a85c', '#f0c674', '#81a2be', '#b294bb', '#8abeb7', '#c5c8c6',
      \ ]
  let g:terminal_color_{s:num} = s:color
  let s:num += 1
endfor

" -------------------------------------------------------------------------------------------------
" Dein Hook Function:

"" Deoplete:
function! DeopleteConfig()
  call deoplete#custom#set('_', 'converters', ['converter_auto_paren', 'converter_remove_overlap'])
  call deoplete#custom#set('_', 'min_pattern_length', 1)
  call deoplete#custom#set('buffer', 'rank', 100)
  call deoplete#custom#set('go', 'matchers', ['matcher_fuzzy'])
  call deoplete#custom#set('go', 'sorters', [])
  call deoplete#custom#set('jedi', 'disabled_syntaxes', ['Comment'])
  call deoplete#custom#set('jedi', 'matchers', ['matcher_fuzzy'])
  call deoplete#custom#set('neosnippet', 'disabled_syntaxes', ['goComment'])"
  call deoplete#custom#set('ternjs', 'rank', 0)
  call deoplete#custom#set('vim', 'disabled_syntaxes', ['Comment'])
endfunction

"" Denite:
function! DeniteConfig()
  call denite#custom#map('insert', '<Down>', '<denite:move_to_next_line>', 'noremap')
  call denite#custom#map('insert', '<Up>', '<denite:move_to_previous_line>', 'noremap')

  call denite#custom#source('line', 'command', ['pt', '--nocolor', '--nogroup', '--follow', '--hidden', '-g', ''])

  call denite#custom#source('file_rec', 'matchers', ['matcher_cpsm'])
  call denite#custom#source('file_rec', 'sorters', ['sorter_sublime'])
  call denite#custom#var('file_rec', 'command', ['pt', '--follow', '--nocolor', '--nogroup', '--hidden', '-g', ''])
  call denite#custom#alias('source', 'file_rec/ag', 'file_rec')
  call denite#custom#var('file_rec/ag', 'command', ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
  call denite#custom#alias('source', 'file_rec/rg', 'file_rec')
  call denite#custom#var('file_rec/rg', 'command', ['rg', '--files', '--glob', '!.git'])

  call denite#custom#var('grep', 'command', ['pt'])
  call denite#custom#var('grep', 'default_opts', ['--follow', '--hidden', '--nocolor', '--nogroup', '--ignore="_*"'])
  call denite#custom#var('grep', 'recursive_opts', [])
  call denite#custom#var('grep', 'pattern_opt', ['-e'])
  call denite#custom#var('grep', 'separator', [])
  call denite#custom#var('grep', 'final_opts', [])

  call denite#custom#alias('source', 'grep/rg', 'grep')
  call denite#custom#var('grep/rg', 'command', ['rg'])
  call denite#custom#var('grep/rg', 'default_opts', ['--vimgrep', '--no-heading'])
  call denite#custom#var('grep/rg', 'recursive_opts', [])
  call denite#custom#var('grep/rg', 'pattern_opt', ['--regexp'])
  call denite#custom#var('grep/rg', 'separator', ['--'])
  call denite#custom#var('grep/rg', 'final_opts', [])

  let s:menus = {}
  let s:menus.zsh = {'description': 'Edit your import zsh configuration'}
  let s:menus.zsh.file_candidates = [['~/.zshrc'], ['zshenv', '~/.zshenv']]
  call denite#custom#var('menu', 'menus', s:menus)

  " for feature use
  let g:cpsm_highlight_mode = 'detailed'
  let g:cpsm_match_empty_query = 0
  let g:cpsm_max_threads = 9
  let g:cpsm_query_inverting_delimiter = ''
  let g:ctrlp_match_current_file = 0
  let g:cpsm_unicode = 1
endfunction

"" Gina:
function! GinaConfig()
  call gina#custom#command#option('commit', '-S|--signoff')
  call gina#custom#execute(
        \ '/\%(commit\)',
        \ 'setlocal colorcolumn=69 expandtab shiftwidth=4 softtabstop=4 tabstop=4 winheight=35',
        \)
  call gina#custom#execute(
        \ '/\%(status\|branch\|ls\|grep\|changes\|tag\)',
        \ 'setlocal winfixheight',
        \)
  call gina#custom#mapping#nmap(
        \ '/\%(commit\|status\|branch\|ls\|grep\|changes\|tag\)',
        \ 'q', ':<C-u> q<CR>', {'noremap': 1, 'silent': 1},
        \)
endfunction

"" YCM:
"" for behavior check and benchmark
function! YCMConfig()
  let g:ycm_auto_trigger = 1
  let g:ycm_min_num_of_chars_for_completion = 1
  let g:ycm_filetype_blacklist = {
        \ 'tagbar' : 1,
        \ 'pandoc' : 1,
        \ 'quickrun' : 1,
        \ 'markdown' : 1,
        \}
  let g:ycm_always_populate_location_list = 1
  let g:ycm_autoclose_preview_window_after_completion = 1
  let g:ycm_autoclose_preview_window_after_insertion = 1
  let g:ycm_collect_identifiers_from_comments_and_strings = 1
  let g:ycm_collect_identifiers_from_tags_files = 1
  let g:ycm_complete_in_comments = 1
  let g:ycm_confirm_extra_conf = 0
  let g:ycm_extra_conf_globlist = ['./*','../*']
  let g:ycm_filepath_completion_use_working_dir = 1
  let g:ycm_global_ycm_extra_conf = $XDG_CONFIG_HOME.'/nvim/.ycm_extra_conf.py'
  let g:ycm_goto_buffer_command = 'same-buffer'  " ['same-buffer', 'horizontal-split', 'vertical-split', 'new-tab', 'new-or-existing-tab']
  let g:ycm_key_list_select_completion = ['<Down>']
  let g:ycm_server_python_interpreter = g:python3_host_prog
  let g:ycm_seed_identifiers_with_syntax = 1

  autocmd! FileType rust nmap <buffer><C-]>  <C-u>YcmCompleter GoTo<CR>
endfunction

" -------------------------------------------------------------------------------------------------
" Dein:

let s:dein_cache = expand('$XDG_CACHE_HOME/nvim/dein')
let s:dein_dir = s:dein_cache . '/repos/github.com/Shougo/dein.vim'
let s:vimproc_dir = s:dein_cache . '/repos/github.com/Shougo/vimproc.vim'

if &runtimepath !~ '/dein.vim'
  if !isdirectory(s:dein_dir)
    call mkdir(fnamemodify(s:dein_dir, ':h'), 'p')
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_dir
    execute '!git clone https://github.com/Shougo/vimproc.vim' s:vimproc_dir
    execute '!cd ' . s:vimproc_dir '&& make'
  endif

  " Add dein and vimproc to &runtimepath
  execute 'set runtimepath^=' . s:dein_dir
  execute 'set runtimepath^=' . s:vimproc_dir
endif

" Set dein.vim variables
let g:dein#types#git#clone_depth = 1

" dein.vim configuration
"   hook_add:    A hook that is executed *before* the target plugin is loaded
"   hook_source: A hook that is executed *after* the target plugin is loaded
" Load dein cache if exists cache file
if dein#load_state(s:dein_cache)
  call dein#begin(s:dein_cache, expand('<sfile>'))

  " Develop Plugins:
  let s:gopath = expand('$GOPATH/src/github.com')
  let s:srcpath = expand('$HOME/src/github.com')

  call dein#local(s:gopath,  {'on_ft': ['go'], 'frozen': 1, 'merged': 0}, ['zchee/nvim-go'])
  call dein#local(s:srcpath, {'on_ft': ['go'], 'frozen': 1, 'merged': 0}, ['zchee/deoplete-go'])
  call dein#local(s:srcpath, {'on_ft': ['python', 'cython', 'pyrex'], 'frozen': 1, 'merged': 0}, ['zchee/deoplete-jedi'])
  call dein#local(s:srcpath, {'on_ft': ['c', 'cpp', 'objc', 'objcpp'], 'frozen': 1, 'merged': 0}, ['zchee/deoplete-clang'])
  call dein#local(s:srcpath, {'on_ft': ['dockerfile'], 'frozen': 1, 'merged': 0}, ['zchee/deoplete-docker'])
  call dein#local(s:srcpath, {'on_ft': ['sh', 'zsh'], 'frozen': 1, 'merged': 0}, ['zchee/deoplete-zsh'])
  call dein#local(s:srcpath, {'on_ft': ['fbs'], 'frozen': 1, 'merged': 0}, ['zchee/vim-flatbuffers'])
  call dein#local(s:srcpath, {'on_ft': ['gn'], 'frozen': 1, 'merged': 0}, ['zchee/vim-gn'])
  call dein#local(s:srcpath, {'on_ft': ['c', 'cpp', 'objc', 'objcpp', 'typescript'], 'frozen': 1, 'merged': 0, 'hook_add': 'call YCMConfig()'}, ['Valloric/YouCompleteMe'])

  " Dein:
  call dein#add('Shougo/dein.vim')
  "" Dependency:
  call dein#add('Shougo/vimproc.vim', {'build': 'make'})


  " Deoplete:
  call dein#add('Shougo/deoplete.nvim', {'hook_add': "call DeopleteConfig()"})
  "" Deopleet Suorces:
  call dein#add('mhartington/deoplete-typescript', {'on_ft': ['typescript', 'tsx', 'typescript.tsx']})
  call dein#add('carlitux/deoplete-ternjs', {'on_ft': ['javascript', 'es6']})
  call dein#add('mitsuse/autocomplete-swift', {'on_ft': ['swift']})
  call dein#add('sebastianmarkow/deoplete-rust', {'on_ft': ['rust']})
  " call dein#add('Shougo/context_filetype.vim')
  call dein#add('Shougo/neco-vim', {'on_ft': ['vim'], 'on_source': ['deoplete.nvim']})
  call dein#add('Shougo/neoinclude.vim', {'on_ft': ['c', 'cpp', 'objc', 'objcpp'], 'on_source': ['deoplete.nvim']})
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('Shougo/neosnippet.vim', {'depends': ['neosnippet-snippets']})
  "" Deopleet Support:
  call dein#add('Shougo/echodoc.vim', {'on_event': 'CompleteDone', 'hook_source': 'call echodoc#enable()'})
  call dein#add('Shougo/neopairs.vim', {'on_event': 'CompleteDone', 'hook_add': 'let g:neopairs#enable = 1'})


  " Denite:
  call dein#add('Shougo/denite.nvim', {'hook_add': "call DeniteConfig()"})
  "" Dependency:
  call dein#add('nixprime/cpsm')
  "" Denite Suorces:


  " Operator:
  call dein#add('kana/vim-operator-user')
  call dein#add('kana/vim-textobj-function')
  call dein#add('kana/vim-textobj-user')
  call dein#add('kana/vim-operator-replace',
        \ {'on_map': '<Plug>', 'depends': 'vim-operator-user'})
  call dein#add('rhysd/vim-operator-surround',
        \ {'on_map': '<Plug>', 'depends': 'vim-operator-user'})


  " Git:
  call dein#add('lambdalisue/gina.vim', {'on_cmd': 'Gina', 'hook_source': "call GinaConfig()"})
  call dein#add('airblade/vim-gitgutter')


  " Linter Formatter:
  call dein#add('neomake/neomake')
  call dein#add('sbdchd/neoformat', {'on_cmd': 'Neoformat'})


  " References:


  " Interface:
  call dein#add('cocopon/vaffle.vim')
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes', {'hook_add': "let g:airline_theme = 'hybridline'"})
  call dein#add('ryanoasis/vim-devicons', {'hook_add': "let g:airline_powerline_fonts = 1"})


  " Utility:
  call dein#add('tyru/caw.vim')
  call dein#add('thinca/vim-quickrun', {'on_cmd': 'QuickRun'})
  call dein#add('haya14busa/vim-asterisk', {'on_map': '<Plug>'})
  call dein#add('haya14busa/dein-command.vim', {'on_cmd': 'Dein'})
  call dein#add('itchyny/vim-parenmatch', {'on_event': 'VimEnter'})
  call dein#add('mattn/sonictemplate-vim', {'on_cmd': 'Template'})
  call dein#add('tyru/open-browser.vim')
  call dein#add('tyru/open-browser-github.vim', {'on_cmd': ['OpenGithubFile', 'OpenGithubIssue', 'OpenGithubPullReq']})
  call dein#add('rhysd/accelerated-jk', {'on_map': '<Plug>'})
  call dein#add('mbbill/undotree', {'on_cmd': ['UndotreeToggle']})

  " Debug:
  " call dein#add('critiqjo/lldb.nvim')
  call dein#add('yuratomo/dbg.vim', {'on_cmd': ['Dbg', 'DdgShell']})
  call dein#add('Conque-GDB', {'on_cmd': ['ConqueTerm', 'ConqueTermSplit', 'ConqueTermVSplit', 'ConqueTermTab', 'ConqueGdb', 'ConqueGdbSplit', 'ConqueGdbVSplit', 'ConqueGdbTab', 'ConqueGdbExe', 'ConqueGdbBDelete', 'ConqueGdbCommand']})


  "" Lifelog:
  call dein#add('wakatime/vim-wakatime')


  " Testing Plugin:
  call dein#add('godlygeek/tabular', {'on_cmd': 'Tabularize'})
  " call dein#add('fatih/vim-go')
  " call dein#add('chrisbra/Colorizer', {'on_cmd': ['ColorHighlight', 'RGB2Term', 'Term2RGB', 'ColorClear', 'ColorToggle', 'HSL2RGB', 'ColorContrast', 'ColorSwapFgBg']})
  " call dein#add('tweekmonster/startuptime.vim')
  " call dein#add('majutsushi/tagbar', {'on_cmd': 'TagbarToggle'})
  " call dein#add('scrooloose/nerdtree', {'lazy': 1})


  " -----------------------------------------------------------------------------
  " Language Plugin:

  "" Go:
  " call dein#add('garyburd/vigor', {'lazy': 1, 'on_ft': 'go'})
  call dein#add('tweekmonster/hl-goimport.vim', {'on_ft': 'go'})
  call dein#add('zchee/vim-go-slide')
  call dein#add('fatih/vim-go')

  "" C Family:
  call dein#add('vim-jp/vim-cpp')
  call dein#add('octol/vim-cpp-enhanced-highlight')
  call dein#add('lyuts/vim-rtags', {'on_ft': ['c', 'cpp', 'objc']})
  call dein#add('CoatiSoftware/vim-coati', {'on_ft': ['c', 'cpp', 'objc']})

  "" Python:
  call dein#add('davidhalter/jedi-vim', {'lazy': 1, 'on_ft': ['python', 'cython', 'pyrex']})
  call dein#add('hynek/vim-python-pep8-indent')
  call dein#add('nvie/vim-flake8')
  call dein#add('tweekmonster/impsort.vim', {'on_ft': ['python','cython', 'pyrex']})

  "" Rust:
  call dein#add('rust-lang/rust.vim', {'on_ft': ['rust']})
  call dein#add('racer-rust/vim-racer')
  call dein#add('rhysd/rust-doc.vim', {'on_ft': ['rust']})

  "" Swift:
  call dein#add('keith/swift.vim', {'on_ft': 'swift'})

  "" Serialization:
  call dein#add('uarun/vim-protobuf')

  "" LLVM:
  call dein#add('rhysd/vim-llvm')

  "" Assembly:
  call dein#add('Shirk/vim-gas')

  "" Binary:
  call dein#add('Shougo/vinarise.vim', {'on_cmd': 'Vinarise', 'hook_add': 'let g:vinarise_enable_auto_detect = 1'})

  "" TypeScript:
  call dein#add('leafgarland/typescript-vim')
  call dein#add('HerringtonDarkholme/yats.vim')

  "" Javascript:
  call dein#add('othree/yajs.vim')
  call dein#add('Shutnik/jshint2.vim')

  "" Markdown:
  call dein#add('moorereason/vim-markdownfmt', {'on_ft': 'markdown'})
  call dein#add('rhysd/vim-gfm-syntax', {'on_ft': 'markdown'})

  "" Vim:
  call dein#add('vim-jp/vimdoc-ja')
  call dein#add('vim-jp/syntax-vim-ex')

  "" Shell:
  call dein#add('chrisbra/vim-sh-indent')

  "" Toml:
  call dein#add('cespare/vim-toml')

  "" Json:
  call dein#add('elzr/vim-json')

  "" Tmux:
  call dein#add('tmux-plugins/vim-tmux')

  "" TinyScheme: for macOS sandbox-exec profile .sb filetype
  call dein#add('vim-scripts/vim-niji', {'on_ft': 'scheme'})

  "" Automation: for code validation
  call dein#add('vim-syntastic/syntastic')

  call dein#end()
  call dein#save_state()
endif

if !has('vim_starting') && dein#check_install()
  call dein#install()
endif


" -------------------------------------------------------------------------------------------------
" Ignore Plugins:

let g:did_install_default_menus = 1 " $VIMRUNTIME/menu.vim
let g:did_menu_trans            = 1 " $VIMRUNTIME/menu.vim
let g:load_doxygen_syntax       = 1 " $VIMRUNTIME/syntax/doxygen.vim
let g:loaded_2html_plugin       = 1 " $VIMRUNTIME/plugin/tohtml.vim
let g:loaded_gzip               = 1 " $VIMRUNTIME/plugin/gzip.vim
let g:loaded_less               = 1 " $VIMRUNTIME/macros/less.vim
let g:loaded_matchit            = 1 " $VIMRUNTIME/plugin/matchit.vim
let g:loaded_matchparen         = 1 " $VIMRUNTIME/plugin/matchparen.vim
let g:loaded_netrw              = 1 " $VIMRUNTIME/autoload/netrw.vim
let g:loaded_netrwFileHandlers  = 1 " $VIMRUNTIME/autoload/netrwFileHandlers.vim
let g:loaded_netrwPlugin        = 1 " $VIMRUNTIME/plugin/netrwPlugin.vim
let g:loaded_netrwSettings      = 1 " $VIMRUNTIME/autoload/netrwSettings.vim
let g:loaded_rrhelper           = 1 " $VIMRUNTIME/plugin/rrhelper.vim
let g:loaded_spellfile_plugin   = 1 " $VIMRUNTIME/plugin/spellfile.vim
let g:loaded_syntax_completion  = 1 " $VIMRUNTIME/autoload/syntaxcomplete.vim
let g:loaded_tar                = 1 " $VIMRUNTIME/autoload/tar.vim
let g:loaded_tarPlugin          = 1 " $VIMRUNTIME/plugin/tarPlugin.vim
let g:loaded_tutor_mode_plugin  = 1 " $VIMRUNTIME/plugin/tutor.vim
let g:loaded_vimball            = 1 " $VIMRUNTIME/autoload/vimball.vim
let g:loaded_vimballPlugin      = 1 " $VIMRUNTIME/plugin/vimballPlugin
let g:loaded_zip                = 1 " $VIMRUNTIME/autoload/zip.vim
let g:loaded_zipPlugin          = 1 " $VIMRUNTIME/plugin/zipPlugin.vim
let g:myscriptsfile             = 1 " $VIMRUNTIME/scripts.vim
let g:netrw_nogx                = 1
let g:suppress_doxygen          = 1 " $VIMRUNTIME/syntax/doxygen.vim

" -------------------------------------------------------------------------------------------------
" Color:

" Set colorscheme and config
let g:enable_bold_font = 1
set background=dark
" colorscheme hybrid_reverse

if !exists('g:syntax_on')
  syntax enable
endif
filetype plugin indent on

" Global:
hi TermCursor    gui=reverse   guifg=#ffffff    guibg=none
hi TermCursorNC  gui=reverse   guifg=#ffffff    guibg=none
hi ParenMatch    gui=underline guifg=none       guibg=#343941

" Go:
" vim-go-stdlib:
let g:go_highlight_error = 1
let g:go_highlight_return = 1
" #cc6666
hi goStdlibErr        gui=Bold    guifg=#ff005f    guibg=None
hi goString           gui=None    guifg=#92999f    guibg=None
hi goComment          gui=None    guifg=#787f86    guibg=None
hi goField            gui=Bold    guifg=#a1cbc5    guibg=None
hi link               goStdlib          Statement
hi link               goStdlibReturn    PreProc
hi link               goImportedPkg     Statement
hi link               goFormatSpecifier PreProc

" Python:
hi pythonSpaceError   gui=None    guifg=#787f86    guibg=#787f86
hi link pythonDelimiter    Special
hi link pythonNone    pythonFunction
hi link pythonSelf    pythonOperator
syn keyword pythonDecorator True False

" C:
let g:c_ansi_constants = 1
let g:c_ansi_typedefs = 1
let g:c_comment_strings = 1
let g:c_gnu = 0
let g:c_no_curly_error = 1
let g:c_no_tab_space_error = 1
let g:c_no_trail_space_error = 1
let g:c_syntax_for_h = 0
hi cCustomFunc  gui=Bold    guifg=#f0c674    guibg=None
hi cErr         gui=Bold    guifg=#ff005f    guibg=None

" Vim:
" quickfix:
Gautocmdft qf
      \ hi Search     gui=None    guifg=None  guibg=#373b41

" Sh:
let g:is_bash = 1

" Denite:
" guibg=#343941
hi! DeniteSearch guifg=#f0c674

" -------------------------------------------------------------------------------------------------
" Gautocmd:

" Global:
Gautocmd BufWinEnter *
      \ if line("'\"") > 1 && line("'\"") <= line("$") && &filetype != 'gitcommit' |
      \ execute "silent! keepjumps normal! g`\"zz"

" Go:
" plan9 assembly
Gautocmdft ia64 let b:caw_oneline_comment = '//' | let b:caw_wrap_oneline_comment = ['/*', '*/']

" Python Cython:
Gautocmd BufWritePre *.py Neomake

" C Family:

" Vim:
" nested autoload
Gautocmd BufWritePost $MYVIMRC,*.vim nested silent! source $MYVIMRC | setlocal colorcolumn=99
Gautocmd BufEnter option-window call LessMap()

" Sh:
Gautocmdft sh let g:sh_noisk=1
Gautocmd BufWritePre *.sh\|bash Neomake

" Markdown:
Gautocmdft markdown let g:sh_noisk=1

" Neosnippet:
Gautocmdft neosnippet call dein#source('neosnippet.vim')
" Clear neosnippet markers when InsertLeave
Gautocmd InsertLeave * NeoSnippetClearMarkers

" Gitcommit:
Gautocmd BufEnter COMMIT_EDITMSG startinsert
Gautocmdft gina-commit startinsert

" Dirvish:
" Gautocmdft dirvish let g:treachery#enable_autochdir = 0

" automatically close window
" http://stackoverflow.com/questions/7476126/how-to-automatically-close-the-quick-fix-window-when-leaving-a-file
function! AutoClose()
  let s:ft = getbufvar(winbufnr(winnr()), "&filetype")
  if winnr('$') == 1 &&
        \ s:ft == "qf" || s:ft == 'dirvish'
    quit!
  endif
endfunction
Gautocmd WinEnter * call AutoClose()

" macOS Frameworks and system header protection
Gautocmd BufNewFile,BufReadPost
      \ /System/Library/*,/Applications/Xcode*,/usr/include*,/usr/lib*
      \ setlocal readonly nomodified


" less like keymappnig
Gautocmdft
      \ godoc,
      \help,
      \man,
      \qf,
      \quickrun,
      \ref
      \ call LessMap()

Gautocmd TermOpen * setlocal sidescrolloff=0 scrolloff=0 statusline=%{b:term_title}

" misc
" Gautocmd CursorHold,FocusGained,InsertEnter * call vimproc#system("issw 'com.apple.keyboardlayout.Programmer Dvorak.keylayout.ProgrammerDvorak'")


" -------------------------------------------------------------------------------------------------
" Plugin Settings:

" Go:
"" Nvim Go:
let go#highlight#cgo = 1
let g:go#build#autosave = 1
let g:go#build#flags = ['-race']
let g:go#build#force = 0
let g:go#fmt#autosave  = 1
let g:go#fmt#mode = 'goimports'
let g:go#guru#keep_cursor = {
      \ 'callees'    : 0,
      \ 'callers'    : 0,
      \ 'callstack'  : 0,
      \ 'definition' : 1,
      \ 'describe'   : 0,
      \ 'freevars'   : 0,
      \ 'implements' : 0,
      \ 'peers'      : 0,
      \ 'pointsto'   : 0,
      \ 'referrers'  : 0,
      \ 'whicherrs'  : 0
      \ }
let g:go#guru#reflection = 0
let g:go#iferr#autosave = 0
let g:go#lint#golint#autosave = 0
let g:go#lint#golint#ignore = ['internal']
let g:go#lint#golint#mode = 'root'
let g:go#lint#govet#autosave = 0
let g:go#lint#govet#flags = ['-v', '-all', '-shadow']
let g:go#lint#metalinter#autosave = 0
let g:go#lint#metalinter#autosave#tools = ['vet', 'golint']
let g:go#lint#metalinter#deadline = '20s'
let g:go#lint#metalinter#skip_dir = ['internal', 'vendor', 'testdata', '__*.go', '*_test.go']
let g:go#lint#metalinter#tools = ['vet', 'golint']
let g:go#rename#prefill = 1
let g:go#snippets#loaded = 1
let g:go#terminal#height = 120
let g:go#terminal#start_insert = 1
let g:go#terminal#width = 120
let g:go#test#all_package = 0
let g:go#test#autosave = 0
let g:go#test#flags = ['-v']
let g:go#debug = 1       " debug
let g:go#debug#pprof = 0 " enable pprof

"" Vim Go:
" let g:go#use_vimproc = 1
" let g:go_asmfmt_autosave = 1
" let g:go_auto_type_info = 0
" let g:go_autodetect_gopath = 1
" let g:go_def_mapping_enabled = 0
" let g:go_def_mode = 'godef'
" let g:go_doc_command = 'godoc'
" let g:go_doc_options = ''
" let g:go_fmt_autosave = 1
" let g:go_fmt_command = 'goimports'
" let g:go_fmt_experimental = 1
" let g:go_loclist_height = 15
" let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck', 'gotype']
" let g:go_snippet_engine = 'neosnippet' " ultisnips
" let g:go_template_enabled = 0
" let g:go_term_enabled = 1
" let g:go_term_height = 30
" let g:go_term_width = 30
" highlight
let g:go_highlight_array_whitespace_error = 0    " default : 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_chan_whitespace_error = 0     " default : 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 0                    " default : 0
let g:go_highlight_format_strings = 1
let g:go_highlight_functions = 1                 " default : 0
let g:go_highlight_generate_tags = 1             " default : 0
let g:go_highlight_interfaces = 1                " default : 0
let g:go_highlight_methods = 1                   " default : 0
let g:go_highlight_operators = 1                 " default : 0
let g:go_highlight_space_tab_error = 0           " default : 1
let g:go_highlight_string_spellcheck = 0         " default : 1
let g:go_highlight_structs = 1                   " default : 0
let g:go_highlight_trailing_whitespace_error = 0 " default : 1


" C CXX ObjC Objcpp:
"" Rtags:
let g:rtagsJumpStackMaxSize = 1000
let g:rtagsMaxSearchResultWindowHeight = 15
let g:rtagsMinCharsForCommandCompletion = 100
let g:rtagsUseDefaultMappings = 0
let g:rtagsUseLocationList = 1

let g:cpp_class_scope_highlight = 1
let g:cpp_experimental_template_highlight = 1
let g:cpp_concepts_highlight = 1

"" Clang Format:
let g:clang_format#auto_format = 0
let g:clang_format#auto_format_on_insert_leave = 0
let g:clang_format#auto_formatexpr = 1
let g:clang_format#command = '/usr/local/bin/clang-format'
let g:clang_format#detect_style_file = 1
" example
let g:clang_format#style_options = {
      \ "Standard" : "C++11",
      \ "AllowShortIfStatementsOnASingleLine" : "true",
      \ "AlwaysBreakTemplateDeclarations" : "true",
      \ "AccessModifierOffset" : -4
      \ }


" Python:
let g:python_highlight_all = 1
let g:flake8_cmd = $HOME.'/.local/bin/flake8'
let g:flake8_show_in_gutter = 1
" Autopep8:
let g:autopep8_aggressive = 1
let g:autopep8_disable_show_diff = 1
let g:impsort_highlight_imported = 1
let g:impsort_highlight_star_imports = 1

" Javascript:
let g:syntastic_mode_map = {
\ "mode" : "active",
\ "active_filetypes" : ["javascript", "json"],
\ }

" Rust:
let g:rustfmt_autosave = 0


" OCaml:
" let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
" execute 'set rtp+=' . g:opamshare . '/merlin/vim'
let g:merlin_python_version = 3


" Markdown:
let g:markdownfmt_autosave = 0
" Gautocmd InsertLeave *.md,*.slide call vimproc#system("issw 'com.apple.keyboardlayout.Programmer Dvorak.keylayout.ProgrammerDvorak'")


" Quickfix:
" http://vim.wikia.com/wiki/Automatically_fitting_a_quickfix_window_height
function! AdjustWindowHeight(minheight, maxheight)
  let s:l = 1
  let s:n_lines = 0
  let s:w_width = winwidth(0)
  while s:l <= line('$')
    " number to float for division
    let s:l_len = strlen(getline(s:l)) + 0.0
    let s:line_width = s:l_len/s:w_width
    let s:n_lines += float2nr(ceil(s:line_width))
    let s:l += 1
  endw
  exe max([min([s:n_lines, a:maxheight]), a:minheight]) . "wincmd _"
endfunction
Gautocmdft qf call AdjustWindowHeight(5, 10)


" http://mattn.kaoriya.net/software/vim/20140523124903.html
let g:markdown_fenced_languages = [
      \ 'c',
      \ 'cpp',
      \ 'go',
      \ 'python',
      \ 'sh',
      \ 'vim',
      \ 'asm',
      \]
let g:slide_fenced_languages = [
      \ 'sh',
      \ 'c',
      \ 'cpp',
      \ 'go',
      \ 'python',
      \ 'vim',
      \ 'asm',
      \]


" Cursorword:
let g:cursorword = 0


" Accelerated JK:
let g:accelerated_jk_acceleration_limit = 50
let g:accelerated_jk_acceleration_table = [3, 15, 25, 35]


" -------------------------------------------------------------------------------------------------
" Plugin Setting:

let g:deoplete#auto_complete_delay = 0
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_camel_case = 0
let g:deoplete#enable_ignore_case = 0
let g:deoplete#enable_refresh_always = 0
let g:deoplete#auto_refresh_delay = 100
let g:deoplete#enable_smart_case = 1
let g:deoplete#file#enable_buffer_path = 1
let g:deoplete#max_list = 10000
" debug:
" call deoplete#enable_logging('DEBUG', $HOME.'/.local/var/log/nvim/python/deoplete.log')
" call deoplete#custom#set('core', 'debug_enabled', 1)
" call deoplete#custom#set('clang', 'debug_enabled', 1)
" call deoplete#custom#set('go', 'debug_enabled', 1)
" call deoplete#custom#set('jedi', 'debug_enabled', 1)
" omnifunc:
let g:deoplete#omni#input_patterns = {} " Initialize
let g:deoplete#omni#input_patterns.lua = ['\h\w*']
Gautocmdft go,python,ruby setlocal omnifunc=
" sources:
" let g:deoplete#sources = {}
" let g:deoplete#sources.gitcommit = ['buffer']

" ignore:
let g:deoplete#ignore_sources = {} " Initialize
let g:deoplete#ignore_sources._ = ['around']
let g:deoplete#ignore_sources.go =
      \ ['buffer', 'dictionary', 'member', 'omni', 'tag', 'syntax', 'around'] " wtf what around?
let g:deoplete#ignore_sources.python =
      \ ['buffer', 'dictionary', 'member', 'omni', 'tag', 'syntax', 'around'] " file/include conflicting deoplete-jedi
let g:deoplete#ignore_sources.c =
      \ ['dictionary', 'member', 'omni', 'tag', 'syntax', 'file/include', 'neosnippet', 'around']
let g:deoplete#ignore_sources.cpp    = g:deoplete#ignore_sources.c
let g:deoplete#ignore_sources.objc   = g:deoplete#ignore_sources.c

let g:deoplete#sources#go#auto_goos = 1
let g:deoplete#sources#go#cgo = 1
let g:deoplete#sources#go#cgo#libclang_path = '/usr/local/lib/libclang.dylib'
let g:deoplete#sources#go#cgo#sort_algo = 'priority' " alphabetical
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
let g:deoplete#sources#go#package_dot = 0
let g:deoplete#sources#go#pointer = 1
let g:deoplete#sources#go#sort_class = ['func', 'type', 'var', 'const', 'package']
let g:deoplete#sources#go#use_cache = 0
let g:deoplete#sources#go#json_directory = $XDG_CACHE_HOME.'/deoplete/go/darwin_amd64'

let g:deoplete#sources#clang#libclang_path = '/usr/local/lib/libclang.dylib'
let g:deoplete#sources#clang#clang_header = '/usr/local/lib/clang'
let g:deoplete#sources#clang#flags = [
  \ '-I/usr/include',
  \ '-I/usr/local/include',
  \ '-isysroot', $XCODE_DIR.'/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.12.sdk',
  \ ] " echo | clang -v -E -x c -
let g:deoplete#sources#jedi#statement_length = 0
let g:deoplete#sources#jedi#short_types = 0
let g:deoplete#sources#jedi#show_docstring = 1
let g:deoplete#sources#jedi#worker_threads = 2
let g:deoplete#sources#jedi#python_path = g:python3_host_prog

let g:racer_cmd = "/usr/local/bin/racer"
let g:racer_experimental_completer = 1
let g:racer_insert_paren = 1

let g:neosnippet#data_directory = $XDG_CACHE_HOME.'/nvim/neosnippet'
let g:neosnippet#enable_complete_done = 1
let g:neosnippet#enable_completed_snippet = 1
let g:neosnippet#expand_word_boundary = 0
let g:neosnippet_username = 'zchee'
let g:snips_author = 'Koichi Shiraishi'
let g:neosnippet#disable_runtime_snippets = {
   \   'c': 1,
   \ 'cpp': 1,
   \  'go': 1,
   \ }
let g:neosnippet#snippets_directory = $XDG_CONFIG_HOME.'/nvim/neosnippets'

let g:neopairs#enable = 1


" Airline:
let g:airline#extensions#quickfix#location_text = 'Location'
let g:airline#extensions#quickfix#quickfix_text = 'Quickfix'
let g:airline#extensions#tabline#buffers_label = 'b'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#exclude_preview = 1
let g:airline#extensions#tabline#excludes = []
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_splits = 1
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#show_tab_type = 1
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#switch_buffers_and_tabs = 1
let g:airline#extensions#tabline#tab_nr_type = 2 " splits and tab number
let g:airline#extensions#tabline#tabs_label = 't'
let g:airline#extensions#tagbar#enabled = 0
let g:airline#extensions#whitespace#mixed_indent_algo = 2
let g:airline#extensions#wordcount#enabled = 0
let g:airline_exclude_filetypes = []
let g:airline_inactive_collapse = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
" let g:airline_section_c = airline#section#create(['%<', 'readonly', ' ', 'path'])"


" Vaffle:
let g:vaffle_auto_cd = 1
let g:vaffle_force_delete = 1
let g:vaffle_show_hidden_files = 1


" VimRef:
let g:ref_cache_dir = expand('$XDG_CACHE_HOME/nvim/ref')
let g:ref_use_vimproc = 1
Gautocmd FileType ref call s:ref_my_settings()
function! s:ref_my_settings() abort
  " Overwrite settings.
  nmap <buffer> [Tag]t  <Plug>(ref-keyword)
  nmap <buffer> [Tag]p  <Plug>(ref-back)
  nnoremap <buffer> <TAB> <C-w>w
endfunction


" GitGutter:
let g:gitgutter_eager = 1
let g:gitgutter_enabled = 1
let g:gItgutter_highlight_lines = 0
let g:gitgutter_map_keys = 0
let g:gitgutter_max_signs = 1000
let g:gitgutter_realtime = 0
let g:gitgutter_sign_column_always = 1


" QuickRun:
Gautocmd WinEnter *
      \ if winnr('$') == 1 &&
      \   getbufvar(winbufnr(winnr()), "&filetype") == "quickrun" |
      \ q |
      \ endif
let g:quickrun_config = get(g:, 'quickrun_config', {})
let g:quickrun_config._ = {
      \ 'runner' : 'vimproc',
      \ 'runner/vimproc/updatetime' : 50,
      \ 'outputter' : 'quickfix',
      \ 'outputter/quickfix/open_cmd' : 'copen 35',
      \ 'outputter/buffer/running_mark' : ''
      \ }
" Go
let g:quickrun_config.go = {
      \ 'command': 'run',
      \ 'cmdopt' : '',
      \ 'exec': ['go %c %s %o -'],
      \ 'outputter' : 'buffer',
      \ 'outputter/buffer/split' : 'vertical botright 100',
      \ 'outputter/buffer/close_on_empty' : 1,
      \ }


" Neomake:
let g:neomake_open_list = 2
let g:neomake_python_enabled_makers = ['pyflakes', 'flake8']


" Jedivim:
let g:jedi#auto_initialization = 0
let g:jedi#use_splits_not_buffers = ''
let g:jedi#auto_vim_configuration = 0
let g:jedi#completions_enabled = 0
let g:jedi#documentation_command = "K"
let g:jedi#force_py_version = 3
let g:jedi#max_doc_height = 150
let g:jedi#popup_select_first = 0
let g:jedi#show_call_signatures = 0
let g:jedi#smart_auto_mappings = 0


" Caw:
let g:caw_hatpos_skip_blank_line = 0
let g:caw_no_default_keymappings = 1
let g:caw_operator_keymappings = 0


" Grammarous:
let g:grammarous#languagetool_cmd = 'languagetool'
let g:grammarous#default_comments_only_filetypes = {
      \ '*' : 1,
      \ 'help' : 0,
      \ 'markdown' : 0,
      \ }


" SonicTemplate:
let g:sonictemplate_vim_template_dir = [
      \ $HOME.'/.nvim/template'
      \]


" Tagbar:
let g:tagbar_ctags_bin = '/usr/local/bin/ctags'
let g:tagbar_width = 80
" Gautocmd BufEnter *.go nested :call tagbar#autoopen(0)


" Wakatime:
let g:wakatime_PythonBinary = g:python3_host_prog


" -------------------------------------------------------------------------------------------------
" Command:

" SourceDarwinHeader
command! SourceDarwinHeader source $XDG_CONFIG_HOME/nvim/macOS_header.vim

" Capture:
" http://qiita.com/sgur/items/9e243f13caa4ff294fa8
command! -nargs=+ -complete=command Capture QuickRun -type vim -src <q-args>

" Shfmt:
command! -nargs=0 -bang -complete=command Shfmt %!shfmt -i 2

" FormatJson:
command! -nargs=0 -bang -complete=command FormatJson %!python -m json.tool

" ProfileSyntax:
command! -nargs=0 -bang -complete=command ProfileSyntax call ProfileSyntax()


" -------------------------------------------------------------------------------------------------
" Functions:

" https://github.com/neovim/neovim/blob/master/runtime/vimrc_example.vim
" When editing a file, always jump to the last known cursor position.  Don't
" do it when the position is invalid or when inside an event handler
" Also don't do it when the mark is in the first line, that is the default
" Posission when opening a file
" Gautocmd BufWinEnter *
"       \ if line("'\"") > 1 && line("'\"") <= line("$") && &filetype != 'gitcommit' |
"       \ execute "keepjumps normal! g`\"zz"


" Smart help window
" https://github.com/rhysd/dotfiles/blob/master/nvimrc#L380-L405
function! s:smart_help(args)
  try
    if winwidth(0) > winheight(0) * 2
      execute 'vertical rightbelow help ' . a:args
    else
      execute 'rightbelow help ' . a:args
    endif
  catch /^Vim\%((\a\+)\)\=:E149/
    echohl ErrorMsg
    echomsg "E149: Sorry, no help for " . a:args
    echohl None
  endtry
endfunction
command! -nargs=* -complete=help Help call <SID>smart_help(<q-args>)

" SmartHelpGrep
function! s:smart_helpgrep(args)
  try
    if winwidth(0) > winheight(0) * 2
      execute 'vertical rightbelow helpgrep ' . a:args . '@ja'
    else
      execute 'rightbelow helpgrep ' . a:args . '@ja'
    endif
  catch /^Vim\%((\a\+)\)\=:E149/
    echohl ErrorMsg
    echomsg "E149: Sorry, no help for " . a:args
    echohl None
  endtry
  copen
endfunction
command! -nargs=* -complete=help HelpGrep call <SID>smart_helpgrep(<q-args>)


" Display syntax infomation on under the current cursor
" for syntax ID
function! s:get_syn_id(transparent)
  let s:synid = synID(line("."), col("."), 1)
  if a:transparent
    return synIDtrans(s:synid)
  else
    return s:synid
  endif
endfunction
" for syntax attributes
function! s:get_syn_attr(synid)
  let s:name = synIDattr(a:synid, "name")
  if has('nvim')
    let s:guifg = synIDattr(a:synid, "fg", "gui")
    let s:guibg = synIDattr(a:synid, "bg", "gui")
    let s:attr = {
          \ "name": s:name,
          \ "guifg": s:guifg,
          \ "guibg": s:guibg,
          \ }
  else
    let s:ctermfg = synIDattr(a:synid, "fg", "cterm")
    let s:ctermbg = synIDattr(a:synid, "bg", "cterm")
    let s:attr = {
          \ "name": s:name,
          \ "ctermfg": s:ctermfg,
          \ "ctermbg": s:ctermbg,
          \ }
  endif
  return s:attr
endfunction
" return syntax information
function! s:get_syn_info(cword)
  let s:baseSyn = s:get_syn_attr(s:get_syn_id(0))
  if has('nvim')
    let s:baseSynInfo = "name: " . s:baseSyn.name .
          \ " guifg: " . s:baseSyn.guifg .
          \ " guibg: " . s:baseSyn.guibg
  else
    let s:baseSynInfo = "name: " . s:baseSyn.name .
          \ " ctermfg: " . s:baseSyn.ctermfg .
          \ " ctermbg: " . s:baseSyn.ctermbg
  endif
  let s:linkedSyn = s:get_syn_attr(s:get_syn_id(1))
  if has('nvim')
    let s:linkedSynInfo =  "name: " . s:linkedSyn.name .
          \ " guifg: " . s:linkedSyn.guifg .
          \ " guibg: " . s:linkedSyn.guibg
  else
    let s:linkedSynInfo =  "name: " . s:linkedSyn.name .
          \ " ctermfg: " . s:linkedSyn.ctermfg .
          \ " ctermbg: " . s:linkedSyn.ctermbg
  endif
  echomsg a:cword . ':'
  echomsg s:baseSynInfo
  echomsg '  ' . "link to"
  echomsg s:linkedSynInfo
endfunction
command! SyntaxInfo call s:get_syn_info(expand('<cword>'))


" Clear message logs
command! ClearMessage for n in range(200) | echom "" | endfor


" Binary edit mode
" need open nvim with `-b` flag
function! BinaryMode() abort
  if !has('binary')
    echoerr "BinaryMode must be 'binary' option"
    return
  endif

  execute '%!xxd'
endfunction


" less like mappings
function! LessMap()
  set colorcolumn=""
  let b:gitgutter_enabled = 0
  " less likes keymap
  nnoremap <silent><buffer>u <C-u>
  nnoremap <silent><buffer>d <C-d>
  nnoremap <silent><buffer>q :q<CR>
endfunction

" Profiling Syntax
function! ProfileSyntax() abort
  " Initial and cleanup syntime
  redraw!
  syntime clear
  " Profiling syntax regexp
  syntime on
  redraw!
  QuickRun -type vim -src 'syntime report'
endfunction

" Open C/C++ online document
" https://github.com/rhysd/dogfiles/blob/926f2b9c1856bbf3a8090f430831f2c94d7cc410/vimrc#L1399-L1423
function! s:open_online_cfamily_doc()
  call dein#source('open-browser.vim')
  let l:l = getline('.')

  if l:l =~# '^\s*#\s*include\s\+<.\+>'
    let l:header = matchstr(l, '^\s*#\s*include\s\+<\zs.\+\ze>')
    if header =~# '^boost'
      "https://www.google.co.jp/search?hl=en&as_q=int64_max&as_sitesearch=cpprefjp.github.io
      execute 'OpenBrowser' 'http://www.google.com/cse?cx=011577717147771266991:jigzgqluebe&q='.matchstr(header, 'boost/\zs[^/>]\+\ze')
      return
    else
      execute 'OpenBrowser' 'http://ja.cppreference.com/mwiki/index.php?title=Special:Search&search='.matchstr(header, '\zs[^/>]\+\ze')
      return
    endif
  else
    let l:cword = expand('<cword>')
    if cword ==# ''
      return
    endif
    let l:line_head = getline('.')[:col('.')-1]
    if line_head =~# 'boost::[[:alnum:]:]*$'
      execute 'OpenBrowser' 'http://www.google.com/cse?cx=011577717147771266991:jigzgqluebe&q='.l:cword
    elseif line_head =~# 'std::[[:alnum:]:]*$'
      execute 'OpenBrowser' 'https://www.google.co.jp/search?hl=en&as_sitesearch=cpprefjp.github.io&as_q='.l:cword
      execute 'OpenBrowser' 'http://ja.cppreference.com/mwiki/index.php?title=Special:Search&search='.l:cword
    else
      let l:name = synIDattr(synIDtrans(synID(line("."), col("."), 1)), 'name')
      if l:name == 'Statement'
        execute 'OpenBrowser' 'http://ja.cppreference.com/w/c/language/'.l:cword
      else
        execute 'OpenBrowser' 'http://ja.cppreference.com/mwiki/index.php?title=Special:Search&search='.l:cword
      endif
    endif
  endif
endfunction


" MarkdownSyntaxInclude
function! s:MarkdownRefreshGoSyntax()
  MarkdownSyntaxInclude go
  MarkdownSyntaxInclude sh
  MarkdownRefreshSyntax
endfunction


" Trim whitespace
function! s:trimSpace()
  if !&binary && &filetype != 'diff' && &filetype != 'markdown'
    normal mz
    normal Hmy
    %s/\s\+$//e
    normal 'yz<CR>
    normal `z
  endif
endfunction
command! TrimSpace call s:trimSpace()


" CursorHold-example
function! PreviewWord()
  if &previewwindow " プレビューウィンドウ内では実行しない
    return
  endif
  let w = expand("<cword>") " カーソル下の単語を得る
  if w =~ '\a' " その単語が文字を含んでいるなら

    " 別のタグを表示させる前にすでに存在するハイライトを消去する
    silent! wincmd P " プレビューウィンドウにジャンプ
    if &previewwindow	 " すでにそこにいるなら
      match none " 存在するハイライトを消去する
      wincmd p " もとのウィンドウに戻る
    endif

    " カーソル下の単語にマッチするタグを表示してみる
    try
      exe "ptag " . w
    catch
      return
    endtry

    silent! wincmd P " プレビューウィンドウにジャンプ
    if &previewwindow " すでにそこにいるなら
      if has("folding")
        silent! .foldopen " 閉じた折り畳みを開く
      endif
      call search("$", "b") " 前の行の最後へ
      let w = substitute(w, '\\', '\\\\', "")
      call search('\<\V' . w . '\>') " カーソルをマッチしたところへ
      " ここで単語にハイライトをつける
      hi previewWord term=bold ctermbg=green guibg=green
      exe 'match previewWord "\%' . line(".") . 'l\%' . col(".") . 'c\k*"'
      wincmd p			" もとのウィンドウへ戻る
    endif
  endif
endfun
" au! CursorHold *.[ch] nested call PreviewWord()


function! s:editInit()
  vsplit $XDG_CONFIG_HOME/nvim/init.vim
endfunction
command! EditInit call s:editInit()


" :Lr <lr-args> to browse lr(1) results in a new window,
"               press return to open file in new window.
command! -nargs=* -complete=file Lr
      \ new | setl bt=nofile noswf | silent exe "0r!lr -Q " <q-args> |
      \ 0 | res | map <buffer><C-M> $<C-W>F<C-W>_

" -------------------------------------------------------------------------------------------------
" Keymap:
"
" For Kinesis Advantage With Programmer Dvorak.
" Global & Local MapLeader are arranged in the center of the keyboard.
"
"   - Global MapLeader: <Space> " Righthand
"   - Local MapLeader : <BS>    " Lefthand
"   - Local prefix    : ,       " Lefthand
"
" TODO(zchee):
"   Swaps semicolon and colon to ideal at Kinesis hardware level. Now use direct edited macOS key dictionary
"   Use Kinesis Advantage2 instead of.
"
" Vim remappable keys
"   - <Space>
"   - ,       : Reverse repeat for f, t, F, T
"   - s       : Substituted by cl
"   - t       : Never use it in normal mode, f -> ... -> h hinstead of
"   - m       : For sets marker, never use it also
"
"   - http://deris.hatenablog.jp/entry/2013/05/02/192415
"
" -------------------------------------------------------------------------------------------------
" Map Leader:

nnoremap <Space> <Nop>
nnoremap <BS>    <Nop>
if !exists('g:mapleader')
  let g:mapleader = "\<Space>"
endif
if !exists('g:maplocalleader')
  let g:maplocalleader = "\<BS>"
endif

" Kinesis Advantage + Dvorak Lefthand
nnoremap <silent><Leader>h        :<C-u>Help<Space><C-l>
nnoremap <silent><Leader>l        :<C-u>Denite line<CR>
nnoremap <silent><Leader>w        :<C-u>w<CR>
nnoremap <silent><Leader>ga       :<C-u>Gina add %<CR>
nnoremap <silent><Leader>gc       :<C-u>Gina commit<CR>
nnoremap <silent><Leader>gp       :<C-u>Gina push<CR>
nnoremap <silent><Leader>gs       :<C-u>Gina status<CR>

" Kinesis Advantage + Dvorak Righthand
nnoremap <silent><LocalLeader>-   :<C-u>split<CR>
nnoremap <silent><LocalLeader>/   :<C-u>Denite -buffer-name=search line -highlight-matched-char=DeniteSearch<CR>
nnoremap <silent><LocalLeader>\   :<C-u>vsplit<CR>
nnoremap <silent><LocalLeader>q   :<C-u>q<CR>
" nnoremap <silent><LocalLeader>r   :<C-u>write<CR> :QuickRun<CR>
nnoremap <silent><LocalLeader>w   :<C-u>w<CR>

" Local key prefix
nnoremap <silent>.n   gt
nnoremap <silent>.p   gT
nnoremap <silent>.r   <C-w>r<C-w>w
nnoremap <silent>.s   :bNext<CR>
nnoremap <silent>.t   :<C-u>tabnew<CR>:call feedkeys(":e")<CR>
nnoremap <silent>.v   :<C-u>vsplit<CR><C-w>w
nnoremap <silent>.w   <C-w>w
nnoremap <silent>.z   :<C-u>split<CR><C-w>w

" -------------------------------------------------------------------------------------------------
" Map: (m)

"" Operator:
map <silent>ti <Plug>(operator-surround-append)
map <silent>td <Plug>(operator-surround-delete)
map <silent>tr <Plug>(operator-surround-replace)

" -------------------------------------------------------------------------------------------------
" Normal: (n)

" When type 'x' key(delete), do not add yank register
" Jump marked line
" Don't use Ex mode, use Q for formatting
" Disable suspend
" Go to first and end using capitalized directions
" Switch @ and ^ for Dvorak pinky

" nmap j <Plug>(accelerated_jk_gj_position)
" nmap k <Plug>(accelerated_jk_gk_position)
nmap <nowait>j <Plug>(accelerated_jk_gj)
nmap <nowait>k <Plug>(accelerated_jk_gk)
nnoremap     s         A
nnoremap     x         "_x
nnoremap     zj        zjzt
nnoremap     zk        2zkzjzt
nnoremap     Q         gq
nnoremap     ZQ        <Nop>
nmap <silent>*         <Plug>(asterisk-gz*)
nnoremap     @         ^
nnoremap     ^         @
nnoremap <silent>g*              :<C-u>DeniteCursorWord -buffer-name=search -mode=normal line<CR>
nnoremap <silent>.g              :<C-u>Denite -buffer-name=search -no-empty -mode=normal grep<CR>
nnoremap <silent>ft              :<C-u>Denite filetype<CR>
nnoremap <silent>tt              :<C-u>DeniteCursorWord -buffer-name=tag -immediately  unite:tag unite:tag/include<CR>
nnoremap <silent>[Window]<Space> :<C-u>Denite file_rec:~/.vim/rc<CR>
nnoremap <silent>[Window]s       :<C-u>Denite file_point file_old `finddir('.git', ';') != '' ? 'file_rec/git' : 'file_rec'`<CR>"

nnoremap <silent><C-g> :<C-u>Denite grep -no-empty<CR>
nnoremap <silent><C-p> :<C-u>DeniteProjectDir file_rec<CR>
nnoremap <silent><C-q> :nohlsearch<CR>
nnoremap <silent>-     :<C-u>Vaffle %:p:h<CR>

" http://ku.ido.nu/post/90355094974/how-to-grep-a-word-under-the-cursor-on-vim
nnoremap <silent><M-h>  :<C-u>Help<Space><C-r><C-w><CR>

" Jump to match pair brackets
" <Tab> and <C-i> are similar treatment. Need <C-i> for jump to next taglist
nnoremap <S-Tab>  %

" open-browser
nmap     <silent>gx  <Plug>(openbrowser-smart-search)

"" Go:
Gautocmdft go nmap  <silent><buffer>K                   <Plug>(go-doc)
Gautocmdft go nmap  <silent><buffer><LocalLeader>]      :<C-u>GoGeneDefinition<CR>
Gautocmdft go nmap  <silent><buffer><C-]>               :<C-u>call GoGuru('definition')<CR>
Gautocmdft go nmap  <silent><buffer><Leader>]           :<C-u>Godef<CR>
" MapLeader Left hand
Gautocmdft go nmap  <silent><buffer><Leader>a           <Plug>(nvim-go-analyze-buffer)
Gautocmdft go nmap  <silent><buffer><Leader>e           <Plug>(nvim-go-rename)
Gautocmdft go nmap  <silent><buffer><Leader>i           <Plug>(nvim-go-iferr)
" MapLeader Right hand
Gautocmdft go nmap  <silent><buffer><LocalLeader>db     :<C-u>DlvBreakpoint<CR>
Gautocmdft go nmap  <silent><buffer><LocalLeader>dc     :<C-u>DlvContinue<CR>
Gautocmdft go nmap  <silent><buffer><LocalLeader>dd     :<C-u>DlvDebug<CR>
Gautocmdft go nmap  <silent><buffer><LocalLeader>dn     :<C-u>DlvNext<CR>
Gautocmdft go nmap  <silent><buffer><LocalLeader>dr     :<C-u>DlvBreakpoint<CR>
Gautocmdft go nmap  <silent><buffer><LocalLeader>b      <Plug>(nvim-go-build)
Gautocmdft go nmap  <silent><buffer><LocalLeader>gc     <Plug>(nvim-go-callers)
Gautocmdft go nmap  <silent><buffer><LocalLeader>gcs    <Plug>(nvim-go-callstack)
Gautocmdft go nmap  <silent><buffer><LocalLeader>ge     <Plug>(nvim-go-callees)
Gautocmdft go nmap  <silent><buffer><LocalLeader>gi     <Plug>(nvim-go-implements)
Gautocmdft go nmap  <silent><buffer><LocalLeader>gl     <Plug>(nvim-go-metalinter)
Gautocmdft go nmap  <silent><buffer><LocalLeader>gr     <Plug>(nvim-go-referrers)
Gautocmdft go nmap  <silent><buffer><LocalLeader>gs     <Plug>(nvim-go-switch-test)
Gautocmdft go nmap  <silent><buffer><LocalLeader>l      <Plug>(nvim-go-lint)
Gautocmdft go nmap  <silent><buffer><LocalLeader>r      <Plug>(nvim-go-run)
Gautocmdft go nmap  <silent><buffer><LocalLeader>t      <Plug>(nvim-go-test)
Gautocmdft go nmap  <silent><buffer><LocalLeader>v      <Plug>(nvim-go-vet)

"" C CXX ObjC:
Gautocmdft c,cpp,objc,objcpp,proto map      <buffer><Leader>x   <Plug>(operator-clang-format)
Gautocmdft c,cpp,objc,objcpp,proto nmap     <buffer><Leader>C   :ClangFormatAutoToggle<CR>
Gautocmdft c,cpp,objc,objcpp,proto nnoremap <buffer><Leader>cf  :<C-u>ClangFormat<CR>
Gautocmdft c,cpp,objc,objcpp,proto vnoremap <buffer><Leader>cf  :ClangFormat<CR>
Gautocmdft c,cpp nnoremap <silent><buffer>K :<C-u>call <SID>open_online_cfamily_doc()<CR>
""" Rtags:
Gautocmdft c,cpp,objc,objcpp nnoremap <silent><buffer><C-]>            :<C-u>call rtags#JumpTo(g:SAME_WINDOW)<CR>
Gautocmdft c,cpp,objc,objcpp nnoremap <silent><buffer><LocalLeader>cb  :<C-u>call rtags#JumpBack()<CR>
Gautocmdft c,cpp,objc,objcpp nnoremap <silent><buffer><LocalLeader>cc  :<C-u>call rtags#FindRefs()<CR>
Gautocmdft c,cpp,objc,objcpp nnoremap <silent><buffer><LocalLeader>cC  :<C-u>call rtags#FindSuperClasses()<CR>
Gautocmdft c,cpp,objc,objcpp nnoremap <silent><buffer><LocalLeader>cf  :<C-u>call rtags#FindSubClasses()<CR>
Gautocmdft c,cpp,objc,objcpp nnoremap <silent><buffer><LocalLeader>cn  :<C-u>call rtags#FindRefsByName(input("Pattern? ", "", "customlist,rtags#CompleteSymbols"))<CR>
Gautocmdft c,cpp,objc,objcpp nnoremap <silent><buffer><LocalLeader>cp  :<C-u>call rtags#JumpToParent()<CR>
Gautocmdft c,cpp,objc,objcpp nnoremap <silent><buffer><LocalLeader>cs  :<C-u>call rtags#FindSymbols(input("Pattern? ", "", "customlist,rtags#CompleteSymbols"))<CR>
Gautocmdft c,cpp,objc,objcpp nnoremap <silent><buffer><Leader>u        :<C-u>call rtags#SymbolInfo()<CR>
Gautocmdft c,cpp,objc,objcpp nnoremap <silent><buffer><LocalLeader>cu  :<C-u>call rtags#SymbolInfo()<CR>
Gautocmdft c,cpp,objc,objcpp nnoremap <silent><buffer><LocalLeader>cv  :<C-u>call rtags#FindVirtuals()<CR>
Gautocmdft c,cpp,objc,objcpp nnoremap <silent><buffer><Space>]         :<C-u>YcmCompleter GoTo<CR>
Gautocmdft c,cpp,objc,objcpp nnoremap <silent><buffer><LocalLeader>]   :<C-u>tag <C-r>=expand("<cword>")<CR><CR>

"" Rust:
Gautocmdft rust nmap <buffer><C-]>    <Plug>(rust-def)
Gautocmdft rust nmap <buffer><C-S-]>  <Plug>(rust-def-vertical)
Gautocmdft rust nmap <buffer>K        <Plug>(rust-doc)

"" Python Cython:
Gautocmdft python,cython nnoremap <silent><buffer>K          :<C-u>call jedi#show_documentation()<CR>
Gautocmdft python,cython nnoremap <silent><buffer><C-]>      :<C-u>call jedi#goto()<CR>
Gautocmdft python,cython nnoremap <silent><buffer><C-e>      :<C-u>call jedi#rename()<CR>
Gautocmdft python,cython nnoremap <silent><buffer><C-f>      :<C-u>call Flake8()<CR><C-w>w :call feedkeys("<Up>")<CR>
Gautocmdft python,cython nnoremap <silent><buffer><Leader>]  :<C-u>tag <c-r>=expand("<cword>")<CR><CR>
Gautocmdft python,cython nnoremap <silent><buffer><Leader>e  :<C-u>call jedi#rename_visual()<CR>
Gautocmdft python,cython nnoremap <silent><buffer><Leader>m  :<C-u>messages<CR>

"" Vim:
Gautocmdft vim nnoremap <silent><LocalLeader>h :<C-u>Help<Space><C-r><C-w><CR>
Gautocmdft vim nnoremap <silent><buffer>K      :<C-u>SmartHelp<Space><C-r><C-w><CR>

"" Vim Help:
Gautocmdft help nnoremap <silent><buffer><C-n> :<C-u>cnext<CR>
Gautocmdft help nnoremap <silent><buffer><C-p> :<C-u>cprevious<CR>

"" Vim Ouickfix:
" Re enable <CR> in quickfix and locationlist
Gautocmdft qf  nnoremap <buffer><CR>      <CR>

"" Markdown:
Gautocmdft markdown nmap <silent><LocalLeader>f  :<C-u>call markdownfmt#Format()<CR>

" -------------------------------------------------------------------------------------------------
" Insert: (i)

" Move cursor to first or end of line
inoremap <silent><C-a>  <C-o><S-i>
inoremap <silent><C-e>  <C-o><S-a>
" Put +register word
inoremap <silent><C-p>  <C-r>*
inoremap <silent><C-j>  <C-r>*

" deoplete
inoremap <silent><expr><CR>     pumvisible() ? deoplete#mappings#close_popup() : "\<CR>"
inoremap <silent><expr><Tab>    pumvisible() ? "\<C-n>".deoplete#mappings#close_popup() : "\<Tab>"
" inoremap <silent><expr><BS>     pumvisible() ? deoplete#mappings#refresh()."\<BS>" : "\<BS>"
inoremap <silent><expr><Up>     pumvisible() ? "\<C-p>"  : "\<Up>"
inoremap <silent><expr><Down>   pumvisible() ? "\<C-n>"  : "\<Down>"
inoremap <silent><expr><C-Up>   pumvisible() ? deoplete#mappings#cancel_popup()."\<Up>" : "\<C-Up>"
inoremap <silent><expr><C-Down> pumvisible() ? deoplete#mappings#cancel_popup()."\<Down>" : "\<C-Down>"
inoremap <silent><expr><Left>   pumvisible() ? deoplete#mappings#cancel_popup()."\<Left>"  : "\<Left>"
inoremap <silent><expr><Right>  pumvisible() ? deoplete#mappings#cancel_popup()."\<Right>" : "\<Right>"
inoremap <silent><expr><C-l>    pumvisible() ? deoplete#mappings#refresh() : "\<C-l>"
inoremap <silent><expr><C-z>    deoplete#mappings#undo_completion()
" neosnippet
imap <expr><C-k> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : ""

"" Go:
Gautocmdft go inoremap <buffer> "    '
Gautocmdft go inoremap <buffer> '    "

"" Swift:
Gautocmdft swift imap <buffer><C-k>  <Plug>(autocomplete_swift_jump_to_placeholder)

" -------------------------------------------------------------------------------------------------
" Visual Select: (v)

" Do not add register to current cursor word
vnoremap c       "_c
vnoremap x       "_x
vnoremap P       "_dP
vnoremap p       "_dp
vnoremap @       ^
vnoremap ^       @
" sort alphabetically
vnoremap <silent>gs :<C-u>'<,'>sort i<CR>
vnoremap v $h
" Move to start of line
vnoremap V ^
" Jump to match pair brackets
vnoremap <S-Tab> %

vmap <silent>gx  <Plug>(openbrowser-smart-search)
nmap <silent>gc  <Plug>(caw:hatpos:toggle)
vmap <silent>gc  <Plug>(caw:hatpos:toggle)

"" Go:
Gautocmdft go vnoremap <buffer> "  '
Gautocmdft go vnoremap <buffer> '  "
"" C:
Gautocmdft c  vnoremap <buffer> <c-f> :call RangeUncrustify('c')<CR>

" -------------------------------------------------------------------------------------------------
" Visual: (x)
xmap <LocalLeader>            <Plug>(operator-replace)

"" Go:
Gautocmdft go xnoremap <buffer> "  '
Gautocmdft go xnoremap <buffer> '  "

" -------------------------------------------------------------------------------------------------
" Select: (s)

" neosnippet
smap <expr><C-k> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : ""

"" Go:
Gautocmdft go snoremap <buffer> "  '
Gautocmdft go snoremap <buffer> '  "

" -------------------------------------------------------------------------------------------------
" CommandLine: (c)

" Move beginning of the command line
" http://superuser.com/a/988874/483994
cnoremap <C-a>    <Home>
cnoremap <C-d>    <Del>

" -------------------------------------------------------------------------------------------------
" Terminal: (t)

" Emacs like mapping
tnoremap <S-Left>        <C-[>b
tnoremap <C-Left>        <C-[>b
tnoremap <S-Right>       <C-[>f
tnoremap <C-Right>       <C-[>f
tnoremap <nowait><buffer><BS>    <BS>

" qq to exit to terminal mode
tnoremap <silent>jj  <C-\><C-n>

" -------------------------------------------------------------------------------------------------

