.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MCRD_savefile, 0x23C

glabel MCRD_savefile
    /* 4024C 8004FA4C D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 40250 8004FA50 1800B2AF */  sw         $s2, 0x18($sp)
    /* 40254 8004FA54 21908000 */  addu       $s2, $a0, $zero
    /* 40258 8004FA58 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 4025C 8004FA5C 2198A000 */  addu       $s3, $a1, $zero
    /* 40260 8004FA60 1400B1AF */  sw         $s1, 0x14($sp)
    /* 40264 8004FA64 0580113C */  lui        $s1, %hi(D_80052FC8)
    /* 40268 8004FA68 2400BFAF */  sw         $ra, 0x24($sp)
    /* 4026C 8004FA6C 2000B4AF */  sw         $s4, 0x20($sp)
    /* 40270 8004FA70 1000B0AF */  sw         $s0, 0x10($sp)
    /* 40274 8004FA74 0800628E */  lw         $v0, 0x8($s3)
    /* 40278 8004FA78 00000000 */  nop
    /* 4027C 8004FA7C 7F004230 */  andi       $v0, $v0, 0x7F
    /* 40280 8004FA80 46004014 */  bnez       $v0, .L8004FB9C
    /* 40284 8004FA84 C82F3426 */   addiu     $s4, $s1, %lo(D_80052FC8)
    /* 40288 8004FA88 21208002 */  addu       $a0, $s4, $zero
    /* 4028C 8004FA8C E8C5030C */  jal        blockclear
    /* 40290 8004FA90 3C020524 */   addiu     $a1, $zero, 0x23C
    /* 40294 8004FA94 04009026 */  addiu      $s0, $s4, 0x4
    /* 40298 8004FA98 21200002 */  addu       $a0, $s0, $zero
    /* 4029C 8004FA9C A4FD8526 */  addiu      $a1, $s4, -0x25C
    /* 402A0 8004FAA0 53000224 */  addiu      $v0, $zero, 0x53
    /* 402A4 8004FAA4 2C0082A2 */  sb         $v0, 0x2C($s4)
    /* 402A8 8004FAA8 43000224 */  addiu      $v0, $zero, 0x43
    /* 402AC 8004FAAC CA96030C */  jal        strcpy
    /* 402B0 8004FAB0 2D0082A2 */   sb        $v0, 0x2D($s4)
    /* 402B4 8004FAB4 0000658E */  lw         $a1, 0x0($s3)
    /* 402B8 8004FAB8 3A9E030C */  jal        strcat
    /* 402BC 8004FABC 21200002 */   addu      $a0, $s0, $zero
    /* 402C0 8004FAC0 C82F32AE */  sw         $s2, %lo(D_80052FC8)($s1)
    /* 402C4 8004FAC4 0800628E */  lw         $v0, 0x8($s3)
    /* 402C8 8004FAC8 00000000 */  nop
    /* 402CC 8004FACC 200082AE */  sw         $v0, 0x20($s4)
    /* 402D0 8004FAD0 1000628E */  lw         $v0, 0x10($s3)
    /* 402D4 8004FAD4 00000000 */  nop
    /* 402D8 8004FAD8 280082AE */  sw         $v0, 0x28($s4)
    /* 402DC 8004FADC 0C00628E */  lw         $v0, 0xC($s3)
    /* 402E0 8004FAE0 00000000 */  nop
    /* 402E4 8004FAE4 240082AE */  sw         $v0, 0x24($s4)
    /* 402E8 8004FAE8 1400628E */  lw         $v0, 0x14($s3)
    /* 402EC 8004FAEC 00000000 */  nop
    /* 402F0 8004FAF0 2C0282AE */  sw         $v0, 0x22C($s4)
    /* 402F4 8004FAF4 1000628E */  lw         $v0, 0x10($s3)
    /* 402F8 8004FAF8 00000000 */  nop
    /* 402FC 8004FAFC 00024230 */  andi       $v0, $v0, 0x200
    /* 40300 8004FB00 53004010 */  beqz       $v0, .L8004FC50
    /* 40304 8004FB04 21800000 */   addu      $s0, $zero, $zero
    /* 40308 8004FB08 21900002 */  addu       $s2, $s0, $zero
    /* 4030C 8004FB0C 21186002 */  addu       $v1, $s3, $zero
  .L8004FB10:
    /* 40310 8004FB10 1800628C */  lw         $v0, 0x18($v1)
    /* 40314 8004FB14 00000000 */  nop
    /* 40318 8004FB18 02004010 */  beqz       $v0, .L8004FB24
    /* 4031C 8004FB1C 00000000 */   nop
    /* 40320 8004FB20 01005226 */  addiu      $s2, $s2, 0x1
  .L8004FB24:
    /* 40324 8004FB24 01001026 */  addiu      $s0, $s0, 0x1
    /* 40328 8004FB28 0300022A */  slti       $v0, $s0, 0x3
    /* 4032C 8004FB2C F8FF4014 */  bnez       $v0, .L8004FB10
    /* 40330 8004FB30 04006324 */   addiu     $v1, $v1, 0x4
    /* 40334 8004FB34 4C004012 */  beqz       $s2, .L8004FC68
    /* 40338 8004FB38 FFFF0224 */   addiu     $v0, $zero, -0x1
    /* 4033C 8004FB3C 10004226 */  addiu      $v0, $s2, 0x10
    /* 40340 8004FB40 2E0082A2 */  sb         $v0, 0x2E($s4)
    /* 40344 8004FB44 0800638E */  lw         $v1, 0x8($s3)
    /* 40348 8004FB48 00000000 */  nop
    /* 4034C 8004FB4C 00206224 */  addiu      $v0, $v1, 0x2000
    /* 40350 8004FB50 03004104 */  bgez       $v0, .L8004FB60
    /* 40354 8004FB54 43130200 */   sra       $v0, $v0, 13
    /* 40358 8004FB58 FF3F6224 */  addiu      $v0, $v1, 0x3FFF
    /* 4035C 8004FB5C 43130200 */  sra        $v0, $v0, 13
  .L8004FB60:
    /* 40360 8004FB60 2F0082A2 */  sb         $v0, 0x2F($s4)
    /* 40364 8004FB64 0400648E */  lw         $a0, 0x4($s3)
    /* 40368 8004FB68 00000000 */  nop
    /* 4036C 8004FB6C 3E008010 */  beqz       $a0, .L8004FC68
    /* 40370 8004FB70 FFFF0224 */   addiu     $v0, $zero, -0x1
    /* 40374 8004FB74 DDA7030C */  jal        strlen
    /* 40378 8004FB78 00000000 */   nop
    /* 4037C 8004FB7C 3A004010 */  beqz       $v0, .L8004FC68
    /* 40380 8004FB80 FFFF0224 */   addiu     $v0, $zero, -0x1
    /* 40384 8004FB84 0400648E */  lw         $a0, 0x4($s3)
    /* 40388 8004FB88 DDA7030C */  jal        strlen
    /* 4038C 8004FB8C 00000000 */   nop
    /* 40390 8004FB90 2100422C */  sltiu      $v0, $v0, 0x21
    /* 40394 8004FB94 03004014 */  bnez       $v0, .L8004FBA4
    /* 40398 8004FB98 21800000 */   addu      $s0, $zero, $zero
  .L8004FB9C:
    /* 4039C 8004FB9C 1A3F0108 */  j          .L8004FC68
    /* 403A0 8004FBA0 FFFF0224 */   addiu     $v0, $zero, -0x1
  .L8004FBA4:
    /* 403A4 8004FBA4 21888002 */  addu       $s1, $s4, $zero
  .L8004FBA8:
    /* 403A8 8004FBA8 0400628E */  lw         $v0, 0x4($s3)
    /* 403AC 8004FBAC 00000000 */  nop
    /* 403B0 8004FBB0 21105000 */  addu       $v0, $v0, $s0
    /* 403B4 8004FBB4 00004490 */  lbu        $a0, 0x0($v0)
    /* 403B8 8004FBB8 BC41010C */  jal        func_800506F0
    /* 403BC 8004FBBC 00000000 */   nop
    /* 403C0 8004FBC0 300022A6 */  sh         $v0, 0x30($s1)
    /* 403C4 8004FBC4 FFFF4230 */  andi       $v0, $v0, 0xFFFF
    /* 403C8 8004FBC8 05004010 */  beqz       $v0, .L8004FBE0
    /* 403CC 8004FBCC 00000000 */   nop
    /* 403D0 8004FBD0 01001026 */  addiu      $s0, $s0, 0x1
    /* 403D4 8004FBD4 2000022A */  slti       $v0, $s0, 0x20
    /* 403D8 8004FBD8 F3FF4014 */  bnez       $v0, .L8004FBA8
    /* 403DC 8004FBDC 02003126 */   addiu     $s1, $s1, 0x2
  .L8004FBE0:
    /* 403E0 8004FBE0 1800648E */  lw         $a0, 0x18($s3)
    /* 403E4 8004FBE4 0FDB030C */  jal        getshapeclut
    /* 403E8 8004FBE8 00000000 */   nop
    /* 403EC 8004FBEC 10004424 */  addiu      $a0, $v0, 0x10
    /* 403F0 8004FBF0 8C008526 */  addiu      $a1, $s4, 0x8C
    /* 403F4 8004FBF4 B798030C */  jal        blockmove
    /* 403F8 8004FBF8 20000624 */   addiu     $a2, $zero, 0x20
    /* 403FC 8004FBFC AC008526 */  addiu      $a1, $s4, 0xAC
    /* 40400 8004FC00 1800648E */  lw         $a0, 0x18($s3)
    /* 40404 8004FC04 80000624 */  addiu      $a2, $zero, 0x80
    /* 40408 8004FC08 B798030C */  jal        blockmove
    /* 4040C 8004FC0C 10008424 */   addiu     $a0, $a0, 0x10
    /* 40410 8004FC10 0200422A */  slti       $v0, $s2, 0x2
    /* 40414 8004FC14 0F004014 */  bnez       $v0, .L8004FC54
    /* 40418 8004FC18 21100000 */   addu      $v0, $zero, $zero
    /* 4041C 8004FC1C 2C018526 */  addiu      $a1, $s4, 0x12C
    /* 40420 8004FC20 1C00648E */  lw         $a0, 0x1C($s3)
    /* 40424 8004FC24 80000624 */  addiu      $a2, $zero, 0x80
    /* 40428 8004FC28 B798030C */  jal        blockmove
    /* 4042C 8004FC2C 10008424 */   addiu     $a0, $a0, 0x10
    /* 40430 8004FC30 03000224 */  addiu      $v0, $zero, 0x3
    /* 40434 8004FC34 07004216 */  bne        $s2, $v0, .L8004FC54
    /* 40438 8004FC38 21100000 */   addu      $v0, $zero, $zero
    /* 4043C 8004FC3C AC018526 */  addiu      $a1, $s4, 0x1AC
    /* 40440 8004FC40 2000648E */  lw         $a0, 0x20($s3)
    /* 40444 8004FC44 80000624 */  addiu      $a2, $zero, 0x80
    /* 40448 8004FC48 B798030C */  jal        blockmove
    /* 4044C 8004FC4C 10008424 */   addiu     $a0, $a0, 0x10
  .L8004FC50:
    /* 40450 8004FC50 21100000 */  addu       $v0, $zero, $zero
  .L8004FC54:
    /* 40454 8004FC54 0580033C */  lui        $v1, %hi(gMemCardInfo)
    /* 40458 8004FC58 682D6324 */  addiu      $v1, $v1, %lo(gMemCardInfo)
    /* 4045C 8004FC5C 02000424 */  addiu      $a0, $zero, 0x2
    /* 40460 8004FC60 300064AC */  sw         $a0, 0x30($v1)
    /* 40464 8004FC64 340060AC */  sw         $zero, 0x34($v1)
  .L8004FC68:
    /* 40468 8004FC68 2400BF8F */  lw         $ra, 0x24($sp)
    /* 4046C 8004FC6C 2000B48F */  lw         $s4, 0x20($sp)
    /* 40470 8004FC70 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 40474 8004FC74 1800B28F */  lw         $s2, 0x18($sp)
    /* 40478 8004FC78 1400B18F */  lw         $s1, 0x14($sp)
    /* 4047C 8004FC7C 1000B08F */  lw         $s0, 0x10($sp)
    /* 40480 8004FC80 0800E003 */  jr         $ra
    /* 40484 8004FC84 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel MCRD_savefile
