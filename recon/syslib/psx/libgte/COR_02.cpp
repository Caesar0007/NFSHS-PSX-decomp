/* syslib/psx/libgte/COR_02.cpp -- RECONSTRUCTED from nfs4-f.exe (Ghidra).
 *   obj libgte.lib(COR_02.OBJ): ccos -- full-circle cosine.  Folds the angle (cosine is even)
 *   into one quadrant, calls csincos, and applies the quadrant sign. */

extern "C" int csincos(int angle, int *psin, int *pcos);   /* COR_01 */

/* @0x800F3728 : ccos(int a) -> cos (4.12) */
extern "C" int ccos(int a)
{
    int s, c;
    unsigned arg;
    if (a < 0) a = -a;
    arg = (unsigned)a & 0xfff;                       /* a mod 0x1000 */
    if (arg < 0x400)               { csincos((int)arg, &s, &c);          return c;  }
    if (arg - 0x400 < 0x400)       { csincos((int)(0x7ff - arg), &s, &c); return -c; }
    if (arg - 0x800 < 0x400)       { csincos((int)(arg - 0x800), &s, &c); return -c; }
    if (arg - 0xc00 < 0x400)       { csincos((int)(0xfff - arg), &s, &c); return c;  }
    return 0;
}
