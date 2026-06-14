.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching R3DCar_InsertCarFacetMenu__FP8Car_tObjP13DRender_tView, 0x1078

glabel R3DCar_InsertCarFacetMenu__FP8Car_tObjP13DRender_tView
    /* A18FC 800B10FC 90FEBD27 */  addiu      $sp, $sp, -0x170
    /* A1900 800B1100 4C01B1AF */  sw         $s1, 0x14C($sp)
    /* A1904 800B1104 21888000 */  addu       $s1, $a0, $zero
    /* A1908 800B1108 6401B7AF */  sw         $s7, 0x164($sp)
    /* A190C 800B110C 21B8A000 */  addu       $s7, $a1, $zero
    /* A1910 800B1110 6C01BFAF */  sw         $ra, 0x16C($sp)
    /* A1914 800B1114 6801BEAF */  sw         $fp, 0x168($sp)
    /* A1918 800B1118 6001B6AF */  sw         $s6, 0x160($sp)
    /* A191C 800B111C 5C01B5AF */  sw         $s5, 0x15C($sp)
    /* A1920 800B1120 5801B4AF */  sw         $s4, 0x158($sp)
    /* A1924 800B1124 5401B3AF */  sw         $s3, 0x154($sp)
    /* A1928 800B1128 5001B2AF */  sw         $s2, 0x150($sp)
    /* A192C 800B112C 4801B0AF */  sw         $s0, 0x148($sp)
    /* A1930 800B1130 4401A0AF */  sw         $zero, 0x144($sp)
    /* A1934 800B1134 D0082D8E */  lw         $t5, 0x8D0($s1)
    /* A1938 800B1138 00000000 */  nop
    /* A193C 800B113C 4001ADAF */  sw         $t5, 0x140($sp)
    /* A1940 800B1140 42082292 */  lbu        $v0, 0x842($s1)
    /* A1944 800B1144 BC083386 */  lh         $s3, 0x8BC($s1)
    /* A1948 800B1148 C2A90200 */  srl        $s5, $v0, 7
    /* A194C 800B114C 1C00622A */  slti       $v0, $s3, 0x1C
    /* A1950 800B1150 16004010 */  beqz       $v0, .L800B11AC
    /* A1954 800B1154 21380000 */   addu      $a3, $zero, $zero
    /* A1958 800B1158 1180023C */  lui        $v0, %hi(R3DCar_ForceDriveSide)
    /* A195C 800B115C 44684224 */  addiu      $v0, $v0, %lo(R3DCar_ForceDriveSide)
    /* A1960 800B1160 21106202 */  addu       $v0, $s3, $v0
    /* A1964 800B1164 00004280 */  lb         $v0, 0x0($v0)
    /* A1968 800B1168 00000000 */  nop
    /* A196C 800B116C 0F004104 */  bgez       $v0, .L800B11AC
    /* A1970 800B1170 4401A2AF */   sw        $v0, 0x144($sp)
    /* A1974 800B1174 1180033C */  lui        $v1, %hi(AITune_trackInfo)
    /* A1978 800B1178 1180023C */  lui        $v0, %hi(D_80113228)
    /* A197C 800B117C 2832448C */  lw         $a0, %lo(D_80113228)($v0)
    /* A1980 800B1180 74DE6324 */  addiu      $v1, $v1, %lo(AITune_trackInfo)
    /* A1984 800B1184 40100400 */  sll        $v0, $a0, 1
    /* A1988 800B1188 21104400 */  addu       $v0, $v0, $a0
    /* A198C 800B118C 80100200 */  sll        $v0, $v0, 2
    /* A1990 800B1190 21104300 */  addu       $v0, $v0, $v1
    /* A1994 800B1194 0400428C */  lw         $v0, 0x4($v0)
    /* A1998 800B1198 00000000 */  nop
    /* A199C 800B119C 01004224 */  addiu      $v0, $v0, 0x1
    /* A19A0 800B11A0 43100200 */  sra        $v0, $v0, 1
    /* A19A4 800B11A4 01004238 */  xori       $v0, $v0, 0x1
    /* A19A8 800B11A8 4401A2AF */  sw         $v0, 0x144($sp)
  .L800B11AC:
    /* A19AC 800B11AC 8802238E */  lw         $v1, 0x288($s1)
    /* A19B0 800B11B0 4401AE8F */  lw         $t6, 0x144($sp)
    /* A19B4 800B11B4 0000738C */  lw         $s3, 0x0($v1)
    /* A19B8 800B11B8 700E8EAF */  sw         $t6, %gp_rel(R3DCar_rightHandDrive)($gp)
    /* A19BC 800B11BC EAFF6226 */  addiu      $v0, $s3, -0x16
    /* A19C0 800B11C0 0600542C */  sltiu      $s4, $v0, 0x6
    /* A19C4 800B11C4 02008016 */  bnez       $s4, .L800B11D0
    /* A19C8 800B11C8 1180053C */   lui       $a1, %hi(R3DCar_subOtStart)
    /* A19CC 800B11CC A00060AC */  sw         $zero, 0xA0($v1)
  .L800B11D0:
    /* A19D0 800B11D0 AC6DA524 */  addiu      $a1, $a1, %lo(R3DCar_subOtStart)
    /* A19D4 800B11D4 D80D868F */  lw         $a2, %gp_rel(R3DCar_InMenu)($gp)
    /* A19D8 800B11D8 1480023C */  lui        $v0, %hi(gFlip)
    /* A19DC 800B11DC B4D7428C */  lw         $v0, %lo(gFlip)($v0)
    /* A19E0 800B11E0 0000248E */  lw         $a0, 0x0($s1)
    /* A19E4 800B11E4 8000C630 */  andi       $a2, $a2, 0x80
    /* A19E8 800B11E8 2B180600 */  sltu       $v1, $zero, $a2
    /* A19EC 800B11EC 80180300 */  sll        $v1, $v1, 2
    /* A19F0 800B11F0 C0100200 */  sll        $v0, $v0, 3
    /* A19F4 800B11F4 21186200 */  addu       $v1, $v1, $v0
    /* A19F8 800B11F8 21186500 */  addu       $v1, $v1, $a1
    /* A19FC 800B11FC 0F008430 */  andi       $a0, $a0, 0xF
    /* A1A00 800B1200 0000628C */  lw         $v0, 0x0($v1)
    /* A1A04 800B1204 C0220400 */  sll        $a0, $a0, 11
    /* A1A08 800B1208 21104400 */  addu       $v0, $v0, $a0
    /* A1A0C 800B120C 3801C014 */  bnez       $a2, .L800B16F0
    /* A1A10 800B1210 6C0822AE */   sw        $v0, 0x86C($s1)
    /* A1A14 800B1214 00020224 */  addiu      $v0, $zero, 0x200
    /* A1A18 800B1218 700822AE */  sw         $v0, 0x870($s1)
    /* A1A1C 800B121C 00010224 */  addiu      $v0, $zero, 0x100
    /* A1A20 800B1220 740822AE */  sw         $v0, 0x874($s1)
    /* A1A24 800B1224 1280023C */  lui        $v0, %hi(DrawC_gScreenMat)
    /* A1A28 800B1228 00100424 */  addiu      $a0, $zero, 0x1000
    /* A1A2C 800B122C 780820AE */  sw         $zero, 0x878($s1)
    /* A1A30 800B1230 7C0820A6 */  sh         $zero, 0x87C($s1)
    /* A1A34 800B1234 C8F444A4 */  sh         $a0, %lo(DrawC_gScreenMat)($v0)
    /* A1A38 800B1238 C8F44224 */  addiu      $v0, $v0, %lo(DrawC_gScreenMat)
    /* A1A3C 800B123C 380E858F */  lw         $a1, %gp_rel(R3DCar_aSyncLoading)($gp)
    /* A1A40 800B1240 00F00324 */  addiu      $v1, $zero, -0x1000
    /* A1A44 800B1244 060040A4 */  sh         $zero, 0x6($v0)
    /* A1A48 800B1248 0C0040A4 */  sh         $zero, 0xC($v0)
    /* A1A4C 800B124C 020040A4 */  sh         $zero, 0x2($v0)
    /* A1A50 800B1250 080043A4 */  sh         $v1, 0x8($v0)
    /* A1A54 800B1254 0E0040A4 */  sh         $zero, 0xE($v0)
    /* A1A58 800B1258 040040A4 */  sh         $zero, 0x4($v0)
    /* A1A5C 800B125C 0A0040A4 */  sh         $zero, 0xA($v0)
    /* A1A60 800B1260 100044A4 */  sh         $a0, 0x10($v0)
    /* A1A64 800B1264 140040AC */  sw         $zero, 0x14($v0)
    /* A1A68 800B1268 180040AC */  sw         $zero, 0x18($v0)
    /* A1A6C 800B126C 1C0040AC */  sw         $zero, 0x1C($v0)
    /* A1A70 800B1270 0500A004 */  bltz       $a1, .L800B1288
    /* A1A74 800B1274 C20820A6 */   sh        $zero, 0x8C2($s1)
    /* A1A78 800B1278 0400E28E */  lw         $v0, 0x4($s7)
    /* A1A7C 800B127C 00000000 */  nop
    /* A1A80 800B1280 1B01A214 */  bne        $a1, $v0, .L800B16F0
    /* A1A84 800B1284 00000000 */   nop
  .L800B1288:
    /* A1A88 800B1288 D808228E */  lw         $v0, 0x8D8($s1)
    /* A1A8C 800B128C 00000000 */  nop
    /* A1A90 800B1290 62004014 */  bnez       $v0, .L800B141C
    /* A1A94 800B1294 00000000 */   nop
    /* A1A98 800B1298 8802228E */  lw         $v0, 0x288($s1)
    /* A1A9C 800B129C 43082392 */  lbu        $v1, 0x843($s1)
    /* A1AA0 800B12A0 A000428C */  lw         $v0, 0xA0($v0)
    /* A1AA4 800B12A4 00000000 */  nop
    /* A1AA8 800B12A8 05006210 */  beq        $v1, $v0, .L800B12C0
    /* A1AAC 800B12AC 00000000 */   nop
    /* A1AB0 800B12B0 BE082296 */  lhu        $v0, 0x8BE($s1)
    /* A1AB4 800B12B4 00000000 */  nop
    /* A1AB8 800B12B8 80004234 */  ori        $v0, $v0, 0x80
    /* A1ABC 800B12BC BE0822A6 */  sh         $v0, 0x8BE($s1)
  .L800B12C0:
    /* A1AC0 800B12C0 D808228E */  lw         $v0, 0x8D8($s1)
    /* A1AC4 800B12C4 00000000 */  nop
    /* A1AC8 800B12C8 54004014 */  bnez       $v0, .L800B141C
    /* A1ACC 800B12CC 00000000 */   nop
    /* A1AD0 800B12D0 BE082286 */  lh         $v0, 0x8BE($s1)
    /* A1AD4 800B12D4 00000000 */  nop
    /* A1AD8 800B12D8 4C005310 */  beq        $v0, $s3, .L800B140C
    /* A1ADC 800B12DC 00000000 */   nop
    /* A1AE0 800B12E0 F7E7010C */  jal        AudioMus_Buffered__Fv
    /* A1AE4 800B12E4 00000000 */   nop
    /* A1AE8 800B12E8 D6E7010C */  jal        AudioMus_Threshold__Fv
    /* A1AEC 800B12EC 21804000 */   addu      $s0, $v0, $zero
    /* A1AF0 800B12F0 2A800202 */  slt        $s0, $s0, $v0
    /* A1AF4 800B12F4 0100103A */  xori       $s0, $s0, 0x1
    /* A1AF8 800B12F8 44000012 */  beqz       $s0, .L800B140C
    /* A1AFC 800B12FC 1C00622A */   slti      $v0, $s3, 0x1C
    /* A1B00 800B1300 04004014 */  bnez       $v0, .L800B1314
    /* A1B04 800B1304 00000000 */   nop
    /* A1B08 800B1308 C0082296 */  lhu        $v0, 0x8C0($s1)
    /* A1B0C 800B130C C8C40208 */  j          .L800B1320
    /* A1B10 800B1310 EF004230 */   andi      $v0, $v0, 0xEF
  .L800B1314:
    /* A1B14 800B1314 C0082296 */  lhu        $v0, 0x8C0($s1)
    /* A1B18 800B1318 00000000 */  nop
    /* A1B1C 800B131C 10004234 */  ori        $v0, $v0, 0x10
  .L800B1320:
    /* A1B20 800B1320 C00822A6 */  sh         $v0, 0x8C0($s1)
    /* A1B24 800B1324 C800B227 */  addiu      $s2, $sp, 0xC8
    /* A1B28 800B1328 21204002 */  addu       $a0, $s2, $zero
    /* A1B2C 800B132C 1480053C */  lui        $a1, %hi(D_8013D350)
    /* A1B30 800B1330 50D3A524 */  addiu      $a1, $a1, %lo(D_8013D350)
    /* A1B34 800B1334 80101300 */  sll        $v0, $s3, 2
    /* A1B38 800B1338 21105300 */  addu       $v0, $v0, $s3
    /* A1B3C 800B133C 1180063C */  lui        $a2, %hi(GameSetup_gCarNames)
    /* A1B40 800B1340 4430C624 */  addiu      $a2, $a2, %lo(GameSetup_gCarNames)
    /* A1B44 800B1344 2F91030C */  jal        sprintf
    /* A1B48 800B1348 21304600 */   addu      $a2, $v0, $a2
    /* A1B4C 800B134C 10008012 */  beqz       $s4, .L800B1390
    /* A1B50 800B1350 1180043C */   lui       $a0, %hi(R3DCar_CopIndex)
    /* A1B54 800B1354 7C688424 */  addiu      $a0, $a0, %lo(R3DCar_CopIndex)
    /* A1B58 800B1358 EAFF6526 */  addiu      $a1, $s3, -0x16
    /* A1B5C 800B135C 8802238E */  lw         $v1, 0x288($s1)
    /* A1B60 800B1360 80100500 */  sll        $v0, $a1, 2
    /* A1B64 800B1364 A000638C */  lw         $v1, 0xA0($v1)
    /* A1B68 800B1368 21104500 */  addu       $v0, $v0, $a1
    /* A1B6C 800B136C 21186200 */  addu       $v1, $v1, $v0
    /* A1B70 800B1370 21186400 */  addu       $v1, $v1, $a0
    /* A1B74 800B1374 1180023C */  lui        $v0, %hi(R3DCar_CopCountry)
    /* A1B78 800B1378 00006390 */  lbu        $v1, 0x0($v1)
    /* A1B7C 800B137C 9C684224 */  addiu      $v0, $v0, %lo(R3DCar_CopCountry)
    /* A1B80 800B1380 21186200 */  addu       $v1, $v1, $v0
    /* A1B84 800B1384 00006290 */  lbu        $v0, 0x0($v1)
    /* A1B88 800B1388 00000000 */  nop
    /* A1B8C 800B138C CA00A2A3 */  sb         $v0, 0xCA($sp)
  .L800B1390:
    /* A1B90 800B1390 1180023C */  lui        $v0, %hi(D_801164C8)
    /* A1B94 800B1394 D800B027 */  addiu      $s0, $sp, 0xD8
    /* A1B98 800B1398 C864458C */  lw         $a1, %lo(D_801164C8)($v0)
    /* A1B9C 800B139C CA96030C */  jal        strcpy
    /* A1BA0 800B13A0 21200002 */   addu      $a0, $s0, $zero
    /* A1BA4 800B13A4 21200002 */  addu       $a0, $s0, $zero
    /* A1BA8 800B13A8 3A9E030C */  jal        strcat
    /* A1BAC 800B13AC 21284002 */   addu      $a1, $s2, $zero
    /* A1BB0 800B13B0 C0082296 */  lhu        $v0, 0x8C0($s1)
    /* A1BB4 800B13B4 00000000 */  nop
    /* A1BB8 800B13B8 10004230 */  andi       $v0, $v0, 0x10
    /* A1BBC 800B13BC 04004010 */  beqz       $v0, .L800B13D0
    /* A1BC0 800B13C0 21200002 */   addu      $a0, $s0, $zero
    /* A1BC4 800B13C4 1480053C */  lui        $a1, %hi(D_8013D358)
    /* A1BC8 800B13C8 3A9E030C */  jal        strcat
    /* A1BCC 800B13CC 58D3A524 */   addiu     $a1, $a1, %lo(D_8013D358)
  .L800B13D0:
    /* A1BD0 800B13D0 21200002 */  addu       $a0, $s0, $zero
    /* A1BD4 800B13D4 1480053C */  lui        $a1, %hi(D_8013D360)
    /* A1BD8 800B13D8 3A9E030C */  jal        strcat
    /* A1BDC 800B13DC 60D3A524 */   addiu     $a1, $a1, %lo(D_8013D360)
    /* A1BE0 800B13E0 21200002 */  addu       $a0, $s0, $zero
    /* A1BE4 800B13E4 DAC4030C */  jal        asyncloadfile
    /* A1BE8 800B13E8 10000524 */   addiu     $a1, $zero, 0x10
    /* A1BEC 800B13EC D80822AE */  sw         $v0, 0x8D8($s1)
    /* A1BF0 800B13F0 0400E28E */  lw         $v0, 0x4($s7)
    /* A1BF4 800B13F4 8802238E */  lw         $v1, 0x288($s1)
    /* A1BF8 800B13F8 BE0833A6 */  sh         $s3, 0x8BE($s1)
    /* A1BFC 800B13FC 380E82AF */  sw         $v0, %gp_rel(R3DCar_aSyncLoading)($gp)
    /* A1C00 800B1400 A0006290 */  lbu        $v0, 0xA0($v1)
    /* A1C04 800B1404 00000000 */  nop
    /* A1C08 800B1408 430822A2 */  sb         $v0, 0x843($s1)
  .L800B140C:
    /* A1C0C 800B140C D808228E */  lw         $v0, 0x8D8($s1)
    /* A1C10 800B1410 00000000 */  nop
    /* A1C14 800B1414 33004010 */  beqz       $v0, .L800B14E4
    /* A1C18 800B1418 00000000 */   nop
  .L800B141C:
    /* A1C1C 800B141C D808248E */  lw         $a0, 0x8D8($s1)
    /* A1C20 800B1420 B6C5030C */  jal        getasyncreadstatus
    /* A1C24 800B1424 00000000 */   nop
    /* A1C28 800B1428 21804000 */  addu       $s0, $v0, $zero
    /* A1C2C 800B142C 0300001E */  bgtz       $s0, .L800B143C
    /* A1C30 800B1430 FFFF0224 */   addiu     $v0, $zero, -0x1
    /* A1C34 800B1434 25000216 */  bne        $s0, $v0, .L800B14CC
    /* A1C38 800B1438 FEFF0224 */   addiu     $v0, $zero, -0x2
  .L800B143C:
    /* A1C3C 800B143C BE082286 */  lh         $v0, 0x8BE($s1)
    /* A1C40 800B1440 00000000 */  nop
    /* A1C44 800B1444 07005314 */  bne        $v0, $s3, .L800B1464
    /* A1C48 800B1448 00000000 */   nop
    /* A1C4C 800B144C 8802228E */  lw         $v0, 0x288($s1)
    /* A1C50 800B1450 43082392 */  lbu        $v1, 0x843($s1)
    /* A1C54 800B1454 A000428C */  lw         $v0, 0xA0($v0)
    /* A1C58 800B1458 00000000 */  nop
    /* A1C5C 800B145C 0A006210 */  beq        $v1, $v0, .L800B1488
    /* A1C60 800B1460 00000000 */   nop
  .L800B1464:
    /* A1C64 800B1464 D808248E */  lw         $a0, 0x8D8($s1)
    /* A1C68 800B1468 90C5030C */  jal        getasyncreadadr
    /* A1C6C 800B146C 00000000 */   nop
    /* A1C70 800B1470 1C004010 */  beqz       $v0, .L800B14E4
    /* A1C74 800B1474 00000000 */   nop
    /* A1C78 800B1478 5095030C */  jal        purgememadr
    /* A1C7C 800B147C 21204000 */   addu      $a0, $v0, $zero
    /* A1C80 800B1480 35C50208 */  j          .L800B14D4
    /* A1C84 800B1484 00000000 */   nop
  .L800B1488:
    /* A1C88 800B1488 D808248E */  lw         $a0, 0x8D8($s1)
    /* A1C8C 800B148C 90C5030C */  jal        getasyncreadadr
    /* A1C90 800B1490 00000000 */   nop
    /* A1C94 800B1494 640E82AF */  sw         $v0, %gp_rel(R3DCar_BigFile)($gp)
    /* A1C98 800B1498 94004010 */  beqz       $v0, .L800B16EC
    /* A1C9C 800B149C FFFF0324 */   addiu     $v1, $zero, -0x1
    /* A1CA0 800B14A0 07000316 */  bne        $s0, $v1, .L800B14C0
    /* A1CA4 800B14A4 D80820AE */   sw        $zero, 0x8D8($s1)
    /* A1CA8 800B14A8 5095030C */  jal        purgememadr
    /* A1CAC 800B14AC 21204000 */   addu      $a0, $v0, $zero
    /* A1CB0 800B14B0 BE082296 */  lhu        $v0, 0x8BE($s1)
    /* A1CB4 800B14B4 640E80AF */  sw         $zero, %gp_rel(R3DCar_BigFile)($gp)
    /* A1CB8 800B14B8 38C50208 */  j          .L800B14E0
    /* A1CBC 800B14BC 80004234 */   ori       $v0, $v0, 0x80
  .L800B14C0:
    /* A1CC0 800B14C0 380E83AF */  sw         $v1, %gp_rel(R3DCar_aSyncLoading)($gp)
    /* A1CC4 800B14C4 39C50208 */  j          .L800B14E4
    /* A1CC8 800B14C8 00000000 */   nop
  .L800B14CC:
    /* A1CCC 800B14CC 05000216 */  bne        $s0, $v0, .L800B14E4
    /* A1CD0 800B14D0 00000000 */   nop
  .L800B14D4:
    /* A1CD4 800B14D4 BE082296 */  lhu        $v0, 0x8BE($s1)
    /* A1CD8 800B14D8 D80820AE */  sw         $zero, 0x8D8($s1)
    /* A1CDC 800B14DC 80004234 */  ori        $v0, $v0, 0x80
  .L800B14E0:
    /* A1CE0 800B14E0 BE0822A6 */  sh         $v0, 0x8BE($s1)
  .L800B14E4:
    /* A1CE4 800B14E4 640E828F */  lw         $v0, %gp_rel(R3DCar_BigFile)($gp)
    /* A1CE8 800B14E8 00000000 */  nop
    /* A1CEC 800B14EC 80004010 */  beqz       $v0, .L800B16F0
    /* A1CF0 800B14F0 21380000 */   addu      $a3, $zero, $zero
    /* A1CF4 800B14F4 BC083086 */  lh         $s0, 0x8BC($s1)
    /* A1CF8 800B14F8 00000000 */  nop
    /* A1CFC 800B14FC 1B000006 */  bltz       $s0, .L800B156C
    /* A1D00 800B1500 21F00000 */   addu      $fp, $zero, $zero
    /* A1D04 800B1504 1180043C */  lui        $a0, %hi(R3DCar_LoadedSceneCounter)
    /* A1D08 800B1508 986A8424 */  addiu      $a0, $a0, %lo(R3DCar_LoadedSceneCounter)
    /* A1D0C 800B150C 40101500 */  sll        $v0, $s5, 1
    /* A1D10 800B1510 21105500 */  addu       $v0, $v0, $s5
    /* A1D14 800B1514 C0100200 */  sll        $v0, $v0, 3
    /* A1D18 800B1518 21285500 */  addu       $a1, $v0, $s5
    /* A1D1C 800B151C 40180500 */  sll        $v1, $a1, 1
    /* A1D20 800B1520 21180302 */  addu       $v1, $s0, $v1
    /* A1D24 800B1524 21186400 */  addu       $v1, $v1, $a0
    /* A1D28 800B1528 00006290 */  lbu        $v0, 0x0($v1)
    /* A1D2C 800B152C 00000000 */  nop
    /* A1D30 800B1530 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* A1D34 800B1534 000062A0 */  sb         $v0, 0x0($v1)
    /* A1D38 800B1538 FF004230 */  andi       $v0, $v0, 0xFF
    /* A1D3C 800B153C 0B004014 */  bnez       $v0, .L800B156C
    /* A1D40 800B1540 01001E24 */   addiu     $fp, $zero, 0x1
    /* A1D44 800B1544 1180023C */  lui        $v0, %hi(R3DCar_LoadedScenePointer)
    /* A1D48 800B1548 08694224 */  addiu      $v0, $v0, %lo(R3DCar_LoadedScenePointer)
    /* A1D4C 800B154C 80801000 */  sll        $s0, $s0, 2
    /* A1D50 800B1550 C0180500 */  sll        $v1, $a1, 3
    /* A1D54 800B1554 21800302 */  addu       $s0, $s0, $v1
    /* A1D58 800B1558 21800202 */  addu       $s0, $s0, $v0
    /* A1D5C 800B155C 0000048E */  lw         $a0, 0x0($s0)
    /* A1D60 800B1560 5095030C */  jal        purgememadr
    /* A1D64 800B1564 00000000 */   nop
    /* A1D68 800B1568 000000AE */  sw         $zero, 0x0($s0)
  .L800B156C:
    /* A1D6C 800B156C BE082296 */  lhu        $v0, 0x8BE($s1)
    /* A1D70 800B1570 43082492 */  lbu        $a0, 0x843($s1)
    /* A1D74 800B1574 BC0822A6 */  sh         $v0, 0x8BC($s1)
    /* A1D78 800B1578 00140200 */  sll        $v0, $v0, 16
    /* A1D7C 800B157C 420824A2 */  sb         $a0, 0x842($s1)
    /* A1D80 800B1580 0400E38E */  lw         $v1, 0x4($s7)
    /* A1D84 800B1584 00000000 */  nop
    /* A1D88 800B1588 03006010 */  beqz       $v1, .L800B1598
    /* A1D8C 800B158C 039C0200 */   sra       $s3, $v0, 16
    /* A1D90 800B1590 80008234 */  ori        $v0, $a0, 0x80
    /* A1D94 800B1594 420822A2 */  sb         $v0, 0x842($s1)
  .L800B1598:
    /* A1D98 800B1598 C800B027 */  addiu      $s0, $sp, 0xC8
    /* A1D9C 800B159C 21200002 */  addu       $a0, $s0, $zero
    /* A1DA0 800B15A0 1480053C */  lui        $a1, %hi(D_8013D350)
    /* A1DA4 800B15A4 50D3A524 */  addiu      $a1, $a1, %lo(D_8013D350)
    /* A1DA8 800B15A8 80B01300 */  sll        $s6, $s3, 2
    /* A1DAC 800B15AC 2110D302 */  addu       $v0, $s6, $s3
    /* A1DB0 800B15B0 1180063C */  lui        $a2, %hi(GameSetup_gCarNames)
    /* A1DB4 800B15B4 4430C624 */  addiu      $a2, $a2, %lo(GameSetup_gCarNames)
    /* A1DB8 800B15B8 21304600 */  addu       $a2, $v0, $a2
    /* A1DBC 800B15BC 42082392 */  lbu        $v1, 0x842($s1)
    /* A1DC0 800B15C0 C0082296 */  lhu        $v0, 0x8C0($s1)
    /* A1DC4 800B15C4 C2A90300 */  srl        $s5, $v1, 7
    /* A1DC8 800B15C8 00140200 */  sll        $v0, $v0, 16
    /* A1DCC 800B15CC 03150200 */  sra        $v0, $v0, 20
    /* A1DD0 800B15D0 2F91030C */  jal        sprintf
    /* A1DD4 800B15D4 C00822A6 */   sh        $v0, 0x8C0($s1)
    /* A1DD8 800B15D8 10008012 */  beqz       $s4, .L800B161C
    /* A1DDC 800B15DC 1180053C */   lui       $a1, %hi(R3DCar_CopIndex)
    /* A1DE0 800B15E0 7C68A524 */  addiu      $a1, $a1, %lo(R3DCar_CopIndex)
    /* A1DE4 800B15E4 EAFF6426 */  addiu      $a0, $s3, -0x16
    /* A1DE8 800B15E8 80100400 */  sll        $v0, $a0, 2
    /* A1DEC 800B15EC 42082392 */  lbu        $v1, 0x842($s1)
    /* A1DF0 800B15F0 21104400 */  addu       $v0, $v0, $a0
    /* A1DF4 800B15F4 7F006330 */  andi       $v1, $v1, 0x7F
    /* A1DF8 800B15F8 21186200 */  addu       $v1, $v1, $v0
    /* A1DFC 800B15FC 21186500 */  addu       $v1, $v1, $a1
    /* A1E00 800B1600 1180023C */  lui        $v0, %hi(R3DCar_CopCountry)
    /* A1E04 800B1604 00006390 */  lbu        $v1, 0x0($v1)
    /* A1E08 800B1608 9C684224 */  addiu      $v0, $v0, %lo(R3DCar_CopCountry)
    /* A1E0C 800B160C 21186200 */  addu       $v1, $v1, $v0
    /* A1E10 800B1610 00006290 */  lbu        $v0, 0x0($v1)
    /* A1E14 800B1614 00000000 */  nop
    /* A1E18 800B1618 CA00A2A3 */  sb         $v0, 0xCA($sp)
  .L800B161C:
    /* A1E1C 800B161C D800B227 */  addiu      $s2, $sp, 0xD8
    /* A1E20 800B1620 21204002 */  addu       $a0, $s2, $zero
    /* A1E24 800B1624 CA96030C */  jal        strcpy
    /* A1E28 800B1628 21280002 */   addu      $a1, $s0, $zero
    /* A1E2C 800B162C C0082296 */  lhu        $v0, 0x8C0($s1)
    /* A1E30 800B1630 00000000 */  nop
    /* A1E34 800B1634 01004230 */  andi       $v0, $v0, 0x1
    /* A1E38 800B1638 04004010 */  beqz       $v0, .L800B164C
    /* A1E3C 800B163C 21204002 */   addu      $a0, $s2, $zero
    /* A1E40 800B1640 1480053C */  lui        $a1, %hi(D_8013D358)
    /* A1E44 800B1644 3A9E030C */  jal        strcat
    /* A1E48 800B1648 58D3A524 */   addiu     $a1, $a1, %lo(D_8013D358)
  .L800B164C:
    /* A1E4C 800B164C 1180023C */  lui        $v0, %hi(R3DCar_LoadedScenePointer)
    /* A1E50 800B1650 08694224 */  addiu      $v0, $v0, %lo(R3DCar_LoadedScenePointer)
    /* A1E54 800B1654 40181500 */  sll        $v1, $s5, 1
    /* A1E58 800B1658 21187500 */  addu       $v1, $v1, $s5
    /* A1E5C 800B165C C0180300 */  sll        $v1, $v1, 3
    /* A1E60 800B1660 21A07500 */  addu       $s4, $v1, $s5
    /* A1E64 800B1664 C0181400 */  sll        $v1, $s4, 3
    /* A1E68 800B1668 2118C302 */  addu       $v1, $s6, $v1
    /* A1E6C 800B166C 21806200 */  addu       $s0, $v1, $v0
    /* A1E70 800B1670 0000048E */  lw         $a0, 0x0($s0)
    /* A1E74 800B1674 00000000 */  nop
    /* A1E78 800B1678 04008010 */  beqz       $a0, .L800B168C
    /* A1E7C 800B167C 00000000 */   nop
    /* A1E80 800B1680 5095030C */  jal        purgememadr
    /* A1E84 800B1684 00000000 */   nop
    /* A1E88 800B1688 000000AE */  sw         $zero, 0x0($s0)
  .L800B168C:
    /* A1E8C 800B168C 21204002 */  addu       $a0, $s2, $zero
    /* A1E90 800B1690 2AB8020C */  jal        R3DCar_ReadInCarData__FPcP8Car_tObj
    /* A1E94 800B1694 21282002 */   addu      $a1, $s1, $zero
    /* A1E98 800B1698 000002AE */  sw         $v0, 0x0($s0)
    /* A1E9C 800B169C 1180023C */  lui        $v0, %hi(R3DCar_LoadedSceneCounter)
    /* A1EA0 800B16A0 986A4224 */  addiu      $v0, $v0, %lo(R3DCar_LoadedSceneCounter)
    /* A1EA4 800B16A4 40181400 */  sll        $v1, $s4, 1
    /* A1EA8 800B16A8 21186302 */  addu       $v1, $s3, $v1
    /* A1EAC 800B16AC 21186200 */  addu       $v1, $v1, $v0
    /* A1EB0 800B16B0 00006290 */  lbu        $v0, 0x0($v1)
    /* A1EB4 800B16B4 21202002 */  addu       $a0, $s1, $zero
    /* A1EB8 800B16B8 01004224 */  addiu      $v0, $v0, 0x1
    /* A1EBC 800B16BC 000062A0 */  sb         $v0, 0x0($v1)
    /* A1EC0 800B16C0 0000058E */  lw         $a1, 0x0($s0)
    /* A1EC4 800B16C4 D4B9020C */  jal        R3DCar_CalcCarDimensions__FP8Car_tObjP18Transformer_zScenei
    /* A1EC8 800B16C8 21306002 */   addu      $a2, $s3, $zero
    /* A1ECC 800B16CC 21202002 */  addu       $a0, $s1, $zero
    /* A1ED0 800B16D0 640E858F */  lw         $a1, %gp_rel(R3DCar_BigFile)($gp)
    /* A1ED4 800B16D4 0400E78E */  lw         $a3, 0x4($s7)
    /* A1ED8 800B16D8 6CC3020C */  jal        R3DCar_ReadInCarTextureMenu__FP8Car_tObjPcii
    /* A1EDC 800B16DC 2130C003 */   addu      $a2, $fp, $zero
    /* A1EE0 800B16E0 640E80AF */  sw         $zero, %gp_rel(R3DCar_BigFile)($gp)
    /* A1EE4 800B16E4 BCC50208 */  j          .L800B16F0
    /* A1EE8 800B16E8 01000724 */   addiu     $a3, $zero, 0x1
  .L800B16EC:
    /* A1EEC 800B16EC 21380000 */  addu       $a3, $zero, $zero
  .L800B16F0:
    /* A1EF0 800B16F0 42082292 */  lbu        $v0, 0x842($s1)
    /* A1EF4 800B16F4 BC083386 */  lh         $s3, 0x8BC($s1)
    /* A1EF8 800B16F8 C2A90200 */  srl        $s5, $v0, 7
    /* A1EFC 800B16FC EAFF6326 */  addiu      $v1, $s3, -0x16
    /* A1F00 800B1700 D80D828F */  lw         $v0, %gp_rel(R3DCar_InMenu)($gp)
    /* A1F04 800B1704 00000000 */  nop
    /* A1F08 800B1708 80004230 */  andi       $v0, $v0, 0x80
    /* A1F0C 800B170C 04004014 */  bnez       $v0, .L800B1720
    /* A1F10 800B1710 0600742C */   sltiu     $s4, $v1, 0x6
    /* A1F14 800B1714 02006106 */  bgez       $s3, .L800B1720
    /* A1F18 800B1718 FFFF0224 */   addiu     $v0, $zero, -0x1
    /* A1F1C 800B171C C20822A6 */  sh         $v0, 0x8C2($s1)
  .L800B1720:
    /* A1F20 800B1720 C2082286 */  lh         $v0, 0x8C2($s1)
    /* A1F24 800B1724 00000000 */  nop
    /* A1F28 800B1728 86024004 */  bltz       $v0, .L800B2144
    /* A1F2C 800B172C 00000000 */   nop
    /* A1F30 800B1730 D80D828F */  lw         $v0, %gp_rel(R3DCar_InMenu)($gp)
    /* A1F34 800B1734 00000000 */  nop
    /* A1F38 800B1738 80004230 */  andi       $v0, $v0, 0x80
    /* A1F3C 800B173C 27004014 */  bnez       $v0, .L800B17DC
    /* A1F40 800B1740 1C00622A */   slti      $v0, $s3, 0x1C
    /* A1F44 800B1744 21008012 */  beqz       $s4, .L800B17CC
    /* A1F48 800B1748 00000000 */   nop
    /* A1F4C 800B174C B8082296 */  lhu        $v0, 0x8B8($s1)
    /* A1F50 800B1750 00000000 */  nop
    /* A1F54 800B1754 80004230 */  andi       $v0, $v0, 0x80
    /* A1F58 800B1758 04004014 */  bnez       $v0, .L800B176C
    /* A1F5C 800B175C 80000224 */   addiu     $v0, $zero, 0x80
    /* A1F60 800B1760 B80822A6 */  sh         $v0, 0x8B8($s1)
    /* A1F64 800B1764 88000224 */  addiu      $v0, $zero, 0x88
    /* A1F68 800B1768 BA0822A6 */  sh         $v0, 0x8BA($s1)
  .L800B176C:
    /* A1F6C 800B176C 5C0E828F */  lw         $v0, %gp_rel(R3DCar_Clock)($gp)
    /* A1F70 800B1770 00000000 */  nop
    /* A1F74 800B1774 0F004010 */  beqz       $v0, .L800B17B4
    /* A1F78 800B1778 00000000 */   nop
    /* A1F7C 800B177C B8082396 */  lhu        $v1, 0x8B8($s1)
    /* A1F80 800B1780 00000000 */  nop
    /* A1F84 800B1784 80006230 */  andi       $v0, $v1, 0x80
    /* A1F88 800B1788 03004010 */  beqz       $v0, .L800B1798
    /* A1F8C 800B178C 01006224 */   addiu     $v0, $v1, 0x1
    /* A1F90 800B1790 8F004230 */  andi       $v0, $v0, 0x8F
    /* A1F94 800B1794 B80822A6 */  sh         $v0, 0x8B8($s1)
  .L800B1798:
    /* A1F98 800B1798 BA082396 */  lhu        $v1, 0x8BA($s1)
    /* A1F9C 800B179C 00000000 */  nop
    /* A1FA0 800B17A0 80006230 */  andi       $v0, $v1, 0x80
    /* A1FA4 800B17A4 03004010 */  beqz       $v0, .L800B17B4
    /* A1FA8 800B17A8 01006224 */   addiu     $v0, $v1, 0x1
    /* A1FAC 800B17AC 8F004230 */  andi       $v0, $v0, 0x8F
    /* A1FB0 800B17B0 BA0822A6 */  sh         $v0, 0x8BA($s1)
  .L800B17B4:
    /* A1FB4 800B17B4 0800E010 */  beqz       $a3, .L800B17D8
    /* A1FB8 800B17B8 33000224 */   addiu     $v0, $zero, 0x33
    /* A1FBC 800B17BC B40822A6 */  sh         $v0, 0x8B4($s1)
    /* A1FC0 800B17C0 02000224 */  addiu      $v0, $zero, 0x2
    /* A1FC4 800B17C4 F6C50208 */  j          .L800B17D8
    /* A1FC8 800B17C8 B60822A6 */   sh        $v0, 0x8B6($s1)
  .L800B17CC:
    /* A1FCC 800B17CC 0300E010 */  beqz       $a3, .L800B17DC
    /* A1FD0 800B17D0 1C00622A */   slti      $v0, $s3, 0x1C
    /* A1FD4 800B17D4 B60820A6 */  sh         $zero, 0x8B6($s1)
  .L800B17D8:
    /* A1FD8 800B17D8 1C00622A */  slti       $v0, $s3, 0x1C
  .L800B17DC:
    /* A1FDC 800B17DC 03004014 */  bnez       $v0, .L800B17EC
    /* A1FE0 800B17E0 00000000 */   nop
    /* A1FE4 800B17E4 03C60208 */  j          .L800B180C
    /* A1FE8 800B17E8 4001A0AF */   sw        $zero, 0x140($sp)
  .L800B17EC:
    /* A1FEC 800B17EC B3082292 */  lbu        $v0, 0x8B3($s1)
    /* A1FF0 800B17F0 00000000 */  nop
    /* A1FF4 800B17F4 02004230 */  andi       $v0, $v0, 0x2
    /* A1FF8 800B17F8 04004010 */  beqz       $v0, .L800B180C
    /* A1FFC 800B17FC 00000000 */   nop
    /* A2000 800B1800 D4082F8E */  lw         $t7, 0x8D4($s1)
    /* A2004 800B1804 00000000 */  nop
    /* A2008 800B1808 4001AFAF */  sw         $t7, 0x140($sp)
  .L800B180C:
    /* A200C 800B180C C2082286 */  lh         $v0, 0x8C2($s1)
    /* A2010 800B1810 00000000 */  nop
    /* A2014 800B1814 04004014 */  bnez       $v0, .L800B1828
    /* A2018 800B1818 1C00622A */   slti      $v0, $s3, 0x1C
    /* A201C 800B181C 02004014 */  bnez       $v0, .L800B1828
    /* A2020 800B1820 01000224 */   addiu     $v0, $zero, 0x1
    /* A2024 800B1824 C20822A6 */  sh         $v0, 0x8C2($s1)
  .L800B1828:
    /* A2028 800B1828 C2082386 */  lh         $v1, 0x8C2($s1)
    /* A202C 800B182C 02000224 */  addiu      $v0, $zero, 0x2
    /* A2030 800B1830 05006214 */  bne        $v1, $v0, .L800B1848
    /* A2034 800B1834 1C000224 */   addiu     $v0, $zero, 0x1C
    /* A2038 800B1838 03006216 */  bne        $s3, $v0, .L800B1848
    /* A203C 800B183C 01000224 */   addiu     $v0, $zero, 0x1
    /* A2040 800B1840 C20822A6 */  sh         $v0, 0x8C2($s1)
    /* A2044 800B1844 C2082386 */  lh         $v1, 0x8C2($s1)
  .L800B1848:
    /* A2048 800B1848 D80D828F */  lw         $v0, %gp_rel(R3DCar_InMenu)($gp)
    /* A204C 800B184C 00000000 */  nop
    /* A2050 800B1850 80004230 */  andi       $v0, $v0, 0x80
    /* A2054 800B1854 07004010 */  beqz       $v0, .L800B1874
    /* A2058 800B1858 02007224 */   addiu     $s2, $v1, 0x2
    /* A205C 800B185C 3801228E */  lw         $v0, 0x138($s1)
    /* A2060 800B1860 A400238E */  lw         $v1, 0xA4($s1)
    /* A2064 800B1864 40100200 */  sll        $v0, $v0, 1
    /* A2068 800B1868 23186200 */  subu       $v1, $v1, $v0
    /* A206C 800B186C 22C60208 */  j          .L800B1888
    /* A2070 800B1870 A40023AE */   sw        $v1, 0xA4($s1)
  .L800B1874:
    /* A2074 800B1874 A400228E */  lw         $v0, 0xA4($s1)
    /* A2078 800B1878 3801238E */  lw         $v1, 0x138($s1)
    /* A207C 800B187C 00000000 */  nop
    /* A2080 800B1880 21104300 */  addu       $v0, $v0, $v1
    /* A2084 800B1884 A40022AE */  sw         $v0, 0xA4($s1)
  .L800B1888:
    /* A2088 800B1888 A000238E */  lw         $v1, 0xA0($s1)
    /* A208C 800B188C 0800E28E */  lw         $v0, 0x8($s7)
    /* A2090 800B1890 00000000 */  nop
    /* A2094 800B1894 23286200 */  subu       $a1, $v1, $v0
    /* A2098 800B1898 C800A5AF */  sw         $a1, 0xC8($sp)
    /* A209C 800B189C A400238E */  lw         $v1, 0xA4($s1)
    /* A20A0 800B18A0 0C00E28E */  lw         $v0, 0xC($s7)
    /* A20A4 800B18A4 00000000 */  nop
    /* A20A8 800B18A8 23306200 */  subu       $a2, $v1, $v0
    /* A20AC 800B18AC CC00A6AF */  sw         $a2, 0xCC($sp)
    /* A20B0 800B18B0 A800238E */  lw         $v1, 0xA8($s1)
    /* A20B4 800B18B4 1000E28E */  lw         $v0, 0x10($s7)
    /* A20B8 800B18B8 2120A000 */  addu       $a0, $a1, $zero
    /* A20BC 800B18BC 23186200 */  subu       $v1, $v1, $v0
    /* A20C0 800B18C0 0200A104 */  bgez       $a1, .L800B18CC
    /* A20C4 800B18C4 D000A3AF */   sw        $v1, 0xD0($sp)
    /* A20C8 800B18C8 FF00A424 */  addiu      $a0, $a1, 0xFF
  .L800B18CC:
    /* A20CC 800B18CC F000228E */  lw         $v0, 0xF0($s1)
    /* A20D0 800B18D0 00000000 */  nop
    /* A20D4 800B18D4 02004104 */  bgez       $v0, .L800B18E0
    /* A20D8 800B18D8 034A0400 */   sra       $t1, $a0, 8
    /* A20DC 800B18DC FF004224 */  addiu      $v0, $v0, 0xFF
  .L800B18E0:
    /* A20E0 800B18E0 03120200 */  sra        $v0, $v0, 8
    /* A20E4 800B18E4 18002201 */  mult       $t1, $v0
    /* A20E8 800B18E8 12380000 */  mflo       $a3
    /* A20EC 800B18EC 0200C104 */  bgez       $a2, .L800B18F8
    /* A20F0 800B18F0 2120C000 */   addu      $a0, $a2, $zero
    /* A20F4 800B18F4 FF00C424 */  addiu      $a0, $a2, 0xFF
  .L800B18F8:
    /* A20F8 800B18F8 F400228E */  lw         $v0, 0xF4($s1)
    /* A20FC 800B18FC 00000000 */  nop
    /* A2100 800B1900 02004104 */  bgez       $v0, .L800B190C
    /* A2104 800B1904 03420400 */   sra       $t0, $a0, 8
    /* A2108 800B1908 FF004224 */  addiu      $v0, $v0, 0xFF
  .L800B190C:
    /* A210C 800B190C 03120200 */  sra        $v0, $v0, 8
    /* A2110 800B1910 18000201 */  mult       $t0, $v0
    /* A2114 800B1914 12680000 */  mflo       $t5
    /* A2118 800B1918 02006104 */  bgez       $v1, .L800B1924
    /* A211C 800B191C 2120ED00 */   addu      $a0, $a3, $t5
    /* A2120 800B1920 FF006324 */  addiu      $v1, $v1, 0xFF
  .L800B1924:
    /* A2124 800B1924 F800228E */  lw         $v0, 0xF8($s1)
    /* A2128 800B1928 00000000 */  nop
    /* A212C 800B192C 02004104 */  bgez       $v0, .L800B1938
    /* A2130 800B1930 031A0300 */   sra       $v1, $v1, 8
    /* A2134 800B1934 FF004224 */  addiu      $v0, $v0, 0xFF
  .L800B1938:
    /* A2138 800B1938 03120200 */  sra        $v0, $v0, 8
    /* A213C 800B193C 18006200 */  mult       $v1, $v0
    /* A2140 800B1940 12680000 */  mflo       $t5
    /* A2144 800B1944 21208D00 */  addu       $a0, $a0, $t5
    /* A2148 800B1948 D800A4AF */  sw         $a0, 0xD8($sp)
    /* A214C 800B194C 0801228E */  lw         $v0, 0x108($s1)
    /* A2150 800B1950 00000000 */  nop
    /* A2154 800B1954 02004104 */  bgez       $v0, .L800B1960
    /* A2158 800B1958 00000000 */   nop
    /* A215C 800B195C FF004224 */  addiu      $v0, $v0, 0xFF
  .L800B1960:
    /* A2160 800B1960 03120200 */  sra        $v0, $v0, 8
    /* A2164 800B1964 18002201 */  mult       $t1, $v0
    /* A2168 800B1968 12280000 */  mflo       $a1
    /* A216C 800B196C 0C01228E */  lw         $v0, 0x10C($s1)
    /* A2170 800B1970 00000000 */  nop
    /* A2174 800B1974 02004104 */  bgez       $v0, .L800B1980
    /* A2178 800B1978 00000000 */   nop
    /* A217C 800B197C FF004224 */  addiu      $v0, $v0, 0xFF
  .L800B1980:
    /* A2180 800B1980 03120200 */  sra        $v0, $v0, 8
    /* A2184 800B1984 18000201 */  mult       $t0, $v0
    /* A2188 800B1988 D000A68F */  lw         $a2, 0xD0($sp)
    /* A218C 800B198C 12680000 */  mflo       $t5
    /* A2190 800B1990 0200C104 */  bgez       $a2, .L800B199C
    /* A2194 800B1994 2128AD00 */   addu      $a1, $a1, $t5
    /* A2198 800B1998 FF00C624 */  addiu      $a2, $a2, 0xFF
  .L800B199C:
    /* A219C 800B199C 1001228E */  lw         $v0, 0x110($s1)
    /* A21A0 800B19A0 00000000 */  nop
    /* A21A4 800B19A4 02004104 */  bgez       $v0, .L800B19B0
    /* A21A8 800B19A8 03320600 */   sra       $a2, $a2, 8
    /* A21AC 800B19AC FF004224 */  addiu      $v0, $v0, 0xFF
  .L800B19B0:
    /* A21B0 800B19B0 03120200 */  sra        $v0, $v0, 8
    /* A21B4 800B19B4 1800C200 */  mult       $a2, $v0
    /* A21B8 800B19B8 12680000 */  mflo       $t5
    /* A21BC 800B19BC 2128AD00 */  addu       $a1, $a1, $t5
    /* A21C0 800B19C0 4AB5030C */  jal        fixedatan
    /* A21C4 800B19C4 E000A5AF */   sw        $a1, 0xE0($sp)
    /* A21C8 800B19C8 02004104 */  bgez       $v0, .L800B19D4
    /* A21CC 800B19CC F0003026 */   addiu     $s0, $s1, 0xF0
    /* A21D0 800B19D0 0F004224 */  addiu      $v0, $v0, 0xF
  .L800B19D4:
    /* A21D4 800B19D4 21200002 */  addu       $a0, $s0, $zero
    /* A21D8 800B19D8 03190200 */  sra        $v1, $v0, 4
    /* A21DC 800B19DC 00100224 */  addiu      $v0, $zero, 0x1000
    /* A21E0 800B19E0 23104300 */  subu       $v0, $v0, $v1
    /* A21E4 800B19E4 580E82A7 */  sh         $v0, %gp_rel(R3DCar_yawCam)($gp)
    /* A21E8 800B19E8 EABE020C */  jal        R3DCar_MATRIX3DT_Copy__FPiT0
    /* A21EC 800B19EC 2800A527 */   addiu     $a1, $sp, 0x28
    /* A21F0 800B19F0 21200002 */  addu       $a0, $s0, $zero
    /* A21F4 800B19F4 EABE020C */  jal        R3DCar_MATRIX3DT_Copy__FPiT0
    /* A21F8 800B19F8 7800A527 */   addiu     $a1, $sp, 0x78
    /* A21FC 800B19FC D80D828F */  lw         $v0, %gp_rel(R3DCar_InMenu)($gp)
    /* A2200 800B1A00 00000000 */  nop
    /* A2204 800B1A04 80004230 */  andi       $v0, $v0, 0x80
    /* A2208 800B1A08 0B004010 */  beqz       $v0, .L800B1A38
    /* A220C 800B1A0C 00000000 */   nop
    /* A2210 800B1A10 3400A28F */  lw         $v0, 0x34($sp)
    /* A2214 800B1A14 3C00A38F */  lw         $v1, 0x3C($sp)
    /* A2218 800B1A18 23100200 */  negu       $v0, $v0
    /* A221C 800B1A1C 3400A2AF */  sw         $v0, 0x34($sp)
    /* A2220 800B1A20 3800A28F */  lw         $v0, 0x38($sp)
    /* A2224 800B1A24 23180300 */  negu       $v1, $v1
    /* A2228 800B1A28 3C00A3AF */  sw         $v1, 0x3C($sp)
    /* A222C 800B1A2C 23100200 */  negu       $v0, $v0
    /* A2230 800B1A30 9BC60208 */  j          .L800B1A6C
    /* A2234 800B1A34 3800A2AF */   sw        $v0, 0x38($sp)
  .L800B1A38:
    /* A2238 800B1A38 4401AE8F */  lw         $t6, 0x144($sp)
    /* A223C 800B1A3C 00000000 */  nop
    /* A2240 800B1A40 0B00C011 */  beqz       $t6, .L800B1A70
    /* A2244 800B1A44 2800A427 */   addiu     $a0, $sp, 0x28
    /* A2248 800B1A48 7800A28F */  lw         $v0, 0x78($sp)
    /* A224C 800B1A4C 8000A38F */  lw         $v1, 0x80($sp)
    /* A2250 800B1A50 23100200 */  negu       $v0, $v0
    /* A2254 800B1A54 7800A2AF */  sw         $v0, 0x78($sp)
    /* A2258 800B1A58 7C00A28F */  lw         $v0, 0x7C($sp)
    /* A225C 800B1A5C 23180300 */  negu       $v1, $v1
    /* A2260 800B1A60 8000A3AF */  sw         $v1, 0x80($sp)
    /* A2264 800B1A64 23100200 */  negu       $v0, $v0
    /* A2268 800B1A68 7C00A2AF */  sw         $v0, 0x7C($sp)
  .L800B1A6C:
    /* A226C 800B1A6C 2800A427 */  addiu      $a0, $sp, 0x28
  .L800B1A70:
    /* A2270 800B1A70 4400F026 */  addiu      $s0, $s7, 0x44
    /* A2274 800B1A74 21280002 */  addu       $a1, $s0, $zero
    /* A2278 800B1A78 6377020C */  jal        Math_fasttransmult__FP10matrixtdefN20
    /* A227C 800B1A7C 5000A627 */   addiu     $a2, $sp, 0x50
    /* A2280 800B1A80 7800A427 */  addiu      $a0, $sp, 0x78
    /* A2284 800B1A84 21280002 */  addu       $a1, $s0, $zero
    /* A2288 800B1A88 6377020C */  jal        Math_fasttransmult__FP10matrixtdefN20
    /* A228C 800B1A8C A000A627 */   addiu     $a2, $sp, 0xA0
    /* A2290 800B1A90 1C00622A */  slti       $v0, $s3, 0x1C
    /* A2294 800B1A94 62004010 */  beqz       $v0, .L800B1C20
    /* A2298 800B1A98 21800000 */   addu      $s0, $zero, $zero
    /* A229C 800B1A9C 1180023C */  lui        $v0, %hi(R3DCar_ObjectInfo)
    /* A22A0 800B1AA0 E0654824 */  addiu      $t0, $v0, %lo(R3DCar_ObjectInfo)
    /* A22A4 800B1AA4 0580023C */  lui        $v0, %hi(jtbl_800564E0)
    /* A22A8 800B1AA8 E0644724 */  addiu      $a3, $v0, %lo(jtbl_800564E0)
    /* A22AC 800B1AAC 1180023C */  lui        $v0, %hi(R3DCar_ObjectVisible)
    /* A22B0 800B1AB0 AC684624 */  addiu      $a2, $v0, %lo(R3DCar_ObjectVisible)
    /* A22B4 800B1AB4 21184002 */  addu       $v1, $s2, $zero
  .L800B1AB8:
    /* A22B8 800B1AB8 3900022A */  slti       $v0, $s0, 0x39
    /* A22BC 800B1ABC 7E004010 */  beqz       $v0, .L800B1CB8
    /* A22C0 800B1AC0 21106800 */   addu      $v0, $v1, $t0
    /* A22C4 800B1AC4 00004290 */  lbu        $v0, 0x0($v0)
    /* A22C8 800B1AC8 00000000 */  nop
    /* A22CC 800B1ACC 00160200 */  sll        $v0, $v0, 24
    /* A22D0 800B1AD0 032E0200 */  sra        $a1, $v0, 24
    /* A22D4 800B1AD4 FEFFA224 */  addiu      $v0, $a1, -0x2
    /* A22D8 800B1AD8 00140200 */  sll        $v0, $v0, 16
    /* A22DC 800B1ADC 03240200 */  sra        $a0, $v0, 16
    /* A22E0 800B1AE0 1500822C */  sltiu      $v0, $a0, 0x15
    /* A22E4 800B1AE4 49004010 */  beqz       $v0, .L800B1C0C
    /* A22E8 800B1AE8 80100400 */   sll       $v0, $a0, 2
    /* A22EC 800B1AEC 21104700 */  addu       $v0, $v0, $a3
    /* A22F0 800B1AF0 0000428C */  lw         $v0, 0x0($v0)
    /* A22F4 800B1AF4 00000000 */  nop
    /* A22F8 800B1AF8 08004000 */  jr         $v0
    /* A22FC 800B1AFC 00000000 */   nop
  jlabel .L800B1B00
    /* A2300 800B1B00 C0082296 */  lhu        $v0, 0x8C0($s1)
    /* A2304 800B1B04 00000000 */  nop
    /* A2308 800B1B08 01004230 */  andi       $v0, $v0, 0x1
    /* A230C 800B1B0C 3E004014 */  bnez       $v0, .L800B1C08
    /* A2310 800B1B10 00000000 */   nop
  jlabel .L800B1B14
    /* A2314 800B1B14 D80D828F */  lw         $v0, %gp_rel(R3DCar_InMenu)($gp)
    /* A2318 800B1B18 00000000 */  nop
    /* A231C 800B1B1C 80004230 */  andi       $v0, $v0, 0x80
    /* A2320 800B1B20 3B004010 */  beqz       $v0, .L800B1C10
    /* A2324 800B1B24 21100602 */   addu      $v0, $s0, $a2
    /* A2328 800B1B28 04C70208 */  j          .L800B1C10
    /* A232C 800B1B2C 21280000 */   addu      $a1, $zero, $zero
  jlabel .L800B1B30
    /* A2330 800B1B30 C0082296 */  lhu        $v0, 0x8C0($s1)
    /* A2334 800B1B34 00000000 */  nop
    /* A2338 800B1B38 01004230 */  andi       $v0, $v0, 0x1
  .L800B1B3C:
    /* A233C 800B1B3C 34004010 */  beqz       $v0, .L800B1C10
    /* A2340 800B1B40 21100602 */   addu      $v0, $s0, $a2
    /* A2344 800B1B44 04C70208 */  j          .L800B1C10
    /* A2348 800B1B48 21280000 */   addu      $a1, $zero, $zero
  jlabel .L800B1B4C
    /* A234C 800B1B4C B3082292 */  lbu        $v0, 0x8B3($s1)
    /* A2350 800B1B50 00000000 */  nop
    /* A2354 800B1B54 04004230 */  andi       $v0, $v0, 0x4
    /* A2358 800B1B58 2D004010 */  beqz       $v0, .L800B1C10
    /* A235C 800B1B5C 21100602 */   addu      $v0, $s0, $a2
    /* A2360 800B1B60 04C70208 */  j          .L800B1C10
    /* A2364 800B1B64 21280000 */   addu      $a1, $zero, $zero
  jlabel .L800B1B68
    /* A2368 800B1B68 B3082292 */  lbu        $v0, 0x8B3($s1)
    /* A236C 800B1B6C 00000000 */  nop
    /* A2370 800B1B70 04004230 */  andi       $v0, $v0, 0x4
    /* A2374 800B1B74 26004014 */  bnez       $v0, .L800B1C10
    /* A2378 800B1B78 21100602 */   addu      $v0, $s0, $a2
    /* A237C 800B1B7C 04C70208 */  j          .L800B1C10
    /* A2380 800B1B80 21280000 */   addu      $a1, $zero, $zero
  jlabel .L800B1B84
    /* A2384 800B1B84 B4082296 */  lhu        $v0, 0x8B4($s1)
    /* A2388 800B1B88 00000000 */  nop
    /* A238C 800B1B8C 02004230 */  andi       $v0, $v0, 0x2
    /* A2390 800B1B90 1F004014 */  bnez       $v0, .L800B1C10
    /* A2394 800B1B94 21100602 */   addu      $v0, $s0, $a2
    /* A2398 800B1B98 04C70208 */  j          .L800B1C10
    /* A239C 800B1B9C 21280000 */   addu      $a1, $zero, $zero
  jlabel .L800B1BA0
    /* A23A0 800B1BA0 B4082296 */  lhu        $v0, 0x8B4($s1)
    /* A23A4 800B1BA4 00000000 */  nop
    /* A23A8 800B1BA8 20004230 */  andi       $v0, $v0, 0x20
    /* A23AC 800B1BAC 18004014 */  bnez       $v0, .L800B1C10
    /* A23B0 800B1BB0 21100602 */   addu      $v0, $s0, $a2
    /* A23B4 800B1BB4 04C70208 */  j          .L800B1C10
    /* A23B8 800B1BB8 21280000 */   addu      $a1, $zero, $zero
  jlabel .L800B1BBC
    /* A23BC 800B1BBC B4082296 */  lhu        $v0, 0x8B4($s1)
    /* A23C0 800B1BC0 00000000 */  nop
    /* A23C4 800B1BC4 11004230 */  andi       $v0, $v0, 0x11
    /* A23C8 800B1BC8 11004014 */  bnez       $v0, .L800B1C10
    /* A23CC 800B1BCC 21100602 */   addu      $v0, $s0, $a2
    /* A23D0 800B1BD0 04C70208 */  j          .L800B1C10
    /* A23D4 800B1BD4 21280000 */   addu      $a1, $zero, $zero
  jlabel .L800B1BD8
    /* A23D8 800B1BD8 B3082292 */  lbu        $v0, 0x8B3($s1)
    /* A23DC 800B1BDC 00000000 */  nop
    /* A23E0 800B1BE0 01004230 */  andi       $v0, $v0, 0x1
    /* A23E4 800B1BE4 0A004014 */  bnez       $v0, .L800B1C10
    /* A23E8 800B1BE8 21100602 */   addu      $v0, $s0, $a2
    /* A23EC 800B1BEC 04C70208 */  j          .L800B1C10
    /* A23F0 800B1BF0 21280000 */   addu      $a1, $zero, $zero
  jlabel .L800B1BF4
    /* A23F4 800B1BF4 B3082292 */  lbu        $v0, 0x8B3($s1)
    /* A23F8 800B1BF8 CFC60208 */  j          .L800B1B3C
    /* A23FC 800B1BFC 01004230 */   andi      $v0, $v0, 0x1
  jlabel .L800B1C00
    /* A2400 800B1C00 03008016 */  bnez       $s4, .L800B1C10
    /* A2404 800B1C04 21100602 */   addu      $v0, $s0, $a2
  jlabel .L800B1C08
    /* A2408 800B1C08 21280000 */  addu       $a1, $zero, $zero
  jlabel .L800B1C0C
    /* A240C 800B1C0C 21100602 */  addu       $v0, $s0, $a2
  .L800B1C10:
    /* A2410 800B1C10 000045A0 */  sb         $a1, 0x0($v0)
    /* A2414 800B1C14 06006324 */  addiu      $v1, $v1, 0x6
    /* A2418 800B1C18 AEC60208 */  j          .L800B1AB8
    /* A241C 800B1C1C 01001026 */   addiu     $s0, $s0, 0x1
  .L800B1C20:
    /* A2420 800B1C20 1180023C */  lui        $v0, %hi(R3DCar_ObjectInfo)
    /* A2424 800B1C24 E0654C24 */  addiu      $t4, $v0, %lo(R3DCar_ObjectInfo)
    /* A2428 800B1C28 12000B24 */  addiu      $t3, $zero, 0x12
    /* A242C 800B1C2C 01000A24 */  addiu      $t2, $zero, 0x1
    /* A2430 800B1C30 16000924 */  addiu      $t1, $zero, 0x16
    /* A2434 800B1C34 1C000824 */  addiu      $t0, $zero, 0x1C
    /* A2438 800B1C38 20000724 */  addiu      $a3, $zero, 0x20
    /* A243C 800B1C3C 1180023C */  lui        $v0, %hi(R3DCar_ObjectVisible)
    /* A2440 800B1C40 AC684624 */  addiu      $a2, $v0, %lo(R3DCar_ObjectVisible)
    /* A2444 800B1C44 21184002 */  addu       $v1, $s2, $zero
  .L800B1C48:
    /* A2448 800B1C48 3900022A */  slti       $v0, $s0, 0x39
    /* A244C 800B1C4C 1A004010 */  beqz       $v0, .L800B1CB8
    /* A2450 800B1C50 21106C00 */   addu      $v0, $v1, $t4
    /* A2454 800B1C54 00004290 */  lbu        $v0, 0x0($v0)
    /* A2458 800B1C58 00000000 */  nop
    /* A245C 800B1C5C 00160200 */  sll        $v0, $v0, 24
    /* A2460 800B1C60 032E0200 */  sra        $a1, $v0, 24
    /* A2464 800B1C64 2120A000 */  addu       $a0, $a1, $zero
    /* A2468 800B1C68 0A008B10 */  beq        $a0, $t3, .L800B1C94
    /* A246C 800B1C6C 13008228 */   slti      $v0, $a0, 0x13
    /* A2470 800B1C70 05004010 */  beqz       $v0, .L800B1C88
    /* A2474 800B1C74 00000000 */   nop
    /* A2478 800B1C78 06008A10 */  beq        $a0, $t2, .L800B1C94
    /* A247C 800B1C7C 00000000 */   nop
    /* A2480 800B1C80 25C70208 */  j          .L800B1C94
    /* A2484 800B1C84 21280000 */   addu      $a1, $zero, $zero
  .L800B1C88:
    /* A2488 800B1C88 02008910 */  beq        $a0, $t1, .L800B1C94
    /* A248C 800B1C8C 00000000 */   nop
    /* A2490 800B1C90 21280000 */  addu       $a1, $zero, $zero
  .L800B1C94:
    /* A2494 800B1C94 04006816 */  bne        $s3, $t0, .L800B1CA8
    /* A2498 800B1C98 21100602 */   addu      $v0, $s0, $a2
    /* A249C 800B1C9C 02000716 */  bne        $s0, $a3, .L800B1CA8
    /* A24A0 800B1CA0 00000000 */   nop
    /* A24A4 800B1CA4 01000524 */  addiu      $a1, $zero, 0x1
  .L800B1CA8:
    /* A24A8 800B1CA8 000045A0 */  sb         $a1, 0x0($v0)
    /* A24AC 800B1CAC 06006324 */  addiu      $v1, $v1, 0x6
    /* A24B0 800B1CB0 12C70208 */  j          .L800B1C48
    /* A24B4 800B1CB4 01001026 */   addiu     $s0, $s0, 0x1
  .L800B1CB8:
    /* A24B8 800B1CB8 1180033C */  lui        $v1, %hi(R3DCar_LoadedScenePointer)
    /* A24BC 800B1CBC 08696324 */  addiu      $v1, $v1, %lo(R3DCar_LoadedScenePointer)
    /* A24C0 800B1CC0 80201300 */  sll        $a0, $s3, 2
    /* A24C4 800B1CC4 40101500 */  sll        $v0, $s5, 1
    /* A24C8 800B1CC8 21105500 */  addu       $v0, $v0, $s5
    /* A24CC 800B1CCC C0100200 */  sll        $v0, $v0, 3
    /* A24D0 800B1CD0 21105500 */  addu       $v0, $v0, $s5
    /* A24D4 800B1CD4 C0100200 */  sll        $v0, $v0, 3
    /* A24D8 800B1CD8 21108200 */  addu       $v0, $a0, $v0
    /* A24DC 800B1CDC 21104300 */  addu       $v0, $v0, $v1
    /* A24E0 800B1CE0 0000428C */  lw         $v0, 0x0($v0)
    /* A24E4 800B1CE4 21800000 */  addu       $s0, $zero, $zero
    /* A24E8 800B1CE8 0000458C */  lw         $a1, 0x0($v0)
    /* A24EC 800B1CEC 21F06000 */  addu       $fp, $v1, $zero
    /* A24F0 800B1CF0 0400A28C */  lw         $v0, 0x4($a1)
    /* A24F4 800B1CF4 21B08000 */  addu       $s6, $a0, $zero
    /* A24F8 800B1CF8 1800A2AF */  sw         $v0, 0x18($sp)
    /* A24FC 800B1CFC 0800A28C */  lw         $v0, 0x8($a1)
    /* A2500 800B1D00 21900002 */  addu       $s2, $s0, $zero
    /* A2504 800B1D04 1C00A2AF */  sw         $v0, 0x1C($sp)
    /* A2508 800B1D08 0C00A28C */  lw         $v0, 0xC($a1)
    /* A250C 800B1D0C 21A00002 */  addu       $s4, $s0, $zero
    /* A2510 800B1D10 2000A2AF */  sw         $v0, 0x20($sp)
  .L800B1D14:
    /* A2514 800B1D14 3900022A */  slti       $v0, $s0, 0x39
    /* A2518 800B1D18 64004010 */  beqz       $v0, .L800B1EAC
    /* A251C 800B1D1C 40101500 */   sll       $v0, $s5, 1
    /* A2520 800B1D20 21105500 */  addu       $v0, $v0, $s5
    /* A2524 800B1D24 C0100200 */  sll        $v0, $v0, 3
    /* A2528 800B1D28 21105500 */  addu       $v0, $v0, $s5
    /* A252C 800B1D2C C0100200 */  sll        $v0, $v0, 3
    /* A2530 800B1D30 2110C202 */  addu       $v0, $s6, $v0
    /* A2534 800B1D34 21105E00 */  addu       $v0, $v0, $fp
    /* A2538 800B1D38 0000428C */  lw         $v0, 0x0($v0)
    /* A253C 800B1D3C 80181000 */  sll        $v1, $s0, 2
    /* A2540 800B1D40 21104300 */  addu       $v0, $v0, $v1
    /* A2544 800B1D44 0000458C */  lw         $a1, 0x0($v0)
    /* A2548 800B1D48 00000000 */  nop
    /* A254C 800B1D4C 0200A294 */  lhu        $v0, 0x2($a1)
    /* A2550 800B1D50 00000000 */  nop
    /* A2554 800B1D54 51004010 */  beqz       $v0, .L800B1E9C
    /* A2558 800B1D58 1180023C */   lui       $v0, %hi(R3DCar_ObjectVisible)
    /* A255C 800B1D5C AC684224 */  addiu      $v0, $v0, %lo(R3DCar_ObjectVisible)
    /* A2560 800B1D60 21100202 */  addu       $v0, $s0, $v0
    /* A2564 800B1D64 00004290 */  lbu        $v0, 0x0($v0)
    /* A2568 800B1D68 00000000 */  nop
    /* A256C 800B1D6C 4B004010 */  beqz       $v0, .L800B1E9C
    /* A2570 800B1D70 0F000224 */   addiu     $v0, $zero, 0xF
    /* A2574 800B1D74 03000212 */  beq        $s0, $v0, .L800B1D84
    /* A2578 800B1D78 2F00022A */   slti      $v0, $s0, 0x2F
    /* A257C 800B1D7C 03004014 */  bnez       $v0, .L800B1D8C
    /* A2580 800B1D80 00000000 */   nop
  .L800B1D84:
    /* A2584 800B1D84 64C70208 */  j          .L800B1D90
    /* A2588 800B1D88 21200000 */   addu      $a0, $zero, $zero
  .L800B1D8C:
    /* A258C 800B1D8C 4001A48F */  lw         $a0, 0x140($sp)
  .L800B1D90:
    /* A2590 800B1D90 0400A28C */  lw         $v0, 0x4($a1)
    /* A2594 800B1D94 1800A38F */  lw         $v1, 0x18($sp)
    /* A2598 800B1D98 00000000 */  nop
    /* A259C 800B1D9C 23104300 */  subu       $v0, $v0, $v1
    /* A25A0 800B1DA0 D800A2AF */  sw         $v0, 0xD8($sp)
    /* A25A4 800B1DA4 0800A28C */  lw         $v0, 0x8($a1)
    /* A25A8 800B1DA8 1C00A38F */  lw         $v1, 0x1C($sp)
    /* A25AC 800B1DAC 00000000 */  nop
    /* A25B0 800B1DB0 23104300 */  subu       $v0, $v0, $v1
    /* A25B4 800B1DB4 23104400 */  subu       $v0, $v0, $a0
    /* A25B8 800B1DB8 DC00A2AF */  sw         $v0, 0xDC($sp)
    /* A25BC 800B1DBC 0C00A28C */  lw         $v0, 0xC($a1)
    /* A25C0 800B1DC0 2000A38F */  lw         $v1, 0x20($sp)
    /* A25C4 800B1DC4 00000000 */  nop
    /* A25C8 800B1DC8 23104300 */  subu       $v0, $v0, $v1
    /* A25CC 800B1DCC E000A2AF */  sw         $v0, 0xE0($sp)
    /* A25D0 800B1DD0 1C00622A */  slti       $v0, $s3, 0x1C
    /* A25D4 800B1DD4 08004010 */  beqz       $v0, .L800B1DF8
    /* A25D8 800B1DD8 2300022A */   slti      $v0, $s0, 0x23
    /* A25DC 800B1DDC 07004014 */  bnez       $v0, .L800B1DFC
    /* A25E0 800B1DE0 D800A427 */   addiu     $a0, $sp, 0xD8
    /* A25E4 800B1DE4 2900022A */  slti       $v0, $s0, 0x29
    /* A25E8 800B1DE8 04004010 */  beqz       $v0, .L800B1DFC
    /* A25EC 800B1DEC 7800A527 */   addiu     $a1, $sp, 0x78
    /* A25F0 800B1DF0 80C70208 */  j          .L800B1E00
    /* A25F4 800B1DF4 00000000 */   nop
  .L800B1DF8:
    /* A25F8 800B1DF8 D800A427 */  addiu      $a0, $sp, 0xD8
  .L800B1DFC:
    /* A25FC 800B1DFC 2800A527 */  addiu      $a1, $sp, 0x28
  .L800B1E00:
    /* A2600 800B1E00 B6AB030C */  jal        transform
    /* A2604 800B1E04 C800A627 */   addiu     $a2, $sp, 0xC8
    /* A2608 800B1E08 D800A427 */  addiu      $a0, $sp, 0xD8
    /* A260C 800B1E0C 4400E526 */  addiu      $a1, $s7, 0x44
    /* A2610 800B1E10 400E868F */  lw         $a2, %gp_rel(R3DCar_position)($gp)
    /* A2614 800B1E14 A000228E */  lw         $v0, 0xA0($s1)
    /* A2618 800B1E18 C800A38F */  lw         $v1, 0xC8($sp)
    /* A261C 800B1E1C 0800E78E */  lw         $a3, 0x8($s7)
    /* A2620 800B1E20 2130D400 */  addu       $a2, $a2, $s4
    /* A2624 800B1E24 21104300 */  addu       $v0, $v0, $v1
    /* A2628 800B1E28 23104700 */  subu       $v0, $v0, $a3
    /* A262C 800B1E2C D800A2AF */  sw         $v0, 0xD8($sp)
    /* A2630 800B1E30 A400228E */  lw         $v0, 0xA4($s1)
    /* A2634 800B1E34 CC00A38F */  lw         $v1, 0xCC($sp)
    /* A2638 800B1E38 0C00E78E */  lw         $a3, 0xC($s7)
    /* A263C 800B1E3C 21104300 */  addu       $v0, $v0, $v1
    /* A2640 800B1E40 23104700 */  subu       $v0, $v0, $a3
    /* A2644 800B1E44 DC00A2AF */  sw         $v0, 0xDC($sp)
    /* A2648 800B1E48 A800228E */  lw         $v0, 0xA8($s1)
    /* A264C 800B1E4C D000A38F */  lw         $v1, 0xD0($sp)
    /* A2650 800B1E50 1000E78E */  lw         $a3, 0x10($s7)
    /* A2654 800B1E54 21104300 */  addu       $v0, $v0, $v1
    /* A2658 800B1E58 23104700 */  subu       $v0, $v0, $a3
    /* A265C 800B1E5C B6AB030C */  jal        transform
    /* A2660 800B1E60 E000A2AF */   sw        $v0, 0xE0($sp)
    /* A2664 800B1E64 1C00622A */  slti       $v0, $s3, 0x1C
    /* A2668 800B1E68 08004010 */  beqz       $v0, .L800B1E8C
    /* A266C 800B1E6C 2300022A */   slti      $v0, $s0, 0x23
    /* A2670 800B1E70 06004014 */  bnez       $v0, .L800B1E8C
    /* A2674 800B1E74 2900022A */   slti      $v0, $s0, 0x29
    /* A2678 800B1E78 04004010 */  beqz       $v0, .L800B1E8C
    /* A267C 800B1E7C A000A427 */   addiu     $a0, $sp, 0xA0
    /* A2680 800B1E80 3C0E858F */  lw         $a1, %gp_rel(R3DCar_orientMat)($gp)
    /* A2684 800B1E84 A5C70208 */  j          .L800B1E94
    /* A2688 800B1E88 00000000 */   nop
  .L800B1E8C:
    /* A268C 800B1E8C 3C0E858F */  lw         $a1, %gp_rel(R3DCar_orientMat)($gp)
    /* A2690 800B1E90 5000A427 */  addiu      $a0, $sp, 0x50
  .L800B1E94:
    /* A2694 800B1E94 EABE020C */  jal        R3DCar_MATRIX3DT_Copy__FPiT0
    /* A2698 800B1E98 2128B200 */   addu      $a1, $a1, $s2
  .L800B1E9C:
    /* A269C 800B1E9C 24005226 */  addiu      $s2, $s2, 0x24
    /* A26A0 800B1EA0 0C009426 */  addiu      $s4, $s4, 0xC
    /* A26A4 800B1EA4 45C70208 */  j          .L800B1D14
    /* A26A8 800B1EA8 01001026 */   addiu     $s0, $s0, 0x1
  .L800B1EAC:
    /* A26AC 800B1EAC 4400E426 */  addiu      $a0, $s7, 0x44
    /* A26B0 800B1EB0 3800E526 */  addiu      $a1, $s7, 0x38
    /* A26B4 800B1EB4 01000624 */  addiu      $a2, $zero, 0x1
    /* A26B8 800B1EB8 A0002726 */  addiu      $a3, $s1, 0xA0
    /* A26BC 800B1EBC 1480023C */  lui        $v0, %hi(R3DCar_center)
    /* A26C0 800B1EC0 90D34224 */  addiu      $v0, $v0, %lo(R3DCar_center)
    /* A26C4 800B1EC4 3887030C */  jal        TrsProj_TransformProjectVertex__FP10matrixtdefP8coorddefiT1P12Draw_tVertex
    /* A26C8 800B1EC8 1000A2AF */   sw        $v0, 0x10($sp)
    /* A26CC 800B1ECC D80D828F */  lw         $v0, %gp_rel(R3DCar_InMenu)($gp)
    /* A26D0 800B1ED0 00000000 */  nop
    /* A26D4 800B1ED4 80004230 */  andi       $v0, $v0, 0x80
    /* A26D8 800B1ED8 9A004014 */  bnez       $v0, .L800B2144
    /* A26DC 800B1EDC 00000000 */   nop
    /* A26E0 800B1EE0 34012F8E */  lw         $t7, 0x134($s1)
    /* A26E4 800B1EE4 3801388E */  lw         $t8, 0x138($s1)
    /* A26E8 800B1EE8 3C012D8E */  lw         $t5, 0x13C($s1)
    /* A26EC 800B1EEC 1801AFAF */  sw         $t7, 0x118($sp)
    /* A26F0 800B1EF0 1C01B8AF */  sw         $t8, 0x11C($sp)
    /* A26F4 800B1EF4 2001ADAF */  sw         $t5, 0x120($sp)
    /* A26F8 800B1EF8 2001A48F */  lw         $a0, 0x120($sp)
    /* A26FC 800B1EFC 0801258E */  lw         $a1, 0x108($s1)
    /* A2700 800B1F00 CA90030C */  jal        fixedmult
    /* A2704 800B1F04 00000000 */   nop
    /* A2708 800B1F08 2001A48F */  lw         $a0, 0x120($sp)
    /* A270C 800B1F0C C800A2AF */  sw         $v0, 0xC8($sp)
    /* A2710 800B1F10 0C01258E */  lw         $a1, 0x10C($s1)
    /* A2714 800B1F14 CA90030C */  jal        fixedmult
    /* A2718 800B1F18 00000000 */   nop
    /* A271C 800B1F1C 2001A48F */  lw         $a0, 0x120($sp)
    /* A2720 800B1F20 CC00A2AF */  sw         $v0, 0xCC($sp)
    /* A2724 800B1F24 1001258E */  lw         $a1, 0x110($s1)
    /* A2728 800B1F28 CA90030C */  jal        fixedmult
    /* A272C 800B1F2C 00000000 */   nop
    /* A2730 800B1F30 1801A48F */  lw         $a0, 0x118($sp)
    /* A2734 800B1F34 D000A2AF */  sw         $v0, 0xD0($sp)
    /* A2738 800B1F38 F000258E */  lw         $a1, 0xF0($s1)
    /* A273C 800B1F3C CA90030C */  jal        fixedmult
    /* A2740 800B1F40 00000000 */   nop
    /* A2744 800B1F44 1801A48F */  lw         $a0, 0x118($sp)
    /* A2748 800B1F48 D800A2AF */  sw         $v0, 0xD8($sp)
    /* A274C 800B1F4C F400258E */  lw         $a1, 0xF4($s1)
    /* A2750 800B1F50 CA90030C */  jal        fixedmult
    /* A2754 800B1F54 00000000 */   nop
    /* A2758 800B1F58 1801A48F */  lw         $a0, 0x118($sp)
    /* A275C 800B1F5C DC00A2AF */  sw         $v0, 0xDC($sp)
    /* A2760 800B1F60 F800258E */  lw         $a1, 0xF8($s1)
    /* A2764 800B1F64 CA90030C */  jal        fixedmult
    /* A2768 800B1F68 00000000 */   nop
    /* A276C 800B1F6C 21204000 */  addu       $a0, $v0, $zero
    /* A2770 800B1F70 E000A2AF */  sw         $v0, 0xE0($sp)
    /* A2774 800B1F74 BC082386 */  lh         $v1, 0x8BC($s1)
    /* A2778 800B1F78 14000224 */  addiu      $v0, $zero, 0x14
    /* A277C 800B1F7C 13006214 */  bne        $v1, $v0, .L800B1FCC
    /* A2780 800B1F80 00000000 */   nop
    /* A2784 800B1F84 1801A28F */  lw         $v0, 0x118($sp)
    /* A2788 800B1F88 F000258E */  lw         $a1, 0xF0($s1)
    /* A278C 800B1F8C 40800200 */  sll        $s0, $v0, 1
    /* A2790 800B1F90 21800202 */  addu       $s0, $s0, $v0
    /* A2794 800B1F94 80811000 */  sll        $s0, $s0, 6
    /* A2798 800B1F98 03821000 */  sra        $s0, $s0, 8
    /* A279C 800B1F9C CA90030C */  jal        fixedmult
    /* A27A0 800B1FA0 21200002 */   addu      $a0, $s0, $zero
    /* A27A4 800B1FA4 E800A2AF */  sw         $v0, 0xE8($sp)
    /* A27A8 800B1FA8 F400258E */  lw         $a1, 0xF4($s1)
    /* A27AC 800B1FAC CA90030C */  jal        fixedmult
    /* A27B0 800B1FB0 21200002 */   addu      $a0, $s0, $zero
    /* A27B4 800B1FB4 EC00A2AF */  sw         $v0, 0xEC($sp)
    /* A27B8 800B1FB8 F800258E */  lw         $a1, 0xF8($s1)
    /* A27BC 800B1FBC CA90030C */  jal        fixedmult
    /* A27C0 800B1FC0 21200002 */   addu      $a0, $s0, $zero
    /* A27C4 800B1FC4 F8C70208 */  j          .L800B1FE0
    /* A27C8 800B1FC8 F000A2AF */   sw        $v0, 0xF0($sp)
  .L800B1FCC:
    /* A27CC 800B1FCC D800A28F */  lw         $v0, 0xD8($sp)
    /* A27D0 800B1FD0 DC00A38F */  lw         $v1, 0xDC($sp)
    /* A27D4 800B1FD4 F000A4AF */  sw         $a0, 0xF0($sp)
    /* A27D8 800B1FD8 E800A2AF */  sw         $v0, 0xE8($sp)
    /* A27DC 800B1FDC EC00A3AF */  sw         $v1, 0xEC($sp)
  .L800B1FE0:
    /* A27E0 800B1FE0 A0002F8E */  lw         $t7, 0xA0($s1)
    /* A27E4 800B1FE4 A400388E */  lw         $t8, 0xA4($s1)
    /* A27E8 800B1FE8 A8002D8E */  lw         $t5, 0xA8($s1)
    /* A27EC 800B1FEC F800AFAF */  sw         $t7, 0xF8($sp)
    /* A27F0 800B1FF0 FC00B8AF */  sw         $t8, 0xFC($sp)
    /* A27F4 800B1FF4 0001ADAF */  sw         $t5, 0x100($sp)
    /* A27F8 800B1FF8 F800A38F */  lw         $v1, 0xF8($sp)
    /* A27FC 800B1FFC C800A28F */  lw         $v0, 0xC8($sp)
    /* A2800 800B2000 CC00A48F */  lw         $a0, 0xCC($sp)
    /* A2804 800B2004 E800A58F */  lw         $a1, 0xE8($sp)
    /* A2808 800B2008 21186200 */  addu       $v1, $v1, $v0
    /* A280C 800B200C 0001A28F */  lw         $v0, 0x100($sp)
    /* A2810 800B2010 0C01A4AF */  sw         $a0, 0x10C($sp)
    /* A2814 800B2014 D000A48F */  lw         $a0, 0xD0($sp)
    /* A2818 800B2018 FC00A0AF */  sw         $zero, 0xFC($sp)
    /* A281C 800B201C 0801A3AF */  sw         $v1, 0x108($sp)
    /* A2820 800B2020 23186500 */  subu       $v1, $v1, $a1
    /* A2824 800B2024 21104400 */  addu       $v0, $v0, $a0
    /* A2828 800B2028 1001A2AF */  sw         $v0, 0x110($sp)
    /* A282C 800B202C E80123AE */  sw         $v1, 0x1E8($s1)
    /* A2830 800B2030 0C01A28F */  lw         $v0, 0x10C($sp)
    /* A2834 800B2034 EC00A38F */  lw         $v1, 0xEC($sp)
    /* A2838 800B2038 00000000 */  nop
    /* A283C 800B203C 23104300 */  subu       $v0, $v0, $v1
    /* A2840 800B2040 EC0122AE */  sw         $v0, 0x1EC($s1)
    /* A2844 800B2044 1001A28F */  lw         $v0, 0x110($sp)
    /* A2848 800B2048 F000A38F */  lw         $v1, 0xF0($sp)
    /* A284C 800B204C 00000000 */  nop
    /* A2850 800B2050 23104300 */  subu       $v0, $v0, $v1
    /* A2854 800B2054 F00122AE */  sw         $v0, 0x1F0($s1)
    /* A2858 800B2058 0801A28F */  lw         $v0, 0x108($sp)
    /* A285C 800B205C E800A38F */  lw         $v1, 0xE8($sp)
    /* A2860 800B2060 00000000 */  nop
    /* A2864 800B2064 21104300 */  addu       $v0, $v0, $v1
    /* A2868 800B2068 F40122AE */  sw         $v0, 0x1F4($s1)
    /* A286C 800B206C 0C01A28F */  lw         $v0, 0x10C($sp)
    /* A2870 800B2070 EC00A38F */  lw         $v1, 0xEC($sp)
    /* A2874 800B2074 00000000 */  nop
    /* A2878 800B2078 21104300 */  addu       $v0, $v0, $v1
    /* A287C 800B207C F80122AE */  sw         $v0, 0x1F8($s1)
    /* A2880 800B2080 1001A28F */  lw         $v0, 0x110($sp)
    /* A2884 800B2084 F000A38F */  lw         $v1, 0xF0($sp)
    /* A2888 800B2088 00000000 */  nop
    /* A288C 800B208C 21104300 */  addu       $v0, $v0, $v1
    /* A2890 800B2090 FC0122AE */  sw         $v0, 0x1FC($s1)
    /* A2894 800B2094 F800A38F */  lw         $v1, 0xF8($sp)
    /* A2898 800B2098 C800A48F */  lw         $a0, 0xC8($sp)
    /* A289C 800B209C FC00A28F */  lw         $v0, 0xFC($sp)
    /* A28A0 800B20A0 CC00A58F */  lw         $a1, 0xCC($sp)
    /* A28A4 800B20A4 23186400 */  subu       $v1, $v1, $a0
    /* A28A8 800B20A8 23104500 */  subu       $v0, $v0, $a1
    /* A28AC 800B20AC 0801A3AF */  sw         $v1, 0x108($sp)
    /* A28B0 800B20B0 0C01A2AF */  sw         $v0, 0x10C($sp)
    /* A28B4 800B20B4 0001A28F */  lw         $v0, 0x100($sp)
    /* A28B8 800B20B8 D000A48F */  lw         $a0, 0xD0($sp)
    /* A28BC 800B20BC D800A58F */  lw         $a1, 0xD8($sp)
    /* A28C0 800B20C0 23104400 */  subu       $v0, $v0, $a0
    /* A28C4 800B20C4 23186500 */  subu       $v1, $v1, $a1
    /* A28C8 800B20C8 1001A2AF */  sw         $v0, 0x110($sp)
    /* A28CC 800B20CC 000223AE */  sw         $v1, 0x200($s1)
    /* A28D0 800B20D0 0C01A28F */  lw         $v0, 0x10C($sp)
    /* A28D4 800B20D4 DC00A38F */  lw         $v1, 0xDC($sp)
    /* A28D8 800B20D8 00000000 */  nop
    /* A28DC 800B20DC 23104300 */  subu       $v0, $v0, $v1
    /* A28E0 800B20E0 040222AE */  sw         $v0, 0x204($s1)
    /* A28E4 800B20E4 1001A28F */  lw         $v0, 0x110($sp)
    /* A28E8 800B20E8 E000A38F */  lw         $v1, 0xE0($sp)
    /* A28EC 800B20EC 04000624 */  addiu      $a2, $zero, 0x4
    /* A28F0 800B20F0 23104300 */  subu       $v0, $v0, $v1
    /* A28F4 800B20F4 080222AE */  sw         $v0, 0x208($s1)
    /* A28F8 800B20F8 0801A28F */  lw         $v0, 0x108($sp)
    /* A28FC 800B20FC D800A38F */  lw         $v1, 0xD8($sp)
    /* A2900 800B2100 E8012726 */  addiu      $a3, $s1, 0x1E8
    /* A2904 800B2104 21104300 */  addu       $v0, $v0, $v1
    /* A2908 800B2108 0C0222AE */  sw         $v0, 0x20C($s1)
    /* A290C 800B210C 0C01A28F */  lw         $v0, 0x10C($sp)
    /* A2910 800B2110 DC00A38F */  lw         $v1, 0xDC($sp)
    /* A2914 800B2114 4400E426 */  addiu      $a0, $s7, 0x44
    /* A2918 800B2118 21104300 */  addu       $v0, $v0, $v1
    /* A291C 800B211C 100222AE */  sw         $v0, 0x210($s1)
    /* A2920 800B2120 1001A28F */  lw         $v0, 0x110($sp)
    /* A2924 800B2124 E000A38F */  lw         $v1, 0xE0($sp)
    /* A2928 800B2128 3800E526 */  addiu      $a1, $s7, 0x38
    /* A292C 800B212C 21104300 */  addu       $v0, $v0, $v1
    /* A2930 800B2130 140222AE */  sw         $v0, 0x214($s1)
    /* A2934 800B2134 1180023C */  lui        $v0, %hi(R3DCar_shadowVertex)
    /* A2938 800B2138 E8684224 */  addiu      $v0, $v0, %lo(R3DCar_shadowVertex)
    /* A293C 800B213C 3887030C */  jal        TrsProj_TransformProjectVertex__FP10matrixtdefP8coorddefiT1P12Draw_tVertex
    /* A2940 800B2140 1000A2AF */   sw        $v0, 0x10($sp)
  .L800B2144:
    /* A2944 800B2144 6C01BF8F */  lw         $ra, 0x16C($sp)
    /* A2948 800B2148 6801BE8F */  lw         $fp, 0x168($sp)
    /* A294C 800B214C 6401B78F */  lw         $s7, 0x164($sp)
    /* A2950 800B2150 6001B68F */  lw         $s6, 0x160($sp)
    /* A2954 800B2154 5C01B58F */  lw         $s5, 0x15C($sp)
    /* A2958 800B2158 5801B48F */  lw         $s4, 0x158($sp)
    /* A295C 800B215C 5401B38F */  lw         $s3, 0x154($sp)
    /* A2960 800B2160 5001B28F */  lw         $s2, 0x150($sp)
    /* A2964 800B2164 4C01B18F */  lw         $s1, 0x14C($sp)
    /* A2968 800B2168 4801B08F */  lw         $s0, 0x148($sp)
    /* A296C 800B216C 0800E003 */  jr         $ra
    /* A2970 800B2170 7001BD27 */   addiu     $sp, $sp, 0x170
endlabel R3DCar_InsertCarFacetMenu__FP8Car_tObjP13DRender_tView
