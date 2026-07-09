/* syslib/psx/libgte/FGO_01.c -- RECONSTRUCTED from nfs4-f.exe (Ghidra; clean fixed-point).
 *   obj libgte.lib(FGO_01.OBJ): RotMatrix -- build a 3x3 rotation matrix from an SVECTOR of
 *   Euler angles (rx,ry,rz; one revolution = 0x1000).  Pure 4.12 fixed-point: sin/cos come
 *   from the packed lookup table _rsincos (low16 = sin, high16 = cos); sin is sign-corrected
 *   for negative angles (sin is odd, cos is even).  m is the standard Rz*Ry*Rx composition. */

extern const int _rsincos[];   /* @0x80137D20 : 4096 x {short sin; short cos} (one circle) */

/* @0x800F252C : RotMatrix(SVECTOR *r, MATRIX *m) -> m */
extern void *RotMatrix(void *r, void *m)
{
    short *rs = (short *)r;
    short *ms = (short *)m;
    int iVar1, iVar2, iVar3, iVar7, iVar8, iVar9;
    short sVar4;
    unsigned uVar6;

    uVar6 = (unsigned)rs[0];                         /* rx */
    if ((int)uVar6 < 0) { iVar7 = _rsincos[(-uVar6 & 0xfff)]; iVar1 = -(int)(short)iVar7; }
    else                { iVar7 = _rsincos[( uVar6 & 0xfff)]; iVar1 =  (int)(short)iVar7; }
    iVar7 = iVar7 >> 0x10;                           /* cos rx ; iVar1 = sin rx */
    uVar6 = (unsigned)rs[1];                         /* ry */
    if ((int)uVar6 < 0) { iVar8 = _rsincos[(-uVar6 & 0xfff)]; iVar2 = (int)(short)iVar8; sVar4 = -(short)iVar8; }
    else                { iVar8 = _rsincos[( uVar6 & 0xfff)]; sVar4 = (short)iVar8; iVar2 = -(int)sVar4; }
    iVar8 = iVar8 >> 0x10;                           /* cos ry ; sVar4 = sin ry, iVar2 = -sin ry */
    uVar6 = (unsigned)rs[2];                         /* rz */
    ms[2] = sVar4;
    ms[5] = (short)(-(iVar8 * iVar1) >> 0xc);
    ms[8] = (short)(iVar8 * iVar7 >> 0xc);
    if ((int)uVar6 < 0) { iVar9 = _rsincos[(-uVar6 & 0xfff)]; iVar3 = -(int)(short)iVar9; }
    else                { iVar9 = _rsincos[( uVar6 & 0xfff)]; iVar3 =  (int)(short)iVar9; }
    iVar9 = iVar9 >> 0x10;                           /* cos rz ; iVar3 = sin rz */
    ms[0] = (short)(iVar9 * iVar8 >> 0xc);
    ms[1] = (short)(-(iVar3 * iVar8) >> 0xc);
    iVar8 = iVar9 * iVar2 >> 0xc;
    ms[3] = (short)(iVar3 * iVar7 >> 0xc) - (short)(iVar8 * iVar1 >> 0xc);
    ms[6] = (short)(iVar3 * iVar1 >> 0xc) + (short)(iVar8 * iVar7 >> 0xc);
    iVar2 = iVar3 * iVar2 >> 0xc;
    ms[4] = (short)(iVar9 * iVar7 >> 0xc) + (short)(iVar2 * iVar1 >> 0xc);
    ms[7] = (short)(iVar9 * iVar1 >> 0xc) - (short)(iVar2 * iVar7 >> 0xc);
    return m;
}
