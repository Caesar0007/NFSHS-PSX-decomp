.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching UpdateTransition__17tUserNameMenuItemb, 0x7C

glabel UpdateTransition__17tUserNameMenuItemb
    /* 11020 80020820 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 11024 80020824 1000B0AF */  sw         $s0, 0x10($sp)
    /* 11028 80020828 21808000 */  addu       $s0, $a0, $zero
    /* 1102C 8002082C 1800BFAF */  sw         $ra, 0x18($sp)
    /* 11030 80020830 1400B1AF */  sw         $s1, 0x14($sp)
    /* 11034 80020834 82000286 */  lh         $v0, 0x82($s0)
    /* 11038 80020838 84000386 */  lh         $v1, 0x84($s0)
    /* 1103C 8002083C 00000000 */  nop
    /* 11040 80020840 21184300 */  addu       $v1, $v0, $v1
    /* 11044 80020844 81006228 */  slti       $v0, $v1, 0x81
    /* 11048 80020848 02004014 */  bnez       $v0, .L80020854
    /* 1104C 8002084C 2188A000 */   addu      $s1, $a1, $zero
    /* 11050 80020850 80000324 */  addiu      $v1, $zero, 0x80
  .L80020854:
    /* 11054 80020854 02006104 */  bgez       $v1, .L80020860
    /* 11058 80020858 00000000 */   nop
    /* 1105C 8002085C 21180000 */  addu       $v1, $zero, $zero
  .L80020860:
    /* 11060 80020860 1800028E */  lw         $v0, 0x18($s0)
    /* 11064 80020864 820003A6 */  sh         $v1, 0x82($s0)
    /* 11068 80020868 48004484 */  lh         $a0, 0x48($v0)
    /* 1106C 8002086C 4C00428C */  lw         $v0, 0x4C($v0)
    /* 11070 80020870 00000000 */  nop
    /* 11074 80020874 09F84000 */  jalr       $v0
    /* 11078 80020878 21200402 */   addu      $a0, $s0, $a0
    /* 1107C 8002087C 21200002 */  addu       $a0, $s0, $zero
    /* 11080 80020880 EA91000C */  jal        UpdateTransition__9tMenuItemb
    /* 11084 80020884 21282002 */   addu      $a1, $s1, $zero
    /* 11088 80020888 1800BF8F */  lw         $ra, 0x18($sp)
    /* 1108C 8002088C 1400B18F */  lw         $s1, 0x14($sp)
    /* 11090 80020890 1000B08F */  lw         $s0, 0x10($sp)
    /* 11094 80020894 0800E003 */  jr         $ra
    /* 11098 80020898 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel UpdateTransition__17tUserNameMenuItemb
