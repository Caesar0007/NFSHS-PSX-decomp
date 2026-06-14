.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_800F5530, 0x84

glabel func_800F5530
    /* E5D30 800F5530 7C19828F */  lw         $v0, %gp_rel(D_8013DEC8)($gp)
    /* E5D34 800F5534 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* E5D38 800F5538 1000B0AF */  sw         $s0, 0x10($sp)
    /* E5D3C 800F553C FF009030 */  andi       $s0, $a0, 0xFF
    /* E5D40 800F5540 1400BFAF */  sw         $ra, 0x14($sp)
    /* E5D44 800F5544 21105000 */  addu       $v0, $v0, $s0
    /* E5D48 800F5548 00004280 */  lb         $v0, 0x0($v0)
    /* E5D4C 800F554C 00000000 */  nop
    /* E5D50 800F5550 0F004010 */  beqz       $v0, .L800F5590
    /* E5D54 800F5554 00000000 */   nop
    /* E5D58 800F5558 8019828F */  lw         $v0, %gp_rel(D_8013DECC)($gp)
    /* E5D5C 800F555C 00000000 */  nop
    /* E5D60 800F5560 21105000 */  addu       $v0, $v0, $s0
    /* E5D64 800F5564 00004490 */  lbu        $a0, 0x0($v0)
    /* E5D68 800F5568 4CD5030C */  jal        func_800F5530
    /* E5D6C 800F556C 00000000 */   nop
    /* E5D70 800F5570 8419828F */  lw         $v0, %gp_rel(D_8013DED0)($gp)
    /* E5D74 800F5574 00000000 */  nop
    /* E5D78 800F5578 21105000 */  addu       $v0, $v0, $s0
    /* E5D7C 800F557C 00004490 */  lbu        $a0, 0x0($v0)
    /* E5D80 800F5580 4CD5030C */  jal        func_800F5530
    /* E5D84 800F5584 00000000 */   nop
    /* E5D88 800F5588 69D50308 */  j          .L800F55A4
    /* E5D8C 800F558C 00000000 */   nop
  .L800F5590:
    /* E5D90 800F5590 8C19828F */  lw         $v0, %gp_rel(D_8013DED8)($gp)
    /* E5D94 800F5594 00000000 */  nop
    /* E5D98 800F5598 000044A0 */  sb         $a0, 0x0($v0)
    /* E5D9C 800F559C 01004224 */  addiu      $v0, $v0, 0x1
    /* E5DA0 800F55A0 8C1982AF */  sw         $v0, %gp_rel(D_8013DED8)($gp)
  .L800F55A4:
    /* E5DA4 800F55A4 1400BF8F */  lw         $ra, 0x14($sp)
    /* E5DA8 800F55A8 1000B08F */  lw         $s0, 0x10($sp)
    /* E5DAC 800F55AC 0800E003 */  jr         $ra
    /* E5DB0 800F55B0 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel func_800F5530
