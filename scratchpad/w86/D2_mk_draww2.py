import pathlib
SING = ('  __asm__("" : : "r"(sd)); __asm__("" : : "r"(sd)); __asm__("" : : "r"(sd));\n'
        '  __asm__("" : : "r"(sd)); __asm__("" : : "r"(sd)); __asm__("" : : "r"(sd));\n')
HEAD = 'pair. */\n  {\n    int t1;\n'

def infl(n):
    s = '  { int sdr = (int)sd;\n'
    for i in range(n):
        s += '    sdr &= (int)sd;\n'
    s += '    sd = (Draw_tGiveShelbyMoreCache *)sdr; }\n'
    return s

variants = []
for n in (2, 4, 6, 8, 12, 20):
    variants.append(('60f+headinfl%d' % n,
                     [(SING, ''), (HEAD, 'pair. */\n' + infl(n) + '  {\n    int t1;\n')]))
pathlib.Path('scratchpad/w86/D2_p2.txt').write_text(repr(variants))
print(len(variants))
