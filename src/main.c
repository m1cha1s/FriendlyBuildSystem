#include <lua.h>
#include <lualib.h>
#include <lauxlib.h>

#include <stdlib.h>
#include <stdio.h>

int main(int argc, char* argv[]) {

    int status;

    lua_State *L;

    L = luaL_newstate();
    luaL_openlibs(L); // Open lua standard libraries

    status = luaL_loadfile(L, "test/fbs.lua");
    if (status) {
        fprintf(stderr, "Couldn't load file: %s\n", lua_tostring(L, -1));
        exit(1);
    }

    lua_pcall(L, 0, LUA_MULTRET, 0);

    lua_close(L);

    return 0;
}
