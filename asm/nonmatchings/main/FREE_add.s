.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FREE_add, 0x94

glabel FREE_add
    /* D5670 800E4E70 10008624 */  addiu      $a2, $a0, 0x10
    /* D5674 800E4E74 2138C000 */  addu       $a3, $a2, $zero
    /* D5678 800E4E78 0800A28C */  lw         $v0, 0x8($a1)
    /* D567C 800E4E7C 1400C38C */  lw         $v1, 0x14($a2)
    /* D5680 800E4E80 1000C48C */  lw         $a0, 0x10($a2)
    /* D5684 800E4E84 23104500 */  subu       $v0, $v0, $a1
    /* D5688 800E4E88 23186400 */  subu       $v1, $v1, $a0
    /* D568C 800E4E8C 42180300 */  srl        $v1, $v1, 1
    /* D5690 800E4E90 21208300 */  addu       $a0, $a0, $v1
    /* D5694 800E4E94 2B208500 */  sltu       $a0, $a0, $a1
    /* D5698 800E4E98 09008010 */  beqz       $a0, .L800E4EC0
    /* D569C 800E4E9C F0FF4824 */   addiu     $t0, $v0, -0x10
  .L800E4EA0:
    /* D56A0 800E4EA0 1400E78C */  lw         $a3, 0x14($a3)
    /* D56A4 800E4EA4 00000000 */  nop
    /* D56A8 800E4EA8 2B10A700 */  sltu       $v0, $a1, $a3
    /* D56AC 800E4EAC FCFF4014 */  bnez       $v0, .L800E4EA0
    /* D56B0 800E4EB0 00000000 */   nop
    /* D56B4 800E4EB4 1000E68C */  lw         $a2, 0x10($a3)
    /* D56B8 800E4EB8 B7930308 */  j          .L800E4EDC
    /* D56BC 800E4EBC 1000A6AC */   sw        $a2, 0x10($a1)
  .L800E4EC0:
    /* D56C0 800E4EC0 1000C68C */  lw         $a2, 0x10($a2)
    /* D56C4 800E4EC4 00000000 */  nop
    /* D56C8 800E4EC8 2B10C500 */  sltu       $v0, $a2, $a1
    /* D56CC 800E4ECC FCFF4014 */  bnez       $v0, .L800E4EC0
    /* D56D0 800E4ED0 00000000 */   nop
    /* D56D4 800E4ED4 1400C78C */  lw         $a3, 0x14($a2)
    /* D56D8 800E4ED8 1000A6AC */  sw         $a2, 0x10($a1)
  .L800E4EDC:
    /* D56DC 800E4EDC 1400A7AC */  sw         $a3, 0x14($a1)
    /* D56E0 800E4EE0 0400A8AC */  sw         $t0, 0x4($a1)
    /* D56E4 800E4EE4 1000E5AC */  sw         $a1, 0x10($a3)
    /* D56E8 800E4EE8 1400C5AC */  sw         $a1, 0x14($a2)
    /* D56EC 800E4EEC 0200A294 */  lhu        $v0, 0x2($a1)
    /* D56F0 800E4EF0 46420324 */  addiu      $v1, $zero, 0x4246
    /* D56F4 800E4EF4 0000A3A4 */  sh         $v1, 0x0($a1)
    /* D56F8 800E4EF8 00404234 */  ori        $v0, $v0, 0x4000
    /* D56FC 800E4EFC 0800E003 */  jr         $ra
    /* D5700 800E4F00 0200A2A4 */   sh        $v0, 0x2($a1)
endlabel FREE_add
