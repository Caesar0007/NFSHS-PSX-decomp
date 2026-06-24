.include "macro.inc"

/* ============================================================================
 * SN-LNK obj-linker blobs (inert) — reclassified out of src/main.c
 * ----------------------------------------------------------------------------
 * These three 8-byte regions used to be split by splat as the "functions"
 * func_800E80C4 / func_800F219C / func_8010694C and were INCLUDE_ASM'd from
 * src/main.c.  They are NOT functions: each is verbatim PsyQ .OBJ content that
 * PSYLINK left inline in the .text stream, immediately *before* a BIOS-call
 * thunk.  The recurring byte pattern is  50 73 ?? 25 | 9b 52|53 43 00.
 *
 * Verification (C:\Temp\claud\search_pattern.py): the pattern occurs 10x in
 * rom/nfs4-f.exe (3 in .text, 7 in .data @0x8012-0x8013).  EVERY occurrence has
 * 0 pointer-refs and 0 jal-refs => never read, never reached, totally inert.
 * Only the thunk that FOLLOWS each .text blob is live.
 *
 * Source obj + the live thunk each blob precedes:
 *   D_800E80C4  <- A63.OBJ  /libc    ; precedes  puts      (B0:0x3F) @0x800E80CC  (jal'd 12x)
 *   D_800F219C  <- MSC00.OBJ/libgte  ; precedes  InitGeom            @0x800F21A4  (jal'd  2x)
 *   D_8010694C  <- C114.OBJ /libapi  ; precedes  _96_remove(A0:0x72) @0x80106954  (jal'd  1x)
 * (in-obj each blob is preceded by an SN-LNK `06 02 f0 02 NN 00` record, tag 06 = local-sym.)
 *
 * NOTE: the three blobs are at three NON-contiguous VAs (interleaved with code);
 * they are grouped in this one file only as a holding pen.  This object is NOT
 * wired into linkers/nfs4.ld (the full PS-EXE link is not the active per-object
 * gate post-sweep).  FINAL DISPOSITION IS DEFERRED (user, 2026-06-24):
 *   keep-as-data  vs  fold-into-the-following-thunk-obj  vs  drop.
 * When disposition is decided, place/fold per-VA (or delete this file).
 * ==========================================================================*/

.section .text, "ax"

nonmatching D_800E80C4, 0x8

dlabel D_800E80C4
    /* D88C4 800E80C4 50730125 */ .word 0x25017350   /* addiu $at,$t0,0x7350 (inert) */
    /* D88C8 800E80C8 9B524300 */ .word 0x0043529B
enddlabel D_800E80C4

nonmatching D_800F219C, 0x8

dlabel D_800F219C
    /* E299C 800F219C 50730925 */ .word 0x25097350   /* addiu $t1,$t0,0x7350 (inert) */
    /* E29A0 800F21A0 9B534300 */ .word 0x0043539B
enddlabel D_800F219C

nonmatching D_8010694C, 0x8

dlabel D_8010694C
    /* F714C 8010694C 50730025 */ .word 0x25007350   /* addiu $zero,$t0,0x7350 (inert) */
    /* F7150 80106950 9B524300 */ .word 0x0043529B
enddlabel D_8010694C
