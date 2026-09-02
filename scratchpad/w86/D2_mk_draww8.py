import pathlib
SING = ('  __asm__("" : : "r"(sd)); __asm__("" : : "r"(sd)); __asm__("" : : "r"(sd));\n'
        '  __asm__("" : : "r"(sd)); __asm__("" : : "r"(sd)); __asm__("" : : "r"(sd));\n')
MAC = ('  DRAWW_SD_REF10(); DRAWW_SD_REF10(); DRAWW_SD_REF10(); DRAWW_SD_REF10();\n'
       '  DRAWW_SD_REF10(); DRAWW_SD_REF10();\n')
TAILDEF = ('#define DRAWW_SD_REF10() \\\n'
           '  __asm__("" : : "r"(sd)); __asm__("" : : "r"(sd)); \\\n'
           '  __asm__("" : : "r"(sd)); __asm__("" : : "r"(sd)); \\\n'
           '  __asm__("" : : "r"(sd)); __asm__("" : : "r"(sd)); \\\n'
           '  __asm__("" : : "r"(sd)); __asm__("" : : "r"(sd)); \\\n'
           '  __asm__("" : : "r"(sd)); __asm__("" : : "r"(sd))\n')
HEAD = 'pair. */\n  {\n    int t1;\n'

def nof():
    return [(SING, ''), (MAC, ''), (TAILDEF, ''), ('#undef DRAWW_SD_REF10\n', '')]

def SD(ind='  '):
    return ind + 'sd = (Draw_tGiveShelbyMoreCache *)((unsigned int)sd | ((unsigned int)sd & 3u));\n'
def IQ(ind='    '):
    return ind + 'inQuad = (Trk_Quad *)((unsigned int)inQuad | ((unsigned int)inQuad & 3u));\n'

A1 = '    t2 = *(u_char *)((char *)inQuad + 3);\n'
A2 = '    geomVertices = sd->vertices;\n'
A3 = '    tx = (sd->trans).x;\n'
A4 = '    gte_ldv0((int *)(&vt0));\n'

variants = [
 ('head sd + head inQuad', nof() + [(HEAD, 'pair. */\n' + SD() + '  {\n    int t1;\n'),
                                    (A1, IQ() + A1)]),
 ('after t2 (sd)',   nof() + [(A1, A1 + SD('    '))]),
 ('after geomV (sd)', nof() + [(A2, A2 + SD('    '))]),
 ('after tx (sd)',    nof() + [(A3, A3 + SD('    '))]),
 ('after ldv0 (sd)',  nof() + [(A4, A4 + SD('    '))]),
 ('head sd, inQuad after t2', nof() + [(HEAD, 'pair. */\n' + SD() + '  {\n    int t1;\n'),
                                       (A1, A1 + IQ())]),
 ('head inQuad only', nof() + [(HEAD, 'pair. */\n' + '  inQuad = (Trk_Quad *)((unsigned int)inQuad | ((unsigned int)inQuad & 3u));\n' + '  {\n    int t1;\n')]),
 ('head sd x2 sep', nof() + [(HEAD, 'pair. */\n' + SD() + '  {\n    int t1;\n'), (A2, A2 + SD('    '))]),
]
pathlib.Path('scratchpad/w86/D2_p8.txt').write_text(repr(variants))
print(len(variants))
