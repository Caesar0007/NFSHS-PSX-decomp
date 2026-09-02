import pathlib

F = '      __asm__("" : : "r"(i),"r"(i),"r"(i),"r"(i),"r"(i));\n'
A = '      i = (int)((unsigned int)i | ((unsigned int)i & 3u));\n'
A2 = A + A
A4 = A * 4

ID0 = '      id0 = id0 * 8;\n'
ID2E = '      id2 = id2 + (int)sd;\n'
GTE = '      gte_rtpt();\n'
NCL = '      gte_nclip();\n'

variants = [
    ('abs in place x1', [(F, A)]),
    ('abs in place x2', [(F, A2)]),
    ('abs in place x4', [(F, A4)]),
    ('abs before the morph block', [(F, ''), (ID0, A + ID0)]),
    ('abs after id2', [(F, ''), (ID2E, ID2E + A)]),
    ('abs after rtpt', [(F, ''), (GTE, GTE + A)]),
    ('abs after nclip', [(F, ''), (NCL, NCL + A)]),
    ('fence kept + abs before morph', [(ID0, A + ID0)]),
]
pathlib.Path('scratchpad/w86/D2_dc2.txt').write_text(repr(variants))
print(len(variants))
