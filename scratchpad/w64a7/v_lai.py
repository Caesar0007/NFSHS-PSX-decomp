HI_A = """        {
            int hi = (*(unsigned char **)(info + 0x3c))[5];
            __asm__("" : "=r"(hi) : "0"(hi));
            d[4] = (unsigned char)(hi >> 7);
        }"""
HI_OFF = """        d[4] = (unsigned char)((*(unsigned char **)(info + 0x3c))[5] >> 7);"""
HI_PLAIN = """        {
            int hi = (*(unsigned char **)(info + 0x3c))[5];
            d[4] = (unsigned char)(hi >> 7);
        }"""

CNT_A = """            cnt = 3;
            __asm__("" : "=r"(cnt) : "0"(cnt));  /* MATCH: opacity fence, 0 insns -- keeps cse from
                                                  * folding the live `3` into the woff `sll ,3`
                                                  * (retail rematerializes: `sllv` is the tell) */"""
CNT_OFF = """            cnt = 3;"""

ANC_A = """        if (--cnt != -1) {
            ac = &_actcur;
            do {"""
ANC_OUT = """        ac = &_actcur;
        if (--cnt != -1) {
            do {"""
ANC_DIRECT = """        if (--cnt != -1) {
            do {"""

BODY_A = """                *(*ac)++ = *src++;"""
BODY_DIRECT = """                *_actcur++ = *src++;"""

VARIANTS = [
    ("A shipped (3 devices)", []),
    ("-hi fence", [(HI_A, HI_PLAIN)]),
    ("-hi local+fence", [(HI_A, HI_OFF)]),
    ("-cnt fence", [(CNT_A, CNT_OFF)]),
    ("-anchor-in-guard", [(ANC_A, ANC_OUT)]),
    ("-anchor at all", [(ANC_A, ANC_DIRECT), (BODY_A, BODY_DIRECT)]),
    ("-hi -cnt", [(HI_A, HI_PLAIN), (CNT_A, CNT_OFF)]),
    ("-hi -cnt -anchor", [(HI_A, HI_PLAIN), (CNT_A, CNT_OFF), (ANC_A, ANC_OUT)]),
]
