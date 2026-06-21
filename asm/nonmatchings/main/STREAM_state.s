.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching STREAM_state, 0x38

glabel STREAM_state
    /* EE404 800FDC04 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* EE408 800FDC08 1800BFAF */  sw         $ra, 0x18($sp)
    /* EE40C 800FDC0C 1000A527 */  addiu      $a1, $sp, 0x10
    /* EE410 800FDC10 BEF0030C */  jal        validatehandle
    /* EE414 800FDC14 1400A627 */   addiu     $a2, $sp, 0x14
    /* EE418 800FDC18 04004014 */  bnez       $v0, .L800FDC2C
    /* EE41C 800FDC1C 21100000 */   addu      $v0, $zero, $zero
    /* EE420 800FDC20 1000A28F */  lw         $v0, 0x10($sp)
    /* EE424 800FDC24 00000000 */  nop
    /* EE428 800FDC28 2800428C */  lw         $v0, 0x28($v0)
  .L800FDC2C:
    /* EE42C 800FDC2C 1800BF8F */  lw         $ra, 0x18($sp)
    /* EE430 800FDC30 00000000 */  nop
    /* EE434 800FDC34 0800E003 */  jr         $ra
    /* EE438 800FDC38 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel STREAM_state
