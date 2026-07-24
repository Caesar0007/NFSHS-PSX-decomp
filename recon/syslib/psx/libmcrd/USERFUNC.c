/* syslib/psx/libmcrd/USERFUNC.c -- RECONSTRUCTED from nfs4-f.exe (Ghidra).
 *   obj libmcrd.lib(USERFUNC.OBJ): a tiny 4-deep stack of pending user callbacks that the card
 *   state machine pumps -- UserFuncOpen pushes a step, UserFuncExecute runs the top one and pops
 *   it when it reports completion (non-zero), each step carrying a 4-word argument scratch block. */

extern int printf(const char *fmt, ...);   /* libc C63 */

typedef int (*UserFn)(void *args);

static int    _uf_top __attribute__((section(".data"))) = -1;  /* @0x8013C2E0 : top-of-stack index (-1 = empty); .data (not .sdata) -> absolute addressing like aspsx, not maspsx -G4 gp-rel */
static int    _uf_arg[4][4];       /* @0x80148A2C : per-slot 4-word argument scratch */
static UserFn _uf_func[4];         /* @0x80148A6C : per-slot callback */

/* @0x80109C00 : UserFuncInit -- reset the stack. */
extern void UserFuncInit(void)
{
    _uf_top = -1;
}

/* @0x80109C10 : UserFuncOpen -- push a callback (clearing its argument block).  Oracle branch
 *   polarity is `if (n<4) goto PUSH; PRINTF_OVERFLOW; goto END; PUSH: ...` (overflow falls through,
 *   push is the jump target) -- the early-return-on-overflow C shape below, not an if/else with the
 *   overflow arm second.  The zero-clear is a real down-counting `for(i=3;i>=0;i--)` loop over a
 *   pointer walking from &_uf_arg[n][3] down to [0] (oracle decrements the pointer in the branch's
 *   delay slot -- catalog lever "down-counting for(i=N-1;i!=-1;i--)"), not 4 unrolled stores.
 *   Structure now matches the oracle exactly (branch shape byte-identical, same 4-insn address-fold
 *   sequence for &_uf_arg[n][3] incl. the D_x+12-style relocation addend); residual 33 diffs (was 43
 *   before this fix) is a pure 3-way register-coloring rotation (n: a2 oracle vs a3 ours; pointer:
 *   v1 vs a2; counter: a1 vs a1 match) -- documented near-miss, not chased further (permuter-class
 *   residual, out of this pass's budget). */
extern void UserFuncOpen(UserFn func)
{
    int n = _uf_top + 1;
    if (n >= 4) {
        printf("libmcrd: event overflow\n");
        return;
    }
    _uf_top = n;
    _uf_func[n] = func;
    {
        int i = 3;
        int *p = &_uf_arg[n][3];
        for (; i >= 0; i--, p--)
            *p = 0;
    }
}

/* @0x80109C8C : UserFuncExecute -- run the top callback; pop it when it completes. */
extern void UserFuncExecute(void)
{
    if (_uf_top >= 0) {
        if (_uf_func[_uf_top](&_uf_arg[_uf_top]) != 0)
            _uf_top = _uf_top - 1;
    }
}

/* @0x80109CF8 : UserFuncComplete -- report whether the stack is now empty (1 = empty, _uf_top<0). */
extern int UserFuncComplete(void)
{
    return (int)((unsigned)_uf_top >> 31);
}
