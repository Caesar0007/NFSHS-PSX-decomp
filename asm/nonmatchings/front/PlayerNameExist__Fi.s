.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching PlayerNameExist__Fi, 0x2C

glabel PlayerNameExist__Fi
    /* 1C1D0 8002B9D0 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 1C1D4 8002B9D4 C0100400 */  sll        $v0, $a0, 3
    /* 1C1D8 8002B9D8 1180043C */  lui        $a0, %hi(D_80114964)
    /* 1C1DC 8002B9DC 64498424 */  addiu      $a0, $a0, %lo(D_80114964)
    /* 1C1E0 8002B9E0 1000BFAF */  sw         $ra, 0x10($sp)
    /* 1C1E4 8002B9E4 DDA7030C */  jal        strlen
    /* 1C1E8 8002B9E8 21204400 */   addu      $a0, $v0, $a0
    /* 1C1EC 8002B9EC 1000BF8F */  lw         $ra, 0x10($sp)
    /* 1C1F0 8002B9F0 2B100200 */  sltu       $v0, $zero, $v0
    /* 1C1F4 8002B9F4 0800E003 */  jr         $ra
    /* 1C1F8 8002B9F8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel PlayerNameExist__Fi
