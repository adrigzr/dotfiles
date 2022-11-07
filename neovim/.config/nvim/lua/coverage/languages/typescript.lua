local M = {}

local Path = require "plenary.path"
local Job = require "plenary.job"
local iterators = require "plenary.iterators"
local signs = require "coverage.signs"
local util = require "coverage.util"
local lspconfig = require "lspconfig.util"

local function calculate_coverage(statements, missing_statements, branches, partial_branches)
  local total = statements + branches
  local total_missing = missing_statements + partial_branches

  return ((total - total_missing) / total) * 100.0
end

local function by_value(value)
  return function(item)
    return item == value
  end
end

local function mark_range(marker, mark, start, end_)
  for linenr in iterators.range(start, end_, 1) do
    if marker[linenr] ~= false then
      marker[linenr] = mark
    end
  end
end

local function find_coverage_files(root_path, callback)
  Job:new({
    enable_recording = true,
    command = "rg",
    cwd = root_path,
    args = {
      "--files",
      "--color=never",
      "--no-heading",
      "--no-ignore",
      "-g",
      "!node_modules",
      "-g",
      "coverage-final.json",
    },
    on_exit = function(j)
      callback(j:result())
    end,
  }):start()
end

local read_coverage_files = function(root_path, file_paths, callback)
  local file_contents = {}

  for _, file_path in pairs(file_paths) do
    file_contents[file_path] = nil

    local file = Path:new(root_path, file_path)

    file:read(vim.schedule_wrap(function(data)
      util.safe_decode(data, function(json)
        file_contents[file_path] = json

        local contents = vim.tbl_values(file_contents)

        if not vim.tbl_contains(contents, nil) then
          callback(contents)
        end
      end)
    end))
  end
end

local function parse_coverage_files(file_contents)
  local files = {}

  for _, data in pairs(file_contents) do
    for fname, cov in pairs(data) do
      local filename = Path:new(fname):make_relative()
      local statements = vim.tbl_count(cov.s)
      local missing_statements = vim.tbl_count(vim.tbl_filter(by_value(0), vim.tbl_values(cov.s)))
      local branches = vim.tbl_count(vim.tbl_flatten(vim.tbl_values(cov.b)))
      local partial_branches = vim.tbl_count(vim.tbl_filter(by_value(0), vim.tbl_flatten(vim.tbl_values(cov.b))))
      local lines = {}

      -- statements
      for key, value in pairs(cov.s) do
        local statement = cov.statementMap[key]

        mark_range(lines, value ~= 0, statement.start.line, statement["end"].line)
      end

      -- functions
      for key, value in pairs(cov.f) do
        local statement = cov.fnMap[key]

        -- declaration
        mark_range(lines, value ~= 0, statement.decl.start.line, statement.decl["end"].line)

        -- body
        mark_range(lines, value ~= 0, statement.loc.start.line, statement.loc["end"].line)
      end

      -- branches
      for key, locations in pairs(cov.b) do
        local branch = cov.branchMap[key]

        for index, value in pairs(locations) do
          local location = branch.locations[index]

          mark_range(lines, value ~= 0, location.start.line, location["end"].line)
        end
      end

      table.insert(files, {
        filename = filename,
        statements = statements,
        missing = missing_statements,
        excluded = nil,
        branches = branches,
        partial = partial_branches,
        coverage = calculate_coverage(statements, missing_statements, branches, partial_branches),
        lines = lines,
      })
    end
  end

  return files
end

--- Loads a coverage report.
-- @param callback called with the list of signs from the coverage report
M.load = function(callback)
  local current_path = vim.fn.expand "%:p"
  local root_path = lspconfig.find_git_ancestor(current_path)

  find_coverage_files(root_path, function(file_paths)
    read_coverage_files(root_path, file_paths, function(file_contents)
      local files = parse_coverage_files(file_contents)

      callback(files)
    end)
  end)
end

--- Returns a list of signs to be placed.
-- @param json_data from the generated report
M.sign_list = function(files)
  local sign_list = {}

  for _, file in pairs(files) do
    local buffer = vim.fn.bufnr(file.filename, false)

    if buffer ~= -1 then
      for linenr, value in pairs(file.lines) do
        local method = value and signs.new_covered or signs.new_uncovered

        table.insert(sign_list, method(buffer, linenr))
      end
    end
  end

  return sign_list
end

--- Returns a summary report.
M.summary = function(files)
  local totals = {
    statements = 0,
    missing = 0,
    excluded = nil,
    branches = 0,
    partial = 0,
    coverage = 0,
  }

  for _, file in pairs(files) do
    totals.statements = totals.statements + file.statements
    totals.missing = totals.missing + file.missing_statements
    totals.branches = totals.branches + file.branches
    totals.partial = totals.partial + file.partial_branches
  end

  totals.coverage = calculate_coverage(totals.statements, totals.missing, totals.branches, totals.partial)

  return {
    files = files,
    totals = totals,
  }
end

return M
