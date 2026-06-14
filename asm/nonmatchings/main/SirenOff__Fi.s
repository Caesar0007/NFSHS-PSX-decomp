.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SirenOff__Fi, 0xBC

glabel SirenOff__Fi
    /* 6A0A0 800798A0 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 6A0A4 800798A4 1180023C */  lui        $v0, %hi(bSirenOn)
    /* 6A0A8 800798A8 90E74224 */  addiu      $v0, $v0, %lo(bSirenOn)
    /* 6A0AC 800798AC 80280400 */  sll        $a1, $a0, 2
    /* 6A0B0 800798B0 2110A200 */  addu       $v0, $a1, $v0
    /* 6A0B4 800798B4 1000BFAF */  sw         $ra, 0x10($sp)
    /* 6A0B8 800798B8 000040AC */  sw         $zero, 0x0($v0)
    /* 6A0BC 800798BC 1180023C */  lui        $v0, %hi(bSirenPitchingUp)
    /* 6A0C0 800798C0 A8E74224 */  addiu      $v0, $v0, %lo(bSirenPitchingUp)
    /* 6A0C4 800798C4 2110A200 */  addu       $v0, $a1, $v0
    /* 6A0C8 800798C8 01000324 */  addiu      $v1, $zero, 0x1
    /* 6A0CC 800798CC 000043AC */  sw         $v1, 0x0($v0)
    /* 6A0D0 800798D0 1180023C */  lui        $v0, %hi(quickSirenActive)
    /* 6A0D4 800798D4 C0E74224 */  addiu      $v0, $v0, %lo(quickSirenActive)
    /* 6A0D8 800798D8 2110A200 */  addu       $v0, $a1, $v0
    /* 6A0DC 800798DC 000040AC */  sw         $zero, 0x0($v0)
    /* 6A0E0 800798E0 1180023C */  lui        $v0, %hi(sirenCurrentPitch)
    /* 6A0E4 800798E4 F0E74224 */  addiu      $v0, $v0, %lo(sirenCurrentPitch)
    /* 6A0E8 800798E8 2110A200 */  addu       $v0, $a1, $v0
    /* 6A0EC 800798EC 20000324 */  addiu      $v1, $zero, 0x20
    /* 6A0F0 800798F0 000043AC */  sw         $v1, 0x0($v0)
    /* 6A0F4 800798F4 1180023C */  lui        $v0, %hi(slowSirenReps)
    /* 6A0F8 800798F8 08E84224 */  addiu      $v0, $v0, %lo(slowSirenReps)
    /* 6A0FC 800798FC 2110A200 */  addu       $v0, $a1, $v0
    /* 6A100 80079900 03000324 */  addiu      $v1, $zero, 0x3
    /* 6A104 80079904 000043AC */  sw         $v1, 0x0($v0)
    /* 6A108 80079908 1180023C */  lui        $v0, %hi(reachedSirenMin)
    /* 6A10C 8007990C 38E84224 */  addiu      $v0, $v0, %lo(reachedSirenMin)
    /* 6A110 80079910 2110A200 */  addu       $v0, $a1, $v0
    /* 6A114 80079914 000040AC */  sw         $zero, 0x0($v0)
    /* 6A118 80079918 1180023C */  lui        $v0, %hi(quickSirenTimeCount)
    /* 6A11C 8007991C 50E84224 */  addiu      $v0, $v0, %lo(quickSirenTimeCount)
    /* 6A120 80079920 2128A200 */  addu       $a1, $a1, $v0
    /* 6A124 80079924 1180023C */  lui        $v0, %hi(gaChannel)
    /* 6A128 80079928 FCE84224 */  addiu      $v0, $v0, %lo(gaChannel)
    /* 6A12C 8007992C 2B008424 */  addiu      $a0, $a0, 0x2B
    /* 6A130 80079930 04206400 */  sllv       $a0, $a0, $v1
    /* 6A134 80079934 21208200 */  addu       $a0, $a0, $v0
    /* 6A138 80079938 0000A0AC */  sw         $zero, 0x0($a1)
    /* 6A13C 8007993C 05000524 */  addiu      $a1, $zero, 0x5
    /* 6A140 80079940 0000848C */  lw         $a0, 0x0($a0)
    /* 6A144 80079944 B4A0030C */  jal        SNDautovol
    /* 6A148 80079948 FFFF0624 */   addiu     $a2, $zero, -0x1
    /* 6A14C 8007994C 1000BF8F */  lw         $ra, 0x10($sp)
    /* 6A150 80079950 00000000 */  nop
    /* 6A154 80079954 0800E003 */  jr         $ra
    /* 6A158 80079958 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel SirenOff__Fi
