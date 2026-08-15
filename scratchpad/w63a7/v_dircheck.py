ANCHOR = """extern int _dirCheck(unsigned char *info)
{
    int ff = 0xff;
    if (*(unsigned short *)(info + 0xe6) != 0 && info[0x46] == ff)
        return 0;
    return 1;
}"""

VARIANTS = [
    ("control (landed)", ANCHOR),

    # A: ONE variable carries the compare constant AND both return values
    #    -> the `set (reg 2) (reg r)` copies give r a $v0 copy-PREFERENCE
    ("A carrier-var flat", """extern int _dirCheck(unsigned char *info)
{
    int r = 0xff;
    if (*(unsigned short *)(info + 0xe6) != 0 && info[0x46] == r) {
        r = 0;
        return r;
    }
    r = 1;
    return r;
}"""),

    # B: same, but born inside the guard (after the lhu dies)
    ("B carrier-var born-in-guard", """extern int _dirCheck(unsigned char *info)
{
    int r;
    if (*(unsigned short *)(info + 0xe6) != 0) {
        r = 0xff;
        if (info[0x46] == r) {
            r = 0;
            return r;
        }
    }
    r = 1;
    return r;
}"""),

    # C: carrier var, De-Morgan early-out spelling (keeps landed block order)
    ("C carrier early-out", """extern int _dirCheck(unsigned char *info)
{
    int r = 0xff;
    if (*(unsigned short *)(info + 0xe6) == 0 || info[0x46] != r)
        return 1;
    r = 0;
    return r;
}"""),

    # D: carrier var reused only for the two returns (constant bare literal)
    ("D returns-via-var only", """extern int _dirCheck(unsigned char *info)
{
    int r;
    if (*(unsigned short *)(info + 0xe6) != 0 && info[0x46] == 0xff) {
        r = 0;
        return r;
    }
    r = 1;
    return r;
}"""),

    # E: carrier var, single exit (funnel through the same var that held 0xff)
    ("E carrier single-exit", """extern int _dirCheck(unsigned char *info)
{
    int r = 0xff;
    if (*(unsigned short *)(info + 0xe6) != 0 && info[0x46] == r)
        r = 0;
    else
        r = 1;
    return r;
}"""),
]
