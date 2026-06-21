.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetCar__25tScreenPinkSlipsCarSelectR8tCarInfo, 0x90

glabel GetCar__25tScreenPinkSlipsCarSelectR8tCarInfo
    /* 2F640 8003EE40 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 2F644 8003EE44 1000B0AF */  sw         $s0, 0x10($sp)
    /* 2F648 8003EE48 2180A000 */  addu       $s0, $a1, $zero
    /* 2F64C 8003EE4C 0580023C */  lui        $v0, %hi(PinkSlipsScreenState)
    /* 2F650 8003EE50 34204424 */  addiu      $a0, $v0, %lo(PinkSlipsScreenState)
    /* 2F654 8003EE54 3420438C */  lw         $v1, %lo(PinkSlipsScreenState)($v0)
    /* 2F658 8003EE58 06000224 */  addiu      $v0, $zero, 0x6
    /* 2F65C 8003EE5C 17006214 */  bne        $v1, $v0, .L8003EEBC
    /* 2F660 8003EE60 1400BFAF */   sw        $ra, 0x14($sp)
    /* 2F664 8003EE64 0400828C */  lw         $v0, 0x4($a0)
    /* 2F668 8003EE68 00000000 */  nop
    /* 2F66C 8003EE6C 14004314 */  bne        $v0, $v1, .L8003EEC0
    /* 2F670 8003EE70 21100000 */   addu      $v0, $zero, $zero
    /* 2F674 8003EE74 0580023C */  lui        $v0, %hi(FEApp)
    /* 2F678 8003EE78 C014438C */  lw         $v1, %lo(FEApp)($v0)
    /* 2F67C 8003EE7C 1180023C */  lui        $v0, %hi(frontEnd)
    /* 2F680 8003EE80 00464224 */  addiu      $v0, $v0, %lo(frontEnd)
    /* 2F684 8003EE84 1180043C */  lui        $a0, %hi(carManager)
    /* 2F688 8003EE88 2C026790 */  lbu        $a3, 0x22C($v1)
    /* 2F68C 8003EE8C 74428424 */  addiu      $a0, $a0, %lo(carManager)
    /* 2F690 8003EE90 2110E200 */  addu       $v0, $a3, $v0
    /* 2F694 8003EE94 25014590 */  lbu        $a1, 0x125($v0)
    /* 2F698 8003EE98 165C000C */  jal        GetPinkSlipsCar__11tCarManagersR8tCarInfos
    /* 2F69C 8003EE9C 21300002 */   addu      $a2, $s0, $zero
    /* 2F6A0 8003EEA0 C5000292 */  lbu        $v0, 0xC5($s0)
    /* 2F6A4 8003EEA4 00000000 */  nop
    /* 2F6A8 8003EEA8 21100202 */  addu       $v0, $s0, $v0
    /* 2F6AC 8003EEAC AF004390 */  lbu        $v1, 0xAF($v0)
    /* 2F6B0 8003EEB0 01000224 */  addiu      $v0, $zero, 0x1
    /* 2F6B4 8003EEB4 B0FB0008 */  j          .L8003EEC0
    /* 2F6B8 8003EEB8 C50003A2 */   sb        $v1, 0xC5($s0)
  .L8003EEBC:
    /* 2F6BC 8003EEBC 21100000 */  addu       $v0, $zero, $zero
  .L8003EEC0:
    /* 2F6C0 8003EEC0 1400BF8F */  lw         $ra, 0x14($sp)
    /* 2F6C4 8003EEC4 1000B08F */  lw         $s0, 0x10($sp)
    /* 2F6C8 8003EEC8 0800E003 */  jr         $ra
    /* 2F6CC 8003EECC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel GetCar__25tScreenPinkSlipsCarSelectR8tCarInfo
