import pathlib

OFF7D = ('              int off7d = 0x7d; /* SYM-CODEGEN-CARRIER: off7d -- one-site opacity prevents the four 0x7d stores from becoming a loop movable */\n'
         '              __asm__("" : "=r"(off7d) : "0"(off7d)); sd->offset = off7d; }\n')
OFF7D_NEW = ('              /* W86-D2: the identity launder is replaced by a PURE-C DEAD FIRST SET.\n'
             '                 A second (non-consecutive-value) SET of the carrier is all loop.c needs\n'
             '                 to refuse the movable; the dead `= 0` store is deleted by flow, so this\n'
             '                 costs zero instructions.  Ladder (whole-TU gate, DrawW_DoTrough):\n'
             '                   device removed .................... 44\n'
             '                   `off7d = 0x7d;` twice (consecutive) . 44 (cse folds the 2nd set)\n'
             '                   `off7d = 0; off7d = 0x7d;` ......... PASS  <- landed\n'
             '                   `... = 0x7d; store; off7d = 0;` .... PASS (equivalent) */\n'
             '              int off7d = 0; /* SYM-CODEGEN-CARRIER: off7d -- the dead first set is what stops loop.c merging the four 0x7d stores into one movable */\n'
             '              off7d = 0x7d;\n'
             '              sd->offset = off7d; }\n')

A = ('  objInstance = (Trk_SimpleInst *)(group + 1);\n'
     '  __asm__("" : "=r"(objInstance) : "0"(objInstance));\n')
A_NEW = ('  /* W86-D2: identity launder -> PURE-C save/dead-set/restore (zero insns, no asm).\n'
         '     `objInstance = 0;` alone BEFORE the real assignment does NOT work (34); the\n'
         '     working shape is real-value first, then the dead set, then the restore. */\n'
         '  objInstance = (Trk_SimpleInst *)(group + 1);\n'
         '  { Trk_SimpleInst *oi = objInstance; objInstance = 0; objInstance = oi; }\n')

B = ('    __asm__("" : "=r"(objInstance) : "0"(objInstance));\n'
     '    /* MATCH (w71-a1): the oracle\'s element loop is UN-ROTATED')
B_NEW = ('    /* W86-D2: identity launder -> PURE-C save/dead-set/restore (zero insns, no asm). */\n'
         '    { Trk_SimpleInst *oi = objInstance; objInstance = 0; objInstance = oi; }\n'
         '    /* MATCH (w71-a1): the oracle\'s element loop is UN-ROTATED')

variants = [('land3', [(OFF7D, OFF7D_NEW), (A, A_NEW), (B, B_NEW)])]
pathlib.Path('scratchpad/w86/D2_l1.txt').write_text(repr(variants))
print('ok')
