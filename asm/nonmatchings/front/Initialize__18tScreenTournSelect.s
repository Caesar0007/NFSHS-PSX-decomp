.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Initialize__18tScreenTournSelect, 0x248

glabel Initialize__18tScreenTournSelect
    /* 300A0 8003F8A0 70FFBD27 */  addiu      $sp, $sp, -0x90
    /* 300A4 8003F8A4 7C00B3AF */  sw         $s3, 0x7C($sp)
    /* 300A8 8003F8A8 21988000 */  addu       $s3, $a0, $zero
    /* 300AC 8003F8AC 1800A427 */  addiu      $a0, $sp, 0x18
    /* 300B0 8003F8B0 21280000 */  addu       $a1, $zero, $zero
    /* 300B4 8003F8B4 2130A000 */  addu       $a2, $a1, $zero
    /* 300B8 8003F8B8 2138A000 */  addu       $a3, $a1, $zero
    /* 300BC 8003F8BC FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 300C0 8003F8C0 8C00BFAF */  sw         $ra, 0x8C($sp)
    /* 300C4 8003F8C4 8800B6AF */  sw         $s6, 0x88($sp)
    /* 300C8 8003F8C8 8400B5AF */  sw         $s5, 0x84($sp)
    /* 300CC 8003F8CC 8000B4AF */  sw         $s4, 0x80($sp)
    /* 300D0 8003F8D0 7800B2AF */  sw         $s2, 0x78($sp)
    /* 300D4 8003F8D4 7400B1AF */  sw         $s1, 0x74($sp)
    /* 300D8 8003F8D8 7000B0AF */  sw         $s0, 0x70($sp)
    /* 300DC 8003F8DC C00262AE */  sw         $v0, 0x2C0($s3)
    /* 300E0 8003F8E0 C40262AE */  sw         $v0, 0x2C4($s3)
    /* 300E4 8003F8E4 00020224 */  addiu      $v0, $zero, 0x200
    /* 300E8 8003F8E8 1800A2A7 */  sh         $v0, 0x18($sp)
    /* 300EC 8003F8EC 50000224 */  addiu      $v0, $zero, 0x50
    /* 300F0 8003F8F0 1C00A2A7 */  sh         $v0, 0x1C($sp)
    /* 300F4 8003F8F4 A0000224 */  addiu      $v0, $zero, 0xA0
    /* 300F8 8003F8F8 1A00A0A7 */  sh         $zero, 0x1A($sp)
    /* 300FC 8003F8FC 80B6030C */  jal        ClearImage
    /* 30100 8003F900 1E00A2A7 */   sh        $v0, 0x1E($sp)
    /* 30104 8003F904 1FB6030C */  jal        DrawSync
    /* 30108 8003F908 21200000 */   addu      $a0, $zero, $zero
    /* 3010C 8003F90C 2B98000C */  jal        Initialize__7tScreen
    /* 30110 8003F910 21206002 */   addu      $a0, $s3, $zero
    /* 30114 8003F914 2000B027 */  addiu      $s0, $sp, 0x20
    /* 30118 8003F918 21200002 */  addu       $a0, $s0, $zero
    /* 3011C 8003F91C 1180023C */  lui        $v0, %hi(D_8011650C)
    /* 30120 8003F920 0180053C */  lui        $a1, %hi(D_80011D9C)
    /* 30124 8003F924 AE0260A6 */  sh         $zero, 0x2AE($s3)
    /* 30128 8003F928 AC0260A6 */  sh         $zero, 0x2AC($s3)
    /* 3012C 8003F92C 0C65468C */  lw         $a2, %lo(D_8011650C)($v0)
    /* 30130 8003F930 2F91030C */  jal        sprintf
    /* 30134 8003F934 9C1DA524 */   addiu     $a1, $a1, %lo(D_80011D9C)
    /* 30138 8003F938 50000424 */  addiu      $a0, $zero, 0x50
    /* 3013C 8003F93C 21288000 */  addu       $a1, $a0, $zero
    /* 30140 8003F940 0F00063C */  lui        $a2, (0xF0000 >> 16)
    /* 30144 8003F944 0200073C */  lui        $a3, (0x25800 >> 16)
    /* 30148 8003F948 0058E734 */  ori        $a3, $a3, (0x25800 & 0xFFFF)
    /* 3014C 8003F94C 10000224 */  addiu      $v0, $zero, 0x10
    /* 30150 8003F950 3243010C */  jal        VIDEO_create__Fiiiii
    /* 30154 8003F954 1000A2AF */   sw        $v0, 0x10($sp)
    /* 30158 8003F958 21204000 */  addu       $a0, $v0, $zero
    /* 3015C 8003F95C 21280002 */  addu       $a1, $s0, $zero
    /* 30160 8003F960 A643010C */  jal        VIDEO_spoolfile__FiPc
    /* 30164 8003F964 640064AE */   sw        $a0, 0x64($s3)
    /* 30168 8003F968 6400648E */  lw         $a0, 0x64($s3)
    /* 3016C 8003F96C BD43010C */  jal        VIDEO_startplayback__Fi
    /* 30170 8003F970 21A80000 */   addu      $s5, $zero, $zero
    /* 30174 8003F974 680060AE */  sw         $zero, 0x68($s3)
    /* 30178 8003F978 21900000 */  addu       $s2, $zero, $zero
  .L8003F97C:
    /* 3017C 8003F97C 001C1500 */  sll        $v1, $s5, 16
    /* 30180 8003F980 031C0300 */  sra        $v1, $v1, 16
    /* 30184 8003F984 40B00300 */  sll        $s6, $v1, 1
    /* 30188 8003F988 80100300 */  sll        $v0, $v1, 2
    /* 3018C 8003F98C 21104300 */  addu       $v0, $v0, $v1
    /* 30190 8003F990 80100200 */  sll        $v0, $v0, 2
    /* 30194 8003F994 23104300 */  subu       $v0, $v0, $v1
    /* 30198 8003F998 80100200 */  sll        $v0, $v0, 2
    /* 3019C 8003F99C A5005424 */  addiu      $s4, $v0, 0xA5
  .L8003F9A0:
    /* 301A0 8003F9A0 008C1200 */  sll        $s1, $s2, 16
    /* 301A4 8003F9A4 038C1100 */  sra        $s1, $s1, 16
    /* 301A8 8003F9A8 2110D102 */  addu       $v0, $s6, $s1
    /* 301AC 8003F9AC 40800200 */  sll        $s0, $v0, 1
    /* 301B0 8003F9B0 21800202 */  addu       $s0, $s0, $v0
    /* 301B4 8003F9B4 00811000 */  sll        $s0, $s0, 4
    /* 301B8 8003F9B8 EC010426 */  addiu      $a0, $s0, 0x1EC
    /* 301BC 8003F9BC 21206402 */  addu       $a0, $s3, $a0
    /* 301C0 8003F9C0 0000658E */  lw         $a1, 0x0($s3)
    /* 301C4 8003F9C4 028C000C */  jal        InitTV__FR9tTVConfigP18tTexture_ShapeInfos
    /* 301C8 8003F9C8 21300000 */   addu      $a2, $zero, $zero
    /* 301CC 8003F9CC 01004426 */  addiu      $a0, $s2, 0x1
    /* 301D0 8003F9D0 21908000 */  addu       $s2, $a0, $zero
    /* 301D4 8003F9D4 21807002 */  addu       $s0, $s3, $s0
    /* 301D8 8003F9D8 C0101100 */  sll        $v0, $s1, 3
    /* 301DC 8003F9DC 21105100 */  addu       $v0, $v0, $s1
    /* 301E0 8003F9E0 80100200 */  sll        $v0, $v0, 2
    /* 301E4 8003F9E4 21105100 */  addu       $v0, $v0, $s1
    /* 301E8 8003F9E8 8E004224 */  addiu      $v0, $v0, 0x8E
    /* 301EC 8003F9EC 020202A6 */  sh         $v0, 0x202($s0)
    /* 301F0 8003F9F0 4C000224 */  addiu      $v0, $zero, 0x4C
    /* 301F4 8003F9F4 040202A6 */  sh         $v0, 0x204($s0)
    /* 301F8 8003F9F8 25000224 */  addiu      $v0, $zero, 0x25
    /* 301FC 8003F9FC 00240400 */  sll        $a0, $a0, 16
    /* 30200 8003FA00 03240400 */  sra        $a0, $a0, 16
    /* 30204 8003FA04 F4010396 */  lhu        $v1, 0x1F4($s0)
    /* 30208 8003FA08 02008428 */  slti       $a0, $a0, 0x2
    /* 3020C 8003FA0C 000214A6 */  sh         $s4, 0x200($s0)
    /* 30210 8003FA10 060202A6 */  sh         $v0, 0x206($s0)
    /* 30214 8003FA14 30006334 */  ori        $v1, $v1, 0x30
    /* 30218 8003FA18 E1FF8014 */  bnez       $a0, .L8003F9A0
    /* 3021C 8003FA1C F40103A6 */   sh        $v1, 0x1F4($s0)
    /* 30220 8003FA20 0100A226 */  addiu      $v0, $s5, 0x1
    /* 30224 8003FA24 21A84000 */  addu       $s5, $v0, $zero
    /* 30228 8003FA28 00140200 */  sll        $v0, $v0, 16
    /* 3022C 8003FA2C 03140200 */  sra        $v0, $v0, 16
    /* 30230 8003FA30 02004228 */  slti       $v0, $v0, 0x2
    /* 30234 8003FA34 D1FF4014 */  bnez       $v0, .L8003F97C
    /* 30238 8003FA38 21900000 */   addu      $s2, $zero, $zero
    /* 3023C 8003FA3C 1180023C */  lui        $v0, %hi(frontEnd)
    /* 30240 8003FA40 00464324 */  addiu      $v1, $v0, %lo(frontEnd)
    /* 30244 8003FA44 22016290 */  lbu        $v0, 0x122($v1)
    /* 30248 8003FA48 00000000 */  nop
    /* 3024C 8003FA4C 04004010 */  beqz       $v0, .L8003FA60
    /* 30250 8003FA50 1180043C */   lui       $a0, %hi(D_80114AF0)
    /* 30254 8003FA54 21016590 */  lbu        $a1, 0x121($v1)
    /* 30258 8003FA58 99FE0008 */  j          .L8003FA64
    /* 3025C 8003FA5C 00000000 */   nop
  .L8003FA60:
    /* 30260 8003FA60 20016590 */  lbu        $a1, 0x120($v1)
  .L8003FA64:
    /* 30264 8003FA64 22016390 */  lbu        $v1, 0x122($v1)
    /* 30268 8003FA68 F04A848C */  lw         $a0, %lo(D_80114AF0)($a0)
    /* 3026C 8003FA6C 40100300 */  sll        $v0, $v1, 1
    /* 30270 8003FA70 21104300 */  addu       $v0, $v0, $v1
    /* 30274 8003FA74 80100200 */  sll        $v0, $v0, 2
    /* 30278 8003FA78 21108200 */  addu       $v0, $a0, $v0
    /* 3027C 8003FA7C 02004390 */  lbu        $v1, 0x2($v0)
    /* 30280 8003FA80 00000000 */  nop
    /* 30284 8003FA84 2118A300 */  addu       $v1, $a1, $v1
    /* 30288 8003FA88 80100300 */  sll        $v0, $v1, 2
    /* 3028C 8003FA8C 21104300 */  addu       $v0, $v0, $v1
    /* 30290 8003FA90 80100200 */  sll        $v0, $v0, 2
    /* 30294 8003FA94 21104300 */  addu       $v0, $v0, $v1
    /* 30298 8003FA98 80100200 */  sll        $v0, $v0, 2
    /* 3029C 8003FA9C 21104400 */  addu       $v0, $v0, $a0
    /* 302A0 8003FAA0 3A004290 */  lbu        $v0, 0x3A($v0)
    /* 302A4 8003FAA4 00000000 */  nop
    /* 302A8 8003FAA8 BA0262A2 */  sb         $v0, 0x2BA($s3)
    /* 302AC 8003FAAC 1480023C */  lui        $v0, %hi(ticks)
    /* 302B0 8003FAB0 ACDC438C */  lw         $v1, %lo(ticks)($v0)
    /* 302B4 8003FAB4 01000224 */  addiu      $v0, $zero, 0x1
    /* 302B8 8003FAB8 B80262A6 */  sh         $v0, 0x2B8($s3)
    /* 302BC 8003FABC B40263AE */  sw         $v1, 0x2B4($s3)
    /* 302C0 8003FAC0 8C00BF8F */  lw         $ra, 0x8C($sp)
    /* 302C4 8003FAC4 8800B68F */  lw         $s6, 0x88($sp)
    /* 302C8 8003FAC8 8400B58F */  lw         $s5, 0x84($sp)
    /* 302CC 8003FACC 8000B48F */  lw         $s4, 0x80($sp)
    /* 302D0 8003FAD0 7C00B38F */  lw         $s3, 0x7C($sp)
    /* 302D4 8003FAD4 7800B28F */  lw         $s2, 0x78($sp)
    /* 302D8 8003FAD8 7400B18F */  lw         $s1, 0x74($sp)
    /* 302DC 8003FADC 7000B08F */  lw         $s0, 0x70($sp)
    /* 302E0 8003FAE0 0800E003 */  jr         $ra
    /* 302E4 8003FAE4 9000BD27 */   addiu     $sp, $sp, 0x90
endlabel Initialize__18tScreenTournSelect
