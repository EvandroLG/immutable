-- makes a deep copy from a table
-- @param state {table}
-- @return {table}
local function deep_copy(state)
  local output = {}

  for k, v in pairs(state) do
    if type(v) == 'table' then
      output[k] = deep_copy(v)
    else
      output[k] = v
    end
  end

  return output
end

-- takes two tables and compare them, returning true in case they are equal
-- @param state {table}
-- @param copy {table}
-- @return {boolean}
local function compare(state, copy)
  if type(state) ~= type(copy) then
    return false
  end

  if type(state) ~= 'table' then
    return state == copy
  end

  local is_equal = true

  for k, v in pairs(copy) do
    -- in case state and copy have the same value, keep data structure from state
    if compare(state[k], v) then
      copy[k] = state[k]
    else
      is_equal = false
    end
  end

  -- look for removed items from the original state
  for k in pairs(state) do
    if copy[k] == nil then
      is_equal = false
      break
    end
  end

  return is_equal
end

-- immutable helper
-- @param state {table}
-- @param recipe {function}
-- @return {table}
local function immutable(state, recipe)
  if type(state) ~= 'table' then
    error('`state` should be a `table`')
  end

  if type(recipe) ~= 'function' then
    error('`recipe` should be a `function`')
  end

  local copy = deep_copy(state)
  recipe(copy)

  if compare(state, copy) then
    return state
  end

  return copy
end

return immutable
