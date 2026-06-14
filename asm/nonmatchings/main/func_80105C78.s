.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_80105C78, 0xC8

glabel func_80105C78
    /* F6478 80105C78 E9008290 */  lbu        $v0, 0xE9($a0)
    /* F647C 80105C7C 00000000 */  nop
    /* F6480 80105C80 2B004010 */  beqz       $v0, .L80105D30
    /* F6484 80105C84 21400000 */   addu      $t0, $zero, $zero
    /* F6488 80105C88 FF000B24 */  addiu      $t3, $zero, 0xFF
    /* F648C 80105C8C 21500000 */  addu       $t2, $zero, $zero
  .L80105C90:
    /* F6490 80105C90 2000858C */  lw         $a1, 0x20($a0)
    /* F6494 80105C94 21380000 */  addu       $a3, $zero, $zero
    /* F6498 80105C98 05000324 */  addiu      $v1, $zero, 0x5
  .L80105C9C:
    /* F649C 80105C9C 0000A290 */  lbu        $v0, 0x0($a1)
    /* F64A0 80105CA0 00000000 */  nop
    /* F64A4 80105CA4 02004814 */  bne        $v0, $t0, .L80105CB0
    /* F64A8 80105CA8 0100A524 */   addiu     $a1, $a1, 0x1
    /* F64AC 80105CAC 0100E724 */  addiu      $a3, $a3, 0x1
  .L80105CB0:
    /* F64B0 80105CB0 FFFF6324 */  addiu      $v1, $v1, -0x1
    /* F64B4 80105CB4 F9FF6104 */  bgez       $v1, .L80105C9C
    /* F64B8 80105CB8 00000000 */   nop
    /* F64BC 80105CBC 0400828C */  lw         $v0, 0x4($a0)
    /* F64C0 80105CC0 00000000 */  nop
    /* F64C4 80105CC4 21104201 */  addu       $v0, $t2, $v0
    /* F64C8 80105CC8 02004990 */  lbu        $t1, 0x2($v0)
    /* F64CC 80105CCC 2000858C */  lw         $a1, 0x20($a0)
    /* F64D0 80105CD0 02002015 */  bnez       $t1, .L80105CDC
    /* F64D4 80105CD4 21180000 */   addu      $v1, $zero, $zero
    /* F64D8 80105CD8 01000924 */  addiu      $t1, $zero, 0x1
  .L80105CDC:
    /* F64DC 80105CDC 21308000 */  addu       $a2, $a0, $zero
  .L80105CE0:
    /* F64E0 80105CE0 0000A290 */  lbu        $v0, 0x0($a1)
    /* F64E4 80105CE4 00000000 */  nop
    /* F64E8 80105CE8 08004814 */  bne        $v0, $t0, .L80105D0C
    /* F64EC 80105CEC 0100A524 */   addiu     $a1, $a1, 0x1
    /* F64F0 80105CF0 2A10E900 */  slt        $v0, $a3, $t1
    /* F64F4 80105CF4 04004010 */  beqz       $v0, .L80105D08
    /* F64F8 80105CF8 00000000 */   nop
    /* F64FC 80105CFC 5D00CBA0 */  sb         $t3, 0x5D($a2)
    /* F6500 80105D00 43170408 */  j          .L80105D0C
    /* F6504 80105D04 FFFFE724 */   addiu     $a3, $a3, -0x1
  .L80105D08:
    /* F6508 80105D08 5D00C8A0 */  sb         $t0, 0x5D($a2)
  .L80105D0C:
    /* F650C 80105D0C 01006324 */  addiu      $v1, $v1, 0x1
    /* F6510 80105D10 06006228 */  slti       $v0, $v1, 0x6
    /* F6514 80105D14 F2FF4014 */  bnez       $v0, .L80105CE0
    /* F6518 80105D18 0100C624 */   addiu     $a2, $a2, 0x1
    /* F651C 80105D1C E9008290 */  lbu        $v0, 0xE9($a0)
    /* F6520 80105D20 01000825 */  addiu      $t0, $t0, 0x1
    /* F6524 80105D24 2A100201 */  slt        $v0, $t0, $v0
    /* F6528 80105D28 D9FF4014 */  bnez       $v0, .L80105C90
    /* F652C 80105D2C 05004A25 */   addiu     $t2, $t2, 0x5
  .L80105D30:
    /* F6530 80105D30 FE000224 */  addiu      $v0, $zero, 0xFE
    /* F6534 80105D34 460082A0 */  sb         $v0, 0x46($a0)
    /* F6538 80105D38 0800E003 */  jr         $ra
    /* F653C 80105D3C 21100000 */   addu      $v0, $zero, $zero
endlabel func_80105C78
