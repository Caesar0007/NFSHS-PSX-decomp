SRC = 'recon/syslib/psx/libgpu/FONT.c'
FNS = ['FntPrint']

LOOPB = """        while (len--, len != -1) {
            WriteChar(*bufPtr++);
        }
"""

SPEC = [
    ("B7 neg1 born BEFORE peel + launder", [(LOOPB, """        {
            int neg1 = -1;
            __asm__("" : "=r"(neg1) : "0"(neg1));
            len--;
            if (len != -1) {
                do {
                    WriteChar(*bufPtr++);
                    len--;
                } while (len != neg1);
            }
        }
""")]),
    ("B8 neg1 born BEFORE peel, no launder", [(LOOPB, """        {
            int neg1 = -1;
            len--;
            if (len != -1) {
                do {
                    WriteChar(*bufPtr++);
                    len--;
                } while (len != neg1);
            }
        }
""")]),
    ("B9 neg1 laundered, used in BOTH tests", [(LOOPB, """        {
            int neg1 = -1;
            __asm__("" : "=r"(neg1) : "0"(neg1));
            len--;
            if (len != neg1) {
                do {
                    WriteChar(*bufPtr++);
                    len--;
                } while (len != neg1);
            }
        }
""")]),
    ("B10 peel literal, loop neg1 laundered twice", [(LOOPB, """        len--;
        if (len != -1) {
            int neg1 = -1;
            __asm__("" : "=r"(neg1) : "0"(neg1));
            __asm__("" : "=r"(neg1) : "0"(neg1));
            do {
                WriteChar(*bufPtr++);
                len--;
            } while (len != neg1);
        }
""")]),
]
