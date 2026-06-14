.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AISpeeds_BTCGetGlueFactor__FP8Car_tObj, 0x1BC

glabel AISpeeds_BTCGetGlueFactor__FP8Car_tObj
    /* 5E89C 8006E09C D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 5E8A0 8006E0A0 2400B5AF */  sw         $s5, 0x24($sp)
    /* 5E8A4 8006E0A4 21A88000 */  addu       $s5, $a0, $zero
    /* 5E8A8 8006E0A8 1800B2AF */  sw         $s2, 0x18($sp)
    /* 5E8AC 8006E0AC 0F27123C */  lui        $s2, (0x270F0000 >> 16)
    /* 5E8B0 8006E0B0 2800BFAF */  sw         $ra, 0x28($sp)
    /* 5E8B4 8006E0B4 2000B4AF */  sw         $s4, 0x20($sp)
    /* 5E8B8 8006E0B8 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 5E8BC 8006E0BC 1400B1AF */  sw         $s1, 0x14($sp)
    /* 5E8C0 8006E0C0 1000B0AF */  sw         $s0, 0x10($sp)
    /* 5E8C4 8006E0C4 6002A28E */  lw         $v0, 0x260($s5)
    /* 5E8C8 8006E0C8 00000000 */  nop
    /* 5E8CC 8006E0CC 20004230 */  andi       $v0, $v0, 0x20
    /* 5E8D0 8006E0D0 32004014 */  bnez       $v0, .L8006E19C
    /* 5E8D4 8006E0D4 21A00000 */   addu      $s4, $zero, $zero
    /* 5E8D8 8006E0D8 21980000 */  addu       $s3, $zero, $zero
    /* 5E8DC 8006E0DC 1180023C */  lui        $v0, %hi(Cars_gHumanRaceCarList)
    /* 5E8E0 8006E0E0 48FA5124 */  addiu      $s1, $v0, %lo(Cars_gHumanRaceCarList)
  .L8006E0E4:
    /* 5E8E4 8006E0E4 1480023C */  lui        $v0, %hi(Cars_gNumHumanRaceCars)
    /* 5E8E8 8006E0E8 00C8428C */  lw         $v0, %lo(Cars_gNumHumanRaceCars)($v0)
    /* 5E8EC 8006E0EC 00000000 */  nop
    /* 5E8F0 8006E0F0 2A106202 */  slt        $v0, $s3, $v0
    /* 5E8F4 8006E0F4 19004010 */  beqz       $v0, .L8006E15C
    /* 5E8F8 8006E0F8 00000000 */   nop
    /* 5E8FC 8006E0FC 0000308E */  lw         $s0, 0x0($s1)
    /* 5E900 8006E100 00000000 */  nop
    /* 5E904 8006E104 6002028E */  lw         $v0, 0x260($s0)
    /* 5E908 8006E108 00000000 */  nop
    /* 5E90C 8006E10C 00024230 */  andi       $v0, $v0, 0x200
    /* 5E910 8006E110 0F004010 */  beqz       $v0, .L8006E150
    /* 5E914 8006E114 2120A002 */   addu      $a0, $s5, $zero
    /* 5E918 8006E118 2ECC010C */  jal        AIWorld_ApxSplineDistance__FP8Car_tObjT0
    /* 5E91C 8006E11C 21280002 */   addu      $a1, $s0, $zero
    /* 5E920 8006E120 21204000 */  addu       $a0, $v0, $zero
    /* 5E924 8006E124 02008104 */  bgez       $a0, .L8006E130
    /* 5E928 8006E128 21108000 */   addu      $v0, $a0, $zero
    /* 5E92C 8006E12C 23100200 */  negu       $v0, $v0
  .L8006E130:
    /* 5E930 8006E130 02004106 */  bgez       $s2, .L8006E13C
    /* 5E934 8006E134 21184002 */   addu      $v1, $s2, $zero
    /* 5E938 8006E138 23180300 */  negu       $v1, $v1
  .L8006E13C:
    /* 5E93C 8006E13C 2A104300 */  slt        $v0, $v0, $v1
    /* 5E940 8006E140 03004010 */  beqz       $v0, .L8006E150
    /* 5E944 8006E144 00000000 */   nop
    /* 5E948 8006E148 21908000 */  addu       $s2, $a0, $zero
    /* 5E94C 8006E14C 21A00002 */  addu       $s4, $s0, $zero
  .L8006E150:
    /* 5E950 8006E150 04003126 */  addiu      $s1, $s1, 0x4
    /* 5E954 8006E154 39B80108 */  j          .L8006E0E4
    /* 5E958 8006E158 01007326 */   addiu     $s3, $s3, 0x1
  .L8006E15C:
    /* 5E95C 8006E15C 5405A28E */  lw         $v0, 0x554($s5)
    /* 5E960 8006E160 00000000 */  nop
    /* 5E964 8006E164 18004202 */  mult       $s2, $v0
    /* 5E968 8006E168 6004838E */  lw         $v1, 0x460($s4)
    /* 5E96C 8006E16C 12900000 */  mflo       $s2
    /* 5E970 8006E170 30006014 */  bnez       $v1, .L8006E234
    /* 5E974 8006E174 0100023C */   lui       $v0, (0x10000 >> 16)
    /* 5E978 8006E178 0900043C */  lui        $a0, (0x9FFFF >> 16)
    /* 5E97C 8006E17C FFFF8434 */  ori        $a0, $a0, (0x9FFFF & 0xFFFF)
    /* 5E980 8006E180 1300033C */  lui        $v1, (0x13FFFE >> 16)
    /* 5E984 8006E184 6405828E */  lw         $v0, 0x564($s4)
    /* 5E988 8006E188 FEFF6334 */  ori        $v1, $v1, (0x13FFFE & 0xFFFF)
    /* 5E98C 8006E18C 21104400 */  addu       $v0, $v0, $a0
    /* 5E990 8006E190 2B186200 */  sltu       $v1, $v1, $v0
    /* 5E994 8006E194 03006014 */  bnez       $v1, .L8006E1A4
    /* 5E998 8006E198 8888023C */   lui       $v0, (0x88888889 >> 16)
  .L8006E19C:
    /* 5E99C 8006E19C 8DB80108 */  j          .L8006E234
    /* 5E9A0 8006E1A0 0100023C */   lui       $v0, (0x10000 >> 16)
  .L8006E1A4:
    /* 5E9A4 8006E1A4 89884234 */  ori        $v0, $v0, (0x88888889 & 0xFFFF)
    /* 5E9A8 8006E1A8 18004202 */  mult       $s2, $v0
    /* 5E9AC 8006E1AC C31F1200 */  sra        $v1, $s2, 31
    /* 5E9B0 8006E1B0 10300000 */  mfhi       $a2
    /* 5E9B4 8006E1B4 2110D200 */  addu       $v0, $a2, $s2
    /* 5E9B8 8006E1B8 43150200 */  sra        $v0, $v0, 21
    /* 5E9BC 8006E1BC 23104300 */  subu       $v0, $v0, $v1
    /* 5E9C0 8006E1C0 0A004424 */  addiu      $a0, $v0, 0xA
    /* 5E9C4 8006E1C4 05008004 */  bltz       $a0, .L8006E1DC
    /* 5E9C8 8006E1C8 15008228 */   slti      $v0, $a0, 0x15
    /* 5E9CC 8006E1CC 04004010 */  beqz       $v0, .L8006E1E0
    /* 5E9D0 8006E1D0 14000324 */   addiu     $v1, $zero, 0x14
    /* 5E9D4 8006E1D4 78B80108 */  j          .L8006E1E0
    /* 5E9D8 8006E1D8 21188000 */   addu      $v1, $a0, $zero
  .L8006E1DC:
    /* 5E9DC 8006E1DC 21180000 */  addu       $v1, $zero, $zero
  .L8006E1E0:
    /* 5E9E0 8006E1E0 1180023C */  lui        $v0, %hi(AIPerson_glueTable)
    /* 5E9E4 8006E1E4 14D74224 */  addiu      $v0, $v0, %lo(AIPerson_glueTable)
    /* 5E9E8 8006E1E8 80180300 */  sll        $v1, $v1, 2
    /* 5E9EC 8006E1EC 21186200 */  addu       $v1, $v1, $v0
    /* 5E9F0 8006E1F0 0000648C */  lw         $a0, 0x0($v1)
    /* 5E9F4 8006E1F4 FFFF0234 */  ori        $v0, $zero, 0xFFFF
    /* 5E9F8 8006E1F8 2A104400 */  slt        $v0, $v0, $a0
    /* 5E9FC 8006E1FC 07004014 */  bnez       $v0, .L8006E21C
    /* 5EA00 8006E200 66668228 */   slti      $v0, $a0, 0x6666
    /* 5EA04 8006E204 4C07A58E */  lw         $a1, 0x74C($s5)
    /* 5EA08 8006E208 0100103C */  lui        $s0, (0x10000 >> 16)
    /* 5EA0C 8006E20C CA90030C */  jal        fixedmult
    /* 5EA10 8006E210 23200402 */   subu      $a0, $s0, $a0
    /* 5EA14 8006E214 23200202 */  subu       $a0, $s0, $v0
    /* 5EA18 8006E218 66668228 */  slti       $v0, $a0, 0x6666
  .L8006E21C:
    /* 5EA1C 8006E21C 02004010 */  beqz       $v0, .L8006E228
    /* 5EA20 8006E220 00000000 */   nop
    /* 5EA24 8006E224 66660424 */  addiu      $a0, $zero, 0x6666
  .L8006E228:
    /* 5EA28 8006E228 BC06A58E */  lw         $a1, 0x6BC($s5)
    /* 5EA2C 8006E22C CA90030C */  jal        fixedmult
    /* 5EA30 8006E230 00000000 */   nop
  .L8006E234:
    /* 5EA34 8006E234 2800BF8F */  lw         $ra, 0x28($sp)
    /* 5EA38 8006E238 2400B58F */  lw         $s5, 0x24($sp)
    /* 5EA3C 8006E23C 2000B48F */  lw         $s4, 0x20($sp)
    /* 5EA40 8006E240 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 5EA44 8006E244 1800B28F */  lw         $s2, 0x18($sp)
    /* 5EA48 8006E248 1400B18F */  lw         $s1, 0x14($sp)
    /* 5EA4C 8006E24C 1000B08F */  lw         $s0, 0x10($sp)
    /* 5EA50 8006E250 0800E003 */  jr         $ra
    /* 5EA54 8006E254 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel AISpeeds_BTCGetGlueFactor__FP8Car_tObj
