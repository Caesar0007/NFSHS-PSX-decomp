.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_8002A31C, 0x250

glabel func_8002A31C
    /* 1AB1C 8002A31C D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 1AB20 8002A320 1000B0AF */  sw         $s0, 0x10($sp)
    /* 1AB24 8002A324 21808000 */  addu       $s0, $a0, $zero
    /* 1AB28 8002A328 1400B1AF */  sw         $s1, 0x14($sp)
    /* 1AB2C 8002A32C 2188A000 */  addu       $s1, $a1, $zero
    /* 1AB30 8002A330 2000BFAF */  sw         $ra, 0x20($sp)
    /* 1AB34 8002A334 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 1AB38 8002A338 1800B2AF */  sw         $s2, 0x18($sp)
    /* 1AB3C 8002A33C 44022286 */  lh         $v0, 0x244($s1)
    /* 1AB40 8002A340 00000000 */  nop
    /* 1AB44 8002A344 6F004018 */  blez       $v0, .L8002A504
    /* 1AB48 8002A348 21900000 */   addu      $s2, $zero, $zero
    /* 1AB4C 8002A34C 01001324 */  addiu      $s3, $zero, 0x1
  .L8002A350:
    /* 1AB50 8002A350 1180043C */  lui        $a0, %hi(carManager)
    /* 1AB54 8002A354 00141200 */  sll        $v0, $s2, 16
    /* 1AB58 8002A358 C3130200 */  sra        $v0, $v0, 15
    /* 1AB5C 8002A35C 21102202 */  addu       $v0, $s1, $v0
    /* 1AB60 8002A360 46024584 */  lh         $a1, 0x246($v0)
    /* 1AB64 8002A364 9358000C */  jal        GetCarFromID__11tCarManagers
    /* 1AB68 8002A368 74428424 */   addiu     $a0, $a0, %lo(carManager)
    /* 1AB6C 8002A36C 04010324 */  addiu      $v1, $zero, 0x104
    /* 1AB70 8002A370 000003AE */  sw         $v1, 0x0($s0)
    /* 1AB74 8002A374 04001026 */  addiu      $s0, $s0, 0x4
    /* 1AB78 8002A378 01004426 */  addiu      $a0, $s2, 0x1
    /* 1AB7C 8002A37C 21908000 */  addu       $s2, $a0, $zero
    /* 1AB80 8002A380 04002386 */  lh         $v1, 0x4($s1)
    /* 1AB84 8002A384 00240400 */  sll        $a0, $a0, 16
    /* 1AB88 8002A388 000003AE */  sw         $v1, 0x0($s0)
    /* 1AB8C 8002A38C 01004290 */  lbu        $v0, 0x1($v0)
    /* 1AB90 8002A390 04001026 */  addiu      $s0, $s0, 0x4
    /* 1AB94 8002A394 000002AE */  sw         $v0, 0x0($s0)
    /* 1AB98 8002A398 04001026 */  addiu      $s0, $s0, 0x4
    /* 1AB9C 8002A39C 06010224 */  addiu      $v0, $zero, 0x106
    /* 1ABA0 8002A3A0 000002AE */  sw         $v0, 0x0($s0)
    /* 1ABA4 8002A3A4 04002286 */  lh         $v0, 0x4($s1)
    /* 1ABA8 8002A3A8 04001026 */  addiu      $s0, $s0, 0x4
    /* 1ABAC 8002A3AC 000002AE */  sw         $v0, 0x0($s0)
    /* 1ABB0 8002A3B0 04001026 */  addiu      $s0, $s0, 0x4
    /* 1ABB4 8002A3B4 000013AE */  sw         $s3, 0x0($s0)
    /* 1ABB8 8002A3B8 04001026 */  addiu      $s0, $s0, 0x4
    /* 1ABBC 8002A3BC 0A010224 */  addiu      $v0, $zero, 0x10A
    /* 1ABC0 8002A3C0 000002AE */  sw         $v0, 0x0($s0)
    /* 1ABC4 8002A3C4 04002286 */  lh         $v0, 0x4($s1)
    /* 1ABC8 8002A3C8 04001026 */  addiu      $s0, $s0, 0x4
    /* 1ABCC 8002A3CC 000002AE */  sw         $v0, 0x0($s0)
    /* 1ABD0 8002A3D0 04001026 */  addiu      $s0, $s0, 0x4
    /* 1ABD4 8002A3D4 000000AE */  sw         $zero, 0x0($s0)
    /* 1ABD8 8002A3D8 04001026 */  addiu      $s0, $s0, 0x4
    /* 1ABDC 8002A3DC 0B010224 */  addiu      $v0, $zero, 0x10B
    /* 1ABE0 8002A3E0 000002AE */  sw         $v0, 0x0($s0)
    /* 1ABE4 8002A3E4 04002286 */  lh         $v0, 0x4($s1)
    /* 1ABE8 8002A3E8 04001026 */  addiu      $s0, $s0, 0x4
    /* 1ABEC 8002A3EC 000002AE */  sw         $v0, 0x0($s0)
    /* 1ABF0 8002A3F0 04001026 */  addiu      $s0, $s0, 0x4
    /* 1ABF4 8002A3F4 000000AE */  sw         $zero, 0x0($s0)
    /* 1ABF8 8002A3F8 04001026 */  addiu      $s0, $s0, 0x4
    /* 1ABFC 8002A3FC 05010224 */  addiu      $v0, $zero, 0x105
    /* 1AC00 8002A400 000002AE */  sw         $v0, 0x0($s0)
    /* 1AC04 8002A404 04002286 */  lh         $v0, 0x4($s1)
    /* 1AC08 8002A408 04001026 */  addiu      $s0, $s0, 0x4
    /* 1AC0C 8002A40C 000002AE */  sw         $v0, 0x0($s0)
    /* 1AC10 8002A410 04001026 */  addiu      $s0, $s0, 0x4
    /* 1AC14 8002A414 04000224 */  addiu      $v0, $zero, 0x4
    /* 1AC18 8002A418 000002AE */  sw         $v0, 0x0($s0)
    /* 1AC1C 8002A41C 21800202 */  addu       $s0, $s0, $v0
    /* 1AC20 8002A420 18010224 */  addiu      $v0, $zero, 0x118
    /* 1AC24 8002A424 000002AE */  sw         $v0, 0x0($s0)
    /* 1AC28 8002A428 04002286 */  lh         $v0, 0x4($s1)
    /* 1AC2C 8002A42C 04001026 */  addiu      $s0, $s0, 0x4
    /* 1AC30 8002A430 000002AE */  sw         $v0, 0x0($s0)
    /* 1AC34 8002A434 04001026 */  addiu      $s0, $s0, 0x4
    /* 1AC38 8002A438 08000224 */  addiu      $v0, $zero, 0x8
    /* 1AC3C 8002A43C 000002AE */  sw         $v0, 0x0($s0)
    /* 1AC40 8002A440 04001026 */  addiu      $s0, $s0, 0x4
    /* 1AC44 8002A444 0C010224 */  addiu      $v0, $zero, 0x10C
    /* 1AC48 8002A448 000002AE */  sw         $v0, 0x0($s0)
    /* 1AC4C 8002A44C 04002286 */  lh         $v0, 0x4($s1)
    /* 1AC50 8002A450 04001026 */  addiu      $s0, $s0, 0x4
    /* 1AC54 8002A454 000002AE */  sw         $v0, 0x0($s0)
    /* 1AC58 8002A458 04001026 */  addiu      $s0, $s0, 0x4
    /* 1AC5C 8002A45C 000013AE */  sw         $s3, 0x0($s0)
    /* 1AC60 8002A460 04001026 */  addiu      $s0, $s0, 0x4
    /* 1AC64 8002A464 25010224 */  addiu      $v0, $zero, 0x125
    /* 1AC68 8002A468 000002AE */  sw         $v0, 0x0($s0)
    /* 1AC6C 8002A46C 04002286 */  lh         $v0, 0x4($s1)
    /* 1AC70 8002A470 04001026 */  addiu      $s0, $s0, 0x4
    /* 1AC74 8002A474 000002AE */  sw         $v0, 0x0($s0)
    /* 1AC78 8002A478 04001026 */  addiu      $s0, $s0, 0x4
    /* 1AC7C 8002A47C 000000AE */  sw         $zero, 0x0($s0)
    /* 1AC80 8002A480 04001026 */  addiu      $s0, $s0, 0x4
    /* 1AC84 8002A484 10010224 */  addiu      $v0, $zero, 0x110
    /* 1AC88 8002A488 000002AE */  sw         $v0, 0x0($s0)
    /* 1AC8C 8002A48C 04002286 */  lh         $v0, 0x4($s1)
    /* 1AC90 8002A490 04001026 */  addiu      $s0, $s0, 0x4
    /* 1AC94 8002A494 000002AE */  sw         $v0, 0x0($s0)
    /* 1AC98 8002A498 04001026 */  addiu      $s0, $s0, 0x4
    /* 1AC9C 8002A49C 000000AE */  sw         $zero, 0x0($s0)
    /* 1ACA0 8002A4A0 04001026 */  addiu      $s0, $s0, 0x4
    /* 1ACA4 8002A4A4 12010224 */  addiu      $v0, $zero, 0x112
    /* 1ACA8 8002A4A8 000002AE */  sw         $v0, 0x0($s0)
    /* 1ACAC 8002A4AC 04002286 */  lh         $v0, 0x4($s1)
    /* 1ACB0 8002A4B0 04001026 */  addiu      $s0, $s0, 0x4
    /* 1ACB4 8002A4B4 000002AE */  sw         $v0, 0x0($s0)
    /* 1ACB8 8002A4B8 04001026 */  addiu      $s0, $s0, 0x4
    /* 1ACBC 8002A4BC 000000AE */  sw         $zero, 0x0($s0)
    /* 1ACC0 8002A4C0 04001026 */  addiu      $s0, $s0, 0x4
    /* 1ACC4 8002A4C4 0D010224 */  addiu      $v0, $zero, 0x10D
    /* 1ACC8 8002A4C8 000002AE */  sw         $v0, 0x0($s0)
    /* 1ACCC 8002A4CC 04002286 */  lh         $v0, 0x4($s1)
    /* 1ACD0 8002A4D0 04001026 */  addiu      $s0, $s0, 0x4
    /* 1ACD4 8002A4D4 000002AE */  sw         $v0, 0x0($s0)
    /* 1ACD8 8002A4D8 04001026 */  addiu      $s0, $s0, 0x4
    /* 1ACDC 8002A4DC 000000AE */  sw         $zero, 0x0($s0)
    /* 1ACE0 8002A4E0 04002296 */  lhu        $v0, 0x4($s1)
    /* 1ACE4 8002A4E4 03240400 */  sra        $a0, $a0, 16
    /* 1ACE8 8002A4E8 01004224 */  addiu      $v0, $v0, 0x1
    /* 1ACEC 8002A4EC 040022A6 */  sh         $v0, 0x4($s1)
    /* 1ACF0 8002A4F0 44022286 */  lh         $v0, 0x244($s1)
    /* 1ACF4 8002A4F4 00000000 */  nop
    /* 1ACF8 8002A4F8 2A208200 */  slt        $a0, $a0, $v0
    /* 1ACFC 8002A4FC 94FF8014 */  bnez       $a0, .L8002A350
    /* 1AD00 8002A500 04001026 */   addiu     $s0, $s0, 0x4
  .L8002A504:
    /* 1AD04 8002A504 5555043C */  lui        $a0, (0x55555556 >> 16)
    /* 1AD08 8002A508 44022296 */  lhu        $v0, 0x244($s1)
    /* 1AD0C 8002A50C 56558434 */  ori        $a0, $a0, (0x55555556 & 0xFFFF)
    /* 1AD10 8002A510 00140200 */  sll        $v0, $v0, 16
    /* 1AD14 8002A514 031C0200 */  sra        $v1, $v0, 16
    /* 1AD18 8002A518 18006400 */  mult       $v1, $a0
    /* 1AD1C 8002A51C C3170200 */  sra        $v0, $v0, 31
    /* 1AD20 8002A520 10300000 */  mfhi       $a2
    /* 1AD24 8002A524 05006018 */  blez       $v1, .L8002A53C
    /* 1AD28 8002A528 2320C200 */   subu      $a0, $a2, $v0
    /* 1AD2C 8002A52C 0200801C */  bgtz       $a0, .L8002A538
    /* 1AD30 8002A530 21108000 */   addu      $v0, $a0, $zero
    /* 1AD34 8002A534 01000224 */  addiu      $v0, $zero, 0x1
  .L8002A538:
    /* 1AD38 8002A538 21204000 */  addu       $a0, $v0, $zero
  .L8002A53C:
    /* 1AD3C 8002A53C 0D000224 */  addiu      $v0, $zero, 0xD
    /* 1AD40 8002A540 000002AE */  sw         $v0, 0x0($s0)
    /* 1AD44 8002A544 04001026 */  addiu      $s0, $s0, 0x4
    /* 1AD48 8002A548 04000226 */  addiu      $v0, $s0, 0x4
    /* 1AD4C 8002A54C 000004AE */  sw         $a0, 0x0($s0)
    /* 1AD50 8002A550 2000BF8F */  lw         $ra, 0x20($sp)
    /* 1AD54 8002A554 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 1AD58 8002A558 1800B28F */  lw         $s2, 0x18($sp)
    /* 1AD5C 8002A55C 1400B18F */  lw         $s1, 0x14($sp)
    /* 1AD60 8002A560 1000B08F */  lw         $s0, 0x10($sp)
    /* 1AD64 8002A564 0800E003 */  jr         $ra
    /* 1AD68 8002A568 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel func_8002A31C
