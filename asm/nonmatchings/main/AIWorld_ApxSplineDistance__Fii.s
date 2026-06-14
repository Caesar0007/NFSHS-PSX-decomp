.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIWorld_ApxSplineDistance__Fii, 0x68

glabel AIWorld_ApxSplineDistance__Fii
    /* 639BC 800731BC 1480033C */  lui        $v1, %hi(gNumSlices)
    /* 639C0 800731C0 C8C7638C */  lw         $v1, %lo(gNumSlices)($v1)
    /* 639C4 800731C4 23208500 */  subu       $a0, $a0, $a1
    /* 639C8 800731C8 C2170300 */  srl        $v0, $v1, 31
    /* 639CC 800731CC 21106200 */  addu       $v0, $v1, $v0
    /* 639D0 800731D0 06008018 */  blez       $a0, .L800731EC
    /* 639D4 800731D4 43280200 */   sra       $a1, $v0, 1
    /* 639D8 800731D8 2A10A400 */  slt        $v0, $a1, $a0
    /* 639DC 800731DC 03004010 */  beqz       $v0, .L800731EC
    /* 639E0 800731E0 00000000 */   nop
    /* 639E4 800731E4 85CC0108 */  j          .L80073214
    /* 639E8 800731E8 23208300 */   subu      $a0, $a0, $v1
  .L800731EC:
    /* 639EC 800731EC 0A008104 */  bgez       $a0, .L80073218
    /* 639F0 800731F0 40100400 */   sll       $v0, $a0, 1
    /* 639F4 800731F4 23100500 */  negu       $v0, $a1
    /* 639F8 800731F8 2A108200 */  slt        $v0, $a0, $v0
    /* 639FC 800731FC 05004010 */  beqz       $v0, .L80073214
    /* 63A00 80073200 00000000 */   nop
    /* 63A04 80073204 1480023C */  lui        $v0, %hi(gNumSlices)
    /* 63A08 80073208 C8C7428C */  lw         $v0, %lo(gNumSlices)($v0)
    /* 63A0C 8007320C 00000000 */  nop
    /* 63A10 80073210 21208200 */  addu       $a0, $a0, $v0
  .L80073214:
    /* 63A14 80073214 40100400 */  sll        $v0, $a0, 1
  .L80073218:
    /* 63A18 80073218 21104400 */  addu       $v0, $v0, $a0
    /* 63A1C 8007321C 0800E003 */  jr         $ra
    /* 63A20 80073220 40140200 */   sll       $v0, $v0, 17
endlabel AIWorld_ApxSplineDistance__Fii
