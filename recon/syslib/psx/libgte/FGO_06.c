/* syslib/psx/libgte/FGO_06.cpp -- RECONSTRUCTED from nfs4-f.exe (Ghidra; clean fixed-point).
 *   obj libgte.lib(FGO_06.OBJ): RotMatrixZ -- post-rotate the matrix m about Z by angle r.
 *   The bottom row (row 2) is untouched; rows 0 and 1 are mixed by sin/cos in 4.12 fixed point. */

extern const int _rsincos[];   /* @0x80137D20 : 4096 x {short sin; short cos} */

/* @0x800F312C : RotMatrixZ(long r, MATRIX *m) -> m */
void *RotMatrixZ(int r, void *m)
{
    short *ms = (short *)m;
    int s, c;
    int m00, m10, m01, m11, m02, m12;
    if (r < 0) { c = _rsincos[(-r & 0xfff)]; s = -(int)(short)c; }
    else       { c = _rsincos[( r & 0xfff)]; s =  (int)(short)c; }
    c = c >> 0x10;                                   /* cos ; s = sin */
    m00 = ms[0]; m10 = ms[3]; m01 = ms[1]; m11 = ms[4]; m02 = ms[2]; m12 = ms[5];
    ms[0] = (short)((c * m00 - s * m10) >> 0xc);
    ms[1] = (short)((c * m01 - s * m11) >> 0xc);
    ms[2] = (short)((c * m02 - s * m12) >> 0xc);
    ms[3] = (short)((s * m00 + c * m10) >> 0xc);
    ms[4] = (short)((s * m01 + c * m11) >> 0xc);
    ms[5] = (short)((s * m02 + c * m12) >> 0xc);
    return m;
}
