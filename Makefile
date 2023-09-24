.PHONY: prebuild build clean run luajit

CC := gcc
CFLAGS := -Wall -Werror -Wpedantic

LDFLAGS := -L./lib/LuaJIT/src/libluajit-5.1.dll.a
INCLUDE := -I./lib/LuaJIT/src

OBJ := src/main.o

prebuild:
	git submodule update --init --recursive

build: luajit fbs

clean:
	rm $(OBJ)
	rm fbs

run: build
	fbs

luajit: prebuild
	make -C lib/luajit

fbs: $(OBJ) 
	$(CC) $(LDFLAGS) -o $@ $^	

%.o: %.c
	$(CC) $(CFLAFGS) $(INCLUDE) -c -o $@ $<
