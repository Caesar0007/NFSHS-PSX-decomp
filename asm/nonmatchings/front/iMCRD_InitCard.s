.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iMCRD_InitCard, 0x58

glabel iMCRD_InitCard
    /* 3FC80 8004F480 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 3FC84 8004F484 1000BFAF */  sw         $ra, 0x10($sp)
    /* 3FC88 8004F488 9140010C */  jal        MCRD_getcard
    /* 3FC8C 8004F48C 00000000 */   nop
    /* 3FC90 8004F490 21184000 */  addu       $v1, $v0, $zero
    /* 3FC94 8004F494 03006014 */  bnez       $v1, .L8004F4A4
    /* 3FC98 8004F498 10006424 */   addiu     $a0, $v1, 0x10
    /* 3FC9C 8004F49C 323D0108 */  j          .L8004F4C8
    /* 3FCA0 8004F4A0 FFFF0224 */   addiu     $v0, $zero, -0x1
  .L8004F4A4:
    /* 3FCA4 8004F4A4 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 3FCA8 8004F4A8 000062AC */  sw         $v0, 0x0($v1)
    /* 3FCAC 8004F4AC 0F000224 */  addiu      $v0, $zero, 0xF
    /* 3FCB0 8004F4B0 58020524 */  addiu      $a1, $zero, 0x258
    /* 3FCB4 8004F4B4 040060AC */  sw         $zero, 0x4($v1)
    /* 3FCB8 8004F4B8 080060AC */  sw         $zero, 0x8($v1)
    /* 3FCBC 8004F4BC E8C5030C */  jal        blockclear
    /* 3FCC0 8004F4C0 0C0062AC */   sw        $v0, 0xC($v1)
    /* 3FCC4 8004F4C4 21100000 */  addu       $v0, $zero, $zero
  .L8004F4C8:
    /* 3FCC8 8004F4C8 1000BF8F */  lw         $ra, 0x10($sp)
    /* 3FCCC 8004F4CC 00000000 */  nop
    /* 3FCD0 8004F4D0 0800E003 */  jr         $ra
    /* 3FCD4 8004F4D4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel iMCRD_InitCard
