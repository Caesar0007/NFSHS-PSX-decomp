.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CalcObjectBoundingSphere__FP5GroupT0, 0x260

glabel CalcObjectBoundingSphere__FP5GroupT0
    /* AAB68 800BA368 C0FFBD27 */  addiu      $sp, $sp, -0x40
    /* AAB6C 800BA36C 2C00B3AF */  sw         $s3, 0x2C($sp)
    /* AAB70 800BA370 2198A000 */  addu       $s3, $a1, $zero
    /* AAB74 800BA374 2800B2AF */  sw         $s2, 0x28($sp)
    /* AAB78 800BA378 04007226 */  addiu      $s2, $s3, 0x4
    /* AAB7C 800BA37C 2400B1AF */  sw         $s1, 0x24($sp)
    /* AAB80 800BA380 21880000 */  addu       $s1, $zero, $zero
    /* AAB84 800BA384 3000B4AF */  sw         $s4, 0x30($sp)
    /* AAB88 800BA388 FFFF1424 */  addiu      $s4, $zero, -0x1
    /* AAB8C 800BA38C 2000B0AF */  sw         $s0, 0x20($sp)
    /* AAB90 800BA390 0A007026 */  addiu      $s0, $s3, 0xA
    /* AAB94 800BA394 3800BFAF */  sw         $ra, 0x38($sp)
    /* AAB98 800BA398 3400B5AF */  sw         $s5, 0x34($sp)
    /* AAB9C 800BA39C 0000958C */  lw         $s5, 0x0($a0)
  .L800BA3A0:
    /* AABA0 800BA3A0 00000000 */  nop
    /* AABA4 800BA3A4 2A103502 */  slt        $v0, $s1, $s5
    /* AABA8 800BA3A8 7E004010 */  beqz       $v0, .L800BA5A4
    /* AABAC 800BA3AC 80101100 */   sll       $v0, $s1, 2
    /* AABB0 800BA3B0 880F838F */  lw         $v1, %gp_rel(Track_gObjDefs)($gp)
    /* AABB4 800BA3B4 00000000 */  nop
    /* AABB8 800BA3B8 21104300 */  addu       $v0, $v0, $v1
    /* AABBC 800BA3BC 0000468C */  lw         $a2, 0x0($v0)
    /* AABC0 800BA3C0 00000000 */  nop
    /* AABC4 800BA3C4 0200C790 */  lbu        $a3, 0x2($a2)
    /* AABC8 800BA3C8 0400C824 */  addiu      $t0, $a2, 0x4
    /* AABCC 800BA3CC 1800A0AF */  sw         $zero, 0x18($sp)
    /* AABD0 800BA3D0 1400A0AF */  sw         $zero, 0x14($sp)
    /* AABD4 800BA3D4 FFFFE724 */  addiu      $a3, $a3, -0x1
    /* AABD8 800BA3D8 1300F410 */  beq        $a3, $s4, .L800BA428
    /* AABDC 800BA3DC 1000A0AF */   sw        $zero, 0x10($sp)
    /* AABE0 800BA3E0 FFFF0524 */  addiu      $a1, $zero, -0x1
    /* AABE4 800BA3E4 0800C424 */  addiu      $a0, $a2, 0x8
  .L800BA3E8:
    /* AABE8 800BA3E8 00000385 */  lh         $v1, 0x0($t0)
    /* AABEC 800BA3EC 1000A28F */  lw         $v0, 0x10($sp)
    /* AABF0 800BA3F0 08000825 */  addiu      $t0, $t0, 0x8
    /* AABF4 800BA3F4 21104300 */  addu       $v0, $v0, $v1
    /* AABF8 800BA3F8 1000A2AF */  sw         $v0, 0x10($sp)
    /* AABFC 800BA3FC FEFF8384 */  lh         $v1, -0x2($a0)
    /* AAC00 800BA400 1400A28F */  lw         $v0, 0x14($sp)
    /* AAC04 800BA404 FFFFE724 */  addiu      $a3, $a3, -0x1
    /* AAC08 800BA408 21104300 */  addu       $v0, $v0, $v1
    /* AAC0C 800BA40C 1400A2AF */  sw         $v0, 0x14($sp)
    /* AAC10 800BA410 00008384 */  lh         $v1, 0x0($a0)
    /* AAC14 800BA414 1800A28F */  lw         $v0, 0x18($sp)
    /* AAC18 800BA418 08008424 */  addiu      $a0, $a0, 0x8
    /* AAC1C 800BA41C 21104300 */  addu       $v0, $v0, $v1
    /* AAC20 800BA420 F1FFE514 */  bne        $a3, $a1, .L800BA3E8
    /* AAC24 800BA424 1800A2AF */   sw        $v0, 0x18($sp)
  .L800BA428:
    /* AAC28 800BA428 0200C290 */  lbu        $v0, 0x2($a2)
    /* AAC2C 800BA42C 1000A58F */  lw         $a1, 0x10($sp)
    /* AAC30 800BA430 00000000 */  nop
    /* AAC34 800BA434 1A00A200 */  div        $zero, $a1, $v0
    /* AAC38 800BA438 02004014 */  bnez       $v0, .L800BA444
    /* AAC3C 800BA43C 00000000 */   nop
    /* AAC40 800BA440 0D000700 */  break      7
  .L800BA444:
    /* AAC44 800BA444 FFFF0124 */  addiu      $at, $zero, -0x1
    /* AAC48 800BA448 04004114 */  bne        $v0, $at, .L800BA45C
    /* AAC4C 800BA44C 0080013C */   lui       $at, (0x80000000 >> 16)
    /* AAC50 800BA450 0200A114 */  bne        $a1, $at, .L800BA45C
    /* AAC54 800BA454 00000000 */   nop
    /* AAC58 800BA458 0D000600 */  break      6
  .L800BA45C:
    /* AAC5C 800BA45C 12280000 */  mflo       $a1
    /* AAC60 800BA460 1400A48F */  lw         $a0, 0x14($sp)
    /* AAC64 800BA464 1000A5AF */  sw         $a1, 0x10($sp)
    /* AAC68 800BA468 0200C290 */  lbu        $v0, 0x2($a2)
    /* AAC6C 800BA46C 00000000 */  nop
    /* AAC70 800BA470 1A008200 */  div        $zero, $a0, $v0
    /* AAC74 800BA474 02004014 */  bnez       $v0, .L800BA480
    /* AAC78 800BA478 00000000 */   nop
    /* AAC7C 800BA47C 0D000700 */  break      7
  .L800BA480:
    /* AAC80 800BA480 FFFF0124 */  addiu      $at, $zero, -0x1
    /* AAC84 800BA484 04004114 */  bne        $v0, $at, .L800BA498
    /* AAC88 800BA488 0080013C */   lui       $at, (0x80000000 >> 16)
    /* AAC8C 800BA48C 02008114 */  bne        $a0, $at, .L800BA498
    /* AAC90 800BA490 00000000 */   nop
    /* AAC94 800BA494 0D000600 */  break      6
  .L800BA498:
    /* AAC98 800BA498 12200000 */  mflo       $a0
    /* AAC9C 800BA49C 1800A38F */  lw         $v1, 0x18($sp)
    /* AACA0 800BA4A0 1400A4AF */  sw         $a0, 0x14($sp)
    /* AACA4 800BA4A4 0200C290 */  lbu        $v0, 0x2($a2)
    /* AACA8 800BA4A8 00000000 */  nop
    /* AACAC 800BA4AC 1A006200 */  div        $zero, $v1, $v0
    /* AACB0 800BA4B0 02004014 */  bnez       $v0, .L800BA4BC
    /* AACB4 800BA4B4 00000000 */   nop
    /* AACB8 800BA4B8 0D000700 */  break      7
  .L800BA4BC:
    /* AACBC 800BA4BC FFFF0124 */  addiu      $at, $zero, -0x1
    /* AACC0 800BA4C0 04004114 */  bne        $v0, $at, .L800BA4D4
    /* AACC4 800BA4C4 0080013C */   lui       $at, (0x80000000 >> 16)
    /* AACC8 800BA4C8 02006114 */  bne        $v1, $at, .L800BA4D4
    /* AACCC 800BA4CC 00000000 */   nop
    /* AACD0 800BA4D0 0D000600 */  break      6
  .L800BA4D4:
    /* AACD4 800BA4D4 12180000 */  mflo       $v1
    /* AACD8 800BA4D8 0400C824 */  addiu      $t0, $a2, 0x4
    /* AACDC 800BA4DC 21580000 */  addu       $t3, $zero, $zero
    /* AACE0 800BA4E0 0800C924 */  addiu      $t1, $a2, 0x8
    /* AACE4 800BA4E4 1800A3AF */  sw         $v1, 0x18($sp)
    /* AACE8 800BA4E8 0200C790 */  lbu        $a3, 0x2($a2)
  .L800BA4EC:
    /* AACEC 800BA4EC 00000000 */  nop
    /* AACF0 800BA4F0 FFFFE724 */  addiu      $a3, $a3, -0x1
    /* AACF4 800BA4F4 1A00F410 */  beq        $a3, $s4, .L800BA560
    /* AACF8 800BA4F8 00000000 */   nop
    /* AACFC 800BA4FC 00000285 */  lh         $v0, 0x0($t0)
    /* AAD00 800BA500 00000000 */  nop
    /* AAD04 800BA504 2310A200 */  subu       $v0, $a1, $v0
    /* AAD08 800BA508 83110200 */  sra        $v0, $v0, 6
    /* AAD0C 800BA50C 18004200 */  mult       $v0, $v0
    /* AAD10 800BA510 FEFF2285 */  lh         $v0, -0x2($t1)
    /* AAD14 800BA514 12500000 */  mflo       $t2
    /* AAD18 800BA518 23108200 */  subu       $v0, $a0, $v0
    /* AAD1C 800BA51C 83110200 */  sra        $v0, $v0, 6
    /* AAD20 800BA520 18004200 */  mult       $v0, $v0
    /* AAD24 800BA524 00002285 */  lh         $v0, 0x0($t1)
    /* AAD28 800BA528 12300000 */  mflo       $a2
    /* AAD2C 800BA52C 23106200 */  subu       $v0, $v1, $v0
    /* AAD30 800BA530 83110200 */  sra        $v0, $v0, 6
    /* AAD34 800BA534 18004200 */  mult       $v0, $v0
    /* AAD38 800BA538 21104601 */  addu       $v0, $t2, $a2
    /* AAD3C 800BA53C 12680000 */  mflo       $t5
    /* AAD40 800BA540 21304D00 */  addu       $a2, $v0, $t5
    /* AAD44 800BA544 2A106601 */  slt        $v0, $t3, $a2
    /* AAD48 800BA548 02004010 */  beqz       $v0, .L800BA554
    /* AAD4C 800BA54C 00000000 */   nop
    /* AAD50 800BA550 2158C000 */  addu       $t3, $a2, $zero
  .L800BA554:
    /* AAD54 800BA554 08002925 */  addiu      $t1, $t1, 0x8
    /* AAD58 800BA558 3BE90208 */  j          .L800BA4EC
    /* AAD5C 800BA55C 08000825 */   addiu     $t0, $t0, 0x8
  .L800BA560:
    /* AAD60 800BA560 1000A297 */  lhu        $v0, 0x10($sp)
    /* AAD64 800BA564 01003126 */  addiu      $s1, $s1, 0x1
    /* AAD68 800BA568 000042A6 */  sh         $v0, 0x0($s2)
    /* AAD6C 800BA56C 1400A297 */  lhu        $v0, 0x14($sp)
    /* AAD70 800BA570 80220B00 */  sll        $a0, $t3, 10
    /* AAD74 800BA574 FCFF02A6 */  sh         $v0, -0x4($s0)
    /* AAD78 800BA578 1800A297 */  lhu        $v0, 0x18($sp)
    /* AAD7C 800BA57C 08005226 */  addiu      $s2, $s2, 0x8
    /* AAD80 800BA580 2BAC030C */  jal        fixedsqrt
    /* AAD84 800BA584 FEFF02A6 */   sh        $v0, -0x2($s0)
    /* AAD88 800BA588 C2110200 */  srl        $v0, $v0, 7
    /* AAD8C 800BA58C 000002A6 */  sh         $v0, 0x0($s0)
    /* AAD90 800BA590 0000628E */  lw         $v0, 0x0($s3)
    /* AAD94 800BA594 08001026 */  addiu      $s0, $s0, 0x8
    /* AAD98 800BA598 01004224 */  addiu      $v0, $v0, 0x1
    /* AAD9C 800BA59C E8E80208 */  j          .L800BA3A0
    /* AADA0 800BA5A0 000062AE */   sw        $v0, 0x0($s3)
  .L800BA5A4:
    /* AADA4 800BA5A4 3800BF8F */  lw         $ra, 0x38($sp)
    /* AADA8 800BA5A8 3400B58F */  lw         $s5, 0x34($sp)
    /* AADAC 800BA5AC 3000B48F */  lw         $s4, 0x30($sp)
    /* AADB0 800BA5B0 2C00B38F */  lw         $s3, 0x2C($sp)
    /* AADB4 800BA5B4 2800B28F */  lw         $s2, 0x28($sp)
    /* AADB8 800BA5B8 2400B18F */  lw         $s1, 0x24($sp)
    /* AADBC 800BA5BC 2000B08F */  lw         $s0, 0x20($sp)
    /* AADC0 800BA5C0 0800E003 */  jr         $ra
    /* AADC4 800BA5C4 4000BD27 */   addiu     $sp, $sp, 0x40
endlabel CalcObjectBoundingSphere__FP5GroupT0
