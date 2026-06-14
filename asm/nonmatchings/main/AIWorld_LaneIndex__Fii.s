.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIWorld_LaneIndex__Fii, 0xC8

glabel AIWorld_LaneIndex__Fii
    /* 63CCC 800734CC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 63CD0 800734D0 2130A000 */  addu       $a2, $a1, $zero
    /* 63CD4 800734D4 1400BFAF */  sw         $ra, 0x14($sp)
    /* 63CD8 800734D8 0800C104 */  bgez       $a2, .L800734FC
    /* 63CDC 800734DC 1000B0AF */   sw        $s0, 0x10($sp)
    /* 63CE0 800734E0 1480023C */  lui        $v0, %hi(BWorldSm_slices)
    /* 63CE4 800734E4 C0C7428C */  lw         $v0, %lo(BWorldSm_slices)($v0)
    /* 63CE8 800734E8 40190400 */  sll        $v1, $a0, 5
    /* 63CEC 800734EC 21186200 */  addu       $v1, $v1, $v0
    /* 63CF0 800734F0 1E006290 */  lbu        $v0, 0x1E($v1)
    /* 63CF4 800734F4 45CD0108 */  j          .L80073514
    /* 63CF8 800734F8 06001024 */   addiu     $s0, $zero, 0x6
  .L800734FC:
    /* 63CFC 800734FC 1480023C */  lui        $v0, %hi(BWorldSm_slices)
    /* 63D00 80073500 C0C7428C */  lw         $v0, %lo(BWorldSm_slices)($v0)
    /* 63D04 80073504 40190400 */  sll        $v1, $a0, 5
    /* 63D08 80073508 21186200 */  addu       $v1, $v1, $v0
    /* 63D0C 8007350C 1F006290 */  lbu        $v0, 0x1F($v1)
    /* 63D10 80073510 07001024 */  addiu      $s0, $zero, 0x7
  .L80073514:
    /* 63D14 80073514 C0130200 */  sll        $v0, $v0, 15
    /* 63D18 80073518 21184000 */  addu       $v1, $v0, $zero
    /* 63D1C 8007351C 1180023C */  lui        $v0, %hi(inverseLaneWidthTable)
    /* 63D20 80073520 02006104 */  bgez       $v1, .L8007352C
    /* 63D24 80073524 0CE04524 */   addiu     $a1, $v0, %lo(inverseLaneWidthTable)
    /* 63D28 80073528 FF3F6324 */  addiu      $v1, $v1, 0x3FFF
  .L8007352C:
    /* 63D2C 8007352C 83130300 */  sra        $v0, $v1, 14
    /* 63D30 80073530 80100200 */  sll        $v0, $v0, 2
    /* 63D34 80073534 21104500 */  addu       $v0, $v0, $a1
    /* 63D38 80073538 0000458C */  lw         $a1, 0x0($v0)
    /* 63D3C 8007353C CA90030C */  jal        fixedmult
    /* 63D40 80073540 2120C000 */   addu      $a0, $a2, $zero
    /* 63D44 80073544 21184000 */  addu       $v1, $v0, $zero
    /* 63D48 80073548 03006104 */  bgez       $v1, .L80073558
    /* 63D4C 8007354C 00000000 */   nop
    /* 63D50 80073550 FFFF0234 */  ori        $v0, $zero, 0xFFFF
    /* 63D54 80073554 21186200 */  addu       $v1, $v1, $v0
  .L80073558:
    /* 63D58 80073558 03140300 */  sra        $v0, $v1, 16
    /* 63D5C 8007355C 21800202 */  addu       $s0, $s0, $v0
    /* 63D60 80073560 02000106 */  bgez       $s0, .L8007356C
    /* 63D64 80073564 21100002 */   addu      $v0, $s0, $zero
    /* 63D68 80073568 21100000 */  addu       $v0, $zero, $zero
  .L8007356C:
    /* 63D6C 8007356C 21804000 */  addu       $s0, $v0, $zero
    /* 63D70 80073570 0E00022A */  slti       $v0, $s0, 0xE
    /* 63D74 80073574 02004010 */  beqz       $v0, .L80073580
    /* 63D78 80073578 0D000324 */   addiu     $v1, $zero, 0xD
    /* 63D7C 8007357C 21180002 */  addu       $v1, $s0, $zero
  .L80073580:
    /* 63D80 80073580 1400BF8F */  lw         $ra, 0x14($sp)
    /* 63D84 80073584 1000B08F */  lw         $s0, 0x10($sp)
    /* 63D88 80073588 21106000 */  addu       $v0, $v1, $zero
    /* 63D8C 8007358C 0800E003 */  jr         $ra
    /* 63D90 80073590 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AIWorld_LaneIndex__Fii
