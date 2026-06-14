.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CdGetToc, 0x24

glabel CdGetToc
    /* F9A9C 8010929C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* F9AA0 801092A0 1000BFAF */  sw         $ra, 0x10($sp)
    /* F9AA4 801092A4 21288000 */  addu       $a1, $a0, $zero
    /* F9AA8 801092A8 B024040C */  jal        CdGetToc2
    /* F9AAC 801092AC 01000424 */   addiu     $a0, $zero, 0x1
    /* F9AB0 801092B0 1000BF8F */  lw         $ra, 0x10($sp)
    /* F9AB4 801092B4 1800BD27 */  addiu      $sp, $sp, 0x18
    /* F9AB8 801092B8 0800E003 */  jr         $ra
    /* F9ABC 801092BC 00000000 */   nop
endlabel CdGetToc
