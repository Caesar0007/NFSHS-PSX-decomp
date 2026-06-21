/* syslib/psx/libcard/END.cpp -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj libcard.lib(END.OBJ): _ExitCard -- exit handler: restore the BIOS B0[0x56] table-6 handler
 *   that _patch_card overwrote (zero it back), then flush the cache.  Kernel-only -> __mips__-guarded. */

extern "C" int  EnterCriticalSection(void); /* @0x8010698C */
extern "C" void ExitCriticalSection(void);  /* @0x8010696C */
extern "C" void FlushCache(void);           /* BIOS A0:0x44 @0x800F43D4 */

#if defined(__mips__)
static int *_bios_b0_table(int idx)
{
    int *t;
    /* BIOS B0-table thunk. Oracle disasm-v3 _patch_card @0x8010CA78: `$t1=<func#>; $t2=0xB0;
     * jalr $t2; ... = $v0`. PsyQ aspsx needs NUMERIC reg names in asm text (no ABI mnemonics):
     * $t1=$9 (func#), $t2=$10 (=0xB0), $v0=$2 (ret), $a0=$4 (=%1). Same physical regs as oracle. */
    __asm__ volatile("move $9,%1\n\t li $10,0xB0\n\t jalr $10\n\t nop\n\t move %0,$2"
                     : "=r"(t) : "r"(idx) : "t1", "t2", "ra", "v0", "memory");
    return t;
}
#endif

/* @0x8010CBC0 : _ExitCard -- un-patch the card handler and flush. */
extern "C" int _ExitCard(void)
{
    char *evt = (char *)0;
    EnterCriticalSection();
#if defined(__mips__)
    {
        int *tbl = _bios_b0_table(0x56);
        evt = (char *)tbl[6];                    /* *(24+tbl) ; $v0 @0x8010cbe0 */
        int  i;
        for (i = 0; i < 3; i++)                  /* restore the 3 overlaid words to 0 */
            ((unsigned int *)(evt + 112))[i] = 0;
    }
#endif
    FlushCache();
    ExitCriticalSection();
    return (int)(evt + 4);   /* incidental $v0 leftover = evt+4 (oracle @0x8010cc08 $v0+=4); discarded */
}
