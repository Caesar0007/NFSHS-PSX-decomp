/* w64-a2 DEVICE LAB: witness for the REG_EQUIV live-length DOUBLING
   (local-alloc.c:1149-53, `REG_LIVE_LENGTH (regno) *= 2;`).

   Gates read off gcc-2.8.1 local-alloc.c:1098-1160:
     - REG_N_SETS(regno) == 1                                       (:1101)
     - route CONSTANT: the single set carries a REG_EQUAL note whose
       source is CONSTANT_P  -> the note is RE-TAGGED REG_EQUIV       (:1116)
       (NO REG_BASIC_BLOCK gate -> works on GLOBAL allocnos)
     - route MEM: SET_SRC is a MEM, REG_BASIC_BLOCK(regno) >= 0 and
       validate_equiv_mem holds                                      (:1136)
       (block-local only)
   On MIPS a constant that needs lui+ori is emitted WITH a REG_EQUAL note,
   a constant that fits one insn is not -- that is the whole dial.

   Each probe pair has IDENTICAL structure/refs; only the source of `k`
   differs.  Read "Register N used R times across L insns" from -dl.        */

extern int g[];
extern void f(int);

/* A: k <- BIG constant (lui+ori, REG_EQUAL(const) -> REG_EQUIV -> live *= 2) */
int probeA(int a, int b)
{
  int k = 0x12345678;
  int r = g[0];
  if (a) { f(r); r = r + 1; }
  if (b) { f(r); r = r + 2; }
  r += k;
  f(r);
  r += k;
  f(r);
  return r + k;
}

/* B: k <- a value loaded from memory in the SAME position (no constant note,
      multi-block => the MEM route's REG_BASIC_BLOCK>=0 gate also fails) */
int probeB(int a, int b)
{
  int k = g[3];
  int r = g[0];
  if (a) { f(r); r = r + 1; }
  if (b) { f(r); r = r + 2; }
  r += k;
  f(r);
  r += k;
  f(r);
  return r + k;
}

/* C: k <- BIG constant but SET TWICE (REG_N_SETS != 1 kills the note) */
int probeC(int a, int b)
{
  int k = 0x12345678;
  int r = g[0];
  if (a) { f(r); r = r + 1; k = 0x12345678; }
  if (b) { f(r); r = r + 2; }
  r += k;
  f(r);
  r += k;
  f(r);
  return r + k;
}

/* D: k <- SMALL constant (single addiu, no REG_EQUAL note emitted) */
int probeD(int a, int b)
{
  int k = 5;
  int r = g[0];
  if (a) { f(r); r = r + 1; }
  if (b) { f(r); r = r + 2; }
  r += k;
  f(r);
  r += k;
  f(r);
  return r + k;
}

/* E: block-LOCAL pseudo loaded from a MEM (the MEM route, :1136) */
int probeE(int a)
{
  int k = g[3];
  int r;
  r = k + g[0];
  r += k;
  r += k;
  r += k + a;
  return r;
}
