/* syslib/psx/libpress/VLC.cpp -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj libpress.lib(VLC.OBJ): the MDEC variable-length-code (Huffman/RLE) bit-stream decoder.
 *   DecDCTvlc unpacks a compressed coefficient stream into MDEC run/level format; it is a
 *   table-driven, resumable decoder -- pass a non-null `bs` to start a frame, or null to
 *   continue from the saved state, returning 1 when more output is pending and 0 at end.
 *
 *   BOTH functions in this obj are GENUINE HAND-WRITTEN PsyQ SDK ASSEMBLY, not compiler output --
 *   proven by (a) the oracle .s marks the majority of arithmetic ops "handwritten instruction",
 *   (b) it uses the trapping `add`/`addi`/`sub` opcodes gcc NEVER emits (see reference_mips_isa_asm.md
 *   "ADD/SUB ARE NEVER EMITTED BY C COMPILERS"), and (c) fixed hand-scheduled t0/t1/t2/.../t9 scratch
 *   registers reused across basic blocks in ways no C-level register allocator produces. Reconstructing
 *   this as C control flow (tried first) could not get within 400 diffs of the oracle -- the established
 *   "genuine handwritten originals stay file-scope asm" precedent (task #31, libsn BIOS-thunk family)
 *   applies here too: reproduced VERBATIM as file-scope __asm__, byte-identical to the oracle.
 *
 *   The lookup tables are large const rodata (the AC primary table alone is 64 KB); they live in
 *   the binary at the addresses below and are pulled in by the data-materialization pass:
 *     CF_DVLC   (= _vlc_ac)    @0x80124038 : AC primary table, 8192 entries x 8 bytes {u_int code; u_int extra}
 *                                            (escape table _vlc_acesc @0x80123C38 = CF_DVLC - 0x400)
 *     CF2_DVLC  (= _vlc_dc)    @0x80134038 : DC magnitude tables (luma + chroma), 256 entries x 4 bytes each
 *   CF_DVLC is the SAME memory-pool-overlay buffer used elsewhere (frontend video/psxfront) -- this
 *   obj is another transient user of that scratch space during MDEC decode. */

typedef unsigned long  u_long;
typedef unsigned int   u_int;
typedef unsigned short u_short;

/* ---- resumable decoder state (saved/restored when DecDCTvlc is called with bs == 0) ----
 * _vlc_state is the 9-word block the oracle addresses via ONE base register + fixed byte offsets
 * (rd,wr,acc,bit,q,blk,dc0,dc1,dc2 -- 0x0/0x4/0x8/0xC/0x10/0x14/0x18/0x1C/0x20); _vlc_blksize and
 * _vlc_end are separate, independently-addressed globals (confirmed: each gets its own lui/addiu
 * pair in the oracle, never computed as an offset from _vlc_state). */
static int      _vlc_blksize __attribute__((section(".data"))) = 0xffffff;  /* @0x801369E8 : output cells per slice; oracle refs ALL absolute lui/%hi (0 gp_rel) -> out of .sdata */
static u_int    _vlc_state[9] __attribute__((section(".bss")));  /* @0x801369EC..80136A0C */
static u_short *_vlc_end       __attribute__((section(".bss")));  /* @0x80136A10 : output slice end */

/* @0x800F7400 : set the per-slice output size (in cells); returns the previous value. */
extern int DecDCTvlcSize(int size);
#if defined(__mips__)
__asm__(
    ".text\n\t.set push\n\t.set noat\n\t.set noreorder\n\t.set\tnoreorder\n"
    ".globl DecDCTvlcSize\nDecDCTvlcSize:\n"
    "\tlui        $t0, %hi(_vlc_blksize)\n"
    "\taddiu      $t0, $t0, %lo(_vlc_blksize)\n"
    "\taddi       $at, $a0, -1\n"
    "\tblez       $at, .L800F7420\n"
    "\tlw        $v0, 0($t0)\n"
    "\tsll        $at, $a0, 1\n"
    "\tjr         $ra\n"
    "\tsw        $at, 0($t0)\n"
    ".L800F7420:\n"
    "\tlui        $at, (16777215 >> 16)\n"
    "\tori        $at, $at, (16777215 & 65535)\n"
    "\tjr         $ra\n"
    "\tsw        $at, 0($t0)\n"
    ".set pop\n"
);
#else
extern int DecDCTvlcSize(int size)
{
    int prev = _vlc_blksize;
    if (size - 1 > 0) _vlc_blksize = size << 1;
    else              _vlc_blksize = 0xffffff;
    return prev;
}
#endif

