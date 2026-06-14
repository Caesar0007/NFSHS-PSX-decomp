.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIWorld_CalculateLaneInfo__FP8Car_tObj, 0xC4

glabel AIWorld_CalculateLaneInfo__FP8Car_tObj
    /* 63D94 80073594 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 63D98 80073598 1400B1AF */  sw         $s1, 0x14($sp)
    /* 63D9C 8007359C 21888000 */  addu       $s1, $a0, $zero
    /* 63DA0 800735A0 1800BFAF */  sw         $ra, 0x18($sp)
    /* 63DA4 800735A4 1000B0AF */  sw         $s0, 0x10($sp)
    /* 63DA8 800735A8 7005228E */  lw         $v0, 0x570($s1)
    /* 63DAC 800735AC 00000000 */  nop
    /* 63DB0 800735B0 04004230 */  andi       $v0, $v0, 0x4
    /* 63DB4 800735B4 23004014 */  bnez       $v0, .L80073644
    /* 63DB8 800735B8 4C0520AE */   sw        $zero, 0x54C($s1)
    /* 63DBC 800735BC 08002486 */  lh         $a0, 0x8($s1)
    /* 63DC0 800735C0 7405258E */  lw         $a1, 0x574($s1)
    /* 63DC4 800735C4 33CD010C */  jal        AIWorld_LaneIndex__Fii
    /* 63DC8 800735C8 00801034 */   ori       $s0, $zero, 0x8000
    /* 63DCC 800735CC 08002486 */  lh         $a0, 0x8($s1)
    /* 63DD0 800735D0 7405258E */  lw         $a1, 0x574($s1)
    /* 63DD4 800735D4 6C02238E */  lw         $v1, 0x26C($s1)
    /* 63DD8 800735D8 C40622AE */  sw         $v0, 0x6C4($s1)
    /* 63DDC 800735DC 2328A300 */  subu       $a1, $a1, $v1
    /* 63DE0 800735E0 33CD010C */  jal        AIWorld_LaneIndex__Fii
    /* 63DE4 800735E4 2128B000 */   addu      $a1, $a1, $s0
    /* 63DE8 800735E8 7405258E */  lw         $a1, 0x574($s1)
    /* 63DEC 800735EC 6C02238E */  lw         $v1, 0x26C($s1)
    /* 63DF0 800735F0 08002486 */  lh         $a0, 0x8($s1)
    /* 63DF4 800735F4 2128A300 */  addu       $a1, $a1, $v1
    /* 63DF8 800735F8 2328B000 */  subu       $a1, $a1, $s0
    /* 63DFC 800735FC 33CD010C */  jal        AIWorld_LaneIndex__Fii
    /* 63E00 80073600 21804000 */   addu      $s0, $v0, $zero
    /* 63E04 80073604 21284000 */  addu       $a1, $v0, $zero
    /* 63E08 80073608 0E00A22C */  sltiu      $v0, $a1, 0xE
    /* 63E0C 8007360C 0D004010 */  beqz       $v0, .L80073644
    /* 63E10 80073610 0E00022E */   sltiu     $v0, $s0, 0xE
    /* 63E14 80073614 0B004010 */  beqz       $v0, .L80073644
    /* 63E18 80073618 2A10B000 */   slt       $v0, $a1, $s0
    /* 63E1C 8007361C 09004014 */  bnez       $v0, .L80073644
    /* 63E20 80073620 21200002 */   addu      $a0, $s0, $zero
    /* 63E24 80073624 01000624 */  addiu      $a2, $zero, 0x1
  .L80073628:
    /* 63E28 80073628 04108600 */  sllv       $v0, $a2, $a0
    /* 63E2C 8007362C 4C05238E */  lw         $v1, 0x54C($s1)
    /* 63E30 80073630 01008424 */  addiu      $a0, $a0, 0x1
    /* 63E34 80073634 25186200 */  or         $v1, $v1, $v0
    /* 63E38 80073638 2A10A400 */  slt        $v0, $a1, $a0
    /* 63E3C 8007363C FAFF4010 */  beqz       $v0, .L80073628
    /* 63E40 80073640 4C0523AE */   sw        $v1, 0x54C($s1)
  .L80073644:
    /* 63E44 80073644 1800BF8F */  lw         $ra, 0x18($sp)
    /* 63E48 80073648 1400B18F */  lw         $s1, 0x14($sp)
    /* 63E4C 8007364C 1000B08F */  lw         $s0, 0x10($sp)
    /* 63E50 80073650 0800E003 */  jr         $ra
    /* 63E54 80073654 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel AIWorld_CalculateLaneInfo__FP8Car_tObj
