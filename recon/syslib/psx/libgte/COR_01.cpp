/* syslib/psx/libgte/COR_01.cpp -- RECONSTRUCTED from nfs4-f.exe (Ghidra + disasm-v3).
 *   obj libgte.lib(COR_01.OBJ): csincos -- first-octant sine & cosine by 6-step CORDIC.
 *   Rotates the seed vector (x = 0x9B7 gain-compensated 1.0, y = 0) by `angle` (4.12, one
 *   revolution = 0x1000) driving the residual z to zero with the arctan table _H_cor_tbl, then
 *   linearly corrects for the leftover residual.  Outputs sin -> *psin, cos -> *pcos.
 *
 *   buf[] holds three 7-element columns 8 ints (0x20 bytes) apart: x=buf[0..6], y=buf[8..14],
 *   z=buf[16..22].  The oracle walks ONE base pointer for the reads (x[i]=p[0], y[i]=p[8],
 *   z[i]=p[16]) plus separate induction pointers for the y[i+1]/z[i+1] stores and the table,
 *   shifting by the loop counter i (srav). */

static const int _H_cor_tbl[6] = { 511, 302, 159, 81, 41, 20 };   /* @0x8013BF20 : CORDIC arctan steps */

/* @0x80106AC4 : csincos(int angle, int *psin, int *pcos) -> sin */
extern "C" int csincos(int angle, int *psin, int *pcos)
{
    int buf[24];
    int *xi = buf;                 /* &x[i] : reads x[i]=xi[0], y[i]=xi[8], z[i]=xi[16] */
    int *yo = buf + 9;             /* &y[i+1] */
    int *zo = buf + 17;            /* &z[i+1] */
    const int *t = _H_cor_tbl;     /* &tbl[i] */
    int i;
    buf[0] = 0x9b7;
    buf[8] = 0;
    buf[16] = angle;
    for (i = 0; i < 6; i++) {
        if (xi[16] < 0) {
            xi[1] = xi[0] + (xi[8] >> i);
            *yo   = xi[8] - (xi[0] >> i);
            *zo   = xi[16] + *t;
        } else {
            xi[1] = xi[0] - (xi[8] >> i);
            *yo   = xi[8] + (xi[0] >> i);
            *zo   = xi[16] - *t;
        }
        xi++; yo++; zo++; t++;
    }
    *pcos = buf[6]  - (buf[22] * buf[14] >> 0xc);   /* x[6] - (z[6]*y[6] >> 12) */
    *psin = buf[14] + (buf[22] * buf[6]  >> 0xc);   /* y[6] + (z[6]*x[6] >> 12) */
    return *psin;
}
