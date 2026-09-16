/* syslib/psx/2mbyte/2mbyte.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\syslib\psx\2mbyte.obj   (xlsx provenance)
 *               == libsn.lib(SNMAIN.OBJ)       (disasm-v3 "// obj:")
 *   This is the PSX program ENTRY POINT -- SN Systems crt0, "2 MB" RAM variant
 *   (retail PSX: stack top = 0x80200000 = top of 2 MiB).
 *
 *   4 symbols (a single fall-through routine + the GCC ctor hook):
 *     __main @0x800E4024 -- GCC global-constructor hook; empty in the SN runtime (SNMAIN.c).
 *     __SN_ENTRY_POINT / stup2 @0x800E402C -- entry: clear BSS  (co-equal names, trusted SYM
 *         v3 dump confirms BOTH at the same VA; IDA calls it `start`, __noreturn)
 *     stup1  @0x800E4050 -- set $sp/$gp/$fp, compute + InitHeap()    (falls through from stup2)
 *     stup0  @0x800E40CC -- call main(); never returns (`break 0,1`) (falls through from stup1)
 *   stup2/stup1/stup0 are a fall-through chain (no `jr` between them, confirmed by the trusted
 *   SYM v3 dump AND the real oracle .s files -- `asm/nonmatchings/main/__SN_ENTRY_POINT.s`,
 *   `stup1.s`, `stup0.s`).
 *
 *   GENUINE HAND-WRITTEN SN Systems crt0 asm (not compiler output): sets $sp/$gp/$fp directly,
 *   saves $ra to a fixed low-RAM scratch cell (D_8013DE5C) since the stack isn't set up yet to
 *   spill it normally, and stup0 embeds its own inline .word data table right after its 3
 *   instructions (the same "code-as-data island" shape as libsn's other genuine originals).
 *   Reconstructed as file-scope __asm__ (BIOS_THUNK / task #31 libsn precedent), byte-identical
 *   to all 3 oracle .s files -- a C model of $sp/$gp reassignment mid-function is not expressible
 *   portably anyway. `syslib.h` already forward-declares `stup2()/stup1()/stup0()` as 3 separate
 *   functions (not 1 combined `start()`), matching this shape.
 */

/* ---- cross-TU call targets (jal targets decoded from EXE bytes; disasm-v3 mislabelled
 *      both by +0x10000 in the boot region -- real targets verified against NFS4.EXE) ---- */
extern int  main(void);                                /* @0x800A4730  GAME\COMMON\NFS3.CPP   */
extern void InitHeap(void *head, unsigned long size);  /* @0x800FDD18  libapi (syslib C57.obj) */

/* ---- crt0 data (real linker symbols; only referenced from the asm text below) ---- */
extern unsigned int _stacksize;   /* linker sym: bytes reserved for the stack */
extern int _bss_obj;              /* linker sym: BSS region start (SN "OBJEND"-style anchor) */
extern int __last_org;            /* linker sym: end of the linked image / BSS end */
extern int _gp;                   /* linker sym: small-data anchor (0x8013C54C, nfs4.ld)     */

/* @0x800E4024 (__main): GCC's global-constructor hook -- EMPTY in the SN runtime (`jr ra; nop`).
 * w48-a7: was MISSING from this TU entirely (gate said NOT IN OBJECT, worklist read it as 0.00%).
 * Emitted as file-scope asm, FIRST, so it lands physically before __SN_ENTRY_POINT like retail --
 * and because this TU's asm blocks leave maspsx in `.set noreorder` state for the whole file, a
 * C-level `void __main(void){}` here would lose its delay-slot nop (w45 file-scope-asm pitfall). */
#if defined(__mips__)
__asm__(
    ".text\n\t.set noat\n\t.set noreorder\n\t.set\tnoreorder\n"
    ".globl __main\n__main:\n"
    "\tjr         $31\n"
    "\tnop\n"
    ".set reorder\n.set at\n"
);
#else
extern void __main(void) { }
#endif

/* @0x800E402C (stup2 / __SN_ENTRY_POINT): zero the BSS region [_bss_obj, __last_org). */
#if defined(__mips__)
__asm__(
    ".text\n\t.set noat\n\t.set noreorder\n\t.set\tnoreorder\n"
    ".globl __SN_ENTRY_POINT\n__SN_ENTRY_POINT:\n.globl stup2\nstup2:\n"
    "\tlui        $2, %hi(_bss_obj)\n"
    "\taddiu      $2, $2, %lo(_bss_obj)\n"
    "\tlui        $3, %hi(__last_org)\n"
    "\taddiu      $3, $3, %lo(__last_org)\n"
    ".L800E403C:\n"
    "\tsw         $0, 0($2)\n"
    "\taddiu      $2, $2, 4\n"
    "\tsltu       $1,$2,$3\n"
    "\tbnez       $1, .L800E403C\n"
    "\tnop\n"
    ".set reorder\n.set at\n"
);
#else
extern void stup2(void) { }
extern void __SN_ENTRY_POINT(void) { }
#endif

