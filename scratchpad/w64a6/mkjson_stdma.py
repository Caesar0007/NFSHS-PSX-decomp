import json

CR = "\r\n"
F_BV   = '    __asm__("" : : "r"(bv));   /* MATCH: DEMOTE bv (read-only fence) so dptr wins $v1 */' + CR
F_VOL1 = '    __asm__ __volatile__("");  /* MATCH: Rage Racer CD_dmastart barrier -- keep the DICR read-back serial */' + CR
F_VOL2 = '        __asm__ __volatile__("");  /* MATCH: Rage Racer CD_dmastart barrier */' + CR
F_BIT  = ('        __asm__("" : "=r"(bit) : "0"(bit));  /* MATCH: PROMOTE bit -> $v1 (2 refs => negative */' + CR +
          '        __asm__("" : "=r"(bit) : "0"(bit));  /* MATCH: allocno numerator; needs TWO fences)   */' + CR)
F_DP   = '        __asm__("" : "=r"(dp) : "0"(dp));  /* MATCH: PROMOTE dp -> $a0 (p then takes $a1) */' + CR

LIM_OLD = ('        if (i == 0x10000) {' + CR)
LIM_NEW = ('        if (i == lim) {' + CR)
DECL_OLD = '    int           mode;' + CR
DECL_NEW = '    int           mode;' + CR + '    int           lim;' + CR
INIT_OLD = '    mode = enable_irq;' + CR + '    i = 0;' + CR
INIT_NEW = '    lim = 0x10000;' + CR + '    mode = enable_irq;' + CR + '    i = 0;' + CR

V = []
V.append({"name": "R1 drop bv fence", "edits": [[F_BV, ""]]})
V.append({"name": "R2 drop bit fences", "edits": [[F_BIT, ""]]})
V.append({"name": "R3 drop dp fence", "edits": [[F_DP, ""]]})
V.append({"name": "R4 drop both vol barriers", "edits": [[F_VOL1, ""], [F_VOL2, ""]]})
V.append({"name": "R4a drop vol1 only", "edits": [[F_VOL1, ""]]})
V.append({"name": "R4b drop vol2 only", "edits": [[F_VOL2, ""]]})
V.append({"name": "R5 named loop limit", "edits": [[DECL_OLD, DECL_NEW], [INIT_OLD, INIT_NEW], [LIM_OLD, LIM_NEW]]})
V.append({"name": "R6 R5 + drop bv fence", "edits": [[DECL_OLD, DECL_NEW], [INIT_OLD, INIT_NEW], [LIM_OLD, LIM_NEW], [F_BV, ""]]})
V.append({"name": "R7 one bit fence only", "edits": [[F_BIT, '        __asm__("" : "=r"(bit) : "0"(bit));' + CR]]})
V.append({"name": "R8 three bit fences", "edits": [[F_BIT, F_BIT + '        __asm__("" : "=r"(bit) : "0"(bit));' + CR]]})

json.dump(V, open(r"C:\Temp\nfs4-decomp\scratchpad\w64a6\v_stdma.json", "w", encoding="utf-8"), indent=1)
print("wrote", len(V))
