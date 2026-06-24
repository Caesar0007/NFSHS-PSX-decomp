.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MemCardWriteData_cb, 0x13C

glabel MemCardWriteData_cb
    /* EBB0C 800FB30C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* EBB10 800FB310 1400B1AF */  sw         $s1, 0x14($sp)
    /* EBB14 800FB314 21888000 */  addu       $s1, $a0, $zero
    /* EBB18 800FB318 1800BFAF */  sw         $ra, 0x18($sp)
    /* EBB1C 800FB31C 1000B0AF */  sw         $s0, 0x10($sp)
    /* EBB20 800FB320 0000238E */  lw         $v1, 0x0($s1)
    /* EBB24 800FB324 0A001024 */  addiu      $s0, $zero, 0xA
    /* EBB28 800FB328 2B007010 */  beq        $v1, $s0, .L800FB3D8
    /* EBB2C 800FB32C 0B006228 */   slti      $v0, $v1, 0xB
    /* EBB30 800FB330 05004010 */  beqz       $v0, .L800FB348
    /* EBB34 800FB334 1E000224 */   addiu     $v0, $zero, 0x1E
    /* EBB38 800FB338 07006010 */  beqz       $v1, .L800FB358
    /* EBB3C 800FB33C 21100000 */   addu      $v0, $zero, $zero
    /* EBB40 800FB340 0DED0308 */  j          .L800FB434
    /* EBB44 800FB344 00000000 */   nop
  .L800FB348:
    /* EBB48 800FB348 07006210 */  beq        $v1, $v0, .L800FB368
    /* EBB4C 800FB34C 21100000 */   addu      $v0, $zero, $zero
    /* EBB50 800FB350 0DED0308 */  j          .L800FB434
    /* EBB54 800FB354 00000000 */   nop
  .L800FB358:
    /* EBB58 800FB358 1380013C */  lui        $at, %hi(D_80136CBC)
    /* EBB5C 800FB35C BC6C20AC */  sw         $zero, %lo(D_80136CBC)($at)
    /* EBB60 800FB360 0CED0308 */  j          .L800FB430
    /* EBB64 800FB364 000030AE */   sw        $s0, 0x0($s1)
  .L800FB368:
    /* EBB68 800FB368 E226040C */  jal        _chk_card_event
    /* EBB6C 800FB36C 00000000 */   nop
    /* EBB70 800FB370 30004010 */  beqz       $v0, .L800FB434
    /* EBB74 800FB374 21100000 */   addu      $v0, $zero, $zero
    /* EBB78 800FB378 7626040C */  jal        _get_card_event
    /* EBB7C 800FB37C 00000000 */   nop
    /* EBB80 800FB380 21204000 */  addu       $a0, $v0, $zero
    /* EBB84 800FB384 0C008010 */  beqz       $a0, .L800FB3B8
    /* EBB88 800FB388 00000000 */   nop
    /* EBB8C 800FB38C 1380023C */  lui        $v0, %hi(D_80136CBC)
    /* EBB90 800FB390 BC6C428C */  lw         $v0, %lo(D_80136CBC)($v0)
    /* EBB94 800FB394 00000000 */  nop
    /* EBB98 800FB398 01004224 */  addiu      $v0, $v0, 0x1
    /* EBB9C 800FB39C 1380013C */  lui        $at, %hi(D_80136CBC)
    /* EBBA0 800FB3A0 BC6C22AC */  sw         $v0, %lo(D_80136CBC)($at)
    /* EBBA4 800FB3A4 04004228 */  slti       $v0, $v0, 0x4
    /* EBBA8 800FB3A8 04004010 */  beqz       $v0, .L800FB3BC
    /* EBBAC 800FB3AC 00000000 */   nop
    /* EBBB0 800FB3B0 0CED0308 */  j          .L800FB430
    /* EBBB4 800FB3B4 000030AE */   sw        $s0, 0x0($s1)
  .L800FB3B8:
    /* EBBB8 800FB3B8 21200000 */  addu       $a0, $zero, $zero
  .L800FB3BC:
    /* EBBBC 800FB3BC 47F0030C */  jal        MemCardEventToRslt
    /* EBBC0 800FB3C0 00000000 */   nop
    /* EBBC4 800FB3C4 1480033C */  lui        $v1, %hi(D_80147518)
    /* EBBC8 800FB3C8 18756324 */  addiu      $v1, $v1, %lo(D_80147518)
    /* EBBCC 800FB3CC 040062AC */  sw         $v0, 0x4($v1)
    /* EBBD0 800FB3D0 0DED0308 */  j          .L800FB434
    /* EBBD4 800FB3D4 01000224 */   addiu     $v0, $zero, 0x1
  .L800FB3D8:
    /* EBBD8 800FB3D8 1480103C */  lui        $s0, %hi(D_80147528)
    /* EBBDC 800FB3DC 28751026 */  addiu      $s0, $s0, %lo(D_80147528)
  .L800FB3E0:
    /* EBBE0 800FB3E0 0000048E */  lw         $a0, 0x0($s0)
    /* EBBE4 800FB3E4 0400058E */  lw         $a1, 0x4($s0)
    /* EBBE8 800FB3E8 6427040C */  jal        lseek
    /* EBBEC 800FB3EC 21300000 */   addu      $a2, $zero, $zero
    /* EBBF0 800FB3F0 0400038E */  lw         $v1, 0x4($s0)
    /* EBBF4 800FB3F4 00000000 */  nop
    /* EBBF8 800FB3F8 F9FF4314 */  bne        $v0, $v1, .L800FB3E0
    /* EBBFC 800FB3FC 00000000 */   nop
    /* EBC00 800FB400 3426040C */  jal        _clr_card_event
    /* EBC04 800FB404 00000000 */   nop
    /* EBC08 800FB408 1480103C */  lui        $s0, %hi(D_80147528)
    /* EBC0C 800FB40C 28751026 */  addiu      $s0, $s0, %lo(D_80147528)
  .L800FB410:
    /* EBC10 800FB410 0000048E */  lw         $a0, 0x0($s0)
    /* EBC14 800FB414 0C00058E */  lw         $a1, 0xC($s0)
    /* EBC18 800FB418 0800068E */  lw         $a2, 0x8($s0)
    /* EBC1C 800FB41C 6C27040C */  jal        write
    /* EBC20 800FB420 00000000 */   nop
    /* EBC24 800FB424 FAFF4014 */  bnez       $v0, .L800FB410
    /* EBC28 800FB428 1E000224 */   addiu     $v0, $zero, 0x1E
    /* EBC2C 800FB42C 000022AE */  sw         $v0, 0x0($s1)
  .L800FB430:
    /* EBC30 800FB430 21100000 */  addu       $v0, $zero, $zero
  .L800FB434:
    /* EBC34 800FB434 1800BF8F */  lw         $ra, 0x18($sp)
    /* EBC38 800FB438 1400B18F */  lw         $s1, 0x14($sp)
    /* EBC3C 800FB43C 1000B08F */  lw         $s0, 0x10($sp)
    /* EBC40 800FB440 0800E003 */  jr         $ra
    /* EBC44 800FB444 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel MemCardWriteData_cb
