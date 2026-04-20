" this configuration is based on: https://gist.github.com/kxxoling/dcc1c3a897e6735989f32b55ef069136
" (make sure to remove default Obsidian shortcuts for these to work)

" yank to system clipboard
set clipboard=unnamed

" let map <silent>leader=" "
" can't set leaders in Obsidian vim, so the key just has to be used consistently.
" however, it needs to be unmap <silent>ped, to not trigger default behavior: https://forum.obsidian.md/t/how-to-set-leader-key-for-vim-mode-and-some-keybindings-using-it/48142/2
unmap <Space>

" some vim commands for the spammers
exmap wa w
exmap xa obcommand workspace:close-window
exmap wq obcommand workspace:close
exmap q obcommand workspace:close

" have j and k navigate visual lines rather than logical ones
nmap j gj
nmap k gk
vmap j gj
vmap k gk

" " Improved vim cursor
" nmap 0 :g0
" nmap $ :gDollar
" nmap [[ :pHead
" nmap ]] :nHead

" open help
exmap help obcommand app:open-help
nmap <F1> :help

" rename file
exmap renameFile obcommand Obsidian-VimEx:file-rename-modal
nmap <F2> :renameFile

" indent/outdent highlighted area
vmap > >gv
vmap < <gv

" go back and forward with Ctrl+O and Ctrl+I
exmap back obcommand app:go-back
nmap <C-o> :back
exmap forward obcommand app:go-forward
nmap <C-i> :forward

" move between tabs with Tab and shift tab in normal mode
exmap ntab obcommand workspace:next-tab
nmap <Tab> :ntab
exmap ptab obcommand workspace:previous-tab
nmap <S-Tab> :ptab

" create new tab
exmap newtab obcommand workspace:new-tab
nmap <C-t> :newtab

" " Emulate Tab Switching https://vimhelp.org/tabpage.txt.html#gt
" " requires Pane Relief: https://github.com/pjeby/pane-relief
" exmap tabnext obcommand pane-relief:go-next
" nmap gt :tabnext
" exmap tabprev obcommand pane-relief:go-prev
" nmap gT :tabprev
" " Same as CMD+\
" nmap g\ :tabnext

" exmap palette obcommand command-palette:open
" nmap <C-p> :palette
" imap <C-p> :palette

" exmap settings obcommand app:open-settings
" nmap <C-,> :settings
" imap <C-,> :settings
" vmap <C-,> :settings

" Open fuzzy search similar to telescope search
exmap fuzzy obcommand switcher:open
nmap <Space>ff :fuzzy

" search/search-and-replace and global search
exmap search obcommand editor:open-search
nmap <C-f> :search
imap <C-f> :search
exmap sed obcommand editor:open-search-replace
nmap <Space>fs :sed
exmap grep obcommand global-search:open
nmap <Space>fg :grep

" open file explorer
exmap E obcommand file-explorer:open
nmap <Space>fe :E

" toggle sidebars and ribbon
exmap toggleLeft obcommand app:toggle-left-sidebar
exmap toggleRibbon obcommand obsidian-hider:toggle-app-ribbon
nmap <Space>th :toggleLeft | toggleRibbon
nmap <Space>tr :toggleRibbon
exmap toggleTabs obcommand obsidian-hider:toggle-tab-containers
nmap <Space>tt :toggleTabs
exmap toggleRight obcommand app:toggle-right-sidebar
nmap <Space>tl :toggleRight

" pane splitting
exmap vs obcommand workspace:split-vertical
nmap \ :vs
exmap sp obcommand workspace:split-horizontal
nmap - :sp

" focus panes
exmap focusLeft obcommand editor:focus-left
nmap <C-w>h :focusLeft
nmap <C-h> :focusLeft
exmap focusRight obcommand editor:focus-right
nmap <C-w>l :focusRight
nmap <C-l> :focusRight
exmap focusBottom obcommand editor:focus-bottom
nmap <C-w>j :focusBottom
nmap <C-j> :focusBottom
exmap focusTop obcommand editor:focus-top
nmap <C-w>k :focusTop
nmap <C-k> :focusTop

" surround
nunmap s
vunmap s

exmap surround_wiki surround [[ ]]
vmap [[ :surround_wiki
vmap ]] :surround_wiki

exmap surround_double_quotes surround " "
vmap s" :surround_double_quotes

exmap surround_single_quotes surround ' '
vmap s' :surround_single_quotes

exmap surround_brackets surround ( )
vmap s( :surround_brackets
vmap s) :surround_brackets

exmap surround_square_brackets surround [ ]
vmap s[ :surround_square_brackets
vmap s] :surround_square_brackets

exmap surround_curly_brackets surround { }
vmap s{ :surround_curly_brackets
vmap s} :surround_curly_brackets

exmap openlink obcommand editor:open-link-in-new-leaf
nmap gd :openlink

" [g]oto [f]ile (= Follow Link under cursor)
exmap followLinkUnderCursor obcommand editor:follow-link
nmap gf :followLinkUnderCursor

" link jump (similar to Vimium's f)
exmap linkjump obcommand mrj-jump-to-link:activate-lightspeed-jump
nmap <Space>gl :linkjump

