# W64-A3 FntFlush (2): ours `addu $a0,$a2,$zero` (reload INHERITANCE from the
# still-live spill source) vs retail `lw $a0,16($sp)` (a real reload from the
# slot).  Re-probe the placement axis in THIS basin (04Z), since every prior
# reading was taken in the 6-diff basin.
SRC = 'recon/syslib/psx/libgpu/FONT.c'
FNS = ['FntFlush', 'FntPrint']

DR = "    dr = &fs->draw_mode;\n"
BLK = """    p       = fs->primbuf;
    autoupd = fs->autoupd;
    text    = (signed char *)fs->textbuf;
    remain  = fs->maxchars;
    curx    = fs->tile.x0;
    cury    = fs->tile.y0;
    rightx  = fs->tile.w;
    rightx  = curx + (short)rightx;     /* split load from add: w lands in its own temp */
    boty    = cury + fs->tile.h;

    TermPrim(dr);
"""

SPEC = [
    ("V1 void fence right after dr=",
     [(DR, DR + '    __asm__("" : : "i"(0));\n')]),
    ("V2 dr assigned just before TermPrim",
     [(DR, ""), (BLK, BLK.replace("    TermPrim(dr);\n", DR + "    TermPrim(dr);\n"))]),
    ("V3 TermPrim first, before the field loads",
     [(BLK, "    TermPrim(dr);\n" + BLK.replace("\n    TermPrim(dr);\n", ""))]),
    ("V4 identity launder on dr before TermPrim",
     [(BLK, BLK.replace("    TermPrim(dr);\n",
                        '    __asm__("" : "=r"(dr) : "0"(dr));\n    TermPrim(dr);\n'))]),
    ("V5 void fence just before TermPrim",
     [(BLK, BLK.replace("    TermPrim(dr);\n",
                        '    __asm__("" : : "i"(0));\n    TermPrim(dr);\n'))]),
]
