.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MenuExtended_GoToRace__FR12tMenuCommand, 0x15C

glabel MenuExtended_GoToRace__FR12tMenuCommand
    /* 1D498 8002CC98 08FFBD27 */  addiu      $sp, $sp, -0xF8
    /* 1D49C 8002CC9C EC00B3AF */  sw         $s3, 0xEC($sp)
    /* 1D4A0 8002CCA0 21988000 */  addu       $s3, $a0, $zero
    /* 1D4A4 8002CCA4 0580023C */  lui        $v0, %hi(FEApp)
    /* 1D4A8 8002CCA8 C014438C */  lw         $v1, %lo(FEApp)($v0)
    /* 1D4AC 8002CCAC 05000224 */  addiu      $v0, $zero, 0x5
    /* 1D4B0 8002CCB0 F000BFAF */  sw         $ra, 0xF0($sp)
    /* 1D4B4 8002CCB4 E800B2AF */  sw         $s2, 0xE8($sp)
    /* 1D4B8 8002CCB8 E400B1AF */  sw         $s1, 0xE4($sp)
    /* 1D4BC 8002CCBC E000B0AF */  sw         $s0, 0xE0($sp)
    /* 1D4C0 8002CCC0 000062AE */  sw         $v0, 0x0($s3)
    /* 1D4C4 8002CCC4 1180023C */  lui        $v0, %hi(frontEnd)
    /* 1D4C8 8002CCC8 00465224 */  addiu      $s2, $v0, %lo(frontEnd)
    /* 1D4CC 8002CCCC 01000224 */  addiu      $v0, $zero, 0x1
    /* 1D4D0 8002CCD0 2A015092 */  lbu        $s0, 0x12A($s2)
    /* 1D4D4 8002CCD4 00000000 */  nop
    /* 1D4D8 8002CCD8 0E000216 */  bne        $s0, $v0, .L8002CD14
    /* 1D4DC 8002CCDC 2C007124 */   addiu     $s1, $v1, 0x2C
    /* 1D4E0 8002CCE0 1180043C */  lui        $a0, %hi(carManager)
    /* 1D4E4 8002CCE4 74428424 */  addiu      $a0, $a0, %lo(carManager)
    /* 1D4E8 8002CCE8 CD5C000C */  jal        GetNumOwnedCars__11tCarManagers
    /* 1D4EC 8002CCEC 21280000 */   addu      $a1, $zero, $zero
    /* 1D4F0 8002CCF0 00140200 */  sll        $v0, $v0, 16
    /* 1D4F4 8002CCF4 0800401C */  bgtz       $v0, .L8002CD18
    /* 1D4F8 8002CCF8 1180023C */   lui       $v0, %hi(D_80114604)
    /* 1D4FC 8002CCFC 04004392 */  lbu        $v1, 0x4($s2)
    /* 1D500 8002CD00 00000000 */  nop
    /* 1D504 8002CD04 03007010 */  beq        $v1, $s0, .L8002CD14
    /* 1D508 8002CD08 06000224 */   addiu     $v0, $zero, 0x6
    /* 1D50C 8002CD0C 2C006214 */  bne        $v1, $v0, .L8002CDC0
    /* 1D510 8002CD10 AA000424 */   addiu     $a0, $zero, 0xAA
  .L8002CD14:
    /* 1D514 8002CD14 1180023C */  lui        $v0, %hi(D_80114604)
  .L8002CD18:
    /* 1D518 8002CD18 04464390 */  lbu        $v1, %lo(D_80114604)($v0)
    /* 1D51C 8002CD1C 02000224 */  addiu      $v0, $zero, 0x2
    /* 1D520 8002CD20 0A006214 */  bne        $v1, $v0, .L8002CD4C
    /* 1D524 8002CD24 1180023C */   lui       $v0, %hi(frontEnd)
    /* 1D528 8002CD28 1180043C */  lui        $a0, %hi(carManager)
    /* 1D52C 8002CD2C 74428424 */  addiu      $a0, $a0, %lo(carManager)
    /* 1D530 8002CD30 DE5C000C */  jal        GetNumTourneyCars__11tCarManagers
    /* 1D534 8002CD34 21280000 */   addu      $a1, $zero, $zero
    /* 1D538 8002CD38 00140200 */  sll        $v0, $v0, 16
    /* 1D53C 8002CD3C 0300401C */  bgtz       $v0, .L8002CD4C
    /* 1D540 8002CD40 1180023C */   lui       $v0, %hi(frontEnd)
    /* 1D544 8002CD44 70B30008 */  j          .L8002CDC0
    /* 1D548 8002CD48 F1000424 */   addiu     $a0, $zero, 0xF1
  .L8002CD4C:
    /* 1D54C 8002CD4C 00464524 */  addiu      $a1, $v0, %lo(frontEnd)
    /* 1D550 8002CD50 0400A390 */  lbu        $v1, 0x4($a1)
    /* 1D554 8002CD54 01000224 */  addiu      $v0, $zero, 0x1
    /* 1D558 8002CD58 0C006214 */  bne        $v1, $v0, .L8002CD8C
    /* 1D55C 8002CD5C 1180023C */   lui       $v0, %hi(frontEnd)
    /* 1D560 8002CD60 1180043C */  lui        $a0, %hi(carManager)
    /* 1D564 8002CD64 74428424 */  addiu      $a0, $a0, %lo(carManager)
    /* 1D568 8002CD68 5C00A590 */  lbu        $a1, 0x5C($a1)
    /* 1D56C 8002CD6C A45B000C */  jal        GetStockCar__11tCarManagersR8tCarInfo
    /* 1D570 8002CD70 1000A627 */   addiu     $a2, $sp, 0x10
    /* 1D574 8002CD74 CF00A293 */  lbu        $v0, 0xCF($sp)
    /* 1D578 8002CD78 00000000 */  nop
    /* 1D57C 8002CD7C 03004014 */  bnez       $v0, .L8002CD8C
    /* 1D580 8002CD80 1180023C */   lui       $v0, %hi(frontEnd)
    /* 1D584 8002CD84 70B30008 */  j          .L8002CDC0
    /* 1D588 8002CD88 F2000424 */   addiu     $a0, $zero, 0xF2
  .L8002CD8C:
    /* 1D58C 8002CD8C 00464324 */  addiu      $v1, $v0, %lo(frontEnd)
    /* 1D590 8002CD90 2A016290 */  lbu        $v0, 0x12A($v1)
    /* 1D594 8002CD94 00000000 */  nop
    /* 1D598 8002CD98 0F004014 */  bnez       $v0, .L8002CDD8
    /* 1D59C 8002CD9C 1180043C */   lui       $a0, %hi(carManager)
    /* 1D5A0 8002CDA0 74428424 */  addiu      $a0, $a0, %lo(carManager)
    /* 1D5A4 8002CDA4 5C006590 */  lbu        $a1, 0x5C($v1)
    /* 1D5A8 8002CDA8 A45B000C */  jal        GetStockCar__11tCarManagersR8tCarInfo
    /* 1D5AC 8002CDAC 1000A627 */   addiu     $a2, $sp, 0x10
    /* 1D5B0 8002CDB0 1700A293 */  lbu        $v0, 0x17($sp)
    /* 1D5B4 8002CDB4 00000000 */  nop
    /* 1D5B8 8002CDB8 07004014 */  bnez       $v0, .L8002CDD8
    /* 1D5BC 8002CDBC F3000424 */   addiu     $a0, $zero, 0xF3
  .L8002CDC0:
    /* 1D5C0 8002CDC0 94E4020C */  jal        TextSys_Word__Fi
    /* 1D5C4 8002CDC4 00000000 */   nop
    /* 1D5C8 8002CDC8 21202002 */  addu       $a0, $s1, $zero
    /* 1D5CC 8002CDCC 1062000C */  jal        Display__11tDialogBase
    /* 1D5D0 8002CDD0 900082AC */   sw        $v0, 0x90($a0)
    /* 1D5D4 8002CDD4 000060AE */  sw         $zero, 0x0($s3)
  .L8002CDD8:
    /* 1D5D8 8002CDD8 F000BF8F */  lw         $ra, 0xF0($sp)
    /* 1D5DC 8002CDDC EC00B38F */  lw         $s3, 0xEC($sp)
    /* 1D5E0 8002CDE0 E800B28F */  lw         $s2, 0xE8($sp)
    /* 1D5E4 8002CDE4 E400B18F */  lw         $s1, 0xE4($sp)
    /* 1D5E8 8002CDE8 E000B08F */  lw         $s0, 0xE0($sp)
    /* 1D5EC 8002CDEC 0800E003 */  jr         $ra
    /* 1D5F0 8002CDF0 F800BD27 */   addiu     $sp, $sp, 0xF8
endlabel MenuExtended_GoToRace__FR12tMenuCommand
