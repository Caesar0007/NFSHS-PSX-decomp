.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CV_ProcessWorldColors_FINAL__FiP7CVECTORs, 0x1C0

glabel CV_ProcessWorldColors_FINAL__FiP7CVECTORs
    /* D1948 800E1148 C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* D194C 800E114C 2800B6AF */  sw         $s6, 0x28($sp)
    /* D1950 800E1150 21B08000 */  addu       $s6, $a0, $zero
    /* D1954 800E1154 2C00B7AF */  sw         $s7, 0x2C($sp)
    /* D1958 800E1158 21B8A000 */  addu       $s7, $a1, $zero
    /* D195C 800E115C 2400B5AF */  sw         $s5, 0x24($sp)
    /* D1960 800E1160 21A80000 */  addu       $s5, $zero, $zero
    /* D1964 800E1164 00340600 */  sll        $a2, $a2, 16
    /* D1968 800E1168 2000B4AF */  sw         $s4, 0x20($sp)
    /* D196C 800E116C 03A40600 */  sra        $s4, $a2, 16
    /* D1970 800E1170 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* D1974 800E1174 2198A002 */  addu       $s3, $s5, $zero
    /* D1978 800E1178 3000BFAF */  sw         $ra, 0x30($sp)
    /* D197C 800E117C 1800B2AF */  sw         $s2, 0x18($sp)
    /* D1980 800E1180 1400B1AF */  sw         $s1, 0x14($sp)
    /* D1984 800E1184 1000B0AF */  sw         $s0, 0x10($sp)
  .L800E1188:
    /* D1988 800E1188 1480023C */  lui        $v0, %hi(Chunk_numLight)
    /* D198C 800E118C ECD4428C */  lw         $v0, %lo(Chunk_numLight)($v0)
    /* D1990 800E1190 00000000 */  nop
    /* D1994 800E1194 2A10A202 */  slt        $v0, $s5, $v0
    /* D1998 800E1198 50004010 */  beqz       $v0, .L800E12DC
    /* D199C 800E119C 2128C002 */   addu      $a1, $s6, $zero
    /* D19A0 800E11A0 1480023C */  lui        $v0, %hi(Chunk_lightTable)
    /* D19A4 800E11A4 18C8428C */  lw         $v0, %lo(Chunk_lightTable)($v0)
    /* D19A8 800E11A8 0000E492 */  lbu        $a0, 0x0($s7)
    /* D19AC 800E11AC 21106202 */  addu       $v0, $s3, $v0
    /* D19B0 800E11B0 00005090 */  lbu        $s0, 0x0($v0)
    /* D19B4 800E11B4 01005190 */  lbu        $s1, 0x1($v0)
    /* D19B8 800E11B8 02005290 */  lbu        $s2, 0x2($v0)
    /* D19BC 800E11BC CA90030C */  jal        fixedmult
    /* D19C0 800E11C0 23200402 */   subu      $a0, $s0, $a0
    /* D19C4 800E11C4 23100202 */  subu       $v0, $s0, $v0
    /* D19C8 800E11C8 06004004 */  bltz       $v0, .L800E11E4
    /* D19CC 800E11CC 21800000 */   addu      $s0, $zero, $zero
    /* D19D0 800E11D0 21804000 */  addu       $s0, $v0, $zero
    /* D19D4 800E11D4 0001022A */  slti       $v0, $s0, 0x100
    /* D19D8 800E11D8 02004014 */  bnez       $v0, .L800E11E4
    /* D19DC 800E11DC 00000000 */   nop
    /* D19E0 800E11E0 FF001024 */  addiu      $s0, $zero, 0xFF
  .L800E11E4:
    /* D19E4 800E11E4 0100E492 */  lbu        $a0, 0x1($s7)
    /* D19E8 800E11E8 2128C002 */  addu       $a1, $s6, $zero
    /* D19EC 800E11EC CA90030C */  jal        fixedmult
    /* D19F0 800E11F0 23202402 */   subu      $a0, $s1, $a0
    /* D19F4 800E11F4 23102202 */  subu       $v0, $s1, $v0
    /* D19F8 800E11F8 06004004 */  bltz       $v0, .L800E1214
    /* D19FC 800E11FC 21880000 */   addu      $s1, $zero, $zero
    /* D1A00 800E1200 21884000 */  addu       $s1, $v0, $zero
    /* D1A04 800E1204 0001222A */  slti       $v0, $s1, 0x100
    /* D1A08 800E1208 02004014 */  bnez       $v0, .L800E1214
    /* D1A0C 800E120C 00000000 */   nop
    /* D1A10 800E1210 FF001124 */  addiu      $s1, $zero, 0xFF
  .L800E1214:
    /* D1A14 800E1214 0200E492 */  lbu        $a0, 0x2($s7)
    /* D1A18 800E1218 2128C002 */  addu       $a1, $s6, $zero
    /* D1A1C 800E121C CA90030C */  jal        fixedmult
    /* D1A20 800E1220 23204402 */   subu      $a0, $s2, $a0
    /* D1A24 800E1224 23104202 */  subu       $v0, $s2, $v0
    /* D1A28 800E1228 06004004 */  bltz       $v0, .L800E1244
    /* D1A2C 800E122C 21900000 */   addu      $s2, $zero, $zero
    /* D1A30 800E1230 21904000 */  addu       $s2, $v0, $zero
    /* D1A34 800E1234 0001422A */  slti       $v0, $s2, 0x100
    /* D1A38 800E1238 02004014 */  bnez       $v0, .L800E1244
    /* D1A3C 800E123C 00000000 */   nop
    /* D1A40 800E1240 FF001224 */  addiu      $s2, $zero, 0xFF
  .L800E1244:
    /* D1A44 800E1244 21801402 */  addu       $s0, $s0, $s4
    /* D1A48 800E1248 21883402 */  addu       $s1, $s1, $s4
    /* D1A4C 800E124C 0001022A */  slti       $v0, $s0, 0x100
    /* D1A50 800E1250 02004014 */  bnez       $v0, .L800E125C
    /* D1A54 800E1254 21905402 */   addu      $s2, $s2, $s4
    /* D1A58 800E1258 FF001024 */  addiu      $s0, $zero, 0xFF
  .L800E125C:
    /* D1A5C 800E125C 02000106 */  bgez       $s0, .L800E1268
    /* D1A60 800E1260 0001222A */   slti      $v0, $s1, 0x100
    /* D1A64 800E1264 21800000 */  addu       $s0, $zero, $zero
  .L800E1268:
    /* D1A68 800E1268 02004014 */  bnez       $v0, .L800E1274
    /* D1A6C 800E126C 00000000 */   nop
    /* D1A70 800E1270 FF001124 */  addiu      $s1, $zero, 0xFF
  .L800E1274:
    /* D1A74 800E1274 02002106 */  bgez       $s1, .L800E1280
    /* D1A78 800E1278 0001422A */   slti      $v0, $s2, 0x100
    /* D1A7C 800E127C 21880000 */  addu       $s1, $zero, $zero
  .L800E1280:
    /* D1A80 800E1280 02004014 */  bnez       $v0, .L800E128C
    /* D1A84 800E1284 00000000 */   nop
    /* D1A88 800E1288 FF001224 */  addiu      $s2, $zero, 0xFF
  .L800E128C:
    /* D1A8C 800E128C 02004106 */  bgez       $s2, .L800E1298
    /* D1A90 800E1290 00000000 */   nop
    /* D1A94 800E1294 21900000 */  addu       $s2, $zero, $zero
  .L800E1298:
    /* D1A98 800E1298 1480023C */  lui        $v0, %hi(Chunk_lightTable)
    /* D1A9C 800E129C 18C8428C */  lw         $v0, %lo(Chunk_lightTable)($v0)
    /* D1AA0 800E12A0 00000000 */  nop
    /* D1AA4 800E12A4 21106202 */  addu       $v0, $s3, $v0
    /* D1AA8 800E12A8 000050A0 */  sb         $s0, 0x0($v0)
    /* D1AAC 800E12AC 1480023C */  lui        $v0, %hi(Chunk_lightTable)
    /* D1AB0 800E12B0 18C8428C */  lw         $v0, %lo(Chunk_lightTable)($v0)
    /* D1AB4 800E12B4 00000000 */  nop
    /* D1AB8 800E12B8 21106202 */  addu       $v0, $s3, $v0
    /* D1ABC 800E12BC 010051A0 */  sb         $s1, 0x1($v0)
    /* D1AC0 800E12C0 1480023C */  lui        $v0, %hi(Chunk_lightTable)
    /* D1AC4 800E12C4 18C8428C */  lw         $v0, %lo(Chunk_lightTable)($v0)
    /* D1AC8 800E12C8 0100B526 */  addiu      $s5, $s5, 0x1
    /* D1ACC 800E12CC 21106202 */  addu       $v0, $s3, $v0
    /* D1AD0 800E12D0 04007326 */  addiu      $s3, $s3, 0x4
    /* D1AD4 800E12D4 62840308 */  j          .L800E1188
    /* D1AD8 800E12D8 020052A0 */   sb        $s2, 0x2($v0)
  .L800E12DC:
    /* D1ADC 800E12DC 3000BF8F */  lw         $ra, 0x30($sp)
    /* D1AE0 800E12E0 2C00B78F */  lw         $s7, 0x2C($sp)
    /* D1AE4 800E12E4 2800B68F */  lw         $s6, 0x28($sp)
    /* D1AE8 800E12E8 2400B58F */  lw         $s5, 0x24($sp)
    /* D1AEC 800E12EC 2000B48F */  lw         $s4, 0x20($sp)
    /* D1AF0 800E12F0 1C00B38F */  lw         $s3, 0x1C($sp)
    /* D1AF4 800E12F4 1800B28F */  lw         $s2, 0x18($sp)
    /* D1AF8 800E12F8 1400B18F */  lw         $s1, 0x14($sp)
    /* D1AFC 800E12FC 1000B08F */  lw         $s0, 0x10($sp)
    /* D1B00 800E1300 0800E003 */  jr         $ra
    /* D1B04 800E1304 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel CV_ProcessWorldColors_FINAL__FiP7CVECTORs
