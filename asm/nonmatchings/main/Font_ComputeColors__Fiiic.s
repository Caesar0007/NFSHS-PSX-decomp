.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Font_ComputeColors__Fiiic, 0x318

glabel Font_ComputeColors__Fiiic
    /* BBB88 800CB388 A8FFBD27 */  addiu      $sp, $sp, -0x58
    /* BBB8C 800CB38C 4000B4AF */  sw         $s4, 0x40($sp)
    /* BBB90 800CB390 21A08000 */  addu       $s4, $a0, $zero
    /* BBB94 800CB394 4800B6AF */  sw         $s6, 0x48($sp)
    /* BBB98 800CB398 21B0E000 */  addu       $s6, $a3, $zero
    /* BBB9C 800CB39C 00FF023C */  lui        $v0, (0xFF000000 >> 16)
    /* BBBA0 800CB3A0 4400B5AF */  sw         $s5, 0x44($sp)
    /* BBBA4 800CB3A4 24A8A200 */  and        $s5, $a1, $v0
    /* BBBA8 800CB3A8 8080093C */  lui        $t1, (0x80808081 >> 16)
    /* BBBAC 800CB3AC 81802935 */  ori        $t1, $t1, (0x80808081 & 0xFFFF)
    /* BBBB0 800CB3B0 21500000 */  addu       $t2, $zero, $zero
    /* BBBB4 800CB3B4 1189193C */  lui        $t9, (0x89119A23 >> 16)
    /* BBBB8 800CB3B8 1800A5AF */  sw         $a1, 0x18($sp)
    /* BBBBC 800CB3BC 1800A293 */  lbu        $v0, 0x18($sp)
    /* BBBC0 800CB3C0 1A00A493 */  lbu        $a0, 0x1A($sp)
    /* BBBC4 800CB3C4 1280083C */  lui        $t0, %hi(shpfontclut)
    /* BBBC8 800CB3C8 5000BFAF */  sw         $ra, 0x50($sp)
    /* BBBCC 800CB3CC 4C00B7AF */  sw         $s7, 0x4C($sp)
    /* BBBD0 800CB3D0 40290200 */  sll        $a1, $v0, 5
    /* BBBD4 800CB3D4 2328A200 */  subu       $a1, $a1, $v0
    /* BBBD8 800CB3D8 1800A900 */  mult       $a1, $t1
    /* BBBDC 800CB3DC 3C00B3AF */  sw         $s3, 0x3C($sp)
    /* BBBE0 800CB3E0 3800B2AF */  sw         $s2, 0x38($sp)
    /* BBBE4 800CB3E4 3400B1AF */  sw         $s1, 0x34($sp)
    /* BBBE8 800CB3E8 3000B0AF */  sw         $s0, 0x30($sp)
    /* BBBEC 800CB3EC B0FD0225 */  addiu      $v0, $t0, %lo(shpfontclut)
    /* BBBF0 800CB3F0 21784000 */  addu       $t7, $v0, $zero
    /* BBBF4 800CB3F4 23000224 */  addiu      $v0, $zero, 0x23
    /* BBBF8 800CB3F8 B0FD02A1 */  sb         $v0, %lo(shpfontclut)($t0)
    /* BBBFC 800CB3FC 10000224 */  addiu      $v0, $zero, 0x10
    /* BBC00 800CB400 40190400 */  sll        $v1, $a0, 5
    /* BBC04 800CB404 23186400 */  subu       $v1, $v1, $a0
    /* BBC08 800CB408 10600000 */  mfhi       $t4
    /* BBC0C 800CB40C 0400E2A5 */  sh         $v0, 0x4($t7)
    /* BBC10 800CB410 1900A793 */  lbu        $a3, 0x19($sp)
    /* BBC14 800CB414 18006900 */  mult       $v1, $t1
    /* BBC18 800CB418 01000224 */  addiu      $v0, $zero, 0x1
    /* BBC1C 800CB41C 0600E2A5 */  sh         $v0, 0x6($t7)
    /* BBC20 800CB420 0800E0A5 */  sh         $zero, 0x8($t7)
    /* BBC24 800CB424 0A00E0A5 */  sh         $zero, 0xA($t7)
    /* BBC28 800CB428 B0FD0291 */  lbu        $v0, %lo(shpfontclut)($t0)
    /* BBC2C 800CB42C 239A3937 */  ori        $t9, $t9, (0x89119A23 & 0xFFFF)
    /* BBC30 800CB430 2000A6AF */  sw         $a2, 0x20($sp)
    /* BBC34 800CB434 08138697 */  lhu        $a2, %gp_rel(font_clutx)($gp)
    /* BBC38 800CB438 40210700 */  sll        $a0, $a3, 5
    /* BBC3C 800CB43C 23208700 */  subu       $a0, $a0, $a3
    /* BBC40 800CB440 0C138797 */  lhu        $a3, %gp_rel(font_cluty)($gp)
    /* BBC44 800CB444 10580000 */  mfhi       $t3
    /* BBC48 800CB448 0F001124 */  addiu      $s1, $zero, 0xF
    /* BBC4C 800CB44C B0FD02AD */  sw         $v0, %lo(shpfontclut)($t0)
    /* BBC50 800CB450 18008900 */  mult       $a0, $t1
    /* BBC54 800CB454 0C00E6A5 */  sh         $a2, 0xC($t7)
    /* BBC58 800CB458 0E00E7A5 */  sh         $a3, 0xE($t7)
    /* BBC5C 800CB45C 21106301 */  addu       $v0, $t3, $v1
    /* BBC60 800CB460 C3110200 */  sra        $v0, $v0, 7
    /* BBC64 800CB464 C31F0300 */  sra        $v1, $v1, 31
    /* BBC68 800CB468 23804300 */  subu       $s0, $v0, $v1
    /* BBC6C 800CB46C 21188501 */  addu       $v1, $t4, $a1
    /* BBC70 800CB470 C3190300 */  sra        $v1, $v1, 7
    /* BBC74 800CB474 C32F0500 */  sra        $a1, $a1, 31
    /* BBC78 800CB478 23186500 */  subu       $v1, $v1, $a1
    /* BBC7C 800CB47C 801A0300 */  sll        $v1, $v1, 10
    /* BBC80 800CB480 10480000 */  mfhi       $t1
    /* BBC84 800CB484 21102401 */  addu       $v0, $t1, $a0
    /* BBC88 800CB488 C3110200 */  sra        $v0, $v0, 7
    /* BBC8C 800CB48C C3270400 */  sra        $a0, $a0, 31
    /* BBC90 800CB490 23104400 */  subu       $v0, $v0, $a0
    /* BBC94 800CB494 40110200 */  sll        $v0, $v0, 5
    /* BBC98 800CB498 00804434 */  ori        $a0, $v0, 0x8000
    /* BBC9C 800CB49C 25986400 */  or         $s3, $v1, $a0
    /* BBCA0 800CB4A0 25906200 */  or         $s2, $v1, $v0
  .L800CB4A4:
    /* BBCA4 800CB4A4 FF00C232 */  andi       $v0, $s6, 0xFF
    /* BBCA8 800CB4A8 0A004010 */  beqz       $v0, .L800CB4D4
    /* BBCAC 800CB4AC 00000000 */   nop
    /* BBCB0 800CB4B0 0800A016 */  bnez       $s5, .L800CB4D4
    /* BBCB4 800CB4B4 08004229 */   slti      $v0, $t2, 0x8
    /* BBCB8 800CB4B8 5F004014 */  bnez       $v0, .L800CB638
    /* BBCBC 800CB4BC 21100000 */   addu      $v0, $zero, $zero
    /* BBCC0 800CB4C0 0C004229 */  slti       $v0, $t2, 0xC
    /* BBCC4 800CB4C4 5C004014 */  bnez       $v0, .L800CB638
    /* BBCC8 800CB4C8 25107002 */   or        $v0, $s3, $s0
    /* BBCCC 800CB4CC 8B2D0308 */  j          .L800CB62C
    /* BBCD0 800CB4D0 25105002 */   or        $v0, $s2, $s0
  .L800CB4D4:
    /* BBCD4 800CB4D4 1800A293 */  lbu        $v0, 0x18($sp)
    /* BBCD8 800CB4D8 00000000 */  nop
    /* BBCDC 800CB4DC 18004A00 */  mult       $v0, $t2
    /* BBCE0 800CB4E0 12100000 */  mflo       $v0
    /* BBCE4 800CB4E4 1900A393 */  lbu        $v1, 0x19($sp)
    /* BBCE8 800CB4E8 00000000 */  nop
    /* BBCEC 800CB4EC 18006A00 */  mult       $v1, $t2
    /* BBCF0 800CB4F0 12180000 */  mflo       $v1
    /* BBCF4 800CB4F4 40290200 */  sll        $a1, $v0, 5
    /* BBCF8 800CB4F8 2328A200 */  subu       $a1, $a1, $v0
    /* BBCFC 800CB4FC 1800B900 */  mult       $a1, $t9
    /* BBD00 800CB500 10600000 */  mfhi       $t4
    /* BBD04 800CB504 40390300 */  sll        $a3, $v1, 5
    /* BBD08 800CB508 2338E300 */  subu       $a3, $a3, $v1
    /* BBD0C 800CB50C 1800F900 */  mult       $a3, $t9
    /* BBD10 800CB510 10680000 */  mfhi       $t5
    /* BBD14 800CB514 1A00A293 */  lbu        $v0, 0x1A($sp)
    /* BBD18 800CB518 00000000 */  nop
    /* BBD1C 800CB51C 18004A00 */  mult       $v0, $t2
    /* BBD20 800CB520 12100000 */  mflo       $v0
    /* BBD24 800CB524 2000A393 */  lbu        $v1, 0x20($sp)
    /* BBD28 800CB528 23202A02 */  subu       $a0, $s1, $t2
    /* BBD2C 800CB52C 18006400 */  mult       $v1, $a0
    /* BBD30 800CB530 12180000 */  mflo       $v1
    /* BBD34 800CB534 40310200 */  sll        $a2, $v0, 5
    /* BBD38 800CB538 2330C200 */  subu       $a2, $a2, $v0
    /* BBD3C 800CB53C 1800D900 */  mult       $a2, $t9
    /* BBD40 800CB540 10B80000 */  mfhi       $s7
    /* BBD44 800CB544 40410300 */  sll        $t0, $v1, 5
    /* BBD48 800CB548 23400301 */  subu       $t0, $t0, $v1
    /* BBD4C 800CB54C 18001901 */  mult       $t0, $t9
    /* BBD50 800CB550 10700000 */  mfhi       $t6
    /* BBD54 800CB554 2100A293 */  lbu        $v0, 0x21($sp)
    /* BBD58 800CB558 00000000 */  nop
    /* BBD5C 800CB55C 18004400 */  mult       $v0, $a0
    /* BBD60 800CB560 12100000 */  mflo       $v0
    /* BBD64 800CB564 2200A993 */  lbu        $t1, 0x22($sp)
    /* BBD68 800CB568 00000000 */  nop
    /* BBD6C 800CB56C 18002401 */  mult       $t1, $a0
    /* BBD70 800CB570 12480000 */  mflo       $t1
    /* BBD74 800CB574 40210200 */  sll        $a0, $v0, 5
    /* BBD78 800CB578 23208200 */  subu       $a0, $a0, $v0
    /* BBD7C 800CB57C 18009900 */  mult       $a0, $t9
    /* BBD80 800CB580 21108501 */  addu       $v0, $t4, $a1
    /* BBD84 800CB584 C3120200 */  sra        $v0, $v0, 11
    /* BBD88 800CB588 C32F0500 */  sra        $a1, $a1, 31
    /* BBD8C 800CB58C 23C04500 */  subu       $t8, $v0, $a1
    /* BBD90 800CB590 2110A701 */  addu       $v0, $t5, $a3
    /* BBD94 800CB594 C3120200 */  sra        $v0, $v0, 11
    /* BBD98 800CB598 C33F0700 */  sra        $a3, $a3, 31
    /* BBD9C 800CB59C 23604700 */  subu       $t4, $v0, $a3
    /* BBDA0 800CB5A0 2110E602 */  addu       $v0, $s7, $a2
    /* BBDA4 800CB5A4 10580000 */  mfhi       $t3
    /* BBDA8 800CB5A8 40190900 */  sll        $v1, $t1, 5
    /* BBDAC 800CB5AC 23186900 */  subu       $v1, $v1, $t1
    /* BBDB0 800CB5B0 18007900 */  mult       $v1, $t9
    /* BBDB4 800CB5B4 C3120200 */  sra        $v0, $v0, 11
    /* BBDB8 800CB5B8 C3370600 */  sra        $a2, $a2, 31
    /* BBDBC 800CB5BC 23384600 */  subu       $a3, $v0, $a2
    /* BBDC0 800CB5C0 2110C801 */  addu       $v0, $t6, $t0
    /* BBDC4 800CB5C4 C3120200 */  sra        $v0, $v0, 11
    /* BBDC8 800CB5C8 C3470800 */  sra        $t0, $t0, 31
    /* BBDCC 800CB5CC 23304800 */  subu       $a2, $v0, $t0
    /* BBDD0 800CB5D0 21106401 */  addu       $v0, $t3, $a0
    /* BBDD4 800CB5D4 C3120200 */  sra        $v0, $v0, 11
    /* BBDD8 800CB5D8 C3270400 */  sra        $a0, $a0, 31
    /* BBDDC 800CB5DC 23284400 */  subu       $a1, $v0, $a0
    /* BBDE0 800CB5E0 10480000 */  mfhi       $t1
    /* BBDE4 800CB5E4 21102301 */  addu       $v0, $t1, $v1
    /* BBDE8 800CB5E8 C3120200 */  sra        $v0, $v0, 11
    /* BBDEC 800CB5EC C31F0300 */  sra        $v1, $v1, 31
    /* BBDF0 800CB5F0 23204300 */  subu       $a0, $v0, $v1
    /* BBDF4 800CB5F4 04004229 */  slti       $v0, $t2, 0x4
    /* BBDF8 800CB5F8 03004010 */  beqz       $v0, .L800CB608
    /* BBDFC 800CB5FC 2800B7AF */   sw        $s7, 0x28($sp)
    /* BBE00 800CB600 8E2D0308 */  j          .L800CB638
    /* BBE04 800CB604 21100000 */   addu      $v0, $zero, $zero
  .L800CB608:
    /* BBE08 800CB608 21100603 */  addu       $v0, $t8, $a2
    /* BBE0C 800CB60C 21188501 */  addu       $v1, $t4, $a1
    /* BBE10 800CB610 2120E400 */  addu       $a0, $a3, $a0
    /* BBE14 800CB614 80120200 */  sll        $v0, $v0, 10
    /* BBE18 800CB618 40190300 */  sll        $v1, $v1, 5
    /* BBE1C 800CB61C 25104300 */  or         $v0, $v0, $v1
    /* BBE20 800CB620 02009116 */  bne        $s4, $s1, .L800CB62C
    /* BBE24 800CB624 25104400 */   or        $v0, $v0, $a0
    /* BBE28 800CB628 00804234 */  ori        $v0, $v0, 0x8000
  .L800CB62C:
    /* BBE2C 800CB62C 02004014 */  bnez       $v0, .L800CB638
    /* BBE30 800CB630 00000000 */   nop
    /* BBE34 800CB634 00040224 */  addiu      $v0, $zero, 0x400
  .L800CB638:
    /* BBE38 800CB638 1000E2A5 */  sh         $v0, 0x10($t7)
    /* BBE3C 800CB63C 01004A25 */  addiu      $t2, $t2, 0x1
    /* BBE40 800CB640 10004229 */  slti       $v0, $t2, 0x10
    /* BBE44 800CB644 97FF4014 */  bnez       $v0, .L800CB4A4
    /* BBE48 800CB648 0200EF25 */   addiu     $t7, $t7, 0x2
    /* BBE4C 800CB64C 1280043C */  lui        $a0, %hi(shpfontclut)
    /* BBE50 800CB650 B0FD8424 */  addiu      $a0, $a0, %lo(shpfontclut)
    /* BBE54 800CB654 00391400 */  sll        $a3, $s4, 4
    /* BBE58 800CB658 0813858F */  lw         $a1, %gp_rel(font_clutx)($gp)
    /* BBE5C 800CB65C 0C13868F */  lw         $a2, %gp_rel(font_cluty)($gp)
    /* BBE60 800CB660 2138A700 */  addu       $a3, $a1, $a3
    /* BBE64 800CB664 E37E030C */  jal        Texture_Vramf__FP8shapetbliiii
    /* BBE68 800CB668 1000A6AF */   sw        $a2, 0x10($sp)
    /* BBE6C 800CB66C 1FB6030C */  jal        DrawSync
    /* BBE70 800CB670 21200000 */   addu      $a0, $zero, $zero
    /* BBE74 800CB674 5000BF8F */  lw         $ra, 0x50($sp)
    /* BBE78 800CB678 4C00B78F */  lw         $s7, 0x4C($sp)
    /* BBE7C 800CB67C 4800B68F */  lw         $s6, 0x48($sp)
    /* BBE80 800CB680 4400B58F */  lw         $s5, 0x44($sp)
    /* BBE84 800CB684 4000B48F */  lw         $s4, 0x40($sp)
    /* BBE88 800CB688 3C00B38F */  lw         $s3, 0x3C($sp)
    /* BBE8C 800CB68C 3800B28F */  lw         $s2, 0x38($sp)
    /* BBE90 800CB690 3400B18F */  lw         $s1, 0x34($sp)
    /* BBE94 800CB694 3000B08F */  lw         $s0, 0x30($sp)
    /* BBE98 800CB698 0800E003 */  jr         $ra
    /* BBE9C 800CB69C 5800BD27 */   addiu     $sp, $sp, 0x58
endlabel Font_ComputeColors__Fiiic
