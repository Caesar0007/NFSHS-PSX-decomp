.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching unpack, 0x20

glabel unpack
    /* D471C 800E3F1C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* D4720 800E3F20 1000BFAF */  sw         $ra, 0x10($sp)
    /* D4724 800E3F24 9A8F030C */  jal        unpackz
    /* D4728 800E3F28 00000000 */   nop
    /* D472C 800E3F2C 1000BF8F */  lw         $ra, 0x10($sp)
    /* D4730 800E3F30 00000000 */  nop
    /* D4734 800E3F34 0800E003 */  jr         $ra
    /* D4738 800E3F38 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel unpack
