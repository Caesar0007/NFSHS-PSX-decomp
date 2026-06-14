.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDstreamremoverequest, 0x12C

glabel iSNDstreamremoverequest
    /* D9464 800E8C64 1480023C */  lui        $v0, %hi(sndss)
    /* D9468 800E8C68 80EA4224 */  addiu      $v0, $v0, %lo(sndss)
    /* D946C 800E8C6C FF008330 */  andi       $v1, $a0, 0xFF
    /* D9470 800E8C70 80180300 */  sll        $v1, $v1, 2
    /* D9474 800E8C74 21186200 */  addu       $v1, $v1, $v0
    /* D9478 800E8C78 0000658C */  lw         $a1, 0x0($v1)
    /* D947C 800E8C7C 21500000 */  addu       $t2, $zero, $zero
    /* D9480 800E8C80 1600A290 */  lbu        $v0, 0x16($a1)
    /* D9484 800E8C84 00000000 */  nop
    /* D9488 800E8C88 00160200 */  sll        $v0, $v0, 24
    /* D948C 800E8C8C 2F004018 */  blez       $v0, .L800E8D4C
    /* D9490 800E8C90 21384001 */   addu      $a3, $t2, $zero
    /* D9494 800E8C94 21484001 */  addu       $t1, $t2, $zero
    /* D9498 800E8C98 21404001 */  addu       $t0, $t2, $zero
  .L800E8C9C:
    /* D949C 800E8C9C 0000A28C */  lw         $v0, 0x0($a1)
    /* D94A0 800E8CA0 00000000 */  nop
    /* D94A4 800E8CA4 21184900 */  addu       $v1, $v0, $t1
    /* D94A8 800E8CA8 0400628C */  lw         $v0, 0x4($v1)
    /* D94AC 800E8CAC 00000000 */  nop
    /* D94B0 800E8CB0 1E004410 */  beq        $v0, $a0, .L800E8D2C
    /* D94B4 800E8CB4 00000000 */   nop
    /* D94B8 800E8CB8 1700A290 */  lbu        $v0, 0x17($a1)
    /* D94BC 800E8CBC 00000000 */  nop
    /* D94C0 800E8CC0 00160200 */  sll        $v0, $v0, 24
    /* D94C4 800E8CC4 03160200 */  sra        $v0, $v0, 24
    /* D94C8 800E8CC8 02004714 */  bne        $v0, $a3, .L800E8CD4
    /* D94CC 800E8CCC 00000000 */   nop
    /* D94D0 800E8CD0 1700AAA0 */  sb         $t2, 0x17($a1)
  .L800E8CD4:
    /* D94D4 800E8CD4 0000A28C */  lw         $v0, 0x0($a1)
    /* D94D8 800E8CD8 20006624 */  addiu      $a2, $v1, 0x20
    /* D94DC 800E8CDC 21100201 */  addu       $v0, $t0, $v0
  .L800E8CE0:
    /* D94E0 800E8CE0 00006B8C */  lw         $t3, 0x0($v1)
    /* D94E4 800E8CE4 04006C8C */  lw         $t4, 0x4($v1)
    /* D94E8 800E8CE8 08006D8C */  lw         $t5, 0x8($v1)
    /* D94EC 800E8CEC 0C006E8C */  lw         $t6, 0xC($v1)
    /* D94F0 800E8CF0 00004BAC */  sw         $t3, 0x0($v0)
    /* D94F4 800E8CF4 04004CAC */  sw         $t4, 0x4($v0)
    /* D94F8 800E8CF8 08004DAC */  sw         $t5, 0x8($v0)
    /* D94FC 800E8CFC 0C004EAC */  sw         $t6, 0xC($v0)
    /* D9500 800E8D00 10006324 */  addiu      $v1, $v1, 0x10
    /* D9504 800E8D04 F6FF6614 */  bne        $v1, $a2, .L800E8CE0
    /* D9508 800E8D08 10004224 */   addiu     $v0, $v0, 0x10
    /* D950C 800E8D0C 00006B8C */  lw         $t3, 0x0($v1)
    /* D9510 800E8D10 04006C8C */  lw         $t4, 0x4($v1)
    /* D9514 800E8D14 08006D8C */  lw         $t5, 0x8($v1)
    /* D9518 800E8D18 00004BAC */  sw         $t3, 0x0($v0)
    /* D951C 800E8D1C 04004CAC */  sw         $t4, 0x4($v0)
    /* D9520 800E8D20 08004DAC */  sw         $t5, 0x8($v0)
    /* D9524 800E8D24 2C000825 */  addiu      $t0, $t0, 0x2C
    /* D9528 800E8D28 01004A25 */  addiu      $t2, $t2, 0x1
  .L800E8D2C:
    /* D952C 800E8D2C 2C002925 */  addiu      $t1, $t1, 0x2C
    /* D9530 800E8D30 1600A290 */  lbu        $v0, 0x16($a1)
    /* D9534 800E8D34 0100E724 */  addiu      $a3, $a3, 0x1
    /* D9538 800E8D38 00160200 */  sll        $v0, $v0, 24
    /* D953C 800E8D3C 03160200 */  sra        $v0, $v0, 24
    /* D9540 800E8D40 2A10E200 */  slt        $v0, $a3, $v0
    /* D9544 800E8D44 D5FF4014 */  bnez       $v0, .L800E8C9C
    /* D9548 800E8D48 00000000 */   nop
  .L800E8D4C:
    /* D954C 800E8D4C 1600A290 */  lbu        $v0, 0x16($a1)
    /* D9550 800E8D50 00000000 */  nop
    /* D9554 800E8D54 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* D9558 800E8D58 1600A2A0 */  sb         $v0, 0x16($a1)
    /* D955C 800E8D5C 1700A390 */  lbu        $v1, 0x17($a1)
    /* D9560 800E8D60 1600A290 */  lbu        $v0, 0x16($a1)
    /* D9564 800E8D64 001E0300 */  sll        $v1, $v1, 24
    /* D9568 800E8D68 00160200 */  sll        $v0, $v0, 24
    /* D956C 800E8D6C 2A104300 */  slt        $v0, $v0, $v1
    /* D9570 800E8D70 05004010 */  beqz       $v0, .L800E8D88
    /* D9574 800E8D74 00000000 */   nop
    /* D9578 800E8D78 1700A290 */  lbu        $v0, 0x17($a1)
    /* D957C 800E8D7C 00000000 */  nop
    /* D9580 800E8D80 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* D9584 800E8D84 1700A2A0 */  sb         $v0, 0x17($a1)
  .L800E8D88:
    /* D9588 800E8D88 0800E003 */  jr         $ra
    /* D958C 800E8D8C 00000000 */   nop
endlabel iSNDstreamremoverequest
