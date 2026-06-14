.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AISpeeds_SuperDuperSpeedUpTheCarsAtTheStartBecauseWeCannotActuallyHandleRenderingTheseCars__FP8Car_tObj, 0x9C

glabel AISpeeds_SuperDuperSpeedUpTheCarsAtTheStartBecauseWeCannotActuallyHandleRenderingTheseCars__FP8Car_tObj
    /* 5E09C 8006D89C 1480023C */  lui        $v0, %hi(Cars_gNumAIRaceCars)
    /* 5E0A0 8006D8A0 04C8428C */  lw         $v0, %lo(Cars_gNumAIRaceCars)($v0)
    /* 5E0A4 8006D8A4 7407838C */  lw         $v1, 0x774($a0)
    /* 5E0A8 8006D8A8 00000000 */  nop
    /* 5E0AC 8006D8AC 23284300 */  subu       $a1, $v0, $v1
    /* 5E0B0 8006D8B0 02004228 */  slti       $v0, $v0, 0x2
    /* 5E0B4 8006D8B4 1E004014 */  bnez       $v0, .L8006D930
    /* 5E0B8 8006D8B8 1180023C */   lui       $v0, %hi(GameSetup_gData)
    /* 5E0BC 8006D8BC EC31428C */  lw         $v0, %lo(GameSetup_gData)($v0)
    /* 5E0C0 8006D8C0 01000324 */  addiu      $v1, $zero, 0x1
    /* 5E0C4 8006D8C4 1A004310 */  beq        $v0, $v1, .L8006D930
    /* 5E0C8 8006D8C8 1280023C */   lui       $v0, %hi(D_8011E0B0)
    /* 5E0CC 8006D8CC B0E0428C */  lw         $v0, %lo(D_8011E0B0)($v0)
    /* 5E0D0 8006D8D0 00000000 */  nop
    /* 5E0D4 8006D8D4 80074228 */  slti       $v0, $v0, 0x780
    /* 5E0D8 8006D8D8 15004010 */  beqz       $v0, .L8006D930
    /* 5E0DC 8006D8DC 00000000 */   nop
    /* 5E0E0 8006D8E0 1480023C */  lui        $v0, %hi(Cars_gNumHumanRaceCars)
    /* 5E0E4 8006D8E4 00C8428C */  lw         $v0, %lo(Cars_gNumHumanRaceCars)($v0)
    /* 5E0E8 8006D8E8 00000000 */  nop
    /* 5E0EC 8006D8EC 10004314 */  bne        $v0, $v1, .L8006D930
    /* 5E0F0 8006D8F0 1180023C */   lui       $v0, %hi(Cars_gHumanRaceCarList)
    /* 5E0F4 8006D8F4 48FA428C */  lw         $v0, %lo(Cars_gHumanRaceCarList)($v0)
    /* 5E0F8 8006D8F8 06008394 */  lhu        $v1, 0x6($a0)
    /* 5E0FC 8006D8FC 06004294 */  lhu        $v0, 0x6($v0)
    /* 5E100 8006D900 00000000 */  nop
    /* 5E104 8006D904 2B104300 */  sltu       $v0, $v0, $v1
    /* 5E108 8006D908 09004010 */  beqz       $v0, .L8006D930
    /* 5E10C 8006D90C 40100500 */   sll       $v0, $a1, 1
    /* 5E110 8006D910 21104500 */  addu       $v0, $v0, $a1
    /* 5E114 8006D914 00190200 */  sll        $v1, $v0, 4
    /* 5E118 8006D918 21104300 */  addu       $v0, $v0, $v1
    /* 5E11C 8006D91C 001A0200 */  sll        $v1, $v0, 8
    /* 5E120 8006D920 21104300 */  addu       $v0, $v0, $v1
    /* 5E124 8006D924 0100033C */  lui        $v1, (0x10000 >> 16)
    /* 5E128 8006D928 0800E003 */  jr         $ra
    /* 5E12C 8006D92C 21104300 */   addu      $v0, $v0, $v1
  .L8006D930:
    /* 5E130 8006D930 0800E003 */  jr         $ra
    /* 5E134 8006D934 0100023C */   lui       $v0, (0x10000 >> 16)
endlabel AISpeeds_SuperDuperSpeedUpTheCarsAtTheStartBecauseWeCannotActuallyHandleRenderingTheseCars__FP8Car_tObj
