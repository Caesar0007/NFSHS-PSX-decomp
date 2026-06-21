.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching UpdateTransition__27tMenuItemGoToMenuButtonFadeb, 0x7C

glabel UpdateTransition__27tMenuItemGoToMenuButtonFadeb
    /* CADC 8001C2DC E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* CAE0 8001C2E0 1000B0AF */  sw         $s0, 0x10($sp)
    /* CAE4 8001C2E4 21808000 */  addu       $s0, $a0, $zero
    /* CAE8 8001C2E8 1800BFAF */  sw         $ra, 0x18($sp)
    /* CAEC 8001C2EC 1400B1AF */  sw         $s1, 0x14($sp)
    /* CAF0 8001C2F0 20000286 */  lh         $v0, 0x20($s0)
    /* CAF4 8001C2F4 22000386 */  lh         $v1, 0x22($s0)
    /* CAF8 8001C2F8 00000000 */  nop
    /* CAFC 8001C2FC 21184300 */  addu       $v1, $v0, $v1
    /* CB00 8001C300 81006228 */  slti       $v0, $v1, 0x81
    /* CB04 8001C304 02004014 */  bnez       $v0, .L8001C310
    /* CB08 8001C308 2188A000 */   addu      $s1, $a1, $zero
    /* CB0C 8001C30C 80000324 */  addiu      $v1, $zero, 0x80
  .L8001C310:
    /* CB10 8001C310 02006104 */  bgez       $v1, .L8001C31C
    /* CB14 8001C314 00000000 */   nop
    /* CB18 8001C318 21180000 */  addu       $v1, $zero, $zero
  .L8001C31C:
    /* CB1C 8001C31C 1800028E */  lw         $v0, 0x18($s0)
    /* CB20 8001C320 200003A6 */  sh         $v1, 0x20($s0)
    /* CB24 8001C324 48004484 */  lh         $a0, 0x48($v0)
    /* CB28 8001C328 4C00428C */  lw         $v0, 0x4C($v0)
    /* CB2C 8001C32C 00000000 */  nop
    /* CB30 8001C330 09F84000 */  jalr       $v0
    /* CB34 8001C334 21200402 */   addu      $a0, $s0, $a0
    /* CB38 8001C338 21200002 */  addu       $a0, $s0, $zero
    /* CB3C 8001C33C EA91000C */  jal        UpdateTransition__9tMenuItemb
    /* CB40 8001C340 21282002 */   addu      $a1, $s1, $zero
    /* CB44 8001C344 1800BF8F */  lw         $ra, 0x18($sp)
    /* CB48 8001C348 1400B18F */  lw         $s1, 0x14($sp)
    /* CB4C 8001C34C 1000B08F */  lw         $s0, 0x10($sp)
    /* CB50 8001C350 0800E003 */  jr         $ra
    /* CB54 8001C354 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel UpdateTransition__27tMenuItemGoToMenuButtonFadeb
