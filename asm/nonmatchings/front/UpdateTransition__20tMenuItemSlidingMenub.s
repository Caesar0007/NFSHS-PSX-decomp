.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching UpdateTransition__20tMenuItemSlidingMenub, 0x7C

glabel UpdateTransition__20tMenuItemSlidingMenub
    /* DB1C 8001D31C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* DB20 8001D320 1000B0AF */  sw         $s0, 0x10($sp)
    /* DB24 8001D324 21808000 */  addu       $s0, $a0, $zero
    /* DB28 8001D328 1800BFAF */  sw         $ra, 0x18($sp)
    /* DB2C 8001D32C 1400B1AF */  sw         $s1, 0x14($sp)
    /* DB30 8001D330 2C000286 */  lh         $v0, 0x2C($s0)
    /* DB34 8001D334 2E000386 */  lh         $v1, 0x2E($s0)
    /* DB38 8001D338 00000000 */  nop
    /* DB3C 8001D33C 21184300 */  addu       $v1, $v0, $v1
    /* DB40 8001D340 81006228 */  slti       $v0, $v1, 0x81
    /* DB44 8001D344 02004014 */  bnez       $v0, .L8001D350
    /* DB48 8001D348 2188A000 */   addu      $s1, $a1, $zero
    /* DB4C 8001D34C 80000324 */  addiu      $v1, $zero, 0x80
  .L8001D350:
    /* DB50 8001D350 02006104 */  bgez       $v1, .L8001D35C
    /* DB54 8001D354 00000000 */   nop
    /* DB58 8001D358 21180000 */  addu       $v1, $zero, $zero
  .L8001D35C:
    /* DB5C 8001D35C 1800028E */  lw         $v0, 0x18($s0)
    /* DB60 8001D360 2C0003A6 */  sh         $v1, 0x2C($s0)
    /* DB64 8001D364 48004484 */  lh         $a0, 0x48($v0)
    /* DB68 8001D368 4C00428C */  lw         $v0, 0x4C($v0)
    /* DB6C 8001D36C 00000000 */  nop
    /* DB70 8001D370 09F84000 */  jalr       $v0
    /* DB74 8001D374 21200402 */   addu      $a0, $s0, $a0
    /* DB78 8001D378 21200002 */  addu       $a0, $s0, $zero
    /* DB7C 8001D37C EA91000C */  jal        UpdateTransition__9tMenuItemb
    /* DB80 8001D380 21282002 */   addu      $a1, $s1, $zero
    /* DB84 8001D384 1800BF8F */  lw         $ra, 0x18($sp)
    /* DB88 8001D388 1400B18F */  lw         $s1, 0x14($sp)
    /* DB8C 8001D38C 1000B08F */  lw         $s0, 0x10($sp)
    /* DB90 8001D390 0800E003 */  jr         $ra
    /* DB94 8001D394 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel UpdateTransition__20tMenuItemSlidingMenub
