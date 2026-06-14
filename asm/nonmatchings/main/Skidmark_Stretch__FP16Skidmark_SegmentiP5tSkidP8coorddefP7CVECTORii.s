.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Skidmark_Stretch__FP16Skidmark_SegmentiP5tSkidP8coorddefP7CVECTORii, 0x80

glabel Skidmark_Stretch__FP16Skidmark_SegmentiP5tSkidP8coorddefP7CVECTORii
    /* CFB08 800DF308 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* CFB0C 800DF30C 3C00A28F */  lw         $v0, 0x3C($sp)
    /* CFB10 800DF310 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* CFB14 800DF314 3800B18F */  lw         $s1, 0x38($sp)
    /* CFB18 800DF318 1800B0AF */  sw         $s0, 0x18($sp)
    /* CFB1C 800DF31C 21808000 */  addu       $s0, $a0, $zero
    /* CFB20 800DF320 2000B2AF */  sw         $s2, 0x20($sp)
    /* CFB24 800DF324 4000B28F */  lw         $s2, 0x40($sp)
    /* CFB28 800DF328 2400BFAF */  sw         $ra, 0x24($sp)
    /* CFB2C 800DF32C 1000A2AF */  sw         $v0, 0x10($sp)
    /* CFB30 800DF330 40100500 */  sll        $v0, $a1, 1
    /* CFB34 800DF334 21104500 */  addu       $v0, $v0, $a1
    /* CFB38 800DF338 80100200 */  sll        $v0, $v0, 2
    /* CFB3C 800DF33C 23104500 */  subu       $v0, $v0, $a1
    /* CFB40 800DF340 80100200 */  sll        $v0, $v0, 2
    /* CFB44 800DF344 23104500 */  subu       $v0, $v0, $a1
    /* CFB48 800DF348 7C15858F */  lw         $a1, %gp_rel(gSm)($gp)
    /* CFB4C 800DF34C 00110200 */  sll        $v0, $v0, 4
    /* CFB50 800DF350 317A030C */  jal        CalcOneSegment__FP16Skidmark_SegmentP8coorddefN21i
    /* CFB54 800DF354 2128A200 */   addu      $a1, $a1, $v0
    /* CFB58 800DF358 0300238A */  lwl        $v1, 0x3($s1)
    /* CFB5C 800DF35C 0000239A */  lwr        $v1, 0x0($s1)
    /* CFB60 800DF360 00000000 */  nop
    /* CFB64 800DF364 130003AA */  swl        $v1, 0x13($s0)
    /* CFB68 800DF368 100003BA */  swr        $v1, 0x10($s0)
    /* CFB6C 800DF36C 140012AE */  sw         $s2, 0x14($s0)
    /* CFB70 800DF370 2400BF8F */  lw         $ra, 0x24($sp)
    /* CFB74 800DF374 2000B28F */  lw         $s2, 0x20($sp)
    /* CFB78 800DF378 1C00B18F */  lw         $s1, 0x1C($sp)
    /* CFB7C 800DF37C 1800B08F */  lw         $s0, 0x18($sp)
    /* CFB80 800DF380 0800E003 */  jr         $ra
    /* CFB84 800DF384 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel Skidmark_Stretch__FP16Skidmark_SegmentiP5tSkidP8coorddefP7CVECTORii
