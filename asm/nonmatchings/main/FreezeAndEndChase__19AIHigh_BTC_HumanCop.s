.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FreezeAndEndChase__19AIHigh_BTC_HumanCop, 0x1D4

glabel FreezeAndEndChase__19AIHigh_BTC_HumanCop
    /* 4DB90 8005D390 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 4DB94 8005D394 1800B2AF */  sw         $s2, 0x18($sp)
    /* 4DB98 8005D398 21908000 */  addu       $s2, $a0, $zero
    /* 4DB9C 8005D39C 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 4DBA0 8005D3A0 1400B1AF */  sw         $s1, 0x14($sp)
    /* 4DBA4 8005D3A4 1000B0AF */  sw         $s0, 0x10($sp)
    /* 4DBA8 8005D3A8 1C00428E */  lw         $v0, 0x1C($s2)
    /* 4DBAC 8005D3AC 00000000 */  nop
    /* 4DBB0 8005D3B0 66004014 */  bnez       $v0, .L8005D54C
    /* 4DBB4 8005D3B4 FF00063C */   lui       $a2, (0xFFFF00 >> 16)
    /* 4DBB8 8005D3B8 1480033C */  lui        $v1, %hi(fastRandom)
    /* 4DBBC 8005D3BC FCD0638C */  lw         $v1, %lo(fastRandom)($v1)
    /* 4DBC0 8005D3C0 1480053C */  lui        $a1, %hi(randSeed)
    /* 4DBC4 8005D3C4 04D1A58C */  lw         $a1, %lo(randSeed)($a1)
    /* 4DBC8 8005D3C8 00000000 */  nop
    /* 4DBCC 8005D3CC 18006500 */  mult       $v1, $a1
    /* 4DBD0 8005D3D0 00FFC634 */  ori        $a2, $a2, (0xFFFF00 & 0xFFFF)
    /* 4DBD4 8005D3D4 12180000 */  mflo       $v1
    /* 4DBD8 8005D3D8 FFFF6430 */  andi       $a0, $v1, 0xFFFF
    /* 4DBDC 8005D3DC 1480013C */  lui        $at, %hi(randtemp)
    /* 4DBE0 8005D3E0 00D123AC */  sw         $v1, %lo(randtemp)($at)
    /* 4DBE4 8005D3E4 24186600 */  and        $v1, $v1, $a2
    /* 4DBE8 8005D3E8 021A0300 */  srl        $v1, $v1, 8
    /* 4DBEC 8005D3EC 40110300 */  sll        $v0, $v1, 5
    /* 4DBF0 8005D3F0 23104300 */  subu       $v0, $v0, $v1
    /* 4DBF4 8005D3F4 80100200 */  sll        $v0, $v0, 2
    /* 4DBF8 8005D3F8 21104300 */  addu       $v0, $v0, $v1
    /* 4DBFC 8005D3FC C0100200 */  sll        $v0, $v0, 3
    /* 4DC00 8005D400 02140200 */  srl        $v0, $v0, 16
    /* 4DC04 8005D404 F401422C */  sltiu      $v0, $v0, 0x1F4
    /* 4DC08 8005D408 1480013C */  lui        $at, %hi(fastRandom)
    /* 4DC0C 8005D40C FCD024AC */  sw         $a0, %lo(fastRandom)($at)
    /* 4DC10 8005D410 02004010 */  beqz       $v0, .L8005D41C
    /* 4DC14 8005D414 FFFF1024 */   addiu     $s0, $zero, -0x1
    /* 4DC18 8005D418 01001024 */  addiu      $s0, $zero, 0x1
  .L8005D41C:
    /* 4DC1C 8005D41C 18008500 */  mult       $a0, $a1
    /* 4DC20 8005D420 12180000 */  mflo       $v1
    /* 4DC24 8005D424 FFFF6230 */  andi       $v0, $v1, 0xFFFF
    /* 4DC28 8005D428 1480013C */  lui        $at, %hi(randtemp)
    /* 4DC2C 8005D42C 00D123AC */  sw         $v1, %lo(randtemp)($at)
    /* 4DC30 8005D430 24186600 */  and        $v1, $v1, $a2
    /* 4DC34 8005D434 021A0300 */  srl        $v1, $v1, 8
    /* 4DC38 8005D438 1480013C */  lui        $at, %hi(fastRandom)
    /* 4DC3C 8005D43C FCD022AC */  sw         $v0, %lo(fastRandom)($at)
    /* 4DC40 8005D440 40110300 */  sll        $v0, $v1, 5
    /* 4DC44 8005D444 23104300 */  subu       $v0, $v0, $v1
    /* 4DC48 8005D448 80100200 */  sll        $v0, $v0, 2
    /* 4DC4C 8005D44C 21104300 */  addu       $v0, $v0, $v1
    /* 4DC50 8005D450 C0100200 */  sll        $v0, $v0, 3
    /* 4DC54 8005D454 02140200 */  srl        $v0, $v0, 16
    /* 4DC58 8005D458 EE02422C */  sltiu      $v0, $v0, 0x2EE
    /* 4DC5C 8005D45C 06004010 */  beqz       $v0, .L8005D478
    /* 4DC60 8005D460 21880000 */   addu      $s1, $zero, $zero
    /* 4DC64 8005D464 1480023C */  lui        $v0, %hi(AIHigh_CopGameType)
    /* 4DC68 8005D468 5CC5428C */  lw         $v0, %lo(AIHigh_CopGameType)($v0)
    /* 4DC6C 8005D46C 00000000 */  nop
    /* 4DC70 8005D470 04004238 */  xori       $v0, $v0, 0x4
    /* 4DC74 8005D474 2B882202 */  sltu       $s1, $s1, $v0
  .L8005D478:
    /* 4DC78 8005D478 0000428E */  lw         $v0, 0x0($s2)
    /* 4DC7C 8005D47C 1480043C */  lui        $a0, %hi(AIDataRecord_TrackCurve)
    /* 4DC80 8005D480 A4C5848C */  lw         $a0, %lo(AIDataRecord_TrackCurve)($a0)
    /* 4DC84 8005D484 08004584 */  lh         $a1, 0x8($v0)
    /* 4DC88 8005D488 E9B4010C */  jal        Get__25AIDataRecord_TrackCurve_ti
    /* 4DC8C 8005D48C 00000000 */   nop
    /* 4DC90 8005D490 42004228 */  slti       $v0, $v0, 0x42
    /* 4DC94 8005D494 07004014 */  bnez       $v0, .L8005D4B4
    /* 4DC98 8005D498 21204002 */   addu      $a0, $s2, $zero
    /* 4DC9C 8005D49C 1480033C */  lui        $v1, %hi(AIHigh_CopGameType)
    /* 4DCA0 8005D4A0 5CC5638C */  lw         $v1, %lo(AIHigh_CopGameType)($v1)
    /* 4DCA4 8005D4A4 04000224 */  addiu      $v0, $zero, 0x4
    /* 4DCA8 8005D4A8 02006210 */  beq        $v1, $v0, .L8005D4B4
    /* 4DCAC 8005D4AC 00000000 */   nop
    /* 4DCB0 8005D4B0 01001124 */  addiu      $s1, $zero, 0x1
  .L8005D4B4:
    /* 4DCB4 8005D4B4 0000428E */  lw         $v0, 0x0($s2)
    /* 4DCB8 8005D4B8 64000624 */  addiu      $a2, $zero, 0x64
    /* 4DCBC 8005D4BC 08004584 */  lh         $a1, 0x8($v0)
    /* 4DCC0 8005D4C0 5474010C */  jal        FindRandomBarrierFreeArea__19AIHigh_BTC_HumanCopiii
    /* 4DCC4 8005D4C4 01000724 */   addiu     $a3, $zero, 0x1
    /* 4DCC8 8005D4C8 6400438E */  lw         $v1, 0x64($s2)
    /* 4DCCC 8005D4CC 00000000 */  nop
    /* 4DCD0 8005D4D0 01006324 */  addiu      $v1, $v1, 0x1
    /* 4DCD4 8005D4D4 01006330 */  andi       $v1, $v1, 0x1
    /* 4DCD8 8005D4D8 04006014 */  bnez       $v1, .L8005D4EC
    /* 4DCDC 8005D4DC 21284000 */   addu      $a1, $v0, $zero
    /* 4DCE0 8005D4E0 C0101000 */  sll        $v0, $s0, 3
    /* 4DCE4 8005D4E4 3D750108 */  j          .L8005D4F4
    /* 4DCE8 8005D4E8 23105000 */   subu      $v0, $v0, $s0
  .L8005D4EC:
    /* 4DCEC 8005D4EC C0101000 */  sll        $v0, $s0, 3
    /* 4DCF0 8005D4F0 23100202 */  subu       $v0, $s0, $v0
  .L8005D4F4:
    /* 4DCF4 8005D4F4 09004004 */  bltz       $v0, .L8005D51C
    /* 4DCF8 8005D4F8 00000000 */   nop
    /* 4DCFC 8005D4FC 1480033C */  lui        $v1, %hi(gNumSlices)
    /* 4DD00 8005D500 C8C7638C */  lw         $v1, %lo(gNumSlices)($v1)
    /* 4DD04 8005D504 2128A200 */  addu       $a1, $a1, $v0
    /* 4DD08 8005D508 2A10A300 */  slt        $v0, $a1, $v1
    /* 4DD0C 8005D50C 0A004014 */  bnez       $v0, .L8005D538
    /* 4DD10 8005D510 21204002 */   addu      $a0, $s2, $zero
    /* 4DD14 8005D514 4E750108 */  j          .L8005D538
    /* 4DD18 8005D518 2328A300 */   subu      $a1, $a1, $v1
  .L8005D51C:
    /* 4DD1C 8005D51C 2128A200 */  addu       $a1, $a1, $v0
    /* 4DD20 8005D520 0500A104 */  bgez       $a1, .L8005D538
    /* 4DD24 8005D524 21204002 */   addu      $a0, $s2, $zero
    /* 4DD28 8005D528 1480023C */  lui        $v0, %hi(gNumSlices)
    /* 4DD2C 8005D52C C8C7428C */  lw         $v0, %lo(gNumSlices)($v0)
    /* 4DD30 8005D530 00000000 */  nop
    /* 4DD34 8005D534 2128A200 */  addu       $a1, $a1, $v0
  .L8005D538:
    /* 4DD38 8005D538 21300002 */  addu       $a2, $s0, $zero
    /* 4DD3C 8005D53C 0000828C */  lw         $v0, 0x0($a0)
    /* 4DD40 8005D540 21382002 */  addu       $a3, $s1, $zero
    /* 4DD44 8005D544 9475010C */  jal        NewStage__19AIHigh_BTC_HumanCopiii
    /* 4DD48 8005D548 080045A4 */   sh        $a1, 0x8($v0)
  .L8005D54C:
    /* 4DD4C 8005D54C 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 4DD50 8005D550 1800B28F */  lw         $s2, 0x18($sp)
    /* 4DD54 8005D554 1400B18F */  lw         $s1, 0x14($sp)
    /* 4DD58 8005D558 1000B08F */  lw         $s0, 0x10($sp)
    /* 4DD5C 8005D55C 0800E003 */  jr         $ra
    /* 4DD60 8005D560 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel FreezeAndEndChase__19AIHigh_BTC_HumanCop
