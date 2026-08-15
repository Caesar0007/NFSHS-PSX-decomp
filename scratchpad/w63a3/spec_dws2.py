SRC = 'recon/syslib/psx/libgpu/SYS.c'
FNS = ['_dws']

HEAD = """    saved = rect;
    var_s4 = 0;                                  /* GP0 cmd selector (0 = 0xA0 load) */
"""
DECLS = """    int to_write;
    int size;
    int var_s0;
    int var_s4;
    int quotient;
    int readyMask;
    RECT *saved;
"""

SPEC = [
    ("P1 read-only fence on rect first", [(HEAD, """    __asm__("" : : "r"(rect));
    saved = rect;
    var_s4 = 0;                                  /* GP0 cmd selector (0 = 0xA0 load) */
""")]),
    ("P2 read-only fence on data first", [(HEAD, """    __asm__("" : : "r"(data));
    saved = rect;
    var_s4 = 0;                                  /* GP0 cmd selector (0 = 0xA0 load) */
""")]),
    ("P3 saved declared FIRST", [(DECLS, """    RECT *saved;
    int to_write;
    int size;
    int var_s0;
    int var_s4;
    int quotient;
    int readyMask;
""")]),
    ("P4 var_s4 before saved", [(HEAD, """    var_s4 = 0;                                  /* GP0 cmd selector (0 = 0xA0 load) */
    saved = rect;
""")]),
    ("P5 identity launder on rect first", [(HEAD, """    __asm__("" : "=r"(rect) : "0"(rect));
    saved = rect;
    var_s4 = 0;                                  /* GP0 cmd selector (0 = 0xA0 load) */
""")]),
    ("P6 identity launder on data first", [(HEAD, """    __asm__("" : "=r"(data) : "0"(data));
    saved = rect;
    var_s4 = 0;                                  /* GP0 cmd selector (0 = 0xA0 load) */
""")]),
]