" g; go to last change - https://vimhelp.org/motion.txt.html#g%3B
nmap gu u<C-r>

" " exmap cursorBackward obcommand heycalmdown-navigate-cursor-history:cursor-position-backward
" " exmap cursorForward heycalmdown-navigate-cursor-history:cursor-position-forward
" nmap g; :cursorBackward
" nmap g' :cursorForward

" blockquote
exmap toggleBlockquote obcommand editor:toggle-blockquote
nmap <Space>< :toggleBlockquote
nmap <Space>> :toggleBlockquote

" complete a Markdown task
exmap toggleTask obcommand editor:toggle-checklist-status
nmap <Space>x :toggleTask

" emulate Folding https://vimhelp.org/fold.txt.html#fold-commands
exmap togglefold obcommand editor:toggle-fold
nmap zo :togglefold

exmap unfoldall obcommand editor:unfold-all
nmap zR :unfoldall

exmap foldall obcommand editor:fold-all
nmap zM :foldall

" map <silent>ping next/previous heading
exmap nextHeading jsfile .obsidian.markdown-helper.js {jumpHeading(true)}
exmap prevHeading jsfile .obsidian.markdown-helper.js {jumpHeading(false)}
nmap g] :nextHeading
nmap g[ :prevHeading

exmap scrollToCenterTop70p jsfile .obsidian.markdown-helper.js {scrollToCursor(0.7)}
nmap zz :scrollToCenterTop70p

" zoom in/out
exmap zoomIn obcommand obsidian-zoom:zoom-in
exmap zoomOut obcommand obsidian-zoom:zoom-out
nmap zi :zoomIn
nmap zo :zoomOut

nmap &a :zoomOut
nmap &b :nextHeading
nmap &c :zoomIn
nmap &d :prevHeading
nmap z] &a&b&c
nmap z[ &a&d&c

" stille Mode
exmap toggleStille obcommand obsidian-stille:toggleStille
nmap zs :toggleStille
nmap <Space>s :toggleStille

" surround Admonition https://github.com/esm7/obsidian-vimrc-support/discussions/146
exmap CodeBlockAdmonitionNote obcommand code-block-from-selection:17f30753-d5f4-4953-abed-5027a25ede58
vmap san :CodeBlockAdmonitionNote
exmap CodeBlockSelectionAdmonitionNote jscommand { editor.setSelections([selection]); this.app.commands.commands['code-block-from-selection:17f30753-d5f4-4953-abed-5027a25ede58'].callback() }
vmap san :CodeBlockSelectionAdmonitionNote

exmap CodeBlockAdmonitionBrainstorm obcommand code-block-from-selection:36a8b91d-c4f1-4ac4-999c-7bfc53c998c1
vmap sab :CodeBlockAdmonitionBrainstorm
exmap CodeBlockSelectionAdmonitionBrainstorm jscommand { editor.setSelections([selection]); this.app.commands.commands['code-block-from-selection:36a8b91d-c4f1-4ac4-999c-7bfc53c998c1'].callback() }
vmap sab :CodeBlockSelectionAdmonitionBrainstorm

exmap CodeBlockAdmonitionQuote obcommand code-block-from-selection:91dc799c-4f7e-4d75-9cde-d9e6db990a5a
vmap saq :CodeBlockAdmonitionQuote
exmap CodeBlockSelectionAdmonitionQuote jscommand { editor.setSelections([selection]); this.app.commands.commands['code-block-from-selection:91dc799c-4f7e-4d75-9cde-d9e6db990a5a'].callback() }
vmap saq :CodeBlockSelectionAdmonitionQuote

exmap CodeBlockAdmonitionContext obcommand code-block-from-selection:cb332ef3-8053-42b0-88c9-a233e6dae6d0
vmap sac :CodeBlockAdmonitionContext
exmap CodeBlockSelectionAdmonitionContext jscommand { editor.setSelections([selection]); this.app.commands.commands['code-block-from-selection:cb332ef3-8053-42b0-88c9-a233e6dae6d0'].callback() }
vmap sac :CodeBlockSelectionAdmonitionContext

exmap CodeBlockAdmonitionRoutine obcommand code-block-from-selection:31f32950-d8df-4d8a-9ca3-91a34d2a67ab
vmap sar :CodeBlockAdmonitionRoutine
exmap CodeBlockSelectionAdmonitionRoutine jscommand { editor.setSelections([selection]); this.app.commands.commands['code-block-from-selection:31f32950-d8df-4d8a-9ca3-91a34d2a67ab'].callback() }
vmap sar :CodeBlockSelectionAdmonitionRoutine

exmap CodeBlockAdmonitionThink obcommand code-block-from-selection:655b28f0-353f-479e-bc5a-c0b422b987c9
vmap sat :655b28f0-353f-479e-bc5a-c0b422b987c9
exmap CodeBlockSelectionAdmonitionThink jscommand { editor.setSelections([selection]); this.app.commands.commands['code-block-from-selection:655b28f0-353f-479e-bc5a-c0b422b987c9'].callback() }
vmap sat :CodeBlockSelectionAdmonitionThink
