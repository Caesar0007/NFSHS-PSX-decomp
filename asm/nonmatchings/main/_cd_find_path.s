.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _cd_find_path, 0xA4

glabel _cd_find_path
    /* E9E44 800F9644 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* E9E48 800F9648 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* E9E4C 800F964C 21988000 */  addu       $s3, $a0, $zero
    /* E9E50 800F9650 2000B4AF */  sw         $s4, 0x20($sp)
    /* E9E54 800F9654 21A0A000 */  addu       $s4, $a1, $zero
    /* E9E58 800F9658 1000B0AF */  sw         $s0, 0x10($sp)
    /* E9E5C 800F965C 21800000 */  addu       $s0, $zero, $zero
    /* E9E60 800F9660 1800B2AF */  sw         $s2, 0x18($sp)
    /* E9E64 800F9664 1480123C */  lui        $s2, %hi(D_80144E88)
    /* E9E68 800F9668 884E5226 */  addiu      $s2, $s2, %lo(D_80144E88)
    /* E9E6C 800F966C 1400B1AF */  sw         $s1, 0x14($sp)
    /* E9E70 800F9670 21880000 */  addu       $s1, $zero, $zero
    /* E9E74 800F9674 2400BFAF */  sw         $ra, 0x24($sp)
  .L800F9678:
    /* E9E78 800F9678 1480023C */  lui        $v0, %hi(D_80144E80)
    /* E9E7C 800F967C 21105100 */  addu       $v0, $v0, $s1
    /* E9E80 800F9680 804E428C */  lw         $v0, %lo(D_80144E80)($v0)
    /* E9E84 800F9684 00000000 */  nop
    /* E9E88 800F9688 0E004010 */  beqz       $v0, .L800F96C4
    /* E9E8C 800F968C 00000000 */   nop
    /* E9E90 800F9690 07005314 */  bne        $v0, $s3, .L800F96B0
    /* E9E94 800F9694 21208002 */   addu      $a0, $s4, $zero
    /* E9E98 800F9698 5F97030C */  jal        strcmp
    /* E9E9C 800F969C 21284002 */   addu      $a1, $s2, $zero
    /* E9EA0 800F96A0 04004014 */  bnez       $v0, .L800F96B4
    /* E9EA4 800F96A4 2C005226 */   addiu     $s2, $s2, 0x2C
    /* E9EA8 800F96A8 B2E50308 */  j          .L800F96C8
    /* E9EAC 800F96AC 01000226 */   addiu     $v0, $s0, 0x1
  .L800F96B0:
    /* E9EB0 800F96B0 2C005226 */  addiu      $s2, $s2, 0x2C
  .L800F96B4:
    /* E9EB4 800F96B4 01001026 */  addiu      $s0, $s0, 0x1
    /* E9EB8 800F96B8 8000022A */  slti       $v0, $s0, 0x80
    /* E9EBC 800F96BC EEFF4014 */  bnez       $v0, .L800F9678
    /* E9EC0 800F96C0 2C003126 */   addiu     $s1, $s1, 0x2C
  .L800F96C4:
    /* E9EC4 800F96C4 FFFF0224 */  addiu      $v0, $zero, -0x1
  .L800F96C8:
    /* E9EC8 800F96C8 2400BF8F */  lw         $ra, 0x24($sp)
    /* E9ECC 800F96CC 2000B48F */  lw         $s4, 0x20($sp)
    /* E9ED0 800F96D0 1C00B38F */  lw         $s3, 0x1C($sp)
    /* E9ED4 800F96D4 1800B28F */  lw         $s2, 0x18($sp)
    /* E9ED8 800F96D8 1400B18F */  lw         $s1, 0x14($sp)
    /* E9EDC 800F96DC 1000B08F */  lw         $s0, 0x10($sp)
    /* E9EE0 800F96E0 0800E003 */  jr         $ra
    /* E9EE4 800F96E4 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel _cd_find_path
