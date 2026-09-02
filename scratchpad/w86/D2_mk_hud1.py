import pathlib

OLD = ('              __asm__("" : "=r"(str) : "0"(str));\n'
       '              alphShape = *str + 0x43;\n')
NEW = ('              /* W86-D2: the identity fence is replaced by a PURE-C save/dead-set/restore.\n'
       '                 The pseudo still gets the extra SET that makes cse forget the byte it\n'
       '                 loaded for the `- 0x30` range test, so the 0xE5 arm re-reads `lbu v1,0(s2)`\n'
       '                 exactly as retail does; the dead `= 0` store is deleted by flow, so this\n'
       '                 costs zero instructions.  Ladder (whole-TU gate, Hud_BuildString):\n'
       '                   device removed ............................ 33\n'
       '                   `str = 0;` after the last read (dead set) .. 33\n'
       '                   save / dead set / restore ................. PASS  <- landed\n'
       '                 (the dead value is free: 0, 1 and -1 all PASS). */\n'
       '              { char *s_ = str; str = 0; str = s_; }\n'
       '              alphShape = *str + 0x43;\n')

pathlib.Path('scratchpad/w86/D2_h1.txt').write_text(repr([('hud2079 save0', [(OLD, NEW)])]))
print('ok')
