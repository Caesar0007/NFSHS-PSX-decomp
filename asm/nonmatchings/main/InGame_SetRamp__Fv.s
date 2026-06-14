.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching InGame_SetRamp__Fv, 0x188

glabel InGame_SetRamp__Fv
    /* CD53C 800DCD3C D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* CD540 800DCD40 1480023C */  lui        $v0, %hi(Replay_ReplayMode)
    /* CD544 800DCD44 F4D3428C */  lw         $v0, %lo(Replay_ReplayMode)($v0)
    /* CD548 800DCD48 1180033C */  lui        $v1, %hi(Input_gHandler)
    /* CD54C 800DCD4C 2000B4AF */  sw         $s4, 0x20($sp)
    /* CD550 800DCD50 143C7424 */  addiu      $s4, $v1, %lo(Input_gHandler)
    /* CD554 800DCD54 2800BFAF */  sw         $ra, 0x28($sp)
    /* CD558 800DCD58 2400B5AF */  sw         $s5, 0x24($sp)
    /* CD55C 800DCD5C 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* CD560 800DCD60 1800B2AF */  sw         $s2, 0x18($sp)
    /* CD564 800DCD64 1400B1AF */  sw         $s1, 0x14($sp)
    /* CD568 800DCD68 02004228 */  slti       $v0, $v0, 0x2
    /* CD56C 800DCD6C 4C004010 */  beqz       $v0, .L800DCEA0
    /* CD570 800DCD70 1000B0AF */   sw        $s0, 0x10($sp)
    /* CD574 800DCD74 1480023C */  lui        $v0, %hi(Cars_gNumHumanRaceCars)
    /* CD578 800DCD78 00C8428C */  lw         $v0, %lo(Cars_gNumHumanRaceCars)($v0)
    /* CD57C 800DCD7C 00000000 */  nop
    /* CD580 800DCD80 47004018 */  blez       $v0, .L800DCEA0
    /* CD584 800DCD84 21980000 */   addu      $s3, $zero, $zero
    /* CD588 800DCD88 1180023C */  lui        $v0, %hi(Cars_gHumanRaceCarList)
    /* CD58C 800DCD8C 48FA5524 */  addiu      $s5, $v0, %lo(Cars_gHumanRaceCarList)
    /* CD590 800DCD90 01001224 */  addiu      $s2, $zero, 0x1
    /* CD594 800DCD94 001C1300 */  sll        $v1, $s3, 16
  .L800DCD98:
    /* CD598 800DCD98 831B0300 */  sra        $v1, $v1, 14
    /* CD59C 800DCD9C 21887500 */  addu       $s1, $v1, $s5
    /* CD5A0 800DCDA0 0000228E */  lw         $v0, 0x0($s1)
    /* CD5A4 800DCDA4 00000000 */  nop
    /* CD5A8 800DCDA8 8802428C */  lw         $v0, 0x288($v0)
    /* CD5AC 800DCDAC 00000000 */  nop
    /* CD5B0 800DCDB0 1C0052AC */  sw         $s2, 0x1C($v0)
    /* CD5B4 800DCDB4 200052AC */  sw         $s2, 0x20($v0)
    /* CD5B8 800DCDB8 180052AC */  sw         $s2, 0x18($v0)
    /* CD5BC 800DCDBC 1480023C */  lui        $v0, %hi(D_8013DAC0)
    /* CD5C0 800DCDC0 C0DA4224 */  addiu      $v0, $v0, %lo(D_8013DAC0)
    /* CD5C4 800DCDC4 21806200 */  addu       $s0, $v1, $v0
    /* CD5C8 800DCDC8 0000038E */  lw         $v1, 0x0($s0)
    /* CD5CC 800DCDCC 4F000224 */  addiu      $v0, $zero, 0x4F
    /* CD5D0 800DCDD0 23104300 */  subu       $v0, $v0, $v1
    /* CD5D4 800DCDD4 80100200 */  sll        $v0, $v0, 2
    /* CD5D8 800DCDD8 21105400 */  addu       $v0, $v0, $s4
    /* CD5DC 800DCDDC 0000448C */  lw         $a0, 0x0($v0)
    /* CD5E0 800DCDE0 4D73030C */  jal        InGame_GetDevice__Fi
    /* CD5E4 800DCDE4 00000000 */   nop
    /* CD5E8 800DCDE8 06005214 */  bne        $v0, $s2, .L800DCE04
    /* CD5EC 800DCDEC 00000000 */   nop
    /* CD5F0 800DCDF0 0000228E */  lw         $v0, 0x0($s1)
    /* CD5F4 800DCDF4 00000000 */  nop
    /* CD5F8 800DCDF8 8802428C */  lw         $v0, 0x288($v0)
    /* CD5FC 800DCDFC 00000000 */  nop
    /* CD600 800DCE00 180040AC */  sw         $zero, 0x18($v0)
  .L800DCE04:
    /* CD604 800DCE04 0000038E */  lw         $v1, 0x0($s0)
    /* CD608 800DCE08 51000224 */  addiu      $v0, $zero, 0x51
    /* CD60C 800DCE0C 23104300 */  subu       $v0, $v0, $v1
    /* CD610 800DCE10 80100200 */  sll        $v0, $v0, 2
    /* CD614 800DCE14 21105400 */  addu       $v0, $v0, $s4
    /* CD618 800DCE18 0000448C */  lw         $a0, 0x0($v0)
    /* CD61C 800DCE1C 4D73030C */  jal        InGame_GetDevice__Fi
    /* CD620 800DCE20 00000000 */   nop
    /* CD624 800DCE24 06005214 */  bne        $v0, $s2, .L800DCE40
    /* CD628 800DCE28 00000000 */   nop
    /* CD62C 800DCE2C 0000228E */  lw         $v0, 0x0($s1)
    /* CD630 800DCE30 00000000 */  nop
    /* CD634 800DCE34 8802428C */  lw         $v0, 0x288($v0)
    /* CD638 800DCE38 00000000 */  nop
    /* CD63C 800DCE3C 1C0040AC */  sw         $zero, 0x1C($v0)
  .L800DCE40:
    /* CD640 800DCE40 0000038E */  lw         $v1, 0x0($s0)
    /* CD644 800DCE44 52000224 */  addiu      $v0, $zero, 0x52
    /* CD648 800DCE48 23104300 */  subu       $v0, $v0, $v1
    /* CD64C 800DCE4C 80100200 */  sll        $v0, $v0, 2
    /* CD650 800DCE50 21105400 */  addu       $v0, $v0, $s4
    /* CD654 800DCE54 0000448C */  lw         $a0, 0x0($v0)
    /* CD658 800DCE58 4D73030C */  jal        InGame_GetDevice__Fi
    /* CD65C 800DCE5C 00000000 */   nop
    /* CD660 800DCE60 07005214 */  bne        $v0, $s2, .L800DCE80
    /* CD664 800DCE64 01006226 */   addiu     $v0, $s3, 0x1
    /* CD668 800DCE68 0000228E */  lw         $v0, 0x0($s1)
    /* CD66C 800DCE6C 00000000 */  nop
    /* CD670 800DCE70 8802428C */  lw         $v0, 0x288($v0)
    /* CD674 800DCE74 00000000 */  nop
    /* CD678 800DCE78 200040AC */  sw         $zero, 0x20($v0)
    /* CD67C 800DCE7C 01006226 */  addiu      $v0, $s3, 0x1
  .L800DCE80:
    /* CD680 800DCE80 21984000 */  addu       $s3, $v0, $zero
    /* CD684 800DCE84 00140200 */  sll        $v0, $v0, 16
    /* CD688 800DCE88 1480033C */  lui        $v1, %hi(Cars_gNumHumanRaceCars)
    /* CD68C 800DCE8C 00C8638C */  lw         $v1, %lo(Cars_gNumHumanRaceCars)($v1)
    /* CD690 800DCE90 03140200 */  sra        $v0, $v0, 16
    /* CD694 800DCE94 2A104300 */  slt        $v0, $v0, $v1
    /* CD698 800DCE98 BFFF4014 */  bnez       $v0, .L800DCD98
    /* CD69C 800DCE9C 001C1300 */   sll       $v1, $s3, 16
  .L800DCEA0:
    /* CD6A0 800DCEA0 2800BF8F */  lw         $ra, 0x28($sp)
    /* CD6A4 800DCEA4 2400B58F */  lw         $s5, 0x24($sp)
    /* CD6A8 800DCEA8 2000B48F */  lw         $s4, 0x20($sp)
    /* CD6AC 800DCEAC 1C00B38F */  lw         $s3, 0x1C($sp)
    /* CD6B0 800DCEB0 1800B28F */  lw         $s2, 0x18($sp)
    /* CD6B4 800DCEB4 1400B18F */  lw         $s1, 0x14($sp)
    /* CD6B8 800DCEB8 1000B08F */  lw         $s0, 0x10($sp)
    /* CD6BC 800DCEBC 0800E003 */  jr         $ra
    /* CD6C0 800DCEC0 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel InGame_SetRamp__Fv
