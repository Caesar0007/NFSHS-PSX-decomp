.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AI_PushFinishedCarsToSide__FP8Car_tObj, 0x19C

glabel AI_PushFinishedCarsToSide__FP8Car_tObj
    /* 4AF24 8005A724 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 4AF28 8005A728 1000B0AF */  sw         $s0, 0x10($sp)
    /* 4AF2C 8005A72C 21808000 */  addu       $s0, $a0, $zero
    /* 4AF30 8005A730 1400BFAF */  sw         $ra, 0x14($sp)
    /* 4AF34 8005A734 6002028E */  lw         $v0, 0x260($s0)
    /* 4AF38 8005A738 00000000 */  nop
    /* 4AF3C 8005A73C 01004230 */  andi       $v0, $v0, 0x1
    /* 4AF40 8005A740 5B004010 */  beqz       $v0, .L8005A8B0
    /* 4AF44 8005A744 02000224 */   addiu     $v0, $zero, 0x2
    /* 4AF48 8005A748 9003048E */  lw         $a0, 0x390($s0)
    /* 4AF4C 8005A74C 00000000 */  nop
    /* 4AF50 8005A750 57008214 */  bne        $a0, $v0, .L8005A8B0
    /* 4AF54 8005A754 1180023C */   lui       $v0, %hi(GameSetup_gData)
    /* 4AF58 8005A758 EC31438C */  lw         $v1, %lo(GameSetup_gData)($v0)
    /* 4AF5C 8005A75C 01000224 */  addiu      $v0, $zero, 0x1
    /* 4AF60 8005A760 03006210 */  beq        $v1, $v0, .L8005A770
    /* 4AF64 8005A764 05000224 */   addiu     $v0, $zero, 0x5
    /* 4AF68 8005A768 15006214 */  bne        $v1, $v0, .L8005A7C0
    /* 4AF6C 8005A76C 00000000 */   nop
  .L8005A770:
    /* 4AF70 8005A770 1180033C */  lui        $v1, %hi(Cars_gHumanRaceCarList)
    /* 4AF74 8005A774 48FA628C */  lw         $v0, %lo(Cars_gHumanRaceCarList)($v1)
    /* 4AF78 8005A778 00000000 */  nop
    /* 4AF7C 8005A77C 6002428C */  lw         $v0, 0x260($v0)
    /* 4AF80 8005A780 00000000 */  nop
    /* 4AF84 8005A784 00024230 */  andi       $v0, $v0, 0x200
    /* 4AF88 8005A788 49004014 */  bnez       $v0, .L8005A8B0
    /* 4AF8C 8005A78C 48FA6324 */   addiu     $v1, $v1, %lo(Cars_gHumanRaceCarList)
    /* 4AF90 8005A790 1480023C */  lui        $v0, %hi(Cars_gNumHumanRaceCars)
    /* 4AF94 8005A794 00C8428C */  lw         $v0, %lo(Cars_gNumHumanRaceCars)($v0)
    /* 4AF98 8005A798 00000000 */  nop
    /* 4AF9C 8005A79C 09004414 */  bne        $v0, $a0, .L8005A7C4
    /* 4AFA0 8005A7A0 21200002 */   addu      $a0, $s0, $zero
    /* 4AFA4 8005A7A4 0400628C */  lw         $v0, 0x4($v1)
    /* 4AFA8 8005A7A8 00000000 */  nop
    /* 4AFAC 8005A7AC 6002428C */  lw         $v0, 0x260($v0)
    /* 4AFB0 8005A7B0 00000000 */  nop
    /* 4AFB4 8005A7B4 00024230 */  andi       $v0, $v0, 0x200
    /* 4AFB8 8005A7B8 3D004014 */  bnez       $v0, .L8005A8B0
    /* 4AFBC 8005A7BC 00000000 */   nop
  .L8005A7C0:
    /* 4AFC0 8005A7C0 21200002 */  addu       $a0, $s0, $zero
  .L8005A7C4:
    /* 4AFC4 8005A7C4 4ACC010C */  jal        AIWorld_ApxSplineDistance__FP8Car_tObji
    /* 4AFC8 8005A7C8 21280000 */   addu      $a1, $zero, $zero
    /* 4AFCC 8005A7CC 1480053C */  lui        $a1, %hi(Cars_gNumCars)
    /* 4AFD0 8005A7D0 F4C7A58C */  lw         $a1, %lo(Cars_gNumCars)($a1)
    /* 4AFD4 8005A7D4 02004104 */  bgez       $v0, .L8005A7E0
    /* 4AFD8 8005A7D8 21304000 */   addu      $a2, $v0, $zero
    /* 4AFDC 8005A7DC 23300600 */  negu       $a2, $a2
  .L8005A7E0:
    /* 4AFE0 8005A7E0 0B00A018 */  blez       $a1, .L8005A810
    /* 4AFE4 8005A7E4 21180000 */   addu      $v1, $zero, $zero
    /* 4AFE8 8005A7E8 1180023C */  lui        $v0, %hi(Cars_gTotalSortedList)
    /* 4AFEC 8005A7EC 20FB4424 */  addiu      $a0, $v0, %lo(Cars_gTotalSortedList)
  .L8005A7F0:
    /* 4AFF0 8005A7F0 0000828C */  lw         $v0, 0x0($a0)
    /* 4AFF4 8005A7F4 00000000 */  nop
    /* 4AFF8 8005A7F8 06005010 */  beq        $v0, $s0, .L8005A814
    /* 4AFFC 8005A7FC 80100300 */   sll       $v0, $v1, 2
    /* 4B000 8005A800 01006324 */  addiu      $v1, $v1, 0x1
    /* 4B004 8005A804 2A106500 */  slt        $v0, $v1, $a1
    /* 4B008 8005A808 F9FF4014 */  bnez       $v0, .L8005A7F0
    /* 4B00C 8005A80C 04008424 */   addiu     $a0, $a0, 0x4
  .L8005A810:
    /* 4B010 8005A810 80100300 */  sll        $v0, $v1, 2
  .L8005A814:
    /* 4B014 8005A814 21104300 */  addu       $v0, $v0, $v1
    /* 4B018 8005A818 C0140200 */  sll        $v0, $v0, 19
    /* 4B01C 8005A81C 2A10C200 */  slt        $v0, $a2, $v0
    /* 4B020 8005A820 23004014 */  bnez       $v0, .L8005A8B0
    /* 4B024 8005A824 00000000 */   nop
    /* 4B028 8005A828 08000286 */  lh         $v0, 0x8($s0)
    /* 4B02C 8005A82C 1480033C */  lui        $v1, %hi(BWorldSm_slices)
    /* 4B030 8005A830 C0C7638C */  lw         $v1, %lo(BWorldSm_slices)($v1)
    /* 4B034 8005A834 C406048E */  lw         $a0, 0x6C4($s0)
    /* 4B038 8005A838 40110200 */  sll        $v0, $v0, 5
    /* 4B03C 8005A83C 21104300 */  addu       $v0, $v0, $v1
    /* 4B040 8005A840 1D004590 */  lbu        $a1, 0x1D($v0)
    /* 4B044 8005A844 06000224 */  addiu      $v0, $zero, 0x6
    /* 4B048 8005A848 02190500 */  srl        $v1, $a1, 4
    /* 4B04C 8005A84C 23104300 */  subu       $v0, $v0, $v1
    /* 4B050 8005A850 04008210 */  beq        $a0, $v0, .L8005A864
    /* 4B054 8005A854 0F00A230 */   andi      $v0, $a1, 0xF
    /* 4B058 8005A858 07004224 */  addiu      $v0, $v0, 0x7
    /* 4B05C 8005A85C 08008214 */  bne        $a0, $v0, .L8005A880
    /* 4B060 8005A860 07008228 */   slti      $v0, $a0, 0x7
  .L8005A864:
    /* 4B064 8005A864 1180023C */  lui        $v0, %hi(CarLogic_gObs)
    /* 4B068 8005A868 E4CC4224 */  addiu      $v0, $v0, %lo(CarLogic_gObs)
    /* 4B06C 8005A86C 0400438C */  lw         $v1, 0x4($v0)
    /* 4B070 8005A870 9600043C */  lui        $a0, (0x960000 >> 16)
    /* 4B074 8005A874 21186400 */  addu       $v1, $v1, $a0
    /* 4B078 8005A878 2C6A0108 */  j          .L8005A8B0
    /* 4B07C 8005A87C 040043AC */   sw        $v1, 0x4($v0)
  .L8005A880:
    /* 4B080 8005A880 06004010 */  beqz       $v0, .L8005A89C
    /* 4B084 8005A884 1180023C */   lui       $v0, %hi(CarLogic_gObs)
    /* 4B088 8005A888 E4CC438C */  lw         $v1, %lo(CarLogic_gObs)($v0)
    /* 4B08C 8005A88C 9600043C */  lui        $a0, (0x960000 >> 16)
    /* 4B090 8005A890 21186400 */  addu       $v1, $v1, $a0
    /* 4B094 8005A894 2C6A0108 */  j          .L8005A8B0
    /* 4B098 8005A898 E4CC43AC */   sw        $v1, %lo(CarLogic_gObs)($v0)
  .L8005A89C:
    /* 4B09C 8005A89C E4CC4224 */  addiu      $v0, $v0, %lo(CarLogic_gObs)
    /* 4B0A0 8005A8A0 0800438C */  lw         $v1, 0x8($v0)
    /* 4B0A4 8005A8A4 9600043C */  lui        $a0, (0x960000 >> 16)
    /* 4B0A8 8005A8A8 21186400 */  addu       $v1, $v1, $a0
    /* 4B0AC 8005A8AC 080043AC */  sw         $v1, 0x8($v0)
  .L8005A8B0:
    /* 4B0B0 8005A8B0 1400BF8F */  lw         $ra, 0x14($sp)
    /* 4B0B4 8005A8B4 1000B08F */  lw         $s0, 0x10($sp)
    /* 4B0B8 8005A8B8 0800E003 */  jr         $ra
    /* 4B0BC 8005A8BC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AI_PushFinishedCarsToSide__FP8Car_tObj
