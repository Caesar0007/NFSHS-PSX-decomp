/* syslib/psx/libcard/PATCH.c -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj libcard.lib(PATCH.OBJ): the boot-time memory-card kernel patches -- part of the hand-
 *   assembled CARD.S unit (no C preimage).  PsyQ installs custom card interrupt handlers by copying
 *   small MIPS code blobs (held as code-as-data INSIDE this same object, addressed by symbol) over
 *   BIOS jump-table entries and into the kernel scratch area.  Every function saves $ra into a fixed
 *   scratch word, INLINES the BIOS B0 table fetch (addiu $t1,idx; addiu $t2,0xB0; jalr $t2), copies a
 *   blob word-by-word, FlushCache()s, restores $ra and returns.  Reproduced verbatim as file-scope
 *   __asm__ (genuine hand-assembly; RULE 7 BIOS-stub form), numeric regs only (aspsx).
 *
 *     _copy_memcard_patch : copy 28 words [InitCARD2+0x10 .. func_8010CA40) into kernel RAM @0xDF80.
 *     _patch_card         : overlay func_8010CA40[0..5) onto the BIOS B0[0x56] table-6 handler @+0x28.
 *     _patch_card2        : overlay func_8010CA40[5..10) onto the BIOS B0[0x57] table-91 handler @+0x9C8.
 *
 *   The copied source blobs live at `InitCARD2+0x10` (A74.OBJ tail) and `func_8010CA40` (a tiny raw-
 *   code island between InitCARD2 and _patch_card, kept as its own INCLUDE_ASM in the run-tree); the
 *   scratch-ra words D_80148AC4/D_80148AD4 and the patch destinations resolve as %hi/%lo relocations
 *   (the verifier is reloc-lenient; the run-tree links them to their real addresses).  */

#if defined(__mips__)

/* @0x8010CA40 : func_8010CA40 -- the TWO 5-word patch TEMPLATES themselves (code-as-data class 2,
 * methodology 3.9b: never `jal`'d, only address-taken by _patch_card / _patch_card2 below, which
 * copy them over BIOS B0[0x56] / B0[0x57] table entries).  splat gave the island its own `func_`
 * label; the recon referenced it by %hi/%lo but never DEFINED it, so objdiff reported the symbol
 * 0% and verify_asm `NOT IN OBJECT` (W52-A9).  Emitted verbatim here, its owning object.
 *
 * The two kernel targets are hardcoded KSEG1 constants (0xA000DFAC / 0xA000DF80 = the relocated
 * card handlers _copy_memcard_patch installs at 0xDF80), NOT relocatable symbols -- they are
 * written as literal lui/addiu pairs so the BYTES are retail-exact.  ⚠ verify_asm reports 8
 * residual lines on this function purely as a NORMALIZER artifact: spimdisasm names the literals
 * `D_A000DFAC` / `D_A000DF80` and verify_asm's literal-dlabel rule resolves `%hi()` as a bare
 * `addr>>16` (0xA000) and `%lo()` as an UNSIGNED `addr&0xFFFF` (0xDFAC), while the real assembler
 * emits the %hi CARRY (0xA001, because %lo's bit 15 is set) and objdump renders the %lo SIGNED
 * (-8276).  Retail word 0x3C02A001 == ours; see the W52-A9 patch proposal for the fix. */
