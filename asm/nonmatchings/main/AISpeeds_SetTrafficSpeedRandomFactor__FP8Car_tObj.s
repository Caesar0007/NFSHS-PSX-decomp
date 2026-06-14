.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AISpeeds_SetTrafficSpeedRandomFactor__FP8Car_tObj, 0x7C

glabel AISpeeds_SetTrafficSpeedRandomFactor__FP8Car_tObj
    /* 5F728 8006EF28 1480033C */  lui        $v1, %hi(fastRandom)
    /* 5F72C 8006EF2C FCD0638C */  lw         $v1, %lo(fastRandom)($v1)
    /* 5F730 8006EF30 1480023C */  lui        $v0, %hi(randSeed)
    /* 5F734 8006EF34 04D1428C */  lw         $v0, %lo(randSeed)($v0)
    /* 5F738 8006EF38 00000000 */  nop
    /* 5F73C 8006EF3C 18006200 */  mult       $v1, $v0
    /* 5F740 8006EF40 F0FFBD27 */  addiu      $sp, $sp, -0x10
    /* 5F744 8006EF44 0580023C */  lui        $v0, %hi(D_800554E0)
    /* 5F748 8006EF48 E0544824 */  addiu      $t0, $v0, %lo(D_800554E0)
    /* 5F74C 8006EF4C 0000058D */  lw         $a1, 0x0($t0)
    /* 5F750 8006EF50 0400068D */  lw         $a2, 0x4($t0)
    /* 5F754 8006EF54 0800078D */  lw         $a3, 0x8($t0)
    /* 5F758 8006EF58 0000A5AF */  sw         $a1, 0x0($sp)
    /* 5F75C 8006EF5C 0400A6AF */  sw         $a2, 0x4($sp)
    /* 5F760 8006EF60 0800A7AF */  sw         $a3, 0x8($sp)
    /* 5F764 8006EF64 0C00058D */  lw         $a1, 0xC($t0)
    /* 5F768 8006EF68 00000000 */  nop
    /* 5F76C 8006EF6C 0C00A5AF */  sw         $a1, 0xC($sp)
    /* 5F770 8006EF70 12180000 */  mflo       $v1
    /* 5F774 8006EF74 82110300 */  srl        $v0, $v1, 6
    /* 5F778 8006EF78 0C004230 */  andi       $v0, $v0, 0xC
    /* 5F77C 8006EF7C 2110A203 */  addu       $v0, $sp, $v0
    /* 5F780 8006EF80 0000428C */  lw         $v0, 0x0($v0)
    /* 5F784 8006EF84 1480013C */  lui        $at, %hi(randtemp)
    /* 5F788 8006EF88 00D123AC */  sw         $v1, %lo(randtemp)($at)
    /* 5F78C 8006EF8C FFFF6330 */  andi       $v1, $v1, 0xFFFF
    /* 5F790 8006EF90 1480013C */  lui        $at, %hi(fastRandom)
    /* 5F794 8006EF94 FCD023AC */  sw         $v1, %lo(fastRandom)($at)
    /* 5F798 8006EF98 900582AC */  sw         $v0, 0x590($a0)
    /* 5F79C 8006EF9C 0800E003 */  jr         $ra
    /* 5F7A0 8006EFA0 1000BD27 */   addiu     $sp, $sp, 0x10
endlabel AISpeeds_SetTrafficSpeedRandomFactor__FP8Car_tObj
