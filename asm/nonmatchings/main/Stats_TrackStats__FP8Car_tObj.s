.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Stats_TrackStats__FP8Car_tObj, 0x408

glabel Stats_TrackStats__FP8Car_tObj
    /* A89FC 800B81FC 1280023C */  lui        $v0, %hi(D_8011E0B0)
    /* A8A00 800B8200 B0E0438C */  lw         $v1, %lo(D_8011E0B0)($v0)
    /* A8A04 800B8204 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* A8A08 800B8208 1000B0AF */  sw         $s0, 0x10($sp)
    /* A8A0C 800B820C 21808000 */  addu       $s0, $a0, $zero
    /* A8A10 800B8210 2400BFAF */  sw         $ra, 0x24($sp)
    /* A8A14 800B8214 2000B4AF */  sw         $s4, 0x20($sp)
    /* A8A18 800B8218 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* A8A1C 800B821C 1800B2AF */  sw         $s2, 0x18($sp)
    /* A8A20 800B8220 01006230 */  andi       $v0, $v1, 0x1
    /* A8A24 800B8224 EF004014 */  bnez       $v0, .L800B85E4
    /* A8A28 800B8228 1400B1AF */   sw        $s1, 0x14($sp)
    /* A8A2C 800B822C 6003048E */  lw         $a0, 0x360($s0)
    /* A8A30 800B8230 1480143C */  lui        $s4, %hi(gNumSlices)
    /* A8A34 800B8234 C8C7948E */  lw         $s4, %lo(gNumSlices)($s4)
    /* A8A38 800B8238 04008228 */  slti       $v0, $a0, 0x4
    /* A8A3C 800B823C 37004010 */  beqz       $v0, .L800B831C
    /* A8A40 800B8240 21986000 */   addu      $s3, $v1, $zero
    /* A8A44 800B8244 80100400 */  sll        $v0, $a0, 2
    /* A8A48 800B8248 21200202 */  addu       $a0, $s0, $v0
    /* A8A4C 800B824C 2004038E */  lw         $v1, 0x420($s0)
    /* A8A50 800B8250 7803828C */  lw         $v0, 0x378($a0)
    /* A8A54 800B8254 00000000 */  nop
    /* A8A58 800B8258 2A104300 */  slt        $v0, $v0, $v1
    /* A8A5C 800B825C 2F004010 */  beqz       $v0, .L800B831C
    /* A8A60 800B8260 00000000 */   nop
    /* A8A64 800B8264 6002028E */  lw         $v0, 0x260($s0)
    /* A8A68 800B8268 00000000 */  nop
    /* A8A6C 800B826C 08004230 */  andi       $v0, $v0, 0x8
    /* A8A70 800B8270 25004010 */  beqz       $v0, .L800B8308
    /* A8A74 800B8274 00000000 */   nop
    /* A8A78 800B8278 8802028E */  lw         $v0, 0x288($s0)
    /* A8A7C 800B827C 00000000 */  nop
    /* A8A80 800B8280 0000428C */  lw         $v0, 0x0($v0)
    /* A8A84 800B8284 00000000 */  nop
    /* A8A88 800B8288 13004228 */  slti       $v0, $v0, 0x13
    /* A8A8C 800B828C 1E004010 */  beqz       $v0, .L800B8308
    /* A8A90 800B8290 00000000 */   nop
    /* A8A94 800B8294 B5AA030C */  jal        rand
    /* A8A98 800B8298 21908000 */   addu      $s2, $a0, $zero
    /* A8A9C 800B829C 1180043C */  lui        $a0, %hi(Cars_topSpeedCap)
    /* A8AA0 800B82A0 28F89124 */  addiu      $s1, $a0, %lo(Cars_topSpeedCap)
    /* A8AA4 800B82A4 8802038E */  lw         $v1, 0x288($s0)
    /* A8AA8 800B82A8 40200200 */  sll        $a0, $v0, 1
    /* A8AAC 800B82AC 0000638C */  lw         $v1, 0x0($v1)
    /* A8AB0 800B82B0 21208200 */  addu       $a0, $a0, $v0
    /* A8AB4 800B82B4 80180300 */  sll        $v1, $v1, 2
    /* A8AB8 800B82B8 21187100 */  addu       $v1, $v1, $s1
    /* A8ABC 800B82BC 0000628C */  lw         $v0, 0x0($v1)
    /* A8AC0 800B82C0 2004038E */  lw         $v1, 0x420($s0)
    /* A8AC4 800B82C4 23104400 */  subu       $v0, $v0, $a0
    /* A8AC8 800B82C8 2A104300 */  slt        $v0, $v0, $v1
    /* A8ACC 800B82CC 0C004010 */  beqz       $v0, .L800B8300
    /* A8AD0 800B82D0 00000000 */   nop
    /* A8AD4 800B82D4 B5AA030C */  jal        rand
    /* A8AD8 800B82D8 00000000 */   nop
    /* A8ADC 800B82DC 8802038E */  lw         $v1, 0x288($s0)
    /* A8AE0 800B82E0 00000000 */  nop
    /* A8AE4 800B82E4 0000638C */  lw         $v1, 0x0($v1)
    /* A8AE8 800B82E8 40200200 */  sll        $a0, $v0, 1
    /* A8AEC 800B82EC 80180300 */  sll        $v1, $v1, 2
    /* A8AF0 800B82F0 21187100 */  addu       $v1, $v1, $s1
    /* A8AF4 800B82F4 0000638C */  lw         $v1, 0x0($v1)
    /* A8AF8 800B82F8 21208200 */  addu       $a0, $a0, $v0
    /* A8AFC 800B82FC 23186400 */  subu       $v1, $v1, $a0
  .L800B8300:
    /* A8B00 800B8300 C7E00208 */  j          .L800B831C
    /* A8B04 800B8304 780343AE */   sw        $v1, 0x378($s2)
  .L800B8308:
    /* A8B08 800B8308 6003028E */  lw         $v0, 0x360($s0)
    /* A8B0C 800B830C 2004038E */  lw         $v1, 0x420($s0)
    /* A8B10 800B8310 80100200 */  sll        $v0, $v0, 2
    /* A8B14 800B8314 21100202 */  addu       $v0, $s0, $v0
    /* A8B18 800B8318 780343AC */  sw         $v1, 0x378($v0)
  .L800B831C:
    /* A8B1C 800B831C 6003058E */  lw         $a1, 0x360($s0)
    /* A8B20 800B8320 6402028E */  lw         $v0, 0x264($s0)
    /* A8B24 800B8324 00000000 */  nop
    /* A8B28 800B8328 5C00A210 */  beq        $a1, $v0, .L800B849C
    /* A8B2C 800B832C 1180023C */   lui       $v0, %hi(D_8011321C)
    /* A8B30 800B8330 9003028E */  lw         $v0, 0x390($s0)
    /* A8B34 800B8334 00000000 */  nop
    /* A8B38 800B8338 58004014 */  bnez       $v0, .L800B849C
    /* A8B3C 800B833C 1180023C */   lui       $v0, %hi(D_8011321C)
    /* A8B40 800B8340 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* A8B44 800B8344 EC31438C */  lw         $v1, %lo(GameSetup_gData)($v0)
    /* A8B48 800B8348 01000224 */  addiu      $v0, $zero, 0x1
    /* A8B4C 800B834C 03006210 */  beq        $v1, $v0, .L800B835C
    /* A8B50 800B8350 05000224 */   addiu     $v0, $zero, 0x5
    /* A8B54 800B8354 1B006214 */  bne        $v1, $v0, .L800B83C4
    /* A8B58 800B8358 00000000 */   nop
  .L800B835C:
    /* A8B5C 800B835C 1180033C */  lui        $v1, %hi(Cars_gHumanRaceCarList)
    /* A8B60 800B8360 48FA628C */  lw         $v0, %lo(Cars_gHumanRaceCarList)($v1)
    /* A8B64 800B8364 00000000 */  nop
    /* A8B68 800B8368 6002428C */  lw         $v0, 0x260($v0)
    /* A8B6C 800B836C 00000000 */  nop
    /* A8B70 800B8370 00024230 */  andi       $v0, $v0, 0x200
    /* A8B74 800B8374 0D004014 */  bnez       $v0, .L800B83AC
    /* A8B78 800B8378 48FA6424 */   addiu     $a0, $v1, %lo(Cars_gHumanRaceCarList)
    /* A8B7C 800B837C 1480033C */  lui        $v1, %hi(Cars_gNumHumanRaceCars)
    /* A8B80 800B8380 00C8638C */  lw         $v1, %lo(Cars_gNumHumanRaceCars)($v1)
    /* A8B84 800B8384 02000224 */  addiu      $v0, $zero, 0x2
    /* A8B88 800B8388 0E006214 */  bne        $v1, $v0, .L800B83C4
    /* A8B8C 800B838C 00000000 */   nop
    /* A8B90 800B8390 0400828C */  lw         $v0, 0x4($a0)
    /* A8B94 800B8394 00000000 */  nop
    /* A8B98 800B8398 6002428C */  lw         $v0, 0x260($v0)
    /* A8B9C 800B839C 00000000 */  nop
    /* A8BA0 800B83A0 00024230 */  andi       $v0, $v0, 0x200
    /* A8BA4 800B83A4 07004010 */  beqz       $v0, .L800B83C4
    /* A8BA8 800B83A8 00000000 */   nop
  .L800B83AC:
    /* A8BAC 800B83AC 0100033C */  lui        $v1, (0x1869F >> 16)
    /* A8BB0 800B83B0 9F866334 */  ori        $v1, $v1, (0x1869F & 0xFFFF)
    /* A8BB4 800B83B4 80100500 */  sll        $v0, $a1, 2
    /* A8BB8 800B83B8 21100202 */  addu       $v0, $s0, $v0
    /* A8BBC 800B83BC F7E00208 */  j          .L800B83DC
    /* A8BC0 800B83C0 680343AC */   sw        $v1, 0x368($v0)
  .L800B83C4:
    /* A8BC4 800B83C4 6003038E */  lw         $v1, 0x360($s0)
    /* A8BC8 800B83C8 6403028E */  lw         $v0, 0x364($s0)
    /* A8BCC 800B83CC 80180300 */  sll        $v1, $v1, 2
    /* A8BD0 800B83D0 21180302 */  addu       $v1, $s0, $v1
    /* A8BD4 800B83D4 23106202 */  subu       $v0, $s3, $v0
    /* A8BD8 800B83D8 680362AC */  sw         $v0, 0x368($v1)
  .L800B83DC:
    /* A8BDC 800B83DC 1180043C */  lui        $a0, %hi(GameSetup_gData)
    /* A8BE0 800B83E0 6402028E */  lw         $v0, 0x264($s0)
    /* A8BE4 800B83E4 EC318324 */  addiu      $v1, $a0, %lo(GameSetup_gData)
    /* A8BE8 800B83E8 640313AE */  sw         $s3, 0x364($s0)
    /* A8BEC 800B83EC 600302AE */  sw         $v0, 0x360($s0)
    /* A8BF0 800B83F0 0400638C */  lw         $v1, 0x4($v1)
    /* A8BF4 800B83F4 00000000 */  nop
    /* A8BF8 800B83F8 28004314 */  bne        $v0, $v1, .L800B849C
    /* A8BFC 800B83FC 1180023C */   lui       $v0, %hi(D_8011321C)
    /* A8C00 800B8400 EC31838C */  lw         $v1, %lo(GameSetup_gData)($a0)
    /* A8C04 800B8404 01000224 */  addiu      $v0, $zero, 0x1
    /* A8C08 800B8408 03006210 */  beq        $v1, $v0, .L800B8418
    /* A8C0C 800B840C 05000224 */   addiu     $v0, $zero, 0x5
    /* A8C10 800B8410 15006214 */  bne        $v1, $v0, .L800B8468
    /* A8C14 800B8414 00000000 */   nop
  .L800B8418:
    /* A8C18 800B8418 1180033C */  lui        $v1, %hi(Cars_gHumanRaceCarList)
    /* A8C1C 800B841C 48FA628C */  lw         $v0, %lo(Cars_gHumanRaceCarList)($v1)
    /* A8C20 800B8420 00000000 */  nop
    /* A8C24 800B8424 6002428C */  lw         $v0, 0x260($v0)
    /* A8C28 800B8428 00000000 */  nop
    /* A8C2C 800B842C 00024230 */  andi       $v0, $v0, 0x200
    /* A8C30 800B8430 19004014 */  bnez       $v0, .L800B8498
    /* A8C34 800B8434 48FA6424 */   addiu     $a0, $v1, %lo(Cars_gHumanRaceCarList)
    /* A8C38 800B8438 1480033C */  lui        $v1, %hi(Cars_gNumHumanRaceCars)
    /* A8C3C 800B843C 00C8638C */  lw         $v1, %lo(Cars_gNumHumanRaceCars)($v1)
    /* A8C40 800B8440 02000224 */  addiu      $v0, $zero, 0x2
    /* A8C44 800B8444 08006214 */  bne        $v1, $v0, .L800B8468
    /* A8C48 800B8448 00000000 */   nop
    /* A8C4C 800B844C 0400828C */  lw         $v0, 0x4($a0)
    /* A8C50 800B8450 00000000 */  nop
    /* A8C54 800B8454 6002428C */  lw         $v0, 0x260($v0)
    /* A8C58 800B8458 00000000 */  nop
    /* A8C5C 800B845C 00024230 */  andi       $v0, $v0, 0x200
    /* A8C60 800B8460 0E004014 */  bnez       $v0, .L800B849C
    /* A8C64 800B8464 1180023C */   lui       $v0, %hi(D_8011321C)
  .L800B8468:
    /* A8C68 800B8468 6003028E */  lw         $v0, 0x360($s0)
    /* A8C6C 800B846C 00000000 */  nop
    /* A8C70 800B8470 01004224 */  addiu      $v0, $v0, 0x1
    /* A8C74 800B8474 18005400 */  mult       $v0, $s4
    /* A8C78 800B8478 6403038E */  lw         $v1, 0x364($s0)
    /* A8C7C 800B847C 540313AE */  sw         $s3, 0x354($s0)
    /* A8C80 800B8480 02000224 */  addiu      $v0, $zero, 0x2
    /* A8C84 800B8484 00FE6324 */  addiu      $v1, $v1, -0x200
    /* A8C88 800B8488 900302AE */  sw         $v0, 0x390($s0)
    /* A8C8C 800B848C 640303AE */  sw         $v1, 0x364($s0)
    /* A8C90 800B8490 12680000 */  mflo       $t5
    /* A8C94 800B8494 50030DAE */  sw         $t5, 0x350($s0)
  .L800B8498:
    /* A8C98 800B8498 1180023C */  lui        $v0, %hi(D_8011321C)
  .L800B849C:
    /* A8C9C 800B849C 1C32428C */  lw         $v0, %lo(D_8011321C)($v0)
    /* A8CA0 800B84A0 00000000 */  nop
    /* A8CA4 800B84A4 06004010 */  beqz       $v0, .L800B84C0
    /* A8CA8 800B84A8 00000000 */   nop
    /* A8CAC 800B84AC 08000286 */  lh         $v0, 0x8($s0)
    /* A8CB0 800B84B0 00000000 */  nop
    /* A8CB4 800B84B4 23108202 */  subu       $v0, $s4, $v0
    /* A8CB8 800B84B8 31E10208 */  j          .L800B84C4
    /* A8CBC 800B84BC FFFF4324 */   addiu     $v1, $v0, -0x1
  .L800B84C0:
    /* A8CC0 800B84C0 08000386 */  lh         $v1, 0x8($s0)
  .L800B84C4:
    /* A8CC4 800B84C4 5803028E */  lw         $v0, 0x358($s0)
    /* A8CC8 800B84C8 00000000 */  nop
    /* A8CCC 800B84CC 10004310 */  beq        $v0, $v1, .L800B8510
    /* A8CD0 800B84D0 21580000 */   addu      $t3, $zero, $zero
    /* A8CD4 800B84D4 9003028E */  lw         $v0, 0x390($s0)
    /* A8CD8 800B84D8 00000000 */  nop
    /* A8CDC 800B84DC 0C004014 */  bnez       $v0, .L800B8510
    /* A8CE0 800B84E0 580303AE */   sw        $v1, 0x358($s0)
    /* A8CE4 800B84E4 6003028E */  lw         $v0, 0x360($s0)
    /* A8CE8 800B84E8 6802038E */  lw         $v1, 0x268($s0)
    /* A8CEC 800B84EC 00000000 */  nop
    /* A8CF0 800B84F0 23104300 */  subu       $v0, $v0, $v1
    /* A8CF4 800B84F4 18005400 */  mult       $v0, $s4
    /* A8CF8 800B84F8 540313AE */  sw         $s3, 0x354($s0)
    /* A8CFC 800B84FC 5803028E */  lw         $v0, 0x358($s0)
    /* A8D00 800B8500 12680000 */  mflo       $t5
    /* A8D04 800B8504 2110A201 */  addu       $v0, $t5, $v0
    /* A8D08 800B8508 500302AE */  sw         $v0, 0x350($s0)
    /* A8D0C 800B850C 21580000 */  addu       $t3, $zero, $zero
  .L800B8510:
    /* A8D10 800B8510 1480053C */  lui        $a1, %hi(Cars_gNumRaceCars)
    /* A8D14 800B8514 F8C7A58C */  lw         $a1, %lo(Cars_gNumRaceCars)($a1)
    /* A8D18 800B8518 1280023C */  lui        $v0, %hi(Stats_racePosition)
    /* A8D1C 800B851C E0E04A24 */  addiu      $t2, $v0, %lo(Stats_racePosition)
    /* A8D20 800B8520 21604001 */  addu       $t4, $t2, $zero
  .L800B8524:
    /* A8D24 800B8524 2A106501 */  slt        $v0, $t3, $a1
    /* A8D28 800B8528 2E004010 */  beqz       $v0, .L800B85E4
    /* A8D2C 800B852C 00000000 */   nop
    /* A8D30 800B8530 5003048E */  lw         $a0, 0x350($s0)
    /* A8D34 800B8534 0400438D */  lw         $v1, 0x4($t2)
    /* A8D38 800B8538 00000000 */  nop
    /* A8D3C 800B853C 2A106400 */  slt        $v0, $v1, $a0
    /* A8D40 800B8540 09004014 */  bnez       $v0, .L800B8568
    /* A8D44 800B8544 FEFFA824 */   addiu     $t0, $a1, -0x2
    /* A8D48 800B8548 23008314 */  bne        $a0, $v1, .L800B85D8
    /* A8D4C 800B854C 00000000 */   nop
    /* A8D50 800B8550 5403028E */  lw         $v0, 0x354($s0)
    /* A8D54 800B8554 0800438D */  lw         $v1, 0x8($t2)
    /* A8D58 800B8558 00000000 */  nop
    /* A8D5C 800B855C 2A104300 */  slt        $v0, $v0, $v1
    /* A8D60 800B8560 1D004010 */  beqz       $v0, .L800B85D8
    /* A8D64 800B8564 00000000 */   nop
  .L800B8568:
    /* A8D68 800B8568 00110800 */  sll        $v0, $t0, 4
    /* A8D6C 800B856C 10004924 */  addiu      $t1, $v0, 0x10
    /* A8D70 800B8570 21384C00 */  addu       $a3, $v0, $t4
  .L800B8574:
    /* A8D74 800B8574 2A100B01 */  slt        $v0, $t0, $t3
    /* A8D78 800B8578 0D004014 */  bnez       $v0, .L800B85B0
    /* A8D7C 800B857C 21102C01 */   addu      $v0, $t1, $t4
    /* A8D80 800B8580 F0FF2925 */  addiu      $t1, $t1, -0x10
    /* A8D84 800B8584 0000E38C */  lw         $v1, 0x0($a3)
    /* A8D88 800B8588 0400E48C */  lw         $a0, 0x4($a3)
    /* A8D8C 800B858C 0800E58C */  lw         $a1, 0x8($a3)
    /* A8D90 800B8590 0C00E68C */  lw         $a2, 0xC($a3)
    /* A8D94 800B8594 F0FFE724 */  addiu      $a3, $a3, -0x10
    /* A8D98 800B8598 FFFF0825 */  addiu      $t0, $t0, -0x1
    /* A8D9C 800B859C 000043AC */  sw         $v1, 0x0($v0)
    /* A8DA0 800B85A0 040044AC */  sw         $a0, 0x4($v0)
    /* A8DA4 800B85A4 080045AC */  sw         $a1, 0x8($v0)
    /* A8DA8 800B85A8 5DE10208 */  j          .L800B8574
    /* A8DAC 800B85AC 0C0046AC */   sw        $a2, 0xC($v0)
  .L800B85B0:
    /* A8DB0 800B85B0 5402038E */  lw         $v1, 0x254($s0)
    /* A8DB4 800B85B4 5003048E */  lw         $a0, 0x350($s0)
    /* A8DB8 800B85B8 6002028E */  lw         $v0, 0x260($s0)
    /* A8DBC 800B85BC 5403058E */  lw         $a1, 0x354($s0)
    /* A8DC0 800B85C0 04004230 */  andi       $v0, $v0, 0x4
    /* A8DC4 800B85C4 000043AD */  sw         $v1, 0x0($t2)
    /* A8DC8 800B85C8 040044AD */  sw         $a0, 0x4($t2)
    /* A8DCC 800B85CC 080045AD */  sw         $a1, 0x8($t2)
    /* A8DD0 800B85D0 79E10208 */  j          .L800B85E4
    /* A8DD4 800B85D4 0C0042AD */   sw        $v0, 0xC($t2)
  .L800B85D8:
    /* A8DD8 800B85D8 10004A25 */  addiu      $t2, $t2, 0x10
    /* A8DDC 800B85DC 49E10208 */  j          .L800B8524
    /* A8DE0 800B85E0 01006B25 */   addiu     $t3, $t3, 0x1
  .L800B85E4:
    /* A8DE4 800B85E4 2400BF8F */  lw         $ra, 0x24($sp)
    /* A8DE8 800B85E8 2000B48F */  lw         $s4, 0x20($sp)
    /* A8DEC 800B85EC 1C00B38F */  lw         $s3, 0x1C($sp)
    /* A8DF0 800B85F0 1800B28F */  lw         $s2, 0x18($sp)
    /* A8DF4 800B85F4 1400B18F */  lw         $s1, 0x14($sp)
    /* A8DF8 800B85F8 1000B08F */  lw         $s0, 0x10($sp)
    /* A8DFC 800B85FC 0800E003 */  jr         $ra
    /* A8E00 800B8600 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel Stats_TrackStats__FP8Car_tObj
