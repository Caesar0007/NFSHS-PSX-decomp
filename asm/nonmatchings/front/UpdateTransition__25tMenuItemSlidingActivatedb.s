.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching UpdateTransition__25tMenuItemSlidingActivatedb, 0x7C

glabel UpdateTransition__25tMenuItemSlidingActivatedb
    /* E6C8 8001DEC8 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* E6CC 8001DECC 1000B0AF */  sw         $s0, 0x10($sp)
    /* E6D0 8001DED0 21808000 */  addu       $s0, $a0, $zero
    /* E6D4 8001DED4 1800BFAF */  sw         $ra, 0x18($sp)
    /* E6D8 8001DED8 1400B1AF */  sw         $s1, 0x14($sp)
    /* E6DC 8001DEDC 2C000286 */  lh         $v0, 0x2C($s0)
    /* E6E0 8001DEE0 2E000386 */  lh         $v1, 0x2E($s0)
    /* E6E4 8001DEE4 00000000 */  nop
    /* E6E8 8001DEE8 21184300 */  addu       $v1, $v0, $v1
    /* E6EC 8001DEEC 81006228 */  slti       $v0, $v1, 0x81
    /* E6F0 8001DEF0 02004014 */  bnez       $v0, .L8001DEFC
    /* E6F4 8001DEF4 2188A000 */   addu      $s1, $a1, $zero
    /* E6F8 8001DEF8 80000324 */  addiu      $v1, $zero, 0x80
  .L8001DEFC:
    /* E6FC 8001DEFC 02006104 */  bgez       $v1, .L8001DF08
    /* E700 8001DF00 00000000 */   nop
    /* E704 8001DF04 21180000 */  addu       $v1, $zero, $zero
  .L8001DF08:
    /* E708 8001DF08 1800028E */  lw         $v0, 0x18($s0)
    /* E70C 8001DF0C 2C0003A6 */  sh         $v1, 0x2C($s0)
    /* E710 8001DF10 48004484 */  lh         $a0, 0x48($v0)
    /* E714 8001DF14 4C00428C */  lw         $v0, 0x4C($v0)
    /* E718 8001DF18 00000000 */  nop
    /* E71C 8001DF1C 09F84000 */  jalr       $v0
    /* E720 8001DF20 21200402 */   addu      $a0, $s0, $a0
    /* E724 8001DF24 21200002 */  addu       $a0, $s0, $zero
    /* E728 8001DF28 EA91000C */  jal        UpdateTransition__9tMenuItemb
    /* E72C 8001DF2C 21282002 */   addu      $a1, $s1, $zero
    /* E730 8001DF30 1800BF8F */  lw         $ra, 0x18($sp)
    /* E734 8001DF34 1400B18F */  lw         $s1, 0x14($sp)
    /* E738 8001DF38 1000B08F */  lw         $s0, 0x10($sp)
    /* E73C 8001DF3C 0800E003 */  jr         $ra
    /* E740 8001DF40 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel UpdateTransition__25tMenuItemSlidingActivatedb
