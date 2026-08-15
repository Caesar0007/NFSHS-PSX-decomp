SRC = 'recon/syslib/psx/libgpu/FONT.c'
FNS = ['FntPrint']

LOOPB = """        while (len--, len != -1) {
            WriteChar(*bufPtr++);
        }
"""

SPEC = [
    ("B1' explicit peel, two literal -1", [(LOOPB, """        len--;
        if (len != -1) {
            do {
                WriteChar(*bufPtr++);
                len--;
            } while (len != -1);
        }
""")]),
    ("B2' laundered neg1 in the loop only", [(LOOPB, """        len--;
        if (len != -1) {
            int neg1 = -1;
            __asm__("" : "=r"(neg1) : "0"(neg1));
            do {
                WriteChar(*bufPtr++);
                len--;
            } while (len != neg1);
        }
""")]),
    ("B4 fence between peel and loop", [(LOOPB, """        len--;
        if (len != -1) {
            __asm__("" : : "i"(0));
            do {
                WriteChar(*bufPtr++);
                len--;
            } while (len != -1);
        }
""")]),
    ("B5 read-only fence on len before loop", [(LOOPB, """        len--;
        if (len != -1) {
            __asm__("" : : "r"(len));
            do {
                WriteChar(*bufPtr++);
                len--;
            } while (len != -1);
        }
""")]),
    ("B6 peel >= 0, loop != -1", [(LOOPB, """        len--;
        if (len >= 0) {
            do {
                WriteChar(*bufPtr++);
                len--;
            } while (len != -1);
        }
""")]),
    ("B0 control (unchanged shape, marker only)", [(LOOPB, """        while (len--, len != -1) {
            WriteChar(*bufPtr++); /* control */
        }
""")]),
]
