.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching tPMenuConstructor__6tPMenuP10tPMenuItemPv, 0x4C

glabel tPMenuConstructor__6tPMenuP10tPMenuItemPv
    /* 9877C 800A7F7C 0400C624 */  addiu      $a2, $a2, 0x4
    /* 98780 800A7F80 080085AC */  sw         $a1, 0x8($a0)
    /* 98784 800A7F84 4C0080AC */  sw         $zero, 0x4C($a0)
    /* 98788 800A7F88 FCFFC28C */  lw         $v0, -0x4($a2)
    /* 9878C 800A7F8C 00000000 */  nop
    /* 98790 800A7F90 0B004010 */  beqz       $v0, .L800A7FC0
    /* 98794 800A7F94 0C0082AC */   sw        $v0, 0xC($a0)
    /* 98798 800A7F98 04000524 */  addiu      $a1, $zero, 0x4
  .L800A7F9C:
    /* 9879C 800A7F9C 0400A524 */  addiu      $a1, $a1, 0x4
    /* 987A0 800A7FA0 4C00828C */  lw         $v0, 0x4C($a0)
    /* 987A4 800A7FA4 0400C624 */  addiu      $a2, $a2, 0x4
    /* 987A8 800A7FA8 01004224 */  addiu      $v0, $v0, 0x1
    /* 987AC 800A7FAC 4C0082AC */  sw         $v0, 0x4C($a0)
    /* 987B0 800A7FB0 FCFFC38C */  lw         $v1, -0x4($a2)
    /* 987B4 800A7FB4 21108500 */  addu       $v0, $a0, $a1
    /* 987B8 800A7FB8 F8FF6014 */  bnez       $v1, .L800A7F9C
    /* 987BC 800A7FBC 080043AC */   sw        $v1, 0x8($v0)
  .L800A7FC0:
    /* 987C0 800A7FC0 0800E003 */  jr         $ra
    /* 987C4 800A7FC4 00000000 */   nop
endlabel tPMenuConstructor__6tPMenuP10tPMenuItemPv
