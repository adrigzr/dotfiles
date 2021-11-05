local exists, module = pcall(require, "diffview")

if not exists then
  return
end

module.setup {}
