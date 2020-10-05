/\([-]\{0,1}\)\@<=\(\_[^-]\{-}\)\(\|\("\)\@=\)/
:let @a=""|%s//\=setreg('A', submatch(0), 'c')/g|1,$d|pu a|0d _
:%s//??/g
:2,$s/\(.\{-}\)\d\{5}\(.\{-}\)\($\)\@=/\[\0\](\0)/g
:1,1y
:let @0=substitute(@0,'/','-','g')
:let @0=trim(@0)
:exe 'w /Users/colinpinney/Documents/Zettelkasten/Odin/' . @0 . '.md'
