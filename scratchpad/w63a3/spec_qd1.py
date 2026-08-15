SRC = 'recon/syslib/psx/libgpu/SYS.c'
FNS = ['_gpu_que_drain']

BODY = """        for (;;) {
            if (((_qout + 1) & 0x3f) == _qin && GEnv.idle_cb == 0)
                DMACallback(2, 0);               /* last entry, no idle cb: detach drain */
            if ((*GPU_GP1 & gpu_ready) == 0) {
                u_long wait_ready = 0x04000000;
                do {
                } while ((*GPU_GP1 & wait_ready) == 0);
            }
            {
                int     extra;
                u_long *arg;
                QueFunc func;
                extra = _que.plain[_qout].extra;
                arg = _que.plain[_qout].arg;
                func = _que.plain[_qout].func;
                func(arg, extra);
            }
            _qout = (_qout + 1) & 0x3f;
            if (_qin == _qout)
                break;                           /* queue empty */
            if ((*D2_CHCR & dma_active) != 0)
                break;                           /* a DMA was started */
        }
"""

HEAD = """        for (;;) {
            if (((_qout + 1) & 0x3f) == _qin && GEnv.idle_cb == 0)
                DMACallback(2, 0);               /* last entry, no idle cb: detach drain */
            if ((*GPU_GP1 & gpu_ready) == 0) {
                u_long wait_ready = 0x04000000;
                do {
                } while ((*GPU_GP1 & wait_ready) == 0);
            }
"""
TAIL = """            _qout = (_qout + 1) & 0x3f;
            if (_qin == _qout)
                break;                           /* queue empty */
            if ((*D2_CHCR & dma_active) != 0)
                break;                           /* a DMA was started */
        }
"""

GOTO_HEAD = """    loop_1:
        {
            if (((_qout + 1) & 0x3f) == _qin && GEnv.idle_cb == 0)
                DMACallback(2, 0);               /* last entry, no idle cb: detach drain */
            if ((*GPU_GP1 & gpu_ready) == 0) {
                u_long wait_ready = 0x04000000;
                do {
                } while ((*GPU_GP1 & wait_ready) == 0);
            }
"""
GOTO_TAIL = """            _qout = (_qout + 1) & 0x3f;
            if (_qin == _qout)
                goto drained;                    /* queue empty */
            if ((*D2_CHCR & dma_active) == 0)
                goto loop_1;                     /* no DMA started: next entry */
        }
    drained: ;
"""

DISPATCH = """            {
                int     extra;
                u_long *arg;
                QueFunc func;
                extra = _que.plain[_qout].extra;
                arg = _que.plain[_qout].arg;
                func = _que.plain[_qout].func;
                func(arg, extra);
            }
"""
DISPATCH_SOTN = """            _que.plain[_qout].func(_que.plain[_qout].arg, _que.plain[_qout].extra);
"""

SPEC = [
    ("Q1 sotn goto-loop back edge", [(HEAD, GOTO_HEAD), (TAIL, GOTO_TAIL)]),
    ("Q2 sotn inline slot re-reads", [(DISPATCH, DISPATCH_SOTN)]),
    ("Q3 both", [(HEAD, GOTO_HEAD), (TAIL, GOTO_TAIL), (DISPATCH, DISPATCH_SOTN)]),
]
