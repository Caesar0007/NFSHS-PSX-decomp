.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDstreamgetrequestptr, 0x88

glabel iSNDstreamgetrequestptr
    /* F3D08 80103508 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* F3D0C 8010350C 1000B0AF */  sw         $s0, 0x10($sp)
    /* F3D10 80103510 21808000 */  addu       $s0, $a0, $zero
    /* F3D14 80103514 19000006 */  bltz       $s0, .L8010357C
    /* F3D18 80103518 1400BFAF */   sw        $ra, 0x14($sp)
    /* F3D1C 8010351C 12A3030C */  jal        iSNDstreamgetstreamptr
    /* F3D20 80103520 FF000432 */   andi      $a0, $s0, 0xFF
    /* F3D24 80103524 21284000 */  addu       $a1, $v0, $zero
    /* F3D28 80103528 1500A010 */  beqz       $a1, .L80103580
    /* F3D2C 8010352C 21100000 */   addu      $v0, $zero, $zero
    /* F3D30 80103530 1600A290 */  lbu        $v0, 0x16($a1)
    /* F3D34 80103534 00000000 */  nop
    /* F3D38 80103538 00160200 */  sll        $v0, $v0, 24
    /* F3D3C 8010353C 0F004018 */  blez       $v0, .L8010357C
    /* F3D40 80103540 21200000 */   addu      $a0, $zero, $zero
    /* F3D44 80103544 0000A38C */  lw         $v1, 0x0($a1)
  .L80103548:
    /* F3D48 80103548 00000000 */  nop
    /* F3D4C 8010354C 0400628C */  lw         $v0, 0x4($v1)
    /* F3D50 80103550 00000000 */  nop
    /* F3D54 80103554 0A005010 */  beq        $v0, $s0, .L80103580
    /* F3D58 80103558 21106000 */   addu      $v0, $v1, $zero
    /* F3D5C 8010355C 2C006324 */  addiu      $v1, $v1, 0x2C
    /* F3D60 80103560 1600A290 */  lbu        $v0, 0x16($a1)
    /* F3D64 80103564 01008424 */  addiu      $a0, $a0, 0x1
    /* F3D68 80103568 00160200 */  sll        $v0, $v0, 24
    /* F3D6C 8010356C 03160200 */  sra        $v0, $v0, 24
    /* F3D70 80103570 2A108200 */  slt        $v0, $a0, $v0
    /* F3D74 80103574 F4FF4014 */  bnez       $v0, .L80103548
    /* F3D78 80103578 00000000 */   nop
  .L8010357C:
    /* F3D7C 8010357C 21100000 */  addu       $v0, $zero, $zero
  .L80103580:
    /* F3D80 80103580 1400BF8F */  lw         $ra, 0x14($sp)
    /* F3D84 80103584 1000B08F */  lw         $s0, 0x10($sp)
    /* F3D88 80103588 0800E003 */  jr         $ra
    /* F3D8C 8010358C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel iSNDstreamgetrequestptr
