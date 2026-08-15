SRC = 'recon/syslib/psx/libgpu/FONT.c'
FNS = ['FntFlush']

CALL = """    TermPrim(dr);
"""

SPEC = [
    ("F1 m-constraint fence before the call", [(CALL, """    __asm__("" : : "m"(*dr));
    TermPrim(dr);
""")]),
    ("F2 volatile re-read of dr at the call", [(CALL, """    TermPrim(*(DR_MODE * volatile *)&dr);
""")]),
    ("F3 m-constraint fence on dr itself", [(CALL, """    __asm__("" : : "m"(dr));
    TermPrim(dr);
""")]),
    ("F4 opacity launder on dr before the call", [(CALL, """    __asm__("" : "=r"(dr) : "0"(dr));
    TermPrim(dr);
""")]),
]
