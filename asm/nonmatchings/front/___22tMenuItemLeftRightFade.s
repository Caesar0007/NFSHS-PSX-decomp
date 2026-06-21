.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___22tMenuItemLeftRightFade, 0x20

glabel ___22tMenuItemLeftRightFade
    /* 114B8 80020CB8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 114BC 80020CBC 1000BFAF */  sw         $ra, 0x10($sp)
    /* 114C0 80020CC0 5592000C */  jal        ___24tMenuItemLeftRightChoice
    /* 114C4 80020CC4 00000000 */   nop
    /* 114C8 80020CC8 1000BF8F */  lw         $ra, 0x10($sp)
    /* 114CC 80020CCC 00000000 */  nop
    /* 114D0 80020CD0 0800E003 */  jr         $ra
    /* 114D4 80020CD4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___22tMenuItemLeftRightFade
