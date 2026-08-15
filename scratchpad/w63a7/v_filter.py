ANCHOR = """    } else {
        if (((unsigned char)(info[0xe8] - 4) < 2 || info[0xe8] == 7) &&
            (*(unsigned short *)(info + 0xe6) == 0 && info[0x34] > 1)) {
            if ((**(unsigned char **)(info + 0x28) & 0xc0) == 0x40 &&
                ((*(unsigned char **)(info + 0x28))[1] & 1) != 0 &&
                _padTotalCurr + 10 < 0x3d) {
                info[0x58] = 1;
                info[0x57] = 1;
                _padTotalCurr = _padTotalCurr + 10;
            }
        } else {
            if (info[0xe8] == 3) {"""

MID = """            if ((**(unsigned char **)(info + 0x28) & 0xc0) == 0x40 &&
                ((*(unsigned char **)(info + 0x28))[1] & 1) != 0 &&
                _padTotalCurr + 10 < 0x3d) {
                info[0x58] = 1;
                info[0x57] = 1;
                _padTotalCurr = _padTotalCurr + 10;
            }
        } else {
"""

VARIANTS = [
    ("M0 control", ANCHOR),

    ("M1 int e8 + opacity fence on info", """    } else {
        int e8 = info[0xe8];
        if (((unsigned char)(e8 - 4) < 2 || e8 == 7) &&
            (*(unsigned short *)(info + 0xe6) == 0 && info[0x34] > 1)) {
""" + MID + """            __asm__("" : "=r"(info) : "0"(info));
            if (info[0xe8] == 3) {"""),

    ("M2 int e8 + laundered alias pointer", """    } else {
        int e8 = info[0xe8];
        unsigned char *i2 = info;
        __asm__("" : "=r"(i2) : "0"(i2));
        if (((unsigned char)(e8 - 4) < 2 || e8 == 7) &&
            (*(unsigned short *)(info + 0xe6) == 0 && info[0x34] > 1)) {
""" + MID + """            if (i2[0xe8] == 3) {"""),

    ("M3 fence on info only (no e8 local)", """    } else {
        if (((unsigned char)(info[0xe8] - 4) < 2 || info[0xe8] == 7) &&
            (*(unsigned short *)(info + 0xe6) == 0 && info[0x34] > 1)) {
""" + MID + """            __asm__("" : "=r"(info) : "0"(info));
            if (info[0xe8] == 3) {"""),

    ("M4 int e8 alone (w61 control re-measure)", """    } else {
        int e8 = info[0xe8];
        if (((unsigned char)(e8 - 4) < 2 || e8 == 7) &&
            (*(unsigned short *)(info + 0xe6) == 0 && info[0x34] > 1)) {
""" + MID + """            if (info[0xe8] == 3) {"""),
]
