.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIWorld_ZSplineDistance__FP8Car_tObjT0, 0x94

glabel AIWorld_ZSplineDistance__FP8Car_tObjT0
    /* 63790 80072F90 C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* 63794 80072F94 3400BFAF */  sw         $ra, 0x34($sp)
    /* 63798 80072F98 3000B0AF */  sw         $s0, 0x30($sp)
    /* 6379C 80072F9C A000828C */  lw         $v0, 0xA0($a0)
    /* 637A0 80072FA0 A000A38C */  lw         $v1, 0xA0($a1)
    /* 637A4 80072FA4 00000000 */  nop
    /* 637A8 80072FA8 23104300 */  subu       $v0, $v0, $v1
    /* 637AC 80072FAC 1000A2AF */  sw         $v0, 0x10($sp)
    /* 637B0 80072FB0 A400828C */  lw         $v0, 0xA4($a0)
    /* 637B4 80072FB4 A400A38C */  lw         $v1, 0xA4($a1)
    /* 637B8 80072FB8 00000000 */  nop
    /* 637BC 80072FBC 23104300 */  subu       $v0, $v0, $v1
    /* 637C0 80072FC0 1400A2AF */  sw         $v0, 0x14($sp)
    /* 637C4 80072FC4 A800828C */  lw         $v0, 0xA8($a0)
    /* 637C8 80072FC8 A800A38C */  lw         $v1, 0xA8($a1)
    /* 637CC 80072FCC 00000000 */  nop
    /* 637D0 80072FD0 23104300 */  subu       $v0, $v0, $v1
    /* 637D4 80072FD4 1800A2AF */  sw         $v0, 0x18($sp)
    /* 637D8 80072FD8 5C01868C */  lw         $a2, 0x15C($a0)
    /* 637DC 80072FDC 6001878C */  lw         $a3, 0x160($a0)
    /* 637E0 80072FE0 6401888C */  lw         $t0, 0x164($a0)
    /* 637E4 80072FE4 2000A6AF */  sw         $a2, 0x20($sp)
    /* 637E8 80072FE8 2400A7AF */  sw         $a3, 0x24($sp)
    /* 637EC 80072FEC 2800A8AF */  sw         $t0, 0x28($sp)
    /* 637F0 80072FF0 1000A48F */  lw         $a0, 0x10($sp)
    /* 637F4 80072FF4 2000A58F */  lw         $a1, 0x20($sp)
    /* 637F8 80072FF8 CA90030C */  jal        fixedmult
    /* 637FC 80072FFC 00000000 */   nop
    /* 63800 80073000 1800A48F */  lw         $a0, 0x18($sp)
    /* 63804 80073004 2800A58F */  lw         $a1, 0x28($sp)
    /* 63808 80073008 CA90030C */  jal        fixedmult
    /* 6380C 8007300C 21804000 */   addu      $s0, $v0, $zero
    /* 63810 80073010 21100202 */  addu       $v0, $s0, $v0
    /* 63814 80073014 3400BF8F */  lw         $ra, 0x34($sp)
    /* 63818 80073018 3000B08F */  lw         $s0, 0x30($sp)
    /* 6381C 8007301C 0800E003 */  jr         $ra
    /* 63820 80073020 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel AIWorld_ZSplineDistance__FP8Car_tObjT0
