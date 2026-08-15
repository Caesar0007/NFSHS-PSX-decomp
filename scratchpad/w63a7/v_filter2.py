ANCHOR = """                i = 0;
                while (i != nmask) {
                    if (*map == mode && (mask & *dat) != 0) { matched = 1; break; }
                    map++; dat++;
                    i++;
                }"""

VARIANTS = [
    ("P0 control (!= bound)", ANCHOR),

    ("P1 guarded do-while (loop-2 shape)", """                i = 0;
                if (nmask != 0) {
                    do {
                        if (*map == mode && (mask & *dat) != 0) { matched = 1; break; }
                        map++; dat++;
                        i++;
                    } while (i < nmask);
                }"""),

    ("P2 guarded do-while, no braces", """                i = 0;
                if (nmask != 0)
                    do {
                        if (*map == mode && (mask & *dat) != 0) { matched = 1; break; }
                        map++; dat++;
                        i++;
                    } while (i < nmask);"""),

    ("P3 plain while (i < nmask)", """                i = 0;
                while (i < nmask) {
                    if (*map == mode && (mask & *dat) != 0) { matched = 1; break; }
                    map++; dat++;
                    i++;
                }"""),

    ("P4 guarded do-while + *map++ fused", """                i = 0;
                if (nmask != 0) {
                    do {
                        if (*map == mode && (mask & *dat) != 0) { matched = 1; break; }
                        map++; dat++;
                        i++;
                    } while (i < nmask);
                }"""),
]
