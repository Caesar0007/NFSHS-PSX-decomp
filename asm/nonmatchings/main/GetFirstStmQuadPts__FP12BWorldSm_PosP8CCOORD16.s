.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetFirstStmQuadPts__FP12BWorldSm_PosP8CCOORD16, 0x9C

glabel GetFirstStmQuadPts__FP12BWorldSm_PosP8CCOORD16
    /* 6F798 8007EF98 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 6F79C 8007EF9C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 6F7A0 8007EFA0 21808000 */  addu       $s0, $a0, $zero
    /* 6F7A4 8007EFA4 1400B1AF */  sw         $s1, 0x14($sp)
    /* 6F7A8 8007EFA8 1800BFAF */  sw         $ra, 0x18($sp)
    /* 6F7AC 8007EFAC B8FB010C */  jal        SetStrip__FP12BWorldSm_Pos
    /* 6F7B0 8007EFB0 2188A000 */   addu      $s1, $a1, $zero
    /* 6F7B4 8007EFB4 38000426 */  addiu      $a0, $s0, 0x38
    /* 6F7B8 8007EFB8 7C00038E */  lw         $v1, 0x7C($s0)
    /* 6F7BC 8007EFBC 02000586 */  lh         $a1, 0x2($s0)
    /* 6F7C0 8007EFC0 00006290 */  lbu        $v0, 0x0($v1)
    /* 6F7C4 8007EFC4 01006390 */  lbu        $v1, 0x1($v1)
    /* 6F7C8 8007EFC8 21104500 */  addu       $v0, $v0, $a1
    /* 6F7CC 8007EFCC C0100200 */  sll        $v0, $v0, 3
    /* 6F7D0 8007EFD0 21105100 */  addu       $v0, $v0, $s1
    /* 6F7D4 8007EFD4 21186500 */  addu       $v1, $v1, $a1
    /* 6F7D8 8007EFD8 08004694 */  lhu        $a2, 0x8($v0)
    /* 6F7DC 8007EFDC 0C004794 */  lhu        $a3, 0xC($v0)
    /* 6F7E0 8007EFE0 C0180300 */  sll        $v1, $v1, 3
    /* 6F7E4 8007EFE4 080086A4 */  sh         $a2, 0x8($a0)
    /* 6F7E8 8007EFE8 0C0087A4 */  sh         $a3, 0xC($a0)
    /* 6F7EC 8007EFEC 00004694 */  lhu        $a2, 0x0($v0)
    /* 6F7F0 8007EFF0 04004794 */  lhu        $a3, 0x4($v0)
    /* 6F7F4 8007EFF4 21187100 */  addu       $v1, $v1, $s1
    /* 6F7F8 8007EFF8 100086A4 */  sh         $a2, 0x10($a0)
    /* 6F7FC 8007EFFC 140087A4 */  sh         $a3, 0x14($a0)
    /* 6F800 8007F000 00006694 */  lhu        $a2, 0x0($v1)
    /* 6F804 8007F004 04006794 */  lhu        $a3, 0x4($v1)
    /* 6F808 8007F008 180086A4 */  sh         $a2, 0x18($a0)
    /* 6F80C 8007F00C 1C0087A4 */  sh         $a3, 0x1C($a0)
    /* 6F810 8007F010 08006694 */  lhu        $a2, 0x8($v1)
    /* 6F814 8007F014 0C006794 */  lhu        $a3, 0xC($v1)
    /* 6F818 8007F018 380006A6 */  sh         $a2, 0x38($s0)
    /* 6F81C 8007F01C 040087A4 */  sh         $a3, 0x4($a0)
    /* 6F820 8007F020 1800BF8F */  lw         $ra, 0x18($sp)
    /* 6F824 8007F024 1400B18F */  lw         $s1, 0x14($sp)
    /* 6F828 8007F028 1000B08F */  lw         $s0, 0x10($sp)
    /* 6F82C 8007F02C 0800E003 */  jr         $ra
    /* 6F830 8007F030 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel GetFirstStmQuadPts__FP12BWorldSm_PosP8CCOORD16
