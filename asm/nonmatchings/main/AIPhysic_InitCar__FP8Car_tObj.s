.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIPhysic_InitCar__FP8Car_tObj, 0x174

glabel AIPhysic_InitCar__FP8Car_tObj
    /* 5D460 8006CC60 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 5D464 8006CC64 2000B4AF */  sw         $s4, 0x20($sp)
    /* 5D468 8006CC68 21A08000 */  addu       $s4, $a0, $zero
    /* 5D46C 8006CC6C 2400BFAF */  sw         $ra, 0x24($sp)
    /* 5D470 8006CC70 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 5D474 8006CC74 1800B2AF */  sw         $s2, 0x18($sp)
    /* 5D478 8006CC78 1400B1AF */  sw         $s1, 0x14($sp)
    /* 5D47C 8006CC7C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 5D480 8006CC80 6002848E */  lw         $a0, 0x260($s4)
    /* 5D484 8006CC84 00000000 */  nop
    /* 5D488 8006CC88 02008230 */  andi       $v0, $a0, 0x2
    /* 5D48C 8006CC8C 49004010 */  beqz       $v0, .L8006CDB4
    /* 5D490 8006CC90 28008230 */   andi      $v0, $a0, 0x28
    /* 5D494 8006CC94 02004010 */  beqz       $v0, .L8006CCA0
    /* 5D498 8006CC98 0C00103C */   lui       $s0, (0xC0000 >> 16)
    /* 5D49C 8006CC9C 0B00103C */  lui        $s0, (0xB0000 >> 16)
  .L8006CCA0:
    /* 5D4A0 8006CCA0 F004828E */  lw         $v0, 0x4F0($s4)
    /* 5D4A4 8006CCA4 00000000 */  nop
    /* 5D4A8 8006CCA8 2000438C */  lw         $v1, 0x20($v0)
    /* 5D4AC 8006CCAC 00000000 */  nop
    /* 5D4B0 8006CCB0 02006104 */  bgez       $v1, .L8006CCBC
    /* 5D4B4 8006CCB4 21100002 */   addu      $v0, $s0, $zero
    /* 5D4B8 8006CCB8 FF006324 */  addiu      $v1, $v1, 0xFF
  .L8006CCBC:
    /* 5D4BC 8006CCBC 02000106 */  bgez       $s0, .L8006CCC8
    /* 5D4C0 8006CCC0 031A0300 */   sra       $v1, $v1, 8
    /* 5D4C4 8006CCC4 FF000226 */  addiu     $v0, $s0, 0xFF
  .L8006CCC8:
    /* 5D4C8 8006CCC8 03120200 */  sra        $v0, $v0, 8
    /* 5D4CC 8006CCCC 18006200 */  mult       $v1, $v0
    /* 5D4D0 8006CCD0 08008230 */  andi       $v0, $a0, 0x8
    /* 5D4D4 8006CCD4 12800000 */  mflo       $s0
    /* 5D4D8 8006CCD8 0D004010 */  beqz       $v0, .L8006CD10
    /* 5D4DC 8006CCDC 00000000 */   nop
    /* 5D4E0 8006CCE0 5402848E */  lw         $a0, 0x254($s4)
    /* 5D4E4 8006CCE4 72BC010C */  jal        AISpeeds_GetUpgradeBrakeMult__Fi
    /* 5D4E8 8006CCE8 00000000 */   nop
    /* 5D4EC 8006CCEC 02000106 */  bgez       $s0, .L8006CCF8
    /* 5D4F0 8006CCF0 21180002 */   addu      $v1, $s0, $zero
    /* 5D4F4 8006CCF4 FF000326 */  addiu      $v1, $s0, 0xFF
  .L8006CCF8:
    /* 5D4F8 8006CCF8 02004104 */  bgez       $v0, .L8006CD04
    /* 5D4FC 8006CCFC 032A0300 */   sra       $a1, $v1, 8
    /* 5D500 8006CD00 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8006CD04:
    /* 5D504 8006CD04 03120200 */  sra        $v0, $v0, 8
    /* 5D508 8006CD08 1800A200 */  mult       $a1, $v0
    /* 5D50C 8006CD0C 12800000 */  mflo       $s0
  .L8006CD10:
    /* 5D510 8006CD10 578F020C */  jal        __builtin_new
    /* 5D514 8006CD14 84000424 */   addiu     $a0, $zero, 0x84
    /* 5D518 8006CD18 21904000 */  addu       $s2, $v0, $zero
    /* 5D51C 8006CD1C 800050AE */  sw         $s0, 0x80($s2)
    /* 5D520 8006CD20 0100043C */  lui        $a0, (0x10000 >> 16)
    /* 5D524 8006CD24 0191030C */  jal        rdiv
    /* 5D528 8006CD28 21280002 */   addu      $a1, $s0, $zero
    /* 5D52C 8006CD2C 21984000 */  addu       $s3, $v0, $zero
    /* 5D530 8006CD30 21880000 */  addu       $s1, $zero, $zero
  .L8006CD34:
    /* 5D534 8006CD34 8000222A */  slti       $v0, $s1, 0x80
    /* 5D538 8006CD38 1D004010 */  beqz       $v0, .L8006CDB0
    /* 5D53C 8006CD3C 00841100 */   sll       $s0, $s1, 16
    /* 5D540 8006CD40 21200002 */  addu       $a0, $s0, $zero
    /* 5D544 8006CD44 CA90030C */  jal        fixedmult
    /* 5D548 8006CD48 21286002 */   addu      $a1, $s3, $zero
    /* 5D54C 8006CD4C 21204000 */  addu       $a0, $v0, $zero
    /* 5D550 8006CD50 CA90030C */  jal        fixedmult
    /* 5D554 8006CD54 21280002 */   addu      $a1, $s0, $zero
    /* 5D558 8006CD58 C21F0200 */  srl        $v1, $v0, 31
    /* 5D55C 8006CD5C 21186200 */  addu       $v1, $v1, $v0
    /* 5D560 8006CD60 02000106 */  bgez       $s0, .L8006CD6C
    /* 5D564 8006CD64 43180300 */   sra       $v1, $v1, 1
    /* 5D568 8006CD68 FFFF1036 */  ori        $s0, $s0, 0xFFFF
  .L8006CD6C:
    /* 5D56C 8006CD6C 03841000 */  sra        $s0, $s0, 16
    /* 5D570 8006CD70 03000106 */  bgez       $s0, .L8006CD80
    /* 5D574 8006CD74 8000022A */   slti      $v0, $s0, 0x80
    /* 5D578 8006CD78 23801000 */  negu       $s0, $s0
    /* 5D57C 8006CD7C 8000022A */  slti       $v0, $s0, 0x80
  .L8006CD80:
    /* 5D580 8006CD80 02004014 */  bnez       $v0, .L8006CD8C
    /* 5D584 8006CD84 00000000 */   nop
    /* 5D588 8006CD88 80001024 */  addiu      $s0, $zero, 0x80
  .L8006CD8C:
    /* 5D58C 8006CD8C 04006104 */  bgez       $v1, .L8006CDA0
    /* 5D590 8006CD90 21805002 */   addu      $s0, $s2, $s0
    /* 5D594 8006CD94 0100023C */  lui        $v0, (0x1FFFF >> 16)
    /* 5D598 8006CD98 FFFF4234 */  ori        $v0, $v0, (0x1FFFF & 0xFFFF)
    /* 5D59C 8006CD9C 21186200 */  addu       $v1, $v1, $v0
  .L8006CDA0:
    /* 5D5A0 8006CDA0 43140300 */  sra        $v0, $v1, 17
    /* 5D5A4 8006CDA4 000002A2 */  sb         $v0, 0x0($s0)
    /* 5D5A8 8006CDA8 4DB30108 */  j          .L8006CD34
    /* 5D5AC 8006CDAC 01003126 */   addiu     $s1, $s1, 0x1
  .L8006CDB0:
    /* 5D5B0 8006CDB0 B80692AE */  sw         $s2, 0x6B8($s4)
  .L8006CDB4:
    /* 5D5B4 8006CDB4 2400BF8F */  lw         $ra, 0x24($sp)
    /* 5D5B8 8006CDB8 2000B48F */  lw         $s4, 0x20($sp)
    /* 5D5BC 8006CDBC 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 5D5C0 8006CDC0 1800B28F */  lw         $s2, 0x18($sp)
    /* 5D5C4 8006CDC4 1400B18F */  lw         $s1, 0x14($sp)
    /* 5D5C8 8006CDC8 1000B08F */  lw         $s0, 0x10($sp)
    /* 5D5CC 8006CDCC 0800E003 */  jr         $ra
    /* 5D5D0 8006CDD0 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel AIPhysic_InitCar__FP8Car_tObj
