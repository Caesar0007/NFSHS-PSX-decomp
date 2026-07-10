/* syslib/psx/libapi/COUNTER.c -- RECONSTRUCTED from nfs4-f.exe (disasm-v3 oracle).
 *   obj libapi.lib(COUNTER.OBJ): the Root-counter (RCnt) API -- SetRCnt @0x800E9E70,
 *   GetRCnt @0x800E9F0C, StartRCnt @0x800E9F44.  These reach the RCnt hardware THROUGH two
 *   base-pointer globals (NOT folded literal MMIO -- IDA folded them; the oracle loads them
 *   with lui/%hi + lw/%lo):
 *     RCnt_regs (D_801234B8) = 0x1F801100  -- RCnt count-register block; per-counter stride
 *                                             0x10, fields: count@+0, mode@+4, target@+8.
 *     RCnt_ctrl (D_801234B4) = 0x1F801070  -- IRQ-control base; the IRQ mask is at +4 (=0x1F801074).
 *     RCnt_irq  (D_801234BC) = {0x10,0x20,0x40,0x1, 0,0} -- per-counter I_MASK bit.
 *   The three globals live in a sibling data TU (COUNTER_data.cpp) so this TU references them
 *   as extern -> absolute lui/%hi addressing, matching the oracle (a small initialized global
 *   defined here would land in -G4 small-data -> gp-relative and break the match; §3.12 #6).
 *   The `spec` index is taken as a SIGNED int (the oracle's `slti`, not `sltiu`) and every
 *   function has a SINGLE return point the early-outs `goto` (the oracle's `j .Lret`).
 *   STATUS: structurally faithful to the oracle (correct base-pointer indexing + algorithm;
 *   replaces the prior IDA literal-MMIO version which was structurally WRONG).  Residual
 *   near-miss is pure hand-asm coloring/scheduling (GetRCnt 7, StartRCnt 10, SetRCnt 38==39
 *   insn-count): the `andi`-mask on a volatile u16 return and the store parked in the `jr $ra`
 *   delay slot are hand-written-asm idioms gcc won't reproduce here without a forbidden reg
 *   pin -- the SAME accepted near-miss class as the sibling RCnt helpers in libpad/WAITRC2. */

extern unsigned char  *RCnt_regs;   /* @0x801234B8 : = (uchar*)0x1F801100 */
extern unsigned char  *RCnt_ctrl;   /* @0x801234B4 : = (uchar*)0x1F801070 */
extern unsigned long   RCnt_irq[];  /* @0x801234BC : {0x10,0x20,0x40,0x1,0,0} */

/* @0x800E9E70 : SetRCnt(spec, target, mode) -- program a root counter, return 1 (0 if spec>=3). */
extern int SetRCnt(unsigned short spec, short target, short mode)
{
    int            s = spec;          /* signed index -> slti, not sltiu */
    unsigned char *reg;
    int            m;
    int            result;

    if (s >= 3) {
        result = 0;
        goto out;
    }

    reg = RCnt_regs + s * 16;
    *(volatile unsigned short *)(reg + 4) = 0;          /* clear mode */
    *(volatile unsigned short *)(reg + 8) = target;     /* set target */

    if (s < 2) {
        m = 0x48;
        if (mode & 0x10) m = 0x49;
        if ((mode & 1) == 0) m |= 0x100;
    } else {
        m = 0x48;
        if ((mode & 1) == 0) m = 0x248;
    }
    if (mode & 0x1000) m |= 0x10;

    *(volatile unsigned short *)(RCnt_regs + s * 16 + 4) = (unsigned short)m;
    result = 1;
out:
    return result;
}

/* @0x800E9F0C : GetRCnt(spec) -- read a counter's current count (0 if spec>=3). */
extern int GetRCnt(unsigned short spec)
{
    /* NEAR-MISS (7): tail andi 0xffff (volatile blocks the lhu/extend merge) + oracle's
     * duplicated `j .END`/v0=0 exit with UNFILLED j slot (-fno-delayed-branch lane class).
     * Tried+reverted: non-volatile read (kills the andi but flips the whole head coloring
     * s: v1->a0, net 19); if/else funnel and explicit `& 0xffff` (same flip). Coupled. */
    int s = spec;                     /* signed index -> slti */
    return (s < 3) ? *(volatile unsigned short *)(RCnt_regs + s * 16) : 0;
}

/* @0x800E9F44 : StartRCnt(spec) -- enable a counter's IRQ in the mask; return spec<3. */
extern int StartRCnt(unsigned short spec)
{
    int s = spec;                     /* signed index -> slti */
    *(volatile unsigned long *)(RCnt_ctrl + 4) |= RCnt_irq[s];
    return s < 3;
}
