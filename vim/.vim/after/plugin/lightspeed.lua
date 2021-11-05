local exists, module = pcall(require, "lightspeed")

if not exists then
  return
end

module.setup { }
