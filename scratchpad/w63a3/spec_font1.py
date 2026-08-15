SRC = 'recon/syslib/psx/libgpu/FONT.c'
FNS = ['FntPrint']

PERCENT = """    if (ch == 0)
        goto fnt_done;
    {
        percent = ch ^ (ch ^ '%');
    }
"""

LOOPB = """        while (len--, len != -1) {
            WriteChar(*bufPtr++);
        }
"""

SPEC = [
    # ---- (A) block reorg's eager steal of `li s4,37` into the beqz slot
    ("A1 void-tail fence before percent block", [(PERCENT, """    if (ch == 0)
        goto fnt_done;
    __asm__("" : : "i"(0));
    {
        percent = ch ^ (ch ^ '%');
    }
""")]),
    ("A2 void-tail fence inside percent block", [(PERCENT, """    if (ch == 0)
        goto fnt_done;
    {
        __asm__("" : : "i"(0));
        percent = ch ^ (ch ^ '%');
    }
""")]),
    ("A3 read-only fence on ch after the test", [(PERCENT, """    if (ch == 0)
        goto fnt_done;
    __asm__("" : : "r"(ch));
    {
        percent = ch ^ (ch ^ '%');
    }
""")]),
    # ---- (B) the loop-B sentinel: retail materializes -1 fresh, we copy it
    ("B1 explicit peel, two literal -1", [(LOOPB, """        len--;
        if (len != -1) {
            do {
                WriteChar(*bufPtr++);
                len--;
            } while (len != -1);
        }
""")]),
    ("B2 laundered neg1 in the loop only", [(LOOPB, """        len--;
        if (len != -1) {
            int neg1 = -1;
            __asm__("" : "=r"(neg1) : "0"(neg1));
            do {
                WriteChar(*bufPtr++);
                len--;
            } while (len != neg1);
        }
""")]),
    ("B3 laundered neg1, comma-peel kept", [(LOOPB, """        {
            int neg1 = -1;
            __asm__("" : "=r"(neg1) : "0"(neg1));
            while (len--, len != neg1) {
                WriteChar(*bufPtr++);
            }
        }
""")]),
]
