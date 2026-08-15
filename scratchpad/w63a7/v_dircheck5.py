ANCHOR = """extern int _dirCheck(unsigned char *info)
{
    int ff = 0xff;
    if (*(unsigned short *)(info + 0xe6) != 0 && info[0x46] == ff)
        return 0;
    return 1;
}"""

VARIANTS = [
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
]
