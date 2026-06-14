.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawC_PrimStop__FP8Car_tObjP13Draw_CarCache, 0xC0

glabel DrawC_PrimStop__FP8Car_tObjP13Draw_CarCache
    /* B0484 800BFC84 7C088284 */  lh         $v0, 0x87C($a0)
    /* B0488 800BFC88 00000000 */  nop
    /* B048C 800BFC8C 2B004014 */  bnez       $v0, .L800BFD3C
    /* B0490 800BFC90 2148A000 */   addu      $t1, $a1, $zero
    /* B0494 800BFC94 7808858C */  lw         $a1, 0x878($a0)
    /* B0498 800BFC98 00000000 */  nop
    /* B049C 800BFC9C 0D00A010 */  beqz       $a1, .L800BFCD4
    /* B04A0 800BFCA0 00000000 */   nop
    /* B04A4 800BFCA4 7C08A284 */  lh         $v0, 0x87C($a1)
    /* B04A8 800BFCA8 7C08A394 */  lhu        $v1, 0x87C($a1)
    /* B04AC 800BFCAC 05004010 */  beqz       $v0, .L800BFCC4
    /* B04B0 800BFCB0 FFFF6224 */   addiu     $v0, $v1, -0x1
    /* B04B4 800BFCB4 7C08A2A4 */  sh         $v0, 0x87C($a1)
    /* B04B8 800BFCB8 00140200 */  sll        $v0, $v0, 16
    /* B04BC 800BFCBC 1F004014 */  bnez       $v0, .L800BFD3C
    /* B04C0 800BFCC0 00000000 */   nop
  .L800BFCC4:
    /* B04C4 800BFCC4 7008A28C */  lw         $v0, 0x870($a1)
    /* B04C8 800BFCC8 6408A48C */  lw         $a0, 0x864($a1)
    /* B04CC 800BFCCC 38FF0208 */  j          .L800BFCE0
    /* B04D0 800BFCD0 FFFF4824 */   addiu     $t0, $v0, -0x1
  .L800BFCD4:
    /* B04D4 800BFCD4 7008828C */  lw         $v0, 0x870($a0)
    /* B04D8 800BFCD8 6408848C */  lw         $a0, 0x864($a0)
    /* B04DC 800BFCDC FFFF4824 */  addiu      $t0, $v0, -0x1
  .L800BFCE0:
    /* B04E0 800BFCE0 FF00063C */  lui        $a2, (0xFFFFFF >> 16)
    /* B04E4 800BFCE4 FFFFC634 */  ori        $a2, $a2, (0xFFFFFF & 0xFFFF)
    /* B04E8 800BFCE8 80280400 */  sll        $a1, $a0, 2
    /* B04EC 800BFCEC 00FF073C */  lui        $a3, (0xFF000000 >> 16)
    /* B04F0 800BFCF0 0000228D */  lw         $v0, 0x0($t1)
    /* B04F4 800BFCF4 3800248D */  lw         $a0, 0x38($t1)
    /* B04F8 800BFCF8 2110A200 */  addu       $v0, $a1, $v0
    /* B04FC 800BFCFC 0000838C */  lw         $v1, 0x0($a0)
    /* B0500 800BFD00 0000428C */  lw         $v0, 0x0($v0)
    /* B0504 800BFD04 24186700 */  and        $v1, $v1, $a3
    /* B0508 800BFD08 24104600 */  and        $v0, $v0, $a2
    /* B050C 800BFD0C 25186200 */  or         $v1, $v1, $v0
    /* B0510 800BFD10 000083AC */  sw         $v1, 0x0($a0)
    /* B0514 800BFD14 0000228D */  lw         $v0, 0x0($t1)
    /* B0518 800BFD18 80180800 */  sll        $v1, $t0, 2
    /* B051C 800BFD1C 2128A200 */  addu       $a1, $a1, $v0
    /* B0520 800BFD20 0000A48C */  lw         $a0, 0x0($a1)
    /* B0524 800BFD24 3800228D */  lw         $v0, 0x38($t1)
    /* B0528 800BFD28 24208700 */  and        $a0, $a0, $a3
    /* B052C 800BFD2C 21104300 */  addu       $v0, $v0, $v1
    /* B0530 800BFD30 24104600 */  and        $v0, $v0, $a2
    /* B0534 800BFD34 25208200 */  or         $a0, $a0, $v0
    /* B0538 800BFD38 0000A4AC */  sw         $a0, 0x0($a1)
  .L800BFD3C:
    /* B053C 800BFD3C 0800E003 */  jr         $ra
    /* B0540 800BFD40 00000000 */   nop
endlabel DrawC_PrimStop__FP8Car_tObjP13Draw_CarCache
