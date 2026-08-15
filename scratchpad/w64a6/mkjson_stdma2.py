import json
CR = "\r\n"
P_OLD = '        p   = (volatile int *)(0x1F801080 + (ch << 4));' + CR
DECL_OLD = '    int           mode;' + CR
BCR_OLD = '        *p++ = (blocks << 16) | blocksize;          /* BCR  */' + CR
DP_OLD = ('        dp  = _dpcr;' + CR)

V = []
V.append({"name": "S1 int base, index first",
          "edits": [[DECL_OLD, DECL_OLD + '    int           base;' + CR],
                    [P_OLD, '        base = 0x1F801080;' + CR + '        p   = (volatile int *)((ch << 4) + base);' + CR]]})
V.append({"name": "S2 int base, base first",
          "edits": [[DECL_OLD, DECL_OLD + '    int           base;' + CR],
                    [P_OLD, '        base = 0x1F801080;' + CR + '        p   = (volatile int *)(base + (ch << 4));' + CR]]})
V.append({"name": "S3 literal, index first",
          "edits": [[P_OLD, '        p   = (volatile int *)((ch << 4) + 0x1F801080);' + CR]]})
V.append({"name": "S4 p computed before dp",
          "edits": [[P_OLD + DP_OLD, DP_OLD + P_OLD]]})
V.append({"name": "S5 named bcr before dp",
          "edits": [[DECL_OLD, DECL_OLD + '    int           bcr;' + CR],
                    [DP_OLD, '        bcr = (blocks << 16) | blocksize;' + CR + DP_OLD],
                    [BCR_OLD, '        *p++ = bcr;                                 /* BCR  */' + CR]]})
V.append({"name": "S6 S1 + named bcr",
          "edits": [[DECL_OLD, DECL_OLD + '    int           base;' + CR + '    int           bcr;' + CR],
                    [P_OLD, '        base = 0x1F801080;' + CR + '        p   = (volatile int *)((ch << 4) + base);' + CR],
                    [DP_OLD, '        bcr = (blocks << 16) | blocksize;' + CR + DP_OLD],
                    [BCR_OLD, '        *p++ = bcr;                                 /* BCR  */' + CR]]})
V.append({"name": "S7 bcr fenced before dp",
          "edits": [[DECL_OLD, DECL_OLD + '    int           bcr;' + CR],
                    [DP_OLD, '        bcr = (blocks << 16) | blocksize;' + CR + '        __asm__("" : "=r"(bcr) : "0"(bcr));' + CR + DP_OLD],
                    [BCR_OLD, '        *p++ = bcr;                                 /* BCR  */' + CR]]})

json.dump(V, open(r"C:\Temp\nfs4-decomp\scratchpad\w64a6\v_stdma2.json", "w", encoding="utf-8"), indent=1)
print("wrote", len(V))
