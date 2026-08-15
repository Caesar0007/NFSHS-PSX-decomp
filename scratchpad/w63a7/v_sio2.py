ANCHOR = """    if (info[0x36] != 0)
        return 0;
    {
        /* w62-a5 device: jump.c's store-flag transform folds two constant
           exits into `sltiu $v0,$v0,1`; laundering the surviving constant
           breaks the fold and restores retail's branched tail. */
        int one = 1;
        __asm__("" : "=r"(one) : "0"(one));
        return one;
    }"""

DEV = """    {
        int one = 1;
        __asm__("" : "=r"(one) : "0"(one));
        return one;
    }"""

VARIANTS = [
    ("R0 control (launder)", ANCHOR),

    ("R1 laundered byte temp", """    {
        int b = info[0x36];
        __asm__("" : "=r"(b) : "0"(b));
        if (b != 0)
            return 0;
    }
""" + DEV),

    ("R2 plain byte temp", """    {
        int b = info[0x36];
        if (b != 0)
            return 0;
    }
""" + DEV),

    ("R3 uchar byte temp", """    {
        unsigned char b = info[0x36];
        if (b != 0)
            return 0;
    }
""" + DEV),

    ("R4 read-only fence on one after the test", """    if (info[0x36] != 0)
        return 0;
    {
        int one = 1;
        __asm__("" : "=r"(one) : "0"(one));
        __asm__("" : : "r"(one));
        return one;
    }"""),
]
