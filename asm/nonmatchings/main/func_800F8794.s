.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_800F8794, 0x2C

glabel func_800F8794
    /* E8F94 800F8794 0800C010 */  beqz       $a2, .L800F87B8
    /* E8F98 800F8798 21180000 */   addu      $v1, $zero, $zero
  .L800F879C:
    /* E8F9C 800F879C 0000A28C */  lw         $v0, 0x0($a1)
    /* E8FA0 800F87A0 0400A524 */  addiu      $a1, $a1, 0x4
    /* E8FA4 800F87A4 01006324 */  addiu      $v1, $v1, 0x1
    /* E8FA8 800F87A8 000082AC */  sw         $v0, 0x0($a0)
    /* E8FAC 800F87AC 2B106600 */  sltu       $v0, $v1, $a2
    /* E8FB0 800F87B0 FAFF4014 */  bnez       $v0, .L800F879C
    /* E8FB4 800F87B4 04008424 */   addiu     $a0, $a0, 0x4
  .L800F87B8:
    /* E8FB8 800F87B8 0800E003 */  jr         $ra
    /* E8FBC 800F87BC 00000000 */   nop
endlabel func_800F8794
