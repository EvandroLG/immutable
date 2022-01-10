.SILENT:

install_dependencies:
	luarocks install simple_test

test:
	LUA_PATH="./src/?.lua;./src/?/init.lua;./src/immutable/?.lua;;" lua test.lua

clean_rockspec:
	rm -rf *.rockspec
	rm -rf *.rock