__asm__(
    "\t.set noat\n"
    "\t.set\tnoreorder\n"
    "\t.set noreorder\n"
    "\t.globl func_8010CA40\n"
    "func_8010CA40:\n"
    "\tlui   $v0, 0xA001\n"                         /* @0x8010CA40  patch1: %hi(0xA000DFAC) */
    "\taddiu $v0, $v0, -8276\n"                     /* @0x8010CA44  %lo = 0xDFAC             */
    "\tjr    $v0\n"                                 /* @0x8010CA48                           */
    "\t nop\n"                                      /* @0x8010CA4C  [delay]                  */
    "\tnop\n"                                       /* @0x8010CA50  (5th word of template 1) */
    "\tlui   $t0, 0xA001\n"                         /* @0x8010CA54  patch2: %hi(0xA000DF80) */
    "\taddiu $t0, $t0, -8320\n"                     /* @0x8010CA58  %lo = 0xDF80             */
    "\tjalr  $t0\n"                                 /* @0x8010CA5C                           */
    "\t nop\n"                                      /* @0x8010CA60  [delay]                  */
    /* W60-A1 (2026-08-14) INTRA-TU LAYOUT FIX -- the 10th word.  splat's `endlabel
     * func_8010CA40, 0x24` stops at 0x8010CA64, but the retail obj carries ONE MORE word
     * there (the oracle .s prints it right after endlabel) and `_patch_card` starts at
     * 0x8010CA68, i.e. blob+0x28.  That word is LOAD-BEARING: `_patch_card2` copies
     * [func_8010CA40+0x14, _patch_card) as template 2, so without it the copy loop moves
     * FOUR words instead of five and the B0[0x57] handler is patched with a truncated
     * template (a runtime defect, invisible to every per-function gate).  Emitted OUTSIDE
     * the symbol via an explicit .size/.type so verify_asm still sees exactly the oracle's
     * 9 instructions. */
    "\t.type  func_8010CA40, @function\n"
    "\t.size  func_8010CA40, 0x24\n"
    "pad_8010CA64:\n"                               /* LOCAL label: ends the symbol's objdump
                                                     * block so verify_asm still slices exactly
                                                     * the oracle's 9 instructions */
    "\tnop\n"                                       /* @0x8010CA64  template-2 5th word / pad */
    "\t.set at\n");

/* @0x8010CA68 : _patch_card -- overlay the jump-into-patch onto the BIOS B0[0x56] table-6 handler. */
__asm__(
    "\t.set noat\n"
    "\t.set\tnoreorder\n"   /* tab form: turns maspsx's is_reorder OFF (no auto bne/jal delay nop) */
    "\t.set noreorder\n"    /* space form: passes THROUGH maspsx to gnu-as (keeps as from reordering) */
    "\t.globl _patch_card\n"
    "_patch_card:\n"
    "\tlui   $at, %hi(D_80148AC4)\n"                /* save ra -> scratch word              */
    "\tsw    $ra, %lo(D_80148AC4)($at)\n"
    "\tjal   EnterCriticalSection\n"
    "\t nop\n"                                       /* delay slot: nop (before args set)    */
    "\taddiu $t1, $zero, 0x56\n"                    /* BIOS call index 0x56                 */
    "\taddiu $t2, $zero, 0xB0\n"                    /* BIOS table base B0                   */
    "\tjalr  $t2\n"
    "\t nop\n"
    "\tlw    $v0, 24($v0)\n"                        /* evt = *(v0+0x18)                     */
    "\tnop\n"
    "\tlw    $v1, 112($v0)\n"                       /* lo = *(evt+0x70)                     */
    "\tnop\n"
    "\tandi  $t1, $v1, 0xFFFF\n"
    "\tsll   $t1, $t1, 16\n"
    "\tlw    $v1, 116($v0)\n"                       /* hi = *(evt+0x74)                     */
    "\tnop\n"
    "\tandi  $t2, $v1, 0xFFFF\n"
    "\taddu  $v1, $t1, $t2\n"                       /* dst base = (lo<<16)+hi               */
    "\taddiu $v0, $v1, 0x28\n"                      /* dst = base + 0x28                    */
    "\tlui   $t2, %hi(func_8010CA40)\n"             /* src = patch1 blob (5 words)          */
    "\taddiu $t2, $t2, %lo(func_8010CA40)\n"
    "\tlui   $t1, %hi(func_8010CA40 + 0x14)\n"      /* end = blob + 0x14                    */
    "\taddiu $t1, $t1, %lo(func_8010CA40 + 0x14)\n"
    ".L_patch_card_loop:\n"
    "\tlw    $v1, 0($t2)\n"
    "\tnop\n"
    "\tsw    $v1, 0($v0)\n"
    "\taddiu $t2, $t2, 4\n"
    "\tbne   $t2, $t1, .L_patch_card_loop\n"
    "\t addiu $v0, $v0, 4\n"
    "\tlui   $at, 0x1\n"                            /* (0x10000>>16) -> kernel flag word    */
    "\tjal   FlushCache\n"
    "\t sw   $v0, -8196($at)\n"                     /* [branch delay] store in jal slot (-0x2004) */
    "\tlui   $ra, %hi(D_80148AC4)\n"                /* restore ra                           */
    "\tlw    $ra, %lo(D_80148AC4)($ra)\n"
    "\tnop\n"
    "\tjr    $ra\n"
    "\t nop\n"
    "\t.set	pop\n");

