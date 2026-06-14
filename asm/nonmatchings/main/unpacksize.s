.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching unpacksize, 0x20

glabel unpacksize
    /* D4804 800E4004 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* D4808 800E4008 1000BFAF */  sw         $ra, 0x10($sp)
    /* D480C 800E400C CF8F030C */  jal        unpacksizez
    /* D4810 800E4010 00000000 */   nop
    /* D4814 800E4014 1000BF8F */  lw         $ra, 0x10($sp)
    /* D4818 800E4018 00000000 */  nop
    /* D481C 800E401C 0800E003 */  jr         $ra
    /* D4820 800E4020 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel unpacksize
