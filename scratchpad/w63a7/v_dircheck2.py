ANCHOR = """extern int _dirCheck(unsigned char *info)
{
    int ff = 0xff;
    if (*(unsigned short *)(info + 0xe6) != 0 && info[0x46] == ff)
        return 0;
    return 1;
}"""

VARIANTS = [
    # B was 1 diff (12/11): the extra insn is a 2nd `jr ra`.  Share the exit.
    ("B1 goto shared exit", """extern int _dirCheck(unsigned char *info)
{
    int r;
    if (*(unsigned short *)(info + 0xe6) != 0) {
        r = 0xff;
        if (info[0x46] == r) {
            r = 0;
            goto done;
        }
    }
    r = 1;
done:
    return r;
}"""),

    ("B2 else-arm single exit", """extern int _dirCheck(unsigned char *info)
{
    int r;
    if (*(unsigned short *)(info + 0xe6) != 0) {
        r = 0xff;
        if (info[0x46] == r)
            r = 0;
        else
            r = 1;
    } else {
        r = 1;
    }
    return r;
}"""),

    ("B3 default-then-override", """extern int _dirCheck(unsigned char *info)
{
    int r;
    if (*(unsigned short *)(info + 0xe6) != 0) {
        r = 0xff;
        if (info[0x46] == r) {
            r = 0;
            return r;
        }
    }
    return 1;
}"""),

    ("B4 goto, r=1 before label only", """extern int _dirCheck(unsigned char *info)
{
    int r = 1;
    if (*(unsigned short *)(info + 0xe6) != 0) {
        int c = 0xff;
        if (info[0x46] == c)
            r = 0;
    }
    return r;
}"""),
]
