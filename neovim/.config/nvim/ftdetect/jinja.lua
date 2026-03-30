local function detect_jinja(path, bufnr)
  local base = path:gsub("%.jinja2?$", ""):gsub("%.j2$", "")

  if base ~= path then
    local ft = vim.filetype.match { filename = base, buf = bufnr }

    if ft then
      vim.b[bufnr].is_jinja = true
      return ft
    end
  end

  return "jinja"
end

vim.filetype.add {
  extension = {
    j2 = detect_jinja,
    jinja = detect_jinja,
    jinja2 = detect_jinja,
  },
}
