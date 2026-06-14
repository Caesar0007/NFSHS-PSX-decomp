.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CheckIfCaught__16AIHigh_BasicPerp, 0x5F0

glabel CheckIfCaught__16AIHigh_BasicPerp
    /* 4BF8C 8005B78C B0FFBD27 */  addiu      $sp, $sp, -0x50
    /* 4BF90 8005B790 3400B3AF */  sw         $s3, 0x34($sp)
    /* 4BF94 8005B794 21988000 */  addu       $s3, $a0, $zero
    /* 4BF98 8005B798 4C00BFAF */  sw         $ra, 0x4C($sp)
    /* 4BF9C 8005B79C 4800BEAF */  sw         $fp, 0x48($sp)
    /* 4BFA0 8005B7A0 4400B7AF */  sw         $s7, 0x44($sp)
    /* 4BFA4 8005B7A4 4000B6AF */  sw         $s6, 0x40($sp)
    /* 4BFA8 8005B7A8 3C00B5AF */  sw         $s5, 0x3C($sp)
    /* 4BFAC 8005B7AC 3800B4AF */  sw         $s4, 0x38($sp)
    /* 4BFB0 8005B7B0 3000B2AF */  sw         $s2, 0x30($sp)
    /* 4BFB4 8005B7B4 2C00B1AF */  sw         $s1, 0x2C($sp)
    /* 4BFB8 8005B7B8 2800B0AF */  sw         $s0, 0x28($sp)
    /* 4BFBC 8005B7BC 0000648E */  lw         $a0, 0x0($s3)
    /* 4BFC0 8005B7C0 1180033C */  lui        $v1, %hi(D_801131F4)
    /* 4BFC4 8005B7C4 6002828C */  lw         $v0, 0x260($a0)
    /* 4BFC8 8005B7C8 F431658C */  lw         $a1, %lo(D_801131F4)($v1)
    /* 4BFCC 8005B7CC 02004230 */  andi       $v0, $v0, 0x2
    /* 4BFD0 8005B7D0 08004010 */  beqz       $v0, .L8005B7F4
    /* 4BFD4 8005B7D4 00000000 */   nop
    /* 4BFD8 8005B7D8 6405828C */  lw         $v0, 0x564($a0)
    /* 4BFDC 8005B7DC 00000000 */  nop
    /* 4BFE0 8005B7E0 02004104 */  bgez       $v0, .L8005B7EC
    /* 4BFE4 8005B7E4 21184000 */   addu      $v1, $v0, $zero
    /* 4BFE8 8005B7E8 23180300 */  negu       $v1, $v1
  .L8005B7EC:
    /* 4BFEC 8005B7EC FE6D0108 */  j          .L8005B7F8
    /* 4BFF0 8005B7F0 00000000 */   nop
  .L8005B7F4:
    /* 4BFF4 8005B7F4 C000838C */  lw         $v1, 0xC0($a0)
  .L8005B7F8:
    /* 4BFF8 8005B7F8 7800628E */  lw         $v0, 0x78($s3)
    /* 4BFFC 8005B7FC 00000000 */  nop
    /* 4C000 8005B800 51014010 */  beqz       $v0, .L8005BD48
    /* 4C004 8005B804 1180023C */   lui       $v0, %hi(AIHigh_BasicPerp_PlayerCaughtSpeed)
    /* 4C008 8005B808 5CCD4224 */  addiu      $v0, $v0, %lo(AIHigh_BasicPerp_PlayerCaughtSpeed)
    /* 4C00C 8005B80C 80200500 */  sll        $a0, $a1, 2
    /* 4C010 8005B810 21108200 */  addu       $v0, $a0, $v0
    /* 4C014 8005B814 0000428C */  lw         $v0, 0x0($v0)
    /* 4C018 8005B818 00000000 */  nop
    /* 4C01C 8005B81C 2A104300 */  slt        $v0, $v0, $v1
    /* 4C020 8005B820 4A014014 */  bnez       $v0, .L8005BD4C
    /* 4C024 8005B824 21100000 */   addu      $v0, $zero, $zero
    /* 4C028 8005B828 1280023C */  lui        $v0, %hi(D_8011E0B0)
    /* 4C02C 8005B82C B0E0428C */  lw         $v0, %lo(D_8011E0B0)($v0)
    /* 4C030 8005B830 6800638E */  lw         $v1, 0x68($s3)
    /* 4C034 8005B834 00000000 */  nop
    /* 4C038 8005B838 23104300 */  subu       $v0, $v0, $v1
    /* 4C03C 8005B83C C0034228 */  slti       $v0, $v0, 0x3C0
    /* 4C040 8005B840 42014014 */  bnez       $v0, .L8005BD4C
    /* 4C044 8005B844 21100000 */   addu      $v0, $zero, $zero
    /* 4C048 8005B848 0000638E */  lw         $v1, 0x0($s3)
    /* 4C04C 8005B84C 00000000 */  nop
    /* 4C050 8005B850 9003628C */  lw         $v0, 0x390($v1)
    /* 4C054 8005B854 00000000 */  nop
    /* 4C058 8005B858 02004228 */  slti       $v0, $v0, 0x2
    /* 4C05C 8005B85C 3A014010 */  beqz       $v0, .L8005BD48
    /* 4C060 8005B860 21B00000 */   addu      $s6, $zero, $zero
    /* 4C064 8005B864 1180173C */  lui        $s7, %hi(Cars_gHumanRaceCarList)
    /* 4C068 8005B868 48FAFE26 */  addiu      $fp, $s7, %lo(Cars_gHumanRaceCarList)
    /* 4C06C 8005B86C 21A88000 */  addu       $s5, $a0, $zero
    /* 4C070 8005B870 0001638C */  lw         $v1, 0x100($v1)
    /* 4C074 8005B874 99990234 */  ori        $v0, $zero, 0x9999
    /* 4C078 8005B878 2A104300 */  slt        $v0, $v0, $v1
    /* 4C07C 8005B87C 2000A2AF */  sw         $v0, 0x20($sp)
  .L8005B880:
    /* 4C080 8005B880 1480023C */  lui        $v0, %hi(Cars_gNumCars)
    /* 4C084 8005B884 F4C7428C */  lw         $v0, %lo(Cars_gNumCars)($v0)
    /* 4C088 8005B888 00000000 */  nop
    /* 4C08C 8005B88C 2A10C202 */  slt        $v0, $s6, $v0
    /* 4C090 8005B890 2D014010 */  beqz       $v0, .L8005BD48
    /* 4C094 8005B894 1180023C */   lui       $v0, %hi(Cars_gList)
    /* 4C098 8005B898 DCF94224 */  addiu      $v0, $v0, %lo(Cars_gList)
    /* 4C09C 8005B89C 80181600 */  sll        $v1, $s6, 2
    /* 4C0A0 8005B8A0 21186200 */  addu       $v1, $v1, $v0
    /* 4C0A4 8005B8A4 0000628E */  lw         $v0, 0x0($s3)
    /* 4C0A8 8005B8A8 0000728C */  lw         $s2, 0x0($v1)
    /* 4C0AC 8005B8AC 6405438C */  lw         $v1, 0x564($v0)
    /* 4C0B0 8005B8B0 6405428E */  lw         $v0, 0x564($s2)
    /* 4C0B4 8005B8B4 00000000 */  nop
    /* 4C0B8 8005B8B8 23286200 */  subu       $a1, $v1, $v0
    /* 4C0BC 8005B8BC 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* 4C0C0 8005B8C0 EC31438C */  lw         $v1, %lo(GameSetup_gData)($v0)
    /* 4C0C4 8005B8C4 01000224 */  addiu      $v0, $zero, 0x1
    /* 4C0C8 8005B8C8 04006210 */  beq        $v1, $v0, .L8005B8DC
    /* 4C0CC 8005B8CC 21200000 */   addu      $a0, $zero, $zero
    /* 4C0D0 8005B8D0 05000224 */  addiu      $v0, $zero, 0x5
    /* 4C0D4 8005B8D4 19006214 */  bne        $v1, $v0, .L8005B93C
    /* 4C0D8 8005B8D8 1180023C */   lui       $v0, %hi(GameSetup_gData)
  .L8005B8DC:
    /* 4C0DC 8005B8DC 48FAE28E */  lw         $v0, %lo(Cars_gHumanRaceCarList)($s7)
    /* 4C0E0 8005B8E0 00000000 */  nop
    /* 4C0E4 8005B8E4 6002428C */  lw         $v0, 0x260($v0)
    /* 4C0E8 8005B8E8 00000000 */  nop
    /* 4C0EC 8005B8EC 00024230 */  andi       $v0, $v0, 0x200
    /* 4C0F0 8005B8F0 0D004014 */  bnez       $v0, .L8005B928
    /* 4C0F4 8005B8F4 02000224 */   addiu     $v0, $zero, 0x2
    /* 4C0F8 8005B8F8 1480033C */  lui        $v1, %hi(Cars_gNumHumanRaceCars)
    /* 4C0FC 8005B8FC 00C8638C */  lw         $v1, %lo(Cars_gNumHumanRaceCars)($v1)
    /* 4C100 8005B900 00000000 */  nop
    /* 4C104 8005B904 0D006214 */  bne        $v1, $v0, .L8005B93C
    /* 4C108 8005B908 1180023C */   lui       $v0, %hi(GameSetup_gData)
    /* 4C10C 8005B90C 0400C28F */  lw         $v0, 0x4($fp)
    /* 4C110 8005B910 00000000 */  nop
    /* 4C114 8005B914 6002428C */  lw         $v0, 0x260($v0)
    /* 4C118 8005B918 00000000 */  nop
    /* 4C11C 8005B91C 00024230 */  andi       $v0, $v0, 0x200
    /* 4C120 8005B920 06004010 */  beqz       $v0, .L8005B93C
    /* 4C124 8005B924 1180023C */   lui       $v0, %hi(GameSetup_gData)
  .L8005B928:
    /* 4C128 8005B928 6002428E */  lw         $v0, 0x260($s2)
    /* 4C12C 8005B92C 00000000 */  nop
    /* 4C130 8005B930 00024230 */  andi       $v0, $v0, 0x200
    /* 4C134 8005B934 1F004014 */  bnez       $v0, .L8005B9B4
    /* 4C138 8005B938 1180023C */   lui       $v0, %hi(GameSetup_gData)
  .L8005B93C:
    /* 4C13C 8005B93C EC31438C */  lw         $v1, %lo(GameSetup_gData)($v0)
    /* 4C140 8005B940 01000224 */  addiu      $v0, $zero, 0x1
    /* 4C144 8005B944 03006210 */  beq        $v1, $v0, .L8005B954
    /* 4C148 8005B948 05000224 */   addiu     $v0, $zero, 0x5
    /* 4C14C 8005B94C 14006214 */  bne        $v1, $v0, .L8005B9A0
    /* 4C150 8005B950 00000000 */   nop
  .L8005B954:
    /* 4C154 8005B954 48FAE28E */  lw         $v0, %lo(Cars_gHumanRaceCarList)($s7)
    /* 4C158 8005B958 00000000 */  nop
    /* 4C15C 8005B95C 6002428C */  lw         $v0, 0x260($v0)
    /* 4C160 8005B960 00000000 */  nop
    /* 4C164 8005B964 00024230 */  andi       $v0, $v0, 0x200
    /* 4C168 8005B968 13004014 */  bnez       $v0, .L8005B9B8
    /* 4C16C 8005B96C 02000224 */   addiu     $v0, $zero, 0x2
    /* 4C170 8005B970 1480033C */  lui        $v1, %hi(Cars_gNumHumanRaceCars)
    /* 4C174 8005B974 00C8638C */  lw         $v1, %lo(Cars_gNumHumanRaceCars)($v1)
    /* 4C178 8005B978 00000000 */  nop
    /* 4C17C 8005B97C 08006214 */  bne        $v1, $v0, .L8005B9A0
    /* 4C180 8005B980 00000000 */   nop
    /* 4C184 8005B984 0400C28F */  lw         $v0, 0x4($fp)
    /* 4C188 8005B988 00000000 */  nop
    /* 4C18C 8005B98C 6002428C */  lw         $v0, 0x260($v0)
    /* 4C190 8005B990 00000000 */  nop
    /* 4C194 8005B994 00024230 */  andi       $v0, $v0, 0x200
    /* 4C198 8005B998 07004014 */  bnez       $v0, .L8005B9B8
    /* 4C19C 8005B99C 00000000 */   nop
  .L8005B9A0:
    /* 4C1A0 8005B9A0 6002428E */  lw         $v0, 0x260($s2)
    /* 4C1A4 8005B9A4 00000000 */  nop
    /* 4C1A8 8005B9A8 20004230 */  andi       $v0, $v0, 0x20
    /* 4C1AC 8005B9AC 02004010 */  beqz       $v0, .L8005B9B8
    /* 4C1B0 8005B9B0 00000000 */   nop
  .L8005B9B4:
    /* 4C1B4 8005B9B4 01000424 */  addiu      $a0, $zero, 0x1
  .L8005B9B8:
    /* 4C1B8 8005B9B8 E1008010 */  beqz       $a0, .L8005BD40
    /* 4C1BC 8005B9BC 00000000 */   nop
    /* 4C1C0 8005B9C0 7005438E */  lw         $v1, 0x570($s2)
    /* 4C1C4 8005B9C4 00000000 */  nop
    /* 4C1C8 8005B9C8 02006230 */  andi       $v0, $v1, 0x2
    /* 4C1CC 8005B9CC DC004010 */  beqz       $v0, .L8005BD40
    /* 4C1D0 8005B9D0 00000000 */   nop
    /* 4C1D4 8005B9D4 7C014296 */  lhu        $v0, 0x17C($s2)
    /* 4C1D8 8005B9D8 00000000 */  nop
    /* 4C1DC 8005B9DC D8004014 */  bnez       $v0, .L8005BD40
    /* 4C1E0 8005B9E0 00000000 */   nop
    /* 4C1E4 8005B9E4 91004292 */  lbu        $v0, 0x91($s2)
    /* 4C1E8 8005B9E8 00000000 */  nop
    /* 4C1EC 8005B9EC D4004010 */  beqz       $v0, .L8005BD40
    /* 4C1F0 8005B9F0 04006230 */   andi      $v0, $v1, 0x4
    /* 4C1F4 8005B9F4 D2004014 */  bnez       $v0, .L8005BD40
    /* 4C1F8 8005B9F8 99990234 */   ori       $v0, $zero, 0x9999
    /* 4C1FC 8005B9FC 0001438E */  lw         $v1, 0x100($s2)
    /* 4C200 8005BA00 00000000 */  nop
    /* 4C204 8005BA04 2A104300 */  slt        $v0, $v0, $v1
    /* 4C208 8005BA08 CD004010 */  beqz       $v0, .L8005BD40
    /* 4C20C 8005BA0C 1180023C */   lui       $v0, %hi(AIHigh_BasicPerp_MinDeltaSpeed)
    /* 4C210 8005BA10 74CD4224 */  addiu      $v0, $v0, %lo(AIHigh_BasicPerp_MinDeltaSpeed)
    /* 4C214 8005BA14 2110A202 */  addu       $v0, $s5, $v0
    /* 4C218 8005BA18 0000428C */  lw         $v0, 0x0($v0)
    /* 4C21C 8005BA1C 00000000 */  nop
    /* 4C220 8005BA20 2A10A200 */  slt        $v0, $a1, $v0
    /* 4C224 8005BA24 C6004010 */  beqz       $v0, .L8005BD40
    /* 4C228 8005BA28 1180023C */   lui       $v0, %hi(AIHigh_BasicPerp_CopCaughtSpeed)
    /* 4C22C 8005BA2C 80CD4224 */  addiu      $v0, $v0, %lo(AIHigh_BasicPerp_CopCaughtSpeed)
    /* 4C230 8005BA30 2110A202 */  addu       $v0, $s5, $v0
    /* 4C234 8005BA34 6405438E */  lw         $v1, 0x564($s2)
    /* 4C238 8005BA38 0000428C */  lw         $v0, 0x0($v0)
    /* 4C23C 8005BA3C 02006104 */  bgez       $v1, .L8005BA48
    /* 4C240 8005BA40 00000000 */   nop
    /* 4C244 8005BA44 23180300 */  negu       $v1, $v1
  .L8005BA48:
    /* 4C248 8005BA48 2A186200 */  slt        $v1, $v1, $v0
    /* 4C24C 8005BA4C BC006010 */  beqz       $v1, .L8005BD40
    /* 4C250 8005BA50 1180023C */   lui       $v0, %hi(AIHigh_BasicPerp_PlayerCaughtDeltaY)
    /* 4C254 8005BA54 68CD4224 */  addiu      $v0, $v0, %lo(AIHigh_BasicPerp_PlayerCaughtDeltaY)
    /* 4C258 8005BA58 2110A202 */  addu       $v0, $s5, $v0
    /* 4C25C 8005BA5C 0000638E */  lw         $v1, 0x0($s3)
    /* 4C260 8005BA60 A400458E */  lw         $a1, 0xA4($s2)
    /* 4C264 8005BA64 A400648C */  lw         $a0, 0xA4($v1)
    /* 4C268 8005BA68 0000428C */  lw         $v0, 0x0($v0)
    /* 4C26C 8005BA6C 2318A400 */  subu       $v1, $a1, $a0
    /* 4C270 8005BA70 0300601C */  bgtz       $v1, .L8005BA80
    /* 4C274 8005BA74 2A186200 */   slt       $v1, $v1, $v0
    /* 4C278 8005BA78 23188500 */  subu       $v1, $a0, $a1
    /* 4C27C 8005BA7C 2A186200 */  slt        $v1, $v1, $v0
  .L8005BA80:
    /* 4C280 8005BA80 AF006010 */  beqz       $v1, .L8005BD40
    /* 4C284 8005BA84 00000000 */   nop
    /* 4C288 8005BA88 0000648E */  lw         $a0, 0x0($s3)
    /* 4C28C 8005BA8C 2ECC010C */  jal        AIWorld_ApxSplineDistance__FP8Car_tObjT0
    /* 4C290 8005BA90 21284002 */   addu      $a1, $s2, $zero
    /* 4C294 8005BA94 02004104 */  bgez       $v0, .L8005BAA0
    /* 4C298 8005BA98 21884000 */   addu      $s1, $v0, $zero
    /* 4C29C 8005BA9C 23881100 */  negu       $s1, $s1
  .L8005BAA0:
    /* 4C2A0 8005BAA0 0000638E */  lw         $v1, 0x0($s3)
    /* 4C2A4 8005BAA4 07000724 */  addiu      $a3, $zero, 0x7
    /* 4C2A8 8005BAA8 08006484 */  lh         $a0, 0x8($v1)
    /* 4C2AC 8005BAAC 1480053C */  lui        $a1, %hi(BWorldSm_slices)
    /* 4C2B0 8005BAB0 C0C7A58C */  lw         $a1, %lo(BWorldSm_slices)($a1)
    /* 4C2B4 8005BAB4 40210400 */  sll        $a0, $a0, 5
    /* 4C2B8 8005BAB8 21208500 */  addu       $a0, $a0, $a1
    /* 4C2BC 8005BABC 1D008490 */  lbu        $a0, 0x1D($a0)
    /* 4C2C0 8005BAC0 C406668C */  lw         $a2, 0x6C4($v1)
    /* 4C2C4 8005BAC4 02110400 */  srl        $v0, $a0, 4
    /* 4C2C8 8005BAC8 2310E200 */  subu       $v0, $a3, $v0
    /* 4C2CC 8005BACC 2A10C200 */  slt        $v0, $a2, $v0
    /* 4C2D0 8005BAD0 21004014 */  bnez       $v0, .L8005BB58
    /* 4C2D4 8005BAD4 21800000 */   addu      $s0, $zero, $zero
    /* 4C2D8 8005BAD8 0F008230 */  andi       $v0, $a0, 0xF
    /* 4C2DC 8005BADC 06004224 */  addiu      $v0, $v0, 0x6
    /* 4C2E0 8005BAE0 2A104600 */  slt        $v0, $v0, $a2
    /* 4C2E4 8005BAE4 1D004014 */  bnez       $v0, .L8005BB5C
    /* 4C2E8 8005BAE8 1180023C */   lui       $v0, %hi(AIHigh_BasicPerp_CaughtDistance)
    /* 4C2EC 8005BAEC 08004486 */  lh         $a0, 0x8($s2)
    /* 4C2F0 8005BAF0 00000000 */  nop
    /* 4C2F4 8005BAF4 40110400 */  sll        $v0, $a0, 5
    /* 4C2F8 8005BAF8 21104500 */  addu       $v0, $v0, $a1
    /* 4C2FC 8005BAFC 1D004390 */  lbu        $v1, 0x1D($v0)
    /* 4C300 8005BB00 C406458E */  lw         $a1, 0x6C4($s2)
    /* 4C304 8005BB04 02110300 */  srl        $v0, $v1, 4
    /* 4C308 8005BB08 2310E200 */  subu       $v0, $a3, $v0
    /* 4C30C 8005BB0C 2A10A200 */  slt        $v0, $a1, $v0
    /* 4C310 8005BB10 12004014 */  bnez       $v0, .L8005BB5C
    /* 4C314 8005BB14 1180023C */   lui       $v0, %hi(AIHigh_BasicPerp_CaughtDistance)
    /* 4C318 8005BB18 0F006230 */  andi       $v0, $v1, 0xF
    /* 4C31C 8005BB1C 06004224 */  addiu      $v0, $v0, 0x6
    /* 4C320 8005BB20 2A104500 */  slt        $v0, $v0, $a1
    /* 4C324 8005BB24 0D004014 */  bnez       $v0, .L8005BB5C
    /* 4C328 8005BB28 1180023C */   lui       $v0, %hi(AIHigh_BasicPerp_CaughtDistance)
    /* 4C32C 8005BB2C 16CD010C */  jal        AIWorld_CheckForBarrierBetweenLanes__Fiii
    /* 4C330 8005BB30 00000000 */   nop
    /* 4C334 8005BB34 09004010 */  beqz       $v0, .L8005BB5C
    /* 4C338 8005BB38 1180023C */   lui       $v0, %hi(AIHigh_BasicPerp_CaughtDistance)
    /* 4C33C 8005BB3C 0000628E */  lw         $v0, 0x0($s3)
    /* 4C340 8005BB40 C406458E */  lw         $a1, 0x6C4($s2)
    /* 4C344 8005BB44 08004484 */  lh         $a0, 0x8($v0)
    /* 4C348 8005BB48 C406468C */  lw         $a2, 0x6C4($v0)
    /* 4C34C 8005BB4C 16CD010C */  jal        AIWorld_CheckForBarrierBetweenLanes__Fiii
    /* 4C350 8005BB50 00000000 */   nop
    /* 4C354 8005BB54 2B800200 */  sltu       $s0, $zero, $v0
  .L8005BB58:
    /* 4C358 8005BB58 1180023C */  lui        $v0, %hi(AIHigh_BasicPerp_CaughtDistance)
  .L8005BB5C:
    /* 4C35C 8005BB5C 8CCD4224 */  addiu      $v0, $v0, %lo(AIHigh_BasicPerp_CaughtDistance)
    /* 4C360 8005BB60 2110A202 */  addu       $v0, $s5, $v0
    /* 4C364 8005BB64 0000428C */  lw         $v0, 0x0($v0)
    /* 4C368 8005BB68 00000000 */  nop
    /* 4C36C 8005BB6C 2A102202 */  slt        $v0, $s1, $v0
    /* 4C370 8005BB70 73004010 */  beqz       $v0, .L8005BD40
    /* 4C374 8005BB74 00000000 */   nop
    /* 4C378 8005BB78 71000016 */  bnez       $s0, .L8005BD40
    /* 4C37C 8005BB7C 21A00000 */   addu      $s4, $zero, $zero
    /* 4C380 8005BB80 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* 4C384 8005BB84 EC31438C */  lw         $v1, %lo(GameSetup_gData)($v0)
    /* 4C388 8005BB88 01000224 */  addiu      $v0, $zero, 0x1
    /* 4C38C 8005BB8C 04006210 */  beq        $v1, $v0, .L8005BBA0
    /* 4C390 8005BB90 0100113C */   lui       $s1, (0x10000 >> 16)
    /* 4C394 8005BB94 05000224 */  addiu      $v0, $zero, 0x5
    /* 4C398 8005BB98 47006214 */  bne        $v1, $v0, .L8005BCB8
    /* 4C39C 8005BB9C 00000000 */   nop
  .L8005BBA0:
    /* 4C3A0 8005BBA0 48FAE28E */  lw         $v0, %lo(Cars_gHumanRaceCarList)($s7)
    /* 4C3A4 8005BBA4 00000000 */  nop
    /* 4C3A8 8005BBA8 6002428C */  lw         $v0, 0x260($v0)
    /* 4C3AC 8005BBAC 00000000 */  nop
    /* 4C3B0 8005BBB0 00024230 */  andi       $v0, $v0, 0x200
    /* 4C3B4 8005BBB4 0D004014 */  bnez       $v0, .L8005BBEC
    /* 4C3B8 8005BBB8 02000224 */   addiu     $v0, $zero, 0x2
    /* 4C3BC 8005BBBC 1480033C */  lui        $v1, %hi(Cars_gNumHumanRaceCars)
    /* 4C3C0 8005BBC0 00C8638C */  lw         $v1, %lo(Cars_gNumHumanRaceCars)($v1)
    /* 4C3C4 8005BBC4 00000000 */  nop
    /* 4C3C8 8005BBC8 3B006214 */  bne        $v1, $v0, .L8005BCB8
    /* 4C3CC 8005BBCC 00000000 */   nop
    /* 4C3D0 8005BBD0 0400C28F */  lw         $v0, 0x4($fp)
    /* 4C3D4 8005BBD4 00000000 */  nop
    /* 4C3D8 8005BBD8 6002428C */  lw         $v0, 0x260($v0)
    /* 4C3DC 8005BBDC 00000000 */  nop
    /* 4C3E0 8005BBE0 00024230 */  andi       $v0, $v0, 0x200
    /* 4C3E4 8005BBE4 34004010 */  beqz       $v0, .L8005BCB8
    /* 4C3E8 8005BBE8 00000000 */   nop
  .L8005BBEC:
    /* 4C3EC 8005BBEC 0000628E */  lw         $v0, 0x0($s3)
    /* 4C3F0 8005BBF0 A000448E */  lw         $a0, 0xA0($s2)
    /* 4C3F4 8005BBF4 A000428C */  lw         $v0, 0xA0($v0)
    /* 4C3F8 8005BBF8 00000000 */  nop
    /* 4C3FC 8005BBFC 23208200 */  subu       $a0, $a0, $v0
    /* 4C400 8005BC00 1000A4AF */  sw         $a0, 0x10($sp)
    /* 4C404 8005BC04 0000638E */  lw         $v1, 0x0($s3)
    /* 4C408 8005BC08 A400428E */  lw         $v0, 0xA4($s2)
    /* 4C40C 8005BC0C A400638C */  lw         $v1, 0xA4($v1)
    /* 4C410 8005BC10 00000000 */  nop
    /* 4C414 8005BC14 23104300 */  subu       $v0, $v0, $v1
    /* 4C418 8005BC18 1400A2AF */  sw         $v0, 0x14($sp)
    /* 4C41C 8005BC1C 0000638E */  lw         $v1, 0x0($s3)
    /* 4C420 8005BC20 A800428E */  lw         $v0, 0xA8($s2)
    /* 4C424 8005BC24 A800638C */  lw         $v1, 0xA8($v1)
    /* 4C428 8005BC28 00000000 */  nop
    /* 4C42C 8005BC2C 23104300 */  subu       $v0, $v0, $v1
    /* 4C430 8005BC30 1800A2AF */  sw         $v0, 0x18($sp)
    /* 4C434 8005BC34 0000628E */  lw         $v0, 0x0($s3)
    /* 4C438 8005BC38 00000000 */  nop
    /* 4C43C 8005BC3C F000458C */  lw         $a1, 0xF0($v0)
    /* 4C440 8005BC40 CA90030C */  jal        fixedmult
    /* 4C444 8005BC44 00000000 */   nop
    /* 4C448 8005BC48 0000638E */  lw         $v1, 0x0($s3)
    /* 4C44C 8005BC4C 1400A48F */  lw         $a0, 0x14($sp)
    /* 4C450 8005BC50 F400658C */  lw         $a1, 0xF4($v1)
    /* 4C454 8005BC54 CA90030C */  jal        fixedmult
    /* 4C458 8005BC58 21804000 */   addu      $s0, $v0, $zero
    /* 4C45C 8005BC5C 0000638E */  lw         $v1, 0x0($s3)
    /* 4C460 8005BC60 1800A48F */  lw         $a0, 0x18($sp)
    /* 4C464 8005BC64 F800658C */  lw         $a1, 0xF8($v1)
    /* 4C468 8005BC68 CA90030C */  jal        fixedmult
    /* 4C46C 8005BC6C 21884000 */   addu      $s1, $v0, $zero
    /* 4C470 8005BC70 21801102 */  addu       $s0, $s0, $s1
    /* 4C474 8005BC74 0000638E */  lw         $v1, 0x0($s3)
    /* 4C478 8005BC78 1000A48F */  lw         $a0, 0x10($sp)
    /* 4C47C 8005BC7C 0801658C */  lw         $a1, 0x108($v1)
    /* 4C480 8005BC80 CA90030C */  jal        fixedmult
    /* 4C484 8005BC84 21A00202 */   addu      $s4, $s0, $v0
    /* 4C488 8005BC88 0000638E */  lw         $v1, 0x0($s3)
    /* 4C48C 8005BC8C 1400A48F */  lw         $a0, 0x14($sp)
    /* 4C490 8005BC90 0C01658C */  lw         $a1, 0x10C($v1)
    /* 4C494 8005BC94 CA90030C */  jal        fixedmult
    /* 4C498 8005BC98 21884000 */   addu      $s1, $v0, $zero
    /* 4C49C 8005BC9C 0000638E */  lw         $v1, 0x0($s3)
    /* 4C4A0 8005BCA0 1800A48F */  lw         $a0, 0x18($sp)
    /* 4C4A4 8005BCA4 1001658C */  lw         $a1, 0x110($v1)
    /* 4C4A8 8005BCA8 CA90030C */  jal        fixedmult
    /* 4C4AC 8005BCAC 21804000 */   addu      $s0, $v0, $zero
    /* 4C4B0 8005BCB0 21883002 */  addu       $s1, $s1, $s0
    /* 4C4B4 8005BCB4 21882202 */  addu       $s1, $s1, $v0
  .L8005BCB8:
    /* 4C4B8 8005BCB8 2000A78F */  lw         $a3, 0x20($sp)
    /* 4C4BC 8005BCBC 00000000 */  nop
    /* 4C4C0 8005BCC0 1900E010 */  beqz       $a3, .L8005BD28
    /* 4C4C4 8005BCC4 0400033C */   lui       $v1, (0x471C6 >> 16)
    /* 4C4C8 8005BCC8 6805428E */  lw         $v0, 0x568($s2)
    /* 4C4CC 8005BCCC C6716334 */  ori        $v1, $v1, (0x471C6 & 0xFFFF)
    /* 4C4D0 8005BCD0 2A106200 */  slt        $v0, $v1, $v0
    /* 4C4D4 8005BCD4 08004014 */  bnez       $v0, .L8005BCF8
    /* 4C4D8 8005BCD8 00000000 */   nop
    /* 4C4DC 8005BCDC 0000628E */  lw         $v0, 0x0($s3)
    /* 4C4E0 8005BCE0 00000000 */  nop
    /* 4C4E4 8005BCE4 6805428C */  lw         $v0, 0x568($v0)
    /* 4C4E8 8005BCE8 00000000 */  nop
    /* 4C4EC 8005BCEC 2A106200 */  slt        $v0, $v1, $v0
    /* 4C4F0 8005BCF0 0D004010 */  beqz       $v0, .L8005BD28
    /* 4C4F4 8005BCF4 00000000 */   nop
  .L8005BCF8:
    /* 4C4F8 8005BCF8 0800033C */  lui        $v1, (0x8FFFF >> 16)
    /* 4C4FC 8005BCFC FFFF6334 */  ori        $v1, $v1, (0x8FFFF & 0xFFFF)
    /* 4C500 8005BD00 02008106 */  bgez       $s4, .L8005BD0C
    /* 4C504 8005BD04 21108002 */   addu      $v0, $s4, $zero
    /* 4C508 8005BD08 23100200 */  negu       $v0, $v0
  .L8005BD0C:
    /* 4C50C 8005BD0C 2A106200 */  slt        $v0, $v1, $v0
    /* 4C510 8005BD10 0B004014 */  bnez       $v0, .L8005BD40
    /* 4C514 8005BD14 00000000 */   nop
    /* 4C518 8005BD18 09002006 */  bltz       $s1, .L8005BD40
    /* 4C51C 8005BD1C 2A107100 */   slt       $v0, $v1, $s1
    /* 4C520 8005BD20 D7FE4014 */  bnez       $v0, .L8005B880
    /* 4C524 8005BD24 0100D626 */   addiu     $s6, $s6, 0x1
  .L8005BD28:
    /* 4C528 8005BD28 6C00628E */  lw         $v0, 0x6C($s3)
    /* 4C52C 8005BD2C 00000000 */  nop
    /* 4C530 8005BD30 06004014 */  bnez       $v0, .L8005BD4C
    /* 4C534 8005BD34 01000224 */   addiu     $v0, $zero, 0x1
    /* 4C538 8005BD38 536F0108 */  j          .L8005BD4C
    /* 4C53C 8005BD3C 6C0072AE */   sw        $s2, 0x6C($s3)
  .L8005BD40:
    /* 4C540 8005BD40 206E0108 */  j          .L8005B880
    /* 4C544 8005BD44 0100D626 */   addiu     $s6, $s6, 0x1
  .L8005BD48:
    /* 4C548 8005BD48 21100000 */  addu       $v0, $zero, $zero
  .L8005BD4C:
    /* 4C54C 8005BD4C 4C00BF8F */  lw         $ra, 0x4C($sp)
    /* 4C550 8005BD50 4800BE8F */  lw         $fp, 0x48($sp)
    /* 4C554 8005BD54 4400B78F */  lw         $s7, 0x44($sp)
    /* 4C558 8005BD58 4000B68F */  lw         $s6, 0x40($sp)
    /* 4C55C 8005BD5C 3C00B58F */  lw         $s5, 0x3C($sp)
    /* 4C560 8005BD60 3800B48F */  lw         $s4, 0x38($sp)
    /* 4C564 8005BD64 3400B38F */  lw         $s3, 0x34($sp)
    /* 4C568 8005BD68 3000B28F */  lw         $s2, 0x30($sp)
    /* 4C56C 8005BD6C 2C00B18F */  lw         $s1, 0x2C($sp)
    /* 4C570 8005BD70 2800B08F */  lw         $s0, 0x28($sp)
    /* 4C574 8005BD74 0800E003 */  jr         $ra
    /* 4C578 8005BD78 5000BD27 */   addiu     $sp, $sp, 0x50
endlabel CheckIfCaught__16AIHigh_BasicPerp
