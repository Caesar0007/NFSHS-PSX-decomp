HEAD = """extern unsigned char *_pad_failall(int flag)
{
    unsigned char *ret;
    int noport = -9;
    int chan;

    do {"""

H_FENCE1 = """extern unsigned char *_pad_failall(int flag)
{
    unsigned char *ret;
    int noport = -9;
    int chan;

    __asm__("" : "=r"(flag) : "0"(flag));
    do {"""

H_FENCE2 = """extern unsigned char *_pad_failall(int flag)
{
    unsigned char *ret;
    int noport = -9;
    int chan;

    __asm__("" : "=r"(flag) : "0"(flag));
    __asm__("" : "=r"(flag) : "0"(flag));
    do {"""

BODY = """        unsigned char *info = _pad_info + _padSioChan * 0xf0;"""
B_OFF = """        int off = _padSioChan * 0xf0;
        unsigned char *info = _pad_info + off;"""
B_CH = """        int c0 = _padSioChan;
        unsigned char *info = _pad_info + c0 * 0xf0;"""
B_CHF = """        int c0 = _padSioChan;
        unsigned char *info = _pad_info + c0 * 0xf0;
        __asm__("" : "=r"(c0) : "0"(c0));"""

VARIANTS = [
    ("A control", []),
    ("F1 identity fence on flag @top", [(HEAD, H_FENCE1)]),
    ("F2 doubled identity fence @top", [(HEAD, H_FENCE2)]),
    ("Q1 named off temp", [(BODY, B_OFF)]),
    ("Q2 named chan temp", [(BODY, B_CH)]),
    ("Q3 named chan temp + launder", [(BODY, B_CHF)]),
    ("F1+Q2", [(HEAD, H_FENCE1), (BODY, B_CH)]),
]
