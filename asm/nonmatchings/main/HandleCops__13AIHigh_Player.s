.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching HandleCops__13AIHigh_Player, 0x1A0

glabel HandleCops__13AIHigh_Player
    /* 532C4 80062AC4 1480023C */  lui        $v0, %hi(Cars_gNumCopCars)
    /* 532C8 80062AC8 0CC8428C */  lw         $v0, %lo(Cars_gNumCopCars)($v0)
    /* 532CC 80062ACC E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 532D0 80062AD0 1400B1AF */  sw         $s1, 0x14($sp)
    /* 532D4 80062AD4 21888000 */  addu       $s1, $a0, $zero
    /* 532D8 80062AD8 1000B0AF */  sw         $s0, 0x10($sp)
    /* 532DC 80062ADC 8C003026 */  addiu      $s0, $s1, 0x8C
    /* 532E0 80062AE0 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 532E4 80062AE4 1800B2AF */  sw         $s2, 0x18($sp)
    /* 532E8 80062AE8 1000128E */  lw         $s2, 0x10($s0)
    /* 532EC 80062AEC 57004010 */  beqz       $v0, .L80062C4C
    /* 532F0 80062AF0 00000000 */   nop
    /* 532F4 80062AF4 8E89010C */  jal        MaintainAvailableCops__13AIHigh_Player
    /* 532F8 80062AF8 00000000 */   nop
    /* 532FC 80062AFC 0085010C */  jal        CheckIfABlockadeCanBeSetup__13AIHigh_Player
    /* 53300 80062B00 21202002 */   addu      $a0, $s1, $zero
    /* 53304 80062B04 03004010 */  beqz       $v0, .L80062B14
    /* 53308 80062B08 00000000 */   nop
    /* 5330C 80062B0C E185010C */  jal        SetupBlockade__13AIHigh_Player
    /* 53310 80062B10 21202002 */   addu      $a0, $s1, $zero
  .L80062B14:
    /* 53314 80062B14 0800428E */  lw         $v0, 0x8($s2)
    /* 53318 80062B18 00000000 */  nop
    /* 5331C 80062B1C 04004014 */  bnez       $v0, .L80062B30
    /* 53320 80062B20 00000000 */   nop
    /* 53324 80062B24 21202002 */  addu       $a0, $s1, $zero
    /* 53328 80062B28 198B010C */  jal        CleanupBlockaders__13AIHigh_Playeri
    /* 5332C 80062B2C 21280000 */   addu      $a1, $zero, $zero
  .L80062B30:
    /* 53330 80062B30 0000228E */  lw         $v0, 0x0($s1)
    /* 53334 80062B34 00000000 */  nop
    /* 53338 80062B38 6405438C */  lw         $v1, 0x564($v0)
    /* 5333C 80062B3C 5405428C */  lw         $v0, 0x554($v0)
    /* 53340 80062B40 00000000 */  nop
    /* 53344 80062B44 18006200 */  mult       $v1, $v0
    /* 53348 80062B48 21280002 */  addu       $a1, $s0, $zero
    /* 5334C 80062B4C 7000228E */  lw         $v0, 0x70($s1)
    /* 53350 80062B50 7400238E */  lw         $v1, 0x74($s1)
    /* 53354 80062B54 1480063C */  lui        $a2, %hi(AI_elapsedTime)
    /* 53358 80062B58 54C5C68C */  lw         $a2, %lo(AI_elapsedTime)($a2)
    /* 5335C 80062B5C 21104300 */  addu       $v0, $v0, $v1
    /* 53360 80062B60 12380000 */  mflo       $a3
    /* 53364 80062B64 30004018 */  blez       $v0, .L80062C28
    /* 53368 80062B68 C2270700 */   srl       $a0, $a3, 31
    /* 5336C 80062B6C 200000AE */  sw         $zero, 0x20($s0)
    /* 53370 80062B70 8C00238E */  lw         $v1, 0x8C($s1)
    /* 53374 80062B74 00000000 */  nop
    /* 53378 80062B78 03006104 */  bgez       $v1, .L80062B88
    /* 5337C 80062B7C 21106000 */   addu      $v0, $v1, $zero
    /* 53380 80062B80 FFFF0234 */  ori        $v0, $zero, 0xFFFF
    /* 53384 80062B84 21106200 */  addu       $v0, $v1, $v0
  .L80062B88:
    /* 53388 80062B88 03140200 */  sra        $v0, $v0, 16
    /* 5338C 80062B8C FFFF4228 */  slti       $v0, $v0, -0x1
    /* 53390 80062B90 29004014 */  bnez       $v0, .L80062C38
    /* 53394 80062B94 00000000 */   nop
    /* 53398 80062B98 02008014 */  bnez       $a0, .L80062BA4
    /* 5339C 80062B9C C0130600 */   sll       $v0, $a2, 15
    /* 533A0 80062BA0 00140600 */  sll        $v0, $a2, 16
  .L80062BA4:
    /* 533A4 80062BA4 23106200 */  subu       $v0, $v1, $v0
    /* 533A8 80062BA8 8C0022AE */  sw         $v0, 0x8C($s1)
    /* 533AC 80062BAC 0000A48C */  lw         $a0, 0x0($a1)
    /* 533B0 80062BB0 00000000 */  nop
    /* 533B4 80062BB4 02008104 */  bgez       $a0, .L80062BC0
    /* 533B8 80062BB8 FFFF0234 */   ori       $v0, $zero, 0xFFFF
    /* 533BC 80062BBC 21208200 */  addu       $a0, $a0, $v0
  .L80062BC0:
    /* 533C0 80062BC0 1000A28C */  lw         $v0, 0x10($a1)
    /* 533C4 80062BC4 00000000 */  nop
    /* 533C8 80062BC8 2400438C */  lw         $v1, 0x24($v0)
    /* 533CC 80062BCC 1480023C */  lui        $v0, %hi(AITune_gRoughLapTime)
    /* 533D0 80062BD0 F8C5428C */  lw         $v0, %lo(AITune_gRoughLapTime)($v0)
    /* 533D4 80062BD4 00000000 */  nop
    /* 533D8 80062BD8 18006200 */  mult       $v1, $v0
    /* 533DC 80062BDC 12180000 */  mflo       $v1
    /* 533E0 80062BE0 03006104 */  bgez       $v1, .L80062BF0
    /* 533E4 80062BE4 03240400 */   sra       $a0, $a0, 16
    /* 533E8 80062BE8 FFFF0234 */  ori        $v0, $zero, 0xFFFF
    /* 533EC 80062BEC 21186200 */  addu       $v1, $v1, $v0
  .L80062BF0:
    /* 533F0 80062BF0 03140300 */  sra        $v0, $v1, 16
    /* 533F4 80062BF4 40110200 */  sll        $v0, $v0, 5
    /* 533F8 80062BF8 80FF4224 */  addiu      $v0, $v0, -0x80
    /* 533FC 80062BFC 2A108200 */  slt        $v0, $a0, $v0
    /* 53400 80062C00 0D004010 */  beqz       $v0, .L80062C38
    /* 53404 80062C04 00000000 */   nop
    /* 53408 80062C08 1C00A28C */  lw         $v0, 0x1C($a1)
    /* 5340C 80062C0C 00000000 */  nop
    /* 53410 80062C10 18004600 */  mult       $v0, $a2
    /* 53414 80062C14 1400A28C */  lw         $v0, 0x14($a1)
    /* 53418 80062C18 12380000 */  mflo       $a3
    /* 5341C 80062C1C 21104700 */  addu       $v0, $v0, $a3
    /* 53420 80062C20 0E8B0108 */  j          .L80062C38
    /* 53424 80062C24 1400A2AC */   sw        $v0, 0x14($a1)
  .L80062C28:
    /* 53428 80062C28 2000028E */  lw         $v0, 0x20($s0)
    /* 5342C 80062C2C 00000000 */  nop
    /* 53430 80062C30 21104600 */  addu       $v0, $v0, $a2
    /* 53434 80062C34 200002AE */  sw         $v0, 0x20($s0)
  .L80062C38:
    /* 53438 80062C38 21202002 */  addu       $a0, $s1, $zero
    /* 5343C 80062C3C 8388010C */  jal        CheckForNewLevel__13AIHigh_Playeri
    /* 53440 80062C40 21280000 */   addu      $a1, $zero, $zero
    /* 53444 80062C44 5F8B010C */  jal        HandlePullOver__13AIHigh_Player
    /* 53448 80062C48 21202002 */   addu      $a0, $s1, $zero
  .L80062C4C:
    /* 5344C 80062C4C 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 53450 80062C50 1800B28F */  lw         $s2, 0x18($sp)
    /* 53454 80062C54 1400B18F */  lw         $s1, 0x14($sp)
    /* 53458 80062C58 1000B08F */  lw         $s0, 0x10($sp)
    /* 5345C 80062C5C 0800E003 */  jr         $ra
    /* 53460 80062C60 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel HandleCops__13AIHigh_Player
