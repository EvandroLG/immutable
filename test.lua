local test = require 'simple_test'
local immutable = require 'immutable'

test('thow error if params have wrong types', function(a)
  a.throw(immutable, { 'state', function() end })
  a.throw(immutable, { 1, function() end })
  a.throw(immutable, { function() end, function() end })

  a.throw(immutable, { {}, {} })
  a.throw(immutable, { {}, 'recipe' })
  a.throw(immutable, { {}, 2 })
end)

test('should create a new state when initial object was completely changed', function(a)
  local state = {
    title = 'Psycho',
    year = 1960
  }

  local new_state = immutable(state, function(draft)
    draft.title = 'Pulp Fiction'
    draft.year = 1994
    draft.review = 5
  end)

  a.equal(state.title, 'Psycho')
  a.equal(state.year, 1960)
  a.equal(state.review, nil)

  a.equal(new_state.title, 'Pulp Fiction')
  a.equal(new_state.year, 1994)
  a.equal(new_state.review, 5)
end)

test('same primitive values should be treated as no change', function(a)
  local state = { 1, 'one', 2, 'two', { name = "Evandro" } }
  local new_state = immutable(state, function(draft)
    draft[1] = 1
    draft[2] = 'one'
    draft[3] = 2
    draft[4] = 'two'
    draft[5].name = 'Evandro'
  end)

  a.equal(state, new_state)
end)

test('should just make changes when it is needed', function(a)
  local state = {
    {
      name = 'Evandro',
      age = 34
    },
    {
      name = 'Carmen',
      age = 63
    },
    {
      name = 'Valeria',
      age = 59
    }
  }

  local new_state = immutable(state, function(draft)
    draft[1].age = 35
  end)

  a.not_equal(state, new_state)
  a.not_equal(state[1], new_state[1])
  a.equal(state[2], new_state[2])
  a.equal(state[3], new_state[3])
  a.equal(state[1].age, 34)
  a.equal(new_state[1].age, 35)
end)
