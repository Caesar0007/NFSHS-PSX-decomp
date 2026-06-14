.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Collide_DoObjectFixedObjectCollision__FP13BO_tNewtonObjP8coorddefN21, 0xDA8

glabel Collide_DoObjectFixedObjectCollision__FP13BO_tNewtonObjP8coorddefN21
    /* 7D30C 8008CB0C 40FFBD27 */  addiu      $sp, $sp, -0xC0
    /* 7D310 8008CB10 A800B2AF */  sw         $s2, 0xA8($sp)
    /* 7D314 8008CB14 21908000 */  addu       $s2, $a0, $zero
    /* 7D318 8008CB18 AC00B3AF */  sw         $s3, 0xAC($sp)
    /* 7D31C 8008CB1C 2198A000 */  addu       $s3, $a1, $zero
    /* 7D320 8008CB20 B800BFAF */  sw         $ra, 0xB8($sp)
    /* 7D324 8008CB24 B400B5AF */  sw         $s5, 0xB4($sp)
    /* 7D328 8008CB28 B000B4AF */  sw         $s4, 0xB0($sp)
    /* 7D32C 8008CB2C A400B1AF */  sw         $s1, 0xA4($sp)
    /* 7D330 8008CB30 A000B0AF */  sw         $s0, 0xA0($sp)
    /* 7D334 8008CB34 0000CE8C */  lw         $t6, 0x0($a2)
    /* 7D338 8008CB38 0400CF8C */  lw         $t7, 0x4($a2)
    /* 7D33C 8008CB3C 0800D88C */  lw         $t8, 0x8($a2)
    /* 7D340 8008CB40 6000AEAF */  sw         $t6, 0x60($sp)
    /* 7D344 8008CB44 6400AFAF */  sw         $t7, 0x64($sp)
    /* 7D348 8008CB48 6800B8AF */  sw         $t8, 0x68($sp)
    /* 7D34C 8008CB4C 0000EE8C */  lw         $t6, 0x0($a3)
    /* 7D350 8008CB50 0400EF8C */  lw         $t7, 0x4($a3)
    /* 7D354 8008CB54 0800F88C */  lw         $t8, 0x8($a3)
    /* 7D358 8008CB58 1000AEAF */  sw         $t6, 0x10($sp)
    /* 7D35C 8008CB5C 1400AFAF */  sw         $t7, 0x14($sp)
    /* 7D360 8008CB60 1800B8AF */  sw         $t8, 0x18($sp)
    /* 7D364 8008CB64 1000A38F */  lw         $v1, 0x10($sp)
    /* 7D368 8008CB68 00000000 */  nop
    /* 7D36C 8008CB6C 02006104 */  bgez       $v1, .L8008CB78
    /* 7D370 8008CB70 21A80000 */   addu      $s5, $zero, $zero
    /* 7D374 8008CB74 FF006324 */  addiu      $v1, $v1, 0xFF
  .L8008CB78:
    /* 7D378 8008CB78 AC00428E */  lw         $v0, 0xAC($s2)
    /* 7D37C 8008CB7C 00000000 */  nop
    /* 7D380 8008CB80 02004104 */  bgez       $v0, .L8008CB8C
    /* 7D384 8008CB84 03220300 */   sra       $a0, $v1, 8
    /* 7D388 8008CB88 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008CB8C:
    /* 7D38C 8008CB8C 03120200 */  sra        $v0, $v0, 8
    /* 7D390 8008CB90 18008200 */  mult       $a0, $v0
    /* 7D394 8008CB94 1400A58F */  lw         $a1, 0x14($sp)
    /* 7D398 8008CB98 12200000 */  mflo       $a0
    /* 7D39C 8008CB9C 0200A104 */  bgez       $a1, .L8008CBA8
    /* 7D3A0 8008CBA0 2118A000 */   addu      $v1, $a1, $zero
    /* 7D3A4 8008CBA4 FF00A324 */  addiu      $v1, $a1, 0xFF
  .L8008CBA8:
    /* 7D3A8 8008CBA8 B000428E */  lw         $v0, 0xB0($s2)
    /* 7D3AC 8008CBAC 00000000 */  nop
    /* 7D3B0 8008CBB0 02004104 */  bgez       $v0, .L8008CBBC
    /* 7D3B4 8008CBB4 03520300 */   sra       $t2, $v1, 8
    /* 7D3B8 8008CBB8 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008CBBC:
    /* 7D3BC 8008CBBC 03120200 */  sra        $v0, $v0, 8
    /* 7D3C0 8008CBC0 18004201 */  mult       $t2, $v0
    /* 7D3C4 8008CBC4 1800A88F */  lw         $t0, 0x18($sp)
    /* 7D3C8 8008CBC8 00000000 */  nop
    /* 7D3CC 8008CBCC 21100001 */  addu       $v0, $t0, $zero
    /* 7D3D0 8008CBD0 12700000 */  mflo       $t6
    /* 7D3D4 8008CBD4 02000105 */  bgez       $t0, .L8008CBE0
    /* 7D3D8 8008CBD8 21388E00 */   addu      $a3, $a0, $t6
    /* 7D3DC 8008CBDC FF000225 */  addiu      $v0, $t0, 0xFF
  .L8008CBE0:
    /* 7D3E0 8008CBE0 B400438E */  lw         $v1, 0xB4($s2)
    /* 7D3E4 8008CBE4 00000000 */  nop
    /* 7D3E8 8008CBE8 02006104 */  bgez       $v1, .L8008CBF4
    /* 7D3EC 8008CBEC 034A0200 */   sra       $t1, $v0, 8
    /* 7D3F0 8008CBF0 FF006324 */  addiu      $v1, $v1, 0xFF
  .L8008CBF4:
    /* 7D3F4 8008CBF4 031A0300 */  sra        $v1, $v1, 8
    /* 7D3F8 8008CBF8 0000648E */  lw         $a0, 0x0($s3)
    /* 7D3FC 8008CBFC A000428E */  lw         $v0, 0xA0($s2)
    /* 7D400 8008CC00 18002301 */  mult       $t1, $v1
    /* 7D404 8008CC04 23308200 */  subu       $a2, $a0, $v0
    /* 7D408 8008CC08 4000A6AF */  sw         $a2, 0x40($sp)
    /* 7D40C 8008CC0C 0400638E */  lw         $v1, 0x4($s3)
    /* 7D410 8008CC10 A400428E */  lw         $v0, 0xA4($s2)
    /* 7D414 8008CC14 00000000 */  nop
    /* 7D418 8008CC18 23186200 */  subu       $v1, $v1, $v0
    /* 7D41C 8008CC1C 4400A3AF */  sw         $v1, 0x44($sp)
    /* 7D420 8008CC20 0800648E */  lw         $a0, 0x8($s3)
    /* 7D424 8008CC24 A800428E */  lw         $v0, 0xA8($s2)
    /* 7D428 8008CC28 00000000 */  nop
    /* 7D42C 8008CC2C 23208200 */  subu       $a0, $a0, $v0
    /* 7D430 8008CC30 4800A4AF */  sw         $a0, 0x48($sp)
    /* 7D434 8008CC34 12700000 */  mflo       $t6
    /* 7D438 8008CC38 02006104 */  bgez       $v1, .L8008CC44
    /* 7D43C 8008CC3C 21A0EE00 */   addu      $s4, $a3, $t6
    /* 7D440 8008CC40 FF006324 */  addiu      $v1, $v1, 0xFF
  .L8008CC44:
    /* 7D444 8008CC44 031A0300 */  sra        $v1, $v1, 8
    /* 7D448 8008CC48 18006900 */  mult       $v1, $t1
    /* 7D44C 8008CC4C 12180000 */  mflo       $v1
    /* 7D450 8008CC50 02008104 */  bgez       $a0, .L8008CC5C
    /* 7D454 8008CC54 21108000 */   addu      $v0, $a0, $zero
    /* 7D458 8008CC58 FF008224 */  addiu      $v0, $a0, 0xFF
  .L8008CC5C:
    /* 7D45C 8008CC5C 033A0200 */  sra        $a3, $v0, 8
    /* 7D460 8008CC60 1800EA00 */  mult       $a3, $t2
    /* 7D464 8008CC64 12700000 */  mflo       $t6
    /* 7D468 8008CC68 23186E00 */  subu       $v1, $v1, $t6
    /* 7D46C 8008CC6C 5000A3AF */  sw         $v1, 0x50($sp)
    /* 7D470 8008CC70 1000A58F */  lw         $a1, 0x10($sp)
    /* 7D474 8008CC74 00000000 */  nop
    /* 7D478 8008CC78 0200A104 */  bgez       $a1, .L8008CC84
    /* 7D47C 8008CC7C 2110A000 */   addu      $v0, $a1, $zero
    /* 7D480 8008CC80 FF00A224 */  addiu      $v0, $a1, 0xFF
  .L8008CC84:
    /* 7D484 8008CC84 03520200 */  sra        $t2, $v0, 8
    /* 7D488 8008CC88 1800EA00 */  mult       $a3, $t2
    /* 7D48C 8008CC8C 12100000 */  mflo       $v0
    /* 7D490 8008CC90 0200C104 */  bgez       $a2, .L8008CC9C
    /* 7D494 8008CC94 2120C000 */   addu      $a0, $a2, $zero
    /* 7D498 8008CC98 FF00C424 */  addiu      $a0, $a2, 0xFF
  .L8008CC9C:
    /* 7D49C 8008CC9C 033A0400 */  sra        $a3, $a0, 8
    /* 7D4A0 8008CCA0 1800E900 */  mult       $a3, $t1
    /* 7D4A4 8008CCA4 12700000 */  mflo       $t6
    /* 7D4A8 8008CCA8 23404E00 */  subu       $t0, $v0, $t6
    /* 7D4AC 8008CCAC 5400A8AF */  sw         $t0, 0x54($sp)
    /* 7D4B0 8008CCB0 1400A28F */  lw         $v0, 0x14($sp)
    /* 7D4B4 8008CCB4 00000000 */  nop
    /* 7D4B8 8008CCB8 02004104 */  bgez       $v0, .L8008CCC4
    /* 7D4BC 8008CCBC 00000000 */   nop
    /* 7D4C0 8008CCC0 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008CCC4:
    /* 7D4C4 8008CCC4 03120200 */  sra        $v0, $v0, 8
    /* 7D4C8 8008CCC8 1800E200 */  mult       $a3, $v0
    /* 7D4CC 8008CCCC 4400A48F */  lw         $a0, 0x44($sp)
    /* 7D4D0 8008CCD0 12300000 */  mflo       $a2
    /* 7D4D4 8008CCD4 03008104 */  bgez       $a0, .L8008CCE4
    /* 7D4D8 8008CCD8 03120400 */   sra       $v0, $a0, 8
    /* 7D4DC 8008CCDC FF008424 */  addiu      $a0, $a0, 0xFF
    /* 7D4E0 8008CCE0 03120400 */  sra        $v0, $a0, 8
  .L8008CCE4:
    /* 7D4E4 8008CCE4 18004A00 */  mult       $v0, $t2
    /* 7D4E8 8008CCE8 12700000 */  mflo       $t6
    /* 7D4EC 8008CCEC 2328CE00 */  subu       $a1, $a2, $t6
    /* 7D4F0 8008CCF0 5800A5AF */  sw         $a1, 0x58($sp)
    /* 7D4F4 8008CCF4 1401448E */  lw         $a0, 0x114($s2)
    /* 7D4F8 8008CCF8 00000000 */  nop
    /* 7D4FC 8008CCFC 02008104 */  bgez       $a0, .L8008CD08
    /* 7D500 8008CD00 21106000 */   addu      $v0, $v1, $zero
    /* 7D504 8008CD04 FF008424 */  addiu      $a0, $a0, 0xFF
  .L8008CD08:
    /* 7D508 8008CD08 02004104 */  bgez       $v0, .L8008CD14
    /* 7D50C 8008CD0C 03220400 */   sra       $a0, $a0, 8
    /* 7D510 8008CD10 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008CD14:
    /* 7D514 8008CD14 03120200 */  sra        $v0, $v0, 8
    /* 7D518 8008CD18 18008200 */  mult       $a0, $v0
    /* 7D51C 8008CD1C 1801438E */  lw         $v1, 0x118($s2)
    /* 7D520 8008CD20 12200000 */  mflo       $a0
    /* 7D524 8008CD24 02006104 */  bgez       $v1, .L8008CD30
    /* 7D528 8008CD28 21100001 */   addu      $v0, $t0, $zero
    /* 7D52C 8008CD2C FF006324 */  addiu      $v1, $v1, 0xFF
  .L8008CD30:
    /* 7D530 8008CD30 02004104 */  bgez       $v0, .L8008CD3C
    /* 7D534 8008CD34 031A0300 */   sra       $v1, $v1, 8
    /* 7D538 8008CD38 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008CD3C:
    /* 7D53C 8008CD3C 03120200 */  sra        $v0, $v0, 8
    /* 7D540 8008CD40 18006200 */  mult       $v1, $v0
    /* 7D544 8008CD44 1C01438E */  lw         $v1, 0x11C($s2)
    /* 7D548 8008CD48 12700000 */  mflo       $t6
    /* 7D54C 8008CD4C 02006104 */  bgez       $v1, .L8008CD58
    /* 7D550 8008CD50 21208E00 */   addu      $a0, $a0, $t6
    /* 7D554 8008CD54 FF006324 */  addiu      $v1, $v1, 0xFF
  .L8008CD58:
    /* 7D558 8008CD58 2110A000 */  addu       $v0, $a1, $zero
    /* 7D55C 8008CD5C 02004104 */  bgez       $v0, .L8008CD68
    /* 7D560 8008CD60 031A0300 */   sra       $v1, $v1, 8
    /* 7D564 8008CD64 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008CD68:
    /* 7D568 8008CD68 03120200 */  sra        $v0, $v0, 8
    /* 7D56C 8008CD6C 18006200 */  mult       $v1, $v0
    /* 7D570 8008CD70 BC00508E */  lw         $s0, 0xBC($s2)
    /* 7D574 8008CD74 12700000 */  mflo       $t6
    /* 7D578 8008CD78 02000106 */  bgez       $s0, .L8008CD84
    /* 7D57C 8008CD7C 21888E00 */   addu      $s1, $a0, $t6
    /* 7D580 8008CD80 03001026 */  addiu      $s0, $s0, 0x3
  .L8008CD84:
    /* 7D584 8008CD84 5000A427 */  addiu      $a0, $sp, 0x50
    /* 7D588 8008CD88 2276020C */  jal        Math_VectorLength2__FP8coorddef
    /* 7D58C 8008CD8C 83801000 */   sra       $s0, $s0, 2
    /* 7D590 8008CD90 2401458E */  lw         $a1, 0x124($s2)
    /* 7D594 8008CD94 21204000 */  addu       $a0, $v0, $zero
    /* 7D598 8008CD98 CA90030C */  jal        fixedmult
    /* 7D59C 8008CD9C 40280500 */   sll       $a1, $a1, 1
    /* 7D5A0 8008CDA0 21209102 */  addu       $a0, $s4, $s1
    /* 7D5A4 8008CDA4 23200400 */  negu       $a0, $a0
    /* 7D5A8 8008CDA8 C22F0200 */  srl        $a1, $v0, 31
    /* 7D5AC 8008CDAC 2128A200 */  addu       $a1, $a1, $v0
    /* 7D5B0 8008CDB0 43280500 */  sra        $a1, $a1, 1
    /* 7D5B4 8008CDB4 0191030C */  jal        rdiv
    /* 7D5B8 8008CDB8 21280502 */   addu      $a1, $s0, $a1
    /* 7D5BC 8008CDBC 21204000 */  addu       $a0, $v0, $zero
    /* 7D5C0 8008CDC0 CA90030C */  jal        fixedmult
    /* 7D5C4 8008CDC4 66660524 */   addiu     $a1, $zero, 0x6666
    /* 7D5C8 8008CDC8 02008106 */  bgez       $s4, .L8008CDD4
    /* 7D5CC 8008CDCC 21188002 */   addu      $v1, $s4, $zero
    /* 7D5D0 8008CDD0 23180300 */  negu       $v1, $v1
  .L8008CDD4:
    /* 7D5D4 8008CDD4 80180300 */  sll        $v1, $v1, 2
    /* 7D5D8 8008CDD8 900143AE */  sw         $v1, 0x190($s2)
    /* 7D5DC 8008CDDC C001438E */  lw         $v1, 0x1C0($s2)
    /* 7D5E0 8008CDE0 0300043C */  lui        $a0, (0x30000 >> 16)
    /* 7D5E4 8008CDE4 940140AE */  sw         $zero, 0x194($s2)
    /* 7D5E8 8008CDE8 25186400 */  or         $v1, $v1, $a0
    /* 7D5EC 8008CDEC 980143AE */  sw         $v1, 0x198($s2)
    /* 7D5F0 8008CDF0 00006F8E */  lw         $t7, 0x0($s3)
    /* 7D5F4 8008CDF4 0400788E */  lw         $t8, 0x4($s3)
    /* 7D5F8 8008CDF8 0800798E */  lw         $t9, 0x8($s3)
    /* 7D5FC 8008CDFC A0014FAE */  sw         $t7, 0x1A0($s2)
    /* 7D600 8008CE00 A40158AE */  sw         $t8, 0x1A4($s2)
    /* 7D604 8008CE04 A80159AE */  sw         $t9, 0x1A8($s2)
    /* 7D608 8008CE08 6000A38F */  lw         $v1, 0x60($sp)
    /* 7D60C 8008CE0C 00000000 */  nop
    /* 7D610 8008CE10 09006014 */  bnez       $v1, .L8008CE38
    /* 7D614 8008CE14 21984000 */   addu      $s3, $v0, $zero
    /* 7D618 8008CE18 6400A28F */  lw         $v0, 0x64($sp)
    /* 7D61C 8008CE1C 00000000 */  nop
    /* 7D620 8008CE20 05004014 */  bnez       $v0, .L8008CE38
    /* 7D624 8008CE24 00000000 */   nop
    /* 7D628 8008CE28 6800A28F */  lw         $v0, 0x68($sp)
    /* 7D62C 8008CE2C 00000000 */  nop
    /* 7D630 8008CE30 6E004010 */  beqz       $v0, .L8008CFEC
    /* 7D634 8008CE34 0900033C */   lui       $v1, (0x9FFFF >> 16)
  .L8008CE38:
    /* 7D638 8008CE38 6000AA8F */  lw         $t2, 0x60($sp)
    /* 7D63C 8008CE3C 00000000 */  nop
    /* 7D640 8008CE40 02004105 */  bgez       $t2, .L8008CE4C
    /* 7D644 8008CE44 21104001 */   addu      $v0, $t2, $zero
    /* 7D648 8008CE48 FF004225 */  addiu      $v0, $t2, 0xFF
  .L8008CE4C:
    /* 7D64C 8008CE4C 1000A88F */  lw         $t0, 0x10($sp)
    /* 7D650 8008CE50 03120200 */  sra        $v0, $v0, 8
    /* 7D654 8008CE54 02000105 */  bgez       $t0, .L8008CE60
    /* 7D658 8008CE58 21180001 */   addu      $v1, $t0, $zero
    /* 7D65C 8008CE5C FF000325 */  addiu      $v1, $t0, 0xFF
  .L8008CE60:
    /* 7D660 8008CE60 036A0300 */  sra        $t5, $v1, 8
    /* 7D664 8008CE64 18004D00 */  mult       $v0, $t5
    /* 7D668 8008CE68 6400A98F */  lw         $t1, 0x64($sp)
    /* 7D66C 8008CE6C 12300000 */  mflo       $a2
    /* 7D670 8008CE70 02002105 */  bgez       $t1, .L8008CE7C
    /* 7D674 8008CE74 21202001 */   addu      $a0, $t1, $zero
    /* 7D678 8008CE78 FF002425 */  addiu      $a0, $t1, 0xFF
  .L8008CE7C:
    /* 7D67C 8008CE7C 1400A58F */  lw         $a1, 0x14($sp)
    /* 7D680 8008CE80 031A0400 */  sra        $v1, $a0, 8
    /* 7D684 8008CE84 0200A104 */  bgez       $a1, .L8008CE90
    /* 7D688 8008CE88 2110A000 */   addu      $v0, $a1, $zero
    /* 7D68C 8008CE8C FF00A224 */  addiu      $v0, $a1, 0xFF
  .L8008CE90:
    /* 7D690 8008CE90 03620200 */  sra        $t4, $v0, 8
    /* 7D694 8008CE94 18006C00 */  mult       $v1, $t4
    /* 7D698 8008CE98 6800A78F */  lw         $a3, 0x68($sp)
    /* 7D69C 8008CE9C 00000000 */  nop
    /* 7D6A0 8008CEA0 2118E000 */  addu       $v1, $a3, $zero
    /* 7D6A4 8008CEA4 12700000 */  mflo       $t6
    /* 7D6A8 8008CEA8 0200E104 */  bgez       $a3, .L8008CEB4
    /* 7D6AC 8008CEAC 2120CE00 */   addu      $a0, $a2, $t6
    /* 7D6B0 8008CEB0 FF00E324 */  addiu      $v1, $a3, 0xFF
  .L8008CEB4:
    /* 7D6B4 8008CEB4 1800A68F */  lw         $a2, 0x18($sp)
    /* 7D6B8 8008CEB8 031A0300 */  sra        $v1, $v1, 8
    /* 7D6BC 8008CEBC 0200C104 */  bgez       $a2, .L8008CEC8
    /* 7D6C0 8008CEC0 2110C000 */   addu      $v0, $a2, $zero
    /* 7D6C4 8008CEC4 FF00C224 */  addiu      $v0, $a2, 0xFF
  .L8008CEC8:
    /* 7D6C8 8008CEC8 035A0200 */  sra        $t3, $v0, 8
    /* 7D6CC 8008CECC 18006B00 */  mult       $v1, $t3
    /* 7D6D0 8008CED0 12700000 */  mflo       $t6
    /* 7D6D4 8008CED4 21188E00 */  addu       $v1, $a0, $t6
    /* 7D6D8 8008CED8 02006104 */  bgez       $v1, .L8008CEE4
    /* 7D6DC 8008CEDC 21106000 */   addu      $v0, $v1, $zero
    /* 7D6E0 8008CEE0 FF006224 */  addiu      $v0, $v1, 0xFF
  .L8008CEE4:
    /* 7D6E4 8008CEE4 03220200 */  sra        $a0, $v0, 8
    /* 7D6E8 8008CEE8 18008D00 */  mult       $a0, $t5
    /* 7D6EC 8008CEEC 12700000 */  mflo       $t6
    /* 7D6F0 8008CEF0 23104E01 */  subu       $v0, $t2, $t6
    /* 7D6F4 8008CEF4 6000A2AF */  sw         $v0, 0x60($sp)
    /* 7D6F8 8008CEF8 18008C00 */  mult       $a0, $t4
    /* 7D6FC 8008CEFC 12700000 */  mflo       $t6
    /* 7D700 8008CF00 23282E01 */  subu       $a1, $t1, $t6
    /* 7D704 8008CF04 6400A5AF */  sw         $a1, 0x64($sp)
    /* 7D708 8008CF08 18008B00 */  mult       $a0, $t3
    /* 7D70C 8008CF0C 21184000 */  addu       $v1, $v0, $zero
    /* 7D710 8008CF10 12700000 */  mflo       $t6
    /* 7D714 8008CF14 2330EE00 */  subu       $a2, $a3, $t6
    /* 7D718 8008CF18 02004104 */  bgez       $v0, .L8008CF24
    /* 7D71C 8008CF1C 6800A6AF */   sw        $a2, 0x68($sp)
    /* 7D720 8008CF20 FF004324 */  addiu      $v1, $v0, 0xFF
  .L8008CF24:
    /* 7D724 8008CF24 031A0300 */  sra        $v1, $v1, 8
    /* 7D728 8008CF28 18006300 */  mult       $v1, $v1
    /* 7D72C 8008CF2C 12180000 */  mflo       $v1
    /* 7D730 8008CF30 0200A104 */  bgez       $a1, .L8008CF3C
    /* 7D734 8008CF34 2110A000 */   addu      $v0, $a1, $zero
    /* 7D738 8008CF38 FF00A224 */  addiu      $v0, $a1, 0xFF
  .L8008CF3C:
    /* 7D73C 8008CF3C 03120200 */  sra        $v0, $v0, 8
    /* 7D740 8008CF40 18004200 */  mult       $v0, $v0
    /* 7D744 8008CF44 2110C000 */  addu       $v0, $a2, $zero
    /* 7D748 8008CF48 12700000 */  mflo       $t6
    /* 7D74C 8008CF4C 0200C104 */  bgez       $a2, .L8008CF58
    /* 7D750 8008CF50 21206E00 */   addu      $a0, $v1, $t6
    /* 7D754 8008CF54 FF00C224 */  addiu      $v0, $a2, 0xFF
  .L8008CF58:
    /* 7D758 8008CF58 03120200 */  sra        $v0, $v0, 8
    /* 7D75C 8008CF5C 18004200 */  mult       $v0, $v0
    /* 7D760 8008CF60 12700000 */  mflo       $t6
    /* 7D764 8008CF64 2BAC030C */  jal        fixedsqrt
    /* 7D768 8008CF68 21208E00 */   addu      $a0, $a0, $t6
    /* 7D76C 8008CF6C 21A84000 */  addu       $s5, $v0, $zero
    /* 7D770 8008CF70 C2171500 */  srl        $v0, $s5, 31
    /* 7D774 8008CF74 2110A202 */  addu       $v0, $s5, $v0
    /* 7D778 8008CF78 43280200 */  sra        $a1, $v0, 1
    /* 7D77C 8008CF7C 0E00A010 */  beqz       $a1, .L8008CFB8
    /* 7D780 8008CF80 00000000 */   nop
    /* 7D784 8008CF84 0191030C */  jal        rdiv
    /* 7D788 8008CF88 00800434 */   ori       $a0, $zero, 0x8000
    /* 7D78C 8008CF8C 23800200 */  negu       $s0, $v0
    /* 7D790 8008CF90 6000A58F */  lw         $a1, 0x60($sp)
    /* 7D794 8008CF94 CA90030C */  jal        fixedmult
    /* 7D798 8008CF98 21200002 */   addu      $a0, $s0, $zero
    /* 7D79C 8008CF9C 6400A58F */  lw         $a1, 0x64($sp)
    /* 7D7A0 8008CFA0 21200002 */  addu       $a0, $s0, $zero
    /* 7D7A4 8008CFA4 CA90030C */  jal        fixedmult
    /* 7D7A8 8008CFA8 6000A2AF */   sw        $v0, 0x60($sp)
    /* 7D7AC 8008CFAC 6800A58F */  lw         $a1, 0x68($sp)
    /* 7D7B0 8008CFB0 F7330208 */  j          .L8008CFDC
    /* 7D7B4 8008CFB4 21200002 */   addu      $a0, $s0, $zero
  .L8008CFB8:
    /* 7D7B8 8008CFB8 6000A58F */  lw         $a1, 0x60($sp)
    /* 7D7BC 8008CFBC CA90030C */  jal        fixedmult
    /* 7D7C0 8008CFC0 FFFF043C */   lui       $a0, (0xFFFF0000 >> 16)
    /* 7D7C4 8008CFC4 6400A58F */  lw         $a1, 0x64($sp)
    /* 7D7C8 8008CFC8 FFFF043C */  lui        $a0, (0xFFFF0000 >> 16)
    /* 7D7CC 8008CFCC CA90030C */  jal        fixedmult
    /* 7D7D0 8008CFD0 6000A2AF */   sw        $v0, 0x60($sp)
    /* 7D7D4 8008CFD4 6800A58F */  lw         $a1, 0x68($sp)
    /* 7D7D8 8008CFD8 FFFF043C */  lui        $a0, (0xFFFF0000 >> 16)
  .L8008CFDC:
    /* 7D7DC 8008CFDC CA90030C */  jal        fixedmult
    /* 7D7E0 8008CFE0 6400A2AF */   sw        $v0, 0x64($sp)
    /* 7D7E4 8008CFE4 6800A2AF */  sw         $v0, 0x68($sp)
    /* 7D7E8 8008CFE8 0900033C */  lui        $v1, (0x9FFFF >> 16)
  .L8008CFEC:
    /* 7D7EC 8008CFEC C000428E */  lw         $v0, 0xC0($s2)
    /* 7D7F0 8008CFF0 FFFF6334 */  ori        $v1, $v1, (0x9FFFF & 0xFFFF)
    /* 7D7F4 8008CFF4 02004104 */  bgez       $v0, .L8008D000
    /* 7D7F8 8008CFF8 00000000 */   nop
    /* 7D7FC 8008CFFC 23100200 */  negu       $v0, $v0
  .L8008D000:
    /* 7D800 8008D000 2A186200 */  slt        $v1, $v1, $v0
    /* 7D804 8008D004 7F006014 */  bnez       $v1, .L8008D204
    /* 7D808 8008D008 0580023C */   lui       $v0, %hi(D_80055A00)
    /* 7D80C 8008D00C 005A4E24 */  addiu      $t6, $v0, %lo(D_80055A00)
    /* 7D810 8008D010 0000CF8D */  lw         $t7, 0x0($t6)
    /* 7D814 8008D014 0400D88D */  lw         $t8, 0x4($t6)
    /* 7D818 8008D018 0800D98D */  lw         $t9, 0x8($t6)
    /* 7D81C 8008D01C 9000AFAF */  sw         $t7, 0x90($sp)
    /* 7D820 8008D020 9400B8AF */  sw         $t8, 0x94($sp)
    /* 7D824 8008D024 9800B9AF */  sw         $t9, 0x98($sp)
    /* 7D828 8008D028 9000A68F */  lw         $a2, 0x90($sp)
    /* 7D82C 8008D02C 00000000 */  nop
    /* 7D830 8008D030 0200C104 */  bgez       $a2, .L8008D03C
    /* 7D834 8008D034 2118C000 */   addu      $v1, $a2, $zero
    /* 7D838 8008D038 FF00C324 */  addiu      $v1, $a2, 0xFF
  .L8008D03C:
    /* 7D83C 8008D03C F000428E */  lw         $v0, 0xF0($s2)
    /* 7D840 8008D040 00000000 */  nop
    /* 7D844 8008D044 02004104 */  bgez       $v0, .L8008D050
    /* 7D848 8008D048 03520300 */   sra       $t2, $v1, 8
    /* 7D84C 8008D04C FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008D050:
    /* 7D850 8008D050 03120200 */  sra        $v0, $v0, 8
    /* 7D854 8008D054 18004201 */  mult       $t2, $v0
    /* 7D858 8008D058 9400A58F */  lw         $a1, 0x94($sp)
    /* 7D85C 8008D05C 12380000 */  mflo       $a3
    /* 7D860 8008D060 0200A104 */  bgez       $a1, .L8008D06C
    /* 7D864 8008D064 2118A000 */   addu      $v1, $a1, $zero
    /* 7D868 8008D068 FF00A324 */  addiu      $v1, $a1, 0xFF
  .L8008D06C:
    /* 7D86C 8008D06C F400428E */  lw         $v0, 0xF4($s2)
    /* 7D870 8008D070 00000000 */  nop
    /* 7D874 8008D074 02004104 */  bgez       $v0, .L8008D080
    /* 7D878 8008D078 034A0300 */   sra       $t1, $v1, 8
    /* 7D87C 8008D07C FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008D080:
    /* 7D880 8008D080 03120200 */  sra        $v0, $v0, 8
    /* 7D884 8008D084 18002201 */  mult       $t1, $v0
    /* 7D888 8008D088 9800A48F */  lw         $a0, 0x98($sp)
    /* 7D88C 8008D08C 00000000 */  nop
    /* 7D890 8008D090 21188000 */  addu       $v1, $a0, $zero
    /* 7D894 8008D094 12700000 */  mflo       $t6
    /* 7D898 8008D098 02008104 */  bgez       $a0, .L8008D0A4
    /* 7D89C 8008D09C 2138EE00 */   addu      $a3, $a3, $t6
    /* 7D8A0 8008D0A0 FF008324 */  addiu      $v1, $a0, 0xFF
  .L8008D0A4:
    /* 7D8A4 8008D0A4 F800428E */  lw         $v0, 0xF8($s2)
    /* 7D8A8 8008D0A8 00000000 */  nop
    /* 7D8AC 8008D0AC 02004104 */  bgez       $v0, .L8008D0B8
    /* 7D8B0 8008D0B0 03420300 */   sra       $t0, $v1, 8
    /* 7D8B4 8008D0B4 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008D0B8:
    /* 7D8B8 8008D0B8 03120200 */  sra        $v0, $v0, 8
    /* 7D8BC 8008D0BC 18000201 */  mult       $t0, $v0
    /* 7D8C0 8008D0C0 12700000 */  mflo       $t6
    /* 7D8C4 8008D0C4 FC00428E */  lw         $v0, 0xFC($s2)
    /* 7D8C8 8008D0C8 00000000 */  nop
    /* 7D8CC 8008D0CC 02004104 */  bgez       $v0, .L8008D0D8
    /* 7D8D0 8008D0D0 2138EE00 */   addu      $a3, $a3, $t6
    /* 7D8D4 8008D0D4 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008D0D8:
    /* 7D8D8 8008D0D8 03120200 */  sra        $v0, $v0, 8
    /* 7D8DC 8008D0DC 18004201 */  mult       $t2, $v0
    /* 7D8E0 8008D0E0 12180000 */  mflo       $v1
    /* 7D8E4 8008D0E4 0001428E */  lw         $v0, 0x100($s2)
    /* 7D8E8 8008D0E8 00000000 */  nop
    /* 7D8EC 8008D0EC 02004104 */  bgez       $v0, .L8008D0F8
    /* 7D8F0 8008D0F0 00000000 */   nop
    /* 7D8F4 8008D0F4 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008D0F8:
    /* 7D8F8 8008D0F8 03120200 */  sra        $v0, $v0, 8
    /* 7D8FC 8008D0FC 18002201 */  mult       $t1, $v0
    /* 7D900 8008D100 12700000 */  mflo       $t6
    /* 7D904 8008D104 0401428E */  lw         $v0, 0x104($s2)
    /* 7D908 8008D108 00000000 */  nop
    /* 7D90C 8008D10C 02004104 */  bgez       $v0, .L8008D118
    /* 7D910 8008D110 21286E00 */   addu      $a1, $v1, $t6
    /* 7D914 8008D114 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008D118:
    /* 7D918 8008D118 03120200 */  sra        $v0, $v0, 8
    /* 7D91C 8008D11C 18000201 */  mult       $t0, $v0
    /* 7D920 8008D120 9000A38F */  lw         $v1, 0x90($sp)
    /* 7D924 8008D124 12700000 */  mflo       $t6
    /* 7D928 8008D128 02006104 */  bgez       $v1, .L8008D134
    /* 7D92C 8008D12C 2128AE00 */   addu      $a1, $a1, $t6
    /* 7D930 8008D130 FF006324 */  addiu      $v1, $v1, 0xFF
  .L8008D134:
    /* 7D934 8008D134 0801428E */  lw         $v0, 0x108($s2)
    /* 7D938 8008D138 00000000 */  nop
    /* 7D93C 8008D13C 02004104 */  bgez       $v0, .L8008D148
    /* 7D940 8008D140 03220300 */   sra       $a0, $v1, 8
    /* 7D944 8008D144 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008D148:
    /* 7D948 8008D148 03120200 */  sra        $v0, $v0, 8
    /* 7D94C 8008D14C 18008200 */  mult       $a0, $v0
    /* 7D950 8008D150 9400A38F */  lw         $v1, 0x94($sp)
    /* 7D954 8008D154 12200000 */  mflo       $a0
    /* 7D958 8008D158 02006104 */  bgez       $v1, .L8008D164
    /* 7D95C 8008D15C 00000000 */   nop
    /* 7D960 8008D160 FF006324 */  addiu      $v1, $v1, 0xFF
  .L8008D164:
    /* 7D964 8008D164 0C01428E */  lw         $v0, 0x10C($s2)
    /* 7D968 8008D168 00000000 */  nop
    /* 7D96C 8008D16C 02004104 */  bgez       $v0, .L8008D178
    /* 7D970 8008D170 031A0300 */   sra       $v1, $v1, 8
    /* 7D974 8008D174 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008D178:
    /* 7D978 8008D178 03120200 */  sra        $v0, $v0, 8
    /* 7D97C 8008D17C 18006200 */  mult       $v1, $v0
    /* 7D980 8008D180 9800A38F */  lw         $v1, 0x98($sp)
    /* 7D984 8008D184 12700000 */  mflo       $t6
    /* 7D988 8008D188 02006104 */  bgez       $v1, .L8008D194
    /* 7D98C 8008D18C 21208E00 */   addu      $a0, $a0, $t6
    /* 7D990 8008D190 FF006324 */  addiu      $v1, $v1, 0xFF
  .L8008D194:
    /* 7D994 8008D194 1001428E */  lw         $v0, 0x110($s2)
    /* 7D998 8008D198 00000000 */  nop
    /* 7D99C 8008D19C 02004104 */  bgez       $v0, .L8008D1A8
    /* 7D9A0 8008D1A0 031A0300 */   sra       $v1, $v1, 8
    /* 7D9A4 8008D1A4 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008D1A8:
    /* 7D9A8 8008D1A8 03120200 */  sra        $v0, $v0, 8
    /* 7D9AC 8008D1AC 18006200 */  mult       $v1, $v0
    /* 7D9B0 8008D1B0 0200E104 */  bgez       $a3, .L8008D1BC
    /* 7D9B4 8008D1B4 2110E000 */   addu      $v0, $a3, $zero
    /* 7D9B8 8008D1B8 23100200 */  negu       $v0, $v0
  .L8008D1BC:
    /* 7D9BC 8008D1BC 12700000 */  mflo       $t6
    /* 7D9C0 8008D1C0 21188E00 */  addu       $v1, $a0, $t6
    /* 7D9C4 8008D1C4 C2F50434 */  ori        $a0, $zero, 0xF5C2
    /* 7D9C8 8008D1C8 2A108200 */  slt        $v0, $a0, $v0
    /* 7D9CC 8008D1CC 0C004014 */  bnez       $v0, .L8008D200
    /* 7D9D0 8008D1D0 01000224 */   addiu     $v0, $zero, 0x1
    /* 7D9D4 8008D1D4 02006104 */  bgez       $v1, .L8008D1E0
    /* 7D9D8 8008D1D8 21106000 */   addu      $v0, $v1, $zero
    /* 7D9DC 8008D1DC 23100200 */  negu       $v0, $v0
  .L8008D1E0:
    /* 7D9E0 8008D1E0 2A108200 */  slt        $v0, $a0, $v0
    /* 7D9E4 8008D1E4 06004014 */  bnez       $v0, .L8008D200
    /* 7D9E8 8008D1E8 01000224 */   addiu     $v0, $zero, 0x1
    /* 7D9EC 8008D1EC FFFF023C */  lui        $v0, (0xFFFF0A3E >> 16)
    /* 7D9F0 8008D1F0 3E0A4234 */  ori        $v0, $v0, (0xFFFF0A3E & 0xFFFF)
    /* 7D9F4 8008D1F4 2A10A200 */  slt        $v0, $a1, $v0
    /* 7D9F8 8008D1F8 02004010 */  beqz       $v0, .L8008D204
    /* 7D9FC 8008D1FC 01000224 */   addiu     $v0, $zero, 0x1
  .L8008D200:
    /* 7DA00 8008D200 E40282AF */  sw         $v0, %gp_rel(frictionLess)($gp)
  .L8008D204:
    /* 7DA04 8008D204 E402838F */  lw         $v1, %gp_rel(frictionLess)($gp)
    /* 7DA08 8008D208 01000224 */  addiu      $v0, $zero, 0x1
    /* 7DA0C 8008D20C 02006214 */  bne        $v1, $v0, .L8008D218
    /* 7DA10 8008D210 00800434 */   ori       $a0, $zero, 0x8000
    /* 7DA14 8008D214 8F020424 */  addiu      $a0, $zero, 0x28F
  .L8008D218:
    /* 7DA18 8008D218 CA90030C */  jal        fixedmult
    /* 7DA1C 8008D21C 21286002 */   addu      $a1, $s3, $zero
    /* 7DA20 8008D220 21804000 */  addu       $s0, $v0, $zero
    /* 7DA24 8008D224 BC00458E */  lw         $a1, 0xBC($s2)
    /* 7DA28 8008D228 21200002 */  addu       $a0, $s0, $zero
    /* 7DA2C 8008D22C C2170500 */  srl        $v0, $a1, 31
    /* 7DA30 8008D230 2128A200 */  addu       $a1, $a1, $v0
    /* 7DA34 8008D234 CA90030C */  jal        fixedmult
    /* 7DA38 8008D238 43280500 */   sra       $a1, $a1, 1
    /* 7DA3C 8008D23C 6000A58F */  lw         $a1, 0x60($sp)
    /* 7DA40 8008D240 CA90030C */  jal        fixedmult
    /* 7DA44 8008D244 21204000 */   addu      $a0, $v0, $zero
    /* 7DA48 8008D248 7000A2AF */  sw         $v0, 0x70($sp)
    /* 7DA4C 8008D24C BC00458E */  lw         $a1, 0xBC($s2)
    /* 7DA50 8008D250 21200002 */  addu       $a0, $s0, $zero
    /* 7DA54 8008D254 C2170500 */  srl        $v0, $a1, 31
    /* 7DA58 8008D258 2128A200 */  addu       $a1, $a1, $v0
    /* 7DA5C 8008D25C CA90030C */  jal        fixedmult
    /* 7DA60 8008D260 43280500 */   sra       $a1, $a1, 1
    /* 7DA64 8008D264 6400A58F */  lw         $a1, 0x64($sp)
    /* 7DA68 8008D268 CA90030C */  jal        fixedmult
    /* 7DA6C 8008D26C 21204000 */   addu      $a0, $v0, $zero
    /* 7DA70 8008D270 7400A2AF */  sw         $v0, 0x74($sp)
    /* 7DA74 8008D274 BC00458E */  lw         $a1, 0xBC($s2)
    /* 7DA78 8008D278 21200002 */  addu       $a0, $s0, $zero
    /* 7DA7C 8008D27C C2170500 */  srl        $v0, $a1, 31
    /* 7DA80 8008D280 2128A200 */  addu       $a1, $a1, $v0
    /* 7DA84 8008D284 CA90030C */  jal        fixedmult
    /* 7DA88 8008D288 43280500 */   sra       $a1, $a1, 1
    /* 7DA8C 8008D28C 6800A58F */  lw         $a1, 0x68($sp)
    /* 7DA90 8008D290 CA90030C */  jal        fixedmult
    /* 7DA94 8008D294 21204000 */   addu      $a0, $v0, $zero
    /* 7DA98 8008D298 7800A2AF */  sw         $v0, 0x78($sp)
    /* 7DA9C 8008D29C 2401458E */  lw         $a1, 0x124($s2)
    /* 7DAA0 8008D2A0 21200002 */  addu       $a0, $s0, $zero
    /* 7DAA4 8008D2A4 E40280AF */  sw         $zero, %gp_rel(frictionLess)($gp)
    /* 7DAA8 8008D2A8 CA90030C */  jal        fixedmult
    /* 7DAAC 8008D2AC 40280500 */   sll       $a1, $a1, 1
    /* 7DAB0 8008D2B0 6400A38F */  lw         $v1, 0x64($sp)
    /* 7DAB4 8008D2B4 00000000 */  nop
    /* 7DAB8 8008D2B8 02006104 */  bgez       $v1, .L8008D2C4
    /* 7DABC 8008D2BC 21884000 */   addu      $s1, $v0, $zero
    /* 7DAC0 8008D2C0 FF006324 */  addiu      $v1, $v1, 0xFF
  .L8008D2C4:
    /* 7DAC4 8008D2C4 4800A78F */  lw         $a3, 0x48($sp)
    /* 7DAC8 8008D2C8 03120300 */  sra        $v0, $v1, 8
    /* 7DACC 8008D2CC 0200E104 */  bgez       $a3, .L8008D2D8
    /* 7DAD0 8008D2D0 2120E000 */   addu      $a0, $a3, $zero
    /* 7DAD4 8008D2D4 FF00E424 */  addiu      $a0, $a3, 0xFF
  .L8008D2D8:
    /* 7DAD8 8008D2D8 035A0400 */  sra        $t3, $a0, 8
    /* 7DADC 8008D2DC 18004B00 */  mult       $v0, $t3
    /* 7DAE0 8008D2E0 6800A38F */  lw         $v1, 0x68($sp)
    /* 7DAE4 8008D2E4 12200000 */  mflo       $a0
    /* 7DAE8 8008D2E8 02006104 */  bgez       $v1, .L8008D2F4
    /* 7DAEC 8008D2EC 21286000 */   addu      $a1, $v1, $zero
    /* 7DAF0 8008D2F0 FF006524 */  addiu      $a1, $v1, 0xFF
  .L8008D2F4:
    /* 7DAF4 8008D2F4 4400A68F */  lw         $a2, 0x44($sp)
    /* 7DAF8 8008D2F8 03420500 */  sra        $t0, $a1, 8
    /* 7DAFC 8008D2FC 0200C104 */  bgez       $a2, .L8008D308
    /* 7DB00 8008D300 2110C000 */   addu      $v0, $a2, $zero
    /* 7DB04 8008D304 FF00C224 */  addiu      $v0, $a2, 0xFF
  .L8008D308:
    /* 7DB08 8008D308 03520200 */  sra        $t2, $v0, 8
    /* 7DB0C 8008D30C 18000A01 */  mult       $t0, $t2
    /* 7DB10 8008D310 12700000 */  mflo       $t6
    /* 7DB14 8008D314 23108E00 */  subu       $v0, $a0, $t6
    /* 7DB18 8008D318 8000A2AF */  sw         $v0, 0x80($sp)
    /* 7DB1C 8008D31C 4000A58F */  lw         $a1, 0x40($sp)
    /* 7DB20 8008D320 00000000 */  nop
    /* 7DB24 8008D324 0200A104 */  bgez       $a1, .L8008D330
    /* 7DB28 8008D328 2118A000 */   addu      $v1, $a1, $zero
    /* 7DB2C 8008D32C FF00A324 */  addiu      $v1, $a1, 0xFF
  .L8008D330:
    /* 7DB30 8008D330 034A0300 */  sra        $t1, $v1, 8
    /* 7DB34 8008D334 18000901 */  mult       $t0, $t1
    /* 7DB38 8008D338 6000A28F */  lw         $v0, 0x60($sp)
    /* 7DB3C 8008D33C 12400000 */  mflo       $t0
    /* 7DB40 8008D340 02004104 */  bgez       $v0, .L8008D34C
    /* 7DB44 8008D344 21204000 */   addu      $a0, $v0, $zero
    /* 7DB48 8008D348 FF004424 */  addiu      $a0, $v0, 0xFF
  .L8008D34C:
    /* 7DB4C 8008D34C 031A0400 */  sra        $v1, $a0, 8
    /* 7DB50 8008D350 18006B00 */  mult       $v1, $t3
    /* 7DB54 8008D354 12700000 */  mflo       $t6
    /* 7DB58 8008D358 23200E01 */  subu       $a0, $t0, $t6
    /* 7DB5C 8008D35C 8400A4AF */  sw         $a0, 0x84($sp)
    /* 7DB60 8008D360 18006A00 */  mult       $v1, $t2
    /* 7DB64 8008D364 6400A28F */  lw         $v0, 0x64($sp)
    /* 7DB68 8008D368 12180000 */  mflo       $v1
    /* 7DB6C 8008D36C 02004104 */  bgez       $v0, .L8008D378
    /* 7DB70 8008D370 00000000 */   nop
    /* 7DB74 8008D374 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008D378:
    /* 7DB78 8008D378 03120200 */  sra        $v0, $v0, 8
    /* 7DB7C 8008D37C 18004900 */  mult       $v0, $t1
    /* 7DB80 8008D380 21108000 */  addu       $v0, $a0, $zero
    /* 7DB84 8008D384 12700000 */  mflo       $t6
    /* 7DB88 8008D388 23186E00 */  subu       $v1, $v1, $t6
    /* 7DB8C 8008D38C 02004104 */  bgez       $v0, .L8008D398
    /* 7DB90 8008D390 8800A3AF */   sw        $v1, 0x88($sp)
    /* 7DB94 8008D394 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008D398:
    /* 7DB98 8008D398 4800A88F */  lw         $t0, 0x48($sp)
    /* 7DB9C 8008D39C 03120200 */  sra        $v0, $v0, 8
    /* 7DBA0 8008D3A0 02000105 */  bgez       $t0, .L8008D3AC
    /* 7DBA4 8008D3A4 21200001 */   addu      $a0, $t0, $zero
    /* 7DBA8 8008D3A8 FF000425 */  addiu      $a0, $t0, 0xFF
  .L8008D3AC:
    /* 7DBAC 8008D3AC 03620400 */  sra        $t4, $a0, 8
    /* 7DBB0 8008D3B0 18004C00 */  mult       $v0, $t4
    /* 7DBB4 8008D3B4 12200000 */  mflo       $a0
    /* 7DBB8 8008D3B8 02006104 */  bgez       $v1, .L8008D3C4
    /* 7DBBC 8008D3BC 21286000 */   addu      $a1, $v1, $zero
    /* 7DBC0 8008D3C0 FF006524 */  addiu      $a1, $v1, 0xFF
  .L8008D3C4:
    /* 7DBC4 8008D3C4 4400A78F */  lw         $a3, 0x44($sp)
    /* 7DBC8 8008D3C8 034A0500 */  sra        $t1, $a1, 8
    /* 7DBCC 8008D3CC 0200E104 */  bgez       $a3, .L8008D3D8
    /* 7DBD0 8008D3D0 2110E000 */   addu      $v0, $a3, $zero
    /* 7DBD4 8008D3D4 FF00E224 */  addiu      $v0, $a3, 0xFF
  .L8008D3D8:
    /* 7DBD8 8008D3D8 035A0200 */  sra        $t3, $v0, 8
    /* 7DBDC 8008D3DC 18002B01 */  mult       $t1, $t3
    /* 7DBE0 8008D3E0 12700000 */  mflo       $t6
    /* 7DBE4 8008D3E4 23288E00 */  subu       $a1, $a0, $t6
    /* 7DBE8 8008D3E8 8000A5AF */  sw         $a1, 0x80($sp)
    /* 7DBEC 8008D3EC 4000A68F */  lw         $a2, 0x40($sp)
    /* 7DBF0 8008D3F0 00000000 */  nop
    /* 7DBF4 8008D3F4 0200C104 */  bgez       $a2, .L8008D400
    /* 7DBF8 8008D3F8 2118C000 */   addu      $v1, $a2, $zero
    /* 7DBFC 8008D3FC FF00C324 */  addiu      $v1, $a2, 0xFF
  .L8008D400:
    /* 7DC00 8008D400 03520300 */  sra        $t2, $v1, 8
    /* 7DC04 8008D404 18002A01 */  mult       $t1, $t2
    /* 7DC08 8008D408 12180000 */  mflo       $v1
    /* 7DC0C 8008D40C 0200A104 */  bgez       $a1, .L8008D418
    /* 7DC10 8008D410 2120A000 */   addu      $a0, $a1, $zero
    /* 7DC14 8008D414 FF00A424 */  addiu      $a0, $a1, 0xFF
  .L8008D418:
    /* 7DC18 8008D418 03120400 */  sra        $v0, $a0, 8
    /* 7DC1C 8008D41C 18004C00 */  mult       $v0, $t4
    /* 7DC20 8008D420 12700000 */  mflo       $t6
    /* 7DC24 8008D424 23186E00 */  subu       $v1, $v1, $t6
    /* 7DC28 8008D428 00000000 */  nop
    /* 7DC2C 8008D42C 18004B00 */  mult       $v0, $t3
    /* 7DC30 8008D430 12380000 */  mflo       $a3
    /* 7DC34 8008D434 02006104 */  bgez       $v1, .L8008D440
    /* 7DC38 8008D438 8400A3AF */   sw        $v1, 0x84($sp)
    /* 7DC3C 8008D43C FF006324 */  addiu      $v1, $v1, 0xFF
  .L8008D440:
    /* 7DC40 8008D440 03120300 */  sra        $v0, $v1, 8
    /* 7DC44 8008D444 18004A00 */  mult       $v0, $t2
    /* 7DC48 8008D448 21202002 */  addu       $a0, $s1, $zero
    /* 7DC4C 8008D44C 12700000 */  mflo       $t6
    /* 7DC50 8008D450 2310EE00 */  subu       $v0, $a3, $t6
    /* 7DC54 8008D454 CA90030C */  jal        fixedmult
    /* 7DC58 8008D458 8800A2AF */   sw        $v0, 0x88($sp)
    /* 7DC5C 8008D45C 8400A58F */  lw         $a1, 0x84($sp)
    /* 7DC60 8008D460 21202002 */  addu       $a0, $s1, $zero
    /* 7DC64 8008D464 CA90030C */  jal        fixedmult
    /* 7DC68 8008D468 8000A2AF */   sw        $v0, 0x80($sp)
    /* 7DC6C 8008D46C 8800A58F */  lw         $a1, 0x88($sp)
    /* 7DC70 8008D470 21202002 */  addu       $a0, $s1, $zero
    /* 7DC74 8008D474 CA90030C */  jal        fixedmult
    /* 7DC78 8008D478 8400A2AF */   sw        $v0, 0x84($sp)
    /* 7DC7C 8008D47C 7000A38F */  lw         $v1, 0x70($sp)
    /* 7DC80 8008D480 8000A48F */  lw         $a0, 0x80($sp)
    /* 7DC84 8008D484 7800A58F */  lw         $a1, 0x78($sp)
    /* 7DC88 8008D488 8800A2AF */  sw         $v0, 0x88($sp)
    /* 7DC8C 8008D48C 21186400 */  addu       $v1, $v1, $a0
    /* 7DC90 8008D490 21306000 */  addu       $a2, $v1, $zero
    /* 7DC94 8008D494 7400A48F */  lw         $a0, 0x74($sp)
    /* 7DC98 8008D498 8400A38F */  lw         $v1, 0x84($sp)
    /* 7DC9C 8008D49C 2128A200 */  addu       $a1, $a1, $v0
    /* 7DCA0 8008D4A0 7000A6AF */  sw         $a2, 0x70($sp)
    /* 7DCA4 8008D4A4 7800A5AF */  sw         $a1, 0x78($sp)
    /* 7DCA8 8008D4A8 21208300 */  addu       $a0, $a0, $v1
    /* 7DCAC 8008D4AC 0200C104 */  bgez       $a2, .L8008D4B8
    /* 7DCB0 8008D4B0 7400A4AF */   sw        $a0, 0x74($sp)
    /* 7DCB4 8008D4B4 FF00C624 */  addiu      $a2, $a2, 0xFF
  .L8008D4B8:
    /* 7DCB8 8008D4B8 6000A28F */  lw         $v0, 0x60($sp)
    /* 7DCBC 8008D4BC 00000000 */  nop
    /* 7DCC0 8008D4C0 02004104 */  bgez       $v0, .L8008D4CC
    /* 7DCC4 8008D4C4 031A0600 */   sra       $v1, $a2, 8
    /* 7DCC8 8008D4C8 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008D4CC:
    /* 7DCCC 8008D4CC 03120200 */  sra        $v0, $v0, 8
    /* 7DCD0 8008D4D0 18006200 */  mult       $v1, $v0
    /* 7DCD4 8008D4D4 12180000 */  mflo       $v1
    /* 7DCD8 8008D4D8 02008104 */  bgez       $a0, .L8008D4E4
    /* 7DCDC 8008D4DC 00000000 */   nop
    /* 7DCE0 8008D4E0 FF008424 */  addiu      $a0, $a0, 0xFF
  .L8008D4E4:
    /* 7DCE4 8008D4E4 6400A28F */  lw         $v0, 0x64($sp)
    /* 7DCE8 8008D4E8 00000000 */  nop
    /* 7DCEC 8008D4EC 02004104 */  bgez       $v0, .L8008D4F8
    /* 7DCF0 8008D4F0 03220400 */   sra       $a0, $a0, 8
    /* 7DCF4 8008D4F4 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008D4F8:
    /* 7DCF8 8008D4F8 03120200 */  sra        $v0, $v0, 8
    /* 7DCFC 8008D4FC 18008200 */  mult       $a0, $v0
    /* 7DD00 8008D500 12700000 */  mflo       $t6
    /* 7DD04 8008D504 0200A104 */  bgez       $a1, .L8008D510
    /* 7DD08 8008D508 21186E00 */   addu      $v1, $v1, $t6
    /* 7DD0C 8008D50C FF00A524 */  addiu      $a1, $a1, 0xFF
  .L8008D510:
    /* 7DD10 8008D510 6800A28F */  lw         $v0, 0x68($sp)
    /* 7DD14 8008D514 00000000 */  nop
    /* 7DD18 8008D518 02004104 */  bgez       $v0, .L8008D524
    /* 7DD1C 8008D51C 032A0500 */   sra       $a1, $a1, 8
    /* 7DD20 8008D520 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008D524:
    /* 7DD24 8008D524 03120200 */  sra        $v0, $v0, 8
    /* 7DD28 8008D528 1800A200 */  mult       $a1, $v0
    /* 7DD2C 8008D52C 12700000 */  mflo       $t6
    /* 7DD30 8008D530 21286E00 */  addu       $a1, $v1, $t6
    /* 7DD34 8008D534 2A10A502 */  slt        $v0, $s5, $a1
    /* 7DD38 8008D538 07004010 */  beqz       $v0, .L8008D558
    /* 7DD3C 8008D53C 00000000 */   nop
    /* 7DD40 8008D540 0191030C */  jal        rdiv
    /* 7DD44 8008D544 2120A002 */   addu      $a0, $s5, $zero
    /* 7DD48 8008D548 21200002 */  addu       $a0, $s0, $zero
    /* 7DD4C 8008D54C CA90030C */  jal        fixedmult
    /* 7DD50 8008D550 21284000 */   addu      $a1, $v0, $zero
    /* 7DD54 8008D554 21804000 */  addu       $s0, $v0, $zero
  .L8008D558:
    /* 7DD58 8008D558 6000A58F */  lw         $a1, 0x60($sp)
    /* 7DD5C 8008D55C CA90030C */  jal        fixedmult
    /* 7DD60 8008D560 21200002 */   addu      $a0, $s0, $zero
    /* 7DD64 8008D564 6400A58F */  lw         $a1, 0x64($sp)
    /* 7DD68 8008D568 21200002 */  addu       $a0, $s0, $zero
    /* 7DD6C 8008D56C CA90030C */  jal        fixedmult
    /* 7DD70 8008D570 6000A2AF */   sw        $v0, 0x60($sp)
    /* 7DD74 8008D574 6800A58F */  lw         $a1, 0x68($sp)
    /* 7DD78 8008D578 21200002 */  addu       $a0, $s0, $zero
    /* 7DD7C 8008D57C CA90030C */  jal        fixedmult
    /* 7DD80 8008D580 6400A2AF */   sw        $v0, 0x64($sp)
    /* 7DD84 8008D584 C200601A */  blez       $s3, .L8008D890
    /* 7DD88 8008D588 6800A2AF */   sw        $v0, 0x68($sp)
    /* 7DD8C 8008D58C 1000A58F */  lw         $a1, 0x10($sp)
    /* 7DD90 8008D590 CA90030C */  jal        fixedmult
    /* 7DD94 8008D594 21206002 */   addu      $a0, $s3, $zero
    /* 7DD98 8008D598 1400A58F */  lw         $a1, 0x14($sp)
    /* 7DD9C 8008D59C 21206002 */  addu       $a0, $s3, $zero
    /* 7DDA0 8008D5A0 CA90030C */  jal        fixedmult
    /* 7DDA4 8008D5A4 3000A2AF */   sw        $v0, 0x30($sp)
    /* 7DDA8 8008D5A8 1800A58F */  lw         $a1, 0x18($sp)
    /* 7DDAC 8008D5AC 21206002 */  addu       $a0, $s3, $zero
    /* 7DDB0 8008D5B0 CA90030C */  jal        fixedmult
    /* 7DDB4 8008D5B4 3400A2AF */   sw        $v0, 0x34($sp)
    /* 7DDB8 8008D5B8 3000A58F */  lw         $a1, 0x30($sp)
    /* 7DDBC 8008D5BC 6000A38F */  lw         $v1, 0x60($sp)
    /* 7DDC0 8008D5C0 6400A48F */  lw         $a0, 0x64($sp)
    /* 7DDC4 8008D5C4 6800A68F */  lw         $a2, 0x68($sp)
    /* 7DDC8 8008D5C8 3800A2AF */  sw         $v0, 0x38($sp)
    /* 7DDCC 8008D5CC 2128A300 */  addu       $a1, $a1, $v1
    /* 7DDD0 8008D5D0 3400A38F */  lw         $v1, 0x34($sp)
    /* 7DDD4 8008D5D4 21104600 */  addu       $v0, $v0, $a2
    /* 7DDD8 8008D5D8 3000A5AF */  sw         $a1, 0x30($sp)
    /* 7DDDC 8008D5DC 3800A2AF */  sw         $v0, 0x38($sp)
    /* 7DDE0 8008D5E0 21186400 */  addu       $v1, $v1, $a0
    /* 7DDE4 8008D5E4 3400A3AF */  sw         $v1, 0x34($sp)
    /* 7DDE8 8008D5E8 BC00448E */  lw         $a0, 0xBC($s2)
    /* 7DDEC 8008D5EC 00000000 */  nop
    /* 7DDF0 8008D5F0 C2170400 */  srl        $v0, $a0, 31
    /* 7DDF4 8008D5F4 21208200 */  addu       $a0, $a0, $v0
    /* 7DDF8 8008D5F8 CA90030C */  jal        fixedmult
    /* 7DDFC 8008D5FC 43200400 */   sra       $a0, $a0, 1
    /* 7DE00 8008D600 2000A2AF */  sw         $v0, 0x20($sp)
    /* 7DE04 8008D604 BC00448E */  lw         $a0, 0xBC($s2)
    /* 7DE08 8008D608 3400A58F */  lw         $a1, 0x34($sp)
    /* 7DE0C 8008D60C C2170400 */  srl        $v0, $a0, 31
    /* 7DE10 8008D610 21208200 */  addu       $a0, $a0, $v0
    /* 7DE14 8008D614 CA90030C */  jal        fixedmult
    /* 7DE18 8008D618 43200400 */   sra       $a0, $a0, 1
    /* 7DE1C 8008D61C 2400A2AF */  sw         $v0, 0x24($sp)
    /* 7DE20 8008D620 BC00448E */  lw         $a0, 0xBC($s2)
    /* 7DE24 8008D624 3800A58F */  lw         $a1, 0x38($sp)
    /* 7DE28 8008D628 C2170400 */  srl        $v0, $a0, 31
    /* 7DE2C 8008D62C 21208200 */  addu       $a0, $a0, $v0
    /* 7DE30 8008D630 CA90030C */  jal        fixedmult
    /* 7DE34 8008D634 43200400 */   sra       $a0, $a0, 1
    /* 7DE38 8008D638 2800A2AF */  sw         $v0, 0x28($sp)
    /* 7DE3C 8008D63C AC00428E */  lw         $v0, 0xAC($s2)
    /* 7DE40 8008D640 2000A38F */  lw         $v1, 0x20($sp)
    /* 7DE44 8008D644 00000000 */  nop
    /* 7DE48 8008D648 21104300 */  addu       $v0, $v0, $v1
    /* 7DE4C 8008D64C AC0042AE */  sw         $v0, 0xAC($s2)
    /* 7DE50 8008D650 B000428E */  lw         $v0, 0xB0($s2)
    /* 7DE54 8008D654 2400A38F */  lw         $v1, 0x24($sp)
    /* 7DE58 8008D658 00000000 */  nop
    /* 7DE5C 8008D65C 21104300 */  addu       $v0, $v0, $v1
    /* 7DE60 8008D660 B00042AE */  sw         $v0, 0xB0($s2)
    /* 7DE64 8008D664 B400428E */  lw         $v0, 0xB4($s2)
    /* 7DE68 8008D668 2800A38F */  lw         $v1, 0x28($sp)
    /* 7DE6C 8008D66C 00000000 */  nop
    /* 7DE70 8008D670 21104300 */  addu       $v0, $v0, $v1
    /* 7DE74 8008D674 B40042AE */  sw         $v0, 0xB4($s2)
    /* 7DE78 8008D678 4400A28F */  lw         $v0, 0x44($sp)
    /* 7DE7C 8008D67C 00000000 */  nop
    /* 7DE80 8008D680 02004104 */  bgez       $v0, .L8008D68C
    /* 7DE84 8008D684 00000000 */   nop
    /* 7DE88 8008D688 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008D68C:
    /* 7DE8C 8008D68C 3800A78F */  lw         $a3, 0x38($sp)
    /* 7DE90 8008D690 03120200 */  sra        $v0, $v0, 8
    /* 7DE94 8008D694 0200E104 */  bgez       $a3, .L8008D6A0
    /* 7DE98 8008D698 2120E000 */   addu      $a0, $a3, $zero
    /* 7DE9C 8008D69C FF00E424 */  addiu      $a0, $a3, 0xFF
  .L8008D6A0:
    /* 7DEA0 8008D6A0 035A0400 */  sra        $t3, $a0, 8
    /* 7DEA4 8008D6A4 18004B00 */  mult       $v0, $t3
    /* 7DEA8 8008D6A8 4800A38F */  lw         $v1, 0x48($sp)
    /* 7DEAC 8008D6AC 12200000 */  mflo       $a0
    /* 7DEB0 8008D6B0 02006104 */  bgez       $v1, .L8008D6BC
    /* 7DEB4 8008D6B4 21286000 */   addu      $a1, $v1, $zero
    /* 7DEB8 8008D6B8 FF006524 */  addiu      $a1, $v1, 0xFF
  .L8008D6BC:
    /* 7DEBC 8008D6BC 3400A68F */  lw         $a2, 0x34($sp)
    /* 7DEC0 8008D6C0 03420500 */  sra        $t0, $a1, 8
    /* 7DEC4 8008D6C4 0200C104 */  bgez       $a2, .L8008D6D0
    /* 7DEC8 8008D6C8 2110C000 */   addu      $v0, $a2, $zero
    /* 7DECC 8008D6CC FF00C224 */  addiu      $v0, $a2, 0xFF
  .L8008D6D0:
    /* 7DED0 8008D6D0 03520200 */  sra        $t2, $v0, 8
    /* 7DED4 8008D6D4 18000A01 */  mult       $t0, $t2
    /* 7DED8 8008D6D8 12700000 */  mflo       $t6
    /* 7DEDC 8008D6DC 23108E00 */  subu       $v0, $a0, $t6
    /* 7DEE0 8008D6E0 2000A2AF */  sw         $v0, 0x20($sp)
    /* 7DEE4 8008D6E4 3000A58F */  lw         $a1, 0x30($sp)
    /* 7DEE8 8008D6E8 00000000 */  nop
    /* 7DEEC 8008D6EC 0200A104 */  bgez       $a1, .L8008D6F8
    /* 7DEF0 8008D6F0 2110A000 */   addu      $v0, $a1, $zero
    /* 7DEF4 8008D6F4 FF00A224 */  addiu      $v0, $a1, 0xFF
  .L8008D6F8:
    /* 7DEF8 8008D6F8 034A0200 */  sra        $t1, $v0, 8
    /* 7DEFC 8008D6FC 18000901 */  mult       $t0, $t1
    /* 7DF00 8008D700 4000A38F */  lw         $v1, 0x40($sp)
    /* 7DF04 8008D704 12100000 */  mflo       $v0
    /* 7DF08 8008D708 02006104 */  bgez       $v1, .L8008D714
    /* 7DF0C 8008D70C 21206000 */   addu      $a0, $v1, $zero
    /* 7DF10 8008D710 FF006424 */  addiu      $a0, $v1, 0xFF
  .L8008D714:
    /* 7DF14 8008D714 03220400 */  sra        $a0, $a0, 8
    /* 7DF18 8008D718 18008B00 */  mult       $a0, $t3
    /* 7DF1C 8008D71C 12700000 */  mflo       $t6
    /* 7DF20 8008D720 23104E00 */  subu       $v0, $v0, $t6
    /* 7DF24 8008D724 2400A2AF */  sw         $v0, 0x24($sp)
    /* 7DF28 8008D728 18008A00 */  mult       $a0, $t2
    /* 7DF2C 8008D72C 4400A38F */  lw         $v1, 0x44($sp)
    /* 7DF30 8008D730 12200000 */  mflo       $a0
    /* 7DF34 8008D734 02006104 */  bgez       $v1, .L8008D740
    /* 7DF38 8008D738 21106000 */   addu      $v0, $v1, $zero
    /* 7DF3C 8008D73C FF006224 */  addiu      $v0, $v1, 0xFF
  .L8008D740:
    /* 7DF40 8008D740 03320200 */  sra        $a2, $v0, 8
    /* 7DF44 8008D744 1800C900 */  mult       $a2, $t1
    /* 7DF48 8008D748 12700000 */  mflo       $t6
    /* 7DF4C 8008D74C 23108E00 */  subu       $v0, $a0, $t6
    /* 7DF50 8008D750 2800A2AF */  sw         $v0, 0x28($sp)
    /* 7DF54 8008D754 3800A98F */  lw         $t1, 0x38($sp)
    /* 7DF58 8008D758 00000000 */  nop
    /* 7DF5C 8008D75C 02002105 */  bgez       $t1, .L8008D768
    /* 7DF60 8008D760 21102001 */   addu      $v0, $t1, $zero
    /* 7DF64 8008D764 FF002225 */  addiu      $v0, $t1, 0xFF
  .L8008D768:
    /* 7DF68 8008D768 03620200 */  sra        $t4, $v0, 8
    /* 7DF6C 8008D76C 1800CC00 */  mult       $a2, $t4
    /* 7DF70 8008D770 4800A38F */  lw         $v1, 0x48($sp)
    /* 7DF74 8008D774 12300000 */  mflo       $a2
    /* 7DF78 8008D778 02006104 */  bgez       $v1, .L8008D784
    /* 7DF7C 8008D77C 21286000 */   addu      $a1, $v1, $zero
    /* 7DF80 8008D780 FF006524 */  addiu      $a1, $v1, 0xFF
  .L8008D784:
    /* 7DF84 8008D784 3400A88F */  lw         $t0, 0x34($sp)
    /* 7DF88 8008D788 03120500 */  sra        $v0, $a1, 8
    /* 7DF8C 8008D78C 02000105 */  bgez       $t0, .L8008D798
    /* 7DF90 8008D790 21200001 */   addu      $a0, $t0, $zero
    /* 7DF94 8008D794 FF000425 */  addiu      $a0, $t0, 0xFF
  .L8008D798:
    /* 7DF98 8008D798 035A0400 */  sra        $t3, $a0, 8
    /* 7DF9C 8008D79C 18004B00 */  mult       $v0, $t3
    /* 7DFA0 8008D7A0 12700000 */  mflo       $t6
    /* 7DFA4 8008D7A4 2328CE00 */  subu       $a1, $a2, $t6
    /* 7DFA8 8008D7A8 2000A5AF */  sw         $a1, 0x20($sp)
    /* 7DFAC 8008D7AC 3000A78F */  lw         $a3, 0x30($sp)
    /* 7DFB0 8008D7B0 00000000 */  nop
    /* 7DFB4 8008D7B4 0200E104 */  bgez       $a3, .L8008D7C0
    /* 7DFB8 8008D7B8 2120E000 */   addu      $a0, $a3, $zero
    /* 7DFBC 8008D7BC FF00E424 */  addiu      $a0, $a3, 0xFF
  .L8008D7C0:
    /* 7DFC0 8008D7C0 03520400 */  sra        $t2, $a0, 8
    /* 7DFC4 8008D7C4 18004A00 */  mult       $v0, $t2
    /* 7DFC8 8008D7C8 4000A38F */  lw         $v1, 0x40($sp)
    /* 7DFCC 8008D7CC 12100000 */  mflo       $v0
    /* 7DFD0 8008D7D0 02006104 */  bgez       $v1, .L8008D7DC
    /* 7DFD4 8008D7D4 21306000 */   addu      $a2, $v1, $zero
    /* 7DFD8 8008D7D8 FF006624 */  addiu      $a2, $v1, 0xFF
  .L8008D7DC:
    /* 7DFDC 8008D7DC 03220600 */  sra        $a0, $a2, 8
    /* 7DFE0 8008D7E0 18008C00 */  mult       $a0, $t4
    /* 7DFE4 8008D7E4 12700000 */  mflo       $t6
    /* 7DFE8 8008D7E8 23104E00 */  subu       $v0, $v0, $t6
    /* 7DFEC 8008D7EC 2400A2AF */  sw         $v0, 0x24($sp)
    /* 7DFF0 8008D7F0 18008B00 */  mult       $a0, $t3
    /* 7DFF4 8008D7F4 4400A28F */  lw         $v0, 0x44($sp)
    /* 7DFF8 8008D7F8 12180000 */  mflo       $v1
    /* 7DFFC 8008D7FC 02004104 */  bgez       $v0, .L8008D808
    /* 7E000 8008D800 00000000 */   nop
    /* 7E004 8008D804 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008D808:
    /* 7E008 8008D808 03120200 */  sra        $v0, $v0, 8
    /* 7E00C 8008D80C 18004A00 */  mult       $v0, $t2
    /* 7E010 8008D810 12700000 */  mflo       $t6
    /* 7E014 8008D814 23106E00 */  subu       $v0, $v1, $t6
    /* 7E018 8008D818 2800A2AF */  sw         $v0, 0x28($sp)
    /* 7E01C 8008D81C 2401448E */  lw         $a0, 0x124($s2)
    /* 7E020 8008D820 CA90030C */  jal        fixedmult
    /* 7E024 8008D824 40200400 */   sll       $a0, $a0, 1
    /* 7E028 8008D828 2000A2AF */  sw         $v0, 0x20($sp)
    /* 7E02C 8008D82C 2401448E */  lw         $a0, 0x124($s2)
    /* 7E030 8008D830 2400A58F */  lw         $a1, 0x24($sp)
    /* 7E034 8008D834 CA90030C */  jal        fixedmult
    /* 7E038 8008D838 40200400 */   sll       $a0, $a0, 1
    /* 7E03C 8008D83C 2400A2AF */  sw         $v0, 0x24($sp)
    /* 7E040 8008D840 2401448E */  lw         $a0, 0x124($s2)
    /* 7E044 8008D844 2800A58F */  lw         $a1, 0x28($sp)
    /* 7E048 8008D848 CA90030C */  jal        fixedmult
    /* 7E04C 8008D84C 40200400 */   sll       $a0, $a0, 1
    /* 7E050 8008D850 2800A2AF */  sw         $v0, 0x28($sp)
    /* 7E054 8008D854 1401428E */  lw         $v0, 0x114($s2)
    /* 7E058 8008D858 2000A38F */  lw         $v1, 0x20($sp)
    /* 7E05C 8008D85C 00000000 */  nop
    /* 7E060 8008D860 21104300 */  addu       $v0, $v0, $v1
    /* 7E064 8008D864 140142AE */  sw         $v0, 0x114($s2)
    /* 7E068 8008D868 1801428E */  lw         $v0, 0x118($s2)
    /* 7E06C 8008D86C 2400A38F */  lw         $v1, 0x24($sp)
    /* 7E070 8008D870 00000000 */  nop
    /* 7E074 8008D874 21104300 */  addu       $v0, $v0, $v1
    /* 7E078 8008D878 180142AE */  sw         $v0, 0x118($s2)
    /* 7E07C 8008D87C 1C01428E */  lw         $v0, 0x11C($s2)
    /* 7E080 8008D880 2800A38F */  lw         $v1, 0x28($sp)
    /* 7E084 8008D884 00000000 */  nop
    /* 7E088 8008D888 21104300 */  addu       $v0, $v0, $v1
    /* 7E08C 8008D88C 1C0142AE */  sw         $v0, 0x11C($s2)
  .L8008D890:
    /* 7E090 8008D890 B800BF8F */  lw         $ra, 0xB8($sp)
    /* 7E094 8008D894 B400B58F */  lw         $s5, 0xB4($sp)
    /* 7E098 8008D898 B000B48F */  lw         $s4, 0xB0($sp)
    /* 7E09C 8008D89C AC00B38F */  lw         $s3, 0xAC($sp)
    /* 7E0A0 8008D8A0 A800B28F */  lw         $s2, 0xA8($sp)
    /* 7E0A4 8008D8A4 A400B18F */  lw         $s1, 0xA4($sp)
    /* 7E0A8 8008D8A8 A000B08F */  lw         $s0, 0xA0($sp)
    /* 7E0AC 8008D8AC 0800E003 */  jr         $ra
    /* 7E0B0 8008D8B0 C000BD27 */   addiu     $sp, $sp, 0xC0
endlabel Collide_DoObjectFixedObjectCollision__FP13BO_tNewtonObjP8coorddefN21
