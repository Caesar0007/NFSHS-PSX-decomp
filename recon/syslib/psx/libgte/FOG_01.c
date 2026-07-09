/* syslib/psx/libgte/FOG_01.c -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj libgte.lib(FOG_01.OBJ): SetFogNear -- set the depth-cue (fog) near plane.  Derives the
 *   GTE DQA coefficient from the near distance `a` and the projection width `h`, then loads
 *   DQA/DQB.  (DQB is fixed at 0x1400000, matching InitGeom.)  The plain C `/` keeps the divide
 *   plus its ÷0 / INT_MIN-overflow `break` guards; the result flows straight into $a0, so DO NOT
 *   cast it to short here -- the callee (SetDQA) narrows it, the caller passes the full word.
 *   Identical to the PsyQ/SOTN source: SetDQA(-(a * 0x140) / h). */

/* SetDQA's GTE register takes the value raw from $a0 (handwritten ctc2, no narrowing);
 * the oracle passes the divide result un-truncated (mflo $a0 -> jal), so the prototype in
 * THIS TU is the wide form -- a `short` prototype would make gcc sign-truncate the arg
 * (spurious sll/sra) which the oracle does not have.  Oracle is the authority on arg width. */
extern void SetDQA(long dqa);    /* libgte REG03.obj @0x80106674 */
extern void SetDQB(long dqb);    /* libgte REG03.obj @0x80106680 */

/* @0x800F27DC : SetFogNear */
extern void SetFogNear(long a, long h)
{
    SetDQA(-(a * 0x140) / h);   /* 0x140 = 320 */
    SetDQB(0x1400000);
}
