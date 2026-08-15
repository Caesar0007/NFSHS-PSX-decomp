# W64-A3: _gpu_que_drain residual 14.  Mapping the three `_qout` reloads to the
# three `_que.plain[_qout]` field chains (read off both streams):
#   retail  load#1 -> .func   load#2 -> .arg   load#3 -> .extra
#   ours    load#1 -> .extra  load#2 -> .arg   load#3 -> .func
# i.e. gcc numbers the reloads in READ order, and retail's read order is
# func, arg, extra -- a permutation never probed (W56/W62 tried DECLARATION
# order and `arg before extra`, not `func first`).
SRC = 'recon/syslib/psx/libgpu/SYS.c'
FNS = ['_gpu_que_drain']

DECL = ("                int     extra;\n"
        "                u_long *arg;\n"
        "                QueFunc func;\n")
E = "                extra = _que.plain[_qout].extra;\n"
A = "                arg = _que.plain[_qout].arg;\n"
F = "                func = _que.plain[_qout].func;\n"
BODY = E + A + F

SPEC = [
    ("R1 read func,arg,extra", [(BODY, F + A + E)]),
    ("R2 read func,extra,arg", [(BODY, F + E + A)]),
    ("R3 read extra,func,arg", [(BODY, E + F + A)]),
    ("R4 read arg,func,extra", [(BODY, A + F + E)]),
    ("R5 read arg,extra,func", [(BODY, A + E + F)]),
    ("R6 read extra,arg,func + decl func,arg,extra",
     [(DECL, "                QueFunc func;\n                u_long *arg;\n"
             "                int     extra;\n")]),
    ("R7 R1 + decl func,arg,extra",
     [(DECL, "                QueFunc func;\n                u_long *arg;\n"
             "                int     extra;\n"), (BODY, F + A + E)]),
]
