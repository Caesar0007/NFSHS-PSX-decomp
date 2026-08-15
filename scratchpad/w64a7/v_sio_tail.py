ANCHOR = """    if (info[0x50] == 0)
        return 1;
    if (info[0x36] != 0)
        return 0;
    return 1;
}"""

LAUNDER = """    if (info[0x50] == 0)
        return 1;
    if (info[0x36] != 0)
        return 0;
    {
        int one = 1;
        __asm__("" : "=r"(one) : "0"(one));
        return one;
    }
}"""

VARIANTS = [
    ("A control", ANCHOR),
    ("B w62 launder device", LAUNDER),
]
