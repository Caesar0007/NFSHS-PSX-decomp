.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___14tScreenDisplay, 0x20

glabel ___14tScreenDisplay
    /* 36204 80045A04 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 36208 80045A08 1000BFAF */  sw         $ra, 0x10($sp)
    /* 3620C 80045A0C 1E98000C */  jal        ___7tScreen
    /* 36210 80045A10 00000000 */   nop
    /* 36214 80045A14 1000BF8F */  lw         $ra, 0x10($sp)
    /* 36218 80045A18 00000000 */  nop
    /* 3621C 80045A1C 0800E003 */  jr         $ra
    /* 36220 80045A20 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___14tScreenDisplay
    /* 36224 80045A24 00000000 */  nop
