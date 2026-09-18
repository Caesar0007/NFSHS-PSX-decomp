.include "macro.inc"

/* ============================================================================
 * SN-LNK obj blob (inert data in the .text stream) @0x800E80C4, 8 bytes
 * ----------------------------------------------------------------------------
 * Verbatim PsyQ .OBJ content that PSYLINK left inline at the START of the
 * text of A63.OBJ (libc), immediately before the live BIOS thunk
 *   puts (B0:0x3F) @0x800E80CC  (jal'd 12x).
 * In the .OBJ the bytes are preceded by an SN-LNK `06 02 f0 02 NN 00` record
 * (tag 06 = local symbol).  The recurring pattern is
 *   50 73 ?? 25 | 9b 52|53 43 00
 * and occurs 10x in rom/nfs4-f.exe (3 in .text, 7 in .data); every occurrence
 * has 0 pointer-refs and 0 jal-refs => never read, never executed.
 *
 * DISPOSITION (user, 2026-09-18): keep as DATA, placed for the linker at its
 * retail address.  One blob per object on purpose: gen_ld places a text-stream
 * piece by voting `retail VA - symbol offset`, and the name-encoded D_<VA>
 * label gives a single, unambiguous base.  (The three blobs used to share one
 * holding-pen object, sn_lnk_blobs.text.s, whose three far-apart symbols could
 * not agree on a base -- it was dropped from the spine and linked as an orphan
 * past the end of the image, leaving these 8 bytes empty.)
 * ==========================================================================*/

.section .text, "ax"

nonmatching D_800E80C4, 0x8

dlabel D_800E80C4
    /* D88C4 800E80C4 50730125 */ .word 0x25017350   /* addiu $at,$t0,0x7350 (inert) */
    /* D88C8 800E80C8 9B524300 */ .word 0x0043529B
enddlabel D_800E80C4
