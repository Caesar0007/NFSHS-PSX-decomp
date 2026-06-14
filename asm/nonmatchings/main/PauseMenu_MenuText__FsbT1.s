.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching PauseMenu_MenuText__FsbT1, 0x64

glabel PauseMenu_MenuText__FsbT1
    /* 9778C 800A6F8C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 97790 800A6F90 1400B1AF */  sw         $s1, 0x14($sp)
    /* 97794 800A6F94 2188A000 */  addu       $s1, $a1, $zero
    /* 97798 800A6F98 1800B2AF */  sw         $s2, 0x18($sp)
    /* 9779C 800A6F9C 2190C000 */  addu       $s2, $a2, $zero
    /* 977A0 800A6FA0 1000B0AF */  sw         $s0, 0x10($sp)
    /* 977A4 800A6FA4 00840400 */  sll        $s0, $a0, 16
    /* 977A8 800A6FA8 03841000 */  sra        $s0, $s0, 16
    /* 977AC 800A6FAC 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 977B0 800A6FB0 A4E4020C */  jal        TextSys_WordX__Fi
    /* 977B4 800A6FB4 21200002 */   addu      $a0, $s0, $zero
    /* 977B8 800A6FB8 21200002 */  addu       $a0, $s0, $zero
    /* 977BC 800A6FBC 008C1100 */  sll        $s1, $s1, 16
    /* 977C0 800A6FC0 00941200 */  sll        $s2, $s2, 16
    /* 977C4 800A6FC4 00140200 */  sll        $v0, $v0, 16
    /* 977C8 800A6FC8 032C1100 */  sra        $a1, $s1, 16
    /* 977CC 800A6FCC 03341200 */  sra        $a2, $s2, 16
    /* 977D0 800A6FD0 C59B020C */  jal        PauseMenu_MenuTextPositioned__Fssss
    /* 977D4 800A6FD4 033C0200 */   sra       $a3, $v0, 16
    /* 977D8 800A6FD8 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 977DC 800A6FDC 1800B28F */  lw         $s2, 0x18($sp)
    /* 977E0 800A6FE0 1400B18F */  lw         $s1, 0x14($sp)
    /* 977E4 800A6FE4 1000B08F */  lw         $s0, 0x10($sp)
    /* 977E8 800A6FE8 0800E003 */  jr         $ra
    /* 977EC 800A6FEC 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel PauseMenu_MenuText__FsbT1
