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
 *   The source shape is shared with the Psy-Q SDK reconstruction in sotn-decomp: mask `spec`
 *   to 16 bits, model the 16-byte hardware register stride as a Counter struct, initialize
 *   final_mode before the range guard, and retain the explicit counter-2 test. */

extern unsigned char  *RCnt_regs;   /* @0x801234B8 : = (uchar*)0x1F801100 */
extern unsigned char  *RCnt_ctrl;   /* @0x801234B4 : = (uchar*)0x1F801070 */
extern unsigned long   RCnt_irq[];  /* @0x801234BC : {0x10,0x20,0x40,0x1,0,0} */

typedef struct Counter {
    unsigned short rootCounter;
    short          unk2;
    short          mode;
    short          pad6;
    short          target;
    short          padA;
    long           padC;
} Counter;

/* @0x800E9E70 : SetRCnt(spec, target, mode) -- program a root counter, return 1 (0 if spec>=3). */
extern long SetRCnt(unsigned long spec, unsigned short target, long flags)
{
    long i = spec & 0xffff;
    long final_mode = 0x48;

    if (i >= 3)
        return 0;

    ((volatile Counter *)RCnt_regs)[i].mode = 0;
    ((volatile Counter *)RCnt_regs)[i].target = target;

    if ((unsigned long)i < 2) {
        if (flags & 0x10)
            final_mode = 0x49;
        if (!(flags & 1))
            final_mode |= 0x100;
    } else if (i == 2) {
        if (!(flags & 1))
            final_mode = 0x248;
    }
    if (flags & 0x1000)
        final_mode |= 0x10;

    ((volatile Counter *)RCnt_regs)[i].mode = final_mode;
    return 1;
}

/* @0x800E9F0C : GetRCnt(spec) -- read a counter's current count (0 if spec>=3). */
extern long GetRCnt(long spec)
{
    long i = spec & 0xffff;
    if (i >= 3)
        return 0;
    return ((volatile Counter *)RCnt_regs)[i].rootCounter;
}

/* @0x800E9F44 : StartRCnt(spec) -- enable a counter's IRQ in the mask; return spec<3. */
extern long StartRCnt(unsigned long spec)
{
    long i = spec & 0xffff;
    ((volatile unsigned long *)RCnt_ctrl)[1] |= RCnt_irq[i];
    return i < 3;
}
