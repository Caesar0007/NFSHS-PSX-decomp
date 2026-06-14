.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching intarccos, 0x24

glabel intarccos
    /* DB598 800EAD98 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* DB59C 800EAD9C 1000BFAF */  sw         $ra, 0x10($sp)
    /* DB5A0 800EADA0 36AB030C */  jal        intarcsin
    /* DB5A4 800EADA4 00000000 */   nop
    /* DB5A8 800EADA8 00010324 */  addiu      $v1, $zero, 0x100
    /* DB5AC 800EADAC 1000BF8F */  lw         $ra, 0x10($sp)
    /* DB5B0 800EADB0 23106200 */  subu       $v0, $v1, $v0
    /* DB5B4 800EADB4 0800E003 */  jr         $ra
    /* DB5B8 800EADB8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel intarccos
