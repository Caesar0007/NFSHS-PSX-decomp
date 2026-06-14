.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __muldf3, 0x314

glabel __muldf3
    /* E6AE4 800F62E4 80FFBD27 */  addiu      $sp, $sp, -0x80
    /* E6AE8 800F62E8 FF7F0A3C */  lui        $t2, (0x7FFFFFFF >> 16)
    /* E6AEC 800F62EC FFFF4A35 */  ori        $t2, $t2, (0x7FFFFFFF & 0xFFFF)
    /* E6AF0 800F62F0 21408000 */  addu       $t0, $a0, $zero
    /* E6AF4 800F62F4 2148A000 */  addu       $t1, $a1, $zero
    /* E6AF8 800F62F8 0080023C */  lui        $v0, (0x80000000 >> 16)
    /* E6AFC 800F62FC 24182201 */  and        $v1, $t1, $v0
    /* E6B00 800F6300 2410E200 */  and        $v0, $a3, $v0
    /* E6B04 800F6304 7800BEAF */  sw         $fp, 0x78($sp)
    /* E6B08 800F6308 26F06200 */  xor        $fp, $v1, $v0
    /* E6B0C 800F630C 24102A01 */  and        $v0, $t1, $t2
    /* E6B10 800F6310 7C00BFAF */  sw         $ra, 0x7C($sp)
    /* E6B14 800F6314 7400B7AF */  sw         $s7, 0x74($sp)
    /* E6B18 800F6318 7000B6AF */  sw         $s6, 0x70($sp)
    /* E6B1C 800F631C 6C00B5AF */  sw         $s5, 0x6C($sp)
    /* E6B20 800F6320 6800B4AF */  sw         $s4, 0x68($sp)
    /* E6B24 800F6324 6400B3AF */  sw         $s3, 0x64($sp)
    /* E6B28 800F6328 6000B2AF */  sw         $s2, 0x60($sp)
    /* E6B2C 800F632C 5C00B1AF */  sw         $s1, 0x5C($sp)
    /* E6B30 800F6330 03004014 */  bnez       $v0, .L800F6340
    /* E6B34 800F6334 5800B0AF */   sw        $s0, 0x58($sp)
    /* E6B38 800F6338 06000011 */  beqz       $t0, .L800F6354
    /* E6B3C 800F633C 00000000 */   nop
  .L800F6340:
    /* E6B40 800F6340 2410EA00 */  and        $v0, $a3, $t2
    /* E6B44 800F6344 06004014 */  bnez       $v0, .L800F6360
    /* E6B48 800F6348 031D0900 */   sra       $v1, $t1, 20
    /* E6B4C 800F634C 0500C014 */  bnez       $a2, .L800F6364
    /* E6B50 800F6350 FF076330 */   andi      $v1, $v1, 0x7FF
  .L800F6354:
    /* E6B54 800F6354 4C00BEAF */  sw         $fp, 0x4C($sp)
    /* E6B58 800F6358 70D90308 */  j          .L800F65C0
    /* E6B5C 800F635C 4800A0AF */   sw        $zero, 0x48($sp)
  .L800F6360:
    /* E6B60 800F6360 FF076330 */  andi       $v1, $v1, 0x7FF
  .L800F6364:
    /* E6B64 800F6364 03150700 */  sra        $v0, $a3, 20
    /* E6B68 800F6368 FF074230 */  andi       $v0, $v0, 0x7FF
    /* E6B6C 800F636C 21186200 */  addu       $v1, $v1, $v0
    /* E6B70 800F6370 02FC7724 */  addiu      $s7, $v1, -0x3FE
    /* E6B74 800F6374 5000A3AF */  sw         $v1, 0x50($sp)
    /* E6B78 800F6378 0F00033C */  lui        $v1, (0xFFFFF >> 16)
    /* E6B7C 800F637C FFFF6334 */  ori        $v1, $v1, (0xFFFFF & 0xFFFF)
    /* E6B80 800F6380 3800B427 */  addiu      $s4, $sp, 0x38
    /* E6B84 800F6384 21208002 */  addu       $a0, $s4, $zero
    /* E6B88 800F6388 24102301 */  and        $v0, $t1, $v1
    /* E6B8C 800F638C 1000053C */  lui        $a1, (0x100000 >> 16)
    /* E6B90 800F6390 25104500 */  or         $v0, $v0, $a1
    /* E6B94 800F6394 2418E300 */  and        $v1, $a3, $v1
    /* E6B98 800F6398 25186500 */  or         $v1, $v1, $a1
    /* E6B9C 800F639C 15001324 */  addiu      $s3, $zero, 0x15
    /* E6BA0 800F63A0 2C00A2AF */  sw         $v0, 0x2C($sp)
    /* E6BA4 800F63A4 2800A8AF */  sw         $t0, 0x28($sp)
    /* E6BA8 800F63A8 3400A3AF */  sw         $v1, 0x34($sp)
    /* E6BAC 800F63AC 3000A6AF */  sw         $a2, 0x30($sp)
    /* E6BB0 800F63B0 1000B3AF */  sw         $s3, 0x10($sp)
    /* E6BB4 800F63B4 2800A68F */  lw         $a2, 0x28($sp)
    /* E6BB8 800F63B8 2C00A78F */  lw         $a3, 0x2C($sp)
    /* E6BBC 800F63BC 3A12040C */  jal        _dbl_shift_us
    /* E6BC0 800F63C0 01000524 */   addiu     $a1, $zero, 0x1
    /* E6BC4 800F63C4 3800B68F */  lw         $s6, 0x38($sp)
    /* E6BC8 800F63C8 21208002 */  addu       $a0, $s4, $zero
    /* E6BCC 800F63CC 1000B3AF */  sw         $s3, 0x10($sp)
    /* E6BD0 800F63D0 3000A68F */  lw         $a2, 0x30($sp)
    /* E6BD4 800F63D4 3400A78F */  lw         $a3, 0x34($sp)
    /* E6BD8 800F63D8 3A12040C */  jal        _dbl_shift_us
    /* E6BDC 800F63DC 01000524 */   addiu     $a1, $zero, 0x1
    /* E6BE0 800F63E0 1F00023C */  lui        $v0, (0x1FFFFF >> 16)
    /* E6BE4 800F63E4 FFFF4234 */  ori        $v0, $v0, (0x1FFFFF & 0xFFFF)
    /* E6BE8 800F63E8 1800A427 */  addiu      $a0, $sp, 0x18
    /* E6BEC 800F63EC 2128C002 */  addu       $a1, $s6, $zero
    /* E6BF0 800F63F0 3800B28F */  lw         $s2, 0x38($sp)
    /* E6BF4 800F63F4 2800B08F */  lw         $s0, 0x28($sp)
    /* E6BF8 800F63F8 3000B18F */  lw         $s1, 0x30($sp)
    /* E6BFC 800F63FC 21304002 */  addu       $a2, $s2, $zero
    /* E6C00 800F6400 24800202 */  and        $s0, $s0, $v0
    /* E6C04 800F6404 7ED9030C */  jal        _mul_mant_d
    /* E6C08 800F6408 24882202 */   and       $s1, $s1, $v0
    /* E6C0C 800F640C 4000B527 */  addiu      $s5, $sp, 0x40
    /* E6C10 800F6410 2120A002 */  addu       $a0, $s5, $zero
    /* E6C14 800F6414 21280002 */  addu       $a1, $s0, $zero
    /* E6C18 800F6418 7ED9030C */  jal        _mul_mant_d
    /* E6C1C 800F641C 21304002 */   addu      $a2, $s2, $zero
    /* E6C20 800F6420 21208002 */  addu       $a0, $s4, $zero
    /* E6C24 800F6424 1000B3AF */  sw         $s3, 0x10($sp)
    /* E6C28 800F6428 4000A68F */  lw         $a2, 0x40($sp)
    /* E6C2C 800F642C 4400A78F */  lw         $a3, 0x44($sp)
    /* E6C30 800F6430 3A12040C */  jal        _dbl_shift_us
    /* E6C34 800F6434 01000524 */   addiu     $a1, $zero, 0x1
    /* E6C38 800F6438 3C00A28F */  lw         $v0, 0x3C($sp)
    /* E6C3C 800F643C 00000000 */  nop
    /* E6C40 800F6440 1000A2AF */  sw         $v0, 0x10($sp)
    /* E6C44 800F6444 3800A78F */  lw         $a3, 0x38($sp)
    /* E6C48 800F6448 1800A58F */  lw         $a1, 0x18($sp)
    /* E6C4C 800F644C 1C00A68F */  lw         $a2, 0x1C($sp)
    /* E6C50 800F6450 DC1B040C */  jal        _add_mant_d
    /* E6C54 800F6454 1800A427 */   addiu     $a0, $sp, 0x18
    /* E6C58 800F6458 2120A002 */  addu       $a0, $s5, $zero
    /* E6C5C 800F645C 21282002 */  addu       $a1, $s1, $zero
    /* E6C60 800F6460 7ED9030C */  jal        _mul_mant_d
    /* E6C64 800F6464 2130C002 */   addu      $a2, $s6, $zero
    /* E6C68 800F6468 21208002 */  addu       $a0, $s4, $zero
    /* E6C6C 800F646C 1000B3AF */  sw         $s3, 0x10($sp)
    /* E6C70 800F6470 4000A68F */  lw         $a2, 0x40($sp)
    /* E6C74 800F6474 4400A78F */  lw         $a3, 0x44($sp)
    /* E6C78 800F6478 3A12040C */  jal        _dbl_shift_us
    /* E6C7C 800F647C 01000524 */   addiu     $a1, $zero, 0x1
    /* E6C80 800F6480 3C00A28F */  lw         $v0, 0x3C($sp)
    /* E6C84 800F6484 00000000 */  nop
    /* E6C88 800F6488 1000A2AF */  sw         $v0, 0x10($sp)
    /* E6C8C 800F648C 3800A78F */  lw         $a3, 0x38($sp)
    /* E6C90 800F6490 1800A58F */  lw         $a1, 0x18($sp)
    /* E6C94 800F6494 1C00A68F */  lw         $a2, 0x1C($sp)
    /* E6C98 800F6498 DC1B040C */  jal        _add_mant_d
    /* E6C9C 800F649C 1800A427 */   addiu     $a0, $sp, 0x18
    /* E6CA0 800F64A0 1C00A28F */  lw         $v0, 0x1C($sp)
    /* E6CA4 800F64A4 00000000 */  nop
    /* E6CA8 800F64A8 11004104 */  bgez       $v0, .L800F64F0
    /* E6CAC 800F64AC 0080103C */   lui       $s0, (0x80000000 >> 16)
    /* E6CB0 800F64B0 00040224 */  addiu      $v0, $zero, 0x400
    /* E6CB4 800F64B4 2400A0AF */  sw         $zero, 0x24($sp)
    /* E6CB8 800F64B8 2000A2AF */  sw         $v0, 0x20($sp)
    /* E6CBC 800F64BC 1000A0AF */  sw         $zero, 0x10($sp)
    /* E6CC0 800F64C0 2000A78F */  lw         $a3, 0x20($sp)
    /* E6CC4 800F64C4 1800A58F */  lw         $a1, 0x18($sp)
    /* E6CC8 800F64C8 1C00A68F */  lw         $a2, 0x1C($sp)
    /* E6CCC 800F64CC DC1B040C */  jal        _add_mant_d
    /* E6CD0 800F64D0 1800A427 */   addiu     $a0, $sp, 0x18
    /* E6CD4 800F64D4 1800A427 */  addiu      $a0, $sp, 0x18
    /* E6CD8 800F64D8 0B000224 */  addiu      $v0, $zero, 0xB
    /* E6CDC 800F64DC 1000A2AF */  sw         $v0, 0x10($sp)
    /* E6CE0 800F64E0 1800A68F */  lw         $a2, 0x18($sp)
    /* E6CE4 800F64E4 1C00A78F */  lw         $a3, 0x1C($sp)
    /* E6CE8 800F64E8 57D90308 */  j          .L800F655C
    /* E6CEC 800F64EC 01000524 */   addiu     $a1, $zero, 0x1
  .L800F64F0:
    /* E6CF0 800F64F0 00020224 */  addiu      $v0, $zero, 0x200
    /* E6CF4 800F64F4 2400A0AF */  sw         $zero, 0x24($sp)
    /* E6CF8 800F64F8 2000A2AF */  sw         $v0, 0x20($sp)
    /* E6CFC 800F64FC 1000A0AF */  sw         $zero, 0x10($sp)
    /* E6D00 800F6500 2000A78F */  lw         $a3, 0x20($sp)
    /* E6D04 800F6504 1800A58F */  lw         $a1, 0x18($sp)
    /* E6D08 800F6508 1C00A68F */  lw         $a2, 0x1C($sp)
    /* E6D0C 800F650C DC1B040C */  jal        _add_mant_d
    /* E6D10 800F6510 1800A427 */   addiu     $a0, $sp, 0x18
    /* E6D14 800F6514 1C00A28F */  lw         $v0, 0x1C($sp)
    /* E6D18 800F6518 00000000 */  nop
    /* E6D1C 800F651C 24105000 */  and        $v0, $v0, $s0
    /* E6D20 800F6520 07004010 */  beqz       $v0, .L800F6540
    /* E6D24 800F6524 1800A427 */   addiu     $a0, $sp, 0x18
    /* E6D28 800F6528 0B000224 */  addiu      $v0, $zero, 0xB
    /* E6D2C 800F652C 1000A2AF */  sw         $v0, 0x10($sp)
    /* E6D30 800F6530 1800A68F */  lw         $a2, 0x18($sp)
    /* E6D34 800F6534 1C00A78F */  lw         $a3, 0x1C($sp)
    /* E6D38 800F6538 57D90308 */  j          .L800F655C
    /* E6D3C 800F653C 01000524 */   addiu     $a1, $zero, 0x1
  .L800F6540:
    /* E6D40 800F6540 01000524 */  addiu      $a1, $zero, 0x1
    /* E6D44 800F6544 0A000224 */  addiu      $v0, $zero, 0xA
    /* E6D48 800F6548 1000A2AF */  sw         $v0, 0x10($sp)
    /* E6D4C 800F654C 1800A68F */  lw         $a2, 0x18($sp)
    /* E6D50 800F6550 5000AB8F */  lw         $t3, 0x50($sp)
    /* E6D54 800F6554 1C00A78F */  lw         $a3, 0x1C($sp)
    /* E6D58 800F6558 01FC7725 */  addiu      $s7, $t3, -0x3FF
  .L800F655C:
    /* E6D5C 800F655C 3A12040C */  jal        _dbl_shift_us
    /* E6D60 800F6560 00000000 */   nop
    /* E6D64 800F6564 EFFF033C */  lui        $v1, (0xFFEFFFFF >> 16)
    /* E6D68 800F6568 1C00A28F */  lw         $v0, 0x1C($sp)
    /* E6D6C 800F656C FFFF6334 */  ori        $v1, $v1, (0xFFEFFFFF & 0xFFFF)
    /* E6D70 800F6570 24184300 */  and        $v1, $v0, $v1
    /* E6D74 800F6574 FF07E22A */  slti       $v0, $s7, 0x7FF
    /* E6D78 800F6578 0A004014 */  bnez       $v0, .L800F65A4
    /* E6D7C 800F657C 1C00A3AF */   sw        $v1, 0x1C($sp)
    /* E6D80 800F6580 22000424 */  addiu      $a0, $zero, 0x22
    /* E6D84 800F6584 951A040C */  jal        _err_math
    /* E6D88 800F6588 0D000524 */   addiu     $a1, $zero, 0xD
    /* E6D8C 800F658C 0200C013 */  beqz       $fp, .L800F6598
    /* E6D90 800F6590 F07F023C */   lui       $v0, (0x7FF00000 >> 16)
    /* E6D94 800F6594 F0FF023C */  lui        $v0, (0xFFF00000 >> 16)
  .L800F6598:
    /* E6D98 800F6598 4C00A2AF */  sw         $v0, 0x4C($sp)
    /* E6D9C 800F659C 70D90308 */  j          .L800F65C0
    /* E6DA0 800F65A0 4800A0AF */   sw        $zero, 0x48($sp)
  .L800F65A4:
    /* E6DA4 800F65A4 00151700 */  sll        $v0, $s7, 20
    /* E6DA8 800F65A8 2510C203 */  or         $v0, $fp, $v0
    /* E6DAC 800F65AC 25104300 */  or         $v0, $v0, $v1
    /* E6DB0 800F65B0 4C00A2AF */  sw         $v0, 0x4C($sp)
    /* E6DB4 800F65B4 1800AB8F */  lw         $t3, 0x18($sp)
    /* E6DB8 800F65B8 00000000 */  nop
    /* E6DBC 800F65BC 4800ABAF */  sw         $t3, 0x48($sp)
  .L800F65C0:
    /* E6DC0 800F65C0 4800A28F */  lw         $v0, 0x48($sp)
    /* E6DC4 800F65C4 4C00A38F */  lw         $v1, 0x4C($sp)
    /* E6DC8 800F65C8 7C00BF8F */  lw         $ra, 0x7C($sp)
    /* E6DCC 800F65CC 7800BE8F */  lw         $fp, 0x78($sp)
    /* E6DD0 800F65D0 7400B78F */  lw         $s7, 0x74($sp)
    /* E6DD4 800F65D4 7000B68F */  lw         $s6, 0x70($sp)
    /* E6DD8 800F65D8 6C00B58F */  lw         $s5, 0x6C($sp)
    /* E6DDC 800F65DC 6800B48F */  lw         $s4, 0x68($sp)
    /* E6DE0 800F65E0 6400B38F */  lw         $s3, 0x64($sp)
    /* E6DE4 800F65E4 6000B28F */  lw         $s2, 0x60($sp)
    /* E6DE8 800F65E8 5C00B18F */  lw         $s1, 0x5C($sp)
    /* E6DEC 800F65EC 5800B08F */  lw         $s0, 0x58($sp)
    /* E6DF0 800F65F0 0800E003 */  jr         $ra
    /* E6DF4 800F65F4 8000BD27 */   addiu     $sp, $sp, 0x80
endlabel __muldf3
