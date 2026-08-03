TU = 'recon/game/psx/hud.cpp'
FNS = 'Hud_BuildString__FPciiiib'

VARIANTS = [
    # Y1: second *str load in the 0xE5 arm through a separate cursor (retail has 2 lbu)
    ('Y1 0xE5 arm re-reads via its own cursor', [
        ("""              alphShape = *str + 0x43;
              if ((u_char)*str == 0xe5) {
""", """              alphShape = *str + 0x43;
              if (*(u_char *)str == 0xe5) {
""")]),
    # Y2: the whole loop walks a cursor born just before it (shortens `str`'s live range)
    ('Y2 cursor local for the loop', [
        ("""  numch = strlen(str);
  i = 0;
""", """  numch = strlen(str);
  i = 0;
  str = str + 0;
""")]),
    # Y3: strlen AFTER ix/ox (birth-order re-test at this basin)
    ('Y3 strlen first', [
        ("""  ix = x;
  ox = x;
  numch = strlen(str);
""", """  numch = strlen(str);
  ix = x;
  ox = x;
""")]),
    # Y4: `i` counted down against numch so str gains a compare ref
    ('Y4 loop test on *str as well as numch', [
        ("""    if (numch <= i) break;    /* exit-in-the-middle: top test + `j` back-edge, tail out-of-line */
""", """    if (numch <= i) break;    /* exit-in-the-middle: top test + `j` back-edge, tail out-of-line */
    if (*str == 0) break;
""")]),
]
