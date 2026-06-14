.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetAngleWind__FP17Souffle_tISouffle, 0x38

glabel GetAngleWind__FP17Souffle_tISouffle
    /* A7E94 800B7694 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* A7E98 800B7698 1000B0AF */  sw         $s0, 0x10($sp)
    /* A7E9C 800B769C 1400BFAF */  sw         $ra, 0x14($sp)
    /* A7EA0 800B76A0 EA9D030C */  jal        random
    /* A7EA4 800B76A4 21808000 */   addu      $s0, $a0, $zero
    /* A7EA8 800B76A8 EA9D030C */  jal        random
    /* A7EAC 800B76AC 080002AE */   sw        $v0, 0x8($s0)
    /* A7EB0 800B76B0 7F004230 */  andi       $v0, $v0, 0x7F
    /* A7EB4 800B76B4 C1FF4224 */  addiu      $v0, $v0, -0x3F
    /* A7EB8 800B76B8 040002AE */  sw         $v0, 0x4($s0)
    /* A7EBC 800B76BC 1400BF8F */  lw         $ra, 0x14($sp)
    /* A7EC0 800B76C0 1000B08F */  lw         $s0, 0x10($sp)
    /* A7EC4 800B76C4 0800E003 */  jr         $ra
    /* A7EC8 800B76C8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel GetAngleWind__FP17Souffle_tISouffle