/* @0x8010CAFC : _patch_card2 -- overlay the call-to-patch onto the BIOS B0[0x57] table-91 handler. */
__asm__(
    "\t.set noat\n"
    "\t.set\tnoreorder\n"   /* tab form: turns maspsx's is_reorder OFF (no auto bne/jal delay nop) */
    "\t.set noreorder\n"    /* space form: passes THROUGH maspsx to gnu-as (keeps as from reordering) */
    "\t.globl _patch_card2\n"
    "_patch_card2:\n"
    "\tlui   $at, %hi(D_80148AC4)\n"                /* save ra -> scratch word              */
    "\tsw    $ra, %lo(D_80148AC4)($at)\n"
    "\tjal   EnterCriticalSection\n"
    "\t nop\n"                                       /* delay slot: nop (before args set)    */
    "\taddiu $t1, $zero, 0x57\n"                    /* BIOS call index 0x57                 */
    "\taddiu $t2, $zero, 0xB0\n"                    /* BIOS table base B0                   */
    "\tjalr  $t2\n"
    "\t nop\n"
    "\tlw    $v0, 364($v0)\n"                       /* evt = *(v0+0x16C)                    */
    "\tnop\n"
    "\tlw    $v1, 2504($v0)\n"                      /* (load -- value discarded)            */
    "\tlui   $t2, %hi(func_8010CA40 + 0x14)\n"      /* src = patch2 blob (5 words)          */
    "\taddiu $t2, $t2, %lo(func_8010CA40 + 0x14)\n"
    "\tlui   $t1, %hi(_patch_card)\n"               /* end = _patch_card (blob+0x28)        */
    "\taddiu $t1, $t1, %lo(_patch_card)\n"
    ".L_patch_card2_loop:\n"
    "\tlw    $t0, 0($t2)\n"
    "\tnop\n"
    "\tsw    $t0, 2504($v0)\n"                      /* *(evt+0x9C8) = blob word             */
    "\taddiu $t2, $t2, 4\n"
    "\tbne   $t2, $t1, .L_patch_card2_loop\n"
    "\t addiu $v0, $v0, 4\n"
    "\tjal   FlushCache\n"
    "\t nop\n"                                       /* delay slot: nop                      */
    "\tlui   $ra, %hi(D_80148AC4)\n"                /* restore ra                           */
    "\tlw    $ra, %lo(D_80148AC4)($ra)\n"
    "\tnop\n"
    "\tjr    $ra\n"
    "\t nop\n"
    "\t.set	pop\n");

/* @0x8010CB6C : _copy_memcard_patch -- copy the 28-word card-IRQ handler blob into kernel RAM. */
__asm__(
    "\t.set noat\n"
    "\t.set\tnoreorder\n"   /* tab form: turns maspsx's is_reorder OFF (no auto bne/jal delay nop) */
    "\t.set noreorder\n"    /* space form: passes THROUGH maspsx to gnu-as (keeps as from reordering) */
    "\t.globl _copy_memcard_patch\n"
    "_copy_memcard_patch:\n"
    "\tori   $v0, $zero, 0xDF80\n"                  /* dst = 0xDF80 (kernel scratch)        */
    "\tlui   $t2, %hi(InitCARD2 + 0x10)\n"          /* src = InitCARD2 tail (28 words)      */
    "\taddiu $t2, $t2, %lo(InitCARD2 + 0x10)\n"
    "\tlui   $t1, %hi(func_8010CA40)\n"             /* end = func_8010CA40                  */
    "\taddiu $t1, $t1, %lo(func_8010CA40)\n"
    ".L_copy_memcard_patch_loop:\n"
    "\tlw    $v1, 0($t2)\n"
    "\tnop\n"                                        /* [load delay]                         */
    "\tsw    $v1, 0($v0)\n"
    "\taddiu $t2, $t2, 4\n"
    "\tbne   $t2, $t1, .L_copy_memcard_patch_loop\n"
    "\t addiu $v0, $v0, 4\n"                         /* [branch delay]                       */
    "\tjr    $ra\n"
    "\t nop\n"
    "\t.set	pop\n");

#endif
