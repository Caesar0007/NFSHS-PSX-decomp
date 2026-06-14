.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CheckForNewTriggers__10AIHigh_Cop, 0x328

glabel CheckForNewTriggers__10AIHigh_Cop
    /* 56144 80065944 C0FFBD27 */  addiu      $sp, $sp, -0x40
    /* 56148 80065948 1280023C */  lui        $v0, %hi(simGlobal)
    /* 5614C 8006594C ACE04324 */  addiu      $v1, $v0, %lo(simGlobal)
    /* 56150 80065950 3C00BFAF */  sw         $ra, 0x3C($sp)
    /* 56154 80065954 3800BEAF */  sw         $fp, 0x38($sp)
    /* 56158 80065958 3400B7AF */  sw         $s7, 0x34($sp)
    /* 5615C 8006595C 3000B6AF */  sw         $s6, 0x30($sp)
    /* 56160 80065960 2C00B5AF */  sw         $s5, 0x2C($sp)
    /* 56164 80065964 2800B4AF */  sw         $s4, 0x28($sp)
    /* 56168 80065968 2400B3AF */  sw         $s3, 0x24($sp)
    /* 5616C 8006596C 2000B2AF */  sw         $s2, 0x20($sp)
    /* 56170 80065970 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* 56174 80065974 1800B0AF */  sw         $s0, 0x18($sp)
    /* 56178 80065978 4000A4AF */  sw         $a0, 0x40($sp)
    /* 5617C 8006597C 0400628C */  lw         $v0, 0x4($v1)
    /* 56180 80065980 00000000 */  nop
    /* 56184 80065984 C0054228 */  slti       $v0, $v0, 0x5C0
    /* 56188 80065988 AC004014 */  bnez       $v0, .L80065C3C
    /* 5618C 8006598C 21100000 */   addu      $v0, $zero, $zero
    /* 56190 80065990 1480023C */  lui        $v0, %hi(Cars_gNumCars)
    /* 56194 80065994 F4C7428C */  lw         $v0, %lo(Cars_gNumCars)($v0)
    /* 56198 80065998 00000000 */  nop
    /* 5619C 8006599C FFFF5E24 */  addiu      $fp, $v0, -0x1
  .L800659A0:
    /* 561A0 800659A0 A500C007 */  bltz       $fp, .L80065C38
    /* 561A4 800659A4 80101E00 */   sll       $v0, $fp, 2
    /* 561A8 800659A8 1180073C */  lui        $a3, %hi(Cars_gTotalSortedList)
    /* 561AC 800659AC 20FBE724 */  addiu      $a3, $a3, %lo(Cars_gTotalSortedList)
    /* 561B0 800659B0 21104700 */  addu       $v0, $v0, $a3
    /* 561B4 800659B4 0000558C */  lw         $s5, 0x0($v0)
    /* 561B8 800659B8 00000000 */  nop
    /* 561BC 800659BC 6002A28E */  lw         $v0, 0x260($s5)
    /* 561C0 800659C0 00000000 */  nop
    /* 561C4 800659C4 01004230 */  andi       $v0, $v0, 0x1
    /* 561C8 800659C8 99004010 */  beqz       $v0, .L80065C30
    /* 561CC 800659CC 1180073C */   lui       $a3, %hi(highLevelAIObjs)
    /* 561D0 800659D0 5402A28E */  lw         $v0, 0x254($s5)
    /* 561D4 800659D4 38CDE724 */  addiu      $a3, $a3, %lo(highLevelAIObjs)
    /* 561D8 800659D8 80100200 */  sll        $v0, $v0, 2
    /* 561DC 800659DC 21104700 */  addu       $v0, $v0, $a3
    /* 561E0 800659E0 0000508C */  lw         $s0, 0x0($v0)
    /* 561E4 800659E4 4000A78F */  lw         $a3, 0x40($sp)
    /* 561E8 800659E8 70000326 */  addiu      $v1, $s0, 0x70
    /* 561EC 800659EC 9C00058E */  lw         $a1, 0x9C($s0)
    /* 561F0 800659F0 1800E28C */  lw         $v0, 0x18($a3)
    /* 561F4 800659F4 8400128E */  lw         $s2, 0x84($s0)
    /* 561F8 800659F8 80200200 */  sll        $a0, $v0, 2
    /* 561FC 800659FC 21106400 */  addu       $v0, $v1, $a0
    /* 56200 80065A00 0800638C */  lw         $v1, 0x8($v1)
    /* 56204 80065A04 0000428C */  lw         $v0, 0x0($v0)
    /* 56208 80065A08 2130A000 */  addu       $a2, $a1, $zero
    /* 5620C 80065A0C 0F006014 */  bnez       $v1, .L80065A4C
    /* 56210 80065A10 1400A2AF */   sw        $v0, 0x14($sp)
    /* 56214 80065A14 2110A400 */  addu       $v0, $a1, $a0
    /* 56218 80065A18 0000428C */  lw         $v0, 0x0($v0)
    /* 5621C 80065A1C 00000000 */  nop
    /* 56220 80065A20 08004018 */  blez       $v0, .L80065A44
    /* 56224 80065A24 40901200 */   sll       $s2, $s2, 1
    /* 56228 80065A28 0000028E */  lw         $v0, 0x0($s0)
    /* 5622C 80065A2C 00000000 */  nop
    /* 56230 80065A30 08004484 */  lh         $a0, 0x8($v0)
    /* 56234 80065A34 C29A010C */  jal        AICop_NoCopsInArea__Fii
    /* 56238 80065A38 F401053C */   lui       $a1, (0x1F40000 >> 16)
    /* 5623C 80065A3C 05004014 */  bnez       $v0, .L80065A54
    /* 56240 80065A40 01000424 */   addiu     $a0, $zero, 0x1
  .L80065A44:
    /* 56244 80065A44 95960108 */  j          .L80065A54
    /* 56248 80065A48 21200000 */   addu      $a0, $zero, $zero
  .L80065A4C:
    /* 5624C 80065A4C 2110C400 */  addu       $v0, $a2, $a0
    /* 56250 80065A50 0000448C */  lw         $a0, 0x0($v0)
  .L80065A54:
    /* 56254 80065A54 1180023C */  lui        $v0, %hi(D_801131F4)
    /* 56258 80065A58 F431438C */  lw         $v1, %lo(D_801131F4)($v0)
    /* 5625C 80065A5C 02000224 */  addiu      $v0, $zero, 0x2
    /* 56260 80065A60 02006214 */  bne        $v1, $v0, .L80065A6C
    /* 56264 80065A64 1280073C */   lui       $a3, %hi(simGlobal)
    /* 56268 80065A68 0100123C */  lui        $s2, (0x10000 >> 16)
  .L80065A6C:
    /* 5626C 80065A6C ACE0E724 */  addiu      $a3, $a3, %lo(simGlobal)
    /* 56270 80065A70 6800038E */  lw         $v1, 0x68($s0)
    /* 56274 80065A74 0400E28C */  lw         $v0, 0x4($a3)
    /* 56278 80065A78 00000000 */  nop
    /* 5627C 80065A7C 23104300 */  subu       $v0, $v0, $v1
    /* 56280 80065A80 C0014228 */  slti       $v0, $v0, 0x1C0
    /* 56284 80065A84 6A004014 */  bnez       $v0, .L80065C30
    /* 56288 80065A88 00000000 */   nop
    /* 5628C 80065A8C 1400A78F */  lw         $a3, 0x14($sp)
    /* 56290 80065A90 00000000 */  nop
    /* 56294 80065A94 2A10E400 */  slt        $v0, $a3, $a0
    /* 56298 80065A98 65004010 */  beqz       $v0, .L80065C30
    /* 5629C 80065A9C 00000000 */   nop
    /* 562A0 80065AA0 6405A28E */  lw         $v0, 0x564($s5)
    /* 562A4 80065AA4 00000000 */  nop
    /* 562A8 80065AA8 02004004 */  bltz       $v0, .L80065AB4
    /* 562AC 80065AAC FFFF0324 */   addiu     $v1, $zero, -0x1
    /* 562B0 80065AB0 01000324 */  addiu      $v1, $zero, 0x1
  .L80065AB4:
    /* 562B4 80065AB4 40110300 */  sll        $v0, $v1, 5
    /* 562B8 80065AB8 23184300 */  subu       $v1, $v0, $v1
    /* 562BC 80065ABC 0A006004 */  bltz       $v1, .L80065AE8
    /* 562C0 80065AC0 00000000 */   nop
    /* 562C4 80065AC4 0800A286 */  lh         $v0, 0x8($s5)
    /* 562C8 80065AC8 1480043C */  lui        $a0, %hi(gNumSlices)
    /* 562CC 80065ACC C8C7848C */  lw         $a0, %lo(gNumSlices)($a0)
    /* 562D0 80065AD0 21184300 */  addu       $v1, $v0, $v1
    /* 562D4 80065AD4 2A106400 */  slt        $v0, $v1, $a0
    /* 562D8 80065AD8 0C004014 */  bnez       $v0, .L80065B0C
    /* 562DC 80065ADC 00000000 */   nop
    /* 562E0 80065AE0 C3960108 */  j          .L80065B0C
    /* 562E4 80065AE4 23186400 */   subu      $v1, $v1, $a0
  .L80065AE8:
    /* 562E8 80065AE8 0800A286 */  lh         $v0, 0x8($s5)
    /* 562EC 80065AEC 00000000 */  nop
    /* 562F0 80065AF0 21184300 */  addu       $v1, $v0, $v1
    /* 562F4 80065AF4 05006104 */  bgez       $v1, .L80065B0C
    /* 562F8 80065AF8 00000000 */   nop
    /* 562FC 80065AFC 1480023C */  lui        $v0, %hi(gNumSlices)
    /* 56300 80065B00 C8C7428C */  lw         $v0, %lo(gNumSlices)($v0)
    /* 56304 80065B04 00000000 */  nop
    /* 56308 80065B08 21186200 */  addu       $v1, $v1, $v0
  .L80065B0C:
    /* 5630C 80065B0C 8800058E */  lw         $a1, 0x88($s0)
    /* 56310 80065B10 00000000 */  nop
    /* 56314 80065B14 2A10A300 */  slt        $v0, $a1, $v1
    /* 56318 80065B18 04004010 */  beqz       $v0, .L80065B2C
    /* 5631C 80065B1C 880003AE */   sw        $v1, 0x88($s0)
    /* 56320 80065B20 2120A000 */  addu       $a0, $a1, $zero
    /* 56324 80065B24 CD960108 */  j          .L80065B34
    /* 56328 80065B28 21A06000 */   addu      $s4, $v1, $zero
  .L80065B2C:
    /* 5632C 80065B2C 21206000 */  addu       $a0, $v1, $zero
    /* 56330 80065B30 21A0A000 */  addu       $s4, $a1, $zero
  .L80065B34:
    /* 56334 80065B34 21888000 */  addu       $s1, $a0, $zero
    /* 56338 80065B38 23109102 */  subu       $v0, $s4, $s1
    /* 5633C 80065B3C 06005728 */  slti       $s7, $v0, 0x6
    /* 56340 80065B40 40101200 */  sll        $v0, $s2, 1
    /* 56344 80065B44 21105200 */  addu       $v0, $v0, $s2
    /* 56348 80065B48 C0100200 */  sll        $v0, $v0, 3
    /* 5634C 80065B4C 21B05200 */  addu       $s6, $v0, $s2
  .L80065B50:
    /* 56350 80065B50 2A103402 */  slt        $v0, $s1, $s4
    /* 56354 80065B54 36004010 */  beqz       $v0, .L80065C30
    /* 56358 80065B58 00000000 */   nop
    /* 5635C 80065B5C 3400E012 */  beqz       $s7, .L80065C30
    /* 56360 80065B60 00000000 */   nop
    /* 56364 80065B64 1480043C */  lui        $a0, %hi(triggerManagerCops)
    /* 56368 80065B68 E8C5848C */  lw         $a0, %lo(triggerManagerCops)($a0)
    /* 5636C 80065B6C 5402A58E */  lw         $a1, 0x254($s5)
    /* 56370 80065B70 C9CA010C */  jal        CheckForTriggerAtSlice__24AITrigger_TriggerManagerii
    /* 56374 80065B74 21302002 */   addu      $a2, $s1, $zero
    /* 56378 80065B78 21984000 */  addu       $s3, $v0, $zero
    /* 5637C 80065B7C FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 56380 80065B80 29006212 */  beq        $s3, $v0, .L80065C28
    /* 56384 80065B84 80281600 */   sll       $a1, $s6, 2
    /* 56388 80065B88 0200A104 */  bgez       $a1, .L80065B94
    /* 5638C 80065B8C FFFF0234 */   ori       $v0, $zero, 0xFFFF
    /* 56390 80065B90 2128A200 */  addu       $a1, $a1, $v0
  .L80065B94:
    /* 56394 80065B94 1480033C */  lui        $v1, %hi(fastRandom)
    /* 56398 80065B98 FCD0638C */  lw         $v1, %lo(fastRandom)($v1)
    /* 5639C 80065B9C 1480023C */  lui        $v0, %hi(randSeed)
    /* 563A0 80065BA0 04D1428C */  lw         $v0, %lo(randSeed)($v0)
    /* 563A4 80065BA4 00000000 */  nop
    /* 563A8 80065BA8 18006200 */  mult       $v1, $v0
    /* 563AC 80065BAC 21202002 */  addu       $a0, $s1, $zero
    /* 563B0 80065BB0 03940500 */  sra        $s2, $a1, 16
    /* 563B4 80065BB4 12180000 */  mflo       $v1
    /* 563B8 80065BB8 FFFF6230 */  andi       $v0, $v1, 0xFFFF
    /* 563BC 80065BBC 1480013C */  lui        $at, %hi(randtemp)
    /* 563C0 80065BC0 00D123AC */  sw         $v1, %lo(randtemp)($at)
    /* 563C4 80065BC4 021A0300 */  srl        $v1, $v1, 8
    /* 563C8 80065BC8 FFFF6330 */  andi       $v1, $v1, 0xFFFF
    /* 563CC 80065BCC 1480013C */  lui        $at, %hi(fastRandom)
    /* 563D0 80065BD0 FCD022AC */  sw         $v0, %lo(fastRandom)($at)
    /* 563D4 80065BD4 40100300 */  sll        $v0, $v1, 1
    /* 563D8 80065BD8 21104300 */  addu       $v0, $v0, $v1
    /* 563DC 80065BDC C0100200 */  sll        $v0, $v0, 3
    /* 563E0 80065BE0 21104300 */  addu       $v0, $v0, $v1
    /* 563E4 80065BE4 03A2010C */  jal        AILife_IsSliceInAnyVisibleArea__Fi
    /* 563E8 80065BE8 82830200 */   srl       $s0, $v0, 14
    /* 563EC 80065BEC 0E004014 */  bnez       $v0, .L80065C28
    /* 563F0 80065BF0 00000000 */   nop
    /* 563F4 80065BF4 1400A78F */  lw         $a3, 0x14($sp)
    /* 563F8 80065BF8 00000000 */  nop
    /* 563FC 80065BFC 0300E014 */  bnez       $a3, .L80065C0C
    /* 56400 80065C00 2A101202 */   slt       $v0, $s0, $s2
    /* 56404 80065C04 D2FF4010 */  beqz       $v0, .L80065B50
    /* 56408 80065C08 01003126 */   addiu     $s1, $s1, 0x1
  .L80065C0C:
    /* 5640C 80065C0C 1480043C */  lui        $a0, %hi(triggerManagerCops)
    /* 56410 80065C10 E8C5848C */  lw         $a0, %lo(triggerManagerCops)($a0)
    /* 56414 80065C14 21286002 */  addu       $a1, $s3, $zero
    /* 56418 80065C18 36CB010C */  jal        GetTrigger__24AITrigger_TriggerManageriPi
    /* 5641C 80065C1C 1000A627 */   addiu     $a2, $sp, 0x10
    /* 56420 80065C20 0F970108 */  j          .L80065C3C
    /* 56424 80065C24 00000000 */   nop
  .L80065C28:
    /* 56428 80065C28 D4960108 */  j          .L80065B50
    /* 5642C 80065C2C 01003126 */   addiu     $s1, $s1, 0x1
  .L80065C30:
    /* 56430 80065C30 68960108 */  j          .L800659A0
    /* 56434 80065C34 FFFFDE27 */   addiu     $fp, $fp, -0x1
  .L80065C38:
    /* 56438 80065C38 21100000 */  addu       $v0, $zero, $zero
  .L80065C3C:
    /* 5643C 80065C3C 3C00BF8F */  lw         $ra, 0x3C($sp)
    /* 56440 80065C40 3800BE8F */  lw         $fp, 0x38($sp)
    /* 56444 80065C44 3400B78F */  lw         $s7, 0x34($sp)
    /* 56448 80065C48 3000B68F */  lw         $s6, 0x30($sp)
    /* 5644C 80065C4C 2C00B58F */  lw         $s5, 0x2C($sp)
    /* 56450 80065C50 2800B48F */  lw         $s4, 0x28($sp)
    /* 56454 80065C54 2400B38F */  lw         $s3, 0x24($sp)
    /* 56458 80065C58 2000B28F */  lw         $s2, 0x20($sp)
    /* 5645C 80065C5C 1C00B18F */  lw         $s1, 0x1C($sp)
    /* 56460 80065C60 1800B08F */  lw         $s0, 0x18($sp)
    /* 56464 80065C64 0800E003 */  jr         $ra
    /* 56468 80065C68 4000BD27 */   addiu     $sp, $sp, 0x40
endlabel CheckForNewTriggers__10AIHigh_Cop
