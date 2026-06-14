.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching creatememclass, 0x1F0

glabel creatememclass
    /* D5894 800E5094 B8FEBD27 */  addiu      $sp, $sp, -0x148
    /* D5898 800E5098 3C01B7AF */  sw         $s7, 0x13C($sp)
    /* D589C 800E509C 5C01B78F */  lw         $s7, 0x15C($sp)
    /* D58A0 800E50A0 3401B5AF */  sw         $s5, 0x134($sp)
    /* D58A4 800E50A4 6001B58F */  lw         $s5, 0x160($sp)
    /* D58A8 800E50A8 6401A28F */  lw         $v0, 0x164($sp)
    /* D58AC 800E50AC 6C01A38F */  lw         $v1, 0x16C($sp)
    /* D58B0 800E50B0 4001BEAF */  sw         $fp, 0x140($sp)
    /* D58B4 800E50B4 21F08000 */  addu       $fp, $a0, $zero
    /* D58B8 800E50B8 3801B6AF */  sw         $s6, 0x138($sp)
    /* D58BC 800E50BC 21B0A000 */  addu       $s6, $a1, $zero
    /* D58C0 800E50C0 3001B4AF */  sw         $s4, 0x130($sp)
    /* D58C4 800E50C4 21A0C000 */  addu       $s4, $a2, $zero
    /* D58C8 800E50C8 2801B2AF */  sw         $s2, 0x128($sp)
    /* D58CC 800E50CC 2190C003 */  addu       $s2, $fp, $zero
    /* D58D0 800E50D0 4401BFAF */  sw         $ra, 0x144($sp)
    /* D58D4 800E50D4 2C01B3AF */  sw         $s3, 0x12C($sp)
    /* D58D8 800E50D8 2401B1AF */  sw         $s1, 0x124($sp)
    /* D58DC 800E50DC 02004010 */  beqz       $v0, .L800E50E8
    /* D58E0 800E50E0 2001B0AF */   sw        $s0, 0x120($sp)
    /* D58E4 800E50E4 00025236 */  ori        $s2, $s2, 0x200
  .L800E50E8:
    /* D58E8 800E50E8 02006010 */  beqz       $v1, .L800E50F4
    /* D58EC 800E50EC 2000A427 */   addiu     $a0, $sp, 0x20
    /* D58F0 800E50F0 00015236 */  ori        $s2, $s2, 0x100
  .L800E50F4:
    /* D58F4 800E50F4 1480053C */  lui        $a1, %hi(D_8013DC20)
    /* D58F8 800E50F8 20DCA524 */  addiu      $a1, $a1, %lo(D_8013DC20)
    /* D58FC 800E50FC 2130C002 */  addu       $a2, $s6, $zero
    /* D5900 800E5100 5000A226 */  addiu      $v0, $s5, 0x50
    /* D5904 800E5104 21108202 */  addu       $v0, $s4, $v0
    /* D5908 800E5108 1F00E326 */  addiu      $v1, $s7, 0x1F
    /* D590C 800E510C 21104300 */  addu       $v0, $v0, $v1
    /* D5910 800E5110 23181700 */  negu       $v1, $s7
    /* D5914 800E5114 24104300 */  and        $v0, $v0, $v1
    /* D5918 800E5118 F0FF5324 */  addiu      $s3, $v0, -0x10
    /* D591C 800E511C 21808702 */  addu       $s0, $s4, $a3
    /* D5920 800E5120 2000A226 */  addiu      $v0, $s5, 0x20
    /* D5924 800E5124 23800202 */  subu       $s0, $s0, $v0
    /* D5928 800E5128 2F91030C */  jal        sprintf
    /* D592C 800E512C 10009126 */   addiu     $s1, $s4, 0x10
    /* D5930 800E5130 21208002 */  addu       $a0, $s4, $zero
    /* D5934 800E5134 2000A527 */  addiu      $a1, $sp, 0x20
    /* D5938 800E5138 40000624 */  addiu      $a2, $zero, 0x40
    /* D593C 800E513C 2138A002 */  addu       $a3, $s5, $zero
    /* D5940 800E5140 00804236 */  ori        $v0, $s2, 0x8000
    /* D5944 800E5144 1000A2AF */  sw         $v0, 0x10($sp)
    /* D5948 800E5148 1400A0AF */  sw         $zero, 0x14($sp)
    /* D594C 800E514C CB93030C */  jal        initmemblock
    /* D5950 800E5150 1800B3AF */   sw        $s3, 0x18($sp)
    /* D5954 800E5154 21206002 */  addu       $a0, $s3, $zero
    /* D5958 800E5158 21280000 */  addu       $a1, $zero, $zero
    /* D595C 800E515C 23301302 */  subu       $a2, $s0, $s3
    /* D5960 800E5160 F0FFC624 */  addiu      $a2, $a2, -0x10
    /* D5964 800E5164 2138A002 */  addu       $a3, $s5, $zero
    /* D5968 800E5168 1000B2AF */  sw         $s2, 0x10($sp)
    /* D596C 800E516C 1400B4AF */  sw         $s4, 0x14($sp)
    /* D5970 800E5170 CB93030C */  jal        initmemblock
    /* D5974 800E5174 1800B0AF */   sw        $s0, 0x18($sp)
    /* D5978 800E5178 2000A427 */  addiu      $a0, $sp, 0x20
    /* D597C 800E517C 1480053C */  lui        $a1, %hi(D_8013DC28)
    /* D5980 800E5180 28DCA524 */  addiu      $a1, $a1, %lo(D_8013DC28)
    /* D5984 800E5184 2F91030C */  jal        sprintf
    /* D5988 800E5188 2130C002 */   addu      $a2, $s6, $zero
    /* D598C 800E518C 21200002 */  addu       $a0, $s0, $zero
    /* D5990 800E5190 2000A527 */  addiu      $a1, $sp, 0x20
    /* D5994 800E5194 21300000 */  addu       $a2, $zero, $zero
    /* D5998 800E5198 2138A002 */  addu       $a3, $s5, $zero
    /* D599C 800E519C 10804236 */  ori        $v0, $s2, 0x8010
    /* D59A0 800E51A0 1000A2AF */  sw         $v0, 0x10($sp)
    /* D59A4 800E51A4 1400B3AF */  sw         $s3, 0x14($sp)
    /* D59A8 800E51A8 CB93030C */  jal        initmemblock
    /* D59AC 800E51AC 1800A0AF */   sw        $zero, 0x18($sp)
    /* D59B0 800E51B0 21202002 */  addu       $a0, $s1, $zero
    /* D59B4 800E51B4 40000524 */  addiu      $a1, $zero, 0x40
    /* D59B8 800E51B8 1480033C */  lui        $v1, %hi(memclass)
    /* D59BC 800E51BC 00E96324 */  addiu      $v1, $v1, %lo(memclass)
    /* D59C0 800E51C0 0F00C233 */  andi       $v0, $fp, 0xF
    /* D59C4 800E51C4 80100200 */  sll        $v0, $v0, 2
    /* D59C8 800E51C8 21104300 */  addu       $v0, $v0, $v1
    /* D59CC 800E51CC E8C5030C */  jal        blockclear
    /* D59D0 800E51D0 000051AC */   sw        $s1, 0x0($v0)
    /* D59D4 800E51D4 21202002 */  addu       $a0, $s1, $zero
    /* D59D8 800E51D8 CA96030C */  jal        strcpy
    /* D59DC 800E51DC 2128C002 */   addu      $a1, $s6, $zero
    /* D59E0 800E51E0 FF7F033C */  lui        $v1, (0x7FFFFFFF >> 16)
    /* D59E4 800E51E4 FFFF6334 */  ori        $v1, $v1, (0x7FFFFFFF & 0xFFFF)
    /* D59E8 800E51E8 53420224 */  addiu      $v0, $zero, 0x4253
    /* D59EC 800E51EC 100022A6 */  sh         $v0, 0x10($s1)
    /* D59F0 800E51F0 20008226 */  addiu      $v0, $s4, 0x20
    /* D59F4 800E51F4 080034AE */  sw         $s4, 0x8($s1)
    /* D59F8 800E51F8 0C0030AE */  sw         $s0, 0xC($s1)
    /* D59FC 800E51FC 200022AE */  sw         $v0, 0x20($s1)
    /* D5A00 800E5200 240022AE */  sw         $v0, 0x24($s1)
    /* D5A04 800E5204 140023AE */  sw         $v1, 0x14($s1)
    /* D5A08 800E5208 5801A28F */  lw         $v0, 0x158($sp)
    /* D5A0C 800E520C 21202002 */  addu       $a0, $s1, $zero
    /* D5A10 800E5210 2C0037AE */  sw         $s7, 0x2C($s1)
    /* D5A14 800E5214 300035AE */  sw         $s5, 0x30($s1)
    /* D5A18 800E5218 340032AE */  sw         $s2, 0x34($s1)
    /* D5A1C 800E521C 380020AE */  sw         $zero, 0x38($s1)
    /* D5A20 800E5220 280022AE */  sw         $v0, 0x28($s1)
    /* D5A24 800E5224 7401A28F */  lw         $v0, 0x174($sp)
    /* D5A28 800E5228 21286002 */  addu       $a1, $s3, $zero
    /* D5A2C 800E522C 9C93030C */  jal        FREE_add
    /* D5A30 800E5230 3C0022AE */   sw        $v0, 0x3C($s1)
    /* D5A34 800E5234 7001A88F */  lw         $t0, 0x170($sp)
    /* D5A38 800E5238 00000000 */  nop
    /* D5A3C 800E523C 04000011 */  beqz       $t0, .L800E5250
    /* D5A40 800E5240 00000000 */   nop
    /* D5A44 800E5244 09F9030C */  jal        allocmutex
    /* D5A48 800E5248 00000000 */   nop
    /* D5A4C 800E524C 380022AE */  sw         $v0, 0x38($s1)
  .L800E5250:
    /* D5A50 800E5250 0400628E */  lw         $v0, 0x4($s3)
    /* D5A54 800E5254 4401BF8F */  lw         $ra, 0x144($sp)
    /* D5A58 800E5258 4001BE8F */  lw         $fp, 0x140($sp)
    /* D5A5C 800E525C 3C01B78F */  lw         $s7, 0x13C($sp)
    /* D5A60 800E5260 3801B68F */  lw         $s6, 0x138($sp)
    /* D5A64 800E5264 3401B58F */  lw         $s5, 0x134($sp)
    /* D5A68 800E5268 3001B48F */  lw         $s4, 0x130($sp)
    /* D5A6C 800E526C 2C01B38F */  lw         $s3, 0x12C($sp)
    /* D5A70 800E5270 2801B28F */  lw         $s2, 0x128($sp)
    /* D5A74 800E5274 2401B18F */  lw         $s1, 0x124($sp)
    /* D5A78 800E5278 2001B08F */  lw         $s0, 0x120($sp)
    /* D5A7C 800E527C 0800E003 */  jr         $ra
    /* D5A80 800E5280 4801BD27 */   addiu     $sp, $sp, 0x148
endlabel creatememclass
