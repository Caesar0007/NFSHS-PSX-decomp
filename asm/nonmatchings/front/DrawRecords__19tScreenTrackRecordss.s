.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawRecords__19tScreenTrackRecordss, 0x1E0

glabel DrawRecords__19tScreenTrackRecordss
    /* 33168 80042968 C0FFBD27 */  addiu      $sp, $sp, -0x40
    /* 3316C 8004296C 2800B4AF */  sw         $s4, 0x28($sp)
    /* 33170 80042970 21A08000 */  addu       $s4, $a0, $zero
    /* 33174 80042974 3C00BFAF */  sw         $ra, 0x3C($sp)
    /* 33178 80042978 3800BEAF */  sw         $fp, 0x38($sp)
    /* 3317C 8004297C 3400B7AF */  sw         $s7, 0x34($sp)
    /* 33180 80042980 3000B6AF */  sw         $s6, 0x30($sp)
    /* 33184 80042984 2C00B5AF */  sw         $s5, 0x2C($sp)
    /* 33188 80042988 2400B3AF */  sw         $s3, 0x24($sp)
    /* 3318C 8004298C 2000B2AF */  sw         $s2, 0x20($sp)
    /* 33190 80042990 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* 33194 80042994 1800B0AF */  sw         $s0, 0x18($sp)
    /* 33198 80042998 6C00828E */  lw         $v0, 0x6C($s4)
    /* 3319C 8004299C 00000000 */  nop
    /* 331A0 800429A0 01004224 */  addiu      $v0, $v0, 0x1
    /* 331A4 800429A4 6C0082AE */  sw         $v0, 0x6C($s4)
    /* 331A8 800429A8 3D004228 */  slti       $v0, $v0, 0x3D
    /* 331AC 800429AC 02004014 */  bnez       $v0, .L800429B8
    /* 331B0 800429B0 21F0A000 */   addu      $fp, $a1, $zero
    /* 331B4 800429B4 6C0080AE */  sw         $zero, 0x6C($s4)
  .L800429B8:
    /* 331B8 800429B8 6C00838E */  lw         $v1, 0x6C($s4)
    /* 331BC 800429BC 00000000 */  nop
    /* 331C0 800429C0 1F006228 */  slti       $v0, $v1, 0x1F
    /* 331C4 800429C4 04004014 */  bnez       $v0, .L800429D8
    /* 331C8 800429C8 C2170300 */   srl       $v0, $v1, 31
    /* 331CC 800429CC 3C000224 */  addiu      $v0, $zero, 0x3C
    /* 331D0 800429D0 23104300 */  subu       $v0, $v0, $v1
    /* 331D4 800429D4 C21F0200 */  srl        $v1, $v0, 31
  .L800429D8:
    /* 331D8 800429D8 21106200 */  addu       $v0, $v1, $v0
    /* 331DC 800429DC 43100200 */  sra        $v0, $v0, 1
    /* 331E0 800429E0 680082AE */  sw         $v0, 0x68($s4)
    /* 331E4 800429E4 6800828E */  lw         $v0, 0x68($s4)
    /* 331E8 800429E8 00000000 */  nop
    /* 331EC 800429EC 14004224 */  addiu      $v0, $v0, 0x14
    /* 331F0 800429F0 C0110200 */  sll        $v0, $v0, 7
    /* 331F4 800429F4 F09F000C */  jal        Front_GetLapsForType__Fv
    /* 331F8 800429F8 680082AE */   sw        $v0, 0x68($s4)
    /* 331FC 800429FC 02000324 */  addiu      $v1, $zero, 0x2
    /* 33200 80042A00 02004314 */  bne        $v0, $v1, .L80042A0C
    /* 33204 80042A04 09000424 */   addiu     $a0, $zero, 0x9
    /* 33208 80042A08 01000424 */  addiu      $a0, $zero, 0x1
  .L80042A0C:
    /* 3320C 80042A0C 21900000 */  addu       $s2, $zero, $zero
    /* 33210 80042A10 00141E00 */  sll        $v0, $fp, 16
    /* 33214 80042A14 03BC0200 */  sra        $s7, $v0, 16
    /* 33218 80042A18 0580023C */  lui        $v0, %hi(NewRecords)
    /* 3321C 80042A1C 78295524 */  addiu      $s5, $v0, %lo(NewRecords)
    /* 33220 80042A20 21B08000 */  addu       $s6, $a0, $zero
    /* 33224 80042A24 00141200 */  sll        $v0, $s2, 16
  .L80042A28:
    /* 33228 80042A28 038C0200 */  sra        $s1, $v0, 16
    /* 3322C 80042A2C 2A103702 */  slt        $v0, $s1, $s7
    /* 33230 80042A30 2C004010 */  beqz       $v0, .L80042AE4
    /* 33234 80042A34 57023026 */   addiu     $s0, $s1, 0x257
    /* 33238 80042A38 94E4020C */  jal        TextSys_Word__Fi
    /* 3323C 80042A3C 21200002 */   addu      $a0, $s0, $zero
    /* 33240 80042A40 49020424 */  addiu      $a0, $zero, 0x249
    /* 33244 80042A44 A4E4020C */  jal        TextSys_WordX__Fi
    /* 33248 80042A48 21984000 */   addu      $s3, $v0, $zero
    /* 3324C 80042A4C 21200002 */  addu       $a0, $s0, $zero
    /* 33250 80042A50 00140200 */  sll        $v0, $v0, 16
    /* 33254 80042A54 ACE4020C */  jal        TextSys_WordY__Fi
    /* 33258 80042A58 03840200 */   sra       $s0, $v0, 16
    /* 3325C 80042A5C 00140200 */  sll        $v0, $v0, 16
    /* 33260 80042A60 80181100 */  sll        $v1, $s1, 2
    /* 33264 80042A64 21187500 */  addu       $v1, $v1, $s5
    /* 33268 80042A68 0000638C */  lw         $v1, 0x0($v1)
    /* 3326C 80042A6C 00000000 */  nop
    /* 33270 80042A70 04006010 */  beqz       $v1, .L80042A84
    /* 33274 80042A74 03340200 */   sra       $a2, $v0, 16
    /* 33278 80042A78 02000224 */  addiu      $v0, $zero, 0x2
    /* 3327C 80042A7C A20A0108 */  j          .L80042A88
    /* 33280 80042A80 1000A2AF */   sw        $v0, 0x10($sp)
  .L80042A84:
    /* 33284 80042A84 1000A0AF */  sw         $zero, 0x10($sp)
  .L80042A88:
    /* 33288 80042A88 21206002 */  addu       $a0, $s3, $zero
    /* 3328C 80042A8C 21280002 */  addu       $a1, $s0, $zero
    /* 33290 80042A90 0B000724 */  addiu      $a3, $zero, 0xB
    /* 33294 80042A94 B083000C */  jal        FETextRender_FullText__FPcss13tMenuTextType14tMenuTextStates
    /* 33298 80042A98 1400A0AF */   sw        $zero, 0x14($sp)
    /* 3329C 80042A9C 00841200 */  sll        $s0, $s2, 16
    /* 332A0 80042AA0 03841000 */  sra        $s0, $s0, 16
    /* 332A4 80042AA4 ACE4020C */  jal        TextSys_WordY__Fi
    /* 332A8 80042AA8 57020426 */   addiu     $a0, $s0, 0x257
    /* 332AC 80042AAC 21208002 */  addu       $a0, $s4, $zero
    /* 332B0 80042AB0 21281602 */  addu       $a1, $s0, $s6
    /* 332B4 80042AB4 80801000 */  sll        $s0, $s0, 2
    /* 332B8 80042AB8 21801502 */  addu       $s0, $s0, $s5
    /* 332BC 80042ABC 0000068E */  lw         $a2, 0x0($s0)
    /* 332C0 80042AC0 C009010C */  jal        DrawOneRecord__19tScreenTrackRecordsibi
    /* 332C4 80042AC4 21384000 */   addu      $a3, $v0, $zero
    /* 332C8 80042AC8 01004226 */  addiu      $v0, $s2, 0x1
    /* 332CC 80042ACC 21904000 */  addu       $s2, $v0, $zero
    /* 332D0 80042AD0 00140200 */  sll        $v0, $v0, 16
    /* 332D4 80042AD4 03140200 */  sra        $v0, $v0, 16
    /* 332D8 80042AD8 08004228 */  slti       $v0, $v0, 0x8
    /* 332DC 80042ADC D2FF4014 */  bnez       $v0, .L80042A28
    /* 332E0 80042AE0 00141200 */   sll       $v0, $s2, 16
  .L80042AE4:
    /* 332E4 80042AE4 00141E00 */  sll        $v0, $fp, 16
    /* 332E8 80042AE8 03140200 */  sra        $v0, $v0, 16
    /* 332EC 80042AEC 09004228 */  slti       $v0, $v0, 0x9
    /* 332F0 80042AF0 09004014 */  bnez       $v0, .L80042B18
    /* 332F4 80042AF4 00000000 */   nop
    /* 332F8 80042AF8 ACE4020C */  jal        TextSys_WordY__Fi
    /* 332FC 80042AFC 60020424 */   addiu     $a0, $zero, 0x260
    /* 33300 80042B00 21208002 */  addu       $a0, $s4, $zero
    /* 33304 80042B04 21280000 */  addu       $a1, $zero, $zero
    /* 33308 80042B08 0580033C */  lui        $v1, %hi(NewBestLap)
    /* 3330C 80042B0C 9829668C */  lw         $a2, %lo(NewBestLap)($v1)
    /* 33310 80042B10 C009010C */  jal        DrawOneRecord__19tScreenTrackRecordsibi
    /* 33314 80042B14 21384000 */   addu      $a3, $v0, $zero
  .L80042B18:
    /* 33318 80042B18 3C00BF8F */  lw         $ra, 0x3C($sp)
    /* 3331C 80042B1C 3800BE8F */  lw         $fp, 0x38($sp)
    /* 33320 80042B20 3400B78F */  lw         $s7, 0x34($sp)
    /* 33324 80042B24 3000B68F */  lw         $s6, 0x30($sp)
    /* 33328 80042B28 2C00B58F */  lw         $s5, 0x2C($sp)
    /* 3332C 80042B2C 2800B48F */  lw         $s4, 0x28($sp)
    /* 33330 80042B30 2400B38F */  lw         $s3, 0x24($sp)
    /* 33334 80042B34 2000B28F */  lw         $s2, 0x20($sp)
    /* 33338 80042B38 1C00B18F */  lw         $s1, 0x1C($sp)
    /* 3333C 80042B3C 1800B08F */  lw         $s0, 0x18($sp)
    /* 33340 80042B40 0800E003 */  jr         $ra
    /* 33344 80042B44 4000BD27 */   addiu     $sp, $sp, 0x40
endlabel DrawRecords__19tScreenTrackRecordss
