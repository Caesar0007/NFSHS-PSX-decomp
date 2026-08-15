SRC = 'recon/syslib/psx/libgpu/SYS.c'
FNS = ['_dws']

MASK = """    if ((*GPU_GP1 & 0x04000000) == 0) {          /* wait until ready to receive DMA */
        readyMask = 0x04000000;
        do {
            if (_gpu_check_timeout())
                return -1;
        } while ((*GPU_GP1 & readyMask) == 0);
    }
"""
MASK_NEW = """    readyMask = 0x04000000;
    __asm__("" : "=r"(readyMask) : "0"(readyMask));
    if ((*GPU_GP1 & 0x04000000) == 0) {          /* wait until ready to receive DMA */
        do {
            if (_gpu_check_timeout())
                return -1;
        } while ((*GPU_GP1 & readyMask) == 0);
    }
"""

LOOP = """    var_s0--;
    if (var_s0 != -1) {
        do {
            *GPU_GP0 = *data;
            data++;
            var_s0--;
        } while (var_s0 != -1);
    }
"""
LOOP_NEW = """    {
        int neg1 = -1;
        __asm__("" : "=r"(neg1) : "0"(neg1));
        var_s0--;
        if (var_s0 != -1) {
            do {
                *GPU_GP0 = *data;
                data++;
                var_s0--;
            } while (var_s0 != neg1);
        }
    }
"""

SPEC = [
    ("D1 mask launder before guard", [(MASK, MASK_NEW)]),
    ("D2 sentinel neg1 before peel", [(LOOP, LOOP_NEW)]),
    ("D3 both", [(MASK, MASK_NEW), (LOOP, LOOP_NEW)]),
]
