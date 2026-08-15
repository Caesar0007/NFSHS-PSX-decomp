ANCHOR = """                info[0x49] = 2;
                __asm__("" : : "r"(info));
                info[0x46] = 0xff;
                return 0xff;"""

VARIANTS = [
    ("F0 control", ANCHOR),

    ("F1 shared-const carrier + cast", """                info[0x49] = 2;
                __asm__("" : : "r"(info));
                st = 0xff;
                info[0x46] = st;
                return st;"""),

    ("F2 shared-const int carrier", """                info[0x49] = 2;
                __asm__("" : : "r"(info));
                r = 0xff;
                info[0x46] = (unsigned char)r;
                return r;"""),

    ("F3 int carrier, no fence", """                info[0x49] = 2;
                r = 0xff;
                info[0x46] = (unsigned char)r;
                return r;"""),

    ("F4 uchar carrier, no fence", """                info[0x49] = 2;
                st = 0xff;
                info[0x46] = st;
                return st;"""),

    ("F5 carrier declared before the guard", """                info[0x49] = 2;
                __asm__("" : : "r"(info));
                cnt = 0xff;
                info[0x46] = (unsigned char)cnt;
                return (int)cnt;"""),
]
