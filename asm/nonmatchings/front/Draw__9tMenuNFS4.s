.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Draw__9tMenuNFS4, 0x148

glabel Draw__9tMenuNFS4
    /* BCF4 8001B4F4 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* BCF8 8001B4F8 3C00B1AF */  sw         $s1, 0x3C($sp)
    /* BCFC 8001B4FC 21888000 */  addu       $s1, $a0, $zero
    /* BD00 8001B500 4000BFAF */  sw         $ra, 0x40($sp)
    /* BD04 8001B504 3800B0AF */  sw         $s0, 0x38($sp)
    /* BD08 8001B508 04002486 */  lh         $a0, 0x4($s1)
    /* BD0C 8001B50C 00000000 */  nop
    /* BD10 8001B510 03008004 */  bltz       $a0, .L8001B520
    /* BD14 8001B514 00000000 */   nop
    /* BD18 8001B518 4586000C */  jal        FETextRender_Title__Fs
    /* BD1C 8001B51C 00000000 */   nop
  .L8001B520:
    /* BD20 8001B520 3995000C */  jal        Initialize__5tMenu
    /* BD24 8001B524 21202002 */   addu      $a0, $s1, $zero
    /* BD28 8001B528 0800228E */  lw         $v0, 0x8($s1)
    /* BD2C 8001B52C 00000000 */  nop
    /* BD30 8001B530 80100200 */  sll        $v0, $v0, 2
    /* BD34 8001B534 21102202 */  addu       $v0, $s1, $v0
    /* BD38 8001B538 1000428C */  lw         $v0, 0x10($v0)
    /* BD3C 8001B53C 00000000 */  nop
    /* BD40 8001B540 0C00458C */  lw         $a1, 0xC($v0)
    /* BD44 8001B544 1000438C */  lw         $v1, 0x10($v0)
    /* BD48 8001B548 2300A004 */  bltz       $a1, .L8001B5D8
    /* BD4C 8001B54C 00000000 */   nop
    /* BD50 8001B550 21006018 */  blez       $v1, .L8001B5D8
    /* BD54 8001B554 1480023C */   lui       $v0, %hi(ticks)
    /* BD58 8001B558 ACDC428C */  lw         $v0, %lo(ticks)($v0)
    /* BD5C 8001B55C 00000000 */  nop
    /* BD60 8001B560 03110200 */  sra        $v0, $v0, 4
    /* BD64 8001B564 1A004300 */  div        $zero, $v0, $v1
    /* BD68 8001B568 02006014 */  bnez       $v1, .L8001B574
    /* BD6C 8001B56C 00000000 */   nop
    /* BD70 8001B570 0D000700 */  break      7
  .L8001B574:
    /* BD74 8001B574 FFFF0124 */  addiu      $at, $zero, -0x1
    /* BD78 8001B578 04006114 */  bne        $v1, $at, .L8001B58C
    /* BD7C 8001B57C 0080013C */   lui       $at, (0x80000000 >> 16)
    /* BD80 8001B580 02004114 */  bne        $v0, $at, .L8001B58C
    /* BD84 8001B584 00000000 */   nop
    /* BD88 8001B588 0D000600 */  break      6
  .L8001B58C:
    /* BD8C 8001B58C 10200000 */  mfhi       $a0
    /* BD90 8001B590 10000724 */  addiu      $a3, $zero, 0x10
    /* BD94 8001B594 CE00033C */  lui        $v1, (0xCEC844 >> 16)
    /* BD98 8001B598 0580023C */  lui        $v0, %hi(FEApp)
    /* BD9C 8001B59C C014428C */  lw         $v0, %lo(FEApp)($v0)
    /* BDA0 8001B5A0 44C86334 */  ori        $v1, $v1, (0xCEC844 & 0xFFFF)
    /* BDA4 8001B5A4 2400A3AF */  sw         $v1, 0x24($sp)
    /* BDA8 8001B5A8 2C024290 */  lbu        $v0, 0x22C($v0)
    /* BDAC 8001B5AC 00000000 */  nop
    /* BDB0 8001B5B0 02004010 */  beqz       $v0, .L8001B5BC
    /* BDB4 8001B5B4 2120A400 */   addu      $a0, $a1, $a0
    /* BDB8 8001B5B8 79000724 */  addiu      $a3, $zero, 0x79
  .L8001B5BC:
    /* BDBC 8001B5BC 10040524 */  addiu      $a1, $zero, 0x410
    /* BDC0 8001B5C0 2000A227 */  addiu      $v0, $sp, 0x20
    /* BDC4 8001B5C4 10000624 */  addiu      $a2, $zero, 0x10
    /* BDC8 8001B5C8 1000A0AF */  sw         $zero, 0x10($sp)
    /* BDCC 8001B5CC 1400A0AF */  sw         $zero, 0x14($sp)
    /* BDD0 8001B5D0 9E39010C */  jal        DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* BDD4 8001B5D4 1800A2AF */   sw        $v0, 0x18($sp)
  .L8001B5D8:
    /* BDD8 8001B5D8 1000228E */  lw         $v0, 0x10($s1)
    /* BDDC 8001B5DC 00000000 */  nop
    /* BDE0 8001B5E0 11004010 */  beqz       $v0, .L8001B628
    /* BDE4 8001B5E4 21800000 */   addu      $s0, $zero, $zero
  .L8001B5E8:
    /* BDE8 8001B5E8 002C1000 */  sll        $a1, $s0, 16
    /* BDEC 8001B5EC 6800228E */  lw         $v0, 0x68($s1)
    /* BDF0 8001B5F0 032C0500 */  sra        $a1, $a1, 16
    /* BDF4 8001B5F4 58004484 */  lh         $a0, 0x58($v0)
    /* BDF8 8001B5F8 5C00428C */  lw         $v0, 0x5C($v0)
    /* BDFC 8001B5FC 00000000 */  nop
    /* BE00 8001B600 09F84000 */  jalr       $v0
    /* BE04 8001B604 21202402 */   addu      $a0, $s1, $a0
    /* BE08 8001B608 01000326 */  addiu      $v1, $s0, 0x1
    /* BE0C 8001B60C 00140300 */  sll        $v0, $v1, 16
    /* BE10 8001B610 83130200 */  sra        $v0, $v0, 14
    /* BE14 8001B614 21102202 */  addu       $v0, $s1, $v0
    /* BE18 8001B618 1000428C */  lw         $v0, 0x10($v0)
    /* BE1C 8001B61C 00000000 */  nop
    /* BE20 8001B620 F1FF4014 */  bnez       $v0, .L8001B5E8
    /* BE24 8001B624 21806000 */   addu      $s0, $v1, $zero
  .L8001B628:
    /* BE28 8001B628 4000BF8F */  lw         $ra, 0x40($sp)
    /* BE2C 8001B62C 3C00B18F */  lw         $s1, 0x3C($sp)
    /* BE30 8001B630 3800B08F */  lw         $s0, 0x38($sp)
    /* BE34 8001B634 0800E003 */  jr         $ra
    /* BE38 8001B638 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel Draw__9tMenuNFS4
