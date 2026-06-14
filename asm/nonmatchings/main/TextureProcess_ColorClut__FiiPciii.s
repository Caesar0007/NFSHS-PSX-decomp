.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TextureProcess_ColorClut__FiiPciii, 0x208

glabel TextureProcess_ColorClut__FiiPciii
    /* D10B8 800E08B8 C0FDBD27 */  addiu      $sp, $sp, -0x240
    /* D10BC 800E08BC 1280033C */  lui        $v1, %hi(TrackSpec_gSpec)
    /* D10C0 800E08C0 7C326324 */  addiu      $v1, $v1, %lo(TrackSpec_gSpec)
    /* D10C4 800E08C4 3C02BFAF */  sw         $ra, 0x23C($sp)
    /* D10C8 800E08C8 3802BEAF */  sw         $fp, 0x238($sp)
    /* D10CC 800E08CC 3402B7AF */  sw         $s7, 0x234($sp)
    /* D10D0 800E08D0 3002B6AF */  sw         $s6, 0x230($sp)
    /* D10D4 800E08D4 2C02B5AF */  sw         $s5, 0x22C($sp)
    /* D10D8 800E08D8 2802B4AF */  sw         $s4, 0x228($sp)
    /* D10DC 800E08DC 2402B3AF */  sw         $s3, 0x224($sp)
    /* D10E0 800E08E0 2002B2AF */  sw         $s2, 0x220($sp)
    /* D10E4 800E08E4 1C02B1AF */  sw         $s1, 0x21C($sp)
    /* D10E8 800E08E8 1802B0AF */  sw         $s0, 0x218($sp)
    /* D10EC 800E08EC 4C02A7AF */  sw         $a3, 0x24C($sp)
    /* D10F0 800E08F0 1000628C */  lw         $v0, 0x10($v1)
    /* D10F4 800E08F4 00000000 */  nop
    /* D10F8 800E08F8 18004400 */  mult       $v0, $a0
    /* D10FC 800E08FC 21B8C000 */  addu       $s7, $a2, $zero
    /* D1100 800E0900 21B00000 */  addu       $s6, $zero, $zero
    /* D1104 800E0904 21F06000 */  addu       $fp, $v1, $zero
    /* D1108 800E0908 12480000 */  mflo       $t1
    /* D110C 800E090C 1000B427 */  addiu      $s4, $sp, 0x10
    /* D1110 800E0910 FFFFA524 */  addiu      $a1, $a1, -0x1
    /* D1114 800E0914 1A002501 */  div        $zero, $t1, $a1
    /* D1118 800E0918 0200A014 */  bnez       $a1, .L800E0924
    /* D111C 800E091C 00000000 */   nop
    /* D1120 800E0920 0D000700 */  break      7
  .L800E0924:
    /* D1124 800E0924 FFFF0124 */  addiu      $at, $zero, -0x1
    /* D1128 800E0928 0400A114 */  bne        $a1, $at, .L800E093C
    /* D112C 800E092C 0080013C */   lui       $at, (0x80000000 >> 16)
    /* D1130 800E0930 02002115 */  bne        $t1, $at, .L800E093C
    /* D1134 800E0934 00000000 */   nop
    /* D1138 800E0938 0D000600 */  break      6
  .L800E093C:
    /* D113C 800E093C 12A80000 */  mflo       $s5
  .L800E0940:
    /* D1140 800E0940 4C02A88F */  lw         $t0, 0x24C($sp)
    /* D1144 800E0944 00000000 */  nop
    /* D1148 800E0948 2A10C802 */  slt        $v0, $s6, $t0
    /* D114C 800E094C 46004010 */  beqz       $v0, .L800E0A68
    /* D1150 800E0950 1002A427 */   addiu     $a0, $sp, 0x210
    /* D1154 800E0954 0000F396 */  lhu        $s3, 0x0($s7)
    /* D1158 800E0958 00000000 */  nop
    /* D115C 800E095C FFFF6332 */  andi       $v1, $s3, 0xFFFF
    /* D1160 800E0960 03006014 */  bnez       $v1, .L800E0970
    /* D1164 800E0964 C2110300 */   srl       $v0, $v1, 7
    /* D1168 800E0968 96820308 */  j          .L800E0A58
    /* D116C 800E096C 000080A6 */   sh        $zero, 0x0($s4)
  .L800E0970:
    /* D1170 800E0970 F8005030 */  andi       $s0, $v0, 0xF8
    /* D1174 800E0974 82100300 */  srl        $v0, $v1, 2
    /* D1178 800E0978 F8005230 */  andi       $s2, $v0, 0xF8
    /* D117C 800E097C 1F006232 */  andi       $v0, $s3, 0x1F
    /* D1180 800E0980 C0880200 */  sll        $s1, $v0, 3
    /* D1184 800E0984 1400C493 */  lbu        $a0, 0x14($fp)
    /* D1188 800E0988 2128A002 */  addu       $a1, $s5, $zero
    /* D118C 800E098C CA90030C */  jal        fixedmult
    /* D1190 800E0990 23202402 */   subu      $a0, $s1, $a0
    /* D1194 800E0994 23102202 */  subu       $v0, $s1, $v0
    /* D1198 800E0998 06004004 */  bltz       $v0, .L800E09B4
    /* D119C 800E099C 21880000 */   addu      $s1, $zero, $zero
    /* D11A0 800E09A0 21884000 */  addu       $s1, $v0, $zero
    /* D11A4 800E09A4 0001222A */  slti       $v0, $s1, 0x100
    /* D11A8 800E09A8 02004014 */  bnez       $v0, .L800E09B4
    /* D11AC 800E09AC 00000000 */   nop
    /* D11B0 800E09B0 FF001124 */  addiu      $s1, $zero, 0xFF
  .L800E09B4:
    /* D11B4 800E09B4 1500C493 */  lbu        $a0, 0x15($fp)
    /* D11B8 800E09B8 2128A002 */  addu       $a1, $s5, $zero
    /* D11BC 800E09BC CA90030C */  jal        fixedmult
    /* D11C0 800E09C0 23204402 */   subu      $a0, $s2, $a0
    /* D11C4 800E09C4 23104202 */  subu       $v0, $s2, $v0
    /* D11C8 800E09C8 06004004 */  bltz       $v0, .L800E09E4
    /* D11CC 800E09CC 21900000 */   addu      $s2, $zero, $zero
    /* D11D0 800E09D0 21904000 */  addu       $s2, $v0, $zero
    /* D11D4 800E09D4 0001422A */  slti       $v0, $s2, 0x100
    /* D11D8 800E09D8 02004014 */  bnez       $v0, .L800E09E4
    /* D11DC 800E09DC 00000000 */   nop
    /* D11E0 800E09E0 FF001224 */  addiu      $s2, $zero, 0xFF
  .L800E09E4:
    /* D11E4 800E09E4 1600C493 */  lbu        $a0, 0x16($fp)
    /* D11E8 800E09E8 2128A002 */  addu       $a1, $s5, $zero
    /* D11EC 800E09EC CA90030C */  jal        fixedmult
    /* D11F0 800E09F0 23200402 */   subu      $a0, $s0, $a0
    /* D11F4 800E09F4 23100202 */  subu       $v0, $s0, $v0
    /* D11F8 800E09F8 06004004 */  bltz       $v0, .L800E0A14
    /* D11FC 800E09FC 21800000 */   addu      $s0, $zero, $zero
    /* D1200 800E0A00 21804000 */  addu       $s0, $v0, $zero
    /* D1204 800E0A04 0001022A */  slti       $v0, $s0, 0x100
    /* D1208 800E0A08 03004014 */  bnez       $v0, .L800E0A18
    /* D120C 800E0A0C 0800022A */   slti      $v0, $s0, 0x8
    /* D1210 800E0A10 FF001024 */  addiu      $s0, $zero, 0xFF
  .L800E0A14:
    /* D1214 800E0A14 0800022A */  slti       $v0, $s0, 0x8
  .L800E0A18:
    /* D1218 800E0A18 03004010 */  beqz       $v0, .L800E0A28
    /* D121C 800E0A1C C3101000 */   sra       $v0, $s0, 3
    /* D1220 800E0A20 08001024 */  addiu      $s0, $zero, 0x8
    /* D1224 800E0A24 C3101000 */  sra        $v0, $s0, 3
  .L800E0A28:
    /* D1228 800E0A28 1F005030 */  andi       $s0, $v0, 0x1F
    /* D122C 800E0A2C C3101200 */  sra        $v0, $s2, 3
    /* D1230 800E0A30 1F005230 */  andi       $s2, $v0, 0x1F
    /* D1234 800E0A34 C3101100 */  sra        $v0, $s1, 3
    /* D1238 800E0A38 1F005130 */  andi       $s1, $v0, 0x1F
    /* D123C 800E0A3C 00806232 */  andi       $v0, $s3, 0x8000
    /* D1240 800E0A40 801A1000 */  sll        $v1, $s0, 10
    /* D1244 800E0A44 25104300 */  or         $v0, $v0, $v1
    /* D1248 800E0A48 40191200 */  sll        $v1, $s2, 5
    /* D124C 800E0A4C 25104300 */  or         $v0, $v0, $v1
    /* D1250 800E0A50 25105100 */  or         $v0, $v0, $s1
    /* D1254 800E0A54 000082A6 */  sh         $v0, 0x0($s4)
  .L800E0A58:
    /* D1258 800E0A58 0200F726 */  addiu      $s7, $s7, 0x2
    /* D125C 800E0A5C 02009426 */  addiu      $s4, $s4, 0x2
    /* D1260 800E0A60 50820308 */  j          .L800E0940
    /* D1264 800E0A64 0100D626 */   addiu     $s6, $s6, 0x1
  .L800E0A68:
    /* D1268 800E0A68 5002A28F */  lw         $v0, 0x250($sp)
    /* D126C 800E0A6C 4C02A897 */  lhu        $t0, 0x24C($sp)
    /* D1270 800E0A70 1000A527 */  addiu      $a1, $sp, 0x10
    /* D1274 800E0A74 1002A2A7 */  sh         $v0, 0x210($sp)
    /* D1278 800E0A78 5402A28F */  lw         $v0, 0x254($sp)
    /* D127C 800E0A7C 1402A8A7 */  sh         $t0, 0x214($sp)
    /* D1280 800E0A80 1202A2A7 */  sh         $v0, 0x212($sp)
    /* D1284 800E0A84 01000224 */  addiu      $v0, $zero, 0x1
    /* D1288 800E0A88 A4B6030C */  jal        LoadImage
    /* D128C 800E0A8C 1602A2A7 */   sh        $v0, 0x216($sp)
    /* D1290 800E0A90 3C02BF8F */  lw         $ra, 0x23C($sp)
    /* D1294 800E0A94 3802BE8F */  lw         $fp, 0x238($sp)
    /* D1298 800E0A98 3402B78F */  lw         $s7, 0x234($sp)
    /* D129C 800E0A9C 3002B68F */  lw         $s6, 0x230($sp)
    /* D12A0 800E0AA0 2C02B58F */  lw         $s5, 0x22C($sp)
    /* D12A4 800E0AA4 2802B48F */  lw         $s4, 0x228($sp)
    /* D12A8 800E0AA8 2402B38F */  lw         $s3, 0x224($sp)
    /* D12AC 800E0AAC 2002B28F */  lw         $s2, 0x220($sp)
    /* D12B0 800E0AB0 1C02B18F */  lw         $s1, 0x21C($sp)
    /* D12B4 800E0AB4 1802B08F */  lw         $s0, 0x218($sp)
    /* D12B8 800E0AB8 0800E003 */  jr         $ra
    /* D12BC 800E0ABC 4002BD27 */   addiu     $sp, $sp, 0x240
endlabel TextureProcess_ColorClut__FiiPciii
