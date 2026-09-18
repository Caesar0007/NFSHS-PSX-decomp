.include "macro.inc"

/* ============================================================================
 * SN-LNK obj blob (inert data in the .text stream) @0x8010694C, 8 bytes
 * ----------------------------------------------------------------------------
 * Verbatim PsyQ .OBJ content that PSYLINK left inline at the START of the
 * text of C114.OBJ (libapi), immediately before the live BIOS thunk
 *   _96_remove (A0:0x72) @0x80106954  (jal'd 1x).
 * In the .OBJ the bytes are preceded by an SN-LNK `06 02 f0 02 NN 00` record
 * (tag 06 = local symbol).  Pattern `50 73 ?? 25 | 9b 52|53 43 00`, 10x in the
 * ROM, 0 pointer-refs, 0 jal-refs => never read, never executed.
 *
 * DISPOSITION (user, 2026-09-18): keep as DATA, placed for the linker at its
 * retail address -- one blob per object so gen_ld's `VA - offset` vote on the
 * name-encoded D_<VA> label yields a single base.  See sn_lnk_800E80C4.text.s.
 * ==========================================================================*/

.section .text, "ax"

nonmatching D_8010694C, 0x8

dlabel D_8010694C
    /* F714C 8010694C 50730025 */ .word 0x25007350   /* addiu $zero,$t0,0x7350 (inert) */
    /* F7150 80106950 9B524300 */ .word 0x0043529B
enddlabel D_8010694C
