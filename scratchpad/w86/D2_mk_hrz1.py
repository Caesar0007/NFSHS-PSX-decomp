import pathlib

I_OLD = '        __asm__ __volatile__("" : : "r"(i));\n'
I_NEW = ('        /* W86-D2: read-only ref fence -> pure-C ABSORPTION IDENTITY `X | (X & 3) == X`.\n'
         '           Real RTL through cse/loop/flow (reference counted, second SET), folded by\n'
         '           combine => zero bytes.  Ladder (whole-TU gate, Horizon_InterpolateLineSCoords):\n'
         '           fence removed 26 | one absorption PASS | 2 or 4 PASS | `X & (X | 3)` PASS. */\n'
         '        i = (int)((unsigned int)i | ((unsigned int)i & 3u));\n')

Q_OLD = ('                  int q = ringOffset + (int)hsd;\n'
         '                  __asm__("" : "=r"(q) : "0"(q));\n')
Q_NEW = ('                  int q = ringOffset + (int)hsd;\n'
         '                  /* W86-D2: identity launder -> pure-C ABSORPTION IDENTITY.  `q` keeps the\n'
         '                     second SET that stops cse re-associating the index-first sum, and\n'
         '                     combine folds the identity away at zero bytes.  Ladder (whole-TU gate,\n'
         '                     Hrz_BuildHorizon): device removed 48 | one absorption PASS | 2/4 PASS |\n'
         '                     `X & (X | 3)` PASS. */\n'
         '                  q = (int)((unsigned int)q | ((unsigned int)q & 3u));\n')

pathlib.Path('scratchpad/w86/D2_hz1.txt').write_text(
    repr([('hrzsku 2 clears', [(I_OLD, I_NEW), (Q_OLD, Q_NEW)])]))
print('ok')
