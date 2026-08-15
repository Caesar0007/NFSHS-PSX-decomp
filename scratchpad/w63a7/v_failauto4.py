ANCHOR = """                info[0x49] = 2;
                __asm__("" : : "r"(info));
                info[0x46] = 0xff;
                return 0xff;"""

VARIANTS = [
    ("I1 minimal: launder only, no cast", """                info[0x49] = 2;
                r = 0xff;
                __asm__("" : "=r"(r) : "0"(r));
                info[0x46] = r;
                return r;"""),

    ("I2 minimal + cast", """                info[0x49] = 2;
                r = 0xff;
                __asm__("" : "=r"(r) : "0"(r));
                info[0x46] = (unsigned char)r;
                return r;"""),

    ("I3 control (unlaundered) for the law", """                info[0x49] = 2;
                r = 0xff;
                info[0x46] = (unsigned char)r;
                return r;"""),
]
