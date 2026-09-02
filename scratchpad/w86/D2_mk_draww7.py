import pathlib
SING = ('  __asm__("" : : "r"(sd)); __asm__("" : : "r"(sd)); __asm__("" : : "r"(sd));\n'
        '  __asm__("" : : "r"(sd)); __asm__("" : : "r"(sd)); __asm__("" : : "r"(sd));\n')
MAC = ('  DRAWW_SD_REF10(); DRAWW_SD_REF10(); DRAWW_SD_REF10(); DRAWW_SD_REF10();\n'
       '  DRAWW_SD_REF10(); DRAWW_SD_REF10();\n')
HEAD = 'pair. */\n  {\n    int t1;\n'
TAILDEF = ('#define DRAWW_SD_REF10() \\\n'
           '  __asm__("" : : "r"(sd)); __asm__("" : : "r"(sd)); \\\n'
           '  __asm__("" : : "r"(sd)); __asm__("" : : "r"(sd)); \\\n'
           '  __asm__("" : : "r"(sd)); __asm__("" : : "r"(sd)); \\\n'
           '  __asm__("" : : "r"(sd)); __asm__("" : : "r"(sd)); \\\n'
           '  __asm__("" : : "r"(sd)); __asm__("" : : "r"(sd))\n')

A = '  sd = (Draw_tGiveShelbyMoreCache *)((unsigned int)sd | ((unsigned int)sd & 3u));\n'
B = '  sd = (Draw_tGiveShelbyMoreCache *)((unsigned int)sd & ((unsigned int)sd | 3u));\n'

def nofences():
    return [(SING, ''), (MAC, ''), (TAILDEF, ''), ('#undef DRAWW_SD_REF10\n', '')]

variants = []
for n in (1, 2, 3, 4, 6, 10, 16, 22, 33, 44):
    variants.append(('0f+abs%d' % n, nofences() + [(HEAD, 'pair. */\n' + A * n + '  {\n    int t1;\n')]))
variants.append(('0f+and1', nofences() + [(HEAD, 'pair. */\n' + B + '  {\n    int t1;\n')]))
variants.append(('0f+and4', nofences() + [(HEAD, 'pair. */\n' + B * 4 + '  {\n    int t1;\n')]))
pathlib.Path('scratchpad/w86/D2_p7.txt').write_text(repr(variants))
print(len(variants))
