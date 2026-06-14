.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching RestoreAll__11SaveSurface, 0x6C

glabel RestoreAll__11SaveSurface
    /* AB7FC 800BAFFC 21308000 */  addu       $a2, $a0, $zero
    /* AB800 800BB000 0000C284 */  lh         $v0, 0x0($a2)
    /* AB804 800BB004 00000000 */  nop
    /* AB808 800BB008 15004018 */  blez       $v0, .L800BB060
    /* AB80C 800BB00C 21280000 */   addu      $a1, $zero, $zero
  .L800BB010:
    /* AB810 800BB010 0400C28C */  lw         $v0, 0x4($a2)
    /* AB814 800BB014 C0200500 */  sll        $a0, $a1, 3
    /* AB818 800BB018 21108200 */  addu       $v0, $a0, $v0
    /* AB81C 800BB01C 0000438C */  lw         $v1, 0x0($v0)
    /* AB820 800BB020 04004290 */  lbu        $v0, 0x4($v0)
    /* AB824 800BB024 00000000 */  nop
    /* AB828 800BB028 000062A0 */  sb         $v0, 0x0($v1)
    /* AB82C 800BB02C 0400C28C */  lw         $v0, 0x4($a2)
    /* AB830 800BB030 00000000 */  nop
    /* AB834 800BB034 21108200 */  addu       $v0, $a0, $v0
    /* AB838 800BB038 000040AC */  sw         $zero, 0x0($v0)
    /* AB83C 800BB03C 0400C28C */  lw         $v0, 0x4($a2)
    /* AB840 800BB040 00000000 */  nop
    /* AB844 800BB044 21208200 */  addu       $a0, $a0, $v0
    /* AB848 800BB048 040080A0 */  sb         $zero, 0x4($a0)
    /* AB84C 800BB04C 0000C284 */  lh         $v0, 0x0($a2)
    /* AB850 800BB050 0100A524 */  addiu      $a1, $a1, 0x1
    /* AB854 800BB054 2A10A200 */  slt        $v0, $a1, $v0
    /* AB858 800BB058 EDFF4014 */  bnez       $v0, .L800BB010
    /* AB85C 800BB05C 00000000 */   nop
  .L800BB060:
    /* AB860 800BB060 0800E003 */  jr         $ra
    /* AB864 800BB064 0000C0A4 */   sh        $zero, 0x0($a2)
endlabel RestoreAll__11SaveSurface
