.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIPhysic_FinishUp__FP8Car_tObj, 0x3EC

glabel AIPhysic_FinishUp__FP8Car_tObj
    /* 5CB7C 8006C37C 80FFBD27 */  addiu      $sp, $sp, -0x80
    /* 5CB80 8006C380 7800B2AF */  sw         $s2, 0x78($sp)
    /* 5CB84 8006C384 21908000 */  addu       $s2, $a0, $zero
    /* 5CB88 8006C388 7C00BFAF */  sw         $ra, 0x7C($sp)
    /* 5CB8C 8006C38C 7400B1AF */  sw         $s1, 0x74($sp)
    /* 5CB90 8006C390 7000B0AF */  sw         $s0, 0x70($sp)
    /* 5CB94 8006C394 1404428E */  lw         $v0, 0x414($s2)
    /* 5CB98 8006C398 3804438E */  lw         $v1, 0x438($s2)
    /* 5CB9C 8006C39C 21280000 */  addu       $a1, $zero, $zero
    /* 5CBA0 8006C3A0 21104300 */  addu       $v0, $v0, $v1
    /* 5CBA4 8006C3A4 6117020C */  jal        Cars_DoGravityEffectsOnAcc__FP8Car_tObji
    /* 5CBA8 8006C3A8 140442AE */   sw        $v0, 0x414($s2)
    /* 5CBAC 8006C3AC F0004426 */  addiu      $a0, $s2, 0xF0
    /* 5CBB0 8006C3B0 1404428E */  lw         $v0, 0x414($s2)
    /* 5CBB4 8006C3B4 3804438E */  lw         $v1, 0x438($s2)
    /* 5CBB8 8006C3B8 2000A527 */  addiu      $a1, $sp, 0x20
    /* 5CBBC 8006C3BC 23104300 */  subu       $v0, $v0, $v1
    /* 5CBC0 8006C3C0 D690030C */  jal        transpose
    /* 5CBC4 8006C3C4 140442AE */   sw        $v0, 0x414($s2)
    /* 5CBC8 8006C3C8 44014426 */  addiu      $a0, $s2, 0x144
    /* 5CBCC 8006C3CC D690030C */  jal        transpose
    /* 5CBD0 8006C3D0 4800A527 */   addiu     $a1, $sp, 0x48
    /* 5CBD4 8006C3D4 0C04448E */  lw         $a0, 0x40C($s2)
    /* 5CBD8 8006C3D8 2000A58F */  lw         $a1, 0x20($sp)
    /* 5CBDC 8006C3DC CA90030C */  jal        fixedmult
    /* 5CBE0 8006C3E0 00000000 */   nop
    /* 5CBE4 8006C3E4 1004448E */  lw         $a0, 0x410($s2)
    /* 5CBE8 8006C3E8 2400A58F */  lw         $a1, 0x24($sp)
    /* 5CBEC 8006C3EC CA90030C */  jal        fixedmult
    /* 5CBF0 8006C3F0 21804000 */   addu      $s0, $v0, $zero
    /* 5CBF4 8006C3F4 1404448E */  lw         $a0, 0x414($s2)
    /* 5CBF8 8006C3F8 2800A58F */  lw         $a1, 0x28($sp)
    /* 5CBFC 8006C3FC CA90030C */  jal        fixedmult
    /* 5CC00 8006C400 21884000 */   addu      $s1, $v0, $zero
    /* 5CC04 8006C404 21801102 */  addu       $s0, $s0, $s1
    /* 5CC08 8006C408 0C04448E */  lw         $a0, 0x40C($s2)
    /* 5CC0C 8006C40C 21800202 */  addu       $s0, $s0, $v0
    /* 5CC10 8006C410 000450AE */  sw         $s0, 0x400($s2)
    /* 5CC14 8006C414 2C00A58F */  lw         $a1, 0x2C($sp)
    /* 5CC18 8006C418 CA90030C */  jal        fixedmult
    /* 5CC1C 8006C41C 00000000 */   nop
    /* 5CC20 8006C420 1004448E */  lw         $a0, 0x410($s2)
    /* 5CC24 8006C424 3000A58F */  lw         $a1, 0x30($sp)
    /* 5CC28 8006C428 CA90030C */  jal        fixedmult
    /* 5CC2C 8006C42C 21804000 */   addu      $s0, $v0, $zero
    /* 5CC30 8006C430 1404448E */  lw         $a0, 0x414($s2)
    /* 5CC34 8006C434 3400A58F */  lw         $a1, 0x34($sp)
    /* 5CC38 8006C438 CA90030C */  jal        fixedmult
    /* 5CC3C 8006C43C 21884000 */   addu      $s1, $v0, $zero
    /* 5CC40 8006C440 21801102 */  addu       $s0, $s0, $s1
    /* 5CC44 8006C444 0C04448E */  lw         $a0, 0x40C($s2)
    /* 5CC48 8006C448 21800202 */  addu       $s0, $s0, $v0
    /* 5CC4C 8006C44C 040450AE */  sw         $s0, 0x404($s2)
    /* 5CC50 8006C450 3800A58F */  lw         $a1, 0x38($sp)
    /* 5CC54 8006C454 CA90030C */  jal        fixedmult
    /* 5CC58 8006C458 00000000 */   nop
    /* 5CC5C 8006C45C 1004448E */  lw         $a0, 0x410($s2)
    /* 5CC60 8006C460 3C00A58F */  lw         $a1, 0x3C($sp)
    /* 5CC64 8006C464 CA90030C */  jal        fixedmult
    /* 5CC68 8006C468 21804000 */   addu      $s0, $v0, $zero
    /* 5CC6C 8006C46C 1404448E */  lw         $a0, 0x414($s2)
    /* 5CC70 8006C470 4000A58F */  lw         $a1, 0x40($sp)
    /* 5CC74 8006C474 CA90030C */  jal        fixedmult
    /* 5CC78 8006C478 21884000 */   addu      $s1, $v0, $zero
    /* 5CC7C 8006C47C 21801102 */  addu       $s0, $s0, $s1
    /* 5CC80 8006C480 3004448E */  lw         $a0, 0x430($s2)
    /* 5CC84 8006C484 21800202 */  addu       $s0, $s0, $v0
    /* 5CC88 8006C488 080450AE */  sw         $s0, 0x408($s2)
    /* 5CC8C 8006C48C 4800A58F */  lw         $a1, 0x48($sp)
    /* 5CC90 8006C490 CA90030C */  jal        fixedmult
    /* 5CC94 8006C494 00000000 */   nop
    /* 5CC98 8006C498 3404448E */  lw         $a0, 0x434($s2)
    /* 5CC9C 8006C49C 4C00A58F */  lw         $a1, 0x4C($sp)
    /* 5CCA0 8006C4A0 CA90030C */  jal        fixedmult
    /* 5CCA4 8006C4A4 21804000 */   addu      $s0, $v0, $zero
    /* 5CCA8 8006C4A8 3804448E */  lw         $a0, 0x438($s2)
    /* 5CCAC 8006C4AC 5000A58F */  lw         $a1, 0x50($sp)
    /* 5CCB0 8006C4B0 CA90030C */  jal        fixedmult
    /* 5CCB4 8006C4B4 21884000 */   addu      $s1, $v0, $zero
    /* 5CCB8 8006C4B8 21801102 */  addu       $s0, $s0, $s1
    /* 5CCBC 8006C4BC 21800202 */  addu       $s0, $s0, $v0
    /* 5CCC0 8006C4C0 0004438E */  lw         $v1, 0x400($s2)
    /* 5CCC4 8006C4C4 3004448E */  lw         $a0, 0x430($s2)
    /* 5CCC8 8006C4C8 21187000 */  addu       $v1, $v1, $s0
    /* 5CCCC 8006C4CC 000443AE */  sw         $v1, 0x400($s2)
    /* 5CCD0 8006C4D0 5400A58F */  lw         $a1, 0x54($sp)
    /* 5CCD4 8006C4D4 CA90030C */  jal        fixedmult
    /* 5CCD8 8006C4D8 00000000 */   nop
    /* 5CCDC 8006C4DC 3404448E */  lw         $a0, 0x434($s2)
    /* 5CCE0 8006C4E0 5800A58F */  lw         $a1, 0x58($sp)
    /* 5CCE4 8006C4E4 CA90030C */  jal        fixedmult
    /* 5CCE8 8006C4E8 21804000 */   addu      $s0, $v0, $zero
    /* 5CCEC 8006C4EC 3804448E */  lw         $a0, 0x438($s2)
    /* 5CCF0 8006C4F0 5C00A58F */  lw         $a1, 0x5C($sp)
    /* 5CCF4 8006C4F4 CA90030C */  jal        fixedmult
    /* 5CCF8 8006C4F8 21884000 */   addu      $s1, $v0, $zero
    /* 5CCFC 8006C4FC 21801102 */  addu       $s0, $s0, $s1
    /* 5CD00 8006C500 21800202 */  addu       $s0, $s0, $v0
    /* 5CD04 8006C504 0404438E */  lw         $v1, 0x404($s2)
    /* 5CD08 8006C508 3004448E */  lw         $a0, 0x430($s2)
    /* 5CD0C 8006C50C 21187000 */  addu       $v1, $v1, $s0
    /* 5CD10 8006C510 040443AE */  sw         $v1, 0x404($s2)
    /* 5CD14 8006C514 6000A58F */  lw         $a1, 0x60($sp)
    /* 5CD18 8006C518 CA90030C */  jal        fixedmult
    /* 5CD1C 8006C51C 00000000 */   nop
    /* 5CD20 8006C520 3404448E */  lw         $a0, 0x434($s2)
    /* 5CD24 8006C524 6400A58F */  lw         $a1, 0x64($sp)
    /* 5CD28 8006C528 CA90030C */  jal        fixedmult
    /* 5CD2C 8006C52C 21804000 */   addu      $s0, $v0, $zero
    /* 5CD30 8006C530 3804448E */  lw         $a0, 0x438($s2)
    /* 5CD34 8006C534 6800A58F */  lw         $a1, 0x68($sp)
    /* 5CD38 8006C538 CA90030C */  jal        fixedmult
    /* 5CD3C 8006C53C 21884000 */   addu      $s1, $v0, $zero
    /* 5CD40 8006C540 21801102 */  addu       $s0, $s0, $s1
    /* 5CD44 8006C544 21800202 */  addu       $s0, $s0, $v0
    /* 5CD48 8006C548 0804438E */  lw         $v1, 0x408($s2)
    /* 5CD4C 8006C54C F403448E */  lw         $a0, 0x3F4($s2)
    /* 5CD50 8006C550 21187000 */  addu       $v1, $v1, $s0
    /* 5CD54 8006C554 080443AE */  sw         $v1, 0x408($s2)
    /* 5CD58 8006C558 2000A58F */  lw         $a1, 0x20($sp)
    /* 5CD5C 8006C55C CA90030C */  jal        fixedmult
    /* 5CD60 8006C560 00000000 */   nop
    /* 5CD64 8006C564 F803448E */  lw         $a0, 0x3F8($s2)
    /* 5CD68 8006C568 2400A58F */  lw         $a1, 0x24($sp)
    /* 5CD6C 8006C56C CA90030C */  jal        fixedmult
    /* 5CD70 8006C570 21804000 */   addu      $s0, $v0, $zero
    /* 5CD74 8006C574 FC03448E */  lw         $a0, 0x3FC($s2)
    /* 5CD78 8006C578 2800A58F */  lw         $a1, 0x28($sp)
    /* 5CD7C 8006C57C CA90030C */  jal        fixedmult
    /* 5CD80 8006C580 21884000 */   addu      $s1, $v0, $zero
    /* 5CD84 8006C584 21801102 */  addu       $s0, $s0, $s1
    /* 5CD88 8006C588 21800202 */  addu       $s0, $s0, $v0
    /* 5CD8C 8006C58C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 5CD90 8006C590 F403448E */  lw         $a0, 0x3F4($s2)
    /* 5CD94 8006C594 2C00A58F */  lw         $a1, 0x2C($sp)
    /* 5CD98 8006C598 CA90030C */  jal        fixedmult
    /* 5CD9C 8006C59C 00000000 */   nop
    /* 5CDA0 8006C5A0 F803448E */  lw         $a0, 0x3F8($s2)
    /* 5CDA4 8006C5A4 3000A58F */  lw         $a1, 0x30($sp)
    /* 5CDA8 8006C5A8 CA90030C */  jal        fixedmult
    /* 5CDAC 8006C5AC 21804000 */   addu      $s0, $v0, $zero
    /* 5CDB0 8006C5B0 FC03448E */  lw         $a0, 0x3FC($s2)
    /* 5CDB4 8006C5B4 3400A58F */  lw         $a1, 0x34($sp)
    /* 5CDB8 8006C5B8 CA90030C */  jal        fixedmult
    /* 5CDBC 8006C5BC 21884000 */   addu      $s1, $v0, $zero
    /* 5CDC0 8006C5C0 21801102 */  addu       $s0, $s0, $s1
    /* 5CDC4 8006C5C4 21800202 */  addu       $s0, $s0, $v0
    /* 5CDC8 8006C5C8 1400B0AF */  sw         $s0, 0x14($sp)
    /* 5CDCC 8006C5CC F403448E */  lw         $a0, 0x3F4($s2)
    /* 5CDD0 8006C5D0 3800A58F */  lw         $a1, 0x38($sp)
    /* 5CDD4 8006C5D4 CA90030C */  jal        fixedmult
    /* 5CDD8 8006C5D8 00000000 */   nop
    /* 5CDDC 8006C5DC F803448E */  lw         $a0, 0x3F8($s2)
    /* 5CDE0 8006C5E0 3C00A58F */  lw         $a1, 0x3C($sp)
    /* 5CDE4 8006C5E4 CA90030C */  jal        fixedmult
    /* 5CDE8 8006C5E8 21804000 */   addu      $s0, $v0, $zero
    /* 5CDEC 8006C5EC FC03448E */  lw         $a0, 0x3FC($s2)
    /* 5CDF0 8006C5F0 4000A58F */  lw         $a1, 0x40($sp)
    /* 5CDF4 8006C5F4 CA90030C */  jal        fixedmult
    /* 5CDF8 8006C5F8 21884000 */   addu      $s1, $v0, $zero
    /* 5CDFC 8006C5FC 21801102 */  addu       $s0, $s0, $s1
    /* 5CE00 8006C600 21800202 */  addu       $s0, $s0, $v0
    /* 5CE04 8006C604 1800B0AF */  sw         $s0, 0x18($sp)
    /* 5CE08 8006C608 1000A68F */  lw         $a2, 0x10($sp)
    /* 5CE0C 8006C60C 1400A78F */  lw         $a3, 0x14($sp)
    /* 5CE10 8006C610 1800A88F */  lw         $t0, 0x18($sp)
    /* 5CE14 8006C614 F40346AE */  sw         $a2, 0x3F4($s2)
    /* 5CE18 8006C618 F80347AE */  sw         $a3, 0x3F8($s2)
    /* 5CE1C 8006C61C FC0348AE */  sw         $t0, 0x3FC($s2)
    /* 5CE20 8006C620 0004448E */  lw         $a0, 0x400($s2)
    /* 5CE24 8006C624 4800858F */  lw         $a1, %gp_rel(AIPhysic_iTime)($gp)
    /* 5CE28 8006C628 CA90030C */  jal        fixedmult
    /* 5CE2C 8006C62C 21800000 */   addu      $s0, $zero, $zero
    /* 5CE30 8006C630 0404448E */  lw         $a0, 0x404($s2)
    /* 5CE34 8006C634 AC00438E */  lw         $v1, 0xAC($s2)
    /* 5CE38 8006C638 4800858F */  lw         $a1, %gp_rel(AIPhysic_iTime)($gp)
    /* 5CE3C 8006C63C 21186200 */  addu       $v1, $v1, $v0
    /* 5CE40 8006C640 CA90030C */  jal        fixedmult
    /* 5CE44 8006C644 AC0043AE */   sw        $v1, 0xAC($s2)
    /* 5CE48 8006C648 0804448E */  lw         $a0, 0x408($s2)
    /* 5CE4C 8006C64C B000438E */  lw         $v1, 0xB0($s2)
    /* 5CE50 8006C650 4800858F */  lw         $a1, %gp_rel(AIPhysic_iTime)($gp)
    /* 5CE54 8006C654 21186200 */  addu       $v1, $v1, $v0
    /* 5CE58 8006C658 CA90030C */  jal        fixedmult
    /* 5CE5C 8006C65C B00043AE */   sw        $v1, 0xB0($s2)
    /* 5CE60 8006C660 B400438E */  lw         $v1, 0xB4($s2)
    /* 5CE64 8006C664 3407448E */  lw         $a0, 0x734($s2)
    /* 5CE68 8006C668 21186200 */  addu       $v1, $v1, $v0
    /* 5CE6C 8006C66C 16008010 */  beqz       $a0, .L8006C6C8
    /* 5CE70 8006C670 B40043AE */   sw        $v1, 0xB4($s2)
  .L8006C674:
    /* 5CE74 8006C674 5000828F */  lw         $v0, %gp_rel(AIPhysic_elapsedTime)($gp)
    /* 5CE78 8006C678 00000000 */  nop
    /* 5CE7C 8006C67C 2A100202 */  slt        $v0, $s0, $v0
    /* 5CE80 8006C680 11004010 */  beqz       $v0, .L8006C6C8
    /* 5CE84 8006C684 00000000 */   nop
    /* 5CE88 8006C688 AC00448E */  lw         $a0, 0xAC($s2)
    /* 5CE8C 8006C68C 3407458E */  lw         $a1, 0x734($s2)
    /* 5CE90 8006C690 CA90030C */  jal        fixedmult
    /* 5CE94 8006C694 01001026 */   addiu     $s0, $s0, 0x1
    /* 5CE98 8006C698 B000448E */  lw         $a0, 0xB0($s2)
    /* 5CE9C 8006C69C 3407458E */  lw         $a1, 0x734($s2)
    /* 5CEA0 8006C6A0 CA90030C */  jal        fixedmult
    /* 5CEA4 8006C6A4 AC0042AE */   sw        $v0, 0xAC($s2)
    /* 5CEA8 8006C6A8 B400448E */  lw         $a0, 0xB4($s2)
    /* 5CEAC 8006C6AC 3407458E */  lw         $a1, 0x734($s2)
    /* 5CEB0 8006C6B0 CA90030C */  jal        fixedmult
    /* 5CEB4 8006C6B4 B00042AE */   sw        $v0, 0xB0($s2)
    /* 5CEB8 8006C6B8 3407438E */  lw         $v1, 0x734($s2)
    /* 5CEBC 8006C6BC 00000000 */  nop
    /* 5CEC0 8006C6C0 ECFF6014 */  bnez       $v1, .L8006C674
    /* 5CEC4 8006C6C4 B40042AE */   sw        $v0, 0xB4($s2)
  .L8006C6C8:
    /* 5CEC8 8006C6C8 F403428E */  lw         $v0, 0x3F4($s2)
    /* 5CECC 8006C6CC 00000000 */  nop
    /* 5CED0 8006C6D0 02004104 */  bgez       $v0, .L8006C6DC
    /* 5CED4 8006C6D4 00000000 */   nop
    /* 5CED8 8006C6D8 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8006C6DC:
    /* 5CEDC 8006C6DC 4800848F */  lw         $a0, %gp_rel(AIPhysic_iTime)($gp)
    /* 5CEE0 8006C6E0 03120200 */  sra        $v0, $v0, 8
    /* 5CEE4 8006C6E4 02008104 */  bgez       $a0, .L8006C6F0
    /* 5CEE8 8006C6E8 21188000 */   addu      $v1, $a0, $zero
    /* 5CEEC 8006C6EC FF008324 */  addiu      $v1, $a0, 0xFF
  .L8006C6F0:
    /* 5CEF0 8006C6F0 032A0300 */  sra        $a1, $v1, 8
    /* 5CEF4 8006C6F4 18004500 */  mult       $v0, $a1
    /* 5CEF8 8006C6F8 1401428E */  lw         $v0, 0x114($s2)
    /* 5CEFC 8006C6FC F803438E */  lw         $v1, 0x3F8($s2)
    /* 5CF00 8006C700 12300000 */  mflo       $a2
    /* 5CF04 8006C704 21104600 */  addu       $v0, $v0, $a2
    /* 5CF08 8006C708 02006104 */  bgez       $v1, .L8006C714
    /* 5CF0C 8006C70C 140142AE */   sw        $v0, 0x114($s2)
    /* 5CF10 8006C710 FF006324 */  addiu      $v1, $v1, 0xFF
  .L8006C714:
    /* 5CF14 8006C714 03120300 */  sra        $v0, $v1, 8
    /* 5CF18 8006C718 18004500 */  mult       $v0, $a1
    /* 5CF1C 8006C71C 1801428E */  lw         $v0, 0x118($s2)
    /* 5CF20 8006C720 FC03438E */  lw         $v1, 0x3FC($s2)
    /* 5CF24 8006C724 12300000 */  mflo       $a2
    /* 5CF28 8006C728 21104600 */  addu       $v0, $v0, $a2
    /* 5CF2C 8006C72C 02006104 */  bgez       $v1, .L8006C738
    /* 5CF30 8006C730 180142AE */   sw        $v0, 0x118($s2)
    /* 5CF34 8006C734 FF006324 */  addiu      $v1, $v1, 0xFF
  .L8006C738:
    /* 5CF38 8006C738 03120300 */  sra        $v0, $v1, 8
    /* 5CF3C 8006C73C 18004500 */  mult       $v0, $a1
    /* 5CF40 8006C740 1C01428E */  lw         $v0, 0x11C($s2)
    /* 5CF44 8006C744 12300000 */  mflo       $a2
    /* 5CF48 8006C748 21104600 */  addu       $v0, $v0, $a2
    /* 5CF4C 8006C74C 1C0142AE */  sw         $v0, 0x11C($s2)
    /* 5CF50 8006C750 7C00BF8F */  lw         $ra, 0x7C($sp)
    /* 5CF54 8006C754 7800B28F */  lw         $s2, 0x78($sp)
    /* 5CF58 8006C758 7400B18F */  lw         $s1, 0x74($sp)
    /* 5CF5C 8006C75C 7000B08F */  lw         $s0, 0x70($sp)
    /* 5CF60 8006C760 0800E003 */  jr         $ra
    /* 5CF64 8006C764 8000BD27 */   addiu     $sp, $sp, 0x80
endlabel AIPhysic_FinishUp__FP8Car_tObj
