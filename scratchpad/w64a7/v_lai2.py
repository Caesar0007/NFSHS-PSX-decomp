HI_A = """        {
            int hi = (*(unsigned char **)(info + 0x3c))[5];
            __asm__("" : "=r"(hi) : "0"(hi));
            d[4] = (unsigned char)(hi >> 7);
        }"""
HI_PLAIN = """        {
            int hi = (*(unsigned char **)(info + 0x3c))[5];
            d[4] = (unsigned char)(hi >> 7);
        }"""

BLK_A = """            cnt = 3;
            __asm__("" : "=r"(cnt) : "0"(cnt));  /* MATCH: opacity fence, 0 insns -- keeps cse from
                                                  * folding the live `3` into the woff `sll ,3`
                                                  * (retail rematerializes: `sllv` is the tell) */
            info[0x48] = v;
            d[0] = v;
            src = (*(unsigned char **)(info + 0x3c)) + 5;
            if (info[0x47] == 0) {
                base = *(unsigned char **)(info + 8);
                woff = (unsigned)info[0xea] << 3;
            } else {
                base = *(unsigned char **)(d - 4);
                woff = (d[-8] + 3) & 0x1fc;
            }
            cur = base + woff;
            *(unsigned char **)(d + 4) = cur;
            _actcur = cur;
        } else {"""

BLK_TOP = """            cnt = 3;
            info[0x48] = v;
            d[0] = v;
            src = (*(unsigned char **)(info + 0x3c)) + 5;
            if (info[0x47] == 0) {
                base = *(unsigned char **)(info + 8);
                woff = (unsigned)info[0xea] << 3;
            } else {
                base = *(unsigned char **)(d - 4);
                woff = (d[-8] + 3) & 0x1fc;
            }
            cur = base + woff;
            *(unsigned char **)(d + 4) = cur;
            _actcur = cur;
        } else {"""

BLK_END = """            info[0x48] = v;
            d[0] = v;
            src = (*(unsigned char **)(info + 0x3c)) + 5;
            if (info[0x47] == 0) {
                base = *(unsigned char **)(info + 8);
                woff = (unsigned)info[0xea] << 3;
            } else {
                base = *(unsigned char **)(d - 4);
                woff = (d[-8] + 3) & 0x1fc;
            }
            cur = base + woff;
            *(unsigned char **)(d + 4) = cur;
            _actcur = cur;
            cnt = 3;
        } else {"""

BLK_MID = """            info[0x48] = v;
            d[0] = v;
            src = (*(unsigned char **)(info + 0x3c)) + 5;
            if (info[0x47] == 0) {
                base = *(unsigned char **)(info + 8);
                woff = (unsigned)info[0xea] << 3;
            } else {
                base = *(unsigned char **)(d - 4);
                woff = (d[-8] + 3) & 0x1fc;
            }
            cnt = 3;
            cur = base + woff;
            *(unsigned char **)(d + 4) = cur;
            _actcur = cur;
        } else {"""

BLK_ENDF = """            info[0x48] = v;
            d[0] = v;
            src = (*(unsigned char **)(info + 0x3c)) + 5;
            if (info[0x47] == 0) {
                base = *(unsigned char **)(info + 8);
                woff = (unsigned)info[0xea] << 3;
            } else {
                base = *(unsigned char **)(d - 4);
                woff = (d[-8] + 3) & 0x1fc;
            }
            cur = base + woff;
            *(unsigned char **)(d + 4) = cur;
            _actcur = cur;
            cnt = 3;
            __asm__("" : "=r"(cnt) : "0"(cnt));
        } else {"""

BASE = [(HI_A, HI_PLAIN)]

VARIANTS = [
    ("A shipped", []),
    ("B -hi -cntfence (cnt at top)", BASE + [(BLK_A, BLK_TOP)]),
    ("C -hi cnt at END of block", BASE + [(BLK_A, BLK_END)]),
    ("D -hi cnt MID (after woff)", BASE + [(BLK_A, BLK_MID)]),
    ("E -hi cnt END + fence", BASE + [(BLK_A, BLK_ENDF)]),
]
