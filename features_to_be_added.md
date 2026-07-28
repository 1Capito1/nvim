## Missing Core IDE Features

### Language Support Enhancements
~- **Symbol outline**: `aerial.nvim` or `symbols-outline.nvim` for code structure navigation~
~- **Refactoring tools**: `refactoring.nvim` for extract method, inline variable, etc.~

### Code Navigation
~- **LSP enhancements**: Ensure you have LSP references/definitions/symbols pickers configured in Snacks~
~- **Better diagnostics display**: Consider `lsp_lines.nvim` or `tiny-inline-diagnostic.nvim` for inline diagnostics~

### Git Integration
~- **Inline git support**: `gitsigns.nvim` for blame, hunks, staging, and visual git indicators in sign column~

### Debugging (DAP Enhancement)
~- **Better UI**: `nvim-dap-ui` for proper debug panels (you have nvim-dap-view but dap-ui is more complete)~
~- **Virtual text**: `nvim-dap-virtual-text` to see variable values inline during debugging~
~- **More language adapters**: Your DAP setup only has Python and Rust configured~

### Project Management
- **Session management**: `auto-session` or `possession.nvim` to restore your workspace
- **Project detection**: Better project-root detection if needed

### Code Quality
~~- **Todo comments**: `todo-comments.nvim` for highlighting and searching TODO/FIXME/NOTE comments~~

### Quality of Life
- **Better folding**: `nvim-ufo` for modern, LSP-based folding with preview
~- **Bufferline**: `bufferline.nvim` for visual buffer tabs~
- **Multi-cursor**: `vim-visual-multi` for simultaneous editing
~- **Code context**: `nvim-navic` or `barbecue.nvim` for breadcrumbs showing where you are in the code~

### Missing Language-Specific
~~- **Rust**: `rustaceanvim` for enhanced Rust support (better than basic LSP)~~
- **Web dev**: `package-info.nvim` for npm versions, `typescript-tools.nvim` for better TypeScript
~~- **Markdown**: `markdown-preview.nvim` for live preview~~

### Documentation
- **Annotations**: `neogen` for auto-generating function documentation/docstrings

### Priority Additions (in order)
~~1. **gitsigns.nvim** - Essential for any IDE~~
~~2. **nvim-dap-ui** - Complete your debugging setup~~
~3. **aerial.nvim** or **symbols-outline.nvim** - Code structure navigation~
~4. **todo-comments.nvim** - Simple but high-value addition~
5. **refactoring.nvim** - IDE-level code manipulation
