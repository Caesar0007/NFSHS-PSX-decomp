.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIPhysic_InControlPhysics__FP8Car_tObj, 0x8B4

glabel AIPhysic_InControlPhysics__FP8Car_tObj
    /* 5C2C8 8006BAC8 90FFBD27 */  addiu      $sp, $sp, -0x70
    /* 5C2CC 8006BACC 5000B2AF */  sw         $s2, 0x50($sp)
    /* 5C2D0 8006BAD0 21908000 */  addu       $s2, $a0, $zero
    /* 5C2D4 8006BAD4 6C00BFAF */  sw         $ra, 0x6C($sp)
    /* 5C2D8 8006BAD8 6800BEAF */  sw         $fp, 0x68($sp)
    /* 5C2DC 8006BADC 6400B7AF */  sw         $s7, 0x64($sp)
    /* 5C2E0 8006BAE0 6000B6AF */  sw         $s6, 0x60($sp)
    /* 5C2E4 8006BAE4 5C00B5AF */  sw         $s5, 0x5C($sp)
    /* 5C2E8 8006BAE8 5800B4AF */  sw         $s4, 0x58($sp)
    /* 5C2EC 8006BAEC 5400B3AF */  sw         $s3, 0x54($sp)
    /* 5C2F0 8006BAF0 4C00B1AF */  sw         $s1, 0x4C($sp)
    /* 5C2F4 8006BAF4 4800B0AF */  sw         $s0, 0x48($sp)
    /* 5C2F8 8006BAF8 5405498E */  lw         $t1, 0x554($s2)
    /* 5C2FC 8006BAFC 00000000 */  nop
    /* 5C300 8006BB00 3800A9AF */  sw         $t1, 0x38($sp)
    /* 5C304 8006BB04 340740AE */  sw         $zero, 0x734($s2)
    /* 5C308 8006BB08 D0064A8E */  lw         $t2, 0x6D0($s2)
    /* 5C30C 8006BB0C D4064B8E */  lw         $t3, 0x6D4($s2)
    /* 5C310 8006BB10 D8064C8E */  lw         $t4, 0x6D8($s2)
    /* 5C314 8006BB14 1000AAAF */  sw         $t2, 0x10($sp)
    /* 5C318 8006BB18 1400ABAF */  sw         $t3, 0x14($sp)
    /* 5C31C 8006BB1C 1800ACAF */  sw         $t4, 0x18($sp)
    /* 5C320 8006BB20 2077020C */  jal        Math_QDNormalizeVector__FP8coorddef
    /* 5C324 8006BB24 1000A427 */   addiu     $a0, $sp, 0x10
    /* 5C328 8006BB28 1800A58F */  lw         $a1, 0x18($sp)
    /* 5C32C 8006BB2C 1400A38F */  lw         $v1, 0x14($sp)
    /* 5C330 8006BB30 1000A28F */  lw         $v0, 0x10($sp)
    /* 5C334 8006BB34 4000A0AF */  sw         $zero, 0x40($sp)
    /* 5C338 8006BB38 23100200 */  negu       $v0, $v0
    /* 5C33C 8006BB3C 2000A5AF */  sw         $a1, 0x20($sp)
    /* 5C340 8006BB40 2400A3AF */  sw         $v1, 0x24($sp)
    /* 5C344 8006BB44 2800A2AF */  sw         $v0, 0x28($sp)
    /* 5C348 8006BB48 AC00448E */  lw         $a0, 0xAC($s2)
    /* 5C34C 8006BB4C CA90030C */  jal        fixedmult
    /* 5C350 8006BB50 21A00000 */   addu      $s4, $zero, $zero
    /* 5C354 8006BB54 B000448E */  lw         $a0, 0xB0($s2)
    /* 5C358 8006BB58 2400A58F */  lw         $a1, 0x24($sp)
    /* 5C35C 8006BB5C CA90030C */  jal        fixedmult
    /* 5C360 8006BB60 21804000 */   addu      $s0, $v0, $zero
    /* 5C364 8006BB64 B400448E */  lw         $a0, 0xB4($s2)
    /* 5C368 8006BB68 2800A58F */  lw         $a1, 0x28($sp)
    /* 5C36C 8006BB6C CA90030C */  jal        fixedmult
    /* 5C370 8006BB70 21884000 */   addu      $s1, $v0, $zero
    /* 5C374 8006BB74 21801102 */  addu       $s0, $s0, $s1
    /* 5C378 8006BB78 5405438E */  lw         $v1, 0x554($s2)
    /* 5C37C 8006BB7C 21800202 */  addu       $s0, $s0, $v0
    /* 5C380 8006BB80 18000302 */  mult       $s0, $v1
    /* 5C384 8006BB84 62000524 */  addiu      $a1, $zero, 0x62
    /* 5C388 8006BB88 2C07578E */  lw         $s7, 0x72C($s2)
    /* 5C38C 8006BB8C 7405468E */  lw         $a2, 0x574($s2)
    /* 5C390 8006BB90 1807428E */  lw         $v0, 0x718($s2)
    /* 5C394 8006BB94 2004448E */  lw         $a0, 0x420($s2)
    /* 5C398 8006BB98 2330C200 */  subu       $a2, $a2, $v0
    /* 5C39C 8006BB9C 3400A6AF */  sw         $a2, 0x34($sp)
    /* 5C3A0 8006BBA0 12480000 */  mflo       $t1
    /* 5C3A4 8006BBA4 CA90030C */  jal        fixedmult
    /* 5C3A8 8006BBA8 3000A9AF */   sw        $t1, 0x30($sp)
    /* 5C3AC 8006BBAC 0100043C */  lui        $a0, (0x10000 >> 16)
    /* 5C3B0 8006BBB0 6007458E */  lw         $a1, 0x760($s2)
    /* 5C3B4 8006BBB4 CA90030C */  jal        fixedmult
    /* 5C3B8 8006BBB8 21204400 */   addu      $a0, $v0, $a0
    /* 5C3BC 8006BBBC 6002438E */  lw         $v1, 0x260($s2)
    /* 5C3C0 8006BBC0 00000000 */  nop
    /* 5C3C4 8006BBC4 08006330 */  andi       $v1, $v1, 0x8
    /* 5C3C8 8006BBC8 16006010 */  beqz       $v1, .L8006BC24
    /* 5C3CC 8006BBCC 21804000 */   addu      $s0, $v0, $zero
    /* 5C3D0 8006BBD0 1280023C */  lui        $v0, %hi(D_8011E0B0)
    /* 5C3D4 8006BBD4 B0E0448C */  lw         $a0, %lo(D_8011E0B0)($v0)
    /* 5C3D8 8006BBD8 4407428E */  lw         $v0, 0x744($s2)
    /* 5C3DC 8006BBDC 00000000 */  nop
    /* 5C3E0 8006BBE0 2A104400 */  slt        $v0, $v0, $a0
    /* 5C3E4 8006BBE4 0F004010 */  beqz       $v0, .L8006BC24
    /* 5C3E8 8006BBE8 00000000 */   nop
    /* 5C3EC 8006BBEC 1801428E */  lw         $v0, 0x118($s2)
    /* 5C3F0 8006BBF0 00000000 */  nop
    /* 5C3F4 8006BBF4 02004104 */  bgez       $v0, .L8006BC00
    /* 5C3F8 8006BBF8 00000000 */   nop
    /* 5C3FC 8006BBFC 23100200 */  negu       $v0, $v0
  .L8006BC00:
    /* 5C400 8006BC00 E9034228 */  slti       $v0, $v0, 0x3E9
    /* 5C404 8006BC04 07004014 */  bnez       $v0, .L8006BC24
    /* 5C408 8006BC08 1600023C */   lui       $v0, (0x1638E3 >> 16)
    /* 5C40C 8006BC0C 6805438E */  lw         $v1, 0x568($s2)
    /* 5C410 8006BC10 E3384234 */  ori        $v0, $v0, (0x1638E3 & 0xFFFF)
    /* 5C414 8006BC14 2A104300 */  slt        $v0, $v0, $v1
    /* 5C418 8006BC18 02004010 */  beqz       $v0, .L8006BC24
    /* 5C41C 8006BC1C 80018224 */   addiu     $v0, $a0, 0x180
    /* 5C420 8006BC20 480742AE */  sw         $v0, 0x748($s2)
  .L8006BC24:
    /* 5C424 8006BC24 F4044426 */  addiu      $a0, $s2, 0x4F4
    /* 5C428 8006BC28 1280023C */  lui        $v0, %hi(simGlobal)
    /* 5C42C 8006BC2C ACE05124 */  addiu      $s1, $v0, %lo(simGlobal)
    /* 5C430 8006BC30 0400238E */  lw         $v1, 0x4($s1)
    /* 5C434 8006BC34 B801428E */  lw         $v0, 0x1B8($s2)
    /* 5C438 8006BC38 00080524 */  addiu      $a1, $zero, 0x800
    /* 5C43C 8006BC3C 56BE010C */  jal        AIScript_DoReAction__FP10AIScript_t20AIScript_tAIReaction
    /* 5C440 8006BC40 23986200 */   subu      $s3, $v1, $v0
    /* 5C444 8006BC44 FFFF0324 */  addiu      $v1, $zero, -0x1
    /* 5C448 8006BC48 07004314 */  bne        $v0, $v1, .L8006BC68
    /* 5C44C 8006BC4C 00000000 */   nop
    /* 5C450 8006BC50 0400228E */  lw         $v0, 0x4($s1)
    /* 5C454 8006BC54 4807438E */  lw         $v1, 0x748($s2)
    /* 5C458 8006BC58 00000000 */  nop
    /* 5C45C 8006BC5C 2A104300 */  slt        $v0, $v0, $v1
    /* 5C460 8006BC60 1C004010 */  beqz       $v0, .L8006BCD4
    /* 5C464 8006BC64 1180023C */   lui       $v0, %hi(D_801131F4)
  .L8006BC68:
    /* 5C468 8006BC68 0400238E */  lw         $v1, 0x4($s1)
    /* 5C46C 8006BC6C B801428E */  lw         $v0, 0x1B8($s2)
    /* 5C470 8006BC70 00000000 */  nop
    /* 5C474 8006BC74 23106200 */  subu       $v0, $v1, $v0
    /* 5C478 8006BC78 40004228 */  slti       $v0, $v0, 0x40
    /* 5C47C 8006BC7C 02004010 */  beqz       $v0, .L8006BC88
    /* 5C480 8006BC80 21B80000 */   addu      $s7, $zero, $zero
    /* 5C484 8006BC84 480743AE */  sw         $v1, 0x748($s2)
  .L8006BC88:
    /* 5C488 8006BC88 1801438E */  lw         $v1, 0x118($s2)
    /* 5C48C 8006BC8C 00000000 */  nop
    /* 5C490 8006BC90 02006104 */  bgez       $v1, .L8006BC9C
    /* 5C494 8006BC94 2180E002 */   addu      $s0, $s7, $zero
    /* 5C498 8006BC98 23180300 */  negu       $v1, $v1
  .L8006BC9C:
    /* 5C49C 8006BC9C CA016324 */  addiu      $v1, $v1, 0x1CA
    /* 5C4A0 8006BCA0 34336228 */  slti       $v0, $v1, 0x3334
    /* 5C4A4 8006BCA4 02004014 */  bnez       $v0, .L8006BCB0
    /* 5C4A8 8006BCA8 00000000 */   nop
    /* 5C4AC 8006BCAC 33330324 */  addiu      $v1, $zero, 0x3333
  .L8006BCB0:
    /* 5C4B0 8006BCB0 1801428E */  lw         $v0, 0x118($s2)
    /* 5C4B4 8006BCB4 00000000 */  nop
    /* 5C4B8 8006BCB8 03004018 */  blez       $v0, .L8006BCC8
    /* 5C4BC 8006BCBC 23100300 */   negu      $v0, $v1
    /* 5C4C0 8006BCC0 33AF0108 */  j          .L8006BCCC
    /* 5C4C4 8006BCC4 180143AE */   sw        $v1, 0x118($s2)
  .L8006BCC8:
    /* 5C4C8 8006BCC8 180142AE */  sw         $v0, 0x118($s2)
  .L8006BCCC:
    /* 5C4CC 8006BCCC 0A00143C */  lui        $s4, (0xA0000 >> 16)
    /* 5C4D0 8006BCD0 1180023C */  lui        $v0, %hi(D_801131F4)
  .L8006BCD4:
    /* 5C4D4 8006BCD4 F4315E8C */  lw         $fp, %lo(D_801131F4)($v0)
    /* 5C4D8 8006BCD8 1000622A */  slti       $v0, $s3, 0x10
    /* 5C4DC 8006BCDC 05004010 */  beqz       $v0, .L8006BCF4
    /* 5C4E0 8006BCE0 00000000 */   nop
    /* 5C4E4 8006BCE4 4407428E */  lw         $v0, 0x744($s2)
    /* 5C4E8 8006BCE8 00000000 */  nop
    /* 5C4EC 8006BCEC ECFF4224 */  addiu      $v0, $v0, -0x14
    /* 5C4F0 8006BCF0 440742AE */  sw         $v0, 0x744($s2)
  .L8006BCF4:
    /* 5C4F4 8006BCF4 1480023C */  lui        $v0, %hi(D_8013C590)
    /* 5C4F8 8006BCF8 90C54224 */  addiu      $v0, $v0, %lo(D_8013C590)
    /* 5C4FC 8006BCFC 2110C203 */  addu       $v0, $fp, $v0
    /* 5C500 8006BD00 00004290 */  lbu        $v0, 0x0($v0)
    /* 5C504 8006BD04 00000000 */  nop
    /* 5C508 8006BD08 2A106202 */  slt        $v0, $s3, $v0
    /* 5C50C 8006BD0C 14004010 */  beqz       $v0, .L8006BD60
    /* 5C510 8006BD10 00000000 */   nop
    /* 5C514 8006BD14 B001428E */  lw         $v0, 0x1B0($s2)
    /* 5C518 8006BD18 00000000 */  nop
    /* 5C51C 8006BD1C 10004010 */  beqz       $v0, .L8006BD60
    /* 5C520 8006BD20 00000000 */   nop
    /* 5C524 8006BD24 6002428C */  lw         $v0, 0x260($v0)
    /* 5C528 8006BD28 00000000 */  nop
    /* 5C52C 8006BD2C 00024230 */  andi       $v0, $v0, 0x200
    /* 5C530 8006BD30 0B004010 */  beqz       $v0, .L8006BD60
    /* 5C534 8006BD34 21200002 */   addu      $a0, $s0, $zero
    /* 5C538 8006BD38 21B80000 */  addu       $s7, $zero, $zero
    /* 5C53C 8006BD3C 1180033C */  lui        $v1, %hi(D_8010DC54)
    /* 5C540 8006BD40 54DC6324 */  addiu      $v1, $v1, %lo(D_8010DC54)
    /* 5C544 8006BD44 80101E00 */  sll        $v0, $fp, 2
    /* 5C548 8006BD48 21104300 */  addu       $v0, $v0, $v1
    /* 5C54C 8006BD4C 0000458C */  lw         $a1, 0x0($v0)
    /* 5C550 8006BD50 01000A24 */  addiu      $t2, $zero, 0x1
    /* 5C554 8006BD54 CA90030C */  jal        fixedmult
    /* 5C558 8006BD58 4000AAAF */   sw        $t2, 0x40($sp)
    /* 5C55C 8006BD5C 21804000 */  addu       $s0, $v0, $zero
  .L8006BD60:
    /* 5C560 8006BD60 2807428E */  lw         $v0, 0x728($s2)
    /* 5C564 8006BD64 00000000 */  nop
    /* 5C568 8006BD68 02004104 */  bgez       $v0, .L8006BD74
    /* 5C56C 8006BD6C 21180002 */   addu      $v1, $s0, $zero
    /* 5C570 8006BD70 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8006BD74:
    /* 5C574 8006BD74 02000106 */  bgez       $s0, .L8006BD80
    /* 5C578 8006BD78 03220200 */   sra       $a0, $v0, 8
    /* 5C57C 8006BD7C FF000326 */  addiu      $v1, $s0, 0xFF
  .L8006BD80:
    /* 5C580 8006BD80 031A0300 */  sra        $v1, $v1, 8
    /* 5C584 8006BD84 18008300 */  mult       $a0, $v1
    /* 5C588 8006BD88 1180023C */  lui        $v0, %hi(D_8010DC90)
    /* 5C58C 8006BD8C 90DC428C */  lw         $v0, %lo(D_8010DC90)($v0)
    /* 5C590 8006BD90 12980000 */  mflo       $s3
    /* 5C594 8006BD94 03004104 */  bgez       $v0, .L8006BDA4
    /* 5C598 8006BD98 032A0200 */   sra       $a1, $v0, 8
    /* 5C59C 8006BD9C FF004224 */  addiu      $v0, $v0, 0xFF
    /* 5C5A0 8006BDA0 032A0200 */  sra        $a1, $v0, 8
  .L8006BDA4:
    /* 5C5A4 8006BDA4 1800A300 */  mult       $a1, $v1
    /* 5C5A8 8006BDA8 3007438E */  lw         $v1, 0x730($s2)
    /* 5C5AC 8006BDAC 0100023C */  lui        $v0, (0x10000 >> 16)
    /* 5C5B0 8006BDB0 2A104300 */  slt        $v0, $v0, $v1
    /* 5C5B4 8006BDB4 12A80000 */  mflo       $s5
    /* 5C5B8 8006BDB8 12004010 */  beqz       $v0, .L8006BE04
    /* 5C5BC 8006BDBC 1280023C */   lui       $v0, %hi(simGlobal)
    /* 5C5C0 8006BDC0 02006104 */  bgez       $v1, .L8006BDCC
    /* 5C5C4 8006BDC4 21206000 */   addu      $a0, $v1, $zero
    /* 5C5C8 8006BDC8 FF006424 */  addiu      $a0, $v1, 0xFF
  .L8006BDCC:
    /* 5C5CC 8006BDCC 21106002 */  addu       $v0, $s3, $zero
    /* 5C5D0 8006BDD0 02006106 */  bgez       $s3, .L8006BDDC
    /* 5C5D4 8006BDD4 03220400 */   sra       $a0, $a0, 8
    /* 5C5D8 8006BDD8 FF006226 */  addiu      $v0, $s3, 0xFF
  .L8006BDDC:
    /* 5C5DC 8006BDDC 03120200 */  sra        $v0, $v0, 8
    /* 5C5E0 8006BDE0 18008200 */  mult       $a0, $v0
    /* 5C5E4 8006BDE4 12980000 */  mflo       $s3
    /* 5C5E8 8006BDE8 0200A106 */  bgez       $s5, .L8006BDF4
    /* 5C5EC 8006BDEC 2110A002 */   addu      $v0, $s5, $zero
    /* 5C5F0 8006BDF0 FF00A226 */  addiu      $v0, $s5, 0xFF
  .L8006BDF4:
    /* 5C5F4 8006BDF4 03120200 */  sra        $v0, $v0, 8
    /* 5C5F8 8006BDF8 18008200 */  mult       $a0, $v0
    /* 5C5FC 8006BDFC 12A80000 */  mflo       $s5
    /* 5C600 8006BE00 1280023C */  lui        $v0, %hi(simGlobal)
  .L8006BE04:
    /* 5C604 8006BE04 ACE05624 */  addiu      $s6, $v0, %lo(simGlobal)
    /* 5C608 8006BE08 5407448E */  lw         $a0, 0x754($s2)
    /* 5C60C 8006BE0C 0400C38E */  lw         $v1, 0x4($s6)
    /* 5C610 8006BE10 DC06518E */  lw         $s1, 0x6DC($s2)
    /* 5C614 8006BE14 5C05498E */  lw         $t1, 0x55C($s2)
    /* 5C618 8006BE18 2A106400 */  slt        $v0, $v1, $a0
    /* 5C61C 8006BE1C 37004010 */  beqz       $v0, .L8006BEFC
    /* 5C620 8006BE20 3C00A9AF */   sw        $t1, 0x3C($sp)
    /* 5C624 8006BE24 6666023C */  lui        $v0, (0x66666667 >> 16)
    /* 5C628 8006BE28 67664234 */  ori        $v0, $v0, (0x66666667 & 0xFFFF)
    /* 5C62C 8006BE2C 18006200 */  mult       $v1, $v0
    /* 5C630 8006BE30 01000524 */  addiu      $a1, $zero, 0x1
    /* 5C634 8006BE34 23208300 */  subu       $a0, $a0, $v1
    /* 5C638 8006BE38 C31F0300 */  sra        $v1, $v1, 31
    /* 5C63C 8006BE3C 10480000 */  mfhi       $t1
    /* 5C640 8006BE40 03110900 */  sra        $v0, $t1, 4
    /* 5C644 8006BE44 23104300 */  subu       $v0, $v0, $v1
    /* 5C648 8006BE48 24104500 */  and        $v0, $v0, $a1
    /* 5C64C 8006BE4C 02004010 */  beqz       $v0, .L8006BE58
    /* 5C650 8006BE50 96000224 */   addiu     $v0, $zero, 0x96
    /* 5C654 8006BE54 FFFF0524 */  addiu      $a1, $zero, -0x1
  .L8006BE58:
    /* 5C658 8006BE58 23184400 */  subu       $v1, $v0, $a0
    /* 5C65C 8006BE5C 32006228 */  slti       $v0, $v1, 0x32
    /* 5C660 8006BE60 0D004010 */  beqz       $v0, .L8006BE98
    /* 5C664 8006BE64 00110500 */   sll       $v0, $a1, 4
    /* 5C668 8006BE68 23104500 */  subu       $v0, $v0, $a1
    /* 5C66C 8006BE6C 40100200 */  sll        $v0, $v0, 1
    /* 5C670 8006BE70 18004300 */  mult       $v0, $v1
    /* 5C674 8006BE74 12100000 */  mflo       $v0
    /* 5C678 8006BE78 EB51033C */  lui        $v1, (0x51EB851F >> 16)
    /* 5C67C 8006BE7C 1F856334 */  ori        $v1, $v1, (0x51EB851F & 0xFFFF)
    /* 5C680 8006BE80 18004300 */  mult       $v0, $v1
    /* 5C684 8006BE84 C3170200 */  sra        $v0, $v0, 31
    /* 5C688 8006BE88 10180000 */  mfhi       $v1
    /* 5C68C 8006BE8C 03190300 */  sra        $v1, $v1, 4
    /* 5C690 8006BE90 B1AF0108 */  j          .L8006BEC4
    /* 5C694 8006BE94 23186200 */   subu      $v1, $v1, $v0
  .L8006BE98:
    /* 5C698 8006BE98 4992023C */  lui        $v0, (0x92492493 >> 16)
    /* 5C69C 8006BE9C 93244234 */  ori        $v0, $v0, (0x92492493 & 0xFFFF)
    /* 5C6A0 8006BEA0 18008200 */  mult       $a0, $v0
    /* 5C6A4 8006BEA4 10180000 */  mfhi       $v1
    /* 5C6A8 8006BEA8 21106400 */  addu       $v0, $v1, $a0
    /* 5C6AC 8006BEAC 83100200 */  sra        $v0, $v0, 2
    /* 5C6B0 8006BEB0 C31F0400 */  sra        $v1, $a0, 31
    /* 5C6B4 8006BEB4 23104300 */  subu       $v0, $v0, $v1
    /* 5C6B8 8006BEB8 0A004224 */  addiu      $v0, $v0, 0xA
    /* 5C6BC 8006BEBC 1800A200 */  mult       $a1, $v0
    /* 5C6C0 8006BEC0 12180000 */  mflo       $v1
  .L8006BEC4:
    /* 5C6C4 8006BEC4 33008228 */  slti       $v0, $a0, 0x33
    /* 5C6C8 8006BEC8 2E004014 */  bnez       $v0, .L8006BF84
    /* 5C6CC 8006BECC 21882302 */   addu      $s1, $s1, $v1
    /* 5C6D0 8006BED0 EB51033C */  lui        $v1, (0x51EB851F >> 16)
    /* 5C6D4 8006BED4 1F856334 */  ori        $v1, $v1, (0x51EB851F & 0xFFFF)
    /* 5C6D8 8006BED8 80100400 */  sll        $v0, $a0, 2
    /* 5C6DC 8006BEDC 21104400 */  addu       $v0, $v0, $a0
    /* 5C6E0 8006BEE0 80140200 */  sll        $v0, $v0, 18
    /* 5C6E4 8006BEE4 18004300 */  mult       $v0, $v1
    /* 5C6E8 8006BEE8 C3170200 */  sra        $v0, $v0, 31
    /* 5C6EC 8006BEEC 10480000 */  mfhi       $t1
    /* 5C6F0 8006BEF0 03190900 */  sra        $v1, $t1, 4
    /* 5C6F4 8006BEF4 E1AF0108 */  j          .L8006BF84
    /* 5C6F8 8006BEF8 23A06200 */   subu      $s4, $v1, $v0
  .L8006BEFC:
    /* 5C6FC 8006BEFC F004428E */  lw         $v0, 0x4F0($s2)
    /* 5C700 8006BF00 00000000 */  nop
    /* 5C704 8006BF04 2C00428C */  lw         $v0, 0x2C($v0)
    /* 5C708 8006BF08 02002106 */  bgez       $s1, .L8006BF14
    /* 5C70C 8006BF0C 21802002 */   addu      $s0, $s1, $zero
    /* 5C710 8006BF10 23801000 */  negu       $s0, $s0
  .L8006BF14:
    /* 5C714 8006BF14 2A105000 */  slt        $v0, $v0, $s0
    /* 5C718 8006BF18 1B004010 */  beqz       $v0, .L8006BF88
    /* 5C71C 8006BF1C 1180023C */   lui       $v0, %hi(AIPhysicConfig)
    /* 5C720 8006BF20 F803428E */  lw         $v0, 0x3F8($s2)
    /* 5C724 8006BF24 00000000 */  nop
    /* 5C728 8006BF28 18002202 */  mult       $s1, $v0
    /* 5C72C 8006BF2C 12480000 */  mflo       $t1
    /* 5C730 8006BF30 14002019 */  blez       $t1, .L8006BF84
    /* 5C734 8006BF34 21204002 */   addu      $a0, $s2, $zero
    /* 5C738 8006BF38 9CAE010C */  jal        AIPhysic_GetRearEndDamageFactor__FP8Car_tObj
    /* 5C73C 8006BF3C 00841000 */   sll       $s0, $s0, 16
    /* 5C740 8006BF40 0100033C */  lui        $v1, (0x10000 >> 16)
    /* 5C744 8006BF44 23186200 */  subu       $v1, $v1, $v0
    /* 5C748 8006BF48 80100300 */  sll        $v0, $v1, 2
    /* 5C74C 8006BF4C F004448E */  lw         $a0, 0x4F0($s2)
    /* 5C750 8006BF50 21104300 */  addu       $v0, $v0, $v1
    /* 5C754 8006BF54 2C00838C */  lw         $v1, 0x2C($a0)
    /* 5C758 8006BF58 80100200 */  sll        $v0, $v0, 2
    /* 5C75C 8006BF5C ECFF6324 */  addiu      $v1, $v1, -0x14
    /* 5C760 8006BF60 001C0300 */  sll        $v1, $v1, 16
    /* 5C764 8006BF64 21104300 */  addu       $v0, $v0, $v1
    /* 5C768 8006BF68 2A105000 */  slt        $v0, $v0, $s0
    /* 5C76C 8006BF6C 06004010 */  beqz       $v0, .L8006BF88
    /* 5C770 8006BF70 1180023C */   lui       $v0, %hi(AIPhysicConfig)
    /* 5C774 8006BF74 0400C28E */  lw         $v0, 0x4($s6)
    /* 5C778 8006BF78 00000000 */  nop
    /* 5C77C 8006BF7C 96004224 */  addiu      $v0, $v0, 0x96
    /* 5C780 8006BF80 540742AE */  sw         $v0, 0x754($s2)
  .L8006BF84:
    /* 5C784 8006BF84 1180023C */  lui        $v0, %hi(AIPhysicConfig)
  .L8006BF88:
    /* 5C788 8006BF88 74DC5024 */  addiu      $s0, $v0, %lo(AIPhysicConfig)
    /* 5C78C 8006BF8C 2400058E */  lw         $a1, 0x24($s0)
    /* 5C790 8006BF90 CA90030C */  jal        fixedmult
    /* 5C794 8006BF94 80000424 */   addiu     $a0, $zero, 0x80
    /* 5C798 8006BF98 23181100 */  negu       $v1, $s1
    /* 5C79C 8006BF9C 18006200 */  mult       $v1, $v0
    /* 5C7A0 8006BFA0 2800048E */  lw         $a0, 0x28($s0)
    /* 5C7A4 8006BFA4 12180000 */  mflo       $v1
    /* 5C7A8 8006BFA8 2A106400 */  slt        $v0, $v1, $a0
    /* 5C7AC 8006BFAC 02004010 */  beqz       $v0, .L8006BFB8
    /* 5C7B0 8006BFB0 00000000 */   nop
    /* 5C7B4 8006BFB4 21206000 */  addu       $a0, $v1, $zero
  .L8006BFB8:
    /* 5C7B8 8006BFB8 2800028E */  lw         $v0, 0x28($s0)
    /* 5C7BC 8006BFBC 21188000 */  addu       $v1, $a0, $zero
    /* 5C7C0 8006BFC0 23200200 */  negu       $a0, $v0
    /* 5C7C4 8006BFC4 2A108300 */  slt        $v0, $a0, $v1
    /* 5C7C8 8006BFC8 02004010 */  beqz       $v0, .L8006BFD4
    /* 5C7CC 8006BFCC 00000000 */   nop
    /* 5C7D0 8006BFD0 21206000 */  addu       $a0, $v1, $zero
  .L8006BFD4:
    /* 5C7D4 8006BFD4 3400A68F */  lw         $a2, 0x34($sp)
    /* 5C7D8 8006BFD8 00000000 */  nop
    /* 5C7DC 8006BFDC 0200C104 */  bgez       $a2, .L8006BFE8
    /* 5C7E0 8006BFE0 21188000 */   addu      $v1, $a0, $zero
    /* 5C7E4 8006BFE4 FF00C624 */  addiu      $a2, $a2, 0xFF
  .L8006BFE8:
    /* 5C7E8 8006BFE8 1400028E */  lw         $v0, 0x14($s0)
    /* 5C7EC 8006BFEC 00000000 */  nop
    /* 5C7F0 8006BFF0 02004104 */  bgez       $v0, .L8006BFFC
    /* 5C7F4 8006BFF4 03320600 */   sra       $a2, $a2, 8
    /* 5C7F8 8006BFF8 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8006BFFC:
    /* 5C7FC 8006BFFC 03120200 */  sra        $v0, $v0, 8
    /* 5C800 8006C000 1800C200 */  mult       $a2, $v0
    /* 5C804 8006C004 1800048E */  lw         $a0, 0x18($s0)
    /* 5C808 8006C008 12480000 */  mflo       $t1
    /* 5C80C 8006C00C 23300900 */  negu       $a2, $t1
    /* 5C810 8006C010 2A10C400 */  slt        $v0, $a2, $a0
    /* 5C814 8006C014 02004010 */  beqz       $v0, .L8006C020
    /* 5C818 8006C018 00000000 */   nop
    /* 5C81C 8006C01C 2120C000 */  addu       $a0, $a2, $zero
  .L8006C020:
    /* 5C820 8006C020 1800028E */  lw         $v0, 0x18($s0)
    /* 5C824 8006C024 21308000 */  addu       $a2, $a0, $zero
    /* 5C828 8006C028 23200200 */  negu       $a0, $v0
    /* 5C82C 8006C02C 2A108600 */  slt        $v0, $a0, $a2
    /* 5C830 8006C030 02004010 */  beqz       $v0, .L8006C03C
    /* 5C834 8006C034 00000000 */   nop
    /* 5C838 8006C038 2120C000 */  addu       $a0, $a2, $zero
  .L8006C03C:
    /* 5C83C 8006C03C 6805458E */  lw         $a1, 0x568($s2)
    /* 5C840 8006C040 21308000 */  addu       $a2, $a0, $zero
    /* 5C844 8006C044 2A10C500 */  slt        $v0, $a2, $a1
    /* 5C848 8006C048 02004010 */  beqz       $v0, .L8006C054
    /* 5C84C 8006C04C 00000000 */   nop
    /* 5C850 8006C050 2128C000 */  addu       $a1, $a2, $zero
  .L8006C054:
    /* 5C854 8006C054 6805478E */  lw         $a3, 0x568($s2)
    /* 5C858 8006C058 2130A000 */  addu       $a2, $a1, $zero
    /* 5C85C 8006C05C 23200700 */  negu       $a0, $a3
    /* 5C860 8006C060 2A108600 */  slt        $v0, $a0, $a2
    /* 5C864 8006C064 02004010 */  beqz       $v0, .L8006C070
    /* 5C868 8006C068 00000000 */   nop
    /* 5C86C 8006C06C 2120C000 */  addu       $a0, $a2, $zero
  .L8006C070:
    /* 5C870 8006C070 21308000 */  addu       $a2, $a0, $zero
    /* 5C874 8006C074 3400058E */  lw         $a1, 0x34($s0)
    /* 5C878 8006C078 6405448E */  lw         $a0, 0x564($s2)
    /* 5C87C 8006C07C 23100500 */  negu       $v0, $a1
    /* 5C880 8006C080 2A104400 */  slt        $v0, $v0, $a0
    /* 5C884 8006C084 2B004010 */  beqz       $v0, .L8006C134
    /* 5C888 8006C088 2A108500 */   slt       $v0, $a0, $a1
    /* 5C88C 8006C08C 2A004010 */  beqz       $v0, .L8006C138
    /* 5C890 8006C090 1180023C */   lui       $v0, %hi(D_8010DCA0)
    /* 5C894 8006C094 0200E104 */  bgez       $a3, .L8006C0A0
    /* 5C898 8006C098 2120E000 */   addu      $a0, $a3, $zero
    /* 5C89C 8006C09C FF00E424 */  addiu      $a0, $a3, 0xFF
  .L8006C0A0:
    /* 5C8A0 8006C0A0 3800028E */  lw         $v0, 0x38($s0)
    /* 5C8A4 8006C0A4 00000000 */  nop
    /* 5C8A8 8006C0A8 02004104 */  bgez       $v0, .L8006C0B4
    /* 5C8AC 8006C0AC 03420400 */   sra       $t0, $a0, 8
    /* 5C8B0 8006C0B0 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8006C0B4:
    /* 5C8B4 8006C0B4 03120200 */  sra        $v0, $v0, 8
    /* 5C8B8 8006C0B8 18000201 */  mult       $t0, $v0
    /* 5C8BC 8006C0BC 12200000 */  mflo       $a0
    /* 5C8C0 8006C0C0 02008104 */  bgez       $a0, .L8006C0CC
    /* 5C8C4 8006C0C4 00000000 */   nop
    /* 5C8C8 8006C0C8 23200400 */  negu       $a0, $a0
  .L8006C0CC:
    /* 5C8CC 8006C0CC 2A10C400 */  slt        $v0, $a2, $a0
    /* 5C8D0 8006C0D0 02004010 */  beqz       $v0, .L8006C0DC
    /* 5C8D4 8006C0D4 21288000 */   addu      $a1, $a0, $zero
    /* 5C8D8 8006C0D8 2128C000 */  addu       $a1, $a2, $zero
  .L8006C0DC:
    /* 5C8DC 8006C0DC 3C00028E */  lw         $v0, 0x3C($s0)
    /* 5C8E0 8006C0E0 00000000 */  nop
    /* 5C8E4 8006C0E4 02004104 */  bgez       $v0, .L8006C0F0
    /* 5C8E8 8006C0E8 00000000 */   nop
    /* 5C8EC 8006C0EC FF004224 */  addiu      $v0, $v0, 0xFF
  .L8006C0F0:
    /* 5C8F0 8006C0F0 03120200 */  sra        $v0, $v0, 8
    /* 5C8F4 8006C0F4 18000201 */  mult       $t0, $v0
    /* 5C8F8 8006C0F8 12200000 */  mflo       $a0
    /* 5C8FC 8006C0FC 02008104 */  bgez       $a0, .L8006C108
    /* 5C900 8006C100 00000000 */   nop
    /* 5C904 8006C104 23200400 */  negu       $a0, $a0
  .L8006C108:
    /* 5C908 8006C108 2A106400 */  slt        $v0, $v1, $a0
    /* 5C90C 8006C10C 02004010 */  beqz       $v0, .L8006C118
    /* 5C910 8006C110 21288000 */   addu      $a1, $a0, $zero
    /* 5C914 8006C114 21286000 */  addu       $a1, $v1, $zero
  .L8006C118:
    /* 5C918 8006C118 2118A000 */  addu       $v1, $a1, $zero
    /* 5C91C 8006C11C 23200400 */  negu       $a0, $a0
    /* 5C920 8006C120 2A108300 */  slt        $v0, $a0, $v1
    /* 5C924 8006C124 02004010 */  beqz       $v0, .L8006C130
    /* 5C928 8006C128 00000000 */   nop
    /* 5C92C 8006C12C 21206000 */  addu       $a0, $v1, $zero
  .L8006C130:
    /* 5C930 8006C130 21188000 */  addu       $v1, $a0, $zero
  .L8006C134:
    /* 5C934 8006C134 1180023C */  lui        $v0, %hi(D_8010DCA0)
  .L8006C138:
    /* 5C938 8006C138 2804448E */  lw         $a0, 0x428($s2)
    /* 5C93C 8006C13C A0DC458C */  lw         $a1, %lo(D_8010DCA0)($v0)
    /* 5C940 8006C140 CA90030C */  jal        fixedmult
    /* 5C944 8006C144 23208300 */   subu      $a0, $a0, $v1
    /* 5C948 8006C148 23880200 */  negu       $s1, $v0
    /* 5C94C 8006C14C 2A103702 */  slt        $v0, $s1, $s7
    /* 5C950 8006C150 02004010 */  beqz       $v0, .L8006C15C
    /* 5C954 8006C154 2118E002 */   addu      $v1, $s7, $zero
    /* 5C958 8006C158 21182002 */  addu       $v1, $s1, $zero
  .L8006C15C:
    /* 5C95C 8006C15C 21886000 */  addu       $s1, $v1, $zero
    /* 5C960 8006C160 23181700 */  negu       $v1, $s7
    /* 5C964 8006C164 2A107100 */  slt        $v0, $v1, $s1
    /* 5C968 8006C168 02004010 */  beqz       $v0, .L8006C174
    /* 5C96C 8006C16C 00000000 */   nop
    /* 5C970 8006C170 21182002 */  addu       $v1, $s1, $zero
  .L8006C174:
    /* 5C974 8006C174 21886000 */  addu       $s1, $v1, $zero
    /* 5C978 8006C178 3000A48F */  lw         $a0, 0x30($sp)
    /* 5C97C 8006C17C CA90030C */  jal        fixedmult
    /* 5C980 8006C180 2128A002 */   addu      $a1, $s5, $zero
    /* 5C984 8006C184 3800A98F */  lw         $t1, 0x38($sp)
    /* 5C988 8006C188 00000000 */  nop
    /* 5C98C 8006C18C 23180900 */  negu       $v1, $t1
    /* 5C990 8006C190 18006200 */  mult       $v1, $v0
    /* 5C994 8006C194 12800000 */  mflo       $s0
    /* 5C998 8006C198 2A101302 */  slt        $v0, $s0, $s3
    /* 5C99C 8006C19C 02004010 */  beqz       $v0, .L8006C1A8
    /* 5C9A0 8006C1A0 21186002 */   addu      $v1, $s3, $zero
    /* 5C9A4 8006C1A4 21180002 */  addu       $v1, $s0, $zero
  .L8006C1A8:
    /* 5C9A8 8006C1A8 21806000 */  addu       $s0, $v1, $zero
    /* 5C9AC 8006C1AC 23181300 */  negu       $v1, $s3
    /* 5C9B0 8006C1B0 2A107000 */  slt        $v0, $v1, $s0
    /* 5C9B4 8006C1B4 02004010 */  beqz       $v0, .L8006C1C0
    /* 5C9B8 8006C1B8 00000000 */   nop
    /* 5C9BC 8006C1BC 21180002 */  addu       $v1, $s0, $zero
  .L8006C1C0:
    /* 5C9C0 8006C1C0 3C00A98F */  lw         $t1, 0x3C($sp)
    /* 5C9C4 8006C1C4 3800AA8F */  lw         $t2, 0x38($sp)
    /* 5C9C8 8006C1C8 00000000 */  nop
    /* 5C9CC 8006C1CC 18002A01 */  mult       $t1, $t2
    /* 5C9D0 8006C1D0 12100000 */  mflo       $v0
    /* 5C9D4 8006C1D4 6405458E */  lw         $a1, 0x564($s2)
    /* 5C9D8 8006C1D8 00000000 */  nop
    /* 5C9DC 8006C1DC 1800AA00 */  mult       $a1, $t2
    /* 5C9E0 8006C1E0 12300000 */  mflo       $a2
    /* 5C9E4 8006C1E4 2A10C200 */  slt        $v0, $a2, $v0
    /* 5C9E8 8006C1E8 1E004010 */  beqz       $v0, .L8006C264
    /* 5C9EC 8006C1EC 21806000 */   addu      $s0, $v1, $zero
    /* 5C9F0 8006C1F0 7802428E */  lw         $v0, 0x278($s2)
    /* 5C9F4 8006C1F4 00000000 */  nop
    /* 5C9F8 8006C1F8 1A004014 */  bnez       $v0, .L8006C264
    /* 5C9FC 8006C1FC 00000000 */   nop
    /* 5CA00 8006C200 5005438E */  lw         $v1, 0x550($s2)
    /* 5CA04 8006C204 5405428E */  lw         $v0, 0x554($s2)
    /* 5CA08 8006C208 00000000 */  nop
    /* 5CA0C 8006C20C 15006214 */  bne        $v1, $v0, .L8006C264
    /* 5CA10 8006C210 00000000 */   nop
    /* 5CA14 8006C214 ACA5010C */  jal        AIPhysic_CalcAcceleration__FP8Car_tObji
    /* 5CA18 8006C218 21204002 */   addu      $a0, $s2, $zero
    /* 5CA1C 8006C21C 40044492 */  lbu        $a0, 0x440($s2)
    /* 5CA20 8006C220 5000838F */  lw         $v1, %gp_rel(AIPhysic_elapsedTime)($gp)
    /* 5CA24 8006C224 00000000 */  nop
    /* 5CA28 8006C228 2A186400 */  slt        $v1, $v1, $a0
    /* 5CA2C 8006C22C 06006010 */  beqz       $v1, .L8006C248
    /* 5CA30 8006C230 21284000 */   addu      $a1, $v0, $zero
    /* 5CA34 8006C234 50008293 */  lbu        $v0, %gp_rel(AIPhysic_elapsedTime)($gp)
    /* 5CA38 8006C238 00000000 */  nop
    /* 5CA3C 8006C23C 23108200 */  subu       $v0, $a0, $v0
    /* 5CA40 8006C240 93B00108 */  j          .L8006C24C
    /* 5CA44 8006C244 400442A2 */   sb        $v0, 0x440($s2)
  .L8006C248:
    /* 5CA48 8006C248 400440A2 */  sb         $zero, 0x440($s2)
  .L8006C24C:
    /* 5CA4C 8006C24C 40044292 */  lbu        $v0, 0x440($s2)
    /* 5CA50 8006C250 00000000 */  nop
    /* 5CA54 8006C254 1B004014 */  bnez       $v0, .L8006C2C4
    /* 5CA58 8006C258 00000000 */   nop
    /* 5CA5C 8006C25C B1B00108 */  j          .L8006C2C4
    /* 5CA60 8006C260 3D0440A2 */   sb        $zero, 0x43D($s2)
  .L8006C264:
    /* 5CA64 8006C264 7AA6010C */  jal        AIPhysic_CalcDeceleration__FP8Car_tObj
    /* 5CA68 8006C268 21204002 */   addu      $a0, $s2, $zero
    /* 5CA6C 8006C26C 23280200 */  negu       $a1, $v0
    /* 5CA70 8006C270 5000828F */  lw         $v0, %gp_rel(AIPhysic_elapsedTime)($gp)
    /* 5CA74 8006C274 40044392 */  lbu        $v1, 0x440($s2)
    /* 5CA78 8006C278 80100200 */  sll        $v0, $v0, 2
    /* 5CA7C 8006C27C 21186200 */  addu       $v1, $v1, $v0
    /* 5CA80 8006C280 FF006228 */  slti       $v0, $v1, 0xFF
    /* 5CA84 8006C284 03004010 */  beqz       $v0, .L8006C294
    /* 5CA88 8006C288 FF000224 */   addiu     $v0, $zero, 0xFF
    /* 5CA8C 8006C28C A6B00108 */  j          .L8006C298
    /* 5CA90 8006C290 400443A2 */   sb        $v1, 0x440($s2)
  .L8006C294:
    /* 5CA94 8006C294 400442A2 */  sb         $v0, 0x440($s2)
  .L8006C298:
    /* 5CA98 8006C298 40044292 */  lbu        $v0, 0x440($s2)
    /* 5CA9C 8006C29C 00000000 */  nop
    /* 5CAA0 8006C2A0 0400422C */  sltiu      $v0, $v0, 0x4
    /* 5CAA4 8006C2A4 02004014 */  bnez       $v0, .L8006C2B0
    /* 5CAA8 8006C2A8 01000224 */   addiu     $v0, $zero, 0x1
    /* 5CAAC 8006C2AC 3D0442A2 */  sb         $v0, 0x43D($s2)
  .L8006C2B0:
    /* 5CAB0 8006C2B0 2004428E */  lw         $v0, 0x420($s2)
    /* 5CAB4 8006C2B4 00000000 */  nop
    /* 5CAB8 8006C2B8 02004104 */  bgez       $v0, .L8006C2C4
    /* 5CABC 8006C2BC 00000000 */   nop
    /* 5CAC0 8006C2C0 23280500 */  negu       $a1, $a1
  .L8006C2C4:
    /* 5CAC4 8006C2C4 4000A98F */  lw         $t1, 0x40($sp)
    /* 5CAC8 8006C2C8 00000000 */  nop
    /* 5CACC 8006C2CC 07002011 */  beqz       $t1, .L8006C2EC
    /* 5CAD0 8006C2D0 1180023C */   lui       $v0, %hi(D_8010DC64)
    /* 5CAD4 8006C2D4 64DC4224 */  addiu      $v0, $v0, %lo(D_8010DC64)
    /* 5CAD8 8006C2D8 80181E00 */  sll        $v1, $fp, 2
    /* 5CADC 8006C2DC 21186200 */  addu       $v1, $v1, $v0
    /* 5CAE0 8006C2E0 0000628C */  lw         $v0, 0x0($v1)
    /* 5CAE4 8006C2E4 00000000 */  nop
    /* 5CAE8 8006C2E8 23280200 */  negu       $a1, $v0
  .L8006C2EC:
    /* 5CAEC 8006C2EC 07008016 */  bnez       $s4, .L8006C30C
    /* 5CAF0 8006C2F0 1180023C */   lui       $v0, %hi(D_8010DC84)
    /* 5CAF4 8006C2F4 3000AA8F */  lw         $t2, 0x30($sp)
    /* 5CAF8 8006C2F8 84DC438C */  lw         $v1, %lo(D_8010DC84)($v0)
    /* 5CAFC 8006C2FC 02004105 */  bgez       $t2, .L8006C308
    /* 5CB00 8006C300 21104001 */   addu      $v0, $t2, $zero
    /* 5CB04 8006C304 23100200 */  negu       $v0, $v0
  .L8006C308:
    /* 5CB08 8006C308 23A04300 */  subu       $s4, $v0, $v1
  .L8006C30C:
    /* 5CB0C 8006C30C 0400801A */  blez       $s4, .L8006C320
    /* 5CB10 8006C310 00000000 */   nop
    /* 5CB14 8006C314 880454AE */  sw         $s4, 0x488($s2)
    /* 5CB18 8006C318 CAB00108 */  j          .L8006C328
    /* 5CB1C 8006C31C 840454AE */   sw        $s4, 0x484($s2)
  .L8006C320:
    /* 5CB20 8006C320 880440AE */  sw         $zero, 0x488($s2)
    /* 5CB24 8006C324 840440AE */  sw         $zero, 0x484($s2)
  .L8006C328:
    /* 5CB28 8006C328 0C0450AE */  sw         $s0, 0x40C($s2)
    /* 5CB2C 8006C32C 100440AE */  sw         $zero, 0x410($s2)
    /* 5CB30 8006C330 140445AE */  sw         $a1, 0x414($s2)
    /* 5CB34 8006C334 300440AE */  sw         $zero, 0x430($s2)
    /* 5CB38 8006C338 340440AE */  sw         $zero, 0x434($s2)
    /* 5CB3C 8006C33C 380440AE */  sw         $zero, 0x438($s2)
    /* 5CB40 8006C340 F40340AE */  sw         $zero, 0x3F4($s2)
    /* 5CB44 8006C344 F80351AE */  sw         $s1, 0x3F8($s2)
    /* 5CB48 8006C348 FC0340AE */  sw         $zero, 0x3FC($s2)
    /* 5CB4C 8006C34C 6C00BF8F */  lw         $ra, 0x6C($sp)
    /* 5CB50 8006C350 6800BE8F */  lw         $fp, 0x68($sp)
    /* 5CB54 8006C354 6400B78F */  lw         $s7, 0x64($sp)
    /* 5CB58 8006C358 6000B68F */  lw         $s6, 0x60($sp)
    /* 5CB5C 8006C35C 5C00B58F */  lw         $s5, 0x5C($sp)
    /* 5CB60 8006C360 5800B48F */  lw         $s4, 0x58($sp)
    /* 5CB64 8006C364 5400B38F */  lw         $s3, 0x54($sp)
    /* 5CB68 8006C368 5000B28F */  lw         $s2, 0x50($sp)
    /* 5CB6C 8006C36C 4C00B18F */  lw         $s1, 0x4C($sp)
    /* 5CB70 8006C370 4800B08F */  lw         $s0, 0x48($sp)
    /* 5CB74 8006C374 0800E003 */  jr         $ra
    /* 5CB78 8006C378 7000BD27 */   addiu     $sp, $sp, 0x70
endlabel AIPhysic_InControlPhysics__FP8Car_tObj
