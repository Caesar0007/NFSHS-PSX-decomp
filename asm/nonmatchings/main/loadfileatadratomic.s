.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching loadfileatadratomic, 0x80

glabel loadfileatadratomic
    /* D6030 800E5830 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* D6034 800E5834 2000B0AF */  sw         $s0, 0x20($sp)
    /* D6038 800E5838 21808000 */  addu       $s0, $a0, $zero
    /* D603C 800E583C 2110A000 */  addu       $v0, $a1, $zero
    /* D6040 800E5840 01000524 */  addiu      $a1, $zero, 0x1
    /* D6044 800E5844 21300002 */  addu       $a2, $s0, $zero
    /* D6048 800E5848 1800A727 */  addiu      $a3, $sp, 0x18
    /* D604C 800E584C 2800BFAF */  sw         $ra, 0x28($sp)
    /* D6050 800E5850 2400B1AF */  sw         $s1, 0x24($sp)
    /* D6054 800E5854 0000448C */  lw         $a0, 0x0($v0)
    /* D6058 800E5858 2AAA030C */  jal        FILE_opensync
    /* D605C 800E585C 21884000 */   addu      $s1, $v0, $zero
    /* D6060 800E5860 03004014 */  bnez       $v0, .L800E5870
    /* D6064 800E5864 21280000 */   addu      $a1, $zero, $zero
    /* D6068 800E5868 27960308 */  j          .L800E589C
    /* D606C 800E586C 21100000 */   addu      $v0, $zero, $zero
  .L800E5870:
    /* D6070 800E5870 FF7F073C */  lui        $a3, (0x7FFFFFFF >> 16)
    /* D6074 800E5874 1800A48F */  lw         $a0, 0x18($sp)
    /* D6078 800E5878 FFFF1026 */  addiu      $s0, $s0, -0x1
    /* D607C 800E587C 1000B0AF */  sw         $s0, 0x10($sp)
    /* D6080 800E5880 0400268E */  lw         $a2, 0x4($s1)
    /* D6084 800E5884 48AA030C */  jal        FILE_readsync
    /* D6088 800E5888 FFFFE734 */   ori       $a3, $a3, (0x7FFFFFFF & 0xFFFF)
    /* D608C 800E588C 1800A48F */  lw         $a0, 0x18($sp)
    /* D6090 800E5890 54AA030C */  jal        FILE_closesync
    /* D6094 800E5894 21280002 */   addu      $a1, $s0, $zero
    /* D6098 800E5898 0400228E */  lw         $v0, 0x4($s1)
  .L800E589C:
    /* D609C 800E589C 2800BF8F */  lw         $ra, 0x28($sp)
    /* D60A0 800E58A0 2400B18F */  lw         $s1, 0x24($sp)
    /* D60A4 800E58A4 2000B08F */  lw         $s0, 0x20($sp)
    /* D60A8 800E58A8 0800E003 */  jr         $ra
    /* D60AC 800E58AC 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel loadfileatadratomic
