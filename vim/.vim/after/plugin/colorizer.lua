local exists, module = pcall(require, "colorizer")

if not exists then
  return
end

module.setup {}
