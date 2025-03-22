" Vim syntax file
" Language: Halcyon Quest Machine
" Maintainer: Peterino
" Latest Revision: 21 May 2022

if exists("b:current_syntax")
    finish
endif

" syn match halcDirectiveArgs "@.*\%(\w\|\.\)*"
" syn match halcDirective "@\s*"
" syn match halcLine /.*:\w+/
" syn match halcLabel "\[.*\]"

" hi def link halcDirective		Operator
" hi def link halcLine		    Statement
" hi def link halcLabel		    PreProc 


syn match halcDirective "@\w\+"
syn match halcGotoTarget "\s.*" contained
syn match halcGoto "@goto\s\w\+" contains=halcDirective,halcGotoTarget
syn match halcLineStart ".*:"
syn match halcChoice "> .\+"
syn match halcLabel "\v\[.+\]"
" syn match halcChoice "> .\+"
"
syn match halcProdTag "{.*}"
syn match halcComment "#.*"

hi def link halcComment Comment
hi def link halcDirective Type
hi def link halcGotoTarget PreProc
hi def link halcGoto Type

hi def link halcLineStart String
hi def link halcChoice Special
hi def link halcLabel PreProc
hi def link halcProdTag Comment

" Define a region that includes both the key and value matches with a colon in between
