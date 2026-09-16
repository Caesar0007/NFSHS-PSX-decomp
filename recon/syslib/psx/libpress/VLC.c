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
/* SYM-GLOBAL-CARRIER: _vlc_blksize
 * SYM-GLOBAL-CARRIER: _vlc_state
 * SYM-GLOBAL-CARRIER: _vlc_end
 * VLC.obj-private resumable state, with exact retail VAs and access shapes
 * proven by the adjacent oracle-derived reconstruction. */
static int      _vlc_blksize __attribute__((section(".data"))) = 0xffffff;  /* @0x801369E8 : output cells per slice; oracle refs ALL absolute lui/%hi (0 gp_rel) -> out of .sdata */
/* Retail keeps both in .data (0x801369ec / 0x80136a10, zero-valued): C
 * statics WITH initializers are emitted into .data at their definition. */
static u_int    _vlc_state[9] __attribute__((section(".data"))) = { 0 };  /* @0x801369EC..80136A0C */
static u_short *_vlc_end       __attribute__((section(".data"))) = 0;      /* @0x80136A10 : output slice end */

/* @0x800F7400 : set the per-slice output size (in cells); returns the previous value. */
extern int DecDCTvlcSize(int size);
#if defined(__mips__)
__asm__(
    ".text\n\t.set noat\n\t.set noreorder\n\t.set\tnoreorder\n"
    ".globl DecDCTvlcSize\nDecDCTvlcSize:\n"
    "\tlui        $8, %hi(_vlc_blksize)\n"
    "\taddiu      $8, $8, %lo(_vlc_blksize)\n"
    "\taddi       $1, $4, -1\n"
    "\tblez       $1, .L800F7420\n"
    "\tlw        $2, 0($8)\n"
    "\tsll        $1, $4, 1\n"
    "\tjr         $31\n"
    "\tsw        $1, 0($8)\n"
    ".L800F7420:\n"
    "\tlui        $1, (16777215 >> 16)\n"
    "\tori        $1, $1, (16777215 & 65535)\n"
    "\tjr         $31\n"
    "\tsw        $1, 0($8)\n"
    ".set reorder\n.set at\n"
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
    ".text\n\t.set noat\n\t.set noreorder\n\t.set\tnoreorder\n"
    ".globl DecDCTvlc\nDecDCTvlc:\n"
    "\tlui        $8, %hi(_vlc_blksize)\n"
    "\taddiu      $8, $8, %lo(_vlc_blksize)\n"
    "\tlui        $6, %hi(CF_DVLC)\n"
    "\taddiu      $6, $6, %lo(CF_DVLC)\n"
    "\tlui        $7, %hi(CF2_DVLC)\n"
    "\taddiu      $7, $7, %lo(CF2_DVLC)\n"
    "\tbnez       $4, .L800F7488\n"
    "\tlw        $9, 0($8)\n"
    "\tlui        $8, %hi(_vlc_state)\n"
    "\taddiu      $8, $8, %lo(_vlc_state)\n"
    "\tlw         $4, 0($8)\n"
    "\tlw         $5, 4($8)\n"
    "\tlw         $2, 8($8)\n"
    "\tlw         $3, 12($8)\n"
    "\tlw         $12, 16($8)\n"
    "\tlw         $13, 20($8)\n"
    "\tlw         $15, 24($8)\n"
    "\tlw         $24, 28($8)\n"
    "\tlw         $25, 32($8)\n"
    "\tadd        $9, $9, $9\n"
    "\tb          .L800F7614\n"
    "\tadd       $14, $5, $9\n"
    ".L800F7488:\n"
    "\tadd        $13, $0, $0\n"
    "\tadd        $15, $0, $0\n"
    "\tadd        $24, $0, $0\n"
    "\tadd        $25, $0, $0\n"
    "\tadd        $9, $9, $9\n"
    "\tadd        $14, $5, $9\n"
    "\tlw         $9, 0($4)\n"
    "\tlhu        $12, 4($4)\n"
    "\tlhu        $10, 6($4)\n"
    "\tlhu        $2, 8($4)\n"
    "\tlhu        $3, 10($4)\n"
    "\taddi       $10, $10, -3\n"
    "\tbltz       $10, .L800F74C4\n"
    "\tsll       $12, $12, 10\n"
    "\taddi       $13, $0, 1\n"
    ".L800F74C4:\n"
    "\taddi       $4, $4, 12\n"
    "\tsll        $2, $2, 16\n"
    "\tor         $2, $2, $3\n"
    "\tor         $3, $0, $0\n"
    "\tsw         $9, 0($5)\n"
    "\tandi       $9, $9, 65535\n"
    "\tsll        $9, $9, 2\n"
    "\taddiu      $9, $9, 4\n"
    "\tadd        $9, $9, $5\n"
    "\tlui        $8, %hi(_vlc_end)\n"
    "\taddiu      $8, $8, %lo(_vlc_end)\n"
    "\tsw         $9, 0($8)\n"
    "\taddi       $5, $5, 2\n"
    ".L800F74F8:\n"
    "\tbeqz       $13, .L800F75D0\n"
    "\tsrl       $8, $2, 22\n"
    "\txori       $1, $8, 1023\n"
    "\tbeqz       $1, .L800F771C\n"
    "\taddi      $5, $5, 2\n"
    "\taddi       $1, $13, -3\n"
    "\tbltz       $1, .L800F751C\n"
    "\taddi      $1, $6, -1024\n"
    "\taddi       $1, $1, -1024\n"
    ".L800F751C:\n"
    "\tsrl        $8, $2, 24\n"
    "\tsll        $8, $8, 2\n"
    "\tadd        $8, $8, $1\n"
    "\tlhu        $9, 0($8)\n"
    "\tlhu        $10, 2($8)\n"
    "\tand        $8, $0, $0\n"
    "\tbeqz       $10, .L800F7560\n"
    "\tsllv      $2, $2, $9\n"
    "\taddi       $1, $0, 32\n"
    "\tsub        $1, $1, $10\n"
    "\tsrlv       $8, $2, $1\n"
    "\tbltz       $2, .L800F755C\n"
    "\tsllv      $2, $2, $10\n"
    "\taddi       $11, $0, -1\n"
    "\tsrlv       $11, $11, $1\n"
    "\tsub        $8, $8, $11\n"
    ".L800F755C:\n"
    "\tadd        $3, $3, $10\n"
    ".L800F7560:\n"
    "\tadd        $3, $3, $9\n"
    "\tandi       $1, $3, 16\n"
    "\tbeqz       $1, .L800F7580\n"
    "\tandi      $3, $3, 15\n"
    "\tlhu        $9, 0($4)\n"
    "\taddi       $4, $4, 2\n"
    "\tsllv       $9, $9, $3\n"
    "\tor         $2, $2, $9\n"
    ".L800F7580:\n"
    "\taddi       $1, $13, -2\n"
    "\tbgtz       $1, .L800F75A8\n"
    "\tadd       $9, $25, $8\n"
    "\tbeqz       $1, .L800F75A0\n"
    "\tadd       $9, $24, $8\n"
    "\tadd        $9, $15, $8\n"
    "\tb          .L800F75AC\n"
    "\tadd       $15, $15, $8\n"
    ".L800F75A0:\n"
    "\tb          .L800F75AC\n"
    "\tadd       $24, $24, $8\n"
    ".L800F75A8:\n"
    "\tadd        $25, $25, $8\n"
    ".L800F75AC:\n"
    "\tsll        $9, $9, 2\n"
    "\tandi       $9, $9, 1023\n"
    "\tor         $9, $12, $9\n"
    "\taddi       $13, $13, 1\n"
    "\taddi       $1, $13, -7\n"
    "\tbnez       $1, .L800F7608\n"
    "\tsh        $9, 0($5)\n"
    "\tb          .L800F7608\n"
    "\taddi      $13, $13, -6\n"
    ".L800F75D0:\n"
    "\txori       $1, $8, 511\n"
    "\tbeqz       $1, .L800F771C\n"
    "\taddi      $5, $5, 2\n"
    "\tsll        $2, $2, 10\n"
    "\taddi       $3, $3, 10\n"
    "\tandi       $1, $3, 16\n"
    "\tbeqz       $1, .L800F7600\n"
    "\tandi      $3, $3, 15\n"
    "\tlhu        $9, 0($4)\n"
    "\taddi       $4, $4, 2\n"
    "\tsllv       $9, $9, $3\n"
    "\tor         $2, $2, $9\n"
    ".L800F7600:\n"
    "\tor         $8, $12, $8\n"
    "\tsh         $8, 0($5)\n"
    ".L800F7608:\n"
    "\tsubu       $1, $5, $14\n"
    "\tbgez       $1, .L800F774C\n"
    "\taddi      $5, $5, 2\n"
    ".L800F7614:\n"
    "\tsrl        $8, $2, 19\n"
    "\tsll        $8, $8, 3\n"
    "\tadd        $8, $8, $6\n"
    "\tlw         $9, 0($8)\n"
    "\tnop\n"
    "\tbnez       $9, .L800F7670\n"
    "\tandi      $1, $9, 255\n"
    "\tsll        $2, $2, 8\n"
    "\taddi       $3, $3, 8\n"
    "\tandi       $1, $3, 16\n"
    "\tbeqz       $1, .L800F7654\n"
    "\tandi      $3, $3, 15\n"
    "\tlhu        $8, 0($4)\n"
    "\taddi       $4, $4, 2\n"
    "\tsllv       $8, $8, $3\n"
    "\tor         $2, $2, $8\n"
    ".L800F7654:\n"
    "\tsrl        $8, $2, 23\n"
    "\tsll        $8, $8, 2\n"
    "\tadd        $8, $8, $7\n"
    "\tlw         $9, 0($8)\n"
    "\tadd        $11, $0, $0\n"
    "\tb          .L800F7674\n"
    "\tandi      $1, $9, 255\n"
    ".L800F7670:\n"
    "\tlw         $11, 4($8)\n"
    ".L800F7674:\n"
    "\tsllv       $2, $2, $1\n"
    "\tadd        $3, $3, $1\n"
    "\tandi       $1, $3, 16\n"
    "\tbeqz       $1, .L800F7698\n"
    "\tandi      $3, $3, 15\n"
    "\tlhu        $8, 0($4)\n"
    "\taddi       $4, $4, 2\n"
    "\tsllv       $8, $8, $3\n"
    "\tor         $2, $2, $8\n"
    ".L800F7698:\n"
    "\tsrl        $9, $9, 16\n"
    "\txori       $1, $9, 31775\n"
    "\tbeqz       $1, .L800F76F8\n"
    "\txori      $1, $9, 65024\n"
    "\tbeqz       $1, .L800F74F8\n"
    "\tsh        $9, 0($5)\n"
    "\tbeqz       $11, .L800F7614\n"
    "\taddi      $5, $5, 2\n"
    "\tandi       $10, $11, 65535\n"
    "\txori       $1, $10, 31775\n"
    "\tbeqz       $1, .L800F76F8\n"
    "\txori      $1, $10, 65024\n"
    "\tbeqz       $1, .L800F74F8\n"
    "\tsh        $10, 0($5)\n"
    "\tsrl        $10, $11, 16\n"
    "\tbeqz       $10, .L800F7614\n"
    "\taddi      $5, $5, 2\n"
    "\txori       $1, $10, 31775\n"
    "\tbeqz       $1, .L800F76F8\n"
    "\txori      $1, $10, 65024\n"
    "\tbeqz       $1, .L800F74F8\n"
    "\tsh        $10, 0($5)\n"
    "\tb          .L800F7614\n"
    "\taddi      $5, $5, 2\n"
    ".L800F76F8:\n"
    "\tsrl        $8, $2, 16\n"
    "\tsh         $8, 0($5)\n"
    "\taddi       $5, $5, 2\n"
    "\tlhu        $8, 0($4)\n"
    "\taddi       $4, $4, 2\n"
    "\tsll        $2, $2, 16\n"
    "\tsllv       $8, $8, $3\n"
    "\tb          .L800F7614\n"
    "\tor        $2, $2, $8\n"
    ".L800F771C:\n"
    "\tlui        $8, %hi(_vlc_end)\n"
    "\taddiu      $8, $8, %lo(_vlc_end)\n"
    "\tlw         $9, 0($8)\n"
    "\tori        $8, $0, 65024\n"
    ".L800F772C:\n"
    "\tsubu       $1, $5, $9\n"
    "\tbgez       $1, .L800F7744\n"
    "\tnop\n"
    "\tsh         $8, 0($5)\n"
    "\tb          .L800F772C\n"
    "\taddi      $5, $5, 2\n"
    ".L800F7744:\n"
    "\tjr         $31\n"
    "\tadd       $2, $0, $0\n"
    ".L800F774C:\n"
    "\tlui        $8, %hi(_vlc_state)\n"
    "\taddiu      $8, $8, %lo(_vlc_state)\n"
    "\tsw         $4, 0($8)\n"
    "\tsw         $5, 4($8)\n"
    "\tsw         $2, 8($8)\n"
    "\tsw         $3, 12($8)\n"
    "\tsw         $12, 16($8)\n"
    "\tsw         $13, 20($8)\n"
    "\tsw         $15, 24($8)\n"
    "\tsw         $24, 28($8)\n"
    "\tsw         $25, 32($8)\n"
    "\tjr         $31\n"
    "\taddi      $2, $0, 1\n"
    ".set reorder\n.set at\n"
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
