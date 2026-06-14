.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching BWorld_CheckChunkVisible__FP12BWorldSm_PosT0, 0x140

glabel BWorld_CheckChunkVisible__FP12BWorldSm_PosT0
    /* 6E414 8007DC14 4D008510 */  beq        $a0, $a1, .L8007DD4C
    /* 6E418 8007DC18 01000224 */   addiu     $v0, $zero, 0x1
    /* 6E41C 8007DC1C 0000A784 */  lh         $a3, 0x0($a1)
    /* 6E420 8007DC20 1480033C */  lui        $v1, %hi(gNumSlices)
    /* 6E424 8007DC24 C8C7638C */  lw         $v1, %lo(gNumSlices)($v1)
    /* 6E428 8007DC28 0200E624 */  addiu      $a2, $a3, 0x2
    /* 6E42C 8007DC2C 2A10C300 */  slt        $v0, $a2, $v1
    /* 6E430 8007DC30 05004010 */  beqz       $v0, .L8007DC48
    /* 6E434 8007DC34 40110600 */   sll       $v0, $a2, 5
    /* 6E438 8007DC38 1480033C */  lui        $v1, %hi(BWorldSm_slices)
    /* 6E43C 8007DC3C C0C7638C */  lw         $v1, %lo(BWorldSm_slices)($v1)
    /* 6E440 8007DC40 18F70108 */  j          .L8007DC60
    /* 6E444 8007DC44 21186200 */   addu      $v1, $v1, $v0
  .L8007DC48:
    /* 6E448 8007DC48 FEFF6224 */  addiu      $v0, $v1, -0x2
    /* 6E44C 8007DC4C 2310E200 */  subu       $v0, $a3, $v0
    /* 6E450 8007DC50 1480033C */  lui        $v1, %hi(BWorldSm_slices)
    /* 6E454 8007DC54 C0C7638C */  lw         $v1, %lo(BWorldSm_slices)($v1)
    /* 6E458 8007DC58 40110200 */  sll        $v0, $v0, 5
    /* 6E45C 8007DC5C 21186200 */  addu       $v1, $v1, $v0
  .L8007DC60:
    /* 6E460 8007DC60 0000A584 */  lh         $a1, 0x0($a1)
    /* 6E464 8007DC64 1C006B90 */  lbu        $t3, 0x1C($v1)
    /* 6E468 8007DC68 FEFFA224 */  addiu      $v0, $a1, -0x2
    /* 6E46C 8007DC6C 05004004 */  bltz       $v0, .L8007DC84
    /* 6E470 8007DC70 40110200 */   sll       $v0, $v0, 5
    /* 6E474 8007DC74 1480033C */  lui        $v1, %hi(BWorldSm_slices)
    /* 6E478 8007DC78 C0C7638C */  lw         $v1, %lo(BWorldSm_slices)($v1)
    /* 6E47C 8007DC7C 29F70108 */  j          .L8007DCA4
    /* 6E480 8007DC80 21286200 */   addu      $a1, $v1, $v0
  .L8007DC84:
    /* 6E484 8007DC84 1480023C */  lui        $v0, %hi(gNumSlices)
    /* 6E488 8007DC88 C8C7428C */  lw         $v0, %lo(gNumSlices)($v0)
    /* 6E48C 8007DC8C 1480033C */  lui        $v1, %hi(BWorldSm_slices)
    /* 6E490 8007DC90 C0C7638C */  lw         $v1, %lo(BWorldSm_slices)($v1)
    /* 6E494 8007DC94 FEFF4224 */  addiu      $v0, $v0, -0x2
    /* 6E498 8007DC98 2110A200 */  addu       $v0, $a1, $v0
    /* 6E49C 8007DC9C 40110200 */  sll        $v0, $v0, 5
    /* 6E4A0 8007DCA0 21286200 */  addu       $a1, $v1, $v0
  .L8007DCA4:
    /* 6E4A4 8007DCA4 75008390 */  lbu        $v1, 0x75($a0)
    /* 6E4A8 8007DCA8 1480023C */  lui        $v0, %hi(Track_gInViewCount)
    /* 6E4AC 8007DCAC B0D4428C */  lw         $v0, %lo(Track_gInViewCount)($v0)
    /* 6E4B0 8007DCB0 00000000 */  nop
    /* 6E4B4 8007DCB4 21104300 */  addu       $v0, $v0, $v1
    /* 6E4B8 8007DCB8 80190300 */  sll        $v1, $v1, 6
    /* 6E4BC 8007DCBC 00004790 */  lbu        $a3, 0x0($v0)
    /* 6E4C0 8007DCC0 1480023C */  lui        $v0, %hi(Track_gInViewList)
    /* 6E4C4 8007DCC4 ACD4428C */  lw         $v0, %lo(Track_gInViewList)($v0)
    /* 6E4C8 8007DCC8 FFFFE724 */  addiu      $a3, $a3, -0x1
    /* 6E4CC 8007DCCC 21204300 */  addu       $a0, $v0, $v1
    /* 6E4D0 8007DCD0 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 6E4D4 8007DCD4 1C00A390 */  lbu        $v1, 0x1C($a1)
    /* 6E4D8 8007DCD8 1900E210 */  beq        $a3, $v0, .L8007DD40
    /* 6E4DC 8007DCDC 21300000 */   addu      $a2, $zero, $zero
    /* 6E4E0 8007DCE0 01000924 */  addiu      $t1, $zero, 0x1
    /* 6E4E4 8007DCE4 21504000 */  addu       $t2, $v0, $zero
    /* 6E4E8 8007DCE8 04102701 */  sllv       $v0, $a3, $t1
    /* 6E4EC 8007DCEC 21404400 */  addu       $t0, $v0, $a0
  .L8007DCF0:
    /* 6E4F0 8007DCF0 00000485 */  lh         $a0, 0x0($t0)
    /* 6E4F4 8007DCF4 00000000 */  nop
    /* 6E4F8 8007DCF8 FF038530 */  andi       $a1, $a0, 0x3FF
    /* 6E4FC 8007DCFC 0600AB14 */  bne        $a1, $t3, .L8007DD18
    /* 6E500 8007DD00 00088230 */   andi      $v0, $a0, 0x800
    /* 6E504 8007DD04 0F004014 */  bnez       $v0, .L8007DD44
    /* 6E508 8007DD08 0200C238 */   xori      $v0, $a2, 0x2
    /* 6E50C 8007DD0C 0100C624 */  addiu      $a2, $a2, 0x1
    /* 6E510 8007DD10 0C00C914 */  bne        $a2, $t1, .L8007DD44
    /* 6E514 8007DD14 0200C238 */   xori      $v0, $a2, 0x2
  .L8007DD18:
    /* 6E518 8007DD18 0600A314 */  bne        $a1, $v1, .L8007DD34
    /* 6E51C 8007DD1C 00088230 */   andi      $v0, $a0, 0x800
    /* 6E520 8007DD20 08004014 */  bnez       $v0, .L8007DD44
    /* 6E524 8007DD24 0200C238 */   xori      $v0, $a2, 0x2
    /* 6E528 8007DD28 0100C624 */  addiu      $a2, $a2, 0x1
    /* 6E52C 8007DD2C 0500C914 */  bne        $a2, $t1, .L8007DD44
    /* 6E530 8007DD30 0200C238 */   xori      $v0, $a2, 0x2
  .L8007DD34:
    /* 6E534 8007DD34 FFFFE724 */  addiu      $a3, $a3, -0x1
    /* 6E538 8007DD38 EDFFEA14 */  bne        $a3, $t2, .L8007DCF0
    /* 6E53C 8007DD3C FEFF0825 */   addiu     $t0, $t0, -0x2
  .L8007DD40:
    /* 6E540 8007DD40 0200C238 */  xori       $v0, $a2, 0x2
  .L8007DD44:
    /* 6E544 8007DD44 0800E003 */  jr         $ra
    /* 6E548 8007DD48 0100422C */   sltiu     $v0, $v0, 0x1
  .L8007DD4C:
    /* 6E54C 8007DD4C 0800E003 */  jr         $ra
    /* 6E550 8007DD50 00000000 */   nop
endlabel BWorld_CheckChunkVisible__FP12BWorldSm_PosT0
