ANCHOR = """extern int _dirCheck(unsigned char *info)
{
    int ff = 0xff;
    if (*(unsigned short *)(info + 0xe6) != 0 && info[0x46] == ff)
        return 0;
    return 1;
}"""

VARIANTS = [
    ("C1 early-out chain", """extern int _dirCheck(unsigned char *info)
{
    int r;
    if (*(unsigned short *)(info + 0xe6) == 0)
        return 1;
    r = 0xff;
    if (info[0x46] != r)
        return 1;
    r = 0;
    return r;
}"""),

    ("C2 B3 + void fence at ret1", """extern int _dirCheck(unsigned char *info)
{
    int r;
    if (*(unsigned short *)(info + 0xe6) != 0) {
        r = 0xff;
        if (info[0x46] == r) {
            r = 0;
            return r;
        }
    }
    __asm__("" : : "i"(0));
    return 1;
}"""),

    ("C3 B3 + exit-block device", """extern int _dirCheck(unsigned char *info)
{
    int r;
    if (*(unsigned short *)(info + 0xe6) != 0) {
        r = 0xff;
        if (info[0x46] == r) {
            r = 0;
            goto out;
        }
    }
    r = 1;
    if (0) {
out:
        ;
    }
    return r;
}"""),

    ("C4 B3, r=1 assigned then return r", """extern int _dirCheck(unsigned char *info)
{
    int r;
    if (*(unsigned short *)(info + 0xe6) != 0) {
        r = 0xff;
        if (info[0x46] == r)
            return r - r;
    }
    return 1;
}"""),

    ("C5 nested, 0 via the carrier, else literal 1", """extern int _dirCheck(unsigned char *info)
{
    int r;
    if (*(unsigned short *)(info + 0xe6) != 0) {
        r = 0xff;
        if (info[0x46] != r)
            return 1;
        r = 0;
        return r;
    }
    return 1;
}"""),
]
