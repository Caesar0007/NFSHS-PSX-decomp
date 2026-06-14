.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CdGetToc2, 0x224

glabel CdGetToc2
    /* F9AC0 801092C0 C0FFBD27 */  addiu      $sp, $sp, -0x40
    /* F9AC4 801092C4 3000B4AF */  sw         $s4, 0x30($sp)
    /* F9AC8 801092C8 21A0A000 */  addu       $s4, $a1, $zero
    /* F9ACC 801092CC 01000224 */  addiu      $v0, $zero, 0x1
    /* F9AD0 801092D0 21200000 */  addu       $a0, $zero, $zero
    /* F9AD4 801092D4 3C00BFAF */  sw         $ra, 0x3C($sp)
    /* F9AD8 801092D8 3800B6AF */  sw         $s6, 0x38($sp)
    /* F9ADC 801092DC 3400B5AF */  sw         $s5, 0x34($sp)
    /* F9AE0 801092E0 2C00B3AF */  sw         $s3, 0x2C($sp)
    /* F9AE4 801092E4 2800B2AF */  sw         $s2, 0x28($sp)
    /* F9AE8 801092E8 2400B1AF */  sw         $s1, 0x24($sp)
    /* F9AEC 801092EC 2000B0AF */  sw         $s0, 0x20($sp)
    /* F9AF0 801092F0 23DE030C */  jal        CdSyncCallback
    /* F9AF4 801092F4 1000A2A3 */   sb        $v0, 0x10($sp)
    /* F9AF8 801092F8 13000424 */  addiu      $a0, $zero, 0x13
    /* F9AFC 801092FC 21280000 */  addu       $a1, $zero, $zero
    /* F9B00 80109300 1800B127 */  addiu      $s1, $sp, 0x18
    /* F9B04 80109304 21302002 */  addu       $a2, $s1, $zero
    /* F9B08 80109308 C9DE030C */  jal        CdControlB
    /* F9B0C 8010930C 21B04000 */   addu      $s6, $v0, $zero
    /* F9B10 80109310 5F004010 */  beqz       $v0, .L80109490
    /* F9B14 80109314 00000000 */   nop
    /* F9B18 80109318 1900A493 */  lbu        $a0, 0x19($sp)
    /* F9B1C 8010931C 1A00A593 */  lbu        $a1, 0x1A($sp)
    /* F9B20 80109320 02190400 */  srl        $v1, $a0, 4
    /* F9B24 80109324 80100300 */  sll        $v0, $v1, 2
    /* F9B28 80109328 21104300 */  addu       $v0, $v0, $v1
    /* F9B2C 8010932C 40100200 */  sll        $v0, $v0, 1
    /* F9B30 80109330 0F008430 */  andi       $a0, $a0, 0xF
    /* F9B34 80109334 21804400 */  addu       $s0, $v0, $a0
    /* F9B38 80109338 02110500 */  srl        $v0, $a1, 4
    /* F9B3C 8010933C 80180200 */  sll        $v1, $v0, 2
    /* F9B40 80109340 21186200 */  addu       $v1, $v1, $v0
    /* F9B44 80109344 40180300 */  sll        $v1, $v1, 1
    /* F9B48 80109348 0F00A530 */  andi       $a1, $a1, 0xF
    /* F9B4C 8010934C 1480023C */  lui        $v0, %hi(CD_debug)
    /* F9B50 80109350 50BF428C */  lw         $v0, %lo(CD_debug)($v0)
    /* F9B54 80109354 00000000 */  nop
    /* F9B58 80109358 02004228 */  slti       $v0, $v0, 0x2
    /* F9B5C 8010935C 06004014 */  bnez       $v0, .L80109378
    /* F9B60 80109360 21986500 */   addu      $s3, $v1, $a1
    /* F9B64 80109364 0580043C */  lui        $a0, %hi(D_80057908)
    /* F9B68 80109368 08798424 */  addiu      $a0, $a0, %lo(D_80057908)
    /* F9B6C 8010936C 21280002 */  addu       $a1, $s0, $zero
    /* F9B70 80109370 2B0A040C */  jal        printf
    /* F9B74 80109374 21306002 */   addu      $a2, $s3, $zero
  .L80109378:
    /* F9B78 80109378 1000A0A3 */  sb         $zero, 0x10($sp)
    /* F9B7C 8010937C 14000424 */  addiu      $a0, $zero, 0x14
    /* F9B80 80109380 1000A527 */  addiu      $a1, $sp, 0x10
    /* F9B84 80109384 C9DE030C */  jal        CdControlB
    /* F9B88 80109388 21302002 */   addu      $a2, $s1, $zero
    /* F9B8C 8010938C 40004010 */  beqz       $v0, .L80109490
    /* F9B90 80109390 00000000 */   nop
    /* F9B94 80109394 1900A293 */  lbu        $v0, 0x19($sp)
    /* F9B98 80109398 00000000 */  nop
    /* F9B9C 8010939C 000082A2 */  sb         $v0, 0x0($s4)
    /* F9BA0 801093A0 1A00A293 */  lbu        $v0, 0x1A($sp)
    /* F9BA4 801093A4 020080A2 */  sb         $zero, 0x2($s4)
    /* F9BA8 801093A8 010082A2 */  sb         $v0, 0x1($s4)
    /* F9BAC 801093AC 2A107002 */  slt        $v0, $s3, $s0
    /* F9BB0 801093B0 20004014 */  bnez       $v0, .L80109434
    /* F9BB4 801093B4 01001224 */   addiu     $s2, $zero, 0x1
    /* F9BB8 801093B8 6666153C */  lui        $s5, (0x66666667 >> 16)
    /* F9BBC 801093BC 6766B536 */  ori        $s5, $s5, (0x66666667 & 0xFFFF)
    /* F9BC0 801093C0 04009126 */  addiu      $s1, $s4, 0x4
  .L801093C4:
    /* F9BC4 801093C4 18001502 */  mult       $s0, $s5
    /* F9BC8 801093C8 14000424 */  addiu      $a0, $zero, 0x14
    /* F9BCC 801093CC 1000A527 */  addiu      $a1, $sp, 0x10
    /* F9BD0 801093D0 1800A627 */  addiu      $a2, $sp, 0x18
    /* F9BD4 801093D4 C3171000 */  sra        $v0, $s0, 31
    /* F9BD8 801093D8 10400000 */  mfhi       $t0
    /* F9BDC 801093DC 83180800 */  sra        $v1, $t0, 2
    /* F9BE0 801093E0 23186200 */  subu       $v1, $v1, $v0
    /* F9BE4 801093E4 00390300 */  sll        $a3, $v1, 4
    /* F9BE8 801093E8 80100300 */  sll        $v0, $v1, 2
    /* F9BEC 801093EC 21104300 */  addu       $v0, $v0, $v1
    /* F9BF0 801093F0 40100200 */  sll        $v0, $v0, 1
    /* F9BF4 801093F4 23100202 */  subu       $v0, $s0, $v0
    /* F9BF8 801093F8 2138E200 */  addu       $a3, $a3, $v0
    /* F9BFC 801093FC C9DE030C */  jal        CdControlB
    /* F9C00 80109400 1000A7A3 */   sb        $a3, 0x10($sp)
    /* F9C04 80109404 22004010 */  beqz       $v0, .L80109490
    /* F9C08 80109408 01005226 */   addiu     $s2, $s2, 0x1
    /* F9C0C 8010940C 1900A293 */  lbu        $v0, 0x19($sp)
    /* F9C10 80109410 00000000 */  nop
    /* F9C14 80109414 000022A2 */  sb         $v0, 0x0($s1)
    /* F9C18 80109418 1A00A293 */  lbu        $v0, 0x1A($sp)
    /* F9C1C 8010941C 01001026 */  addiu      $s0, $s0, 0x1
    /* F9C20 80109420 020020A2 */  sb         $zero, 0x2($s1)
    /* F9C24 80109424 010022A2 */  sb         $v0, 0x1($s1)
    /* F9C28 80109428 2A107002 */  slt        $v0, $s3, $s0
    /* F9C2C 8010942C E5FF4010 */  beqz       $v0, .L801093C4
    /* F9C30 80109430 04003126 */   addiu     $s1, $s1, 0x4
  .L80109434:
    /* F9C34 80109434 1480023C */  lui        $v0, %hi(CD_debug)
    /* F9C38 80109438 50BF428C */  lw         $v0, %lo(CD_debug)($v0)
    /* F9C3C 8010943C 00000000 */  nop
    /* F9C40 80109440 02004228 */  slti       $v0, $v0, 0x2
    /* F9C44 80109444 0E004014 */  bnez       $v0, .L80109480
    /* F9C48 80109448 FFFF5126 */   addiu     $s1, $s2, -0x1
    /* F9C4C 8010944C 0C002006 */  bltz       $s1, .L80109480
    /* F9C50 80109450 21900000 */   addu      $s2, $zero, $zero
    /* F9C54 80109454 21808002 */  addu       $s0, $s4, $zero
  .L80109458:
    /* F9C58 80109458 0580043C */  lui        $a0, %hi(D_80057918)
    /* F9C5C 8010945C 18798424 */  addiu      $a0, $a0, %lo(D_80057918)
    /* F9C60 80109460 00000592 */  lbu        $a1, 0x0($s0)
    /* F9C64 80109464 01000692 */  lbu        $a2, 0x1($s0)
    /* F9C68 80109468 04001026 */  addiu      $s0, $s0, 0x4
    /* F9C6C 8010946C 2B0A040C */  jal        printf
    /* F9C70 80109470 01005226 */   addiu     $s2, $s2, 0x1
    /* F9C74 80109474 2A103202 */  slt        $v0, $s1, $s2
    /* F9C78 80109478 F7FF4010 */  beqz       $v0, .L80109458
    /* F9C7C 8010947C 00000000 */   nop
  .L80109480:
    /* F9C80 80109480 23DE030C */  jal        CdSyncCallback
    /* F9C84 80109484 2120C002 */   addu      $a0, $s6, $zero
    /* F9C88 80109488 2F250408 */  j          .L801094BC
    /* F9C8C 8010948C 21102002 */   addu      $v0, $s1, $zero
  .L80109490:
    /* F9C90 80109490 1480023C */  lui        $v0, %hi(CD_debug)
    /* F9C94 80109494 50BF428C */  lw         $v0, %lo(CD_debug)($v0)
    /* F9C98 80109498 00000000 */  nop
    /* F9C9C 8010949C 04004010 */  beqz       $v0, .L801094B0
    /* F9CA0 801094A0 00000000 */   nop
    /* F9CA4 801094A4 0580043C */  lui        $a0, %hi(D_80057934)
    /* F9CA8 801094A8 2B0A040C */  jal        printf
    /* F9CAC 801094AC 34798424 */   addiu     $a0, $a0, %lo(D_80057934)
  .L801094B0:
    /* F9CB0 801094B0 23DE030C */  jal        CdSyncCallback
    /* F9CB4 801094B4 2120C002 */   addu      $a0, $s6, $zero
    /* F9CB8 801094B8 21100000 */  addu       $v0, $zero, $zero
  .L801094BC:
    /* F9CBC 801094BC 3C00BF8F */  lw         $ra, 0x3C($sp)
    /* F9CC0 801094C0 3800B68F */  lw         $s6, 0x38($sp)
    /* F9CC4 801094C4 3400B58F */  lw         $s5, 0x34($sp)
    /* F9CC8 801094C8 3000B48F */  lw         $s4, 0x30($sp)
    /* F9CCC 801094CC 2C00B38F */  lw         $s3, 0x2C($sp)
    /* F9CD0 801094D0 2800B28F */  lw         $s2, 0x28($sp)
    /* F9CD4 801094D4 2400B18F */  lw         $s1, 0x24($sp)
    /* F9CD8 801094D8 2000B08F */  lw         $s0, 0x20($sp)
    /* F9CDC 801094DC 0800E003 */  jr         $ra
    /* F9CE0 801094E0 4000BD27 */   addiu     $sp, $sp, 0x40
endlabel CdGetToc2
    /* F9CE4 801094E4 00000000 */  nop
    /* F9CE8 801094E8 00000000 */  nop
