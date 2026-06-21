.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching RealDeInit__14tCreditManager, 0x40

glabel RealDeInit__14tCreditManager
    /* 263E4 80035BE4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 263E8 80035BE8 1000B0AF */  sw         $s0, 0x10($sp)
    /* 263EC 80035BEC 21808000 */  addu       $s0, $a0, $zero
    /* 263F0 80035BF0 1400BFAF */  sw         $ra, 0x14($sp)
    /* 263F4 80035BF4 1000028E */  lw         $v0, 0x10($s0)
    /* 263F8 80035BF8 00000000 */  nop
    /* 263FC 80035BFC 05004010 */  beqz       $v0, .L80035C14
    /* 26400 80035C00 140000AE */   sw        $zero, 0x14($s0)
    /* 26404 80035C04 0000048E */  lw         $a0, 0x0($s0)
    /* 26408 80035C08 5095030C */  jal        purgememadr
    /* 2640C 80035C0C 00000000 */   nop
    /* 26410 80035C10 100000AE */  sw         $zero, 0x10($s0)
  .L80035C14:
    /* 26414 80035C14 1400BF8F */  lw         $ra, 0x14($sp)
    /* 26418 80035C18 1000B08F */  lw         $s0, 0x10($sp)
    /* 2641C 80035C1C 0800E003 */  jr         $ra
    /* 26420 80035C20 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel RealDeInit__14tCreditManager
