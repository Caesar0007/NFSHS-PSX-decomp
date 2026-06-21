/* syslib/psx/libcard/PATCH.cpp -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj libcard.lib(PATCH.OBJ): the boot-time memory-card kernel patches.  PsyQ installs custom card
 *   interrupt handlers by overlaying small MIPS code blobs onto BIOS jump-table entries and into the
 *   kernel scratch area @0xDF80.  The instruction blobs are materialised below (raw words read from
 *   the EXE).  The table navigation + kernel writes are inherently target-only, so they live in a
 *   __mips__-guarded block (the host build is a no-op -- these patch the real PSX kernel).
 *     _copy_memcard_patch : copy the 28-word card-IRQ handler into kernel RAM @0xDF80.
 *     _patch_card  : overlay a jump into the patch onto a BIOS B0[0x56] table-6 handler.
 *     _patch_card2 : overlay a call to the patch onto the BIOS B0[0x57] table-91 handler @+2504. */

extern "C" int  EnterCriticalSection(void);   /* @0x8010698C */
extern "C" void ExitCriticalSection(void);    /* @0x8010696C */
extern "C" void FlushCache(void);             /* BIOS A0:0x44 @0x800F43D4 */

/* the card interrupt-handler code copied into the kernel @0xDF80 (28 words). */
static const unsigned int _memcard_patch_code[28] = {
    0x946f000a, 0x3c080000, 0x01e2c025, 0x37190012, 0xa479000a, 0x24080028, 0x2508ffff,
    0x1500fffe, 0x00000000, 0x03e00008, 0x00000000, 0x8c621074, 0x00000000, 0x30420080,
    0x1040000b, 0x00000000, 0x8c621044, 0x00000000, 0x30420080, 0x1440fffc, 0x00000000,
    0x3c020001, 0x8c42dffc, 0x00000000, 0x00400008, 0x00000000, 0x03e00008, 0x00000000
};
/* "lui v0,0xa001; addiu v0,v0,-0x2054; jr v0; nop; nop" -- jump into the patch (B0[0x56]). */
static const unsigned int _patch1_code[5] = { 0x3c02a001, 0x2442dfac, 0x00400008, 0, 0 };
/* "lui t0,0xa001; addiu t0,t0,-0x2080; jalr t0; nop; nop" -- call the patch (B0[0x57]). */
static const unsigned int _patch2_code[5] = { 0x3c08a001, 0x2508df80, 0x0100f809, 0, 0 };

#if defined(__mips__)
/* fetch a BIOS B0 jump table base (B0:`idx`). */
static int *_bios_b0_table(int idx)
{
    int *t;
    /* BIOS B0-table thunk. Oracle disasm-v3 _patch_card @0x8010CA78: `$t1=<func#>; $t2=0xB0;
     * jalr $t2; ... = $v0`. PsyQ aspsx needs NUMERIC reg names in asm text: $t1=$9/$t2=$10/$v0=$2
     * ($a0=$4=%1). Same physical regs as oracle. gcc2.7.2 clobbers use ABI names w/o `$`. */
    __asm__ volatile("move $9,%1\n\t li $10,0xB0\n\t jalr $10\n\t nop\n\t move %0,$2"
                     : "=r"(t) : "r"(idx) : "t1", "t2", "ra", "v0", "memory");
    return t;
}
#endif

/* @0x8010CB6C : copy the card-IRQ handler blob into the kernel scratch area @0xDF80. */
extern "C" int _copy_memcard_patch(void)
{
    volatile unsigned int *dst = (volatile unsigned int *)0xDF80;
    int i;
    for (i = 0; i < 28; i++)
        dst[i] = _memcard_patch_code[i];
    return 0;
}

/* @0x8010CA68 : overlay the jump-into-patch onto the BIOS B0[0x56] table-entry-6 handler. */
extern "C" int _patch_card(void)
{
    EnterCriticalSection();
#if defined(__mips__)
    {
        int *tbl = _bios_b0_table(0x56);
        int *evt = (int *)tbl[6];                                   /* *(24+tbl) */
        unsigned int *dst = (unsigned int *)(((evt[28] & 0xFFFF) << 16)
                                             + (evt[29] & 0xFFFF) + 0x28);
        int i;
        for (i = 0; i < 5; i++)
            dst[i] = _patch1_code[i];
    }
#endif
    FlushCache();
    ExitCriticalSection();
    return 0;
}

/* @0x8010CAFC : overlay the call-to-patch onto the BIOS B0[0x57] table-entry-91 handler @+2504. */
extern "C" int _patch_card2(void)
{
    EnterCriticalSection();
#if defined(__mips__)
    {
        int *tbl = _bios_b0_table(0x57);
        int  evt = tbl[91];                                         /* *(364+tbl) */
        unsigned int *dst = (unsigned int *)(evt + 2504);
        int i;
        for (i = 0; i < 5; i++)
            dst[i] = _patch2_code[i];
    }
#endif
    FlushCache();
    ExitCriticalSection();
    return 0;
}
