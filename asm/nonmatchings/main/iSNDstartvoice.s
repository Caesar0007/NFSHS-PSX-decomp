.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDstartvoice, 0x1DC

glabel iSNDstartvoice
    /* EFBCC 800FF3CC D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* EFBD0 800FF3D0 1800B2AF */  sw         $s2, 0x18($sp)
    /* EFBD4 800FF3D4 21908000 */  addu       $s2, $a0, $zero
    /* EFBD8 800FF3D8 4D4A043C */  lui        $a0, (0x4A4DC96F >> 16)
    /* EFBDC 800FF3DC 40101200 */  sll        $v0, $s2, 1
    /* EFBE0 800FF3E0 21105200 */  addu       $v0, $v0, $s2
    /* EFBE4 800FF3E4 80100200 */  sll        $v0, $v0, 2
    /* EFBE8 800FF3E8 23105200 */  subu       $v0, $v0, $s2
    /* EFBEC 800FF3EC 80100200 */  sll        $v0, $v0, 2
    /* EFBF0 800FF3F0 1480033C */  lui        $v1, %hi(D_801479F0)
    /* EFBF4 800FF3F4 2000B4AF */  sw         $s4, 0x20($sp)
    /* EFBF8 800FF3F8 F0797424 */  addiu      $s4, $v1, %lo(D_801479F0)
    /* EFBFC 800FF3FC 1000B0AF */  sw         $s0, 0x10($sp)
    /* EFC00 800FF400 21805400 */  addu       $s0, $v0, $s4
    /* EFC04 800FF404 2800BFAF */  sw         $ra, 0x28($sp)
    /* EFC08 800FF408 2400B5AF */  sw         $s5, 0x24($sp)
    /* EFC0C 800FF40C 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* EFC10 800FF410 1400B1AF */  sw         $s1, 0x14($sp)
    /* EFC14 800FF414 240000A2 */  sb         $zero, 0x24($s0)
    /* EFC18 800FF418 250000A2 */  sb         $zero, 0x25($s0)
    /* EFC1C 800FF41C 0800028E */  lw         $v0, 0x8($s0)
    /* EFC20 800FF420 6FC98434 */  ori        $a0, $a0, (0x4A4DC96F & 0xFFFF)
    /* EFC24 800FF424 19004400 */  multu      $v0, $a0
    /* EFC28 800FF428 0000058E */  lw         $a1, 0x0($s0)
    /* EFC2C 800FF42C 21204002 */  addu       $a0, $s2, $zero
    /* EFC30 800FF430 10400000 */  mfhi       $t0
    /* EFC34 800FF434 C2A90800 */  srl        $s5, $t0, 7
    /* EFC38 800FF438 E5FC030C */  jal        iSNDsetslot
    /* EFC3C 800FF43C 2130A002 */   addu      $a2, $s5, $zero
    /* EFC40 800FF440 01000224 */  addiu      $v0, $zero, 0x1
    /* EFC44 800FF444 04984202 */  sllv       $s3, $v0, $s2
    /* EFC48 800FF448 02000224 */  addiu      $v0, $zero, 0x2
    /* EFC4C 800FF44C 1C0002A2 */  sb         $v0, 0x1C($s0)
    /* EFC50 800FF450 1D0002A2 */  sb         $v0, 0x1D($s0)
    /* EFC54 800FF454 260000A2 */  sb         $zero, 0x26($s0)
    /* EFC58 800FF458 1F000392 */  lbu        $v1, 0x1F($s0)
    /* EFC5C 800FF45C 02000224 */  addiu      $v0, $zero, 0x2
    /* EFC60 800FF460 3C006214 */  bne        $v1, $v0, .L800FF554
    /* EFC64 800FF464 00000000 */   nop
    /* EFC68 800FF468 20000292 */  lbu        $v0, 0x20($s0)
    /* EFC6C 800FF46C 00000000 */  nop
    /* EFC70 800FF470 00160200 */  sll        $v0, $v0, 24
    /* EFC74 800FF474 03160200 */  sra        $v0, $v0, 24
    /* EFC78 800FF478 40180200 */  sll        $v1, $v0, 1
    /* EFC7C 800FF47C 21186200 */  addu       $v1, $v1, $v0
    /* EFC80 800FF480 80180300 */  sll        $v1, $v1, 2
    /* EFC84 800FF484 23186200 */  subu       $v1, $v1, $v0
    /* EFC88 800FF488 80180300 */  sll        $v1, $v1, 2
    /* EFC8C 800FF48C 27000292 */  lbu        $v0, 0x27($s0)
    /* EFC90 800FF490 00000000 */  nop
    /* EFC94 800FF494 00160200 */  sll        $v0, $v0, 24
    /* EFC98 800FF498 0B004004 */  bltz       $v0, .L800FF4C8
    /* EFC9C 800FF49C 21887400 */   addu      $s1, $v1, $s4
    /* EFCA0 800FF4A0 27000292 */  lbu        $v0, 0x27($s0)
    /* EFCA4 800FF4A4 00000000 */  nop
    /* EFCA8 800FF4A8 00160200 */  sll        $v0, $v0, 24
    /* EFCAC 800FF4AC 83150200 */  sra        $v0, $v0, 22
    /* EFCB0 800FF4B0 21108202 */  addu       $v0, $s4, $v0
    /* EFCB4 800FF4B4 2004428C */  lw         $v0, 0x420($v0)
    /* EFCB8 800FF4B8 00000000 */  nop
    /* EFCBC 800FF4BC 0800478C */  lw         $a3, 0x8($v0)
    /* EFCC0 800FF4C0 45FD0308 */  j          .L800FF514
    /* EFCC4 800FF4C4 2130A002 */   addu      $a2, $s5, $zero
  .L800FF4C8:
    /* EFCC8 800FF4C8 9224043C */  lui        $a0, (0x24924925 >> 16)
    /* EFCCC 800FF4CC 0400028E */  lw         $v0, 0x4($s0)
    /* EFCD0 800FF4D0 0400058E */  lw         $a1, 0x4($s0)
    /* EFCD4 800FF4D4 25498434 */  ori        $a0, $a0, (0x24924925 & 0xFFFF)
    /* EFCD8 800FF4D8 82180500 */  srl        $v1, $a1, 2
    /* EFCDC 800FF4DC 19006400 */  multu      $v1, $a0
    /* EFCE0 800FF4E0 10180000 */  mfhi       $v1
    /* EFCE4 800FF4E4 82100200 */  srl        $v0, $v0, 2
    /* EFCE8 800FF4E8 00000000 */  nop
    /* EFCEC 800FF4EC 19004400 */  multu      $v0, $a0
    /* EFCF0 800FF4F0 C0100300 */  sll        $v0, $v1, 3
    /* EFCF4 800FF4F4 23104300 */  subu       $v0, $v0, $v1
    /* EFCF8 800FF4F8 80100200 */  sll        $v0, $v0, 2
    /* EFCFC 800FF4FC 10380000 */  mfhi       $a3
    /* EFD00 800FF500 0200A210 */  beq        $a1, $v0, .L800FF50C
    /* EFD04 800FF504 00000000 */   nop
    /* EFD08 800FF508 0100E724 */  addiu      $a3, $a3, 0x1
  .L800FF50C:
    /* EFD0C 800FF50C 00390700 */  sll        $a3, $a3, 4
    /* EFD10 800FF510 2130A002 */  addu       $a2, $s5, $zero
  .L800FF514:
    /* EFD14 800FF514 20000492 */  lbu        $a0, 0x20($s0)
    /* EFD18 800FF518 0000058E */  lw         $a1, 0x0($s0)
    /* EFD1C 800FF51C 00260400 */  sll        $a0, $a0, 24
    /* EFD20 800FF520 03260400 */  sra        $a0, $a0, 24
    /* EFD24 800FF524 E5FC030C */  jal        iSNDsetslot
    /* EFD28 800FF528 2128A700 */   addu      $a1, $a1, $a3
    /* EFD2C 800FF52C 20000392 */  lbu        $v1, 0x20($s0)
    /* EFD30 800FF530 02000224 */  addiu      $v0, $zero, 0x2
    /* EFD34 800FF534 1C0022A2 */  sb         $v0, 0x1C($s1)
    /* EFD38 800FF538 1D0022A2 */  sb         $v0, 0x1D($s1)
    /* EFD3C 800FF53C 01000224 */  addiu      $v0, $zero, 0x1
    /* EFD40 800FF540 260020A2 */  sb         $zero, 0x26($s1)
    /* EFD44 800FF544 001E0300 */  sll        $v1, $v1, 24
    /* EFD48 800FF548 031E0300 */  sra        $v1, $v1, 24
    /* EFD4C 800FF54C 04106200 */  sllv       $v0, $v0, $v1
    /* EFD50 800FF550 25986202 */  or         $s3, $s3, $v0
  .L800FF554:
    /* EFD54 800FF554 22000592 */  lbu        $a1, 0x22($s0)
    /* EFD58 800FF558 21204002 */  addu       $a0, $s2, $zero
    /* EFD5C 800FF55C 002E0500 */  sll        $a1, $a1, 24
    /* EFD60 800FF560 3E00040C */  jal        iSNDvol
    /* EFD64 800FF564 032E0500 */   sra       $a1, $a1, 24
    /* EFD68 800FF568 21204002 */  addu       $a0, $s2, $zero
    /* EFD6C 800FF56C 23000692 */  lbu        $a2, 0x23($s0)
    /* EFD70 800FF570 21280000 */  addu       $a1, $zero, $zero
    /* EFD74 800FF574 00360600 */  sll        $a2, $a2, 24
    /* EFD78 800FF578 1600040C */  jal        iSNDplatformfxlevel
    /* EFD7C 800FF57C 03360600 */   sra       $a2, $a2, 24
    /* EFD80 800FF580 21106002 */  addu       $v0, $s3, $zero
    /* EFD84 800FF584 2800BF8F */  lw         $ra, 0x28($sp)
    /* EFD88 800FF588 2400B58F */  lw         $s5, 0x24($sp)
    /* EFD8C 800FF58C 2000B48F */  lw         $s4, 0x20($sp)
    /* EFD90 800FF590 1C00B38F */  lw         $s3, 0x1C($sp)
    /* EFD94 800FF594 1800B28F */  lw         $s2, 0x18($sp)
    /* EFD98 800FF598 1400B18F */  lw         $s1, 0x14($sp)
    /* EFD9C 800FF59C 1000B08F */  lw         $s0, 0x10($sp)
    /* EFDA0 800FF5A0 0800E003 */  jr         $ra
    /* EFDA4 800FF5A4 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel iSNDstartvoice
