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

local function compare(state, copy)
  if type(state) ~= type(copy) then
    return false
  end

  if type(state) ~= 'table' then
    return state == copy
  end

  local is_equal = true

  for k, v in pairs(copy) do
    if compare(state[k], v) then
      copy[k] = state[k]
    else
      is_equal = false
    end
  end

  for k in pairs(state) do
    if copy[k] == nil then
      is_equal = false
    end
  end

  return is_equal
end

local function immutable(state, recipe)
  local copy = deep_copy(state)
  recipe(copy)

  if (compare(state, copy)) then
    return state
  end

  return copy
end

return immutable
