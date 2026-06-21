.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ProcessInput__20tMenuItemSlidingMenu7tPlayerR13tInputKeyTypeR12tMenuCommand, 0xA8

glabel ProcessInput__20tMenuItemSlidingMenu7tPlayerR13tInputKeyTypeR12tMenuCommand
    /* E480 8001DC80 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* E484 8001DC84 1000B0AF */  sw         $s0, 0x10($sp)
    /* E488 8001DC88 21808000 */  addu       $s0, $a0, $zero
    /* E48C 8001DC8C 1800B2AF */  sw         $s2, 0x18($sp)
    /* E490 8001DC90 2190A000 */  addu       $s2, $a1, $zero
    /* E494 8001DC94 1400B1AF */  sw         $s1, 0x14($sp)
    /* E498 8001DC98 2188C000 */  addu       $s1, $a2, $zero
    /* E49C 8001DC9C 2000BFAF */  sw         $ra, 0x20($sp)
    /* E4A0 8001DCA0 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* E4A4 8001DCA4 28000386 */  lh         $v1, 0x28($s0)
    /* E4A8 8001DCA8 26000286 */  lh         $v0, 0x26($s0)
    /* E4AC 8001DCAC 00000000 */  nop
    /* E4B0 8001DCB0 0C006214 */  bne        $v1, $v0, .L8001DCE4
    /* E4B4 8001DCB4 2198E000 */   addu      $s3, $a3, $zero
    /* E4B8 8001DCB8 1C00038E */  lw         $v1, 0x1C($s0)
    /* E4BC 8001DCBC 00000000 */  nop
    /* E4C0 8001DCC0 08006010 */  beqz       $v1, .L8001DCE4
    /* E4C4 8001DCC4 00000000 */   nop
    /* E4C8 8001DCC8 6800628C */  lw         $v0, 0x68($v1)
    /* E4CC 8001DCCC 00000000 */  nop
    /* E4D0 8001DCD0 18004484 */  lh         $a0, 0x18($v0)
    /* E4D4 8001DCD4 1C00428C */  lw         $v0, 0x1C($v0)
    /* E4D8 8001DCD8 00000000 */  nop
    /* E4DC 8001DCDC 09F84000 */  jalr       $v0
    /* E4E0 8001DCE0 21206400 */   addu      $a0, $v1, $a0
  .L8001DCE4:
    /* E4E4 8001DCE4 0000238E */  lw         $v1, 0x0($s1)
    /* E4E8 8001DCE8 00040224 */  addiu      $v0, $zero, 0x400
    /* E4EC 8001DCEC 03006214 */  bne        $v1, $v0, .L8001DCFC
    /* E4F0 8001DCF0 21200002 */   addu      $a0, $s0, $zero
    /* E4F4 8001DCF4 01000224 */  addiu      $v0, $zero, 0x1
    /* E4F8 8001DCF8 000022AE */  sw         $v0, 0x0($s1)
  .L8001DCFC:
    /* E4FC 8001DCFC 21284002 */  addu       $a1, $s2, $zero
    /* E500 8001DD00 21302002 */  addu       $a2, $s1, $zero
    /* E504 8001DD04 E891000C */  jal        ProcessInput__9tMenuItem7tPlayerR13tInputKeyTypeR12tMenuCommand
    /* E508 8001DD08 21386002 */   addu      $a3, $s3, $zero
    /* E50C 8001DD0C 2000BF8F */  lw         $ra, 0x20($sp)
    /* E510 8001DD10 1C00B38F */  lw         $s3, 0x1C($sp)
    /* E514 8001DD14 1800B28F */  lw         $s2, 0x18($sp)
    /* E518 8001DD18 1400B18F */  lw         $s1, 0x14($sp)
    /* E51C 8001DD1C 1000B08F */  lw         $s0, 0x10($sp)
    /* E520 8001DD20 0800E003 */  jr         $ra
    /* E524 8001DD24 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel ProcessInput__20tMenuItemSlidingMenu7tPlayerR13tInputKeyTypeR12tMenuCommand
