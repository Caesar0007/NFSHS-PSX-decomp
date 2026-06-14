.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching HudOff__14AIHigh_BTC_Cop, 0x30

glabel HudOff__14AIHigh_BTC_Cop
    /* 4D704 8005CF04 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 4D708 8005CF08 1000BFAF */  sw         $ra, 0x10($sp)
    /* 4D70C 8005CF0C 1C00828C */  lw         $v0, 0x1C($a0)
    /* 4D710 8005CF10 00000000 */  nop
    /* 4D714 8005CF14 03004014 */  bnez       $v0, .L8005CF24
    /* 4D718 8005CF18 00000000 */   nop
    /* 4D71C 8005CF1C F965030C */  jal        Hud_BustedOverlayOff__Fv
    /* 4D720 8005CF20 00000000 */   nop
  .L8005CF24:
    /* 4D724 8005CF24 1000BF8F */  lw         $ra, 0x10($sp)
    /* 4D728 8005CF28 00000000 */  nop
    /* 4D72C 8005CF2C 0800E003 */  jr         $ra
    /* 4D730 8005CF30 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel HudOff__14AIHigh_BTC_Cop
