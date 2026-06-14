.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

/* Handwritten function */
nonmatching DrawW_BuildObjectFacets__FP13DRender_tViewP15ChunkObjectInfo, 0x2F4

glabel DrawW_BuildObjectFacets__FP13DRender_tViewP15ChunkObjectInfo
    /* B80A8 800C78A8 58FFBD27 */  addiu      $sp, $sp, -0xA8
    /* B80AC 800C78AC 9C00B7AF */  sw         $s7, 0x9C($sp)
    /* B80B0 800C78B0 21B88000 */  addu       $s7, $a0, $zero
    /* B80B4 800C78B4 A400BFAF */  sw         $ra, 0xA4($sp)
    /* B80B8 800C78B8 A000BEAF */  sw         $fp, 0xA0($sp)
    /* B80BC 800C78BC 9800B6AF */  sw         $s6, 0x98($sp)
    /* B80C0 800C78C0 9400B5AF */  sw         $s5, 0x94($sp)
    /* B80C4 800C78C4 9000B4AF */  sw         $s4, 0x90($sp)
    /* B80C8 800C78C8 8C00B3AF */  sw         $s3, 0x8C($sp)
    /* B80CC 800C78CC 8800B2AF */  sw         $s2, 0x88($sp)
    /* B80D0 800C78D0 8400B1AF */  sw         $s1, 0x84($sp)
    /* B80D4 800C78D4 8000B0AF */  sw         $s0, 0x80($sp)
    /* B80D8 800C78D8 0400A28C */  lw         $v0, 0x4($a1)
    /* B80DC 800C78DC 21A80000 */  addu       $s5, $zero, $zero
    /* B80E0 800C78E0 04005024 */  addiu      $s0, $v0, 0x4
    /* B80E4 800C78E4 0000428C */  lw         $v0, 0x0($v0)
    /* B80E8 800C78E8 801F1E3C */  lui        $fp, (0x1F800028 >> 16)
    /* B80EC 800C78EC 9E004010 */  beqz       $v0, .L800C7B68
    /* B80F0 800C78F0 6800A2AF */   sw        $v0, 0x68($sp)
    /* B80F4 800C78F4 1000A88C */  lw         $t0, 0x10($a1)
    /* B80F8 800C78F8 801F023C */  lui        $v0, (0x1F800014 >> 16)
    /* B80FC 800C78FC 6C00A8AF */  sw         $t0, 0x6C($sp)
    /* B8100 800C7900 0800A88C */  lw         $t0, 0x8($a1)
    /* B8104 800C7904 14004234 */  ori        $v0, $v0, (0x1F800014 & 0xFFFF)
    /* B8108 800C7908 7000A8AF */  sw         $t0, 0x70($sp)
    /* B810C 800C790C 0C00B68C */  lw         $s6, 0xC($a1)
    /* B8110 800C7910 1400A58C */  lw         $a1, 0x14($a1)
    /* B8114 800C7914 801F083C */  lui        $t0, (0x1F800014 >> 16)
    /* B8118 800C7918 14000835 */  ori        $t0, $t0, (0x1F800014 & 0xFFFF)
    /* B811C 800C791C 7400A5AF */  sw         $a1, 0x74($sp)
    /* B8120 800C7920 1C0040AC */  sw         $zero, 0x1C($v0)
    /* B8124 800C7924 180040AC */  sw         $zero, 0x18($v0)
    /* B8128 800C7928 2800C0AF */  sw         $zero, (0x1F800028 & 0xFFFF)($fp)
    /* B812C 800C792C 14000C8D */  lw         $t4, 0x14($t0)
    /* B8130 800C7930 18000D8D */  lw         $t5, 0x18($t0)
    /* B8134 800C7934 0028CC48 */  ctc2       $t4, $5 /* handwritten instruction */
    /* B8138 800C7938 1C000E8D */  lw         $t6, 0x1C($t0)
    /* B813C 800C793C 0030CD48 */  ctc2       $t5, $6 /* handwritten instruction */
    /* B8140 800C7940 0038CE48 */  ctc2       $t6, $7 /* handwritten instruction */
    /* B8144 800C7944 21A00000 */  addu       $s4, $zero, $zero
    /* B8148 800C7948 4800B327 */  addiu      $s3, $sp, 0x48
    /* B814C 800C794C 2000A827 */  addiu      $t0, $sp, 0x20
    /* B8150 800C7950 7800A8AF */  sw         $t0, 0x78($sp)
  .L800C7954:
    /* B8154 800C7954 6800A88F */  lw         $t0, 0x68($sp)
    /* B8158 800C7958 00000000 */  nop
    /* B815C 800C795C 2A108802 */  slt        $v0, $s4, $t0
    /* B8160 800C7960 82004010 */  beqz       $v0, .L800C7B6C
    /* B8164 800C7964 2110A002 */   addu      $v0, $s5, $zero
    /* B8168 800C7968 7400A88F */  lw         $t0, 0x74($sp)
    /* B816C 800C796C 00000000 */  nop
    /* B8170 800C7970 09000011 */  beqz       $t0, .L800C7998
    /* B8174 800C7974 40101400 */   sll       $v0, $s4, 1
    /* B8178 800C7978 21104800 */  addu       $v0, $v0, $t0
    /* B817C 800C797C 00004294 */  lhu        $v0, 0x0($v0)
    /* B8180 800C7980 00000000 */  nop
    /* B8184 800C7984 02130200 */  srl        $v0, $v0, 12
    /* B8188 800C7988 01004238 */  xori       $v0, $v0, 0x1
    /* B818C 800C798C 01004230 */  andi       $v0, $v0, 0x1
    /* B8190 800C7990 70004014 */  bnez       $v0, .L800C7B54
    /* B8194 800C7994 00000000 */   nop
  .L800C7998:
    /* B8198 800C7998 6C00B28F */  lw         $s2, 0x6C($sp)
    /* B819C 800C799C 00000000 */  nop
    /* B81A0 800C79A0 06004016 */  bnez       $s2, .L800C79BC
    /* B81A4 800C79A4 00000000 */   nop
    /* B81A8 800C79A8 04000292 */  lbu        $v0, 0x4($s0)
    /* B81AC 800C79AC 1480033C */  lui        $v1, %hi(D_8013D820)
    /* B81B0 800C79B0 20D86324 */  addiu      $v1, $v1, %lo(D_8013D820)
    /* B81B4 800C79B4 21104300 */  addu       $v0, $v0, $v1
    /* B81B8 800C79B8 00005280 */  lb         $s2, 0x0($v0)
  .L800C79BC:
    /* B81BC 800C79BC 02000392 */  lbu        $v1, 0x2($s0)
    /* B81C0 800C79C0 01000224 */  addiu      $v0, $zero, 0x1
    /* B81C4 800C79C4 09006210 */  beq        $v1, $v0, .L800C79EC
    /* B81C8 800C79C8 02006228 */   slti      $v0, $v1, 0x2
    /* B81CC 800C79CC 61004014 */  bnez       $v0, .L800C7B54
    /* B81D0 800C79D0 03000224 */   addiu     $v0, $zero, 0x3
    /* B81D4 800C79D4 23006210 */  beq        $v1, $v0, .L800C7A64
    /* B81D8 800C79D8 07000224 */   addiu     $v0, $zero, 0x7
    /* B81DC 800C79DC 21006210 */  beq        $v1, $v0, .L800C7A64
    /* B81E0 800C79E0 00000000 */   nop
    /* B81E4 800C79E4 D51E0308 */  j          .L800C7B54
    /* B81E8 800C79E8 00000000 */   nop
  .L800C79EC:
    /* B81EC 800C79EC 06000586 */  lh         $a1, 0x6($s0)
    /* B81F0 800C79F0 1480033C */  lui        $v1, %hi(Track_gObjDefs)
    /* B81F4 800C79F4 D4D4638C */  lw         $v1, %lo(Track_gObjDefs)($v1)
    /* B81F8 800C79F8 7000A88F */  lw         $t0, 0x70($sp)
    /* B81FC 800C79FC 80100500 */  sll        $v0, $a1, 2
    /* B8200 800C7A00 21104300 */  addu       $v0, $v0, $v1
    /* B8204 800C7A04 0000518C */  lw         $s1, 0x0($v0)
    /* B8208 800C7A08 06000011 */  beqz       $t0, .L800C7A24
    /* B820C 800C7A0C 2120E002 */   addu      $a0, $s7, $zero
    /* B8210 800C7A10 08000626 */  addiu      $a2, $s0, 0x8
    /* B8214 800C7A14 F422030C */  jal        ObjectClipped__FP13DRender_tViewiP8coorddefP25Draw_tGiveShelbyMoreCache
    /* B8218 800C7A18 2138C003 */   addu      $a3, $fp, $zero
    /* B821C 800C7A1C 4D004014 */  bnez       $v0, .L800C7B54
    /* B8220 800C7A20 00000000 */   nop
  .L800C7A24:
    /* B8224 800C7A24 FFFF0824 */  addiu      $t0, $zero, -0x1
    /* B8228 800C7A28 0600C812 */  beq        $s6, $t0, .L800C7A44
    /* B822C 800C7A2C 08000426 */   addiu     $a0, $s0, 0x8
    /* B8230 800C7A30 71F5010C */  jal        xzsquaredist32__FP8coorddefT0
    /* B8234 800C7A34 0800E526 */   addiu     $a1, $s7, 0x8
    /* B8238 800C7A38 2A105600 */  slt        $v0, $v0, $s6
    /* B823C 800C7A3C 45004010 */  beqz       $v0, .L800C7B54
    /* B8240 800C7A40 00000000 */   nop
  .L800C7A44:
    /* B8244 800C7A44 1000B2AF */  sw         $s2, 0x10($sp)
    /* B8248 800C7A48 2120E002 */  addu       $a0, $s7, $zero
    /* B824C 800C7A4C 2128C003 */  addu       $a1, $fp, $zero
    /* B8250 800C7A50 21302002 */  addu       $a2, $s1, $zero
    /* B8254 800C7A54 8520030C */  jal        DrawObjectSimple__FP13DRender_tViewP11Draw_DCacheP13Trk_ObjectDefP8coorddefi
    /* B8258 800C7A58 08000726 */   addiu     $a3, $s0, 0x8
    /* B825C 800C7A5C D51E0308 */  j          .L800C7B54
    /* B8260 800C7A60 21A8A202 */   addu      $s5, $s5, $v0
  .L800C7A64:
    /* B8264 800C7A64 911D030C */  jal        DrawW_GetAnimationTime__FP15Trk_AnimateInst
    /* B8268 800C7A68 21200002 */   addu      $a0, $s0, $zero
    /* B826C 800C7A6C 21200002 */  addu       $a0, $s0, $zero
    /* B8270 800C7A70 01000524 */  addiu      $a1, $zero, 0x1
    /* B8274 800C7A74 21304000 */  addu       $a2, $v0, $zero
    /* B8278 800C7A78 7800A88F */  lw         $t0, 0x78($sp)
    /* B827C 800C7A7C 21386002 */  addu       $a3, $s3, $zero
    /* B8280 800C7A80 C6CF010C */  jal        Anim_GetRotPos__FP15Trk_AnimateInstiiP8coorddefP10matrixtdef
    /* B8284 800C7A84 1000A8AF */   sw        $t0, 0x10($sp)
    /* B8288 800C7A88 FFFF0824 */  addiu      $t0, $zero, -0x1
    /* B828C 800C7A8C 0600C812 */  beq        $s6, $t0, .L800C7AA8
    /* B8290 800C7A90 21206002 */   addu      $a0, $s3, $zero
    /* B8294 800C7A94 71F5010C */  jal        xzsquaredist32__FP8coorddefT0
    /* B8298 800C7A98 0800E526 */   addiu     $a1, $s7, 0x8
    /* B829C 800C7A9C 2A105600 */  slt        $v0, $v0, $s6
    /* B82A0 800C7AA0 2C004010 */  beqz       $v0, .L800C7B54
    /* B82A4 800C7AA4 00000000 */   nop
  .L800C7AA8:
    /* B82A8 800C7AA8 2120E002 */  addu       $a0, $s7, $zero
    /* B82AC 800C7AAC 2128C003 */  addu       $a1, $fp, $zero
    /* B82B0 800C7AB0 06000286 */  lh         $v0, 0x6($s0)
    /* B82B4 800C7AB4 1480033C */  lui        $v1, %hi(Track_gObjDefs)
    /* B82B8 800C7AB8 D4D4638C */  lw         $v1, %lo(Track_gObjDefs)($v1)
    /* B82BC 800C7ABC 7800A68F */  lw         $a2, 0x78($sp)
    /* B82C0 800C7AC0 80100200 */  sll        $v0, $v0, 2
    /* B82C4 800C7AC4 21104300 */  addu       $v0, $v0, $v1
    /* B82C8 800C7AC8 0000518C */  lw         $s1, 0x0($v0)
    /* B82CC 800C7ACC FFFF0824 */  addiu      $t0, $zero, -0x1
    /* B82D0 800C7AD0 1000B3AF */  sw         $s3, 0x10($sp)
    /* B82D4 800C7AD4 1400B2AF */  sw         $s2, 0x14($sp)
    /* B82D8 800C7AD8 1800A8AF */  sw         $t0, 0x18($sp)
    /* B82DC 800C7ADC AF1F030C */  jal        DrawObjectTransform__FP13DRender_tViewP11Draw_DCacheP10matrixtdefP13Trk_ObjectDefP8coorddefis
    /* B82E0 800C7AE0 21382002 */   addu      $a3, $s1, $zero
    /* B82E4 800C7AE4 05000392 */  lbu        $v1, 0x5($s0)
    /* B82E8 800C7AE8 00000000 */  nop
    /* B82EC 800C7AEC 02006330 */  andi       $v1, $v1, 0x2
    /* B82F0 800C7AF0 18006010 */  beqz       $v1, .L800C7B54
    /* B82F4 800C7AF4 21A8A202 */   addu      $s5, $s5, $v0
    /* B82F8 800C7AF8 2120E002 */  addu       $a0, $s7, $zero
    /* B82FC 800C7AFC FFFF0524 */  addiu      $a1, $zero, -0x1
    /* B8300 800C7B00 3800A28F */  lw         $v0, 0x38($sp)
    /* B8304 800C7B04 4800A38F */  lw         $v1, 0x48($sp)
    /* B8308 800C7B08 00110200 */  sll        $v0, $v0, 4
    /* B830C 800C7B0C 23186200 */  subu       $v1, $v1, $v0
    /* B8310 800C7B10 3C00A28F */  lw         $v0, 0x3C($sp)
    /* B8314 800C7B14 1E000624 */  addiu      $a2, $zero, 0x1E
    /* B8318 800C7B18 5800A3AF */  sw         $v1, 0x58($sp)
    /* B831C 800C7B1C 4C00A38F */  lw         $v1, 0x4C($sp)
    /* B8320 800C7B20 00110200 */  sll        $v0, $v0, 4
    /* B8324 800C7B24 23186200 */  subu       $v1, $v1, $v0
    /* B8328 800C7B28 4000A28F */  lw         $v0, 0x40($sp)
    /* B832C 800C7B2C 21386002 */  addu       $a3, $s3, $zero
    /* B8330 800C7B30 5C00A3AF */  sw         $v1, 0x5C($sp)
    /* B8334 800C7B34 5000A38F */  lw         $v1, 0x50($sp)
    /* B8338 800C7B38 00110200 */  sll        $v0, $v0, 4
    /* B833C 800C7B3C 23186200 */  subu       $v1, $v1, $v0
    /* B8340 800C7B40 5800A227 */  addiu      $v0, $sp, 0x58
    /* B8344 800C7B44 6000A3AF */  sw         $v1, 0x60($sp)
    /* B8348 800C7B48 1000A2AF */  sw         $v0, 0x10($sp)
    /* B834C 800C7B4C 4C35030C */  jal        Flare_Halo2__FP13DRender_tViewiiP8coorddefT3P15Draw_FlareCache
    /* B8350 800C7B50 1400BEAF */   sw        $fp, 0x14($sp)
  .L800C7B54:
    /* B8354 800C7B54 00000286 */  lh         $v0, 0x0($s0)
    /* B8358 800C7B58 00000000 */  nop
    /* B835C 800C7B5C 21800202 */  addu       $s0, $s0, $v0
    /* B8360 800C7B60 551E0308 */  j          .L800C7954
    /* B8364 800C7B64 01009426 */   addiu     $s4, $s4, 0x1
  .L800C7B68:
    /* B8368 800C7B68 2110A002 */  addu       $v0, $s5, $zero
  .L800C7B6C:
    /* B836C 800C7B6C A400BF8F */  lw         $ra, 0xA4($sp)
    /* B8370 800C7B70 A000BE8F */  lw         $fp, 0xA0($sp)
    /* B8374 800C7B74 9C00B78F */  lw         $s7, 0x9C($sp)
    /* B8378 800C7B78 9800B68F */  lw         $s6, 0x98($sp)
    /* B837C 800C7B7C 9400B58F */  lw         $s5, 0x94($sp)
    /* B8380 800C7B80 9000B48F */  lw         $s4, 0x90($sp)
    /* B8384 800C7B84 8C00B38F */  lw         $s3, 0x8C($sp)
    /* B8388 800C7B88 8800B28F */  lw         $s2, 0x88($sp)
    /* B838C 800C7B8C 8400B18F */  lw         $s1, 0x84($sp)
    /* B8390 800C7B90 8000B08F */  lw         $s0, 0x80($sp)
    /* B8394 800C7B94 0800E003 */  jr         $ra
    /* B8398 800C7B98 A800BD27 */   addiu     $sp, $sp, 0xA8
endlabel DrawW_BuildObjectFacets__FP13DRender_tViewP15ChunkObjectInfo
