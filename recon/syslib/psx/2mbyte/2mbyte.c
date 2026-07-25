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

/* @0x800E402C (stup2 / __SN_ENTRY_POINT): zero the BSS region [_bss_obj, __last_org). */
#if defined(__mips__)
__asm__(
    ".text\n\t.set push\n\t.set noat\n\t.set noreorder\n\t.set\tnoreorder\n"
    ".globl __SN_ENTRY_POINT\n__SN_ENTRY_POINT:\n.globl stup2\nstup2:\n"
    "\tlui        $v0, %hi(_bss_obj)\n"
    "\taddiu      $v0, $v0, %lo(_bss_obj)\n"
    "\tlui        $v1, %hi(__last_org)\n"
    "\taddiu      $v1, $v1, %lo(__last_org)\n"
    ".L800E403C:\n"
    "\tsw         $zero, 0($v0)\n"
    "\taddiu      $v0, $v0, 4\n"
    "\tsltu       $at,$v0,$v1\n"
    "\tbnez       $at, .L800E403C\n"
    "\tnop\n"
    ".set pop\n"
);
#else
extern void stup2(void) { }
extern void __SN_ENTRY_POINT(void) { }
#endif

/* @0x800E4050 (stup1): install $sp (top of 2 MiB) / $gp / $fp, then InitHeap(base, size).
 * Falls through from stup2 above -- must stay textually adjacent (no intervening code/data). */
#if defined(__mips__)
__asm__(
    ".text\n\t.set push\n\t.set noat\n\t.set noreorder\n\t.set\tnoreorder\n"
    ".globl stup1\nstup1:\n"
    "\taddiu      $v0, $zero, 4\n"
    "\tnop\n"
    "\tnop\n"
    "\tnop\n"
    "\tnop\n"
    "\tlui        $a0, %hi(D_800E40D8)\n"
    "\taddiu      $a0, $a0, %lo(D_800E40D8)\n"
    "\taddu       $a0, $a0, $v0\n"
    "\tlw         $v0, 0($a0)\n"
    "\tlui        $t0, %hi(D_80000004)\n"
    "\tor         $sp, $v0, $t0\n"
    "\tlui        $a0, %hi(__last_org)\n"
    "\taddiu      $a0, $a0, %lo(__last_org)\n"
    "\tsll        $a0, $a0, 3\n"
    "\tsrl        $a0, $a0, 3\n"
    "\tlui        $v1, %hi(_stacksize)\n"
    "\tlw         $v1, %lo(_stacksize)($v1)\n"
    "\tnop\n"
    "\tsubu       $a1, $v0, $v1\n"
    "\tsubu       $a1, $a1, $a0\n"
    "\tor         $a0, $a0, $t0\n"
    "\tlui        $at, %hi(D_8013DE5C)\n"
    "\tsw         $ra, %lo(D_8013DE5C)($at)\n"
    "\tlui        $gp, %hi(_gp)\n"
    "\taddiu      $gp, $gp, %lo(_gp)\n"
    "\taddu       $fp, $sp, $zero\n"
    "\tjal        InitHeap\n"
    "\taddi      $a0, $a0, %lo(D_80000004)\n"
    "\tlui        $ra, %hi(D_8013DE5C)\n"
    "\tlw         $ra, %lo(D_8013DE5C)($ra)\n"
    "\tnop\n"
    ".set pop\n"
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
    ".text\n\t.set push\n\t.set noat\n\t.set noreorder\n\t.set\tnoreorder\n"
    ".globl stup0\nstup0:\n"
    "\tjal        main\n"
    "\tnop\n"
    "\tbreak      1\n"
    "D_800E40D8:\n"
    "\t.word      2097152\n"
    "\t.word      2097152\n"
    "\t.word      2097152\n"
    "\t.word      2097152\n"
    ".set pop\n"
);
#else
extern void stup0(void) { for (;;) { } }
#endif
