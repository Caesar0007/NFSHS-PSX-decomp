.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioCmn_RemoveOldestAsyncSfx__Fi, 0xE8

glabel AudioCmn_RemoveOldestAsyncSfx__Fi
    /* 66E74 80076674 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 66E78 80076678 1000B0AF */  sw         $s0, 0x10($sp)
    /* 66E7C 8007667C FFFF1024 */  addiu      $s0, $zero, -0x1
    /* 66E80 80076680 21380000 */  addu       $a3, $zero, $zero
    /* 66E84 80076684 21400002 */  addu       $t0, $s0, $zero
    /* 66E88 80076688 1280023C */  lui        $v0, %hi(D_8011E0B0)
    /* 66E8C 8007668C B0E0438C */  lw         $v1, %lo(D_8011E0B0)($v0)
    /* 66E90 80076690 1180023C */  lui        $v0, %hi(AudioCmn_gSfxSlot)
    /* 66E94 80076694 34EB4624 */  addiu      $a2, $v0, %lo(AudioCmn_gSfxSlot)
    /* 66E98 80076698 1400BFAF */  sw         $ra, 0x14($sp)
    /* 66E9C 8007669C F0FF6324 */  addiu      $v1, $v1, -0x10
  .L800766A0:
    /* 66EA0 800766A0 2000E228 */  slti       $v0, $a3, 0x20
    /* 66EA4 800766A4 0F004010 */  beqz       $v0, .L800766E4
    /* 66EA8 800766A8 FFFF0224 */   addiu     $v0, $zero, -0x1
    /* 66EAC 800766AC 0400C28C */  lw         $v0, 0x4($a2)
    /* 66EB0 800766B0 00000000 */  nop
    /* 66EB4 800766B4 08004810 */  beq        $v0, $t0, .L800766D8
    /* 66EB8 800766B8 00000000 */   nop
    /* 66EBC 800766BC 0C00C58C */  lw         $a1, 0xC($a2)
    /* 66EC0 800766C0 00000000 */  nop
    /* 66EC4 800766C4 2A10A300 */  slt        $v0, $a1, $v1
    /* 66EC8 800766C8 03004010 */  beqz       $v0, .L800766D8
    /* 66ECC 800766CC 00000000 */   nop
    /* 66ED0 800766D0 2118A000 */  addu       $v1, $a1, $zero
    /* 66ED4 800766D4 2180E000 */  addu       $s0, $a3, $zero
  .L800766D8:
    /* 66ED8 800766D8 1800C624 */  addiu      $a2, $a2, 0x18
    /* 66EDC 800766DC A8D90108 */  j          .L800766A0
    /* 66EE0 800766E0 0100E724 */   addiu     $a3, $a3, 0x1
  .L800766E4:
    /* 66EE4 800766E4 14000216 */  bne        $s0, $v0, .L80076738
    /* 66EE8 800766E8 21280000 */   addu      $a1, $zero, $zero
    /* 66EEC 800766EC 21304000 */  addu       $a2, $v0, $zero
    /* 66EF0 800766F0 1180023C */  lui        $v0, %hi(AudioCmn_gSfxSlot)
    /* 66EF4 800766F4 34EB4324 */  addiu      $v1, $v0, %lo(AudioCmn_gSfxSlot)
  .L800766F8:
    /* 66EF8 800766F8 2000A228 */  slti       $v0, $a1, 0x20
    /* 66EFC 800766FC 0E004010 */  beqz       $v0, .L80076738
    /* 66F00 80076700 00000000 */   nop
    /* 66F04 80076704 0400628C */  lw         $v0, 0x4($v1)
    /* 66F08 80076708 00000000 */  nop
    /* 66F0C 8007670C 07004610 */  beq        $v0, $a2, .L8007672C
    /* 66F10 80076710 00000000 */   nop
    /* 66F14 80076714 0000628C */  lw         $v0, 0x0($v1)
    /* 66F18 80076718 00000000 */  nop
    /* 66F1C 8007671C 2A104400 */  slt        $v0, $v0, $a0
    /* 66F20 80076720 02004010 */  beqz       $v0, .L8007672C
    /* 66F24 80076724 00000000 */   nop
    /* 66F28 80076728 2180A000 */  addu       $s0, $a1, $zero
  .L8007672C:
    /* 66F2C 8007672C 18006324 */  addiu      $v1, $v1, 0x18
    /* 66F30 80076730 BED90108 */  j          .L800766F8
    /* 66F34 80076734 0100A524 */   addiu     $a1, $a1, 0x1
  .L80076738:
    /* 66F38 80076738 04000006 */  bltz       $s0, .L8007674C
    /* 66F3C 8007673C 21100002 */   addu      $v0, $s0, $zero
    /* 66F40 80076740 6DD9010C */  jal        AudioCmn_RemoveAsyncSfx__Fi
    /* 66F44 80076744 21200002 */   addu      $a0, $s0, $zero
    /* 66F48 80076748 21100002 */  addu       $v0, $s0, $zero
  .L8007674C:
    /* 66F4C 8007674C 1400BF8F */  lw         $ra, 0x14($sp)
    /* 66F50 80076750 1000B08F */  lw         $s0, 0x10($sp)
    /* 66F54 80076754 0800E003 */  jr         $ra
    /* 66F58 80076758 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AudioCmn_RemoveOldestAsyncSfx__Fi