/* @0x800E4050 (stup1): install $sp (top of 2 MiB) / $gp / $fp, then InitHeap(base, size).
 * Falls through from stup2 above -- must stay textually adjacent (no intervening code/data). */
#if defined(__mips__)
__asm__(
    ".text\n\t.set noat\n\t.set noreorder\n\t.set\tnoreorder\n"
    ".globl stup1\nstup1:\n"
    "\taddiu      $2, $0, 4\n"
    "\tnop\n"
    "\tnop\n"
    "\tnop\n"
    "\tnop\n"
    "\tlui        $4, %hi(D_800E40D8)\n"
    "\taddiu      $4, $4, %lo(D_800E40D8)\n"
    "\taddu       $4, $4, $2\n"
    "\tlw         $2, 0($4)\n"
    "\tlui        $8, %hi(D_80000004)\n"
    "\tor         $29, $2, $8\n"
    "\tlui        $4, %hi(__last_org)\n"
    "\taddiu      $4, $4, %lo(__last_org)\n"
    "\tsll        $4, $4, 3\n"
    "\tsrl        $4, $4, 3\n"
    "\tlui        $3, %hi(_stacksize)\n"
    "\tlw         $3, %lo(_stacksize)($3)\n"
    "\tnop\n"
    "\tsubu       $5, $2, $3\n"
    "\tsubu       $5, $5, $4\n"
    "\tor         $4, $4, $8\n"
    "\tlui        $1, %hi(D_8013DE5C)\n"
    "\tsw         $31, %lo(D_8013DE5C)($1)\n"
    "\tlui        $28, %hi(_gp)\n"
    "\taddiu      $28, $28, %lo(_gp)\n"
    "\taddu       $30, $29, $0\n"
    "\tjal        InitHeap\n"
    "\taddi      $4, $4, %lo(D_80000004)\n"
    "\tlui        $31, %hi(D_8013DE5C)\n"
    "\tlw         $31, %lo(D_8013DE5C)($31)\n"
    /* w48-a7: stup1's SYM span is 0x78 = 30 insns and ENDS at the `lw $ra` -- the load-delay
     * nop @0x800E40C8 is a PAD word between stup1 and stup0, not part of stup1.  Label it so the
     * byte stays in the image (retail layout preserved) while the symbol block is 30 insns.     */
    "D_800E40C8:\n"
    "\tnop\n"
    ".set reorder\n.set at\n"
);
#else
extern void stup1(void) { }
#endif

/* @0x800E40CC (stup0): enter the game, then halt (should never return). Falls through from
 * stup1 above. The `_stacktab` table @D_800E40D8 (stup1 reads slot [1], the 2 MiB stack top)
 * is inline data immediately after this function's 3 real instructions -- kept in the SAME
 * asm block so it lands at the exact oracle byte offset (0x800E40D8). */
#if defined(__mips__)
__asm__(
    ".text\n\t.set noat\n\t.set noreorder\n\t.set\tnoreorder\n"
    ".globl stup0\nstup0:\n"
    "\tjal        main\n"
    "\tnop\n"
    "\tbreak      1\n"
    /* w64-a21 BOARD FIX (symbol-SIZE only; zero code bytes change).  The interior
     * `D_800E40D8` label is the next symbol after `stup0`, so tools/fix_symsizes.py
     * sized stup0 at 0x0C -- but retail's symbol is 0x1C (the oracle's own
     * `nonmatching stup0, 0x1C`, and the 4 inline `.word`s ARE inside it).  objdiff
     * reads every function row's extent from st_size, so the board scored stup0
     * 3/7 = 42.86% while verify_asm (which slices by the ORACLE's span and walks
     * through interior labels) reported PASS 7/7.  An explicit .size wins over
     * fix_symsizes (it only fills size==0 symbols).  Same idiom as
     * recon/syslib/psx/libcard/PATCH.c's func_8010CA40. */
    "\t.type      stup0, @function\n"
    "\t.size      stup0, 0x1c\n"
    /* ...and give the inline table the SAME symbol shape splat's `alabel` gives the
     * expected object (global, STT_FUNC, 0x10) so objdiff keeps scoring it as its own
     * row: with stup0 now covering these bytes, a size-0 local would have been read as
     * an empty symbol (100.00 -> 0.00).  Only this TU defines/uses the name (stup1's
     * %hi/%lo pair above), so the global binding cannot collide at link. */
    "\t.globl     D_800E40D8\n"
    "D_800E40D8:\n"
    "\t.type      D_800E40D8, @function\n"
    "\t.size      D_800E40D8, 0x10\n"
    "\t.word      2097152\n"
    "\t.word      2097152\n"
    "\t.word      2097152\n"
    "\t.word      2097152\n"
    ".set reorder\n.set at\n"
);
#else
extern void stup0(void) { for (;;) { } }
#endif
