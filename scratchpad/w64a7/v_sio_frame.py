A0 = """    {
        int fix = _padFixResult[_padSioChan];"""
A1 = """    if (info[0x50] == 0)
        return 1;
    if (info[0x36] != 0)
        return 0;
    return 1;
}"""

ANCHOR = A0

CAST = """    {
        int fix = *(int *)((_padSioChan << 2) + (int)_padFixResult);"""
VOL = """    {
        int fix = *(volatile int *)&_padFixResult[_padSioChan];"""

VARIANTS = [
    ("A control", A0),
    ("D cast-int first read", CAST),
    ("E volatile first read", VOL),
]
