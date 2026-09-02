import pathlib
SING = ('  __asm__("" : : "r"(sd)); __asm__("" : : "r"(sd)); __asm__("" : : "r"(sd));\n'
        '  __asm__("" : : "r"(sd)); __asm__("" : : "r"(sd)); __asm__("" : : "r"(sd));\n')
MAC = ('  DRAWW_SD_REF10(); DRAWW_SD_REF10(); DRAWW_SD_REF10(); DRAWW_SD_REF10();\n'
       '  DRAWW_SD_REF10(); DRAWW_SD_REF10();\n')
HEAD = 'pair. */\n  {\n    int t1;\n'

def absorb(n):
    """n nested absorption identities on sd, each a real RTL insn combine folds away."""
    s = ''
    for i in range(n):
        s += '  sd = (Draw_tGiveShelbyMoreCache *)((unsigned int)sd | ((unsigned int)sd & 3u));\n'
    return s

variants = []
for n in (1, 2, 4, 8, 16, 24, 33):
    variants.append(('60f+abs%d' % n,
                     [(SING, ''), (HEAD, 'pair. */\n' + absorb(n) + '  {\n    int t1;\n')]))
pathlib.Path('scratchpad/w86/D2_p6.txt').write_text(repr(variants))
print(len(variants))
