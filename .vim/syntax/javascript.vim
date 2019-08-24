if exists('b:current_syntax') 
    if b:current_syntax ==# 'javascript'
        finish
    endif
else
    sy clear
    sy sync ccomment jsComment
    let b:current_syntax = 'javascript' 
endif

sy sync fromstart
sy sync minlines=120

runtime! syntax/regex.vim
runtime! syntax/docstring.vim

" mainly for syntax#complete
" sy keyword jsArrayFunct  concat copyWithin every fill filter find findIndex includes indexOf join lastIndexOf map pop push reduce reduceRight reverse shift slice some sort splice unshift
" sy keyword jsJSONStatics parse stringify
" sy keyword jsMapFunct    clear get set
" sy keyword jsMathStatics E LN10 LN2 LOG10E LOG2E PI SQRT1_2 SQRT2 abs acos acosh asin asinh atan atan2 atanh cbrt ceil clz32 cos cosh exp expm1 floor fround hypot imul log log10 log1p log2 max min pow random round sign sin sinh sqrt tan tanh trunc
" sy keyword jsObjFunct    hasOwnProperty isPrototypeOf propertyIsEnumerable toLocaleStr toStr valueOf 
" sy keyword jsObjStatics  length name assign create defineProperties defineProperty entries freeze getOwnPropertyDescriptor getOwnPropertyDescriptors getOwnPropertyNames getOwnPropertySymbols getPrototypeOf is isExtensible isFrozen isSealed keys preventExtensions seal setPrototypeOf values
" sy keyword jsPromise     all race reject resolve 
" sy keyword jsSetFunct    add has size 
" sy keyword jsStrFunct    charAt charCodeAt codePointAt concat endsWith fixed fontcolor fontsize includes localeCompare match normalize padEnd padStart repeat replace search split startsWith strike sub substr substring toLocaleLowerCase toLocaleUpperCase toLowerCase toUpperCase trim trimEnd trimLeft trimRight trimStart

" #!/usr/bin/env node
sy match jsShebang '\v^#!.+$'

" Comment:
sy region  jsComment     start="/\*"  end="\*/"       contains=@Spell,@docstringAll,tsCommentTsIgnore keepend
sy region  jsCommentTodo start='\v<(FIXME|XXX|TODO)>' end="$" oneline contained
sy match   tsCommentTsIgnore '\V@ts-ignore\v\s*'
sy match   jsLineComment "\/\/\v[^\n\r]*"             contains=@Spell,jsCommentTodo,tsCommentTsIgnore
sy match   tsTripSlashDirect "\/\/\/\v[^\n\r]*"       contains=@Spell,jsCommentTodo

" Builtin Types:
sy keyword jsBool true false
sy keyword jsCond if else switch case
sy keyword jsNull null undefined
sy match   jsNum "-\=\<\d\+L\=\>\|0[xX][0-9a-fA-F]\+\>"
sy keyword jsNum Infinity NaN

" objects by convention capitalised
sy match jsType  "\v<(([A-Z][a-z]+)+|[A-Z]+[a-z][A-Za-z]+)>"
" mainly for syntax#complete
sy keyword jsType Array Boolean Date Function Number Object String RegExp Infinity Reflect Proxy Math Symbol Error EvalError InternalError RangeError ReferenceError SyntaxError TypeError URIError Generator GeneratorFunction AsyncFunction Promise JSON DataView ArrayBuffer Map Set WeakMap WeakSet Int8Array Uint8Array Uint8ClampedArray Int16Array Uint16Array Int32Array Uint32Array Float32Array Float64Array 
sy keyword tsType Partial Readonly Record Pick Pick Omit Exclude Extract NonNullable ReturnType InstanceType Required ThisType

" Str:
sy match  jsStrEscape "\v\\." contained containedin=jsStrD,jsStrS,jsTemplStr
sy region jsStrD start=+"+  skip=+\\\\\|\\"+  end=+"\|$+ oneline  keepend contains=@Spell
sy region jsStrS start=+'+  skip=+\\\\\|\\'+  end=+'\|$+ oneline  keepend contains=@Spell
" FIXME Doesn't look nice
" sy match jsStrSQuote "'"  contained containedin=jsStrS
" sy match jsStrDQuote '"' contained containedin=jsStrD
" hi def link jsStrDQuote Delimiter
" hi def link jsStrSQuote Delimiter

