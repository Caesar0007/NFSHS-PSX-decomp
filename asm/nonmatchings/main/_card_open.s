.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _card_open, 0x30

glabel _card_open
    /* F9DF0 801095F0 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* F9DF4 801095F4 1000BFAF */  sw         $ra, 0x10($sp)
    /* F9DF8 801095F8 E131040C */  jal        InitCARD
    /* F9DFC 801095FC 00000000 */   nop
    /* F9E00 80109600 FC31040C */  jal        StartCARD
    /* F9E04 80109604 00000000 */   nop
    /* F9E08 80109608 1532040C */  jal        _bu_init
    /* F9E0C 8010960C 00000000 */   nop
    /* F9E10 80109610 1000BF8F */  lw         $ra, 0x10($sp)
    /* F9E14 80109614 1800BD27 */  addiu      $sp, $sp, 0x18
    /* F9E18 80109618 0800E003 */  jr         $ra
    /* F9E1C 8010961C 00000000 */   nop
endlabel _card_open
