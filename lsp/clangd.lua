-------------------------------------------------------------------------------
-- Dependencies:
--   apt install clangd clang-tidy clang-format
-------------------------------------------------------------------------------
return {
  -- Command and arguments to start the server.
  cmd = { 
    'clangd', 
    '--background-index',
    '--clang-tidy',           -- Enables static analysis and linting diagnostics
    '--header-insertion=iwyu', -- "Include What You Use" auto-imports missing headers
    '--completion-style=detailed',
    '--function-arg-placeholders',
    '--fallback-style=llvm',   -- Uses LLVM format style if .clang-format is missing
  },

  -- Sets the "root directory" to look for a project
  root_markers = {
    '.clangd',
    '.clang-tidy',
    '.clang-format',
    'compile_commands.json',
    'compile_flags.txt',
    'configure.ac',
    'Makefile',
    'meson.build',
    'build.ninja',
    '.git',
  },

  -- Filetypes to automatically attach to.
  filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' }, -- Trimmed down headers as filetypes target source mapping
}

