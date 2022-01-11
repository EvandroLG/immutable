# immutable &middot; [![license](https://badgen.now.sh/badge/license/MIT)](./LICENSE)

`immutable` is a tiny library that makes easy to work with immutable data.

## Installation

To install `immutable` run:

```bash
$ luarocks install --server=http://luarocks.org/dev immutable
```

## How does it work?

`immutable` is highly inspired by `Immer`, a popular JavaScript library to work with immutable states in a simple way. If you are already familiar with how this JavaScript library works, `immutable` won’t bring anything new for you.

In the end of the day, `immutable` is just a function that takes two arguments: the first one is the object state that we want to start from and the second argument is a function that is passed a `draft` that we can apply straightforward mutations. Those mutations will be used to produce the next state, taking care of any necessary copy and without changing the initial object.

```lua
  local immutable = require 'immutable'

  local state = {
    {
      title = 'Psycho',
      year = 1960,
    },
    {
      title = 'Pulp Fiction',
      year = 1994,
    },
  }

  local new_state = immutable(state, function(draft)
    draft[1].title = 'Get out'
    draft[1].year = 2017
  end)
```

The result of the `immutable` function is a new state based on the mutations applied to the draft state. In case the reference of an object didn't change, the object didn't change.

## License

[MIT](./LICENSE)
