.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Movie_SetDecodeOffset__Fssss, 0xD4

glabel Movie_SetDecodeOffset__Fssss
    /* 3D0B0 8004C8B0 0580023C */  lui        $v0, %hi(D_80052D0A)
    /* 3D0B4 8004C8B4 0580033C */  lui        $v1, %hi(D_80052CFC)
    /* 3D0B8 8004C8B8 0A2D4884 */  lh         $t0, %lo(D_80052D0A)($v0)
    /* 3D0BC 8004C8BC FC2C6284 */  lh         $v0, %lo(D_80052CFC)($v1)
    /* 3D0C0 8004C8C0 00000000 */  nop
    /* 3D0C4 8004C8C4 18000201 */  mult       $t0, $v0
    /* 3D0C8 8004C8C8 0580023C */  lui        $v0, %hi(D_80052CFE)
    /* 3D0CC 8004C8CC 12400000 */  mflo       $t0
    /* 3D0D0 8004C8D0 FE2C4384 */  lh         $v1, %lo(D_80052CFE)($v0)
    /* 3D0D4 8004C8D4 00000000 */  nop
    /* 3D0D8 8004C8D8 1A000301 */  div        $zero, $t0, $v1
    /* 3D0DC 8004C8DC 02006014 */  bnez       $v1, .L8004C8E8
    /* 3D0E0 8004C8E0 00000000 */   nop
    /* 3D0E4 8004C8E4 0D000700 */  break      7
  .L8004C8E8:
    /* 3D0E8 8004C8E8 FFFF0124 */  addiu      $at, $zero, -0x1
    /* 3D0EC 8004C8EC 04006114 */  bne        $v1, $at, .L8004C900
    /* 3D0F0 8004C8F0 0080013C */   lui       $at, (0x80000000 >> 16)
    /* 3D0F4 8004C8F4 02000115 */  bne        $t0, $at, .L8004C900
    /* 3D0F8 8004C8F8 00000000 */   nop
    /* 3D0FC 8004C8FC 0D000600 */  break      6
  .L8004C900:
    /* 3D100 8004C900 12180000 */  mflo       $v1
    /* 3D104 8004C904 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 3D108 8004C908 1400BFAF */  sw         $ra, 0x14($sp)
    /* 3D10C 8004C90C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 3D110 8004C910 0580023C */  lui        $v0, %hi(D_80052D38)
    /* 3D114 8004C914 382D44A4 */  sh         $a0, %lo(D_80052D38)($v0)
    /* 3D118 8004C918 382D4224 */  addiu      $v0, $v0, %lo(D_80052D38)
    /* 3D11C 8004C91C 21204000 */  addu       $a0, $v0, $zero
    /* 3D120 8004C920 020085A4 */  sh         $a1, 0x2($a0)
    /* 3D124 8004C924 21280000 */  addu       $a1, $zero, $zero
    /* 3D128 8004C928 080086A4 */  sh         $a2, 0x8($a0)
    /* 3D12C 8004C92C 2130A000 */  addu       $a2, $a1, $zero
    /* 3D130 8004C930 0580023C */  lui        $v0, %hi(D_80052D08)
    /* 3D134 8004C934 082D4294 */  lhu        $v0, %lo(D_80052D08)($v0)
    /* 3D138 8004C938 08009024 */  addiu      $s0, $a0, 0x8
    /* 3D13C 8004C93C 020007A6 */  sh         $a3, 0x2($s0)
    /* 3D140 8004C940 2138A000 */  addu       $a3, $a1, $zero
    /* 3D144 8004C944 060082A4 */  sh         $v0, 0x6($a0)
    /* 3D148 8004C948 060002A6 */  sh         $v0, 0x6($s0)
    /* 3D14C 8004C94C 040083A4 */  sh         $v1, 0x4($a0)
    /* 3D150 8004C950 80B6030C */  jal        ClearImage
    /* 3D154 8004C954 040003A6 */   sh        $v1, 0x4($s0)
    /* 3D158 8004C958 21200002 */  addu       $a0, $s0, $zero
    /* 3D15C 8004C95C 21280000 */  addu       $a1, $zero, $zero
    /* 3D160 8004C960 2130A000 */  addu       $a2, $a1, $zero
    /* 3D164 8004C964 80B6030C */  jal        ClearImage
    /* 3D168 8004C968 2138A000 */   addu      $a3, $a1, $zero
    /* 3D16C 8004C96C 1FB6030C */  jal        DrawSync
    /* 3D170 8004C970 21200000 */   addu      $a0, $zero, $zero
    /* 3D174 8004C974 1400BF8F */  lw         $ra, 0x14($sp)
    /* 3D178 8004C978 1000B08F */  lw         $s0, 0x10($sp)
    /* 3D17C 8004C97C 0800E003 */  jr         $ra
    /* 3D180 8004C980 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Movie_SetDecodeOffset__Fssss
