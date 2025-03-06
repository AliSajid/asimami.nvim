local system_cmd = vim.fn.system
local M = {}

function M.organizeImports(bufnr)
  local params = vim.lsp.util.make_range_params()
  params.context = { only = { 'source.organizeImports' } }
  local result = vim.lsp.buf_request_sync(bufnr, 'textDocument/codeAction', params, 500)
  for cid, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or 'utf-16'
        vim.lsp.util.apply_workspace_edit(r.edit, enc)
        return
      end
    end
  end
end

function M.insertTimestamp()
  local timestamp = system_cmd('date -u +%Y%m%d%H%M%S%Z'):gsub('\n', '')
  -- print("Timestamp" .. timestamp)
  vim.api.nvim_put({ timestamp }, '', false, true)
end

function M.insertTime()
  local timestamp = system_cmd('date -u +%H%M%S%Z'):gsub('\n', '')
  -- vim.api.nvim_put({ timestamp }, '', false, true)
  vim.api.nvim_put({ timestamp }, '', false, true)
end

function M.insertDate()
  local timestamp = system_cmd('date -u +%Y%m%d'):gsub('\n', '')
  -- print({ timestamp }, '', false, true)
  vim.api.nvim_put({ timestamp }, '', false, true)
end

return M
