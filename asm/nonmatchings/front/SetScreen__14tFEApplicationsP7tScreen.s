.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SetScreen__14tFEApplicationsP7tScreen, 0x50

glabel SetScreen__14tFEApplicationsP7tScreen
    /* 4724 80013F24 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 4728 80013F28 002C0500 */  sll        $a1, $a1, 16
    /* 472C 80013F2C 832B0500 */  sra        $a1, $a1, 14
    /* 4730 80013F30 21208500 */  addu       $a0, $a0, $a1
    /* 4734 80013F34 1000BFAF */  sw         $ra, 0x10($sp)
    /* 4738 80013F38 0C00828C */  lw         $v0, 0xC($a0)
    /* 473C 80013F3C 00000000 */  nop
    /* 4740 80013F40 0800C210 */  beq        $a2, $v0, .L80013F64
    /* 4744 80013F44 00000000 */   nop
    /* 4748 80013F48 06004010 */  beqz       $v0, .L80013F64
    /* 474C 80013F4C 1C0086AC */   sw        $a2, 0x1C($a0)
    /* 4750 80013F50 0400C010 */  beqz       $a2, .L80013F64
    /* 4754 80013F54 21204000 */   addu      $a0, $v0, $zero
    /* 4758 80013F58 02000524 */  addiu      $a1, $zero, 0x2
    /* 475C 80013F5C 019A000C */  jal        TransitionOff__7tScreen22tScreen_TransitionTypeP5tMenu
    /* 4760 80013F60 21300000 */   addu      $a2, $zero, $zero
  .L80013F64:
    /* 4764 80013F64 1000BF8F */  lw         $ra, 0x10($sp)
    /* 4768 80013F68 00000000 */  nop
    /* 476C 80013F6C 0800E003 */  jr         $ra
    /* 4770 80013F70 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel SetScreen__14tFEApplicationsP7tScreen
