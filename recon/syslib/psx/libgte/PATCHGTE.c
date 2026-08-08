/* syslib/psx/libgte/PATCHGTE.c -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj libgte.lib(PATCHGTE.OBJ): _patch_gte -- the runtime workaround for the GTE hardware
 *   bug.  The oracle is genuine HANDWRITTEN assembly (it spills $ra to a FIXED GLOBAL
 *   D_8014898C rather than the stack, and calls the BIOS via a raw `jalr $t2` after loading
 *   $t1=0x56,$t2=0xB0).  Inside a critical section it fetches the kernel exception-handler
 *   prologue (BIOS B0:0x56 -> table; +0x18 -> handler; +0x28 -> the GTE save sequence) and,
 *   if it still matches the known-buggy template, overwrites it in place (self-modifying code)
 *   with a corrected sequence that reads the Cause register, then flushes the I-cache.
 *   InitGeom calls this once.  Because it is handwritten, the faithful form is a FILE-SCOPE
 *   __asm__ emitting the exact instruction stream (same idiom as the BIOS thunks / InitGeom),
 *   NOT a register pin.  Host = portable no-op (no BIOS / GTE).
 *
 *   _gte_patch_text @0x80106500 holds both halves: words [0..5] are the buggy pattern to match
 *   (the loop walks &word[0]..&word[6]), words [6..11] the fixed replacement copied over the
 *   handler (the loop copies &word[6]..&word[12]); the fix adds `mfc0 $2,$13` = read Cause.
 *
 *   w26-a3 TOOLCHAIN migration (.cpp -> .c, CC1PSX/C lane). Two blockers, both resolved:
 *   1. `extern "C"` is meaningless in C (already default linkage) -- stripped, and the
 *      `extern "C" { ... }` BLOCK wrapping _gte_patch_text (C++-only syntax) removed outright;
 *      a plain non-static file-scope `const` array already has external linkage in C99/C89 (C,
 *      unlike C++, does NOT give `const` internal linkage), so nothing else changes.
 *   2. CC1PSX emits this TU's data BEFORE the file-scope __asm__ block (the reverse of
 *      cc1plus's order here -- cc1plus emits the asm FIRST, with `_gte_patch_text` optimized
 *      away entirely as apparently-unreferenced, a PRE-EXISTING and ORTHOGONAL data-loss bug in
 *      the prior .cpp build, confirmed by objdump -t showing `_gte_patch_text` as `*UND*` there
 *      -- flagged separately, not fixed by this migration since it's not this task's scope).
 *      Under cc1, `_gte_patch_text` lands in `.rdata` (a `.rdata`-then-`.text` switch with NO
 *      section directive emitted at the asm's `#APP` boundary, since gcc doesn't know the raw
 *      asm text is about to define a labeled function) -- so without a fix, `_patch_gte`'s
 *      instruction bytes assemble into `.rodata`, not `.text`. FIX (re-verified cheaply, proven
 *      via an isolated repro + real objdump -h/-t: `.text` size correct, `_patch_gte` symbol
 *      correctly in the `.text` section, `_gte_patch_text` correctly in `.rodata` -- this route
 *      DOES work under Task 1's generalized maspsx `.section` parser, contradicting the earlier
 *      "confirmed not fixable" note): prepend a literal `.section .text` as the FIRST line
 *      inside the `__asm__` string, so the assembler explicitly switches back to `.text` before
 *      any of `_patch_gte`'s real instructions, regardless of whatever section preceded it.
 *      `_patch_gte` byte-matches: PASS, 43 insns (unchanged from the pre-migration baseline). */

extern int  EnterCriticalSection(void);   /* libapi A36 */
extern void ExitCriticalSection(void);    /* libapi A37 */
extern void FlushCache(void);             /* libapi C68 */

/* @0x80106500 : GTE exception-handler patch template (match-half + fix-half).
 * Must be an initialized .rodata/.data table so the loop bounds &[0]/&[6]/&[12] resolve;
 * the handwritten loops reference it as func_80106500 / D_80106518 / D_80106530. */
#if defined(__mips__)
extern const unsigned _gte_patch_text[13];   /* w48-a8: defined in the __asm__ block below */
#else
const unsigned _gte_patch_text[13] = {
    0xaf410004, 0xaf420008, 0xaf43000c, 0xaf5f007c, 0x40037000, 0x00000000,   /* [0..5] buggy pattern */
    0xaf410004, 0xaf420008, 0x40026800, 0xaf43000c, 0x40037000, 0xaf5f007c,   /* [6..11] fixed (mfc0 $2,$13) */
    0x00000000
};
#endif

#if defined(__mips__)
/* @0x8014898C : scratch word holding $ra across the helper calls (handwritten spill). */
int _patch_gte_ra_save;

/* @0x80106454 : _patch_gte -- handwritten.  Double `.set noreorder` (tab form disables
 * maspsx's auto delay-slot nop insertion so the hand-filled bne/jal delay slots survive;
 * space form passes through to GNU as) -- the proven libcard CARD.S idiom.
 * w26-a3: leading `.section .text` forces the assembler back into `.text` regardless of
 * whatever section (here CC1PSX's `.rdata`, for the const table above) was active when this
 * raw-asm passthrough block begins -- see the file header note. */
