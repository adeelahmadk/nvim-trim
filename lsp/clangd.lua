return {
  -- Command and arguments to start the server.
  cmd = { 'clangd', '--background-index' },

  -- Sets the "root directory" to the parent directory of the file in the
  -- current buffer that contains either of the files
  root_markers = { 'compile_commands.json', 'compile_flags.txt' },

  -- Filetypes to automatically attach to.
  filetypes = { 'c', 'cpp' },
}
