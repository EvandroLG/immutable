package = 'immutable'
version = 'dev-1'

source = {
  url = 'git+https://github.com/evandrolg/immutable.git',
}

description = {
  summary = '`immutable` is a tiny library that makes easy to work with immutable data.',
  homepage = 'https://github.com/EvandroLG/immutable',
  maintainer = 'Evandro Leopoldino Goncalves (@evandrolg) <evandrolgoncalves@gmail.com>',
  license = 'MIT <http://opensource.org/licenses/MIT>'
}

dependencies = {
  "lua >= 5.1",
}

build = {
  type = "builtin",
  modules = {
    ['immutable'] = "src/immutable/init.lua",
  }
}
