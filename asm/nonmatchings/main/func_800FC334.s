.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_800FC334, 0x40

glabel func_800FC334
    /* ECB34 800FC334 2B10A400 */  sltu       $v0, $a1, $a0
    /* ECB38 800FC338 06004014 */  bnez       $v0, .L800FC354
    /* ECB3C 800FC33C 2B10C400 */   sltu      $v0, $a2, $a0
    /* ECB40 800FC340 02004014 */  bnez       $v0, .L800FC34C
    /* ECB44 800FC344 21180000 */   addu      $v1, $zero, $zero
    /* ECB48 800FC348 2B18C500 */  sltu       $v1, $a2, $a1
  .L800FC34C:
    /* ECB4C 800FC34C 0800E003 */  jr         $ra
    /* ECB50 800FC350 21106000 */   addu      $v0, $v1, $zero
  .L800FC354:
    /* ECB54 800FC354 04004010 */  beqz       $v0, .L800FC368
    /* ECB58 800FC358 21180000 */   addu      $v1, $zero, $zero
    /* ECB5C 800FC35C 2B10C500 */  sltu       $v0, $a2, $a1
    /* ECB60 800FC360 02004010 */  beqz       $v0, .L800FC36C
    /* ECB64 800FC364 00000000 */   nop
  .L800FC368:
    /* ECB68 800FC368 01000324 */  addiu      $v1, $zero, 0x1
  .L800FC36C:
    /* ECB6C 800FC36C 0800E003 */  jr         $ra
    /* ECB70 800FC370 21106000 */   addu      $v0, $v1, $zero
endlabel func_800FC334
