.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Texture_LoadImage__FP4RECTPUl, 0x44

glabel Texture_LoadImage__FP4RECTPUl
    /* D0348 800DFB48 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* D034C 800DFB4C 1000BFAF */  sw         $ra, 0x10($sp)
    /* D0350 800DFB50 04008294 */  lhu        $v0, 0x4($a0)
    /* D0354 800DFB54 00000000 */  nop
    /* D0358 800DFB58 01004230 */  andi       $v0, $v0, 0x1
    /* D035C 800DFB5C 05004010 */  beqz       $v0, .L800DFB74
    /* D0360 800DFB60 00000000 */   nop
    /* D0364 800DFB64 06008294 */  lhu        $v0, 0x6($a0)
    /* D0368 800DFB68 00000000 */  nop
    /* D036C 800DFB6C 01004234 */  ori        $v0, $v0, 0x1
    /* D0370 800DFB70 060082A4 */  sh         $v0, 0x6($a0)
  .L800DFB74:
    /* D0374 800DFB74 A4B6030C */  jal        LoadImage
    /* D0378 800DFB78 00000000 */   nop
    /* D037C 800DFB7C 1000BF8F */  lw         $ra, 0x10($sp)
    /* D0380 800DFB80 00000000 */  nop
    /* D0384 800DFB84 0800E003 */  jr         $ra
    /* D0388 800DFB88 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Texture_LoadImage__FP4RECTPUl
