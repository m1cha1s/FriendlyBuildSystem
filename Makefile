.PHONY: prebuild build clean run luajit

CC := gcc
CFLAGS := -Wall -Werror -Wpedantic -O2

#LDFLAGS := -L./lib/LuaJIT/src/ -lm -lluajit
LDFLAGS := ./lib/LuaJIT/src/libluajit.a -lm
INCLUDE := -I./lib/LuaJIT/src

OBJ := src/main.o

NPROC ?= 2

prebuild:
	git submodule update --init --recursive

build: luajit fbs

clean:
	rm $(OBJ)
	rm fbs

run: build
	./fbs

luajit: prebuild
	make -j $(NPROC) -C ./lib/LuaJIT

fbs: $(OBJ) 
	$(CC) -o $@ $^ $(LDFLAGS)

%.o: %.c
	$(CC) $(CFLAFGS) $(INCLUDE) -c -o $@ $<
