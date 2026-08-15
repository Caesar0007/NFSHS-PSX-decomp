ANCHOR = """                info[0x49] = 2;
                __asm__("" : : "r"(info));
                info[0x46] = 0xff;
                return 0xff;"""

VARIANTS = [
    ("H0 G5 repeat", """                info[0x49] = 2;
                __asm__("" : : "r"(info));
                r = 0xff;
                __asm__("" : "=r"(r) : "0"(r));
                info[0x46] = (unsigned char)r;
                return r;"""),

    ("H1 G5 without the info fence", """                info[0x49] = 2;
                r = 0xff;
                __asm__("" : "=r"(r) : "0"(r));
                info[0x46] = (unsigned char)r;
                return r;"""),

    ("H2 G5 no cast", """                info[0x49] = 2;
                __asm__("" : : "r"(info));
                r = 0xff;
                __asm__("" : "=r"(r) : "0"(r));
                info[0x46] = r;
                return r;"""),

    ("H3 launder AFTER the store", """                info[0x49] = 2;
                __asm__("" : : "r"(info));
                r = 0xff;
                info[0x46] = (unsigned char)r;
                __asm__("" : "=r"(r) : "0"(r));
                return r;"""),

    ("H4 read-only fence instead of identity", """                info[0x49] = 2;
                __asm__("" : : "r"(info));
                r = 0xff;
                __asm__("" : : "r"(r));
                info[0x46] = (unsigned char)r;
                return r;"""),

    ("H5 uchar carrier laundered", """                info[0x49] = 2;
                __asm__("" : : "r"(info));
                st = 0xff;
                __asm__("" : "=r"(st) : "0"(st));
                info[0x46] = st;
                return st;"""),
]
