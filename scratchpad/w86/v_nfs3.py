NL = chr(10)
PINS = ('          register int z0 __asm__("$6") = 0;' + NL +
        '          register int z1 __asm__("$4") = 0;' + NL)
NOPIN = ('          int z0 = 0;' + NL +
         '          int z1 = 0;' + NL)
LOOP = ('  p = (int *)gFileMgr.oparray;' + NL +
        '  {' + NL +
        '  int *g = (int *)gFileMgr.handlearray;' + NL +
        '  if (p < g) {' + NL +
        '    e = g;' + NL +
        '    do {' + NL)
# variant loop shapes (all end with the same "do {" so the body is untouched)
L_direct = ('  p = (int *)gFileMgr.oparray;' + NL +
            '  {' + NL +
            '  int *g = (int *)gFileMgr.handlearray;' + NL +
            '  if (p < g) {' + NL +
            '    e = g;' + NL +
            '    do {' + NL)
TAIL = ('      p = p + 1;' + NL +
        '    } while (p < e);' + NL)

L_g_only = ('  p = (int *)gFileMgr.oparray;' + NL +
            '  {' + NL +
            '  int *g = (int *)gFileMgr.handlearray;' + NL +
            '  if (p < g) {' + NL +
            '    do {' + NL)
TAIL_g = ('      p = p + 1;' + NL +
          '    } while (p < g);' + NL)

L_count = ('  p = (int *)gFileMgr.oparray;' + NL +
           '  {' + NL +
           '  int *g = (int *)gFileMgr.handlearray;' + NL +
           '  int n = g - p;' + NL +
           '  if (0 < n) {' + NL +
           '    do {' + NL)
TAIL_count = ('      p = p + 1;' + NL +
              '      n = n - 1;' + NL +
              '    } while (n != 0);' + NL)

L_inflate = ('  p = (int *)gFileMgr.oparray;' + NL +
             '  {' + NL +
             '  int *g = (int *)gFileMgr.handlearray;' + NL +
             '  if (p < g) {' + NL +
             '    e = g;' + NL +
             '    e = (int *)((int)e & ((int)e | (int)p));' + NL +
             '    do {' + NL)

VARIANTS = [
    ("nopin_baseline", [(PINS, NOPIN)]),
    ("nopin_g_only", [(PINS, NOPIN), (LOOP, L_g_only), (TAIL, TAIL_g)]),
    ("nopin_count", [(PINS, NOPIN), (LOOP, L_count), (TAIL, TAIL_count)]),
    ("nopin_inflate_e", [(PINS, NOPIN), (LOOP, L_inflate)]),
    ("pins_count", [(LOOP, L_count), (TAIL, TAIL_count)]),
]
