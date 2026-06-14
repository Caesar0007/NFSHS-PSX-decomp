.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MEM_tailsize, 0x64

glabel MEM_tailsize
    /* D5830 800E5030 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* D5834 800E5034 1480023C */  lui        $v0, %hi(memclass)
    /* D5838 800E5038 00E94224 */  addiu      $v0, $v0, %lo(memclass)
    /* D583C 800E503C 0F00A530 */  andi       $a1, $a1, 0xF
    /* D5840 800E5040 80280500 */  sll        $a1, $a1, 2
    /* D5844 800E5044 2128A200 */  addu       $a1, $a1, $v0
    /* D5848 800E5048 1400BFAF */  sw         $ra, 0x14($sp)
    /* D584C 800E504C 1000B0AF */  sw         $s0, 0x10($sp)
    /* D5850 800E5050 0000B08C */  lw         $s0, 0x0($a1)
    /* D5854 800E5054 09008010 */  beqz       $a0, .L800E507C
    /* D5858 800E5058 21180000 */   addu      $v1, $zero, $zero
    /* D585C 800E505C 3400028E */  lw         $v0, 0x34($s0)
    /* D5860 800E5060 00000000 */  nop
    /* D5864 800E5064 00014230 */  andi       $v0, $v0, 0x100
    /* D5868 800E5068 04004010 */  beqz       $v0, .L800E507C
    /* D586C 800E506C 00000000 */   nop
    /* D5870 800E5070 DDA7030C */  jal        strlen
    /* D5874 800E5074 00000000 */   nop
    /* D5878 800E5078 01004324 */  addiu      $v1, $v0, 0x1
  .L800E507C:
    /* D587C 800E507C 3000028E */  lw         $v0, 0x30($s0)
    /* D5880 800E5080 1400BF8F */  lw         $ra, 0x14($sp)
    /* D5884 800E5084 1000B08F */  lw         $s0, 0x10($sp)
    /* D5888 800E5088 21104300 */  addu       $v0, $v0, $v1
    /* D588C 800E508C 0800E003 */  jr         $ra
    /* D5890 800E5090 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel MEM_tailsize
