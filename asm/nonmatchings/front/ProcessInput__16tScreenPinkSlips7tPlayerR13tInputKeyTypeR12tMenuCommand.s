.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ProcessInput__16tScreenPinkSlips7tPlayerR13tInputKeyTypeR12tMenuCommand, 0x13C

glabel ProcessInput__16tScreenPinkSlips7tPlayerR13tInputKeyTypeR12tMenuCommand
    /* 29E90 80039690 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* 29E94 80039694 4400BFAF */  sw         $ra, 0x44($sp)
    /* 29E98 80039698 4000B0AF */  sw         $s0, 0x40($sp)
    /* 29E9C 8003969C 0000C38C */  lw         $v1, 0x0($a2)
    /* 29EA0 800396A0 08000224 */  addiu      $v0, $zero, 0x8
    /* 29EA4 800396A4 45006214 */  bne        $v1, $v0, .L800397BC
    /* 29EA8 800396A8 1180023C */   lui       $v0, %hi(frontEnd)
    /* 29EAC 800396AC 00465024 */  addiu      $s0, $v0, %lo(frontEnd)
    /* 29EB0 800396B0 1180043C */  lui        $a0, %hi(trackManager)
    /* 29EB4 800396B4 46000292 */  lbu        $v0, 0x46($s0)
    /* 29EB8 800396B8 504A8424 */  addiu      $a0, $a0, %lo(trackManager)
    /* 29EBC 800396BC 21105000 */  addu       $v0, $v0, $s0
    /* 29EC0 800396C0 23004590 */  lbu        $a1, 0x23($v0)
    /* 29EC4 800396C4 A986000C */  jal        GetTrack__13tTrackManagersR17tTrackInformation
    /* 29EC8 800396C8 1000A627 */   addiu     $a2, $sp, 0x10
    /* 29ECC 800396CC 0580023C */  lui        $v0, %hi(menuDefs)
    /* 29ED0 800396D0 581A448C */  lw         $a0, %lo(menuDefs)($v0)
    /* 29ED4 800396D4 00000000 */  nop
    /* 29ED8 800396D8 4C0F838C */  lw         $v1, 0xF4C($a0)
    /* 29EDC 800396DC FEFF0224 */  addiu      $v0, $zero, -0x2
    /* 29EE0 800396E0 24286200 */  and        $a1, $v1, $v0
    /* 29EE4 800396E4 4C0F85AC */  sw         $a1, 0xF4C($a0)
    /* 29EE8 800396E8 03000392 */  lbu        $v1, 0x3($s0)
    /* 29EEC 800396EC 01000224 */  addiu      $v0, $zero, 0x1
    /* 29EF0 800396F0 06006210 */  beq        $v1, $v0, .L8003970C
    /* 29EF4 800396F4 02000224 */   addiu     $v0, $zero, 0x2
    /* 29EF8 800396F8 1E030392 */  lbu        $v1, 0x31E($s0)
    /* 29EFC 800396FC 00000000 */  nop
    /* 29F00 80039700 02006214 */  bne        $v1, $v0, .L8003970C
    /* 29F04 80039704 0100A234 */   ori       $v0, $a1, 0x1
    /* 29F08 80039708 4C0F82AC */  sw         $v0, 0xF4C($a0)
  .L8003970C:
    /* 29F0C 8003970C 1200A293 */  lbu        $v0, 0x12($sp)
    /* 29F10 80039710 00000000 */  nop
    /* 29F14 80039714 0300422C */  sltiu      $v0, $v0, 0x3
    /* 29F18 80039718 07004014 */  bnez       $v0, .L80039738
    /* 29F1C 8003971C 0580023C */   lui       $v0, %hi(menuDefs)
    /* 29F20 80039720 581A438C */  lw         $v1, %lo(menuDefs)($v0)
    /* 29F24 80039724 00000000 */  nop
    /* 29F28 80039728 4C0F628C */  lw         $v0, 0xF4C($v1)
    /* 29F2C 8003972C 00000000 */  nop
    /* 29F30 80039730 01004234 */  ori        $v0, $v0, 0x1
    /* 29F34 80039734 4C0F62AC */  sw         $v0, 0xF4C($v1)
  .L80039738:
    /* 29F38 80039738 1400A293 */  lbu        $v0, 0x14($sp)
    /* 29F3C 8003973C 00000000 */  nop
    /* 29F40 80039740 07004010 */  beqz       $v0, .L80039760
    /* 29F44 80039744 0580023C */   lui       $v0, %hi(menuDefs)
    /* 29F48 80039748 581A438C */  lw         $v1, %lo(menuDefs)($v0)
    /* 29F4C 8003974C 00000000 */  nop
    /* 29F50 80039750 4C0F628C */  lw         $v0, 0xF4C($v1)
    /* 29F54 80039754 00000000 */  nop
    /* 29F58 80039758 01004234 */  ori        $v0, $v0, 0x1
    /* 29F5C 8003975C 4C0F62AC */  sw         $v0, 0xF4C($v1)
  .L80039760:
    /* 29F60 80039760 1180023C */  lui        $v0, %hi(frontEnd)
    /* 29F64 80039764 00464424 */  addiu      $a0, $v0, %lo(frontEnd)
    /* 29F68 80039768 03008390 */  lbu        $v1, 0x3($a0)
    /* 29F6C 8003976C 01000224 */  addiu      $v0, $zero, 0x1
    /* 29F70 80039770 0C006214 */  bne        $v1, $v0, .L800397A4
    /* 29F74 80039774 0580023C */   lui       $v0, %hi(menuDefs)
    /* 29F78 80039778 04008290 */  lbu        $v0, 0x4($a0)
    /* 29F7C 8003977C 00000000 */  nop
    /* 29F80 80039780 08004314 */  bne        $v0, $v1, .L800397A4
    /* 29F84 80039784 0580023C */   lui       $v0, %hi(menuDefs)
    /* 29F88 80039788 581A438C */  lw         $v1, %lo(menuDefs)($v0)
    /* 29F8C 8003978C 00000000 */  nop
    /* 29F90 80039790 4C0F628C */  lw         $v0, 0xF4C($v1)
    /* 29F94 80039794 00000000 */  nop
    /* 29F98 80039798 01004234 */  ori        $v0, $v0, 0x1
    /* 29F9C 8003979C 4C0F62AC */  sw         $v0, 0xF4C($v1)
    /* 29FA0 800397A0 0580023C */  lui        $v0, %hi(menuDefs)
  .L800397A4:
    /* 29FA4 800397A4 581A438C */  lw         $v1, %lo(menuDefs)($v0)
    /* 29FA8 800397A8 00000000 */  nop
    /* 29FAC 800397AC 700F628C */  lw         $v0, 0xF70($v1)
    /* 29FB0 800397B0 00000000 */  nop
    /* 29FB4 800397B4 01004234 */  ori        $v0, $v0, 0x1
    /* 29FB8 800397B8 700F62AC */  sw         $v0, 0xF70($v1)
  .L800397BC:
    /* 29FBC 800397BC 4400BF8F */  lw         $ra, 0x44($sp)
    /* 29FC0 800397C0 4000B08F */  lw         $s0, 0x40($sp)
    /* 29FC4 800397C4 0800E003 */  jr         $ra
    /* 29FC8 800397C8 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel ProcessInput__16tScreenPinkSlips7tPlayerR13tInputKeyTypeR12tMenuCommand
