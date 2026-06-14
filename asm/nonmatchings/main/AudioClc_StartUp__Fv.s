.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioClc_StartUp__Fv, 0x15C

glabel AudioClc_StartUp__Fv
    /* 65038 80074838 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 6503C 8007483C 1180023C */  lui        $v0, %hi(AudioClc_gPlayer)
    /* 65040 80074840 1800B2AF */  sw         $s2, 0x18($sp)
    /* 65044 80074844 A8E25224 */  addiu      $s2, $v0, %lo(AudioClc_gPlayer)
    /* 65048 80074848 1180023C */  lui        $v0, %hi(AudioClc_gClosest)
    /* 6504C 8007484C 2000B4AF */  sw         $s4, 0x20($sp)
    /* 65050 80074850 48E35424 */  addiu      $s4, $v0, %lo(AudioClc_gClosest)
    /* 65054 80074854 1000B0AF */  sw         $s0, 0x10($sp)
    /* 65058 80074858 21800000 */  addu       $s0, $zero, $zero
    /* 6505C 8007485C 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* 65060 80074860 2400B5AF */  sw         $s5, 0x24($sp)
    /* 65064 80074864 EC315524 */  addiu      $s5, $v0, %lo(GameSetup_gData)
    /* 65068 80074868 1400B1AF */  sw         $s1, 0x14($sp)
    /* 6506C 8007486C 18005126 */  addiu      $s1, $s2, 0x18
    /* 65070 80074870 1180023C */  lui        $v0, %hi(Cars_gHumanRaceCarList)
    /* 65074 80074874 2800B6AF */  sw         $s6, 0x28($sp)
    /* 65078 80074878 48FA5624 */  addiu      $s6, $v0, %lo(Cars_gHumanRaceCarList)
    /* 6507C 8007487C 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 65080 80074880 2198C002 */  addu       $s3, $s6, $zero
    /* 65084 80074884 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 65088 80074888 2C00BFAF */  sw         $ra, 0x2C($sp)
    /* 6508C 8007488C C00080AF */  sw         $zero, %gp_rel(AudioClc_gRandomPhrase)($gp)
    /* 65090 80074890 C40080AF */  sw         $zero, %gp_rel(AudioClc_gBullHornCount)($gp)
    /* 65094 80074894 C80080AF */  sw         $zero, %gp_rel(AudioClc_gBumpCopCount)($gp)
    /* 65098 80074898 CC0082AF */  sw         $v0, %gp_rel(AudioClc_gLastVoice)($gp)
    /* 6509C 8007489C D00082AF */  sw         $v0, %gp_rel(AudioClc_gLastphrase1)($gp)
    /* 650A0 800748A0 D40082AF */  sw         $v0, %gp_rel(AudioClc_gLastphrase2)($gp)
    /* 650A4 800748A4 D80082AF */  sw         $v0, %gp_rel(AudioClc_gLastphrase3)($gp)
  .L800748A8:
    /* 650A8 800748A8 21202002 */  addu       $a0, $s1, $zero
    /* 650AC 800748AC 21280000 */  addu       $a1, $zero, $zero
    /* 650B0 800748B0 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 650B4 800748B4 000042AE */  sw         $v0, 0x0($s2)
    /* 650B8 800748B8 ECFF20AE */  sw         $zero, -0x14($s1)
    /* 650BC 800748BC 02D2010C */  jal        AudioClc_InitSource__FP16AudioClc_tSourceP8Car_tObj
    /* 650C0 800748C0 F0FF20AE */   sw        $zero, -0x10($s1)
    /* 650C4 800748C4 0C00A28E */  lw         $v0, 0xC($s5)
    /* 650C8 800748C8 00000000 */  nop
    /* 650CC 800748CC 02004228 */  slti       $v0, $v0, 0x2
    /* 650D0 800748D0 0E004014 */  bnez       $v0, .L8007490C
    /* 650D4 800748D4 00000000 */   nop
    /* 650D8 800748D8 15000016 */  bnez       $s0, .L80074930
    /* 650DC 800748DC 00000000 */   nop
    /* 650E0 800748E0 1C00A38E */  lw         $v1, 0x1C($s5)
    /* 650E4 800748E4 1480023C */  lui        $v0, %hi(Cars_gNumHumanRaceCars)
    /* 650E8 800748E8 00C8428C */  lw         $v0, %lo(Cars_gNumHumanRaceCars)($v0)
    /* 650EC 800748EC 00000000 */  nop
    /* 650F0 800748F0 2A106200 */  slt        $v0, $v1, $v0
    /* 650F4 800748F4 0E004010 */  beqz       $v0, .L80074930
    /* 650F8 800748F8 80100300 */   sll       $v0, $v1, 2
    /* 650FC 800748FC 21105600 */  addu       $v0, $v0, $s6
    /* 65100 80074900 0000428C */  lw         $v0, 0x0($v0)
    /* 65104 80074904 4CD20108 */  j          .L80074930
    /* 65108 80074908 000022AE */   sw        $v0, 0x0($s1)
  .L8007490C:
    /* 6510C 8007490C 1480023C */  lui        $v0, %hi(Cars_gNumHumanRaceCars)
    /* 65110 80074910 00C8428C */  lw         $v0, %lo(Cars_gNumHumanRaceCars)($v0)
    /* 65114 80074914 00000000 */  nop
    /* 65118 80074918 2A100202 */  slt        $v0, $s0, $v0
    /* 6511C 8007491C 04004010 */  beqz       $v0, .L80074930
    /* 65120 80074920 00000000 */   nop
    /* 65124 80074924 0000628E */  lw         $v0, 0x0($s3)
    /* 65128 80074928 00000000 */  nop
    /* 6512C 8007492C 000022AE */  sw         $v0, 0x0($s1)
  .L80074930:
    /* 65130 80074930 04007326 */  addiu      $s3, $s3, 0x4
    /* 65134 80074934 01001026 */  addiu      $s0, $s0, 0x1
    /* 65138 80074938 50003126 */  addiu      $s1, $s1, 0x50
    /* 6513C 8007493C 0200022A */  slti       $v0, $s0, 0x2
    /* 65140 80074940 D9FF4014 */  bnez       $v0, .L800748A8
    /* 65144 80074944 50005226 */   addiu     $s2, $s2, 0x50
    /* 65148 80074948 21800000 */  addu       $s0, $zero, $zero
  .L8007494C:
    /* 6514C 8007494C 21208002 */  addu       $a0, $s4, $zero
    /* 65150 80074950 02D2010C */  jal        AudioClc_InitSource__FP16AudioClc_tSourceP8Car_tObj
    /* 65154 80074954 21280000 */   addu      $a1, $zero, $zero
    /* 65158 80074958 01001026 */  addiu      $s0, $s0, 0x1
    /* 6515C 8007495C 0400022A */  slti       $v0, $s0, 0x4
    /* 65160 80074960 FAFF4014 */  bnez       $v0, .L8007494C
    /* 65164 80074964 38009426 */   addiu     $s4, $s4, 0x38
    /* 65168 80074968 2C00BF8F */  lw         $ra, 0x2C($sp)
    /* 6516C 8007496C 2800B68F */  lw         $s6, 0x28($sp)
    /* 65170 80074970 2400B58F */  lw         $s5, 0x24($sp)
    /* 65174 80074974 2000B48F */  lw         $s4, 0x20($sp)
    /* 65178 80074978 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 6517C 8007497C 1800B28F */  lw         $s2, 0x18($sp)
    /* 65180 80074980 1400B18F */  lw         $s1, 0x14($sp)
    /* 65184 80074984 1000B08F */  lw         $s0, 0x10($sp)
    /* 65188 80074988 BC0080AF */  sw         $zero, %gp_rel(AudioClc_gCameraVelocity)($gp)
    /* 6518C 8007498C 0800E003 */  jr         $ra
    /* 65190 80074990 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel AudioClc_StartUp__Fv
