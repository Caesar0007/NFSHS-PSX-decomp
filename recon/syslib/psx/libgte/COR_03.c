/* syslib/psx/libgte/COR_03.c -- RECONSTRUCTED from nfs4-f.exe (Ghidra).
 *   obj libgte.lib(COR_03.OBJ): csin -- full-circle sine.  Sine is odd, so negative inputs are
 *   reflected; the magnitude is folded into one quadrant, csincos is called, and the quadrant
 *   sign is applied. */

extern int csincos(int angle, int *psin, int *pcos);   /* COR_01 */

/* @0x800F37F8 : csin(int a) -> sin (4.12) */
extern int csin(int a)
{
    int s, c;
    if (a >= 0) {
        unsigned u = (unsigned)a & 0xfff;
        if (u >= 0x400) {
            if (u - 0x400 >= 0x400) {                /* u >= 0x800 */
                unsigned u2 = u - 0x800;
                if (u2 >= 0x400) {                   /* u >= 0xc00 */
                    if (u - 0xc00 >= 0x400) return 0;
                    u2 = 0xfff - u;
                }
                csincos((int)u2, &s, &c);
                return -s;
            }
            u = 0x7ff - u;                            /* quadrant 2 */
        }
        csincos((int)u, &s, &c);
        return s;
    }
    {
        unsigned u = (unsigned)(-a) & 0xfff;
        if (u < 0x400)           { csincos((int)u, &s, &c);           return -s; }
        if (u - 0x400 < 0x400)   { csincos((int)(0x7ff - u), &s, &c); return -s; }
        {
            unsigned u2 = u - 0x800;
            if (u2 >= 0x400) {
                if (u - 0xc00 >= 0x400) return 0;
                u2 = 0xfff - u;
            }
            csincos((int)u2, &s, &c);
            return s;
        }
    }
}
