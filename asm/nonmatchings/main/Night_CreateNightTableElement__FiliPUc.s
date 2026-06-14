.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Night_CreateNightTableElement__FiliPUc, 0x1C4

glabel Night_CreateNightTableElement__FiliPUc
    /* CBBE0 800DB3E0 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* CBBE4 800DB3E4 2400B1AF */  sw         $s1, 0x24($sp)
    /* CBBE8 800DB3E8 2188E000 */  addu       $s1, $a3, $zero
    /* CBBEC 800DB3EC 00110600 */  sll        $v0, $a2, 4
    /* CBBF0 800DB3F0 21104600 */  addu       $v0, $v0, $a2
    /* CBBF4 800DB3F4 00110200 */  sll        $v0, $v0, 4
    /* CBBF8 800DB3F8 3400A5AF */  sw         $a1, 0x34($sp)
    /* CBBFC 800DB3FC 3400A393 */  lbu        $v1, 0x34($sp)
    /* CBC00 800DB400 21384600 */  addu       $a3, $v0, $a2
    /* CBC04 800DB404 18006700 */  mult       $v1, $a3
    /* CBC08 800DB408 2000B0AF */  sw         $s0, 0x20($sp)
    /* CBC0C 800DB40C 21808000 */  addu       $s0, $a0, $zero
    /* CBC10 800DB410 40101000 */  sll        $v0, $s0, 1
    /* CBC14 800DB414 4815838F */  lw         $v1, %gp_rel(gTableCache)($gp)
    /* CBC18 800DB418 21105000 */  addu       $v0, $v0, $s0
    /* CBC1C 800DB41C 2800BFAF */  sw         $ra, 0x28($sp)
    /* CBC20 800DB420 21104300 */  addu       $v0, $v0, $v1
    /* CBC24 800DB424 00004490 */  lbu        $a0, 0x0($v0)
    /* CBC28 800DB428 01004590 */  lbu        $a1, 0x1($v0)
    /* CBC2C 800DB42C 12500000 */  mflo       $t2
    /* CBC30 800DB430 031B0A00 */  sra        $v1, $t2, 12
    /* CBC34 800DB434 21308300 */  addu       $a2, $a0, $v1
    /* CBC38 800DB438 3400A327 */  addiu      $v1, $sp, 0x34
    /* CBC3C 800DB43C 0001C428 */  slti       $a0, $a2, 0x100
    /* CBC40 800DB440 01006890 */  lbu        $t0, 0x1($v1)
    /* CBC44 800DB444 02006990 */  lbu        $t1, 0x2($v1)
    /* CBC48 800DB448 02004390 */  lbu        $v1, 0x2($v0)
    /* CBC4C 800DB44C 02008014 */  bnez       $a0, .L800DB458
    /* CBC50 800DB450 18000701 */   mult      $t0, $a3
    /* CBC54 800DB454 FF000624 */  addiu      $a2, $zero, 0xFF
  .L800DB458:
    /* CBC58 800DB458 12500000 */  mflo       $t2
    /* CBC5C 800DB45C 03130A00 */  sra        $v0, $t2, 12
    /* CBC60 800DB460 2128A200 */  addu       $a1, $a1, $v0
    /* CBC64 800DB464 0001A228 */  slti       $v0, $a1, 0x100
    /* CBC68 800DB468 02004014 */  bnez       $v0, .L800DB474
    /* CBC6C 800DB46C 18002701 */   mult      $t1, $a3
    /* CBC70 800DB470 FF000524 */  addiu      $a1, $zero, 0xFF
  .L800DB474:
    /* CBC74 800DB474 12500000 */  mflo       $t2
    /* CBC78 800DB478 03130A00 */  sra        $v0, $t2, 12
    /* CBC7C 800DB47C 21206200 */  addu       $a0, $v1, $v0
    /* CBC80 800DB480 00018228 */  slti       $v0, $a0, 0x100
    /* CBC84 800DB484 02004014 */  bnez       $v0, .L800DB490
    /* CBC88 800DB488 F8FF0324 */   addiu     $v1, $zero, -0x8
    /* CBC8C 800DB48C FF000424 */  addiu      $a0, $zero, 0xFF
  .L800DB490:
    /* CBC90 800DB490 2410C300 */  and        $v0, $a2, $v1
    /* CBC94 800DB494 1000A2A3 */  sb         $v0, 0x10($sp)
    /* CBC98 800DB498 2410A300 */  and        $v0, $a1, $v1
    /* CBC9C 800DB49C 1100A2A3 */  sb         $v0, 0x11($sp)
    /* CBCA0 800DB4A0 FF004230 */  andi       $v0, $v0, 0xFF
    /* CBCA4 800DB4A4 24188300 */  and        $v1, $a0, $v1
    /* CBCA8 800DB4A8 00120200 */  sll        $v0, $v0, 8
    /* CBCAC 800DB4AC 1200A3A3 */  sb         $v1, 0x12($sp)
    /* CBCB0 800DB4B0 FF006330 */  andi       $v1, $v1, 0xFF
    /* CBCB4 800DB4B4 001C0300 */  sll        $v1, $v1, 16
    /* CBCB8 800DB4B8 1000A493 */  lbu        $a0, 0x10($sp)
    /* CBCBC 800DB4BC 1800A527 */  addiu      $a1, $sp, 0x18
    /* CBCC0 800DB4C0 25208200 */  or         $a0, $a0, $v0
    /* CBCC4 800DB4C4 1300A293 */  lbu        $v0, 0x13($sp)
    /* CBCC8 800DB4C8 25208300 */  or         $a0, $a0, $v1
    /* CBCCC 800DB4CC 00160200 */  sll        $v0, $v0, 24
    /* CBCD0 800DB4D0 C66C030C */  jal        Night_FindClosestColor__FG7CVECTORPi
    /* CBCD4 800DB4D4 25208200 */   or        $a0, $a0, $v0
    /* CBCD8 800DB4D8 01024228 */  slti       $v0, $v0, 0x201
    /* CBCDC 800DB4DC 0D004014 */  bnez       $v0, .L800DB514
    /* CBCE0 800DB4E0 00000000 */   nop
    /* CBCE4 800DB4E4 1480023C */  lui        $v0, %hi(Chunk_numLight)
    /* CBCE8 800DB4E8 ECD4428C */  lw         $v0, %lo(Chunk_numLight)($v0)
    /* CBCEC 800DB4EC 00000000 */  nop
    /* CBCF0 800DB4F0 04004224 */  addiu      $v0, $v0, 0x4
    /* CBCF4 800DB4F4 2A100202 */  slt        $v0, $s0, $v0
    /* CBCF8 800DB4F8 06004010 */  beqz       $v0, .L800DB514
    /* CBCFC 800DB4FC 00000000 */   nop
    /* CBD00 800DB500 1415838F */  lw         $v1, %gp_rel(Night_gTotalLights)($gp)
    /* CBD04 800DB504 00000000 */  nop
    /* CBD08 800DB508 00016228 */  slti       $v0, $v1, 0x100
    /* CBD0C 800DB50C 04004014 */  bnez       $v0, .L800DB520
    /* CBD10 800DB510 40100300 */   sll       $v0, $v1, 1
  .L800DB514:
    /* CBD14 800DB514 1800A293 */  lbu        $v0, 0x18($sp)
    /* CBD18 800DB518 646D0308 */  j          .L800DB590
    /* CBD1C 800DB51C 000022A2 */   sb        $v0, 0x0($s1)
  .L800DB520:
    /* CBD20 800DB520 21104300 */  addu       $v0, $v0, $v1
    /* CBD24 800DB524 4815838F */  lw         $v1, %gp_rel(gTableCache)($gp)
    /* CBD28 800DB528 1000A493 */  lbu        $a0, 0x10($sp)
    /* CBD2C 800DB52C 21104300 */  addu       $v0, $v0, $v1
    /* CBD30 800DB530 000044A0 */  sb         $a0, 0x0($v0)
    /* CBD34 800DB534 1415838F */  lw         $v1, %gp_rel(Night_gTotalLights)($gp)
    /* CBD38 800DB538 00000000 */  nop
    /* CBD3C 800DB53C 40100300 */  sll        $v0, $v1, 1
    /* CBD40 800DB540 21104300 */  addu       $v0, $v0, $v1
    /* CBD44 800DB544 4815838F */  lw         $v1, %gp_rel(gTableCache)($gp)
    /* CBD48 800DB548 1100A493 */  lbu        $a0, 0x11($sp)
    /* CBD4C 800DB54C 21104300 */  addu       $v0, $v0, $v1
    /* CBD50 800DB550 010044A0 */  sb         $a0, 0x1($v0)
    /* CBD54 800DB554 1415838F */  lw         $v1, %gp_rel(Night_gTotalLights)($gp)
    /* CBD58 800DB558 00000000 */  nop
    /* CBD5C 800DB55C 40100300 */  sll        $v0, $v1, 1
    /* CBD60 800DB560 21104300 */  addu       $v0, $v0, $v1
    /* CBD64 800DB564 4815838F */  lw         $v1, %gp_rel(gTableCache)($gp)
    /* CBD68 800DB568 1200A493 */  lbu        $a0, 0x12($sp)
    /* CBD6C 800DB56C 21104300 */  addu       $v0, $v0, $v1
    /* CBD70 800DB570 020044A0 */  sb         $a0, 0x2($v0)
    /* CBD74 800DB574 14158293 */  lbu        $v0, %gp_rel(Night_gTotalLights)($gp)
    /* CBD78 800DB578 00000000 */  nop
    /* CBD7C 800DB57C 000022A2 */  sb         $v0, 0x0($s1)
    /* CBD80 800DB580 1415828F */  lw         $v0, %gp_rel(Night_gTotalLights)($gp)
    /* CBD84 800DB584 00000000 */  nop
    /* CBD88 800DB588 01004224 */  addiu      $v0, $v0, 0x1
    /* CBD8C 800DB58C 141582AF */  sw         $v0, %gp_rel(Night_gTotalLights)($gp)
  .L800DB590:
    /* CBD90 800DB590 2800BF8F */  lw         $ra, 0x28($sp)
    /* CBD94 800DB594 2400B18F */  lw         $s1, 0x24($sp)
    /* CBD98 800DB598 2000B08F */  lw         $s0, 0x20($sp)
    /* CBD9C 800DB59C 0800E003 */  jr         $ra
    /* CBDA0 800DB5A0 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel Night_CreateNightTableElement__FiliPUc
