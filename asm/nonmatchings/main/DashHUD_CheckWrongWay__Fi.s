.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DashHUD_CheckWrongWay__Fi, 0x70

glabel DashHUD_CheckWrongWay__Fi
    /* 8B898 8009B098 1180033C */  lui        $v1, %hi(Camera_gInfo)
    /* 8B89C 8009B09C ACF26324 */  addiu      $v1, $v1, %lo(Camera_gInfo)
    /* 8B8A0 8009B0A0 00110400 */  sll        $v0, $a0, 4
    /* 8B8A4 8009B0A4 21104400 */  addu       $v0, $v0, $a0
    /* 8B8A8 8009B0A8 00110200 */  sll        $v0, $v0, 4
    /* 8B8AC 8009B0AC 21104300 */  addu       $v0, $v0, $v1
    /* 8B8B0 8009B0B0 0000428C */  lw         $v0, 0x0($v0)
    /* 8B8B4 8009B0B4 00000000 */  nop
    /* 8B8B8 8009B0B8 F003438C */  lw         $v1, 0x3F0($v0)
    /* 8B8BC 8009B0BC 00000000 */  nop
    /* 8B8C0 8009B0C0 40006228 */  slti       $v0, $v1, 0x40
    /* 8B8C4 8009B0C4 05004014 */  bnez       $v0, .L8009B0DC
    /* 8B8C8 8009B0C8 21280000 */   addu      $a1, $zero, $zero
    /* 8B8CC 8009B0CC 94006228 */  slti       $v0, $v1, 0x94
    /* 8B8D0 8009B0D0 02004010 */  beqz       $v0, .L8009B0DC
    /* 8B8D4 8009B0D4 02000524 */   addiu     $a1, $zero, 0x2
    /* 8B8D8 8009B0D8 01000524 */  addiu      $a1, $zero, 0x1
  .L8009B0DC:
    /* 8B8DC 8009B0DC 1180023C */  lui        $v0, %hi(DashHUD_gInfo)
    /* 8B8E0 8009B0E0 30274224 */  addiu      $v0, $v0, %lo(DashHUD_gInfo)
    /* 8B8E4 8009B0E4 80180400 */  sll        $v1, $a0, 2
    /* 8B8E8 8009B0E8 21186200 */  addu       $v1, $v1, $v0
    /* 8B8EC 8009B0EC 2C00628C */  lw         $v0, 0x2C($v1)
    /* 8B8F0 8009B0F0 00000000 */  nop
    /* 8B8F4 8009B0F4 0200A210 */  beq        $a1, $v0, .L8009B100
    /* 8B8F8 8009B0F8 00000000 */   nop
    /* 8B8FC 8009B0FC 2C0065AC */  sw         $a1, 0x2C($v1)
  .L8009B100:
    /* 8B900 8009B100 0800E003 */  jr         $ra
    /* 8B904 8009B104 00000000 */   nop
endlabel DashHUD_CheckWrongWay__Fi
