.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Draw_DeInitViews__Fv, 0x88

glabel Draw_DeInitViews__Fv
    /* AE4E0 800BDCE0 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* AE4E4 800BDCE4 1400B1AF */  sw         $s1, 0x14($sp)
    /* AE4E8 800BDCE8 21880000 */  addu       $s1, $zero, $zero
    /* AE4EC 800BDCEC 1280023C */  lui        $v0, %hi(Draw_gView)
    /* AE4F0 800BDCF0 1000B0AF */  sw         $s0, 0x10($sp)
    /* AE4F4 800BDCF4 54EC5024 */  addiu      $s0, $v0, %lo(Draw_gView)
    /* AE4F8 800BDCF8 1800BFAF */  sw         $ra, 0x18($sp)
  .L800BDCFC:
    /* AE4FC 800BDCFC 6012828F */  lw         $v0, %gp_rel(Draw_gNumView)($gp)
    /* AE500 800BDD00 00000000 */  nop
    /* AE504 800BDD04 2A102202 */  slt        $v0, $s1, $v0
    /* AE508 800BDD08 12004010 */  beqz       $v0, .L800BDD54
    /* AE50C 800BDD0C 00000000 */   nop
    /* AE510 800BDD10 C000048E */  lw         $a0, 0xC0($s0)
    /* AE514 800BDD14 00000000 */  nop
    /* AE518 800BDD18 03008010 */  beqz       $a0, .L800BDD28
    /* AE51C 800BDD1C 00000000 */   nop
    /* AE520 800BDD20 5095030C */  jal        purgememadr
    /* AE524 800BDD24 00000000 */   nop
  .L800BDD28:
    /* AE528 800BDD28 C400048E */  lw         $a0, 0xC4($s0)
    /* AE52C 800BDD2C 00000000 */  nop
    /* AE530 800BDD30 03008010 */  beqz       $a0, .L800BDD40
    /* AE534 800BDD34 00000000 */   nop
    /* AE538 800BDD38 5095030C */  jal        purgememadr
    /* AE53C 800BDD3C 00000000 */   nop
  .L800BDD40:
    /* AE540 800BDD40 C00000AE */  sw         $zero, 0xC0($s0)
    /* AE544 800BDD44 C40000AE */  sw         $zero, 0xC4($s0)
    /* AE548 800BDD48 C8001026 */  addiu      $s0, $s0, 0xC8
    /* AE54C 800BDD4C 3FF70208 */  j          .L800BDCFC
    /* AE550 800BDD50 01003126 */   addiu     $s1, $s1, 0x1
  .L800BDD54:
    /* AE554 800BDD54 1800BF8F */  lw         $ra, 0x18($sp)
    /* AE558 800BDD58 1400B18F */  lw         $s1, 0x14($sp)
    /* AE55C 800BDD5C 1000B08F */  lw         $s0, 0x10($sp)
    /* AE560 800BDD60 0800E003 */  jr         $ra
    /* AE564 800BDD64 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Draw_DeInitViews__Fv
