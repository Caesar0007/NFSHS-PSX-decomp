.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TextValue__24tListIteratorMultiPlayer7tPlayer, 0x50

glabel TextValue__24tListIteratorMultiPlayer7tPlayer
    /* 14BE0 800243E0 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 14BE4 800243E4 1000B0AF */  sw         $s0, 0x10($sp)
    /* 14BE8 800243E8 21808000 */  addu       $s0, $a0, $zero
    /* 14BEC 800243EC 1400BFAF */  sw         $ra, 0x14($sp)
    /* 14BF0 800243F0 0C00028E */  lw         $v0, 0xC($s0)
    /* 14BF4 800243F4 00000000 */  nop
    /* 14BF8 800243F8 10004484 */  lh         $a0, 0x10($v0)
    /* 14BFC 800243FC 1400428C */  lw         $v0, 0x14($v0)
    /* 14C00 80024400 00000000 */  nop
    /* 14C04 80024404 09F84000 */  jalr       $v0
    /* 14C08 80024408 21200402 */   addu      $a0, $s0, $a0
    /* 14C0C 8002440C FF004230 */  andi       $v0, $v0, 0xFF
    /* 14C10 80024410 40100200 */  sll        $v0, $v0, 1
    /* 14C14 80024414 0000038E */  lw         $v1, 0x0($s0)
    /* 14C18 80024418 1400BF8F */  lw         $ra, 0x14($sp)
    /* 14C1C 8002441C 1000B08F */  lw         $s0, 0x10($sp)
    /* 14C20 80024420 21104300 */  addu       $v0, $v0, $v1
    /* 14C24 80024424 00004284 */  lh         $v0, 0x0($v0)
    /* 14C28 80024428 0800E003 */  jr         $ra
    /* 14C2C 8002442C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel TextValue__24tListIteratorMultiPlayer7tPlayer
