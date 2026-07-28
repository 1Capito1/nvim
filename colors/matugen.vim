" matugen generated colorscheme - Legacy & Modern Tree-sitter Support
set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "matugen"

" --- Transparency & UI Basics ---
hi Normal guifg=#dfe3e8 guibg=NONE
hi NormalFloat guifg=#dfe3e8 guibg=#1c2024
hi FloatBorder guifg=#8b9198 guibg=NONE

" --- Cursor & Selection ---
hi Cursor guifg=#101417 guibg=#94cdf7
hi CursorLine guibg=#181c20
hi CursorLineNr guifg=#94cdf7 gui=bold
hi Search guibg=#384956 guifg=#d3e5f5
hi Visual guibg=#313539

" --- Legacy Vim Syntax Groups ---
hi Statement guifg=#94cdf7 gui=bold
hi Keyword guifg=#94cdf7 gui=bold
hi Type guifg=#cec0e8 gui=italic
hi Function guifg=#b7c9d9
hi Identifier guifg=#dfe3e8
hi Constant guifg=#cec0e8
hi String guifg=#3b464f
hi Number guifg=#cec0e8
hi Operator guifg=#94cdf7
hi Delimiter guifg=#8b9198
hi Comment guifg=#8b9198 gui=italic

" --- Tree-sitter Groups (Modern @ names) ---
hi @keyword guifg=#94cdf7 gui=bold
hi @keyword.function guifg=#94cdf7 gui=bold
hi @function guifg=#b7c9d9
hi @function.call guifg=#b7c9d9
hi @type guifg=#cec0e8 gui=italic
hi @type.builtin guifg=#cec0e8 gui=italic
hi @variable guifg=#dfe3e8
hi @operator guifg=#94cdf7
hi @punctuation.bracket guifg=#8b9198
hi @variable.parameter guifg=#dfe3e8

" --- Tree-sitter Groups (Legacy TS names) ---
" This fixes your 'func' and 'Sum' and 'int' highlights
hi TSKeywordFunction guifg=#94cdf7 gui=bold
hi TSFunction guifg=#b7c9d9
hi TSType guifg=#cec0e8 gui=italic
hi TSTypeBuiltin guifg=#cec0e8 gui=italic
hi TSKeyword guifg=#94cdf7 gui=bold
hi TSOperator guifg=#94cdf7
hi TSPunctBracket guifg=#8b9198
hi TSVariable guifg=#dfe3e8
hi TSParameter guifg=#dfe3e8

" --- Diagnostics & Git ---
hi DiagnosticError guifg=#ffb4ab
hi DiagnosticWarn guifg=#cec0e8
hi GitSignsAdd guifg=#94cdf7
hi GitSignsChange guifg=#cec0e8
hi GitSignsDelete guifg=#ffb4ab

" --- Completion Menu ---
hi Pmenu guifg=#dfe3e8 guibg=#262a2e
hi PmenuSel guibg=#94cdf7 guifg=#00344d
