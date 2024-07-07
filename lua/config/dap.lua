local dap = require('dap')

dap.adapters['pwa-node'] = {
  type = 'server',
  host = 'localhost',
  port = 8123,
  executable = {
    command = "js-debug-adapter"
  }
}

for _, lang in ipairs { 'typescript', 'javascript' } do
  dap.configurations[lang] = {
    {
      type = 'pwa-node',
      request = 'launch',
      name = 'Launch File',
      program = '${file}',
      cwd = '${workspaceFolder}',
      runtimeExecutable = "bun"
    }
  }
end