/* @0x800F7430 : decode one slice of the MDEC bit-stream into run/level cells. */
extern int DecDCTvlc(u_int *bs, u_int *buf);
#if defined(__mips__)
__asm__(
    ".text\n\t.set push\n\t.set noat\n\t.set noreorder\n\t.set\tnoreorder\n"
    ".globl DecDCTvlc\nDecDCTvlc:\n"
    "\tlui        $t0, %hi(_vlc_blksize)\n"
    "\taddiu      $t0, $t0, %lo(_vlc_blksize)\n"
    "\tlui        $a2, %hi(CF_DVLC)\n"
    "\taddiu      $a2, $a2, %lo(CF_DVLC)\n"
    "\tlui        $a3, %hi(CF2_DVLC)\n"
    "\taddiu      $a3, $a3, %lo(CF2_DVLC)\n"
    "\tbnez       $a0, .L800F7488\n"
    "\tlw        $t1, 0($t0)\n"
    "\tlui        $t0, %hi(_vlc_state)\n"
    "\taddiu      $t0, $t0, %lo(_vlc_state)\n"
    "\tlw         $a0, 0($t0)\n"
    "\tlw         $a1, 4($t0)\n"
    "\tlw         $v0, 8($t0)\n"
    "\tlw         $v1, 12($t0)\n"
    "\tlw         $t4, 16($t0)\n"
    "\tlw         $t5, 20($t0)\n"
    "\tlw         $t7, 24($t0)\n"
    "\tlw         $t8, 28($t0)\n"
    "\tlw         $t9, 32($t0)\n"
    "\tadd        $t1, $t1, $t1\n"
    "\tb          .L800F7614\n"
    "\tadd       $t6, $a1, $t1\n"
    ".L800F7488:\n"
    "\tadd        $t5, $zero, $zero\n"
    "\tadd        $t7, $zero, $zero\n"
    "\tadd        $t8, $zero, $zero\n"
    "\tadd        $t9, $zero, $zero\n"
    "\tadd        $t1, $t1, $t1\n"
    "\tadd        $t6, $a1, $t1\n"
    "\tlw         $t1, 0($a0)\n"
    "\tlhu        $t4, 4($a0)\n"
    "\tlhu        $t2, 6($a0)\n"
    "\tlhu        $v0, 8($a0)\n"
    "\tlhu        $v1, 10($a0)\n"
    "\taddi       $t2, $t2, -3\n"
    "\tbltz       $t2, .L800F74C4\n"
    "\tsll       $t4, $t4, 10\n"
    "\taddi       $t5, $zero, 1\n"
    ".L800F74C4:\n"
    "\taddi       $a0, $a0, 12\n"
    "\tsll        $v0, $v0, 16\n"
    "\tor         $v0, $v0, $v1\n"
    "\tor         $v1, $zero, $zero\n"
    "\tsw         $t1, 0($a1)\n"
    "\tandi       $t1, $t1, 65535\n"
    "\tsll        $t1, $t1, 2\n"
    "\taddiu      $t1, $t1, 4\n"
    "\tadd        $t1, $t1, $a1\n"
    "\tlui        $t0, %hi(_vlc_end)\n"
    "\taddiu      $t0, $t0, %lo(_vlc_end)\n"
    "\tsw         $t1, 0($t0)\n"
    "\taddi       $a1, $a1, 2\n"
    ".L800F74F8:\n"
    "\tbeqz       $t5, .L800F75D0\n"
    "\tsrl       $t0, $v0, 22\n"
    "\txori       $at, $t0, 1023\n"
    "\tbeqz       $at, .L800F771C\n"
    "\taddi      $a1, $a1, 2\n"
    "\taddi       $at, $t5, -3\n"
    "\tbltz       $at, .L800F751C\n"
    "\taddi      $at, $a2, -1024\n"
    "\taddi       $at, $at, -1024\n"
    ".L800F751C:\n"
    "\tsrl        $t0, $v0, 24\n"
    "\tsll        $t0, $t0, 2\n"
    "\tadd        $t0, $t0, $at\n"
    "\tlhu        $t1, 0($t0)\n"
    "\tlhu        $t2, 2($t0)\n"
    "\tand        $t0, $zero, $zero\n"
    "\tbeqz       $t2, .L800F7560\n"
    "\tsllv      $v0, $v0, $t1\n"
    "\taddi       $at, $zero, 32\n"
    "\tsub        $at, $at, $t2\n"
    "\tsrlv       $t0, $v0, $at\n"
    "\tbltz       $v0, .L800F755C\n"
    "\tsllv      $v0, $v0, $t2\n"
    "\taddi       $t3, $zero, -1\n"
    "\tsrlv       $t3, $t3, $at\n"
    "\tsub        $t0, $t0, $t3\n"
    ".L800F755C:\n"
    "\tadd        $v1, $v1, $t2\n"
    ".L800F7560:\n"
    "\tadd        $v1, $v1, $t1\n"
    "\tandi       $at, $v1, 16\n"
    "\tbeqz       $at, .L800F7580\n"
    "\tandi      $v1, $v1, 15\n"
    "\tlhu        $t1, 0($a0)\n"
    "\taddi       $a0, $a0, 2\n"
    "\tsllv       $t1, $t1, $v1\n"
    "\tor         $v0, $v0, $t1\n"
    ".L800F7580:\n"
    "\taddi       $at, $t5, -2\n"
    "\tbgtz       $at, .L800F75A8\n"
    "\tadd       $t1, $t9, $t0\n"
    "\tbeqz       $at, .L800F75A0\n"
    "\tadd       $t1, $t8, $t0\n"
    "\tadd        $t1, $t7, $t0\n"
    "\tb          .L800F75AC\n"
    "\tadd       $t7, $t7, $t0\n"
    ".L800F75A0:\n"
    "\tb          .L800F75AC\n"
    "\tadd       $t8, $t8, $t0\n"
    ".L800F75A8:\n"
    "\tadd        $t9, $t9, $t0\n"
    ".L800F75AC:\n"
    "\tsll        $t1, $t1, 2\n"
    "\tandi       $t1, $t1, 1023\n"
    "\tor         $t1, $t4, $t1\n"
    "\taddi       $t5, $t5, 1\n"
    "\taddi       $at, $t5, -7\n"
    "\tbnez       $at, .L800F7608\n"
    "\tsh        $t1, 0($a1)\n"
    "\tb          .L800F7608\n"
    "\taddi      $t5, $t5, -6\n"
    ".L800F75D0:\n"
    "\txori       $at, $t0, 511\n"
    "\tbeqz       $at, .L800F771C\n"
    "\taddi      $a1, $a1, 2\n"
    "\tsll        $v0, $v0, 10\n"
    "\taddi       $v1, $v1, 10\n"
    "\tandi       $at, $v1, 16\n"
    "\tbeqz       $at, .L800F7600\n"
    "\tandi      $v1, $v1, 15\n"
    "\tlhu        $t1, 0($a0)\n"
    "\taddi       $a0, $a0, 2\n"
    "\tsllv       $t1, $t1, $v1\n"
    "\tor         $v0, $v0, $t1\n"
    ".L800F7600:\n"
    "\tor         $t0, $t4, $t0\n"
    "\tsh         $t0, 0($a1)\n"
    ".L800F7608:\n"
    "\tsubu       $at, $a1, $t6\n"
    "\tbgez       $at, .L800F774C\n"
    "\taddi      $a1, $a1, 2\n"
    ".L800F7614:\n"
    "\tsrl        $t0, $v0, 19\n"
    "\tsll        $t0, $t0, 3\n"
    "\tadd        $t0, $t0, $a2\n"
    "\tlw         $t1, 0($t0)\n"
    "\tnop\n"
    "\tbnez       $t1, .L800F7670\n"
    "\tandi      $at, $t1, 255\n"
    "\tsll        $v0, $v0, 8\n"
    "\taddi       $v1, $v1, 8\n"
    "\tandi       $at, $v1, 16\n"
    "\tbeqz       $at, .L800F7654\n"
    "\tandi      $v1, $v1, 15\n"
    "\tlhu        $t0, 0($a0)\n"
    "\taddi       $a0, $a0, 2\n"
    "\tsllv       $t0, $t0, $v1\n"
    "\tor         $v0, $v0, $t0\n"
    ".L800F7654:\n"
    "\tsrl        $t0, $v0, 23\n"
    "\tsll        $t0, $t0, 2\n"
    "\tadd        $t0, $t0, $a3\n"
    "\tlw         $t1, 0($t0)\n"
    "\tadd        $t3, $zero, $zero\n"
    "\tb          .L800F7674\n"
    "\tandi      $at, $t1, 255\n"
    ".L800F7670:\n"
    "\tlw         $t3, 4($t0)\n"
    ".L800F7674:\n"
    "\tsllv       $v0, $v0, $at\n"
    "\tadd        $v1, $v1, $at\n"
    "\tandi       $at, $v1, 16\n"
    "\tbeqz       $at, .L800F7698\n"
    "\tandi      $v1, $v1, 15\n"
    "\tlhu        $t0, 0($a0)\n"
    "\taddi       $a0, $a0, 2\n"
    "\tsllv       $t0, $t0, $v1\n"
    "\tor         $v0, $v0, $t0\n"
    ".L800F7698:\n"
    "\tsrl        $t1, $t1, 16\n"
    "\txori       $at, $t1, 31775\n"
    "\tbeqz       $at, .L800F76F8\n"
    "\txori      $at, $t1, 65024\n"
    "\tbeqz       $at, .L800F74F8\n"
    "\tsh        $t1, 0($a1)\n"
    "\tbeqz       $t3, .L800F7614\n"
    "\taddi      $a1, $a1, 2\n"
    "\tandi       $t2, $t3, 65535\n"
    "\txori       $at, $t2, 31775\n"
    "\tbeqz       $at, .L800F76F8\n"
    "\txori      $at, $t2, 65024\n"
    "\tbeqz       $at, .L800F74F8\n"
    "\tsh        $t2, 0($a1)\n"
    "\tsrl        $t2, $t3, 16\n"
    "\tbeqz       $t2, .L800F7614\n"
    "\taddi      $a1, $a1, 2\n"
    "\txori       $at, $t2, 31775\n"
    "\tbeqz       $at, .L800F76F8\n"
    "\txori      $at, $t2, 65024\n"
    "\tbeqz       $at, .L800F74F8\n"
    "\tsh        $t2, 0($a1)\n"
    "\tb          .L800F7614\n"
    "\taddi      $a1, $a1, 2\n"
    ".L800F76F8:\n"
    "\tsrl        $t0, $v0, 16\n"
    "\tsh         $t0, 0($a1)\n"
    "\taddi       $a1, $a1, 2\n"
    "\tlhu        $t0, 0($a0)\n"
    "\taddi       $a0, $a0, 2\n"
    "\tsll        $v0, $v0, 16\n"
    "\tsllv       $t0, $t0, $v1\n"
    "\tb          .L800F7614\n"
    "\tor        $v0, $v0, $t0\n"
    ".L800F771C:\n"
    "\tlui        $t0, %hi(_vlc_end)\n"
    "\taddiu      $t0, $t0, %lo(_vlc_end)\n"
    "\tlw         $t1, 0($t0)\n"
    "\tori        $t0, $zero, 65024\n"
    ".L800F772C:\n"
    "\tsubu       $at, $a1, $t1\n"
    "\tbgez       $at, .L800F7744\n"
    "\tnop\n"
    "\tsh         $t0, 0($a1)\n"
    "\tb          .L800F772C\n"
    "\taddi      $a1, $a1, 2\n"
    ".L800F7744:\n"
    "\tjr         $ra\n"
    "\tadd       $v0, $zero, $zero\n"
    ".L800F774C:\n"
    "\tlui        $t0, %hi(_vlc_state)\n"
    "\taddiu      $t0, $t0, %lo(_vlc_state)\n"
    "\tsw         $a0, 0($t0)\n"
    "\tsw         $a1, 4($t0)\n"
    "\tsw         $v0, 8($t0)\n"
    "\tsw         $v1, 12($t0)\n"
    "\tsw         $t4, 16($t0)\n"
    "\tsw         $t5, 20($t0)\n"
    "\tsw         $t7, 24($t0)\n"
    "\tsw         $t8, 28($t0)\n"
    "\tsw         $t9, 32($t0)\n"
    "\tjr         $ra\n"
    "\taddi      $v0, $zero, 1\n"
    ".set pop\n"
);
#else
extern int DecDCTvlc(u_int *bs, u_int *buf)
{
    /* host stub: this routine is genuine hand-written PSX asm (see header); no portable C
     * equivalent is reconstructed -- the real body only exists under __mips__. */
    (void)bs; (void)buf;
    return 0;
}
#endif
