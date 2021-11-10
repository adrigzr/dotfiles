local exists, module = pcall(require, "renamer")

if not exists then
  return
end

module.setup {}
