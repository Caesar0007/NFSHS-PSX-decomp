.include "macro.inc"

/* ============================================================================
 * SN-LNK obj blob (inert data in the .text stream) @0x800F219C, 8 bytes
 * ----------------------------------------------------------------------------
 * Verbatim PsyQ .OBJ content that PSYLINK left inline at the START of the
 * text of MSC00.OBJ (libgte), immediately before
 *   InitGeom @0x800F21A4  (jal'd 2x).
 * In the .OBJ the bytes are preceded by an SN-LNK `06 02 f0 02 NN 00` record
 * (tag 06 = local symbol).  Pattern `50 73 ?? 25 | 9b 52|53 43 00`, 10x in the
 * ROM, 0 pointer-refs, 0 jal-refs => never read, never executed.
 *
 * DISPOSITION (user, 2026-09-18): keep as DATA, placed for the linker at its
 * retail address -- one blob per object so gen_ld's `VA - offset` vote on the
 * name-encoded D_<VA> label yields a single base.  See sn_lnk_800E80C4.text.s.
 * ==========================================================================*/

.section .text, "ax"

nonmatching D_800F219C, 0x8

dlabel D_800F219C
    /* E299C 800F219C 50730925 */ .word 0x25097350   /* addiu $t1,$t0,0x7350 (inert) */
    /* E29A0 800F21A0 9B534300 */ .word 0x0043539B
enddlabel D_800F219C
