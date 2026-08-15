# W64-A3 _gpu_que_drain, round 2: SHAPE elements one at a time (the brief's
# instruction).  Read-ORDER permutations are falsified (spec_qd.py: 24/16/16/
# 25/22/14/24), so the dial is not which reload feeds which chain.
SRC = 'recon/syslib/psx/libgpu/SYS.c'
FNS = ['_gpu_que_drain']

BLOCK = """            {
                int     extra;
                u_long *arg;
                QueFunc func;
                extra = _que.plain[_qout].extra;
                arg = _que.plain[_qout].arg;
                func = _que.plain[_qout].func;
                func(arg, extra);
            }
"""

SPEC = [
    ("Q1 func local, args inlined", [(BLOCK, """            {
                QueFunc func;
                func = _que.plain[_qout].func;
                func(_que.plain[_qout].arg, _que.plain[_qout].extra);
            }
""")]),
    ("Q2 extra+arg locals, func inlined", [(BLOCK, """            {
                int     extra;
                u_long *arg;
                extra = _que.plain[_qout].extra;
                arg = _que.plain[_qout].arg;
                _que.plain[_qout].func(arg, extra);
            }
""")]),
    ("Q3 locals at fn scope (no inner block)", [(BLOCK, """            extra = _que.plain[_qout].extra;
            arg = _que.plain[_qout].arg;
            func = _que.plain[_qout].func;
            func(arg, extra);
""")]),
    ("Q4 decl-with-init form", [(BLOCK, """            {
                int     extra = _que.plain[_qout].extra;
                u_long *arg = _que.plain[_qout].arg;
                QueFunc func = _que.plain[_qout].func;
                func(arg, extra);
            }
""")]),
    ("Q5 (*func)() call spelling", [(BLOCK, """            {
                int     extra;
                u_long *arg;
                QueFunc func;
                extra = _que.plain[_qout].extra;
                arg = _que.plain[_qout].arg;
                func = _que.plain[_qout].func;
                (*func)(arg, extra);
            }
""")]),
    ("Q6 void fence before the func read", [(BLOCK, """            {
                int     extra;
                u_long *arg;
                QueFunc func;
                extra = _que.plain[_qout].extra;
                arg = _que.plain[_qout].arg;
                __asm__("" : : "i"(0));
                func = _que.plain[_qout].func;
                func(arg, extra);
            }
""")]),
    ("Q7 void fence after the extra read", [(BLOCK, """            {
                int     extra;
                u_long *arg;
                QueFunc func;
                extra = _que.plain[_qout].extra;
                __asm__("" : : "i"(0));
                arg = _que.plain[_qout].arg;
                func = _que.plain[_qout].func;
                func(arg, extra);
            }
""")]),
]
