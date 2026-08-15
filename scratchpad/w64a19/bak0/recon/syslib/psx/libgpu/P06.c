/* syslib/psx/libgpu/P06.c -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj libgpu.lib(P06.OBJ): AddPrim @0x80107040.  Inserts primitive p at the head of the
 *   ordering-table entry *ot (24-bit linked-list address in the low 3 bytes of each tag). */
/* PsyQ's real P_TAG: a bitfield, not a byte-masked word (Xenogears libgpu.h confirms the
 * canonical macro shape: `#define addPrim(ot,p) setaddr(p,getaddr(ot)), setaddr(ot,p)` where
 * `setaddr(p,a) ((P_TAG*)(p))->addr = (u_long)(a)`).  The prior hand-masked-OR reconstruction
 * was semantically equivalent but put the two mask constants (0xff000000/0x00ffffff) in the
 * WRONG a2/a3 registers (14-diff near-miss; operand-order swaps within the OR were tried and
 * made it worse).  A REAL 24:8 bitfield store forces gcc's bitfield-insert lowering to
 * materialize the masks in the SAME order the compiler originally did -> exact match. */
typedef struct { unsigned int addr:24, len:8; } P_TAG;
extern void AddPrim(void *ot, void *p)   /* @0x80107040 */
{
    ((P_TAG *)p)->addr  = ((P_TAG *)ot)->addr;
    ((P_TAG *)ot)->addr = (unsigned int)p;
}
