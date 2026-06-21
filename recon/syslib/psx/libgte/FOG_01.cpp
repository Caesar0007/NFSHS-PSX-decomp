/* syslib/psx/libgte/FOG_01.cpp -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj libgte.lib(FOG_01.OBJ): SetFogNear -- set the depth-cue (fog) near plane.  Derives the
 *   GTE DQA coefficient from the near distance `a` and the projection width `dvpw`, then loads
 *   DQA/DQB.  (DQB is fixed at 0x1400000, matching InitGeom.) */

extern "C" void SetDQA(short dqa);   /* libgte REG03.obj @0x80106674 */
extern "C" void SetDQB(long dqb);    /* libgte REG03.obj @0x80106680 */

/* @0x800F27DC : SetFogNear */
extern "C" void SetFogNear(long a, long dvpw)
{
    SetDQA((short)(-(a * 320) / dvpw));   /* a*5<<6 = a*320 */
    SetDQB(0x1400000);
}
