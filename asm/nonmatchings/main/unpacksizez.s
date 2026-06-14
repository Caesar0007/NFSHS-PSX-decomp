.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching unpacksizez, 0xC8

glabel unpacksizez
    /* D473C 800E3F3C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* D4740 800E3F40 1000BFAF */  sw         $ra, 0x10($sp)
    /* D4744 800E3F44 01008390 */  lbu        $v1, 0x1($a0)
    /* D4748 800E3F48 FB000224 */  addiu      $v0, $zero, 0xFB
    /* D474C 800E3F4C 04006210 */  beq        $v1, $v0, .L800E3F60
    /* D4750 800E3F50 21280000 */   addu      $a1, $zero, $zero
    /* D4754 800E3F54 32000224 */  addiu      $v0, $zero, 0x32
    /* D4758 800E3F58 26006214 */  bne        $v1, $v0, .L800E3FF4
    /* D475C 800E3F5C 00000000 */   nop
  .L800E3F60:
    /* D4760 800E3F60 00008290 */  lbu        $v0, 0x0($a0)
    /* D4764 800E3F64 00000000 */  nop
    /* D4768 800E3F68 FE004330 */  andi       $v1, $v0, 0xFE
    /* D476C 800E3F6C 32000224 */  addiu      $v0, $zero, 0x32
    /* D4770 800E3F70 1C006210 */  beq        $v1, $v0, .L800E3FE4
    /* D4774 800E3F74 33006228 */   slti      $v0, $v1, 0x33
    /* D4778 800E3F78 0E004010 */  beqz       $v0, .L800E3FB4
    /* D477C 800E3F7C 18000224 */   addiu     $v0, $zero, 0x18
    /* D4780 800E3F80 18006210 */  beq        $v1, $v0, .L800E3FE4
    /* D4784 800E3F84 19006228 */   slti      $v0, $v1, 0x19
    /* D4788 800E3F88 05004010 */  beqz       $v0, .L800E3FA0
    /* D478C 800E3F8C 10000224 */   addiu     $v0, $zero, 0x10
    /* D4790 800E3F90 15006210 */  beq        $v1, $v0, .L800E3FE8
    /* D4794 800E3F94 02008424 */   addiu     $a0, $a0, 0x2
    /* D4798 800E3F98 FD8F0308 */  j          .L800E3FF4
    /* D479C 800E3F9C 00000000 */   nop
  .L800E3FA0:
    /* D47A0 800E3FA0 30000224 */  addiu      $v0, $zero, 0x30
    /* D47A4 800E3FA4 10006210 */  beq        $v1, $v0, .L800E3FE8
    /* D47A8 800E3FA8 02008424 */   addiu     $a0, $a0, 0x2
    /* D47AC 800E3FAC FD8F0308 */  j          .L800E3FF4
    /* D47B0 800E3FB0 00000000 */   nop
  .L800E3FB4:
    /* D47B4 800E3FB4 46000224 */  addiu      $v0, $zero, 0x46
    /* D47B8 800E3FB8 0A006210 */  beq        $v1, $v0, .L800E3FE4
    /* D47BC 800E3FBC 47006228 */   slti      $v0, $v1, 0x47
    /* D47C0 800E3FC0 05004010 */  beqz       $v0, .L800E3FD8
    /* D47C4 800E3FC4 34000224 */   addiu     $v0, $zero, 0x34
    /* D47C8 800E3FC8 07006210 */  beq        $v1, $v0, .L800E3FE8
    /* D47CC 800E3FCC 02008424 */   addiu     $a0, $a0, 0x2
    /* D47D0 800E3FD0 FD8F0308 */  j          .L800E3FF4
    /* D47D4 800E3FD4 00000000 */   nop
  .L800E3FD8:
    /* D47D8 800E3FD8 4A000224 */  addiu      $v0, $zero, 0x4A
    /* D47DC 800E3FDC 05006214 */  bne        $v1, $v0, .L800E3FF4
    /* D47E0 800E3FE0 00000000 */   nop
  .L800E3FE4:
    /* D47E4 800E3FE4 02008424 */  addiu      $a0, $a0, 0x2
  .L800E3FE8:
    /* D47E8 800E3FE8 09CC030C */  jal        getm
    /* D47EC 800E3FEC 03000524 */   addiu     $a1, $zero, 0x3
    /* D47F0 800E3FF0 21284000 */  addu       $a1, $v0, $zero
  .L800E3FF4:
    /* D47F4 800E3FF4 1000BF8F */  lw         $ra, 0x10($sp)
    /* D47F8 800E3FF8 2110A000 */  addu       $v0, $a1, $zero
    /* D47FC 800E3FFC 0800E003 */  jr         $ra
    /* D4800 800E4000 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel unpacksizez
