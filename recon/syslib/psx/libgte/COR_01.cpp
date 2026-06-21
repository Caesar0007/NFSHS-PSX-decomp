/* syslib/psx/libgte/COR_01.cpp -- RECONSTRUCTED from nfs4-f.exe (Ghidra; clean fixed-point).
 *   obj libgte.lib(COR_01.OBJ): csincos -- first-octant sine & cosine by 6-step CORDIC.
 *   Rotates the seed vector (x = 0x9B7 gain-compensated 1.0, y = 0) by `angle` (4.12, one
 *   revolution = 0x1000) driving the residual z to zero with the arctan table _H_cor_tbl, then
 *   linearly corrects for the leftover residual.  Outputs sin -> *psin, cos -> *pcos. */

static const int _H_cor_tbl[6] = { 511, 302, 159, 81, 41, 20 };   /* @0x8013BF20 : CORDIC arctan steps */

/* @0x80106AC4 : csincos(int angle, int *psin, int *pcos) -> sin */
extern "C" int csincos(int angle, int *psin, int *pcos)
{
    int buf[24];
    int *x = buf, *y = buf + 8, *z = buf + 16;   /* three 7-element columns, 8 ints apart */
    unsigned i;
    x[0] = 0x9b7;
    y[0] = 0;
    z[0] = angle;
    for (i = 0; i < 6; i++) {
        if (z[i] < 0) {
            x[i + 1] = x[i] + (y[i] >> (i & 0x1f));
            y[i + 1] = y[i] - (x[i] >> (i & 0x1f));
            z[i + 1] = z[i] + _H_cor_tbl[i];
        } else {
            x[i + 1] = x[i] - (y[i] >> (i & 0x1f));
            y[i + 1] = y[i] + (x[i] >> (i & 0x1f));
            z[i + 1] = z[i] - _H_cor_tbl[i];
        }
    }
    *pcos = x[6] - (z[6] * y[6] >> 0xc);
    *psin = y[6] + (z[6] * x[6] >> 0xc);
    return *psin;
}
