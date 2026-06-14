.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIWorld_CheckForBarrierBetweenLanes__Fiii, 0x74

glabel AIWorld_CheckForBarrierBetweenLanes__Fiii
    /* 63C58 80073458 1480023C */  lui        $v0, %hi(BWorldSm_slices)
    /* 63C5C 8007345C C0C7428C */  lw         $v0, %lo(BWorldSm_slices)($v0)
    /* 63C60 80073460 40210400 */  sll        $a0, $a0, 5
    /* 63C64 80073464 21208200 */  addu       $a0, $a0, $v0
    /* 63C68 80073468 0E000224 */  addiu      $v0, $zero, 0xE
    /* 63C6C 8007346C 23284500 */  subu       $a1, $v0, $a1
    /* 63C70 80073470 23184600 */  subu       $v1, $v0, $a2
    /* 63C74 80073474 2A106500 */  slt        $v0, $v1, $a1
    /* 63C78 80073478 16008484 */  lh         $a0, 0x16($a0)
    /* 63C7C 8007347C 0A004014 */  bnez       $v0, .L800734A8
    /* 63C80 80073480 00000000 */   nop
    /* 63C84 80073484 27100400 */  nor        $v0, $zero, $a0
    /* 63C88 80073488 0710A200 */  srav       $v0, $v0, $a1
    /* 63C8C 8007348C 23206500 */  subu       $a0, $v1, $a1
    /* 63C90 80073490 01008424 */  addiu      $a0, $a0, 0x1
    /* 63C94 80073494 FFFF0324 */  addiu      $v1, $zero, -0x1
    /* 63C98 80073498 04188300 */  sllv       $v1, $v1, $a0
    /* 63C9C 8007349C 27180300 */  nor        $v1, $zero, $v1
    /* 63CA0 800734A0 0800E003 */  jr         $ra
    /* 63CA4 800734A4 24104300 */   and       $v0, $v0, $v1
  .L800734A8:
    /* 63CA8 800734A8 27100400 */  nor        $v0, $zero, $a0
    /* 63CAC 800734AC 07106200 */  srav       $v0, $v0, $v1
    /* 63CB0 800734B0 2320A300 */  subu       $a0, $a1, $v1
    /* 63CB4 800734B4 01008424 */  addiu      $a0, $a0, 0x1
    /* 63CB8 800734B8 FFFF0324 */  addiu      $v1, $zero, -0x1
    /* 63CBC 800734BC 04188300 */  sllv       $v1, $v1, $a0
    /* 63CC0 800734C0 27180300 */  nor        $v1, $zero, $v1
    /* 63CC4 800734C4 0800E003 */  jr         $ra
    /* 63CC8 800734C8 24104300 */   and       $v0, $v0, $v1
endlabel AIWorld_CheckForBarrierBetweenLanes__Fiii
