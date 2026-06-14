.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SetDrawEnv, 0x1F8

glabel SetDrawEnv
    /* DEC10 800EE410 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* DEC14 800EE414 1800B0AF */  sw         $s0, 0x18($sp)
    /* DEC18 800EE418 2180A000 */  addu       $s0, $a1, $zero
    /* DEC1C 800EE41C 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* DEC20 800EE420 21888000 */  addu       $s1, $a0, $zero
    /* DEC24 800EE424 2000BFAF */  sw         $ra, 0x20($sp)
    /* DEC28 800EE428 00000486 */  lh         $a0, 0x0($s0)
    /* DEC2C 800EE42C 02000586 */  lh         $a1, 0x2($s0)
    /* DEC30 800EE430 26BA030C */  jal        func_800EE898
    /* DEC34 800EE434 00000000 */   nop
    /* DEC38 800EE438 040022AE */  sw         $v0, 0x4($s1)
    /* DEC3C 800EE43C 04000496 */  lhu        $a0, 0x4($s0)
    /* DEC40 800EE440 00000296 */  lhu        $v0, 0x0($s0)
    /* DEC44 800EE444 02000596 */  lhu        $a1, 0x2($s0)
    /* DEC48 800EE448 21208200 */  addu       $a0, $a0, $v0
    /* DEC4C 800EE44C FFFF8424 */  addiu      $a0, $a0, -0x1
    /* DEC50 800EE450 00240400 */  sll        $a0, $a0, 16
    /* DEC54 800EE454 06000296 */  lhu        $v0, 0x6($s0)
    /* DEC58 800EE458 03240400 */  sra        $a0, $a0, 16
    /* DEC5C 800EE45C 2128A200 */  addu       $a1, $a1, $v0
    /* DEC60 800EE460 FFFFA524 */  addiu      $a1, $a1, -0x1
    /* DEC64 800EE464 002C0500 */  sll        $a1, $a1, 16
    /* DEC68 800EE468 4CBA030C */  jal        func_800EE930
    /* DEC6C 800EE46C 032C0500 */   sra       $a1, $a1, 16
    /* DEC70 800EE470 080022AE */  sw         $v0, 0x8($s1)
    /* DEC74 800EE474 08000486 */  lh         $a0, 0x8($s0)
    /* DEC78 800EE478 0A000586 */  lh         $a1, 0xA($s0)
    /* DEC7C 800EE47C 72BA030C */  jal        func_800EE9C8
    /* DEC80 800EE480 00000000 */   nop
    /* DEC84 800EE484 0C0022AE */  sw         $v0, 0xC($s1)
    /* DEC88 800EE488 17000492 */  lbu        $a0, 0x17($s0)
    /* DEC8C 800EE48C 16000592 */  lbu        $a1, 0x16($s0)
    /* DEC90 800EE490 14000696 */  lhu        $a2, 0x14($s0)
    /* DEC94 800EE494 1EBA030C */  jal        func_800EE878
    /* DEC98 800EE498 00000000 */   nop
    /* DEC9C 800EE49C 0C000426 */  addiu      $a0, $s0, 0xC
    /* DECA0 800EE4A0 79BA030C */  jal        func_800EE9E4
    /* DECA4 800EE4A4 100022AE */   sw        $v0, 0x10($s1)
    /* DECA8 800EE4A8 140022AE */  sw         $v0, 0x14($s1)
    /* DECAC 800EE4AC 00E6023C */  lui        $v0, (0xE6000000 >> 16)
    /* DECB0 800EE4B0 180022AE */  sw         $v0, 0x18($s1)
    /* DECB4 800EE4B4 18000292 */  lbu        $v0, 0x18($s0)
    /* DECB8 800EE4B8 00000000 */  nop
    /* DECBC 800EE4BC 4B004010 */  beqz       $v0, .L800EE5EC
    /* DECC0 800EE4C0 07000824 */   addiu     $t0, $zero, 0x7
    /* DECC4 800EE4C4 00000296 */  lhu        $v0, 0x0($s0)
    /* DECC8 800EE4C8 00000000 */  nop
    /* DECCC 800EE4CC 1000A2A7 */  sh         $v0, 0x10($sp)
    /* DECD0 800EE4D0 02000296 */  lhu        $v0, 0x2($s0)
    /* DECD4 800EE4D4 00000000 */  nop
    /* DECD8 800EE4D8 1200A2A7 */  sh         $v0, 0x12($sp)
    /* DECDC 800EE4DC 04000496 */  lhu        $a0, 0x4($s0)
    /* DECE0 800EE4E0 00000000 */  nop
    /* DECE4 800EE4E4 1400A4A7 */  sh         $a0, 0x14($sp)
    /* DECE8 800EE4E8 06000296 */  lhu        $v0, 0x6($s0)
    /* DECEC 800EE4EC 00000000 */  nop
    /* DECF0 800EE4F0 1600A2A7 */  sh         $v0, 0x16($sp)
    /* DECF4 800EE4F4 00140400 */  sll        $v0, $a0, 16
    /* DECF8 800EE4F8 031C0200 */  sra        $v1, $v0, 16
    /* DECFC 800EE4FC 0B006004 */  bltz       $v1, .L800EE52C
    /* DED00 800EE500 21100000 */   addu      $v0, $zero, $zero
    /* DED04 800EE504 1280023C */  lui        $v0, %hi(D_801236A0)
    /* DED08 800EE508 A0364284 */  lh         $v0, %lo(D_801236A0)($v0)
    /* DED0C 800EE50C 00000000 */  nop
    /* DED10 800EE510 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* DED14 800EE514 2A104300 */  slt        $v0, $v0, $v1
    /* DED18 800EE518 1280033C */  lui        $v1, %hi(D_801236A0)
    /* DED1C 800EE51C A0366394 */  lhu        $v1, %lo(D_801236A0)($v1)
    /* DED20 800EE520 02004014 */  bnez       $v0, .L800EE52C
    /* DED24 800EE524 FFFF6224 */   addiu     $v0, $v1, -0x1
    /* DED28 800EE528 21108000 */  addu       $v0, $a0, $zero
  .L800EE52C:
    /* DED2C 800EE52C 1600A387 */  lh         $v1, 0x16($sp)
    /* DED30 800EE530 1600A497 */  lhu        $a0, 0x16($sp)
    /* DED34 800EE534 0C006004 */  bltz       $v1, .L800EE568
    /* DED38 800EE538 1400A2A7 */   sh        $v0, 0x14($sp)
    /* DED3C 800EE53C 1280023C */  lui        $v0, %hi(D_801236A2)
    /* DED40 800EE540 A2364284 */  lh         $v0, %lo(D_801236A2)($v0)
    /* DED44 800EE544 00000000 */  nop
    /* DED48 800EE548 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* DED4C 800EE54C 2A104300 */  slt        $v0, $v0, $v1
    /* DED50 800EE550 1280033C */  lui        $v1, %hi(D_801236A2)
    /* DED54 800EE554 A2366394 */  lhu        $v1, %lo(D_801236A2)($v1)
    /* DED58 800EE558 04004014 */  bnez       $v0, .L800EE56C
    /* DED5C 800EE55C FFFF6224 */   addiu     $v0, $v1, -0x1
    /* DED60 800EE560 5BB90308 */  j          .L800EE56C
    /* DED64 800EE564 21108000 */   addu      $v0, $a0, $zero
  .L800EE568:
    /* DED68 800EE568 21100000 */  addu       $v0, $zero, $zero
  .L800EE56C:
    /* DED6C 800EE56C 80300800 */  sll        $a2, $t0, 2
    /* DED70 800EE570 01000825 */  addiu      $t0, $t0, 0x1
    /* DED74 800EE574 80380800 */  sll        $a3, $t0, 2
    /* DED78 800EE578 01000825 */  addiu      $t0, $t0, 0x1
    /* DED7C 800EE57C 80280800 */  sll        $a1, $t0, 2
    /* DED80 800EE580 01000825 */  addiu      $t0, $t0, 0x1
    /* DED84 800EE584 1600A2A7 */  sh         $v0, 0x16($sp)
    /* DED88 800EE588 1000A297 */  lhu        $v0, 0x10($sp)
    /* DED8C 800EE58C 08000396 */  lhu        $v1, 0x8($s0)
    /* DED90 800EE590 2130D100 */  addu       $a2, $a2, $s1
    /* DED94 800EE594 23104300 */  subu       $v0, $v0, $v1
    /* DED98 800EE598 1000A2A7 */  sh         $v0, 0x10($sp)
    /* DED9C 800EE59C 1200A297 */  lhu        $v0, 0x12($sp)
    /* DEDA0 800EE5A0 0A000396 */  lhu        $v1, 0xA($s0)
    /* DEDA4 800EE5A4 0060043C */  lui        $a0, (0x60000000 >> 16)
    /* DEDA8 800EE5A8 23104300 */  subu       $v0, $v0, $v1
    /* DEDAC 800EE5AC 1200A2A7 */  sh         $v0, 0x12($sp)
    /* DEDB0 800EE5B0 1B000292 */  lbu        $v0, 0x1B($s0)
    /* DEDB4 800EE5B4 1A000392 */  lbu        $v1, 0x1A($s0)
    /* DEDB8 800EE5B8 00140200 */  sll        $v0, $v0, 16
    /* DEDBC 800EE5BC 001A0300 */  sll        $v1, $v1, 8
    /* DEDC0 800EE5C0 25186400 */  or         $v1, $v1, $a0
    /* DEDC4 800EE5C4 19000492 */  lbu        $a0, 0x19($s0)
    /* DEDC8 800EE5C8 25104300 */  or         $v0, $v0, $v1
    /* DEDCC 800EE5CC 25104400 */  or         $v0, $v0, $a0
    /* DEDD0 800EE5D0 0000C2AC */  sw         $v0, 0x0($a2)
    /* DEDD4 800EE5D4 1000A28F */  lw         $v0, 0x10($sp)
    /* DEDD8 800EE5D8 2138F100 */  addu       $a3, $a3, $s1
    /* DEDDC 800EE5DC 0000E2AC */  sw         $v0, 0x0($a3)
    /* DEDE0 800EE5E0 1400A28F */  lw         $v0, 0x14($sp)
    /* DEDE4 800EE5E4 2128B100 */  addu       $a1, $a1, $s1
    /* DEDE8 800EE5E8 0000A2AC */  sw         $v0, 0x0($a1)
  .L800EE5EC:
    /* DEDEC 800EE5EC FFFF0225 */  addiu      $v0, $t0, -0x1
    /* DEDF0 800EE5F0 030022A2 */  sb         $v0, 0x3($s1)
    /* DEDF4 800EE5F4 2000BF8F */  lw         $ra, 0x20($sp)
    /* DEDF8 800EE5F8 1C00B18F */  lw         $s1, 0x1C($sp)
    /* DEDFC 800EE5FC 1800B08F */  lw         $s0, 0x18($sp)
    /* DEE00 800EE600 0800E003 */  jr         $ra
    /* DEE04 800EE604 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel SetDrawEnv
