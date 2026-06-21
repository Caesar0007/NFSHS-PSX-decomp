.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching UpdateTransition__22tMenuItemLeftRightFadeb, 0x7C

glabel UpdateTransition__22tMenuItemLeftRightFadeb
    /* CC38 8001C438 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* CC3C 8001C43C 1000B0AF */  sw         $s0, 0x10($sp)
    /* CC40 8001C440 21808000 */  addu       $s0, $a0, $zero
    /* CC44 8001C444 1800BFAF */  sw         $ra, 0x18($sp)
    /* CC48 8001C448 1400B1AF */  sw         $s1, 0x14($sp)
    /* CC4C 8001C44C 20000286 */  lh         $v0, 0x20($s0)
    /* CC50 8001C450 22000386 */  lh         $v1, 0x22($s0)
    /* CC54 8001C454 00000000 */  nop
    /* CC58 8001C458 21184300 */  addu       $v1, $v0, $v1
    /* CC5C 8001C45C 81006228 */  slti       $v0, $v1, 0x81
    /* CC60 8001C460 02004014 */  bnez       $v0, .L8001C46C
    /* CC64 8001C464 2188A000 */   addu      $s1, $a1, $zero
    /* CC68 8001C468 80000324 */  addiu      $v1, $zero, 0x80
  .L8001C46C:
    /* CC6C 8001C46C 02006104 */  bgez       $v1, .L8001C478
    /* CC70 8001C470 00000000 */   nop
    /* CC74 8001C474 21180000 */  addu       $v1, $zero, $zero
  .L8001C478:
    /* CC78 8001C478 1800028E */  lw         $v0, 0x18($s0)
    /* CC7C 8001C47C 200003A6 */  sh         $v1, 0x20($s0)
    /* CC80 8001C480 48004484 */  lh         $a0, 0x48($v0)
    /* CC84 8001C484 4C00428C */  lw         $v0, 0x4C($v0)
    /* CC88 8001C488 00000000 */  nop
    /* CC8C 8001C48C 09F84000 */  jalr       $v0
    /* CC90 8001C490 21200402 */   addu      $a0, $s0, $a0
    /* CC94 8001C494 21200002 */  addu       $a0, $s0, $zero
    /* CC98 8001C498 EA91000C */  jal        UpdateTransition__9tMenuItemb
    /* CC9C 8001C49C 21282002 */   addu      $a1, $s1, $zero
    /* CCA0 8001C4A0 1800BF8F */  lw         $ra, 0x18($sp)
    /* CCA4 8001C4A4 1400B18F */  lw         $s1, 0x14($sp)
    /* CCA8 8001C4A8 1000B08F */  lw         $s0, 0x10($sp)
    /* CCAC 8001C4AC 0800E003 */  jr         $ra
    /* CCB0 8001C4B0 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel UpdateTransition__22tMenuItemLeftRightFadeb
