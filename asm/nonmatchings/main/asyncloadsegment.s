.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching asyncloadsegment, 0x20

glabel asyncloadsegment
    /* E1DB0 800F15B0 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* E1DB4 800F15B4 1000BFAF */  sw         $ra, 0x10($sp)
    /* E1DB8 800F15B8 2FC5030C */  jal        asyncloadsegmentcallback
    /* E1DBC 800F15BC 21380000 */   addu      $a3, $zero, $zero
    /* E1DC0 800F15C0 1000BF8F */  lw         $ra, 0x10($sp)
    /* E1DC4 800F15C4 00000000 */  nop
    /* E1DC8 800F15C8 0800E003 */  jr         $ra
    /* E1DCC 800F15CC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel asyncloadsegment
