.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Front_ResetPSXController__Fii, 0x6C

glabel Front_ResetPSXController__Fii
    /* 178E4 800270E4 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 178E8 800270E8 1000B0AF */  sw         $s0, 0x10($sp)
    /* 178EC 800270EC 21808000 */  addu       $s0, $a0, $zero
    /* 178F0 800270F0 1400B1AF */  sw         $s1, 0x14($sp)
    /* 178F4 800270F4 2188A000 */  addu       $s1, $a1, $zero
    /* 178F8 800270F8 1800BFAF */  sw         $ra, 0x18($sp)
    /* 178FC 800270FC A1A0030C */  jal        timedwait
    /* 17900 80027100 0A000424 */   addiu     $a0, $zero, 0xA
    /* 17904 80027104 8490030C */  jal        PAD_update
    /* 17908 80027108 00000000 */   nop
    /* 1790C 8002710C 1180053C */  lui        $a1, %hi(frontEnd)
    /* 17910 80027110 0046A524 */  addiu      $a1, $a1, %lo(frontEnd)
    /* 17914 80027114 40201000 */  sll        $a0, $s0, 1
    /* 17918 80027118 1480033C */  lui        $v1, %hi(gPadinfo)
    /* 1791C 8002711C 9CE86324 */  addiu      $v1, $v1, %lo(gPadinfo)
    /* 17920 80027120 40111000 */  sll        $v0, $s0, 5
    /* 17924 80027124 21104300 */  addu       $v0, $v0, $v1
    /* 17928 80027128 21208500 */  addu       $a0, $a0, $a1
    /* 1792C 8002712C 05004290 */  lbu        $v0, 0x5($v0)
    /* 17930 80027130 21800502 */  addu       $s0, $s0, $a1
    /* 17934 80027134 5E0382A4 */  sh         $v0, 0x35E($a0)
    /* 17938 80027138 620311A2 */  sb         $s1, 0x362($s0)
    /* 1793C 8002713C 1800BF8F */  lw         $ra, 0x18($sp)
    /* 17940 80027140 1400B18F */  lw         $s1, 0x14($sp)
    /* 17944 80027144 1000B08F */  lw         $s0, 0x10($sp)
    /* 17948 80027148 0800E003 */  jr         $ra
    /* 1794C 8002714C 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Front_ResetPSXController__Fii
