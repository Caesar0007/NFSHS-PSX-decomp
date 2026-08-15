ANCHOR = """extern int _dirCheck(unsigned char *info)
{
    int ff = 0xff;
    if (*(unsigned short *)(info + 0xe6) != 0 && info[0x46] == ff)
        return 0;
    return 1;
}"""

VARIANTS = [
    # E2: ONE variable = the modeword AND the constant -> multi-block => GLOBAL
    # allocno, while the returns stay literal so the flat 11-insn layout holds.
    ("E2 mw-carrier, flat && (nested)", """extern int _dirCheck(unsigned char *info)
{
    int r = *(unsigned short *)(info + 0xe6);
    if (r != 0) {
        r = 0xff;
        if (info[0x46] == r)
            return 0;
    }
    return 1;
}"""),

    ("E3 mw-carrier, unsigned", """extern int _dirCheck(unsigned char *info)
{
    unsigned r = *(unsigned short *)(info + 0xe6);
    if (r != 0) {
        r = 0xff;
        if (info[0x46] == r)
            return 0;
    }
    return 1;
}"""),

    # E4: constant carrier global via a second (dead) block assignment
    ("E4 ff also set in the else path", """extern int _dirCheck(unsigned char *info)
{
    int ff;
    if (*(unsigned short *)(info + 0xe6) != 0) {
        ff = 0xff;
        if (info[0x46] == ff)
            return 0;
    } else {
        ff = 0;
    }
    return 1;
}"""),

    # E5: B3 shape but the 1-return also through the carrier and NO goto
    #     (checks whether the extra jr is the r-vs-literal choice)
    ("E5 B3 with literal 0 return", """extern int _dirCheck(unsigned char *info)
{
    int r;
    if (*(unsigned short *)(info + 0xe6) != 0) {
        r = 0xff;
        if (info[0x46] == r)
            return 0;
    }
    return 1;
}"""),
]
