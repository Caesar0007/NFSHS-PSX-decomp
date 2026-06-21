.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ProcessInput__16tScreenTrackInfo7tPlayerR13tInputKeyTypeR12tMenuCommand, 0x9C

glabel ProcessInput__16tScreenTrackInfo7tPlayerR13tInputKeyTypeR12tMenuCommand
    /* 32D8C 8004258C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 32D90 80042590 1000BFAF */  sw         $ra, 0x10($sp)
    /* 32D94 80042594 0000C38C */  lw         $v1, 0x0($a2)
    /* 32D98 80042598 10000224 */  addiu      $v0, $zero, 0x10
    /* 32D9C 8004259C 1E006214 */  bne        $v1, $v0, .L80042618
    /* 32DA0 800425A0 00000000 */   nop
    /* 32DA4 800425A4 9FDB000C */  jal        TurnOffInstant__10tVideoWall
    /* 32DA8 800425A8 6C028424 */   addiu     $a0, $a0, 0x26C
    /* 32DAC 800425AC 1180023C */  lui        $v0, %hi(tournamentManager)
    /* 32DB0 800425B0 D84A4524 */  addiu      $a1, $v0, %lo(tournamentManager)
    /* 32DB4 800425B4 0C00A28C */  lw         $v0, 0xC($a1)
    /* 32DB8 800425B8 00000000 */  nop
    /* 32DBC 800425BC 16004014 */  bnez       $v0, .L80042618
    /* 32DC0 800425C0 00000000 */   nop
    /* 32DC4 800425C4 0400A38C */  lw         $v1, 0x4($a1)
    /* 32DC8 800425C8 1800A48C */  lw         $a0, 0x18($a1)
    /* 32DCC 800425CC 40100300 */  sll        $v0, $v1, 1
    /* 32DD0 800425D0 21104300 */  addu       $v0, $v0, $v1
    /* 32DD4 800425D4 80100200 */  sll        $v0, $v0, 2
    /* 32DD8 800425D8 21108200 */  addu       $v0, $a0, $v0
    /* 32DDC 800425DC 02004390 */  lbu        $v1, 0x2($v0)
    /* 32DE0 800425E0 0800A28C */  lw         $v0, 0x8($a1)
    /* 32DE4 800425E4 00000000 */  nop
    /* 32DE8 800425E8 21186200 */  addu       $v1, $v1, $v0
    /* 32DEC 800425EC 80100300 */  sll        $v0, $v1, 2
    /* 32DF0 800425F0 21104300 */  addu       $v0, $v0, $v1
    /* 32DF4 800425F4 80100200 */  sll        $v0, $v0, 2
    /* 32DF8 800425F8 21104300 */  addu       $v0, $v0, $v1
    /* 32DFC 800425FC 80100200 */  sll        $v0, $v0, 2
    /* 32E00 80042600 21104400 */  addu       $v0, $v0, $a0
    /* 32E04 80042604 5400438C */  lw         $v1, 0x54($v0)
    /* 32E08 80042608 1400A28C */  lw         $v0, 0x14($a1)
    /* 32E0C 8004260C 00000000 */  nop
    /* 32E10 80042610 21104300 */  addu       $v0, $v0, $v1
    /* 32E14 80042614 1400A2AC */  sw         $v0, 0x14($a1)
  .L80042618:
    /* 32E18 80042618 1000BF8F */  lw         $ra, 0x10($sp)
    /* 32E1C 8004261C 00000000 */  nop
    /* 32E20 80042620 0800E003 */  jr         $ra
    /* 32E24 80042624 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ProcessInput__16tScreenTrackInfo7tPlayerR13tInputKeyTypeR12tMenuCommand
