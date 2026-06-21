.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetNumberEnabledItems__5tMenu, 0x68

glabel GetNumberEnabledItems__5tMenu
    /* 16094 80025894 0C00828C */  lw         $v0, 0xC($a0)
    /* 16098 80025898 00000000 */  nop
    /* 1609C 8002589C 03004010 */  beqz       $v0, .L800258AC
    /* 160A0 800258A0 21280000 */   addu      $a1, $zero, $zero
    /* 160A4 800258A4 0800E003 */  jr         $ra
    /* 160A8 800258A8 21100000 */   addu      $v0, $zero, $zero
  .L800258AC:
    /* 160AC 800258AC 2118A000 */  addu       $v1, $a1, $zero
  .L800258B0:
    /* 160B0 800258B0 00140300 */  sll        $v0, $v1, 16
    /* 160B4 800258B4 83130200 */  sra        $v0, $v0, 14
    /* 160B8 800258B8 21108200 */  addu       $v0, $a0, $v0
    /* 160BC 800258BC 1000428C */  lw         $v0, 0x10($v0)
    /* 160C0 800258C0 00000000 */  nop
    /* 160C4 800258C4 0A004010 */  beqz       $v0, .L800258F0
    /* 160C8 800258C8 00000000 */   nop
    /* 160CC 800258CC 0000428C */  lw         $v0, 0x0($v0)
    /* 160D0 800258D0 00000000 */  nop
    /* 160D4 800258D4 01004238 */  xori       $v0, $v0, 0x1
    /* 160D8 800258D8 01004230 */  andi       $v0, $v0, 0x1
    /* 160DC 800258DC 02004010 */  beqz       $v0, .L800258E8
    /* 160E0 800258E0 00000000 */   nop
    /* 160E4 800258E4 0100A524 */  addiu      $a1, $a1, 0x1
  .L800258E8:
    /* 160E8 800258E8 2C960008 */  j          .L800258B0
    /* 160EC 800258EC 01006324 */   addiu     $v1, $v1, 0x1
  .L800258F0:
    /* 160F0 800258F0 00140500 */  sll        $v0, $a1, 16
    /* 160F4 800258F4 0800E003 */  jr         $ra
    /* 160F8 800258F8 03140200 */   sra       $v0, $v0, 16
endlabel GetNumberEnabledItems__5tMenu
