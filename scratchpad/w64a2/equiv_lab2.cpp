/* w64-a2 DEVICE LAB round 2 -- decisive witness pair for the REG_EQUIV
   live-length DOUBLING (gcc-2.8.1 local-alloc.c:1149-53).
   F and G are instruction-for-instruction the same shape; the ONLY difference
   is the unknown-alias store in G, which makes validate_equiv_mem() fail
   (local-alloc.c:1136) so no REG_EQUIV note is planted.                     */

extern int g[];
extern int *h;
extern void f(int);

int probeF(int a)
{
  int k = g[3];
  int r = k + a;
  r += k;
  r += k;
  r += k;
  r += k;
  return r;
}

int probeG(int a)
{
  int k = g[3];
  int r = k + a;
  *h = a;                 /* unknown-alias store INSIDE k's life */
  r += k;
  r += k;
  r += k;
  r += k;
  return r;
}

/* H/I: the same pair with the pseudo made GLOBAL (used in 2 blocks) -- the MEM
   route's REG_BASIC_BLOCK >= 0 gate should then REFUSE the note entirely, so
   H and I must show the SAME live length. */
int probeH(int a)
{
  int k = g[3];
  int r = k + a;
  if (a) { r += k; }
  r += k;
  r += k;
  r += k;
  return r;
}

int probeI(int a)
{
  int k = g[3];
  int r = k + a;
  *h = a;
  if (a) { r += k; }
  r += k;
  r += k;
  r += k;
  return r;
}
