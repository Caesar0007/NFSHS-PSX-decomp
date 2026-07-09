/* syslib/psx/libgte/COR_02.c -- RECONSTRUCTED from nfs4-f.exe (Ghidra + disasm-v3).
 *   obj libgte.lib(COR_02.OBJ): ccos -- full-circle cosine.  Cosine is even, so the angle is
 *   made non-negative, reduced modulo one revolution (0x1000) with a *signed* `%` (the oracle's
 *   sra/sll/subu round-to-zero sequence -- NOT an andi mask, since gcc cannot prove the negated
 *   value is non-negative), then folded into the first quadrant and sign-corrected. */

extern int csincos(int angle, int *psin, int *pcos);   /* COR_01 */

/* @0x800F3728 : ccos(int a) -> cos (4.12) */
extern int ccos(int a)
{
    int s, c;
    if (a < 0) a = -a;
    a = a % 0x1000;
    if ((unsigned)a < 0x400)             { csincos(a, &s, &c);          return c;  }
    if ((unsigned)(a - 0x400) < 0x400)   { csincos(0x7ff - a, &s, &c);  return -c; }
    if ((unsigned)(a - 0x800) < 0x400)   { csincos(a - 0x800, &s, &c);  return -c; }
    if ((unsigned)(a - 0xc00) < 0x400)   { csincos(0xfff - a, &s, &c);  return c;  }
    return c;
}
