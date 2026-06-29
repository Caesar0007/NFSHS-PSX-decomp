/* syslib/psx/libmcrd/USERFUNC.cpp -- RECONSTRUCTED from nfs4-f.exe (Ghidra).
 *   obj libmcrd.lib(USERFUNC.OBJ): a tiny 4-deep stack of pending user callbacks that the card
 *   state machine pumps -- UserFuncOpen pushes a step, UserFuncExecute runs the top one and pops
 *   it when it reports completion (non-zero), each step carrying a 4-word argument scratch block. */

extern "C" int printf(const char *fmt, ...);   /* libc C63 */

typedef int (*UserFn)(void *args);

static int    _uf_top __attribute__((section(".data"))) = -1;  /* @0x8013C2E0 : top-of-stack index (-1 = empty); .data (not .sdata) -> absolute addressing like aspsx, not maspsx -G4 gp-rel */
static int    _uf_arg[4][4];       /* @0x80148A2C : per-slot 4-word argument scratch */
static UserFn _uf_func[4];         /* @0x80148A6C : per-slot callback */

/* @0x80109C00 : UserFuncInit -- reset the stack. */
extern "C" void UserFuncInit(void)
{
    _uf_top = -1;
}

/* @0x80109C10 : UserFuncOpen -- push a callback (clearing its argument block). */
extern "C" void UserFuncOpen(UserFn func)
{
    int n = _uf_top + 1;
    if (n < 4) {
        _uf_top = n;
        _uf_func[n] = func;
        _uf_arg[n][0] = 0;
        _uf_arg[n][1] = 0;
        _uf_arg[n][2] = 0;
        _uf_arg[n][3] = 0;
    } else {
        printf("libmcrd: event overflow\n");
    }
}

/* @0x80109C8C : UserFuncExecute -- run the top callback; pop it when it completes. */
extern "C" void UserFuncExecute(void)
{
    if (_uf_top >= 0) {
        if (_uf_func[_uf_top](&_uf_arg[_uf_top]) != 0)
            _uf_top = _uf_top - 1;
    }
}

/* @0x80109CF8 : UserFuncComplete -- report whether the stack is now empty (1 = empty, _uf_top<0). */
extern "C" int UserFuncComplete(void)
{
    return (int)((unsigned)_uf_top >> 31);
}
