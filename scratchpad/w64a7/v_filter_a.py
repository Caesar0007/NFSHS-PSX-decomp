A = """                i = 0;
                while (i != nmask) {
                    if (*map == mode && (mask & *dat) != 0) { matched = 1; break; }
                    map++; dat++;
                    i++;
                }"""

V1 = """                i = 0;
                if (nmask != 0) {
                    for (;;) {
                        if (*map == mode && (mask & *dat) != 0) { matched = 1; break; }
                        map++; dat++;
                        i++;
                        if (i >= nmask) break;
                    }
                }"""

V2 = """                i = 0;
                if (nmask != 0) {
                    do {
                        if (*map == mode && (mask & *dat) != 0) { matched = 1; goto found; }
                        map++; dat++;
                        i++;
                    } while (i < nmask);
                }
                found: ;"""

V3 = """                i = 0;
                if (nmask != 0) {
                    while (1) {
                        if (*map == mode && (mask & *dat) != 0) { matched = 1; break; }
                        map++; dat++;
                        if (++i >= nmask) break;
                    }
                }"""

V4 = """                i = 0;
                if (nmask != 0) {
                    do {
                        if (*map == mode && (mask & *dat) != 0) { matched = 1; break; }
                        map++; dat++;
                        i++;
                    } while (i < nmask);
                }"""

V5 = """                i = 0;
                if (nmask != 0) {
                    for (;;) {
                        if (*map == mode && (mask & *dat) != 0) { matched = 1; break; }
                        map++; dat++;
                        i++;
                        if (!(i < nmask)) break;
                    }
                }"""

V6 = """                i = 0;
                while (i != nmask) {
                    if (*map == mode && (mask & *dat) != 0) { matched = 1; break; }
                    map++; dat++;
                    i++;
                }
                __asm__("" : : "i"(0));"""

VARIANTS = [
    ("A control", []),
    ("V1 guard + for(;;) bottom-test", [(A, V1)]),
    ("V2 guard + do-while + goto", [(A, V2)]),
    ("V3 guard + while(1) preincr", [(A, V3)]),
    ("V4 guard + do-while + break", [(A, V4)]),
    ("V5 guard + for(;;) !(i<n)", [(A, V5)]),
    ("V6 control + void-tail fence", [(A, V6)]),
]
