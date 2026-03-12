local exists, code_reviewer = pcall(require, "code-reviewer")

if not exists then
  return
end

code_reviewer.setup {
  display = "diffview",
  backend = "opencode",
}
