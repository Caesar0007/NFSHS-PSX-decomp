.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Cars_InitializeCarTablesFlagsAndCounters__FP8Car_tObj, 0x518

glabel Cars_InitializeCarTablesFlagsAndCounters__FP8Car_tObj
    /* 768E4 800860E4 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 768E8 800860E8 1400B1AF */  sw         $s1, 0x14($sp)
    /* 768EC 800860EC 21888000 */  addu       $s1, $a0, $zero
    /* 768F0 800860F0 40022426 */  addiu      $a0, $s1, 0x240
    /* 768F4 800860F4 1180023C */  lui        $v0, %hi(Cars_gList)
    /* 768F8 800860F8 A802868F */  lw         $a2, %gp_rel(Cars_gNumCars)($gp)
    /* 768FC 800860FC DCF94224 */  addiu      $v0, $v0, %lo(Cars_gList)
    /* 76900 80086100 2000BFAF */  sw         $ra, 0x20($sp)
    /* 76904 80086104 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 76908 80086108 1800B2AF */  sw         $s2, 0x18($sp)
    /* 7690C 8008610C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 76910 80086110 8802258E */  lw         $a1, 0x288($s1)
    /* 76914 80086114 80180600 */  sll        $v1, $a2, 2
    /* 76918 80086118 0400B38C */  lw         $s3, 0x4($a1)
    /* 7691C 8008611C 21106200 */  addu       $v0, $v1, $v0
    /* 76920 80086120 000051AC */  sw         $s1, 0x0($v0)
    /* 76924 80086124 1180023C */  lui        $v0, %hi(Cars_gSortedList)
    /* 76928 80086128 FCFA4224 */  addiu      $v0, $v0, %lo(Cars_gSortedList)
    /* 7692C 8008612C 21106200 */  addu       $v0, $v1, $v0
    /* 76930 80086130 000051AC */  sw         $s1, 0x0($v0)
    /* 76934 80086134 1180023C */  lui        $v0, %hi(Cars_gTotalSortedList)
    /* 76938 80086138 20FB4224 */  addiu      $v0, $v0, %lo(Cars_gTotalSortedList)
    /* 7693C 8008613C 21186200 */  addu       $v1, $v1, $v0
    /* 76940 80086140 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 76944 80086144 000071AC */  sw         $s1, 0x0($v1)
    /* 76948 80086148 540226AE */  sw         $a2, 0x254($s1)
    /* 7694C 8008614C 0100C624 */  addiu      $a2, $a2, 0x1
    /* 76950 80086150 8802238E */  lw         $v1, 0x288($s1)
    /* 76954 80086154 1180053C */  lui        $a1, %hi(GameSetup_gCarNames)
    /* 76958 80086158 600220AE */  sw         $zero, 0x260($s1)
    /* 7695C 8008615C 580222AE */  sw         $v0, 0x258($s1)
    /* 76960 80086160 0000638C */  lw         $v1, 0x0($v1)
    /* 76964 80086164 4430A524 */  addiu      $a1, $a1, %lo(GameSetup_gCarNames)
    /* 76968 80086168 A80286AF */  sw         $a2, %gp_rel(Cars_gNumCars)($gp)
    /* 7696C 8008616C 80100300 */  sll        $v0, $v1, 2
    /* 76970 80086170 21104300 */  addu       $v0, $v0, $v1
    /* 76974 80086174 CA96030C */  jal        strcpy
    /* 76978 80086178 21284500 */   addu      $a1, $v0, $a1
    /* 7697C 8008617C 8802228E */  lw         $v0, 0x288($s1)
    /* 76980 80086180 00000000 */  nop
    /* 76984 80086184 0000448C */  lw         $a0, 0x0($v0)
    /* 76988 80086188 00000000 */  nop
    /* 7698C 8008618C 1D008228 */  slti       $v0, $a0, 0x1D
    /* 76990 80086190 08004010 */  beqz       $v0, .L800861B4
    /* 76994 80086194 1480053C */   lui       $a1, %hi(D_8013C7E0)
    /* 76998 80086198 94E4020C */  jal        TextSys_Word__Fi
    /* 7699C 8008619C 4E008424 */   addiu     $a0, $a0, 0x4E
    /* 769A0 800861A0 49022426 */  addiu      $a0, $s1, 0x249
    /* 769A4 800861A4 CA96030C */  jal        strcpy
    /* 769A8 800861A8 21284000 */   addu      $a1, $v0, $zero
    /* 769AC 800861AC 71180208 */  j          .L800861C4
    /* 769B0 800861B0 01006232 */   andi      $v0, $s3, 0x1
  .L800861B4:
    /* 769B4 800861B4 49022426 */  addiu      $a0, $s1, 0x249
    /* 769B8 800861B8 2F91030C */  jal        sprintf
    /* 769BC 800861BC E0C7A524 */   addiu     $a1, $a1, %lo(D_8013C7E0)
    /* 769C0 800861C0 01006232 */  andi       $v0, $s3, 0x1
  .L800861C4:
    /* 769C4 800861C4 4E004010 */  beqz       $v0, .L80086300
    /* 769C8 800861C8 02006232 */   andi      $v0, $s3, 0x2
    /* 769CC 800861CC B402848F */  lw         $a0, %gp_rel(Cars_gNumHumanRaceCars)($gp)
    /* 769D0 800861D0 74AE000C */  jal        PlayerNameExist__Fi
    /* 769D4 800861D4 00000000 */   nop
    /* 769D8 800861D8 06004010 */  beqz       $v0, .L800861F4
    /* 769DC 800861DC 1180023C */   lui       $v0, %hi(D_80114603)
    /* 769E0 800861E0 B402848F */  lw         $a0, %gp_rel(Cars_gNumHumanRaceCars)($gp)
    /* 769E4 800861E4 A2AE000C */  jal        PlayerNameMixedCase__Fi
    /* 769E8 800861E8 00000000 */   nop
    /* 769EC 800861EC 8D180208 */  j          .L80086234
    /* 769F0 800861F0 00000000 */   nop
  .L800861F4:
    /* 769F4 800861F4 03464390 */  lbu        $v1, %lo(D_80114603)($v0)
    /* 769F8 800861F8 01000224 */  addiu      $v0, $zero, 0x1
    /* 769FC 800861FC 0B006214 */  bne        $v1, $v0, .L8008622C
    /* 76A00 80086200 00000000 */   nop
    /* 76A04 80086204 94E4020C */  jal        TextSys_Word__Fi
    /* 76A08 80086208 2F000424 */   addiu     $a0, $zero, 0x2F
    /* 76A0C 8008620C 21284000 */  addu       $a1, $v0, $zero
    /* 76A10 80086210 8802248E */  lw         $a0, 0x288($s1)
    /* 76A14 80086214 B402868F */  lw         $a2, %gp_rel(Cars_gNumHumanRaceCars)($gp)
    /* 76A18 80086218 5C008424 */  addiu      $a0, $a0, 0x5C
    /* 76A1C 8008621C 2F91030C */  jal        sprintf
    /* 76A20 80086220 0100C624 */   addiu     $a2, $a2, 0x1
    /* 76A24 80086224 92180208 */  j          .L80086248
    /* 76A28 80086228 1180053C */   lui       $a1, %hi(D_80114984)
  .L8008622C:
    /* 76A2C 8008622C 94E4020C */  jal        TextSys_Word__Fi
    /* 76A30 80086230 2E000424 */   addiu     $a0, $zero, 0x2E
  .L80086234:
    /* 76A34 80086234 8802248E */  lw         $a0, 0x288($s1)
    /* 76A38 80086238 21284000 */  addu       $a1, $v0, $zero
    /* 76A3C 8008623C 2F91030C */  jal        sprintf
    /* 76A40 80086240 5C008424 */   addiu     $a0, $a0, 0x5C
    /* 76A44 80086244 1180053C */  lui        $a1, %hi(D_80114984)
  .L80086248:
    /* 76A48 80086248 8449A524 */  addiu      $a1, $a1, %lo(D_80114984)
    /* 76A4C 8008624C 8802248E */  lw         $a0, 0x288($s1)
    /* 76A50 80086250 B402828F */  lw         $v0, %gp_rel(Cars_gNumHumanRaceCars)($gp)
    /* 76A54 80086254 68008424 */  addiu      $a0, $a0, 0x68
    /* 76A58 80086258 C0100200 */  sll        $v0, $v0, 3
    /* 76A5C 8008625C CA96030C */  jal        strcpy
    /* 76A60 80086260 21284500 */   addu      $a1, $v0, $a1
    /* 76A64 80086264 1180033C */  lui        $v1, %hi(Cars_gHumanRaceCarList)
    /* 76A68 80086268 B402848F */  lw         $a0, %gp_rel(Cars_gNumHumanRaceCars)($gp)
    /* 76A6C 8008626C 48FA6324 */  addiu      $v1, $v1, %lo(Cars_gHumanRaceCarList)
    /* 76A70 80086270 80100400 */  sll        $v0, $a0, 2
    /* 76A74 80086274 21104300 */  addu       $v0, $v0, $v1
    /* 76A78 80086278 580224AE */  sw         $a0, 0x258($s1)
    /* 76A7C 8008627C 01008424 */  addiu      $a0, $a0, 0x1
    /* 76A80 80086280 1180033C */  lui        $v1, %hi(Cars_gRaceCarList)
    /* 76A84 80086284 000051AC */  sw         $s1, 0x0($v0)
    /* 76A88 80086288 6002228E */  lw         $v0, 0x260($s1)
    /* 76A8C 8008628C 00FA6324 */  addiu      $v1, $v1, %lo(Cars_gRaceCarList)
    /* 76A90 80086290 B40284AF */  sw         $a0, %gp_rel(Cars_gNumHumanRaceCars)($gp)
    /* 76A94 80086294 AC02848F */  lw         $a0, %gp_rel(Cars_gNumRaceCars)($gp)
    /* 76A98 80086298 04004234 */  ori        $v0, $v0, 0x4
    /* 76A9C 8008629C 600222AE */  sw         $v0, 0x260($s1)
    /* 76AA0 800862A0 80100400 */  sll        $v0, $a0, 2
    /* 76AA4 800862A4 21104300 */  addu       $v0, $v0, $v1
    /* 76AA8 800862A8 01008424 */  addiu      $a0, $a0, 0x1
    /* 76AAC 800862AC 1180033C */  lui        $v1, %hi(Cars_gLifeBasisCarList)
    /* 76AB0 800862B0 000051AC */  sw         $s1, 0x0($v0)
    /* 76AB4 800862B4 6002228E */  lw         $v0, 0x260($s1)
    /* 76AB8 800862B8 D8FA6324 */  addiu      $v1, $v1, %lo(Cars_gLifeBasisCarList)
    /* 76ABC 800862BC AC0284AF */  sw         $a0, %gp_rel(Cars_gNumRaceCars)($gp)
    /* 76AC0 800862C0 C402848F */  lw         $a0, %gp_rel(Cars_gNumLifeBasisCars)($gp)
    /* 76AC4 800862C4 01004234 */  ori        $v0, $v0, 0x1
    /* 76AC8 800862C8 600222AE */  sw         $v0, 0x260($s1)
    /* 76ACC 800862CC 80100400 */  sll        $v0, $a0, 2
    /* 76AD0 800862D0 21104300 */  addu       $v0, $v0, $v1
    /* 76AD4 800862D4 000051AC */  sw         $s1, 0x0($v0)
    /* 76AD8 800862D8 6002238E */  lw         $v1, 0x260($s1)
    /* 76ADC 800862DC 01008424 */  addiu      $a0, $a0, 0x1
    /* 76AE0 800862E0 C40284AF */  sw         $a0, %gp_rel(Cars_gNumLifeBasisCars)($gp)
    /* 76AE4 800862E4 00016234 */  ori        $v0, $v1, 0x100
    /* 76AE8 800862E8 600222AE */  sw         $v0, 0x260($s1)
    /* 76AEC 800862EC 40006232 */  andi       $v0, $s3, 0x40
    /* 76AF0 800862F0 02004010 */  beqz       $v0, .L800862FC
    /* 76AF4 800862F4 00036234 */   ori       $v0, $v1, 0x300
    /* 76AF8 800862F8 600222AE */  sw         $v0, 0x260($s1)
  .L800862FC:
    /* 76AFC 800862FC 02006232 */  andi       $v0, $s3, 0x2
  .L80086300:
    /* 76B00 80086300 83004010 */  beqz       $v0, .L80086510
    /* 76B04 80086304 1180103C */   lui       $s0, %hi(GameSetup_gData)
    /* 76B08 80086308 EC310426 */  addiu      $a0, $s0, %lo(GameSetup_gData)
    /* 76B0C 8008630C 1180053C */  lui        $a1, %hi(GameSetup_gPersonalityNames)
    /* 76B10 80086310 5402228E */  lw         $v0, 0x254($s1)
    /* 76B14 80086314 7431A524 */  addiu      $a1, $a1, %lo(GameSetup_gPersonalityNames)
    /* 76B18 80086318 40180200 */  sll        $v1, $v0, 1
    /* 76B1C 8008631C 21186200 */  addu       $v1, $v1, $v0
    /* 76B20 80086320 00110300 */  sll        $v0, $v1, 4
    /* 76B24 80086324 23104300 */  subu       $v0, $v0, $v1
    /* 76B28 80086328 80100200 */  sll        $v0, $v0, 2
    /* 76B2C 8008632C 21104400 */  addu       $v0, $v0, $a0
    /* 76B30 80086330 8802248E */  lw         $a0, 0x288($s1)
    /* 76B34 80086334 2404528C */  lw         $s2, 0x424($v0)
    /* 76B38 80086338 5C008424 */  addiu      $a0, $a0, 0x5C
    /* 76B3C 8008633C C0101200 */  sll        $v0, $s2, 3
    /* 76B40 80086340 CA96030C */  jal        strcpy
    /* 76B44 80086344 21284500 */   addu      $a1, $v0, $a1
    /* 76B48 80086348 EC31038E */  lw         $v1, %lo(GameSetup_gData)($s0)
    /* 76B4C 8008634C 01000224 */  addiu      $v0, $zero, 0x1
    /* 76B50 80086350 03006210 */  beq        $v1, $v0, .L80086360
    /* 76B54 80086354 05000224 */   addiu     $v0, $zero, 0x5
    /* 76B58 80086358 19006214 */  bne        $v1, $v0, .L800863C0
    /* 76B5C 8008635C 00000000 */   nop
  .L80086360:
    /* 76B60 80086360 1180033C */  lui        $v1, %hi(Cars_gHumanRaceCarList)
    /* 76B64 80086364 48FA628C */  lw         $v0, %lo(Cars_gHumanRaceCarList)($v1)
    /* 76B68 80086368 00000000 */  nop
    /* 76B6C 8008636C 6002428C */  lw         $v0, 0x260($v0)
    /* 76B70 80086370 00000000 */  nop
    /* 76B74 80086374 00024230 */  andi       $v0, $v0, 0x200
    /* 76B78 80086378 0C004014 */  bnez       $v0, .L800863AC
    /* 76B7C 8008637C 48FA6424 */   addiu     $a0, $v1, %lo(Cars_gHumanRaceCarList)
    /* 76B80 80086380 B402838F */  lw         $v1, %gp_rel(Cars_gNumHumanRaceCars)($gp)
    /* 76B84 80086384 02000224 */  addiu      $v0, $zero, 0x2
    /* 76B88 80086388 0D006214 */  bne        $v1, $v0, .L800863C0
    /* 76B8C 8008638C 00000000 */   nop
    /* 76B90 80086390 0400828C */  lw         $v0, 0x4($a0)
    /* 76B94 80086394 00000000 */  nop
    /* 76B98 80086398 6002428C */  lw         $v0, 0x260($v0)
    /* 76B9C 8008639C 00000000 */  nop
    /* 76BA0 800863A0 00024230 */  andi       $v0, $v0, 0x200
    /* 76BA4 800863A4 06004010 */  beqz       $v0, .L800863C0
    /* 76BA8 800863A8 00000000 */   nop
  .L800863AC:
    /* 76BAC 800863AC 94E4020C */  jal        TextSys_Word__Fi
    /* 76BB0 800863B0 32000424 */   addiu     $a0, $zero, 0x32
    /* 76BB4 800863B4 8802248E */  lw         $a0, 0x288($s1)
    /* 76BB8 800863B8 F5180208 */  j          .L800863D4
    /* 76BBC 800863BC 21284000 */   addu      $a1, $v0, $zero
  .L800863C0:
    /* 76BC0 800863C0 8802248E */  lw         $a0, 0x288($s1)
    /* 76BC4 800863C4 C0101200 */  sll        $v0, $s2, 3
    /* 76BC8 800863C8 1180053C */  lui        $a1, %hi(GameSetup_gPersonalityNames)
    /* 76BCC 800863CC 7431A524 */  addiu      $a1, $a1, %lo(GameSetup_gPersonalityNames)
    /* 76BD0 800863D0 21284500 */  addu       $a1, $v0, $a1
  .L800863D4:
    /* 76BD4 800863D4 CA96030C */  jal        strcpy
    /* 76BD8 800863D8 68008424 */   addiu     $a0, $a0, 0x68
    /* 76BDC 800863DC 8802248E */  lw         $a0, 0x288($s1)
    /* 76BE0 800863E0 549A000C */  jal        s_lower__FPc
    /* 76BE4 800863E4 68008424 */   addiu     $a0, $a0, 0x68
    /* 76BE8 800863E8 1180033C */  lui        $v1, %hi(Cars_gAICarList)
    /* 76BEC 800863EC 24FA6324 */  addiu      $v1, $v1, %lo(Cars_gAICarList)
    /* 76BF0 800863F0 B002848F */  lw         $a0, %gp_rel(Cars_gNumAICars)($gp)
    /* 76BF4 800863F4 B802858F */  lw         $a1, %gp_rel(Cars_gNumAIRaceCars)($gp)
    /* 76BF8 800863F8 80100400 */  sll        $v0, $a0, 2
    /* 76BFC 800863FC 21104300 */  addu       $v0, $v0, $v1
    /* 76C00 80086400 1180033C */  lui        $v1, %hi(Cars_gAIRaceCarList)
    /* 76C04 80086404 6CFA6324 */  addiu      $v1, $v1, %lo(Cars_gAIRaceCarList)
    /* 76C08 80086408 000051AC */  sw         $s1, 0x0($v0)
    /* 76C0C 8008640C 6002228E */  lw         $v0, 0x260($s1)
    /* 76C10 80086410 01008424 */  addiu      $a0, $a0, 0x1
    /* 76C14 80086414 B00284AF */  sw         $a0, %gp_rel(Cars_gNumAICars)($gp)
    /* 76C18 80086418 AC02848F */  lw         $a0, %gp_rel(Cars_gNumRaceCars)($gp)
    /* 76C1C 8008641C 02004234 */  ori        $v0, $v0, 0x2
    /* 76C20 80086420 600222AE */  sw         $v0, 0x260($s1)
    /* 76C24 80086424 80100500 */  sll        $v0, $a1, 2
    /* 76C28 80086428 21104300 */  addu       $v0, $v0, $v1
    /* 76C2C 8008642C 1180033C */  lui        $v1, %hi(Cars_gRaceCarList)
    /* 76C30 80086430 00FA6324 */  addiu      $v1, $v1, %lo(Cars_gRaceCarList)
    /* 76C34 80086434 000051AC */  sw         $s1, 0x0($v0)
    /* 76C38 80086438 6002228E */  lw         $v0, 0x260($s1)
    /* 76C3C 8008643C 0100A524 */  addiu      $a1, $a1, 0x1
    /* 76C40 80086440 B80285AF */  sw         $a1, %gp_rel(Cars_gNumAIRaceCars)($gp)
    /* 76C44 80086444 08004234 */  ori        $v0, $v0, 0x8
    /* 76C48 80086448 600222AE */  sw         $v0, 0x260($s1)
    /* 76C4C 8008644C 80100400 */  sll        $v0, $a0, 2
    /* 76C50 80086450 21104300 */  addu       $v0, $v0, $v1
    /* 76C54 80086454 000051AC */  sw         $s1, 0x0($v0)
    /* 76C58 80086458 6002228E */  lw         $v0, 0x260($s1)
    /* 76C5C 8008645C 1180033C */  lui        $v1, %hi(GameSetup_gData)
    /* 76C60 80086460 01004234 */  ori        $v0, $v0, 0x1
    /* 76C64 80086464 600222AE */  sw         $v0, 0x260($s1)
    /* 76C68 80086468 EC316224 */  addiu      $v0, $v1, %lo(GameSetup_gData)
    /* 76C6C 8008646C 1400428C */  lw         $v0, 0x14($v0)
    /* 76C70 80086470 01008424 */  addiu      $a0, $a0, 0x1
    /* 76C74 80086474 AC0284AF */  sw         $a0, %gp_rel(Cars_gNumRaceCars)($gp)
    /* 76C78 80086478 25004010 */  beqz       $v0, .L80086510
    /* 76C7C 8008647C 01000224 */   addiu     $v0, $zero, 0x1
    /* 76C80 80086480 EC31638C */  lw         $v1, %lo(GameSetup_gData)($v1)
    /* 76C84 80086484 00000000 */  nop
    /* 76C88 80086488 03006210 */  beq        $v1, $v0, .L80086498
    /* 76C8C 8008648C 05000224 */   addiu     $v0, $zero, 0x5
    /* 76C90 80086490 15006214 */  bne        $v1, $v0, .L800864E8
    /* 76C94 80086494 1180033C */   lui       $v1, %hi(Cars_gLifeBasisCarList)
  .L80086498:
    /* 76C98 80086498 1180033C */  lui        $v1, %hi(Cars_gHumanRaceCarList)
    /* 76C9C 8008649C 48FA628C */  lw         $v0, %lo(Cars_gHumanRaceCarList)($v1)
    /* 76CA0 800864A0 00000000 */  nop
    /* 76CA4 800864A4 6002428C */  lw         $v0, 0x260($v0)
    /* 76CA8 800864A8 00000000 */  nop
    /* 76CAC 800864AC 00024230 */  andi       $v0, $v0, 0x200
    /* 76CB0 800864B0 17004014 */  bnez       $v0, .L80086510
    /* 76CB4 800864B4 48FA6424 */   addiu     $a0, $v1, %lo(Cars_gHumanRaceCarList)
    /* 76CB8 800864B8 B402838F */  lw         $v1, %gp_rel(Cars_gNumHumanRaceCars)($gp)
    /* 76CBC 800864BC 02000224 */  addiu      $v0, $zero, 0x2
    /* 76CC0 800864C0 09006214 */  bne        $v1, $v0, .L800864E8
    /* 76CC4 800864C4 1180033C */   lui       $v1, %hi(Cars_gLifeBasisCarList)
    /* 76CC8 800864C8 0400828C */  lw         $v0, 0x4($a0)
    /* 76CCC 800864CC 00000000 */  nop
    /* 76CD0 800864D0 6002428C */  lw         $v0, 0x260($v0)
    /* 76CD4 800864D4 00000000 */  nop
    /* 76CD8 800864D8 00024230 */  andi       $v0, $v0, 0x200
    /* 76CDC 800864DC 0D004014 */  bnez       $v0, .L80086514
    /* 76CE0 800864E0 04006232 */   andi      $v0, $s3, 0x4
    /* 76CE4 800864E4 1180033C */  lui        $v1, %hi(Cars_gLifeBasisCarList)
  .L800864E8:
    /* 76CE8 800864E8 C402848F */  lw         $a0, %gp_rel(Cars_gNumLifeBasisCars)($gp)
    /* 76CEC 800864EC D8FA6324 */  addiu      $v1, $v1, %lo(Cars_gLifeBasisCarList)
    /* 76CF0 800864F0 80100400 */  sll        $v0, $a0, 2
    /* 76CF4 800864F4 21104300 */  addu       $v0, $v0, $v1
    /* 76CF8 800864F8 000051AC */  sw         $s1, 0x0($v0)
    /* 76CFC 800864FC 6002228E */  lw         $v0, 0x260($s1)
    /* 76D00 80086500 01008424 */  addiu      $a0, $a0, 0x1
    /* 76D04 80086504 C40284AF */  sw         $a0, %gp_rel(Cars_gNumLifeBasisCars)($gp)
    /* 76D08 80086508 00014234 */  ori        $v0, $v0, 0x100
    /* 76D0C 8008650C 600222AE */  sw         $v0, 0x260($s1)
  .L80086510:
    /* 76D10 80086510 04006232 */  andi       $v0, $s3, 0x4
  .L80086514:
    /* 76D14 80086514 16004010 */  beqz       $v0, .L80086570
    /* 76D18 80086518 1180033C */   lui       $v1, %hi(Cars_gAICarList)
    /* 76D1C 8008651C B002848F */  lw         $a0, %gp_rel(Cars_gNumAICars)($gp)
    /* 76D20 80086520 24FA6324 */  addiu      $v1, $v1, %lo(Cars_gAICarList)
    /* 76D24 80086524 80100400 */  sll        $v0, $a0, 2
    /* 76D28 80086528 21104300 */  addu       $v0, $v0, $v1
    /* 76D2C 8008652C 01008424 */  addiu      $a0, $a0, 0x1
    /* 76D30 80086530 1180033C */  lui        $v1, %hi(Cars_gTrafficCarList)
    /* 76D34 80086534 000051AC */  sw         $s1, 0x0($v0)
    /* 76D38 80086538 6002228E */  lw         $v0, 0x260($s1)
    /* 76D3C 8008653C 90FA6324 */  addiu      $v1, $v1, %lo(Cars_gTrafficCarList)
    /* 76D40 80086540 B00284AF */  sw         $a0, %gp_rel(Cars_gNumAICars)($gp)
    /* 76D44 80086544 BC02848F */  lw         $a0, %gp_rel(Cars_gNumTrafficCars)($gp)
    /* 76D48 80086548 02004234 */  ori        $v0, $v0, 0x2
    /* 76D4C 8008654C 600222AE */  sw         $v0, 0x260($s1)
    /* 76D50 80086550 80100400 */  sll        $v0, $a0, 2
    /* 76D54 80086554 21104300 */  addu       $v0, $v0, $v1
    /* 76D58 80086558 000051AC */  sw         $s1, 0x0($v0)
    /* 76D5C 8008655C 6002228E */  lw         $v0, 0x260($s1)
    /* 76D60 80086560 01008424 */  addiu      $a0, $a0, 0x1
    /* 76D64 80086564 BC0284AF */  sw         $a0, %gp_rel(Cars_gNumTrafficCars)($gp)
    /* 76D68 80086568 10004234 */  ori        $v0, $v0, 0x10
    /* 76D6C 8008656C 600222AE */  sw         $v0, 0x260($s1)
  .L80086570:
    /* 76D70 80086570 18006232 */  andi       $v0, $s3, 0x18
    /* 76D74 80086574 1A004010 */  beqz       $v0, .L800865E0
    /* 76D78 80086578 1180033C */   lui       $v1, %hi(Cars_gAICarList)
    /* 76D7C 8008657C B002848F */  lw         $a0, %gp_rel(Cars_gNumAICars)($gp)
    /* 76D80 80086580 24FA6324 */  addiu      $v1, $v1, %lo(Cars_gAICarList)
    /* 76D84 80086584 80100400 */  sll        $v0, $a0, 2
    /* 76D88 80086588 21104300 */  addu       $v0, $v0, $v1
    /* 76D8C 8008658C 01008424 */  addiu      $a0, $a0, 0x1
    /* 76D90 80086590 1180033C */  lui        $v1, %hi(Cars_gCopCarList)
    /* 76D94 80086594 000051AC */  sw         $s1, 0x0($v0)
    /* 76D98 80086598 6002228E */  lw         $v0, 0x260($s1)
    /* 76D9C 8008659C B4FA6324 */  addiu      $v1, $v1, %lo(Cars_gCopCarList)
    /* 76DA0 800865A0 B00284AF */  sw         $a0, %gp_rel(Cars_gNumAICars)($gp)
    /* 76DA4 800865A4 C002848F */  lw         $a0, %gp_rel(Cars_gNumCopCars)($gp)
    /* 76DA8 800865A8 02004234 */  ori        $v0, $v0, 0x2
    /* 76DAC 800865AC 600222AE */  sw         $v0, 0x260($s1)
    /* 76DB0 800865B0 80100400 */  sll        $v0, $a0, 2
    /* 76DB4 800865B4 21104300 */  addu       $v0, $v0, $v1
    /* 76DB8 800865B8 000051AC */  sw         $s1, 0x0($v0)
    /* 76DBC 800865BC 6002238E */  lw         $v1, 0x260($s1)
    /* 76DC0 800865C0 01008424 */  addiu      $a0, $a0, 0x1
    /* 76DC4 800865C4 C00284AF */  sw         $a0, %gp_rel(Cars_gNumCopCars)($gp)
    /* 76DC8 800865C8 20006234 */  ori        $v0, $v1, 0x20
    /* 76DCC 800865CC 600222AE */  sw         $v0, 0x260($s1)
    /* 76DD0 800865D0 10006232 */  andi       $v0, $s3, 0x10
    /* 76DD4 800865D4 02004010 */  beqz       $v0, .L800865E0
    /* 76DD8 800865D8 60006234 */   ori       $v0, $v1, 0x60
    /* 76DDC 800865DC 600222AE */  sw         $v0, 0x260($s1)
  .L800865E0:
    /* 76DE0 800865E0 2000BF8F */  lw         $ra, 0x20($sp)
    /* 76DE4 800865E4 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 76DE8 800865E8 1800B28F */  lw         $s2, 0x18($sp)
    /* 76DEC 800865EC 1400B18F */  lw         $s1, 0x14($sp)
    /* 76DF0 800865F0 1000B08F */  lw         $s0, 0x10($sp)
    /* 76DF4 800865F4 0800E003 */  jr         $ra
    /* 76DF8 800865F8 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel Cars_InitializeCarTablesFlagsAndCounters__FP8Car_tObj
