.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ProcessInput__25tScreenPinkSlipsCarSelect7tPlayerR13tInputKeyTypeR12tMenuCommand, 0xA8

glabel ProcessInput__25tScreenPinkSlipsCarSelect7tPlayerR13tInputKeyTypeR12tMenuCommand
    /* 2FD90 8003F590 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 2FD94 8003F594 1000BFAF */  sw         $ra, 0x10($sp)
    /* 2FD98 8003F598 0000C58C */  lw         $a1, 0x0($a2)
    /* 2FD9C 8003F59C 10000224 */  addiu      $v0, $zero, 0x10
    /* 2FDA0 8003F5A0 1100A210 */  beq        $a1, $v0, .L8003F5E8
    /* 2FDA4 8003F5A4 04000224 */   addiu     $v0, $zero, 0x4
    /* 2FDA8 8003F5A8 0B00A210 */  beq        $a1, $v0, .L8003F5D8
    /* 2FDAC 8003F5AC 0580023C */   lui       $v0, %hi(PinkSlipsScreenState)
    /* 2FDB0 8003F5B0 34204324 */  addiu      $v1, $v0, %lo(PinkSlipsScreenState)
    /* 2FDB4 8003F5B4 3420458C */  lw         $a1, %lo(PinkSlipsScreenState)($v0)
    /* 2FDB8 8003F5B8 06000224 */  addiu      $v0, $zero, 0x6
    /* 2FDBC 8003F5BC 0500A214 */  bne        $a1, $v0, .L8003F5D4
    /* 2FDC0 8003F5C0 01000224 */   addiu     $v0, $zero, 0x1
    /* 2FDC4 8003F5C4 0400628C */  lw         $v0, 0x4($v1)
    /* 2FDC8 8003F5C8 00000000 */  nop
    /* 2FDCC 8003F5CC 02004510 */  beq        $v0, $a1, .L8003F5D8
    /* 2FDD0 8003F5D0 01000224 */   addiu     $v0, $zero, 0x1
  .L8003F5D4:
    /* 2FDD4 8003F5D4 0000C2AC */  sw         $v0, 0x0($a2)
  .L8003F5D8:
    /* 2FDD8 8003F5D8 0000C38C */  lw         $v1, 0x0($a2)
    /* 2FDDC 8003F5DC 10000224 */  addiu      $v0, $zero, 0x10
    /* 2FDE0 8003F5E0 11006214 */  bne        $v1, $v0, .L8003F628
    /* 2FDE4 8003F5E4 00000000 */   nop
  .L8003F5E8:
    /* 2FDE8 8003F5E8 0580053C */  lui        $a1, %hi(PinkSlipsScreenState)
    /* 2FDEC 8003F5EC 3420A38C */  lw         $v1, %lo(PinkSlipsScreenState)($a1)
    /* 2FDF0 8003F5F0 06000224 */  addiu      $v0, $zero, 0x6
    /* 2FDF4 8003F5F4 05006214 */  bne        $v1, $v0, .L8003F60C
    /* 2FDF8 8003F5F8 3420A624 */   addiu     $a2, $a1, %lo(PinkSlipsScreenState)
    /* 2FDFC 8003F5FC 0400C28C */  lw         $v0, 0x4($a2)
    /* 2FE00 8003F600 00000000 */  nop
    /* 2FE04 8003F604 08004310 */  beq        $v0, $v1, .L8003F628
    /* 2FE08 8003F608 00000000 */   nop
  .L8003F60C:
    /* 2FE0C 8003F60C 01000224 */  addiu      $v0, $zero, 0x1
    /* 2FE10 8003F610 480482AC */  sw         $v0, 0x448($a0)
    /* 2FE14 8003F614 07000224 */  addiu      $v0, $zero, 0x7
    /* 2FE18 8003F618 A0038424 */  addiu      $a0, $a0, 0x3A0
    /* 2FE1C 8003F61C 3420A2AC */  sw         $v0, %lo(PinkSlipsScreenState)($a1)
    /* 2FE20 8003F620 4162000C */  jal        Hide__11tDialogBase
    /* 2FE24 8003F624 0400C2AC */   sw        $v0, 0x4($a2)
  .L8003F628:
    /* 2FE28 8003F628 1000BF8F */  lw         $ra, 0x10($sp)
    /* 2FE2C 8003F62C 00000000 */  nop
    /* 2FE30 8003F630 0800E003 */  jr         $ra
    /* 2FE34 8003F634 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ProcessInput__25tScreenPinkSlipsCarSelect7tPlayerR13tInputKeyTypeR12tMenuCommand
