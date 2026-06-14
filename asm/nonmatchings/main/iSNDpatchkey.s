.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDpatchkey, 0x104

glabel iSNDpatchkey
    /* EF74C 800FEF4C 1480023C */  lui        $v0, %hi(sndgs)
    /* EF750 800FEF50 60784724 */  addiu      $a3, $v0, %lo(sndgs)
    /* EF754 800FEF54 40100400 */  sll        $v0, $a0, 1
    /* EF758 800FEF58 21104400 */  addu       $v0, $v0, $a0
    /* EF75C 800FEF5C C0100200 */  sll        $v0, $v0, 3
    /* EF760 800FEF60 21104400 */  addu       $v0, $v0, $a0
    /* EF764 800FEF64 9400E38C */  lw         $v1, 0x94($a3)
    /* EF768 800FEF68 80100200 */  sll        $v0, $v0, 2
    /* EF76C 800FEF6C 21186200 */  addu       $v1, $v1, $v0
    /* EF770 800FEF70 37006690 */  lbu        $a2, 0x37($v1)
    /* EF774 800FEF74 00000000 */  nop
    /* EF778 800FEF78 2B00C010 */  beqz       $a2, .L800FF028
    /* EF77C 800FEF7C 00000000 */   nop
    /* EF780 800FEF80 0000A28C */  lw         $v0, 0x0($a1)
    /* EF784 800FEF84 00000000 */  nop
    /* EF788 800FEF88 01004224 */  addiu      $v0, $v0, 0x1
    /* EF78C 800FEF8C 0000A2AC */  sw         $v0, 0x0($a1)
    /* EF790 800FEF90 1100E390 */  lbu        $v1, 0x11($a3)
    /* EF794 800FEF94 00000000 */  nop
    /* EF798 800FEF98 2A104300 */  slt        $v0, $v0, $v1
    /* EF79C 800FEF9C 29004010 */  beqz       $v0, .L800FF044
    /* EF7A0 800FEFA0 2120E000 */   addu      $a0, $a3, $zero
    /* EF7A4 800FEFA4 01000724 */  addiu      $a3, $zero, 0x1
  .L800FEFA8:
    /* EF7A8 800FEFA8 0000A38C */  lw         $v1, 0x0($a1)
    /* EF7AC 800FEFAC 00000000 */  nop
    /* EF7B0 800FEFB0 40100300 */  sll        $v0, $v1, 1
    /* EF7B4 800FEFB4 21104300 */  addu       $v0, $v0, $v1
    /* EF7B8 800FEFB8 C0100200 */  sll        $v0, $v0, 3
    /* EF7BC 800FEFBC 21104300 */  addu       $v0, $v0, $v1
    /* EF7C0 800FEFC0 9400838C */  lw         $v1, 0x94($a0)
    /* EF7C4 800FEFC4 80100200 */  sll        $v0, $v0, 2
    /* EF7C8 800FEFC8 21186200 */  addu       $v1, $v1, $v0
    /* EF7CC 800FEFCC 37006290 */  lbu        $v0, 0x37($v1)
    /* EF7D0 800FEFD0 00000000 */  nop
    /* EF7D4 800FEFD4 09004614 */  bne        $v0, $a2, .L800FEFFC
    /* EF7D8 800FEFD8 00000000 */   nop
    /* EF7DC 800FEFDC 0B006280 */  lb         $v0, 0xB($v1)
    /* EF7E0 800FEFE0 00000000 */  nop
    /* EF7E4 800FEFE4 05004714 */  bne        $v0, $a3, .L800FEFFC
    /* EF7E8 800FEFE8 00000000 */   nop
    /* EF7EC 800FEFEC 0000628C */  lw         $v0, 0x0($v1)
    /* EF7F0 800FEFF0 00000000 */  nop
    /* EF7F4 800FEFF4 11004104 */  bgez       $v0, .L800FF03C
    /* EF7F8 800FEFF8 00000000 */   nop
  .L800FEFFC:
    /* EF7FC 800FEFFC 0000A28C */  lw         $v0, 0x0($a1)
    /* EF800 800FF000 00000000 */  nop
    /* EF804 800FF004 01004224 */  addiu      $v0, $v0, 0x1
    /* EF808 800FF008 0000A2AC */  sw         $v0, 0x0($a1)
    /* EF80C 800FF00C 11008390 */  lbu        $v1, 0x11($a0)
    /* EF810 800FF010 00000000 */  nop
    /* EF814 800FF014 2A104300 */  slt        $v0, $v0, $v1
    /* EF818 800FF018 E3FF4014 */  bnez       $v0, .L800FEFA8
    /* EF81C 800FF01C 21100000 */   addu      $v0, $zero, $zero
    /* EF820 800FF020 12FC0308 */  j          .L800FF048
    /* EF824 800FF024 00000000 */   nop
  .L800FF028:
    /* EF828 800FF028 0000A28C */  lw         $v0, 0x0($a1)
    /* EF82C 800FF02C 00000000 */  nop
    /* EF830 800FF030 05004104 */  bgez       $v0, .L800FF048
    /* EF834 800FF034 21100000 */   addu      $v0, $zero, $zero
    /* EF838 800FF038 0000A4AC */  sw         $a0, 0x0($a1)
  .L800FF03C:
    /* EF83C 800FF03C 0800E003 */  jr         $ra
    /* EF840 800FF040 01000224 */   addiu     $v0, $zero, 0x1
  .L800FF044:
    /* EF844 800FF044 21100000 */  addu       $v0, $zero, $zero
  .L800FF048:
    /* EF848 800FF048 0800E003 */  jr         $ra
    /* EF84C 800FF04C 00000000 */   nop
endlabel iSNDpatchkey
