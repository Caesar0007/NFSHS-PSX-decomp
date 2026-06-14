.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Night_GenerateNextLightningEvent__Fv, 0x74

glabel Night_GenerateNextLightningEvent__Fv
    /* CBDCC 800DB5CC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* CBDD0 800DB5D0 1000BFAF */  sw         $ra, 0x10($sp)
    /* CBDD4 800DB5D4 EA9D030C */  jal        random
    /* CBDD8 800DB5D8 00000000 */   nop
    /* CBDDC 800DB5DC 1280033C */  lui        $v1, %hi(D_8011E0B0)
    /* CBDE0 800DB5E0 FF074230 */  andi       $v0, $v0, 0x7FF
    /* CBDE4 800DB5E4 B0E0638C */  lw         $v1, %lo(D_8011E0B0)($v1)
    /* CBDE8 800DB5E8 1F004224 */  addiu      $v0, $v0, 0x1F
    /* CBDEC 800DB5EC 21186200 */  addu       $v1, $v1, $v0
    /* CBDF0 800DB5F0 1C1583AF */  sw         $v1, %gp_rel(Night_gNextLightning)($gp)
    /* CBDF4 800DB5F4 EA9D030C */  jal        random
    /* CBDF8 800DB5F8 00000000 */   nop
    /* CBDFC 800DB5FC 0F004230 */  andi       $v0, $v0, 0xF
    /* CBE00 800DB600 1C15838F */  lw         $v1, %gp_rel(Night_gNextLightning)($gp)
    /* CBE04 800DB604 0F004224 */  addiu      $v0, $v0, 0xF
    /* CBE08 800DB608 21106200 */  addu       $v0, $v1, $v0
    /* CBE0C 800DB60C 201582AF */  sw         $v0, %gp_rel(Night_gEndNextLightning)($gp)
    /* CBE10 800DB610 241583AF */  sw         $v1, %gp_rel(Night_gNextFlicker)($gp)
    /* CBE14 800DB614 EA9D030C */  jal        random
    /* CBE18 800DB618 00000000 */   nop
    /* CBE1C 800DB61C FFFF4230 */  andi       $v0, $v0, 0xFFFF
    /* CBE20 800DB620 281582AF */  sw         $v0, %gp_rel(Night_gFlashAzimuth)($gp)
    /* CBE24 800DB624 EA9D030C */  jal        random
    /* CBE28 800DB628 00000000 */   nop
    /* CBE2C 800DB62C 1000BF8F */  lw         $ra, 0x10($sp)
    /* CBE30 800DB630 01004230 */  andi       $v0, $v0, 0x1
    /* CBE34 800DB634 2C1582A3 */  sb         $v0, %gp_rel(Night_gShowForks)($gp)
    /* CBE38 800DB638 0800E003 */  jr         $ra
    /* CBE3C 800DB63C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Night_GenerateNextLightningEvent__Fv
