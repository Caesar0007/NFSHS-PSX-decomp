.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching PSXTransDrawBrightEndLine__Fiiiiiiiii, 0x284

glabel PSXTransDrawBrightEndLine__Fiiiiiiiii
    /* 3C378 8004BB78 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* 3C37C 8004BB7C 3800B6AF */  sw         $s6, 0x38($sp)
    /* 3C380 8004BB80 5800B68F */  lw         $s6, 0x58($sp)
    /* 3C384 8004BB84 4000BEAF */  sw         $fp, 0x40($sp)
    /* 3C388 8004BB88 5C00BE8F */  lw         $fp, 0x5C($sp)
    /* 3C38C 8004BB8C 3C00B7AF */  sw         $s7, 0x3C($sp)
    /* 3C390 8004BB90 6000B78F */  lw         $s7, 0x60($sp)
    /* 3C394 8004BB94 2C00B3AF */  sw         $s3, 0x2C($sp)
    /* 3C398 8004BB98 21988000 */  addu       $s3, $a0, $zero
    /* 3C39C 8004BB9C 2800B2AF */  sw         $s2, 0x28($sp)
    /* 3C3A0 8004BBA0 2190A000 */  addu       $s2, $a1, $zero
    /* 3C3A4 8004BBA4 3000B4AF */  sw         $s4, 0x30($sp)
    /* 3C3A8 8004BBA8 21A0C000 */  addu       $s4, $a2, $zero
    /* 3C3AC 8004BBAC 3400B5AF */  sw         $s5, 0x34($sp)
    /* 3C3B0 8004BBB0 21A8E000 */  addu       $s5, $a3, $zero
    /* 3C3B4 8004BBB4 2000B0AF */  sw         $s0, 0x20($sp)
    /* 3C3B8 8004BBB8 80001024 */  addiu      $s0, $zero, 0x80
    /* 3C3BC 8004BBBC 4400BFAF */  sw         $ra, 0x44($sp)
    /* 3C3C0 8004BBC0 8200F012 */  beq        $s7, $s0, .L8004BDCC
    /* 3C3C4 8004BBC4 2400B1AF */   sw        $s1, 0x24($sp)
    /* 3C3C8 8004BBC8 FF00053C */  lui        $a1, (0xFFFFFF >> 16)
    /* 3C3CC 8004BBCC FFFFA534 */  ori        $a1, $a1, (0xFFFFFF & 0xFFFF)
    /* 3C3D0 8004BBD0 FE2D010C */  jal        CalcFadeVal__Fiii
    /* 3C3D4 8004BBD4 40000624 */   addiu     $a2, $zero, 0x40
    /* 3C3D8 8004BBD8 4800E012 */  beqz       $s7, .L8004BCFC
    /* 3C3DC 8004BBDC 21184000 */   addu      $v1, $v0, $zero
    /* 3C3E0 8004BBE0 0200C22F */  sltiu      $v0, $fp, 0x2
    /* 3C3E4 8004BBE4 1F004010 */  beqz       $v0, .L8004BC64
    /* 3C3E8 8004BBE8 23101702 */   subu      $v0, $s0, $s7
    /* 3C3EC 8004BBEC 1800C202 */  mult       $s6, $v0
    /* 3C3F0 8004BBF0 12100000 */  mflo       $v0
    /* 3C3F4 8004BBF4 03004104 */  bgez       $v0, .L8004BC04
    /* 3C3F8 8004BBF8 C3810200 */   sra       $s0, $v0, 7
    /* 3C3FC 8004BBFC 7F004224 */  addiu      $v0, $v0, 0x7F
    /* 3C400 8004BC00 C3810200 */  sra        $s0, $v0, 7
  .L8004BC04:
    /* 3C404 8004BC04 833A0200 */  sra        $a3, $v0, 10
    /* 3C408 8004BC08 0900E228 */  slti       $v0, $a3, 0x9
    /* 3C40C 8004BC0C 02004014 */  bnez       $v0, .L8004BC18
    /* 3C410 8004BC10 2188A002 */   addu      $s1, $s5, $zero
    /* 3C414 8004BC14 08000724 */  addiu      $a3, $zero, 0x8
  .L8004BC18:
    /* 3C418 8004BC18 01000224 */  addiu      $v0, $zero, 0x1
    /* 3C41C 8004BC1C 0900C217 */  bne        $fp, $v0, .L8004BC44
    /* 3C420 8004BC20 21109602 */   addu      $v0, $s4, $s6
    /* 3C424 8004BC24 21204002 */  addu       $a0, $s2, $zero
    /* 3C428 8004BC28 21289002 */  addu       $a1, $s4, $s0
    /* 3C42C 8004BC2C 2328A700 */  subu       $a1, $a1, $a3
    /* 3C430 8004BC30 21302002 */  addu       $a2, $s1, $zero
    /* 3C434 8004BC34 1000B3AF */  sw         $s3, 0x10($sp)
    /* 3C438 8004BC38 1400B3AF */  sw         $s3, 0x14($sp)
    /* 3C43C 8004BC3C 3B2F0108 */  j          .L8004BCEC
    /* 3C440 8004BC40 1800A3AF */   sw        $v1, 0x18($sp)
  .L8004BC44:
    /* 3C444 8004BC44 23A05000 */  subu       $s4, $v0, $s0
    /* 3C448 8004BC48 21204002 */  addu       $a0, $s2, $zero
    /* 3C44C 8004BC4C 21288002 */  addu       $a1, $s4, $zero
    /* 3C450 8004BC50 21302002 */  addu       $a2, $s1, $zero
    /* 3C454 8004BC54 1000A3AF */  sw         $v1, 0x10($sp)
    /* 3C458 8004BC58 1400A3AF */  sw         $v1, 0x14($sp)
    /* 3C45C 8004BC5C 302F0108 */  j          .L8004BCC0
    /* 3C460 8004BC60 1800B3AF */   sw        $s3, 0x18($sp)
  .L8004BC64:
    /* 3C464 8004BC64 1800A202 */  mult       $s5, $v0
    /* 3C468 8004BC68 12100000 */  mflo       $v0
    /* 3C46C 8004BC6C 03004104 */  bgez       $v0, .L8004BC7C
    /* 3C470 8004BC70 C3890200 */   sra       $s1, $v0, 7
    /* 3C474 8004BC74 7F004224 */  addiu      $v0, $v0, 0x7F
    /* 3C478 8004BC78 C3890200 */  sra        $s1, $v0, 7
  .L8004BC7C:
    /* 3C47C 8004BC7C 833A0200 */  sra        $a3, $v0, 10
    /* 3C480 8004BC80 0900E228 */  slti       $v0, $a3, 0x9
    /* 3C484 8004BC84 02004014 */  bnez       $v0, .L8004BC90
    /* 3C488 8004BC88 2180C002 */   addu      $s0, $s6, $zero
    /* 3C48C 8004BC8C 08000724 */  addiu      $a3, $zero, 0x8
  .L8004BC90:
    /* 3C490 8004BC90 02000224 */  addiu      $v0, $zero, 0x2
    /* 3C494 8004BC94 0E00C217 */  bne        $fp, $v0, .L8004BCD0
    /* 3C498 8004BC98 21205102 */   addu      $a0, $s2, $s1
    /* 3C49C 8004BC9C 21105502 */  addu       $v0, $s2, $s5
    /* 3C4A0 8004BCA0 23905100 */  subu       $s2, $v0, $s1
    /* 3C4A4 8004BCA4 21204002 */  addu       $a0, $s2, $zero
    /* 3C4A8 8004BCA8 21288002 */  addu       $a1, $s4, $zero
    /* 3C4AC 8004BCAC 2130E000 */  addu       $a2, $a3, $zero
    /* 3C4B0 8004BCB0 21380002 */  addu       $a3, $s0, $zero
    /* 3C4B4 8004BCB4 1000A3AF */  sw         $v1, 0x10($sp)
    /* 3C4B8 8004BCB8 1400B3AF */  sw         $s3, 0x14($sp)
    /* 3C4BC 8004BCBC 1800A3AF */  sw         $v1, 0x18($sp)
  .L8004BCC0:
    /* 3C4C0 8004BCC0 373B010C */  jal        PSXDrawGouraudSquare__Fiiiiiiii
    /* 3C4C4 8004BCC4 1C00B3AF */   sw        $s3, 0x1C($sp)
    /* 3C4C8 8004BCC8 412F0108 */  j          .L8004BD04
    /* 3C4CC 8004BCCC 00000000 */   nop
  .L8004BCD0:
    /* 3C4D0 8004BCD0 23208700 */  subu       $a0, $a0, $a3
    /* 3C4D4 8004BCD4 21288002 */  addu       $a1, $s4, $zero
    /* 3C4D8 8004BCD8 2130E000 */  addu       $a2, $a3, $zero
    /* 3C4DC 8004BCDC 21380002 */  addu       $a3, $s0, $zero
    /* 3C4E0 8004BCE0 1000B3AF */  sw         $s3, 0x10($sp)
    /* 3C4E4 8004BCE4 1400A3AF */  sw         $v1, 0x14($sp)
    /* 3C4E8 8004BCE8 1800B3AF */  sw         $s3, 0x18($sp)
  .L8004BCEC:
    /* 3C4EC 8004BCEC 373B010C */  jal        PSXDrawGouraudSquare__Fiiiiiiii
    /* 3C4F0 8004BCF0 1C00A3AF */   sw        $v1, 0x1C($sp)
    /* 3C4F4 8004BCF4 412F0108 */  j          .L8004BD04
    /* 3C4F8 8004BCF8 00000000 */   nop
  .L8004BCFC:
    /* 3C4FC 8004BCFC 2188A002 */  addu       $s1, $s5, $zero
    /* 3C500 8004BD00 2180C002 */  addu       $s0, $s6, $zero
  .L8004BD04:
    /* 3C504 8004BD04 6400A88F */  lw         $t0, 0x64($sp)
    /* 3C508 8004BD08 00000000 */  nop
    /* 3C50C 8004BD0C 1D000011 */  beqz       $t0, .L8004BD84
    /* 3C510 8004BD10 02000224 */   addiu     $v0, $zero, 0x2
    /* 3C514 8004BD14 0400C213 */  beq        $fp, $v0, .L8004BD28
    /* 3C518 8004BD18 21205102 */   addu      $a0, $s2, $s1
    /* 3C51C 8004BD1C 0D00E016 */  bnez       $s7, .L8004BD54
    /* 3C520 8004BD20 03000224 */   addiu     $v0, $zero, 0x3
    /* 3C524 8004BD24 21205102 */  addu       $a0, $s2, $s1
  .L8004BD28:
    /* 3C528 8004BD28 21288002 */  addu       $a1, $s4, $zero
    /* 3C52C 8004BD2C 6400A88F */  lw         $t0, 0x64($sp)
    /* 3C530 8004BD30 21380002 */  addu       $a3, $s0, $zero
    /* 3C534 8004BD34 1000B3AF */  sw         $s3, 0x10($sp)
    /* 3C538 8004BD38 1400A0AF */  sw         $zero, 0x14($sp)
    /* 3C53C 8004BD3C 1800B3AF */  sw         $s3, 0x18($sp)
    /* 3C540 8004BD40 1C00A0AF */  sw         $zero, 0x1C($sp)
    /* 3C544 8004BD44 23208800 */  subu       $a0, $a0, $t0
    /* 3C548 8004BD48 373B010C */  jal        PSXDrawGouraudSquare__Fiiiiiiii
    /* 3C54C 8004BD4C 21300001 */   addu      $a2, $t0, $zero
    /* 3C550 8004BD50 03000224 */  addiu      $v0, $zero, 0x3
  .L8004BD54:
    /* 3C554 8004BD54 0300C213 */  beq        $fp, $v0, .L8004BD64
    /* 3C558 8004BD58 21204002 */   addu      $a0, $s2, $zero
    /* 3C55C 8004BD5C 0900E016 */  bnez       $s7, .L8004BD84
    /* 3C560 8004BD60 00000000 */   nop
  .L8004BD64:
    /* 3C564 8004BD64 21288002 */  addu       $a1, $s4, $zero
    /* 3C568 8004BD68 6400A68F */  lw         $a2, 0x64($sp)
    /* 3C56C 8004BD6C 21380002 */  addu       $a3, $s0, $zero
    /* 3C570 8004BD70 1000A0AF */  sw         $zero, 0x10($sp)
    /* 3C574 8004BD74 1400B3AF */  sw         $s3, 0x14($sp)
    /* 3C578 8004BD78 1800A0AF */  sw         $zero, 0x18($sp)
    /* 3C57C 8004BD7C 373B010C */  jal        PSXDrawGouraudSquare__Fiiiiiiii
    /* 3C580 8004BD80 1C00B3AF */   sw        $s3, 0x1C($sp)
  .L8004BD84:
    /* 3C584 8004BD84 6800A88F */  lw         $t0, 0x68($sp)
    /* 3C588 8004BD88 00000000 */  nop
    /* 3C58C 8004BD8C 08000015 */  bnez       $t0, .L8004BDB0
    /* 3C590 8004BD90 21206002 */   addu      $a0, $s3, $zero
    /* 3C594 8004BD94 1000B0AF */  sw         $s0, 0x10($sp)
    /* 3C598 8004BD98 21284002 */  addu       $a1, $s2, $zero
    /* 3C59C 8004BD9C 21308002 */  addu       $a2, $s4, $zero
    /* 3C5A0 8004BDA0 113B010C */  jal        PSXDrawSquare__Fiiiii
    /* 3C5A4 8004BDA4 21382002 */   addu      $a3, $s1, $zero
    /* 3C5A8 8004BDA8 732F0108 */  j          .L8004BDCC
    /* 3C5AC 8004BDAC 00000000 */   nop
  .L8004BDB0:
    /* 3C5B0 8004BDB0 21284002 */  addu       $a1, $s2, $zero
    /* 3C5B4 8004BDB4 21308002 */  addu       $a2, $s4, $zero
    /* 3C5B8 8004BDB8 21382002 */  addu       $a3, $s1, $zero
    /* 3C5BC 8004BDBC 01000224 */  addiu      $v0, $zero, 0x1
    /* 3C5C0 8004BDC0 1000B0AF */  sw         $s0, 0x10($sp)
    /* 3C5C4 8004BDC4 B43B010C */  jal        PSXDrawTransSquare__Fiiiiis
    /* 3C5C8 8004BDC8 1400A2AF */   sw        $v0, 0x14($sp)
  .L8004BDCC:
    /* 3C5CC 8004BDCC 4400BF8F */  lw         $ra, 0x44($sp)
    /* 3C5D0 8004BDD0 4000BE8F */  lw         $fp, 0x40($sp)
    /* 3C5D4 8004BDD4 3C00B78F */  lw         $s7, 0x3C($sp)
    /* 3C5D8 8004BDD8 3800B68F */  lw         $s6, 0x38($sp)
    /* 3C5DC 8004BDDC 3400B58F */  lw         $s5, 0x34($sp)
    /* 3C5E0 8004BDE0 3000B48F */  lw         $s4, 0x30($sp)
    /* 3C5E4 8004BDE4 2C00B38F */  lw         $s3, 0x2C($sp)
    /* 3C5E8 8004BDE8 2800B28F */  lw         $s2, 0x28($sp)
    /* 3C5EC 8004BDEC 2400B18F */  lw         $s1, 0x24($sp)
    /* 3C5F0 8004BDF0 2000B08F */  lw         $s0, 0x20($sp)
    /* 3C5F4 8004BDF4 0800E003 */  jr         $ra
    /* 3C5F8 8004BDF8 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel PSXTransDrawBrightEndLine__Fiiiiiiiii
    /* 3C5FC 8004BDFC 00000000 */  nop
