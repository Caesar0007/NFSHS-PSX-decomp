.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioClc_InitSource__FP16AudioClc_tSourceP8Car_tObj, 0x30

glabel AudioClc_InitSource__FP16AudioClc_tSourceP8Car_tObj
    /* 65008 80074808 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 6500C 8007480C 040082AC */  sw         $v0, 0x4($a0)
    /* 65010 80074810 080082AC */  sw         $v0, 0x8($a0)
    /* 65014 80074814 24130224 */  addiu      $v0, $zero, 0x1324
    /* 65018 80074818 000085AC */  sw         $a1, 0x0($a0)
    /* 6501C 8007481C 100080AC */  sw         $zero, 0x10($a0)
    /* 65020 80074820 200080AC */  sw         $zero, 0x20($a0)
    /* 65024 80074824 140082AC */  sw         $v0, 0x14($a0)
    /* 65028 80074828 180080AC */  sw         $zero, 0x18($a0)
    /* 6502C 8007482C 300080AC */  sw         $zero, 0x30($a0)
    /* 65030 80074830 0800E003 */  jr         $ra
    /* 65034 80074834 340080AC */   sw        $zero, 0x34($a0)
endlabel AudioClc_InitSource__FP16AudioClc_tSourceP8Car_tObj