__asm__(
    "\t.section .text\n"     /* w26-a3: force .text (CC1PSX leaves us in .rdata here) */
    "\t.set noat\n"
    "\t.set\tnoreorder\n"   /* tab form: turns maspsx's is_reorder OFF (no auto bne/jal delay nop) */
    "\t.set noreorder\n"    /* space form: passes THROUGH maspsx to gnu-as (keeps as from reordering) */
    "\t.globl _patch_gte\n"
    "_patch_gte:\n"
    "\tlui   $at, %hi(_patch_gte_ra_save)\n"
    "\tsw    $ra, %lo(_patch_gte_ra_save)($at)\n"
    "\tjal   EnterCriticalSection\n"
    "\t nop\n"                              /* jal delay slot (oracle: nop, not the addiu) */
    "\taddiu $t1, $zero, 86\n"              /* 0x56 BIOS func index */
    "\taddiu $t2, $zero, 176\n"             /* 0xB0 BIOS B0 table base */
    "\tjalr  $t2\n"                         /* -> exception-handler table ptr in $v0 */
    "\t nop\n"                              /* jalr delay slot (maspsx does not auto-fill jalr) */
    "\tlw    $v0, 24($v0)\n"                /* +0x18 table[6] -> handler */
    "\tnop\n"
    "\taddiu $v0, $v0, 40\n"                /* +0x28 handler -> GTE save sequence */
    "\taddu  $t7, $v0, $zero\n"             /* keep the destination pointer */
    "\tlui   $t2, %hi(_gte_patch_text)\n"   /* &match[0] */
    "\taddiu $t2, $t2, %lo(_gte_patch_text)\n"
    "\tlui   $t1, %hi(_gte_patch_text+24)\n"   /* &match-end (=&word[6]) */
    "\taddiu $t1, $t1, %lo(_gte_patch_text+24)\n"
    "1:\n"                                  /* compare loop: while bytes match */
    "\tlw    $v1, 0($t2)\n"
    "\tlw    $t3, 0($v0)\n"
    "\taddiu $t2, $t2, 4\n"
    "\tbne   $v1, $t3, 3f\n"                /* mismatch -> skip the overwrite */
    "\t addiu $v0, $v0, 4\n"
    "\tbne   $t2, $t1, 1b\n"
    "\t nop\n"
    "\taddu  $v0, $t7, $zero\n"             /* matched: reset dest to handler+0x28 */
    "\tlui   $t2, %hi(_gte_patch_text+24)\n"   /* &fix[0] (=&word[6]) */
    "\taddiu $t2, $t2, %lo(_gte_patch_text+24)\n"
    "\tlui   $t1, %hi(_gte_patch_text+48)\n"   /* &fix-end (=&word[12]) */
    "\taddiu $t1, $t1, %lo(_gte_patch_text+48)\n"
    "2:\n"                                  /* copy loop: overwrite handler with fix */
    "\tlw    $v1, 0($t2)\n"
    "\tnop\n"
    "\tsw    $v1, 0($v0)\n"
    "\taddiu $t2, $t2, 4\n"
    "\tbne   $t2, $t1, 2b\n"
    "\t addiu $v0, $v0, 4\n"
    "3:\n"
    "\tjal   FlushCache\n"
    "\t nop\n"                              /* jal delay slot (nop) */
    "\tjal   ExitCriticalSection\n"
    "\t nop\n"                              /* jal delay slot (nop) */
    "\tlui   $ra, %hi(_patch_gte_ra_save)\n"
    "\tlw    $ra, %lo(_patch_gte_ra_save)($ra)\n"
    "\tnop\n"
    "\tjr    $ra\n"
    "\t nop\n"
    /* --- @0x80106500 : the patch TEMPLATE table, emitted in .text immediately after
     * _patch_gte (its real VA).  The oracle's symbol for it is `_patch_gte_handler_1`
     * (0x30 bytes = words [0..11]); it is a §3.9b class-2 code-as-data PATCH TEMPLATE, not
     * a function.  Emitting it as a C `const` array put the bytes in .rodata under a name
     * the gate could not resolve -> `NOT IN OBJECT`.  `_gte_patch_text` is the same address
     * under the recon's own name, via a GNU-as symbol assignment (gcc-2.8 SILENTLY IGNORES
     * __attribute__((alias)) -- catalog §G).  D_80106518 / D_80106530 are splat's interior
     * labels for &word[6] (the fix half) and &word[12]. --- */
    "\t.globl _patch_gte_handler_1\n"
    "_patch_gte_handler_1:\n"
    "\t.globl _gte_patch_text\n"
    "_gte_patch_text = _patch_gte_handler_1\n"
    "\t.word 0xaf410004\n\t.word 0xaf420008\n\t.word 0xaf43000c\n"
    "\t.word 0xaf5f007c\n\t.word 0x40037000\n\t.word 0x00000000\n"
    /* w50 CI fix: objdiff 3.8.0 requires every left-side (expected) GLOBAL to pair --
     * the expected object exports splat's alabels D_80106518 (&word[6], the fix half)
     * and D_80106530 (&word[12]) as globals, so the recon must define them too.  The
     * old "no interior label" receipt (objdump block-split fear) re-tested with the
     * labels present: verify_asm still gates both fns PASS.  The recon still reaches
     * the fix half as `_gte_patch_text+24`. */
    "\t.globl D_80106518\n"
    "D_80106518:\n"
    "\t.word 0xaf410004\n\t.word 0xaf420008\n\t.word 0x40026800\n"
    "\t.word 0xaf43000c\n\t.word 0x40037000\n\t.word 0xaf5f007c\n"
    "\t.globl D_80106530\n"
    "D_80106530:\n"
    "\t.word 0x00000000\n"
    "\t.set	pop\n");
#else
/* @0x80106454 : _patch_gte -- host no-op (no BIOS, no GTE, no self-modifying code). */
extern void _patch_gte(void)
{
    EnterCriticalSection();
    (void)_gte_patch_text;
    FlushCache();
    ExitCriticalSection();
}
#endif
