local exists, module = pcall(require, "nvim-gps")

if not exists then
  return
end

module.setup {
  separator = ' ⟩ ',
	icons = {
		["class-name"] = ' ',
		["function-name"] = ' ',
		["method-name"] = ' ',
		["container-name"] = ' ',
		["tag-name"] = '炙'
	},
}
