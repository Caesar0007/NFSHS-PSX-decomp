/* syslib/psx/libgpu/P06.c -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj libgpu.lib(P06.OBJ): AddPrim @0x80107040.  Inserts primitive p at the head of the
 *   ordering-table entry *ot (24-bit linked-list address in the low 3 bytes of each tag). */
extern void AddPrim(void *ot, void *p)   /* @0x80107040 */
{
    /* NEAR-MISS (14): pure $a2<->$a3 assignment swap of the two mask constants
     * (count matches). Tried+reverted: named locals in oracle order (no change),
     * operand-order swap (worse, flips load order). Allocation tie-break. */
    *(unsigned int *)p  = (*(unsigned int *)p  & 0xff000000u) | (*(unsigned int *)ot & 0x00ffffffu);
    *(unsigned int *)ot = (*(unsigned int *)ot & 0xff000000u) | ((unsigned int)p     & 0x00ffffffu);
}
