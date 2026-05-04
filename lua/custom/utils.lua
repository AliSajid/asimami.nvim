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
  -- The "!" prefix forces UTC
  -- Equivalent to your shell: 'date -u +%Y%m%d%H%M%S%Z'
  local timestamp = os.date '!%Y%m%d%H%M%S%Z'

  if timestamp then
    vim.api.nvim_put({ timestamp }, 'c', true, true)
  end
  return timestamp
end

function M.insertTime()
  local timestamp = os.date '!%H%M%S%Z'

  if timestamp then
    vim.api.nvim_put({ timestamp }, 'c', true, true)
  end
  return timestamp
end

function M.insertDate()
  local timestamp = os.date '!%Y%m%d%Z'

  if timestamp then
    vim.api.nvim_put({ timestamp }, 'c', true, true)
  end
  return timestamp
end

return M