" `template string with ${vars}`
sy region jsTemplStr      start='`'   end='`' keepend contains=jsTemplStrSubst,jsTemplStrHtmlTag,@Spell
sy region jsTemplStrSubst start='\${' end='}' keepend matchgroup=Delimiter contained containedin=jsTemplStr contains=jsStrD,jsStrS,jsOp,jsArrowFunc,jsRegexStr,jsGlobal,jsEvent,jsBool,jsNull,jsNum,jsDollar

" sy region jsJSXTag start="\v\<([a-z]+)( [a-z]+(\=\".{,20}\")?)*\>" end="\v</\1\>" keepend
" sy region jsJSXTagInner start="\v\<([a-z]+)( [a-z]+(\=\".{,20}\")?)*\>" end="\v</\1\>" keepend

" recursive syntax definitions only work properly in nvim
if has('nvim')
	" often we put HTML tags in js templates
	sy region jsTemplStrHtmlTag          start="\v\<([a-z]+[1-6]?)([ \n\t]+[-a-zA-Z]+(\=\"[^\"]*\")?)*\>" end="\v</\1\>" contained contains=jsTemplStrHtmlTagInner,jsTemplStrHtmlTag,jsTemplStrHtmlTagAttr keepend
	sy region jsTemplStrHtmlTagInner     start="\v\>"ms=e+1 end="\v\<"me=s-1 contained keepend
	sy match  jsTemplStrHtmlTagAttr      "\v <[a-z]{3,15}>"ms=s+1 contained keepend
	sy region jsTemplStrHtmlTagAttr      start="\v[a-z]{2,15}\=\"" end="\"" oneline contained contains=jsTemplStrHtmlTagAttrName,jsTemplStrHtmlTagAttrValue,jsTemplStrHtmlTagAttrEq keepend
	sy match  jsTemplStrHtmlTagAttrName  "\v[a-z]{2,15}\="me=e-1 contained keepend
	sy match  jsTemplStrHtmlTagAttrEq    "\v\=" contained 
	sy region jsTemplStrHtmlTagAttrValue start='"' end='"' oneline contained keepend
endif

sy region  jsRegexStr start=+/[^/*]+me=e-1 skip=+\\\\\|\\/+ end=+/[gim]\{0,2\}\s*$+ end=+/[gim]\{0,2\}\s*[;.,)\]}]+me=e-1 contains=@regexAll oneline keepend

" $vars or $
sy match jsDollar '\v([a-z][A-Za-z0-9]*)?\$[A-Za-z0-9]*'

" Statements:
sy keyword jsKeyword   super async function get set
sy keyword jsVarDecl   var let const declare
sy keyword tsClassDecl type interface enum namespace
sy keyword jsClassDecl class extends implements
sy keyword jsStmt      return with break continue try catch finally throw package throws yield 
sy keyword jsSpecial   this prototype constructor 
sy match   jsConst    "\v<[A-Z][A-Z_]{2}[A-Z0-9_]+>"

" chained calls
"sy match jsSpecial '\v^\s*\.[a-z][a-zA-Z]+'ms=s+1

" import * from "./file.js"
" require("./file.js")
sy keyword jsImport import export as default from
sy keyword nodeImport require exports

" Loops:
sy keyword jsRepeat	do for while of

 " OOP:
sy keyword tsAccess    private public abstract readonly protected
sy keyword jsAccess    static final
sy keyword tsTypePrim  boolean void string number object any

" Deprecated:
" __get_attribute__
sy region  jsDepr start='__' end='__' oneline keepend
" see MDN 'deprecated and obsolete features'
sy keyword jsDepr escape big quote arity getNotifier unescape caller setYear getYear toLocaleFormat toGMTString StopIteration Iterator

" Macros:
sy keyword jsNodeMacro __dirname __filename 

" Globals:
" Node.js
sy keyword jsNodeGlobal module process 
" Browser
sy keyword jsBrowserGlobal window inspect origin document alert caches screen sessionStorage close confirm prompt stream fetch focus blur getSelection getComputedStyle closed applicationCache open parent screenLeft screenTop scroll scrollBy scrollX scrollY openDatabase print resizeBy resizeTo stop status pageXOffset pageYOffset outerWidth outerHeight opener dispatchEvent removeEventListener
" shared 
sy keyword jsGlobal        arguments setInterval setTimeout console escape unescape eval clearTimeout clearInterval parseInt parseFloat decodeURI decodeURIComponent encodeURIComponent isFinite isNaN crypto
" events
sy match   jsEvent         '\v<on[a-z]{4,}>'

" Operators:
sy keyword jsOp await new typeof instanceof delete in

" || && : ? 
" and bitwise | &
sy match jsOp "\v( |>)(\-{2}|\+{2})"
" rest / spread ...
" logical negation
" bit flip
sy match jsOp "\v\.{3}|([!~]<)"
" -- ++ - + += -= * / *= /= % %=
" bitwise continued ... >>> <<< ^ ~
" == === <= >= < > !== !=
sy match jsOp "\v( |^|>)([-+%*/><^]\=?|\>{2,3}|\<{2,3}|!?\={1,2}|\={3}|\&{1,2}|\|{1,2})( |$|<)"

"key: value in objects
" cond ? ifT : ifF
sy match jsOp "\v( |^)[:?]( |$)"

" x => x.something
sy match jsArrowFunc "\v(\\(\\))? (\=\>)( |$)"

" indexing eg xs[0]
"sy match jsBracket "\v[][}{]"

" call function e.g.: myFunct()
sy match jsDecorator '\V@\v[a-zA-Z]\w+\(@='
sy match jsFunctCall '\v[a-z]\w+\(@='

hi def link tsAccess                   jsAccess
hi def link jsAccess                   StorageClass
hi def link jsArrowFunc                jsStmt
hi def link jsBool                     Boolean
"hi def link jsBracket                  Operator
hi def link jsBrowserGlobal            Builtin
hi def link tsClassDecl                jsClassDecl
hi def link jsClassDecl                jsDecl
hi def link jsComment                  Comment
hi def link tsCommentTsIgnore          PreProc
hi def link jsCommentTodo              WarningMsg
hi def link jsCond                     Conditional
hi def link jsConst                    Constant
hi def link jsDecl                     jsStmt
hi def link jsDepr                     ErrorMsg
hi def link jsDollar                   jsGlobal
hi def link jsEvent                    Procedure
hi def link jsFunctCall                Function
hi def link jsGlobal                   Builtin
hi def link nodeImport                 jsImport
hi def link jsImport                   Include
hi def link jsKeyword                  Keyword
hi def link jsLineComment              jsComment
hi def link tsTripSlashDirect          PreProc
hi def link jsNodeGlobal               Builtin
hi def link jsNodeMacro                Macro
hi def link jsDecorator                Macro
hi def link jsNull                     Symbol
hi def link jsNum                      Number
hi def link jsOp                       Operator
hi def link jsRegexStr                 PreProc
hi def link jsRepeat                   Repeat
hi def link jsShebang                  PreProc
hi def link jsSpecial                  Special
hi def link jsStmt                     Statement
hi def link jsStrD                     String
hi def link jsStrEscape                SpecialChar
hi def link jsStrS                     String
hi def link jsTemplStr                 Macro
hi def link jsTemplStrHtmlTag          Keyword
hi def link jsTemplStrHtmlTagAttr      Constant
hi def link jsTemplStrHtmlTagAttrEq    Operator
hi def link jsTemplStrHtmlTagAttrName  Constant
hi def link jsTemplStrHtmlTagAttrValue String
hi def link jsTemplStrHtmlTagInner     Normal
hi def link jsTemplStrSubst            Normal
hi def link tsTypePrim                 jsType
hi def link jsType                     Type
hi def link jsVarDecl                  jsDecl
