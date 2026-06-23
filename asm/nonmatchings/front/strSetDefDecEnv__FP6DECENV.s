.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching strSetDefDecEnv__FP6DECENV, 0x8C

glabel strSetDefDecEnv__FP6DECENV
    /* 3D714 8004CF14 0580023C */  lui        $v0, %hi(D_80052CFC)
    /* 3D718 8004CF18 0580033C */  lui        $v1, %hi(D_80052CFE)
    /* 3D71C 8004CF1C FC2C4584 */  lh         $a1, %lo(D_80052CFC)($v0)
    /* 3D720 8004CF20 FE2C6284 */  lh         $v0, %lo(D_80052CFE)($v1)
    /* 3D724 8004CF24 00290500 */  sll        $a1, $a1, 4
    /* 3D728 8004CF28 1A00A200 */  div        $zero, $a1, $v0
    /* 3D72C 8004CF2C 02004014 */  bnez       $v0, .L8004CF38
    /* 3D730 8004CF30 00000000 */   nop
    /* 3D734 8004CF34 0D000700 */  break      7
  .L8004CF38:
    /* 3D738 8004CF38 FFFF0124 */  addiu      $at, $zero, -0x1
    /* 3D73C 8004CF3C 04004114 */  bne        $v0, $at, .L8004CF50
    /* 3D740 8004CF40 0080013C */   lui       $at, (0x80000000 >> 16)
    /* 3D744 8004CF44 0200A114 */  bne        $a1, $at, .L8004CF50
    /* 3D748 8004CF48 00000000 */   nop
    /* 3D74C 8004CF4C 0D000600 */  break      6
  .L8004CF50:
    /* 3D750 8004CF50 12280000 */  mflo       $a1
    /* 3D754 8004CF54 0580033C */  lui        $v1, %hi(D_80052D5C)
    /* 3D758 8004CF58 0580063C */  lui        $a2, %hi(D_80052D60)
    /* 3D75C 8004CF5C 0580073C */  lui        $a3, %hi(D_80052D08)
    /* 3D760 8004CF60 5C2D638C */  lw         $v1, %lo(D_80052D5C)($v1)
    /* 3D764 8004CF64 602DC68C */  lw         $a2, %lo(D_80052D60)($a2)
    /* 3D768 8004CF68 082DE794 */  lhu        $a3, %lo(D_80052D08)($a3)
    /* 3D76C 8004CF6C 0580023C */  lui        $v0, %hi(D_80052D58)
    /* 3D770 8004CF70 582D428C */  lw         $v0, %lo(D_80052D58)($v0)
    /* 3D774 8004CF74 080080AC */  sw         $zero, 0x8($a0)
    /* 3D778 8004CF78 200080AC */  sw         $zero, 0x20($a0)
    /* 3D77C 8004CF7C 2C0080AC */  sw         $zero, 0x2C($a0)
    /* 3D780 8004CF80 240080A4 */  sh         $zero, 0x24($a0)
    /* 3D784 8004CF84 260080A4 */  sh         $zero, 0x26($a0)
    /* 3D788 8004CF88 040083AC */  sw         $v1, 0x4($a0)
    /* 3D78C 8004CF8C 0C0086AC */  sw         $a2, 0xC($a0)
    /* 3D790 8004CF90 2A0087A4 */  sh         $a3, 0x2A($a0)
    /* 3D794 8004CF94 000082AC */  sw         $v0, 0x0($a0)
    /* 3D798 8004CF98 0800E003 */  jr         $ra
    /* 3D79C 8004CF9C 280085A4 */   sh        $a1, 0x28($a0)
endlabel strSetDefDecEnv__FP6DECENV
