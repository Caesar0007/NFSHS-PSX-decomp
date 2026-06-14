.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DecDCTReset, 0x34

glabel DecDCTReset
    /* E91C8 800F89C8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* E91CC 800F89CC 1000B0AF */  sw         $s0, 0x10($sp)
    /* E91D0 800F89D0 21808000 */  addu       $s0, $a0, $zero
    /* E91D4 800F89D4 03000016 */  bnez       $s0, .L800F89E4
    /* E91D8 800F89D8 1400BFAF */   sw        $ra, 0x14($sp)
    /* E91DC 800F89DC 13CA030C */  jal        ResetCallback
    /* E91E0 800F89E0 00000000 */   nop
  .L800F89E4:
    /* E91E4 800F89E4 BEE2030C */  jal        func_800F8AF8
    /* E91E8 800F89E8 21200002 */   addu      $a0, $s0, $zero
    /* E91EC 800F89EC 1400BF8F */  lw         $ra, 0x14($sp)
    /* E91F0 800F89F0 1000B08F */  lw         $s0, 0x10($sp)
    /* E91F4 800F89F4 0800E003 */  jr         $ra
    /* E91F8 800F89F8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel DecDCTReset
