.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching InitCARD, 0x6C

glabel InitCARD
    /* FCF84 8010C784 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* FCF88 8010C788 1000B0AF */  sw         $s0, 0x10($sp)
    /* FCF8C 8010C78C 21808000 */  addu       $s0, $a0, $zero
    /* FCF90 8010C790 1400BFAF */  sw         $ra, 0x14($sp)
    /* FCF94 8010C794 9519040C */  jal        ChangeClearPAD
    /* FCF98 8010C798 21200000 */   addu      $a0, $zero, $zero
    /* FCF9C 8010C79C 631A040C */  jal        EnterCriticalSection
    /* FCFA0 8010C7A0 00000000 */   nop
    /* FCFA4 8010C7A4 6C32040C */  jal        ReadInitPadFlag
    /* FCFA8 8010C7A8 00000000 */   nop
    /* FCFAC 8010C7AC 02004014 */  bnez       $v0, .L8010C7B8
    /* FCFB0 8010C7B0 00000000 */   nop
    /* FCFB4 8010C7B4 21800000 */  addu       $s0, $zero, $zero
  .L8010C7B8:
    /* FCFB8 8010C7B8 7032040C */  jal        InitCARD2
    /* FCFBC 8010C7BC 21200002 */   addu      $a0, $s0, $zero
    /* FCFC0 8010C7C0 DB32040C */  jal        _copy_memcard_patch
    /* FCFC4 8010C7C4 00000000 */   nop
    /* FCFC8 8010C7C8 9A32040C */  jal        _patch_card
    /* FCFCC 8010C7CC 00000000 */   nop
    /* FCFD0 8010C7D0 BF32040C */  jal        _patch_card2
    /* FCFD4 8010C7D4 00000000 */   nop
    /* FCFD8 8010C7D8 5B1A040C */  jal        ExitCriticalSection
    /* FCFDC 8010C7DC 00000000 */   nop
    /* FCFE0 8010C7E0 1400BF8F */  lw         $ra, 0x14($sp)
    /* FCFE4 8010C7E4 1000B08F */  lw         $s0, 0x10($sp)
    /* FCFE8 8010C7E8 0800E003 */  jr         $ra
    /* FCFEC 8010C7EC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel InitCARD
