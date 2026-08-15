ANCHOR = """                info[0x49] = 2;
                __asm__("" : : "r"(info));
                info[0x46] = 0xff;
                return 0xff;"""

VARIANTS = [
    ("G1 embedded assign + fence", """                info[0x49] = 2;
                __asm__("" : : "r"(info));
                return (info[0x46] = 0xff);"""),

    ("G2 embedded assign, no fence", """                info[0x49] = 2;
                return (info[0x46] = 0xff);"""),

    ("G3 embedded assign via st", """                info[0x49] = 2;
                __asm__("" : : "r"(info));
                st = (info[0x46] = 0xff);
                return st;"""),

    ("G4 int carrier no cast + fence", """                info[0x49] = 2;
                __asm__("" : : "r"(info));
                r = 0xff;
                info[0x46] = r;
                return r;"""),

    ("G5 identity-launder the constant", """                info[0x49] = 2;
                __asm__("" : : "r"(info));
                r = 0xff;
                __asm__("" : "=r"(r) : "0"(r));
                info[0x46] = (unsigned char)r;
                return r;"""),
]
