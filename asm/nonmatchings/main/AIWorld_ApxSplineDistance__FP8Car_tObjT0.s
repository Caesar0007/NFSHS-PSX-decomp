.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIWorld_ApxSplineDistance__FP8Car_tObjT0, 0x70

glabel AIWorld_ApxSplineDistance__FP8Car_tObjT0
    /* 638B8 800730B8 08008384 */  lh         $v1, 0x8($a0)
    /* 638BC 800730BC 0800A284 */  lh         $v0, 0x8($a1)
    /* 638C0 800730C0 1480043C */  lui        $a0, %hi(gNumSlices)
    /* 638C4 800730C4 C8C7848C */  lw         $a0, %lo(gNumSlices)($a0)
    /* 638C8 800730C8 23186200 */  subu       $v1, $v1, $v0
    /* 638CC 800730CC C2170400 */  srl        $v0, $a0, 31
    /* 638D0 800730D0 21108200 */  addu       $v0, $a0, $v0
    /* 638D4 800730D4 06006018 */  blez       $v1, .L800730F0
    /* 638D8 800730D8 43280200 */   sra       $a1, $v0, 1
    /* 638DC 800730DC 2A10A300 */  slt        $v0, $a1, $v1
    /* 638E0 800730E0 03004010 */  beqz       $v0, .L800730F0
    /* 638E4 800730E4 00000000 */   nop
    /* 638E8 800730E8 46CC0108 */  j          .L80073118
    /* 638EC 800730EC 23186400 */   subu      $v1, $v1, $a0
  .L800730F0:
    /* 638F0 800730F0 0A006104 */  bgez       $v1, .L8007311C
    /* 638F4 800730F4 40100300 */   sll       $v0, $v1, 1
    /* 638F8 800730F8 23100500 */  negu       $v0, $a1
    /* 638FC 800730FC 2A106200 */  slt        $v0, $v1, $v0
    /* 63900 80073100 05004010 */  beqz       $v0, .L80073118
    /* 63904 80073104 00000000 */   nop
    /* 63908 80073108 1480023C */  lui        $v0, %hi(gNumSlices)
    /* 6390C 8007310C C8C7428C */  lw         $v0, %lo(gNumSlices)($v0)
    /* 63910 80073110 00000000 */  nop
    /* 63914 80073114 21186200 */  addu       $v1, $v1, $v0
  .L80073118:
    /* 63918 80073118 40100300 */  sll        $v0, $v1, 1
  .L8007311C:
    /* 6391C 8007311C 21104300 */  addu       $v0, $v0, $v1
    /* 63920 80073120 0800E003 */  jr         $ra
    /* 63924 80073124 40140200 */   sll       $v0, $v0, 17
endlabel AIWorld_ApxSplineDistance__FP8Car_tObjT0
