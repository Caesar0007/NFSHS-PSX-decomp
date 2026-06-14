.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AILife_RCSetSpeeds__FP8Car_tObj, 0x30

glabel AILife_RCSetSpeeds__FP8Car_tObj
    /* 57EB4 800676B4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 57EB8 800676B8 1000B0AF */  sw         $s0, 0x10($sp)
    /* 57EBC 800676BC 1400BFAF */  sw         $ra, 0x14($sp)
    /* 57EC0 800676C0 77BB010C */  jal        AISpeeds_CalcDesiredSpeed__FP8Car_tObj
    /* 57EC4 800676C4 21808000 */   addu      $s0, $a0, $zero
    /* 57EC8 800676C8 5C05028E */  lw         $v0, 0x55C($s0)
    /* 57ECC 800676CC 00000000 */  nop
    /* 57ED0 800676D0 640502AE */  sw         $v0, 0x564($s0)
    /* 57ED4 800676D4 1400BF8F */  lw         $ra, 0x14($sp)
    /* 57ED8 800676D8 1000B08F */  lw         $s0, 0x10($sp)
    /* 57EDC 800676DC 0800E003 */  jr         $ra
    /* 57EE0 800676E0 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AILife_RCSetSpeeds__FP8Car_tObj
