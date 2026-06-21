.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ValidTrack__18tListIteratorTrackc, 0xA8

glabel ValidTrack__18tListIteratorTrackc
    /* 12750 80021F50 FF00A530 */  andi       $a1, $a1, 0xFF
    /* 12754 80021F54 40100500 */  sll        $v0, $a1, 1
    /* 12758 80021F58 1400848C */  lw         $a0, 0x14($a0)
    /* 1275C 80021F5C 21104500 */  addu       $v0, $v0, $a1
    /* 12760 80021F60 0400838C */  lw         $v1, 0x4($a0)
    /* 12764 80021F64 00110200 */  sll        $v0, $v0, 4
    /* 12768 80021F68 21186200 */  addu       $v1, $v1, $v0
    /* 1276C 80021F6C 00006280 */  lb         $v0, 0x0($v1)
    /* 12770 80021F70 00000000 */  nop
    /* 12774 80021F74 80100200 */  sll        $v0, $v0, 2
    /* 12778 80021F78 21208200 */  addu       $a0, $a0, $v0
    /* 1277C 80021F7C 1180023C */  lui        $v0, %hi(D_80114604)
    /* 12780 80021F80 04464690 */  lbu        $a2, %lo(D_80114604)($v0)
    /* 12784 80021F84 0800858C */  lw         $a1, 0x8($a0)
    /* 12788 80021F88 0500C010 */  beqz       $a2, .L80021FA0
    /* 1278C 80021F8C 01000224 */   addiu     $v0, $zero, 0x1
    /* 12790 80021F90 0800C210 */  beq        $a2, $v0, .L80021FB4
    /* 12794 80021F94 2110A000 */   addu      $v0, $a1, $zero
    /* 12798 80021F98 FC870008 */  j          .L80021FF0
    /* 1279C 80021F9C 00000000 */   nop
  .L80021FA0:
    /* 127A0 80021FA0 4800828C */  lw         $v0, 0x48($a0)
    /* 127A4 80021FA4 00000000 */  nop
    /* 127A8 80021FA8 2528A200 */  or         $a1, $a1, $v0
    /* 127AC 80021FAC FB870008 */  j          .L80021FEC
    /* 127B0 80021FB0 2B280500 */   sltu      $a1, $zero, $a1
  .L80021FB4:
    /* 127B4 80021FB4 4800828C */  lw         $v0, 0x48($a0)
    /* 127B8 80021FB8 00000000 */  nop
    /* 127BC 80021FBC 2528A200 */  or         $a1, $a1, $v0
    /* 127C0 80021FC0 04006290 */  lbu        $v0, 0x4($v1)
    /* 127C4 80021FC4 00000000 */  nop
    /* 127C8 80021FC8 02004010 */  beqz       $v0, .L80021FD4
    /* 127CC 80021FCC 2B280500 */   sltu      $a1, $zero, $a1
    /* 127D0 80021FD0 21280000 */  addu       $a1, $zero, $zero
  .L80021FD4:
    /* 127D4 80021FD4 02006290 */  lbu        $v0, 0x2($v1)
    /* 127D8 80021FD8 00000000 */  nop
    /* 127DC 80021FDC 0300422C */  sltiu      $v0, $v0, 0x3
    /* 127E0 80021FE0 03004014 */  bnez       $v0, .L80021FF0
    /* 127E4 80021FE4 2110A000 */   addu      $v0, $a1, $zero
    /* 127E8 80021FE8 21280000 */  addu       $a1, $zero, $zero
  .L80021FEC:
    /* 127EC 80021FEC 2110A000 */  addu       $v0, $a1, $zero
  .L80021FF0:
    /* 127F0 80021FF0 0800E003 */  jr         $ra
    /* 127F4 80021FF4 00000000 */   nop
endlabel ValidTrack__18tListIteratorTrackc
