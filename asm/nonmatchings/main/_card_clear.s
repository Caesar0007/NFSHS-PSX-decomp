.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _card_clear, 0x34

glabel _card_clear
    /* FA520 80109D20 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* FA524 80109D24 1000B0AF */  sw         $s0, 0x10($sp)
    /* FA528 80109D28 1400BFAF */  sw         $ra, 0x14($sp)
    /* FA52C 80109D2C 2428040C */  jal        _new_card
    /* FA530 80109D30 21808000 */   addu      $s0, $a0, $zero
    /* FA534 80109D34 21200002 */  addu       $a0, $s0, $zero
    /* FA538 80109D38 3F000524 */  addiu      $a1, $zero, 0x3F
    /* FA53C 80109D3C 2828040C */  jal        _card_write
    /* FA540 80109D40 21300000 */   addu      $a2, $zero, $zero
    /* FA544 80109D44 1400BF8F */  lw         $ra, 0x14($sp)
    /* FA548 80109D48 1000B08F */  lw         $s0, 0x10($sp)
    /* FA54C 80109D4C 0800E003 */  jr         $ra
    /* FA550 80109D50 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel _card_clear
    /* FA554 80109D54 00000000 */  nop
    /* FA558 80109D58 00000000 */  nop
    /* FA55C 80109D5C 00000000 */  nop
