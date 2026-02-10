P = function(v)
  print(vim.inspect(v))
  return v
end

RELOAD = function(module)
  package.loaded[module] = nil
end

R = function(name)
  RELOAD(name)
  return require(name)
end
