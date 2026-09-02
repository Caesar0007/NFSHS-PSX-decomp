import json, pathlib
SING = ('  __asm__("" : : "r"(sd)); __asm__("" : : "r"(sd)); __asm__("" : : "r"(sd));\n'
        '  __asm__("" : : "r"(sd)); __asm__("" : : "r"(sd)); __asm__("" : : "r"(sd));\n')

def infl(n, var='sdr'):
    s = '  { int %s = (int)sd;\n' % var
    for i in range(n):
        s += '    %s &= (int)sd;\n' % var
    s += '    sd = (Draw_tGiveShelbyMoreCache *)%s; }\n' % var
    return s

variants = [
    ('60fences_only', [(SING, '')]),
    ('60fences+infl5_tail', [(SING, infl(5))]),
    ('60fences+infl12_tail', [(SING, infl(12))]),
    ('60fences+infl30_tail', [(SING, infl(30))]),
]
pathlib.Path('scratchpad/w86/D2_p1.txt').write_text(repr(variants))
print(len(variants))
