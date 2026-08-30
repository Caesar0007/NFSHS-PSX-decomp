.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching VoxSentence_GetNumPhrases_8010B100, 0xC

/* W67-A5: LOCALIZED (retail-static-copy class, w65-a7 RECEIPTS §3.2 / the 16E */
/* .L decision): this is spchrule.c's file-local static copy @0x8010B100; the */
/* canonical global stays in spchdata's VoxSentence_GetNumPhrases_8010B100.s @0x80100730. */
/* Binding-only change -- the bytes and offsets do not move. */
    .type VoxSentence_GetNumPhrases_8010B100, @function
VoxSentence_GetNumPhrases_8010B100:
    /* FB900 8010B100 03008290 */  lbu        $v0, 0x3($a0)
    /* FB904 8010B104 0800E003 */  jr         $ra
    /* FB908 8010B108 82100200 */   srl       $v0, $v0, 2
endlabel VoxSentence_GetNumPhrases_8010B100
