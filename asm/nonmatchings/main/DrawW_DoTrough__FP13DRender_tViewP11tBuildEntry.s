.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

/* Handwritten function */
nonmatching DrawW_DoTrough__FP13DRender_tViewP11tBuildEntry, 0x59C

glabel DrawW_DoTrough__FP13DRender_tViewP11tBuildEntry
    /* B77A0 800C6FA0 A0FFBD27 */  addiu      $sp, $sp, -0x60
    /* B77A4 800C6FA4 4400B3AF */  sw         $s3, 0x44($sp)
    /* B77A8 800C6FA8 21988000 */  addu       $s3, $a0, $zero
    /* B77AC 800C6FAC 5800BEAF */  sw         $fp, 0x58($sp)
    /* B77B0 800C6FB0 21F00000 */  addu       $fp, $zero, $zero
    /* B77B4 800C6FB4 5000B6AF */  sw         $s6, 0x50($sp)
    /* B77B8 800C6FB8 FFFF1624 */  addiu      $s6, $zero, -0x1
    /* B77BC 800C6FBC 4C00B5AF */  sw         $s5, 0x4C($sp)
    /* B77C0 800C6FC0 2000B527 */  addiu      $s5, $sp, 0x20
    /* B77C4 800C6FC4 5400B7AF */  sw         $s7, 0x54($sp)
    /* B77C8 800C6FC8 01001724 */  addiu      $s7, $zero, 0x1
    /* B77CC 800C6FCC 4800B4AF */  sw         $s4, 0x48($sp)
    /* B77D0 800C6FD0 21A0A000 */  addu       $s4, $a1, $zero
    /* B77D4 800C6FD4 3800B0AF */  sw         $s0, 0x38($sp)
    /* B77D8 800C6FD8 801F103C */  lui        $s0, (0x1F8000E7 >> 16)
    /* B77DC 800C6FDC 1480073C */  lui        $a3, %hi(BWorld_gChunkCount)
    /* B77E0 800C6FE0 A8C7E78C */  lw         $a3, %lo(BWorld_gChunkCount)($a3)
    /* B77E4 800C6FE4 01000224 */  addiu      $v0, $zero, 0x1
    /* B77E8 800C6FE8 5C00BFAF */  sw         $ra, 0x5C($sp)
    /* B77EC 800C6FEC 4000B2AF */  sw         $s2, 0x40($sp)
    /* B77F0 800C6FF0 3C00B1AF */  sw         $s1, 0x3C($sp)
    /* B77F4 800C6FF4 3000A7AF */  sw         $a3, 0x30($sp)
    /* B77F8 800C6FF8 DA0002A6 */  sh         $v0, (0x1F8000DA & 0xFFFF)($s0)
    /* B77FC 800C6FFC 1280023C */  lui        $v0, %hi(gIdentTemplate)
    /* B7800 800C7000 801F073C */  lui        $a3, (0x1F800074 >> 16)
    /* B7804 800C7004 7400E734 */  ori        $a3, $a3, (0x1F800074 & 0xFFFF)
    /* B7808 800C7008 70F54A24 */  addiu      $t2, $v0, %lo(gIdentTemplate)
    /* B780C 800C700C 0000488D */  lw         $t0, 0x0($t2)
    /* B7810 800C7010 0400498D */  lw         $t1, 0x4($t2)
    /* B7814 800C7014 0000E8AC */  sw         $t0, 0x0($a3)
    /* B7818 800C7018 0400E9AC */  sw         $t1, 0x4($a3)
    /* B781C 800C701C 0800488D */  lw         $t0, 0x8($t2)
    /* B7820 800C7020 0C00498D */  lw         $t1, 0xC($t2)
    /* B7824 800C7024 0800E8AC */  sw         $t0, 0x8($a3)
    /* B7828 800C7028 0C00E9AC */  sw         $t1, 0xC($a3)
    /* B782C 800C702C 1000488D */  lw         $t0, 0x10($t2)
    /* B7830 800C7030 1400498D */  lw         $t1, 0x14($t2)
    /* B7834 800C7034 1000E8AC */  sw         $t0, 0x10($a3)
    /* B7838 800C7038 1400E9AC */  sw         $t1, 0x14($a3)
    /* B783C 800C703C 1800488D */  lw         $t0, 0x18($t2)
    /* B7840 800C7040 1C00498D */  lw         $t1, 0x1C($t2)
    /* B7844 800C7044 1800E8AC */  sw         $t0, 0x18($a3)
    /* B7848 800C7048 1C00E9AC */  sw         $t1, 0x1C($a3)
    /* B784C 800C704C 480100A6 */  sh         $zero, (0x1F800148 & 0xFFFF)($s0)
  .L800C7050:
    /* B7850 800C7050 3000A88F */  lw         $t0, 0x30($sp)
    /* B7854 800C7054 00000000 */  nop
    /* B7858 800C7058 2A10C803 */  slt        $v0, $fp, $t0
    /* B785C 800C705C 2B014010 */  beqz       $v0, .L800C750C
    /* B7860 800C7060 00000000 */   nop
    /* B7864 800C7064 03008292 */  lbu        $v0, 0x3($s4)
    /* B7868 800C7068 00000000 */  nop
    /* B786C 800C706C 01004230 */  andi       $v0, $v0, 0x1
    /* B7870 800C7070 23014010 */  beqz       $v0, .L800C7500
    /* B7874 800C7074 1280023C */   lui       $v0, %hi(gInitialArt)
    /* B7878 800C7078 58E14224 */  addiu      $v0, $v0, %lo(gInitialArt)
    /* B787C 800C707C 1180043C */  lui        $a0, %hi(gWorldMat)
    /* B7880 800C7080 FC0002AE */  sw         $v0, (0x1F8000FC & 0xFFFF)($s0)
    /* B7884 800C7084 00008292 */  lbu        $v0, 0x0($s4)
    /* B7888 800C7088 40EE8424 */  addiu      $a0, $a0, %lo(gWorldMat)
    /* B788C 800C708C E40002A2 */  sb         $v0, (0x1F8000E4 & 0xFFFF)($s0)
    /* B7890 800C7090 02008292 */  lbu        $v0, 0x2($s4)
    /* B7894 800C7094 E4000392 */  lbu        $v1, (0x1F8000E4 & 0xFFFF)($s0)
    /* B7898 800C7098 14000526 */  addiu      $a1, $s0, %lo(D_1F800014)
    /* B789C 800C709C E50002A2 */  sb         $v0, (0x1F8000E5 & 0xFFFF)($s0)
    /* B78A0 800C70A0 C0100300 */  sll        $v0, $v1, 3
    /* B78A4 800C70A4 23104300 */  subu       $v0, $v0, $v1
    /* B78A8 800C70A8 1480033C */  lui        $v1, %hi(Track_chunkList)
    /* B78AC 800C70AC B8D4638C */  lw         $v1, %lo(Track_chunkList)($v1)
    /* B78B0 800C70B0 00110200 */  sll        $v0, $v0, 4
    /* B78B4 800C70B4 4F1D030C */  jal        DrawW_WorldSetUpMatrix__FP10matrixtdefP6MATRIX
    /* B78B8 800C70B8 21886200 */   addu      $s1, $v1, $v0
    /* B78BC 800C70BC 6C00228E */  lw         $v0, 0x6C($s1)
    /* B78C0 800C70C0 E4000492 */  lbu        $a0, (0x1F8000E4 & 0xFFFF)($s0)
    /* B78C4 800C70C4 060100A2 */  sb         $zero, (0x1F800106 & 0xFFFF)($s0)
    /* B78C8 800C70C8 1480033C */  lui        $v1, %hi(Track_materials)
    /* B78CC 800C70CC D0D4638C */  lw         $v1, %lo(Track_materials)($v1)
    /* B78D0 800C70D0 D80016A6 */  sh         $s6, (0x1F8000D8 & 0xFFFF)($s0)
    /* B78D4 800C70D4 04004224 */  addiu      $v0, $v0, 0x4
    /* B78D8 800C70D8 E00002AE */  sw         $v0, (0x1F8000E0 & 0xFFFF)($s0)
    /* B78DC 800C70DC 40100400 */  sll        $v0, $a0, 1
    /* B78E0 800C70E0 21104400 */  addu       $v0, $v0, $a0
    /* B78E4 800C70E4 80100200 */  sll        $v0, $v0, 2
    /* B78E8 800C70E8 F00003AE */  sw         $v1, (0x1F8000F0 & 0xFFFF)($s0)
    /* B78EC 800C70EC 1480033C */  lui        $v1, %hi(Chunk_chunkCenters)
    /* B78F0 800C70F0 1CC8638C */  lw         $v1, %lo(Chunk_chunkCenters)($v1)
    /* B78F4 800C70F4 1480043C */  lui        $a0, %hi(gNight_renderNight)
    /* B78F8 800C70F8 28DA848C */  lw         $a0, %lo(gNight_renderNight)($a0)
    /* B78FC 800C70FC 00000000 */  nop
    /* B7900 800C7100 84008010 */  beqz       $a0, .L800C7314
    /* B7904 800C7104 21906200 */   addu      $s2, $v1, $v0
    /* B7908 800C7108 04000224 */  addiu      $v0, $zero, 0x4
    /* B790C 800C710C 1180093C */  lui        $t1, %hi(Camera_gInfo)
    /* B7910 800C7110 060102A2 */  sb         $v0, (0x1F800106 & 0xFFFF)($s0)
    /* B7914 800C7114 0400658E */  lw         $a1, 0x4($s3)
    /* B7918 800C7118 ACF22925 */  addiu      $t1, $t1, %lo(Camera_gInfo)
    /* B791C 800C711C 04104500 */  sllv       $v0, $a1, $v0
    /* B7920 800C7120 21104500 */  addu       $v0, $v0, $a1
    /* B7924 800C7124 00110200 */  sll        $v0, $v0, 4
    /* B7928 800C7128 21104900 */  addu       $v0, $v0, $t1
    /* B792C 800C712C 0400448C */  lw         $a0, 0x4($v0)
    /* B7930 800C7130 0000428E */  lw         $v0, 0x0($s2)
    /* B7934 800C7134 A000838C */  lw         $v1, 0xA0($a0)
    /* B7938 800C7138 00000000 */  nop
    /* B793C 800C713C 23104300 */  subu       $v0, $v0, $v1
    /* B7940 800C7140 83120200 */  sra        $v0, $v0, 10
    /* B7944 800C7144 18004200 */  mult       $v0, $v0
    /* B7948 800C7148 A800838C */  lw         $v1, 0xA8($a0)
    /* B794C 800C714C 0800428E */  lw         $v0, 0x8($s2)
    /* B7950 800C7150 12300000 */  mflo       $a2
    /* B7954 800C7154 23104300 */  subu       $v0, $v0, $v1
    /* B7958 800C7158 83120200 */  sra        $v0, $v0, 10
    /* B795C 800C715C 18004200 */  mult       $v0, $v0
    /* B7960 800C7160 7D04033C */  lui        $v1, (0x47DFFFF >> 16)
    /* B7964 800C7164 FFFF6334 */  ori        $v1, $v1, (0x47DFFFF & 0xFFFF)
    /* B7968 800C7168 12100000 */  mflo       $v0
    /* B796C 800C716C 2110C200 */  addu       $v0, $a2, $v0
    /* B7970 800C7170 2A186200 */  slt        $v1, $v1, $v0
    /* B7974 800C7174 38006014 */  bnez       $v1, .L800C7258
    /* B7978 800C7178 1180033C */   lui       $v1, %hi(Cars_gList)
    /* B797C 800C717C DCF96324 */  addiu      $v1, $v1, %lo(Cars_gList)
    /* B7980 800C7180 80100500 */  sll        $v0, $a1, 2
    /* B7984 800C7184 21104300 */  addu       $v0, $v0, $v1
    /* B7988 800C7188 0000428C */  lw         $v0, 0x0($v0)
    /* B798C 800C718C 00000000 */  nop
    /* B7990 800C7190 47044290 */  lbu        $v0, 0x447($v0)
    /* B7994 800C7194 00000000 */  nop
    /* B7998 800C7198 06004230 */  andi       $v0, $v0, 0x6
    /* B799C 800C719C 02004010 */  beqz       $v0, .L800C71A8
    /* B79A0 800C71A0 05000224 */   addiu     $v0, $zero, 0x5
    /* B79A4 800C71A4 060102A2 */  sb         $v0, (0x1F800106 & 0xFFFF)($s0)
  .L800C71A8:
    /* B79A8 800C71A8 1180073C */  lui        $a3, %hi(Camera_gInfo)
    /* B79AC 800C71AC 0400638E */  lw         $v1, 0x4($s3)
    /* B79B0 800C71B0 ACF2E724 */  addiu      $a3, $a3, %lo(Camera_gInfo)
    /* B79B4 800C71B4 00110300 */  sll        $v0, $v1, 4
    /* B79B8 800C71B8 21104300 */  addu       $v0, $v0, $v1
    /* B79BC 800C71BC 00110200 */  sll        $v0, $v0, 4
    /* B79C0 800C71C0 21104700 */  addu       $v0, $v0, $a3
    /* B79C4 800C71C4 0400428C */  lw         $v0, 0x4($v0)
    /* B79C8 800C71C8 1180083C */  lui        $t0, %hi(Camera_gInfo)
    /* B79CC 800C71CC A000438C */  lw         $v1, 0xA0($v0)
    /* B79D0 800C71D0 0800628E */  lw         $v0, 0x8($s3)
    /* B79D4 800C71D4 ACF20825 */  addiu      $t0, $t0, %lo(Camera_gInfo)
    /* B79D8 800C71D8 23104300 */  subu       $v0, $v0, $v1
    /* B79DC 800C71DC 1000A2AF */  sw         $v0, 0x10($sp)
    /* B79E0 800C71E0 0400638E */  lw         $v1, 0x4($s3)
    /* B79E4 800C71E4 1000A427 */  addiu      $a0, $sp, 0x10
    /* B79E8 800C71E8 00110300 */  sll        $v0, $v1, 4
    /* B79EC 800C71EC 21104300 */  addu       $v0, $v0, $v1
    /* B79F0 800C71F0 00110200 */  sll        $v0, $v0, 4
    /* B79F4 800C71F4 21104800 */  addu       $v0, $v0, $t0
    /* B79F8 800C71F8 0400428C */  lw         $v0, 0x4($v0)
    /* B79FC 800C71FC 1180093C */  lui        $t1, %hi(Camera_gInfo)
    /* B7A00 800C7200 A400438C */  lw         $v1, 0xA4($v0)
    /* B7A04 800C7204 0C00628E */  lw         $v0, 0xC($s3)
    /* B7A08 800C7208 ACF22925 */  addiu      $t1, $t1, %lo(Camera_gInfo)
    /* B7A0C 800C720C 23104300 */  subu       $v0, $v0, $v1
    /* B7A10 800C7210 1400A2AF */  sw         $v0, 0x14($sp)
    /* B7A14 800C7214 0400638E */  lw         $v1, 0x4($s3)
    /* B7A18 800C7218 1180053C */  lui        $a1, %hi(gNightMat)
    /* B7A1C 800C721C 00110300 */  sll        $v0, $v1, 4
    /* B7A20 800C7220 21104300 */  addu       $v0, $v0, $v1
    /* B7A24 800C7224 00110200 */  sll        $v0, $v0, 4
    /* B7A28 800C7228 21104900 */  addu       $v0, $v0, $t1
    /* B7A2C 800C722C 0400428C */  lw         $v0, 0x4($v0)
    /* B7A30 800C7230 64EEA524 */  addiu      $a1, $a1, %lo(gNightMat)
    /* B7A34 800C7234 A800438C */  lw         $v1, 0xA8($v0)
    /* B7A38 800C7238 1000628E */  lw         $v0, 0x10($s3)
    /* B7A3C 800C723C 2130A002 */  addu       $a2, $s5, $zero
    /* B7A40 800C7240 23104300 */  subu       $v0, $v0, $v1
    /* B7A44 800C7244 B6AB030C */  jal        transform
    /* B7A48 800C7248 1800A2AF */   sw        $v0, 0x18($sp)
    /* B7A4C 800C724C 2120A002 */  addu       $a0, $s5, $zero
    /* B7A50 800C7250 761D030C */  jal        DrawW_WorldSetUpTranslation__FP8coorddefP6MATRIX
    /* B7A54 800C7254 34000526 */   addiu     $a1, $s0, %lo(D_1F800034)
  .L800C7258:
    /* B7A58 800C7258 1480043C */  lui        $a0, %hi(BW_gCopCarObj)
    /* B7A5C 800C725C B4C7848C */  lw         $a0, %lo(BW_gCopCarObj)($a0)
    /* B7A60 800C7260 00000000 */  nop
    /* B7A64 800C7264 2B008010 */  beqz       $a0, .L800C7314
    /* B7A68 800C7268 00000000 */   nop
    /* B7A6C 800C726C A000838C */  lw         $v1, 0xA0($a0)
    /* B7A70 800C7270 0000428E */  lw         $v0, 0x0($s2)
    /* B7A74 800C7274 00000000 */  nop
    /* B7A78 800C7278 23104300 */  subu       $v0, $v0, $v1
    /* B7A7C 800C727C 83120200 */  sra        $v0, $v0, 10
    /* B7A80 800C7280 18004200 */  mult       $v0, $v0
    /* B7A84 800C7284 A800838C */  lw         $v1, 0xA8($a0)
    /* B7A88 800C7288 0800428E */  lw         $v0, 0x8($s2)
    /* B7A8C 800C728C 12280000 */  mflo       $a1
    /* B7A90 800C7290 23104300 */  subu       $v0, $v0, $v1
    /* B7A94 800C7294 83120200 */  sra        $v0, $v0, 10
    /* B7A98 800C7298 18004200 */  mult       $v0, $v0
    /* B7A9C 800C729C 7D04033C */  lui        $v1, (0x47DFFFF >> 16)
    /* B7AA0 800C72A0 FFFF6334 */  ori        $v1, $v1, (0x47DFFFF & 0xFFFF)
    /* B7AA4 800C72A4 12100000 */  mflo       $v0
    /* B7AA8 800C72A8 2110A200 */  addu       $v0, $a1, $v0
    /* B7AAC 800C72AC 2A186200 */  slt        $v1, $v1, $v0
    /* B7AB0 800C72B0 18006014 */  bnez       $v1, .L800C7314
    /* B7AB4 800C72B4 21308000 */   addu      $a2, $a0, $zero
    /* B7AB8 800C72B8 06010292 */  lbu        $v0, (0x1F800106 & 0xFFFF)($s0)
    /* B7ABC 800C72BC 1000A427 */  addiu      $a0, $sp, 0x10
    /* B7AC0 800C72C0 02004234 */  ori        $v0, $v0, 0x2
    /* B7AC4 800C72C4 060102A2 */  sb         $v0, (0x1F800106 & 0xFFFF)($s0)
    /* B7AC8 800C72C8 A000C38C */  lw         $v1, 0xA0($a2)
    /* B7ACC 800C72CC 0800628E */  lw         $v0, 0x8($s3)
    /* B7AD0 800C72D0 1180053C */  lui        $a1, %hi(gCopMat)
    /* B7AD4 800C72D4 23104300 */  subu       $v0, $v0, $v1
    /* B7AD8 800C72D8 1000A2AF */  sw         $v0, 0x10($sp)
    /* B7ADC 800C72DC A400C38C */  lw         $v1, 0xA4($a2)
    /* B7AE0 800C72E0 0C00628E */  lw         $v0, 0xC($s3)
    /* B7AE4 800C72E4 88EEA524 */  addiu      $a1, $a1, %lo(gCopMat)
    /* B7AE8 800C72E8 23104300 */  subu       $v0, $v0, $v1
    /* B7AEC 800C72EC 1400A2AF */  sw         $v0, 0x14($sp)
    /* B7AF0 800C72F0 A800C38C */  lw         $v1, 0xA8($a2)
    /* B7AF4 800C72F4 1000628E */  lw         $v0, 0x10($s3)
    /* B7AF8 800C72F8 2130A002 */  addu       $a2, $s5, $zero
    /* B7AFC 800C72FC 23104300 */  subu       $v0, $v0, $v1
    /* B7B00 800C7300 B6AB030C */  jal        transform
    /* B7B04 800C7304 1800A2AF */   sw        $v0, 0x18($sp)
    /* B7B08 800C7308 2120A002 */  addu       $a0, $s5, $zero
    /* B7B0C 800C730C 761D030C */  jal        DrawW_WorldSetUpTranslation__FP8coorddefP6MATRIX
    /* B7B10 800C7310 54000526 */   addiu     $a1, $s0, %lo(D_1F800054)
  .L800C7314:
    /* B7B14 800C7314 0800638E */  lw         $v1, 0x8($s3)
    /* B7B18 800C7318 0000428E */  lw         $v0, 0x0($s2)
    /* B7B1C 800C731C 00000000 */  nop
    /* B7B20 800C7320 23104300 */  subu       $v0, $v0, $v1
    /* B7B24 800C7324 83120200 */  sra        $v0, $v0, 10
    /* B7B28 800C7328 F40002A6 */  sh         $v0, (0x1F8000F4 & 0xFFFF)($s0)
    /* B7B2C 800C732C 0C00638E */  lw         $v1, 0xC($s3)
    /* B7B30 800C7330 0400428E */  lw         $v0, 0x4($s2)
    /* B7B34 800C7334 00000000 */  nop
    /* B7B38 800C7338 23104300 */  subu       $v0, $v0, $v1
    /* B7B3C 800C733C 83120200 */  sra        $v0, $v0, 10
    /* B7B40 800C7340 F60002A6 */  sh         $v0, (0x1F8000F6 & 0xFFFF)($s0)
    /* B7B44 800C7344 1000638E */  lw         $v1, 0x10($s3)
    /* B7B48 800C7348 0800428E */  lw         $v0, 0x8($s2)
    /* B7B4C 800C734C 00000000 */  nop
    /* B7B50 800C7350 23104300 */  subu       $v0, $v0, $v1
    /* B7B54 800C7354 83120200 */  sra        $v0, $v0, 10
    /* B7B58 800C7358 F80002A6 */  sh         $v0, (0x1F8000F8 & 0xFFFF)($s0)
    /* B7B5C 800C735C 14000226 */  addiu      $v0, $s0, %lo(D_1F800014)
    /* B7B60 800C7360 1C0040AC */  sw         $zero, 0x1C($v0)
    /* B7B64 800C7364 180040AC */  sw         $zero, 0x18($v0)
    /* B7B68 800C7368 280000AE */  sw         $zero, (0x1F800028 & 0xFFFF)($s0)
    /* B7B6C 800C736C 14004C8C */  lw         $t4, 0x14($v0)
    /* B7B70 800C7370 18004D8C */  lw         $t5, 0x18($v0)
    /* B7B74 800C7374 0028CC48 */  ctc2       $t4, $5 /* handwritten instruction */
    /* B7B78 800C7378 1C004E8C */  lw         $t6, 0x1C($v0)
    /* B7B7C 800C737C 0030CD48 */  ctc2       $t5, $6 /* handwritten instruction */
    /* B7B80 800C7380 0038CE48 */  ctc2       $t6, $7 /* handwritten instruction */
    /* B7B84 800C7384 E5000292 */  lbu        $v0, (0x1F8000E5 & 0xFFFF)($s0)
    /* B7B88 800C7388 00000000 */  nop
    /* B7B8C 800C738C 15004010 */  beqz       $v0, .L800C73E4
    /* B7B90 800C7390 00000000 */   nop
    /* B7B94 800C7394 3800238E */  lw         $v1, 0x38($s1)
    /* B7B98 800C7398 00000000 */  nop
    /* B7B9C 800C739C 38006010 */  beqz       $v1, .L800C7480
    /* B7BA0 800C73A0 21200002 */   addu      $a0, $s0, $zero
    /* B7BA4 800C73A4 04006224 */  addiu      $v0, $v1, 0x4
    /* B7BA8 800C73A8 000102AE */  sw         $v0, (0x1F800100 & 0xFFFF)($s0)
    /* B7BAC 800C73AC 00006394 */  lhu        $v1, 0x0($v1)
    /* B7BB0 800C73B0 7D000224 */  addiu      $v0, $zero, 0x7D
    /* B7BB4 800C73B4 EC0002AE */  sw         $v0, (0x1F8000EC & 0xFFFF)($s0)
    /* B7BB8 800C73B8 AE1B030C */  jal        DrawW_StripDraw_High__FP25Draw_tGiveShelbyMoreCache
    /* B7BBC 800C73BC 040103A6 */   sh        $v1, (0x1F800104 & 0xFFFF)($s0)
    /* B7BC0 800C73C0 25002292 */  lbu        $v0, 0x25($s1)
    /* B7BC4 800C73C4 00000000 */  nop
    /* B7BC8 800C73C8 E70002A2 */  sb         $v0, (0x1F8000E7 & 0xFFFF)($s0)
    /* B7BCC 800C73CC FF004230 */  andi       $v0, $v0, 0xFF
    /* B7BD0 800C73D0 2B004010 */  beqz       $v0, .L800C7480
    /* B7BD4 800C73D4 21200002 */   addu      $a0, $s0, $zero
    /* B7BD8 800C73D8 3400238E */  lw         $v1, 0x34($s1)
    /* B7BDC 800C73DC 1B1D0308 */  j          .L800C746C
    /* B7BE0 800C73E0 1E000224 */   addiu     $v0, $zero, 0x1E
  .L800C73E4:
    /* B7BE4 800C73E4 3C00228E */  lw         $v0, 0x3C($s1)
    /* B7BE8 800C73E8 00000000 */  nop
    /* B7BEC 800C73EC 0A004010 */  beqz       $v0, .L800C7418
    /* B7BF0 800C73F0 00000000 */   nop
    /* B7BF4 800C73F4 00004394 */  lhu        $v1, 0x0($v0)
    /* B7BF8 800C73F8 04004224 */  addiu      $v0, $v0, 0x4
    /* B7BFC 800C73FC 000102AE */  sw         $v0, (0x1F800100 & 0xFFFF)($s0)
    /* B7C00 800C7400 05004010 */  beqz       $v0, .L800C7418
    /* B7C04 800C7404 040103A6 */   sh        $v1, (0x1F800104 & 0xFFFF)($s0)
    /* B7C08 800C7408 7D000224 */  addiu      $v0, $zero, 0x7D
    /* B7C0C 800C740C EC0002AE */  sw         $v0, (0x1F8000EC & 0xFFFF)($s0)
    /* B7C10 800C7410 AE1B030C */  jal        DrawW_StripDraw_High__FP25Draw_tGiveShelbyMoreCache
    /* B7C14 800C7414 21200002 */   addu      $a0, $s0, $zero
  .L800C7418:
    /* B7C18 800C7418 20002292 */  lbu        $v0, 0x20($s1)
    /* B7C1C 800C741C 00000000 */  nop
    /* B7C20 800C7420 E70002A2 */  sb         $v0, (0x1F8000E7 & 0xFFFF)($s0)
    /* B7C24 800C7424 FF004230 */  andi       $v0, $v0, 0xFF
    /* B7C28 800C7428 08004010 */  beqz       $v0, .L800C744C
    /* B7C2C 800C742C 21200002 */   addu      $a0, $s0, $zero
    /* B7C30 800C7430 2800238E */  lw         $v1, 0x28($s1)
    /* B7C34 800C7434 7D000224 */  addiu      $v0, $zero, 0x7D
    /* B7C38 800C7438 EC0002AE */  sw         $v0, (0x1F8000EC & 0xFFFF)($s0)
    /* B7C3C 800C743C 070117A2 */  sb         $s7, (0x1F800107 & 0xFFFF)($s0)
    /* B7C40 800C7440 D80016A6 */  sh         $s6, (0x1F8000D8 & 0xFFFF)($s0)
    /* B7C44 800C7444 8E1B030C */  jal        DrawW_kCtrlWorld_High__FP25Draw_tGiveShelbyMoreCache
    /* B7C48 800C7448 E80003AE */   sw        $v1, (0x1F8000E8 & 0xFFFF)($s0)
  .L800C744C:
    /* B7C4C 800C744C 21002292 */  lbu        $v0, 0x21($s1)
    /* B7C50 800C7450 00000000 */  nop
    /* B7C54 800C7454 E70002A2 */  sb         $v0, (0x1F8000E7 & 0xFFFF)($s0)
    /* B7C58 800C7458 FF004230 */  andi       $v0, $v0, 0xFF
    /* B7C5C 800C745C 08004010 */  beqz       $v0, .L800C7480
    /* B7C60 800C7460 21200002 */   addu      $a0, $s0, $zero
    /* B7C64 800C7464 2C00238E */  lw         $v1, 0x2C($s1)
    /* B7C68 800C7468 1E000224 */  addiu      $v0, $zero, 0x1E
  .L800C746C:
    /* B7C6C 800C746C EC0002AE */  sw         $v0, (0x1F8000EC & 0xFFFF)($s0)
    /* B7C70 800C7470 070117A2 */  sb         $s7, (0x1F800107 & 0xFFFF)($s0)
    /* B7C74 800C7474 D80016A6 */  sh         $s6, (0x1F8000D8 & 0xFFFF)($s0)
    /* B7C78 800C7478 8E1B030C */  jal        DrawW_kCtrlWorld_High__FP25Draw_tGiveShelbyMoreCache
    /* B7C7C 800C747C E80003AE */   sw        $v1, (0x1F8000E8 & 0xFFFF)($s0)
  .L800C7480:
    /* B7C80 800C7480 5C00228E */  lw         $v0, 0x5C($s1)
    /* B7C84 800C7484 00000000 */  nop
    /* B7C88 800C7488 04004224 */  addiu      $v0, $v0, 0x4
    /* B7C8C 800C748C E00002AE */  sw         $v0, (0x1F8000E0 & 0xFFFF)($s0)
    /* B7C90 800C7490 22002292 */  lbu        $v0, 0x22($s1)
    /* B7C94 800C7494 00000000 */  nop
    /* B7C98 800C7498 E70002A2 */  sb         $v0, (0x1F8000E7 & 0xFFFF)($s0)
    /* B7C9C 800C749C FF004230 */  andi       $v0, $v0, 0xFF
    /* B7CA0 800C74A0 09004010 */  beqz       $v0, .L800C74C8
    /* B7CA4 800C74A4 21200002 */   addu      $a0, $s0, $zero
    /* B7CA8 800C74A8 6000238E */  lw         $v1, 0x60($s1)
    /* B7CAC 800C74AC 7D000224 */  addiu      $v0, $zero, 0x7D
    /* B7CB0 800C74B0 EC0002AE */  sw         $v0, (0x1F8000EC & 0xFFFF)($s0)
    /* B7CB4 800C74B4 070117A2 */  sb         $s7, (0x1F800107 & 0xFFFF)($s0)
    /* B7CB8 800C74B8 D80016A6 */  sh         $s6, (0x1F8000D8 & 0xFFFF)($s0)
    /* B7CBC 800C74BC 04006324 */  addiu      $v1, $v1, 0x4
    /* B7CC0 800C74C0 8E1B030C */  jal        DrawW_kCtrlWorld_High__FP25Draw_tGiveShelbyMoreCache
    /* B7CC4 800C74C4 E80003AE */   sw        $v1, (0x1F8000E8 & 0xFFFF)($s0)
  .L800C74C8:
    /* B7CC8 800C74C8 23002292 */  lbu        $v0, 0x23($s1)
    /* B7CCC 800C74CC 00000000 */  nop
    /* B7CD0 800C74D0 E70002A2 */  sb         $v0, (0x1F8000E7 & 0xFFFF)($s0)
    /* B7CD4 800C74D4 FF004230 */  andi       $v0, $v0, 0xFF
    /* B7CD8 800C74D8 09004010 */  beqz       $v0, .L800C7500
    /* B7CDC 800C74DC 21200002 */   addu      $a0, $s0, $zero
    /* B7CE0 800C74E0 6400238E */  lw         $v1, 0x64($s1)
    /* B7CE4 800C74E4 32000224 */  addiu      $v0, $zero, 0x32
    /* B7CE8 800C74E8 EC0002AE */  sw         $v0, (0x1F8000EC & 0xFFFF)($s0)
    /* B7CEC 800C74EC 070117A2 */  sb         $s7, (0x1F800107 & 0xFFFF)($s0)
    /* B7CF0 800C74F0 D80016A6 */  sh         $s6, (0x1F8000D8 & 0xFFFF)($s0)
    /* B7CF4 800C74F4 04006324 */  addiu      $v1, $v1, 0x4
    /* B7CF8 800C74F8 8E1B030C */  jal        DrawW_kCtrlWorld_High__FP25Draw_tGiveShelbyMoreCache
    /* B7CFC 800C74FC E80003AE */   sw        $v1, (0x1F8000E8 & 0xFFFF)($s0)
  .L800C7500:
    /* B7D00 800C7500 04009426 */  addiu      $s4, $s4, 0x4
    /* B7D04 800C7504 141C0308 */  j          .L800C7050
    /* B7D08 800C7508 0100DE27 */   addiu     $fp, $fp, 0x1
  .L800C750C:
    /* B7D0C 800C750C 5C00BF8F */  lw         $ra, 0x5C($sp)
    /* B7D10 800C7510 5800BE8F */  lw         $fp, 0x58($sp)
    /* B7D14 800C7514 5400B78F */  lw         $s7, 0x54($sp)
    /* B7D18 800C7518 5000B68F */  lw         $s6, 0x50($sp)
    /* B7D1C 800C751C 4C00B58F */  lw         $s5, 0x4C($sp)
    /* B7D20 800C7520 4800B48F */  lw         $s4, 0x48($sp)
    /* B7D24 800C7524 4400B38F */  lw         $s3, 0x44($sp)
    /* B7D28 800C7528 4000B28F */  lw         $s2, 0x40($sp)
    /* B7D2C 800C752C 3C00B18F */  lw         $s1, 0x3C($sp)
    /* B7D30 800C7530 3800B08F */  lw         $s0, 0x38($sp)
    /* B7D34 800C7534 0800E003 */  jr         $ra
    /* B7D38 800C7538 6000BD27 */   addiu     $sp, $sp, 0x60
endlabel DrawW_DoTrough__FP13DRender_tViewP11tBuildEntry
