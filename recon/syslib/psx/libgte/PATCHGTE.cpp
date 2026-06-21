/* syslib/psx/libgte/PATCHGTE.cpp -- RECONSTRUCTED from nfs4-f.exe (Ghidra + disasm-v3).
 *   obj libgte.lib(PATCHGTE.OBJ): _patch_gte -- the runtime workaround for the GTE hardware
 *   bug.  Inside a critical section it fetches the kernel exception-handler prologue (via BIOS
 *   B0:0x56 -> table, +0x18 -> handler, +0x28 -> the GTE save sequence) and, if it still matches
 *   the known-buggy template, overwrites it in place (self-modifying code) with a corrected
 *   sequence that reads the Cause register, then flushes the I-cache.  InitGeom calls this once.
 *
 *   _gte_patch_text @0x80106500 holds both halves: words [0..5] are the buggy pattern to match,
 *   words [6..11] the fixed replacement (the fix adds `mfc0 $2,$13` = read Cause). */

extern "C" int  EnterCriticalSection(void);   /* libapi A36 */
extern "C" void ExitCriticalSection(void);    /* libapi A37 */
extern "C" void FlushCache(void);             /* libapi C68 */

/* @0x80106500 : GTE exception-handler patch template (match-half + fix-half). */
static const unsigned _gte_patch_text[13] = {
    0xaf410004, 0xaf420008, 0xaf43000c, 0xaf5f007c, 0x40037000, 0x00000000,   /* [0..5] buggy pattern */
    0xaf410004, 0xaf420008, 0x40026800, 0xaf43000c, 0x40037000, 0xaf5f007c,   /* [6..11] fixed (mfc0 $2,$13) */
    0x00000000
};

/* @0x80106454 : _patch_gte */
extern "C" void _patch_gte(void)
{
    EnterCriticalSection();
#if defined(__mips__)
    int *handler;
    {
        int tbl;
        __asm__ volatile(                          /* BIOS B0:0x56 -> exception-handler table */
            "li $9,0x56\n\t"
            "li $10,0xB0\n\t"
            "jalr $10\n\t"
            "nop\n\t"
            "move %0,$2\n\t"
            : "=r"(tbl) : : "$8", "$9", "$10", "$2", "$3", "$31", "memory");
        handler = (int *)(*(int *)(tbl + 0x18) + 0x28);
    }
    {
        int i, ok = 1;
        for (i = 0; i < 6; i++)
            if (handler[i] != (int)_gte_patch_text[i]) { ok = 0; break; }
        if (ok)
            for (i = 0; i < 6; i++)
                handler[i] = (int)_gte_patch_text[6 + i];
    }
#endif
    FlushCache();
    ExitCriticalSection();
}
