.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetGustWind__FP17Souffle_tISouffle, 0x48

glabel GetGustWind__FP17Souffle_tISouffle
    /* A7E4C 800B764C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* A7E50 800B7650 1000B0AF */  sw         $s0, 0x10($sp)
    /* A7E54 800B7654 1400BFAF */  sw         $ra, 0x14($sp)
    /* A7E58 800B7658 EA9D030C */  jal        random
    /* A7E5C 800B765C 21808000 */   addu      $s0, $a0, $zero
    /* A7E60 800B7660 FF034230 */  andi       $v0, $v0, 0x3FF
    /* A7E64 800B7664 EA9D030C */  jal        random
    /* A7E68 800B7668 180002AE */   sw        $v0, 0x18($s0)
    /* A7E6C 800B766C FF034230 */  andi       $v0, $v0, 0x3FF
    /* A7E70 800B7670 EA9D030C */  jal        random
    /* A7E74 800B7674 200002AE */   sw        $v0, 0x20($s0)
    /* A7E78 800B7678 FF034230 */  andi       $v0, $v0, 0x3FF
    /* A7E7C 800B767C FF074224 */  addiu      $v0, $v0, 0x7FF
    /* A7E80 800B7680 1C0002AE */  sw         $v0, 0x1C($s0)
    /* A7E84 800B7684 1400BF8F */  lw         $ra, 0x14($sp)
    /* A7E88 800B7688 1000B08F */  lw         $s0, 0x10($sp)
    /* A7E8C 800B768C 0800E003 */  jr         $ra
    /* A7E90 800B7690 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel GetGustWind__FP17Souffle_tISouffle
