/* w64-a2 DEVICE LAB round 3.  Round 2 showed the MEM route did NOT fire for
   `k = g[3]` -- validate_equiv_mem() returns 0 as soon as ANY register mentioned
   in the MEM has a REG_DEAD note inside the scan, and under split-addresses the
   %hi base pseudo dies ON the load itself.  So the route needs an address whose
   registers do NOT die in k's life: a long-lived pointer, or an sp/fp-relative
   MEM (hard regs never carry REG_DEAD notes here).                            */

extern int g[];
extern int *h;
extern void f(int);

struct S { int a, b, c, d; };

/* J: address = a pointer that STAYS LIVE past the load (no REG_DEAD on it) */
int probeJ(S *p, int a)
{
  int k = p->d;
  int r = k + a;
  r += k;
  r += k;
  r += k;
  r += p->a;          /* keeps p live past k's death */
  return r;
}

/* K: control -- same shape but p DIES at the load */
int probeK(S *p, int a)
{
  int k = p->d;
  int r = k + a;
  r += k;
  r += k;
  r += k;
  r += a;
  return r;
}

/* L: sp-relative MEM (a local array element) */
int probeL(int a)
{
  int loc[8];
  int i;
  int r;
  for (i = 0; i < 8; i++) loc[i] = a + i;
  {
    int k = loc[3];
    r = k + a;
    r += k;
    r += k;
    r += k;
  }
  return r;
}

/* M: control for L -- the same value produced by arithmetic, not a MEM */
int probeM(int a)
{
  int loc[8];
  int i;
  int r;
  for (i = 0; i < 8; i++) loc[i] = a + i;
  {
    int k = a + 3;
    r = k + a;
    r += k;
    r += k;
    r += k;
    r += loc[3];
  }
  return r;
}

/* N: control for L -- an unknown-alias store INSIDE k's life makes
   validate_equiv_mem() fail (equiv_mem_modified), so no note is planted. */
int probeN(int a)
{
  int loc[8];
  int i;
  int r;
  for (i = 0; i < 8; i++) loc[i] = a + i;
  {
    int k = loc[3];
    r = k + a;
    *h = a;
    r += k;
    r += k;
    r += k;
  }
  return r;
}

/* O: L with ONE MORE use of k -- live must stay exactly 2 x span. */
int probeO(int a)
{
  int loc[8];
  int i;
  int r;
  for (i = 0; i < 8; i++) loc[i] = a + i;
  {
    int k = loc[3];
    r = k + a;
    r += k;
    r += k;
    r += k;
    r += k;
  }
  return r;
}

/* P: the CONSTANT route -- a loop-INVARIANT big literal that loop.c hoists into
   the preheader carries a REG_EQUAL(const) note, which local-alloc.c:1116
   re-tags REG_EQUIV -> live length doubled. */
int probeP(int n)
{
  int r = 0;
  int i;
  for (i = 0; i < n; i++) r += g[i] & 0x12345678;
  return r;
}

/* Q: control -- the same mask value arriving from memory (no constant note) */
int probeQ(int n)
{
  int r = 0;
  int i;
  int m = *h;
  for (i = 0; i < n; i++) r += g[i] & m;
  return r;
}
