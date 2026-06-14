.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Newton_FindGroundElevationRough__FP8coorddefN20, 0x1D4

glabel Newton_FindGroundElevationRough__FP8coorddefN20
    /* 9048C 8009FC8C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 90490 8009FC90 1400B1AF */  sw         $s1, 0x14($sp)
    /* 90494 8009FC94 2188C000 */  addu       $s1, $a2, $zero
    /* 90498 8009FC98 1800BFAF */  sw         $ra, 0x18($sp)
    /* 9049C 8009FC9C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 904A0 8009FCA0 0000A68C */  lw         $a2, 0x0($a1)
    /* 904A4 8009FCA4 00000000 */  nop
    /* 904A8 8009FCA8 0200C104 */  bgez       $a2, .L8009FCB4
    /* 904AC 8009FCAC 21800000 */   addu      $s0, $zero, $zero
    /* 904B0 8009FCB0 FF00C624 */  addiu      $a2, $a2, 0xFF
  .L8009FCB4:
    /* 904B4 8009FCB4 0000838C */  lw         $v1, 0x0($a0)
    /* 904B8 8009FCB8 0000228E */  lw         $v0, 0x0($s1)
    /* 904BC 8009FCBC 00000000 */  nop
    /* 904C0 8009FCC0 23106200 */  subu       $v0, $v1, $v0
    /* 904C4 8009FCC4 02004104 */  bgez       $v0, .L8009FCD0
    /* 904C8 8009FCC8 031A0600 */   sra       $v1, $a2, 8
    /* 904CC 8009FCCC FF004224 */  addiu      $v0, $v0, 0xFF
  .L8009FCD0:
    /* 904D0 8009FCD0 03120200 */  sra        $v0, $v0, 8
    /* 904D4 8009FCD4 18006200 */  mult       $v1, $v0
    /* 904D8 8009FCD8 0800A68C */  lw         $a2, 0x8($a1)
    /* 904DC 8009FCDC 12500000 */  mflo       $t2
    /* 904E0 8009FCE0 0200C104 */  bgez       $a2, .L8009FCEC
    /* 904E4 8009FCE4 23400A00 */   negu      $t0, $t2
    /* 904E8 8009FCE8 FF00C624 */  addiu      $a2, $a2, 0xFF
  .L8009FCEC:
    /* 904EC 8009FCEC 0800838C */  lw         $v1, 0x8($a0)
    /* 904F0 8009FCF0 0800228E */  lw         $v0, 0x8($s1)
    /* 904F4 8009FCF4 00000000 */  nop
    /* 904F8 8009FCF8 23106200 */  subu       $v0, $v1, $v0
    /* 904FC 8009FCFC 02004104 */  bgez       $v0, .L8009FD08
    /* 90500 8009FD00 031A0600 */   sra       $v1, $a2, 8
    /* 90504 8009FD04 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8009FD08:
    /* 90508 8009FD08 03120200 */  sra        $v0, $v0, 8
    /* 9050C 8009FD0C 18006200 */  mult       $v1, $v0
    /* 90510 8009FD10 21380000 */  addu       $a3, $zero, $zero
    /* 90514 8009FD14 1180023C */  lui        $v0, %hi(fudgeTable)
    /* 90518 8009FD18 E4404924 */  addiu      $t1, $v0, %lo(fudgeTable)
    /* 9051C 8009FD1C 12500000 */  mflo       $t2
    /* 90520 8009FD20 23400A01 */  subu       $t0, $t0, $t2
  .L8009FD24:
    /* 90524 8009FD24 0F00E014 */  bnez       $a3, .L8009FD64
    /* 90528 8009FD28 00000000 */   nop
    /* 9052C 8009FD2C 0000828C */  lw         $v0, 0x0($a0)
    /* 90530 8009FD30 0800838C */  lw         $v1, 0x8($a0)
    /* 90534 8009FD34 02004104 */  bgez       $v0, .L8009FD40
    /* 90538 8009FD38 21304000 */   addu      $a2, $v0, $zero
    /* 9053C 8009FD3C 23300600 */  negu       $a2, $a2
  .L8009FD40:
    /* 90540 8009FD40 43180300 */  sra        $v1, $v1, 1
    /* 90544 8009FD44 02006104 */  bgez       $v1, .L8009FD50
    /* 90548 8009FD48 00000000 */   nop
    /* 9054C 8009FD4C 23180300 */  negu       $v1, $v1
  .L8009FD50:
    /* 90550 8009FD50 2A106600 */  slt        $v0, $v1, $a2
    /* 90554 8009FD54 0F004014 */  bnez       $v0, .L8009FD94
    /* 90558 8009FD58 00000000 */   nop
    /* 9055C 8009FD5C 697F0208 */  j          .L8009FDA4
    /* 90560 8009FD60 83100600 */   sra       $v0, $a2, 2
  .L8009FD64:
    /* 90564 8009FD64 0000828C */  lw         $v0, 0x0($a0)
    /* 90568 8009FD68 0800838C */  lw         $v1, 0x8($a0)
    /* 9056C 8009FD6C 83100200 */  sra        $v0, $v0, 2
    /* 90570 8009FD70 02004104 */  bgez       $v0, .L8009FD7C
    /* 90574 8009FD74 21304000 */   addu      $a2, $v0, $zero
    /* 90578 8009FD78 23300600 */  negu       $a2, $a2
  .L8009FD7C:
    /* 9057C 8009FD7C 02006104 */  bgez       $v1, .L8009FD88
    /* 90580 8009FD80 00000000 */   nop
    /* 90584 8009FD84 23180300 */  negu       $v1, $v1
  .L8009FD88:
    /* 90588 8009FD88 2A106600 */  slt        $v0, $v1, $a2
    /* 9058C 8009FD8C 04004010 */  beqz       $v0, .L8009FDA0
    /* 90590 8009FD90 00000000 */   nop
  .L8009FD94:
    /* 90594 8009FD94 83100300 */  sra        $v0, $v1, 2
    /* 90598 8009FD98 6A7F0208 */  j          .L8009FDA8
    /* 9059C 8009FD9C 2118C200 */   addu      $v1, $a2, $v0
  .L8009FDA0:
    /* 905A0 8009FDA0 83100600 */  sra        $v0, $a2, 2
  .L8009FDA4:
    /* 905A4 8009FDA4 21186200 */  addu       $v1, $v1, $v0
  .L8009FDA8:
    /* 905A8 8009FDA8 C3130300 */  sra        $v0, $v1, 15
    /* 905AC 8009FDAC 02004104 */  bgez       $v0, .L8009FDB8
    /* 905B0 8009FDB0 21184000 */   addu      $v1, $v0, $zero
    /* 905B4 8009FDB4 23180300 */  negu       $v1, $v1
  .L8009FDB8:
    /* 905B8 8009FDB8 02006104 */  bgez       $v1, .L8009FDC4
    /* 905BC 8009FDBC 21106000 */   addu      $v0, $v1, $zero
    /* 905C0 8009FDC0 1F006224 */  addiu      $v0, $v1, 0x1F
  .L8009FDC4:
    /* 905C4 8009FDC4 43110200 */  sra        $v0, $v0, 5
    /* 905C8 8009FDC8 40110200 */  sll        $v0, $v0, 5
    /* 905CC 8009FDCC 23106200 */  subu       $v0, $v1, $v0
    /* 905D0 8009FDD0 40100200 */  sll        $v0, $v0, 1
    /* 905D4 8009FDD4 21104900 */  addu       $v0, $v0, $t1
    /* 905D8 8009FDD8 00004284 */  lh         $v0, 0x0($v0)
    /* 905DC 8009FDDC 0100E724 */  addiu      $a3, $a3, 0x1
    /* 905E0 8009FDE0 C0110200 */  sll        $v0, $v0, 7
    /* 905E4 8009FDE4 21800202 */  addu       $s0, $s0, $v0
    /* 905E8 8009FDE8 0200E228 */  slti       $v0, $a3, 0x2
    /* 905EC 8009FDEC CDFF4014 */  bnez       $v0, .L8009FD24
    /* 905F0 8009FDF0 B89E0234 */   ori       $v0, $zero, 0x9EB8
    /* 905F4 8009FDF4 0400A58C */  lw         $a1, 0x4($a1)
    /* 905F8 8009FDF8 00000000 */  nop
    /* 905FC 8009FDFC 2A104500 */  slt        $v0, $v0, $a1
    /* 90600 8009FE00 0C004010 */  beqz       $v0, .L8009FE34
    /* 90604 8009FE04 0100023C */   lui       $v0, (0x10000 >> 16)
    /* 90608 8009FE08 23104500 */  subu       $v0, $v0, $a1
    /* 9060C 8009FE0C 43120200 */  sra        $v0, $v0, 9
    /* 90610 8009FE10 1180033C */  lui        $v1, %hi(divTable)
    /* 90614 8009FE14 1C406324 */  addiu      $v1, $v1, %lo(divTable)
    /* 90618 8009FE18 80100200 */  sll        $v0, $v0, 2
    /* 9061C 8009FE1C 21104300 */  addu       $v0, $v0, $v1
    /* 90620 8009FE20 0000458C */  lw         $a1, 0x0($v0)
    /* 90624 8009FE24 CA90030C */  jal        fixedmult
    /* 90628 8009FE28 21200001 */   addu      $a0, $t0, $zero
    /* 9062C 8009FE2C 8F7F0208 */  j          .L8009FE3C
    /* 90630 8009FE30 00000000 */   nop
  .L8009FE34:
    /* 90634 8009FE34 0191030C */  jal        rdiv
    /* 90638 8009FE38 21200001 */   addu      $a0, $t0, $zero
  .L8009FE3C:
    /* 9063C 8009FE3C 0400238E */  lw         $v1, 0x4($s1)
    /* 90640 8009FE40 00000000 */  nop
    /* 90644 8009FE44 21104300 */  addu       $v0, $v0, $v1
    /* 90648 8009FE48 21105000 */  addu       $v0, $v0, $s0
    /* 9064C 8009FE4C 1800BF8F */  lw         $ra, 0x18($sp)
    /* 90650 8009FE50 1400B18F */  lw         $s1, 0x14($sp)
    /* 90654 8009FE54 1000B08F */  lw         $s0, 0x10($sp)
    /* 90658 8009FE58 0800E003 */  jr         $ra
    /* 9065C 8009FE5C 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Newton_FindGroundElevationRough__FP8coorddefN20
