F = ('              __asm__("" : :\n'
     '                      "r"(i * 0xc0), "r"(i * 0xc0), "r"(i * 0xc0));\n')
BODY = ('              if (((*fMemIcon)[filenum][i][0] & 0xf7U) == 0x40) {\n'
        '                vramfxya((*fMemIcon)[filenum][i],i * 0x11 + 900,\n'
        '                         filenum * 0x11,clutx,cluty);\n'
        '              }\n')
ROW = ('              {\n'
       '                char *row = (*fMemIcon)[filenum][i];\n'
       '%s'
       '                if ((row[0] & 0xf7U) == 0x40) {\n'
       '                  vramfxya(row,i * 0x11 + 900,filenum * 0x11,clutx,cluty);\n'
       '                }\n'
       '              }\n')
ABSROW = '                row = (char *)((int)row & ((int)row | filenum));\n'
PULLED = '            __asm__("" : "=r"(pulled) : "0"(pulled));\n'

VARIANTS = [
    ("drop", [(F, "")]),
    ("row0", [(F, ""), (BODY, ROW % "")]),
    ("row1", [(F, ""), (BODY, ROW % ABSROW)]),
    ("row2", [(F, ""), (BODY, ROW % (ABSROW * 2))]),
    ("row3", [(F, ""), (BODY, ROW % (ABSROW * 3))]),
    ("keepfence_row1", [(BODY, ROW % ABSROW)]),
    ("absi", [(F, '              i &= (i | filenum);\n')]),
    ("absi3", [(F, '              i &= (i | filenum);\n' * 3)]),
]
