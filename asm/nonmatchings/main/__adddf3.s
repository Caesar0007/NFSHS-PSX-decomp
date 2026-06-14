.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __adddf3, 0x374

glabel __adddf3
    /* E6254 800F5A54 A0FFBD27 */  addiu      $sp, $sp, -0x60
    /* E6258 800F5A58 3000A0AF */  sw         $zero, 0x30($sp)
    /* E625C 800F5A5C 5400B7AF */  sw         $s7, 0x54($sp)
    /* E6260 800F5A60 21B80000 */  addu       $s7, $zero, $zero
    /* E6264 800F5A64 4400B3AF */  sw         $s3, 0x44($sp)
    /* E6268 800F5A68 4000B2AF */  sw         $s2, 0x40($sp)
    /* E626C 800F5A6C 21908000 */  addu       $s2, $a0, $zero
    /* E6270 800F5A70 2198A000 */  addu       $s3, $a1, $zero
    /* E6274 800F5A74 3C00B1AF */  sw         $s1, 0x3C($sp)
    /* E6278 800F5A78 3800B0AF */  sw         $s0, 0x38($sp)
    /* E627C 800F5A7C 2180C000 */  addu       $s0, $a2, $zero
    /* E6280 800F5A80 2188E000 */  addu       $s1, $a3, $zero
    /* E6284 800F5A84 FF7F023C */  lui        $v0, (0x7FFFFFFF >> 16)
    /* E6288 800F5A88 FFFF4234 */  ori        $v0, $v0, (0x7FFFFFFF & 0xFFFF)
    /* E628C 800F5A8C 24106202 */  and        $v0, $s3, $v0
    /* E6290 800F5A90 5800BFAF */  sw         $ra, 0x58($sp)
    /* E6294 800F5A94 5000B6AF */  sw         $s6, 0x50($sp)
    /* E6298 800F5A98 4C00B5AF */  sw         $s5, 0x4C($sp)
    /* E629C 800F5A9C 4800B4AF */  sw         $s4, 0x48($sp)
    /* E62A0 800F5AA0 06004014 */  bnez       $v0, .L800F5ABC
    /* E62A4 800F5AA4 3400A0AF */   sw        $zero, 0x34($sp)
    /* E62A8 800F5AA8 05004016 */  bnez       $s2, .L800F5AC0
    /* E62AC 800F5AAC FF7F023C */   lui       $v0, (0x7FFFFFFF >> 16)
    /* E62B0 800F5AB0 2110C000 */  addu       $v0, $a2, $zero
    /* E62B4 800F5AB4 67D70308 */  j          .L800F5D9C
    /* E62B8 800F5AB8 2118E000 */   addu      $v1, $a3, $zero
  .L800F5ABC:
    /* E62BC 800F5ABC FF7F023C */  lui        $v0, (0x7FFFFFFF >> 16)
  .L800F5AC0:
    /* E62C0 800F5AC0 FFFF4234 */  ori        $v0, $v0, (0x7FFFFFFF & 0xFFFF)
    /* E62C4 800F5AC4 24102202 */  and        $v0, $s1, $v0
    /* E62C8 800F5AC8 03004014 */  bnez       $v0, .L800F5AD8
    /* E62CC 800F5ACC 03151300 */   sra       $v0, $s3, 20
    /* E62D0 800F5AD0 B0000012 */  beqz       $s0, .L800F5D94
    /* E62D4 800F5AD4 00000000 */   nop
  .L800F5AD8:
    /* E62D8 800F5AD8 FF075430 */  andi       $s4, $v0, 0x7FF
    /* E62DC 800F5ADC 03151100 */  sra        $v0, $s1, 20
    /* E62E0 800F5AE0 FF075630 */  andi       $s6, $v0, 0x7FF
    /* E62E4 800F5AE4 3600C226 */  addiu      $v0, $s6, 0x36
    /* E62E8 800F5AE8 2A105400 */  slt        $v0, $v0, $s4
    /* E62EC 800F5AEC A9004014 */  bnez       $v0, .L800F5D94
    /* E62F0 800F5AF0 36008226 */   addiu     $v0, $s4, 0x36
    /* E62F4 800F5AF4 2A105600 */  slt        $v0, $v0, $s6
    /* E62F8 800F5AF8 04004010 */  beqz       $v0, .L800F5B0C
    /* E62FC 800F5AFC 0F00023C */   lui       $v0, (0xFFFFF >> 16)
    /* E6300 800F5B00 21100002 */  addu       $v0, $s0, $zero
    /* E6304 800F5B04 67D70308 */  j          .L800F5D9C
    /* E6308 800F5B08 21182002 */   addu      $v1, $s1, $zero
  .L800F5B0C:
    /* E630C 800F5B0C FFFF4234 */  ori        $v0, $v0, (0xFFFFF & 0xFFFF)
    /* E6310 800F5B10 24186202 */  and        $v1, $s3, $v0
    /* E6314 800F5B14 1000043C */  lui        $a0, (0x100000 >> 16)
    /* E6318 800F5B18 25306400 */  or         $a2, $v1, $a0
    /* E631C 800F5B1C 24102202 */  and        $v0, $s1, $v0
    /* E6320 800F5B20 25104400 */  or         $v0, $v0, $a0
    /* E6324 800F5B24 0080153C */  lui        $s5, (0x80000000 >> 16)
    /* E6328 800F5B28 1C00A6AF */  sw         $a2, 0x1C($sp)
    /* E632C 800F5B2C 1800B2AF */  sw         $s2, 0x18($sp)
    /* E6330 800F5B30 2400A2AF */  sw         $v0, 0x24($sp)
    /* E6334 800F5B34 04006106 */  bgez       $s3, .L800F5B48
    /* E6338 800F5B38 2000B0AF */   sw        $s0, 0x20($sp)
    /* E633C 800F5B3C 1800A427 */  addiu      $a0, $sp, 0x18
    /* E6340 800F5B40 C01B040C */  jal        _mainasu
    /* E6344 800F5B44 21284002 */   addu      $a1, $s2, $zero
  .L800F5B48:
    /* E6348 800F5B48 24103502 */  and        $v0, $s1, $s5
    /* E634C 800F5B4C 06004010 */  beqz       $v0, .L800F5B68
    /* E6350 800F5B50 1800A427 */   addiu     $a0, $sp, 0x18
    /* E6354 800F5B54 2000A58F */  lw         $a1, 0x20($sp)
    /* E6358 800F5B58 2400A68F */  lw         $a2, 0x24($sp)
    /* E635C 800F5B5C C01B040C */  jal        _mainasu
    /* E6360 800F5B60 2000A427 */   addiu     $a0, $sp, 0x20
    /* E6364 800F5B64 1800A427 */  addiu      $a0, $sp, 0x18
  .L800F5B68:
    /* E6368 800F5B68 09001024 */  addiu      $s0, $zero, 0x9
    /* E636C 800F5B6C 1000B0AF */  sw         $s0, 0x10($sp)
    /* E6370 800F5B70 1800A68F */  lw         $a2, 0x18($sp)
    /* E6374 800F5B74 1C00A78F */  lw         $a3, 0x1C($sp)
    /* E6378 800F5B78 901B040C */  jal        _dbl_shift
    /* E637C 800F5B7C 21280000 */   addu      $a1, $zero, $zero
    /* E6380 800F5B80 2000B127 */  addiu      $s1, $sp, 0x20
    /* E6384 800F5B84 21202002 */  addu       $a0, $s1, $zero
    /* E6388 800F5B88 1000B0AF */  sw         $s0, 0x10($sp)
    /* E638C 800F5B8C 2000A68F */  lw         $a2, 0x20($sp)
    /* E6390 800F5B90 2400A78F */  lw         $a3, 0x24($sp)
    /* E6394 800F5B94 901B040C */  jal        _dbl_shift
    /* E6398 800F5B98 21280000 */   addu      $a1, $zero, $zero
    /* E639C 800F5B9C 2A10D402 */  slt        $v0, $s6, $s4
    /* E63A0 800F5BA0 07004010 */  beqz       $v0, .L800F5BC0
    /* E63A4 800F5BA4 23109602 */   subu      $v0, $s4, $s6
    /* E63A8 800F5BA8 21202002 */  addu       $a0, $s1, $zero
    /* E63AC 800F5BAC 1000A2AF */  sw         $v0, 0x10($sp)
    /* E63B0 800F5BB0 2000A68F */  lw         $a2, 0x20($sp)
    /* E63B4 800F5BB4 2400A78F */  lw         $a3, 0x24($sp)
    /* E63B8 800F5BB8 F7D60308 */  j          .L800F5BDC
    /* E63BC 800F5BBC 01000524 */   addiu     $a1, $zero, 0x1
  .L800F5BC0:
    /* E63C0 800F5BC0 1800A427 */  addiu      $a0, $sp, 0x18
    /* E63C4 800F5BC4 01000524 */  addiu      $a1, $zero, 0x1
    /* E63C8 800F5BC8 2310D402 */  subu       $v0, $s6, $s4
    /* E63CC 800F5BCC 1000A2AF */  sw         $v0, 0x10($sp)
    /* E63D0 800F5BD0 1800A68F */  lw         $a2, 0x18($sp)
    /* E63D4 800F5BD4 1C00A78F */  lw         $a3, 0x1C($sp)
    /* E63D8 800F5BD8 21A0C002 */  addu       $s4, $s6, $zero
  .L800F5BDC:
    /* E63DC 800F5BDC 901B040C */  jal        _dbl_shift
    /* E63E0 800F5BE0 00000000 */   nop
    /* E63E4 800F5BE4 2400A28F */  lw         $v0, 0x24($sp)
    /* E63E8 800F5BE8 00000000 */  nop
    /* E63EC 800F5BEC 1000A2AF */  sw         $v0, 0x10($sp)
    /* E63F0 800F5BF0 2000A78F */  lw         $a3, 0x20($sp)
    /* E63F4 800F5BF4 1800A58F */  lw         $a1, 0x18($sp)
    /* E63F8 800F5BF8 1C00A68F */  lw         $a2, 0x1C($sp)
    /* E63FC 800F5BFC DC1B040C */  jal        _add_mant_d
    /* E6400 800F5C00 1800A427 */   addiu     $a0, $sp, 0x18
    /* E6404 800F5C04 1C00A68F */  lw         $a2, 0x1C($sp)
    /* E6408 800F5C08 00000000 */  nop
    /* E640C 800F5C0C 0B00C004 */  bltz       $a2, .L800F5C3C
    /* E6410 800F5C10 00000000 */   nop
    /* E6414 800F5C14 0D00C014 */  bnez       $a2, .L800F5C4C
    /* E6418 800F5C18 00000000 */   nop
    /* E641C 800F5C1C 1800A28F */  lw         $v0, 0x18($sp)
    /* E6420 800F5C20 00000000 */  nop
    /* E6424 800F5C24 09004014 */  bnez       $v0, .L800F5C4C
    /* E6428 800F5C28 00000000 */   nop
    /* E642C 800F5C2C 3000A28F */  lw         $v0, 0x30($sp)
    /* E6430 800F5C30 3400A38F */  lw         $v1, 0x34($sp)
    /* E6434 800F5C34 67D70308 */  j          .L800F5D9C
    /* E6438 800F5C38 00000000 */   nop
  .L800F5C3C:
    /* E643C 800F5C3C 1800A427 */  addiu      $a0, $sp, 0x18
    /* E6440 800F5C40 1800A58F */  lw         $a1, 0x18($sp)
    /* E6444 800F5C44 C01B040C */  jal        _mainasu
    /* E6448 800F5C48 0080173C */   lui       $s7, (0x80000000 >> 16)
  .L800F5C4C:
    /* E644C 800F5C4C 1C00A28F */  lw         $v0, 0x1C($sp)
    /* E6450 800F5C50 00E0033C */  lui        $v1, (0xE0000000 >> 16)
    /* E6454 800F5C54 24104300 */  and        $v0, $v0, $v1
    /* E6458 800F5C58 0D004014 */  bnez       $v0, .L800F5C90
    /* E645C 800F5C5C 00E0103C */   lui       $s0, (0xE0000000 >> 16)
    /* E6460 800F5C60 01001124 */  addiu      $s1, $zero, 0x1
  .L800F5C64:
    /* E6464 800F5C64 1800A427 */  addiu      $a0, $sp, 0x18
    /* E6468 800F5C68 1000B1AF */  sw         $s1, 0x10($sp)
    /* E646C 800F5C6C 1800A68F */  lw         $a2, 0x18($sp)
    /* E6470 800F5C70 1C00A78F */  lw         $a3, 0x1C($sp)
    /* E6474 800F5C74 901B040C */  jal        _dbl_shift
    /* E6478 800F5C78 21280000 */   addu      $a1, $zero, $zero
    /* E647C 800F5C7C 1C00A28F */  lw         $v0, 0x1C($sp)
    /* E6480 800F5C80 00000000 */  nop
    /* E6484 800F5C84 24105000 */  and        $v0, $v0, $s0
    /* E6488 800F5C88 F6FF4010 */  beqz       $v0, .L800F5C64
    /* E648C 800F5C8C FFFF9426 */   addiu     $s4, $s4, -0x1
  .L800F5C90:
    /* E6490 800F5C90 1C00A28F */  lw         $v0, 0x1C($sp)
    /* E6494 800F5C94 0040103C */  lui        $s0, (0x40000000 >> 16)
    /* E6498 800F5C98 24105000 */  and        $v0, $v0, $s0
    /* E649C 800F5C9C 08004010 */  beqz       $v0, .L800F5CC0
    /* E64A0 800F5CA0 1800A427 */   addiu     $a0, $sp, 0x18
    /* E64A4 800F5CA4 01000524 */  addiu      $a1, $zero, 0x1
    /* E64A8 800F5CA8 01000224 */  addiu      $v0, $zero, 0x1
    /* E64AC 800F5CAC 1000A2AF */  sw         $v0, 0x10($sp)
    /* E64B0 800F5CB0 1800A68F */  lw         $a2, 0x18($sp)
    /* E64B4 800F5CB4 1C00A78F */  lw         $a3, 0x1C($sp)
    /* E64B8 800F5CB8 901B040C */  jal        _dbl_shift
    /* E64BC 800F5CBC 01009426 */   addiu     $s4, $s4, 0x1
  .L800F5CC0:
    /* E64C0 800F5CC0 1800A28F */  lw         $v0, 0x18($sp)
    /* E64C4 800F5CC4 FF000324 */  addiu      $v1, $zero, 0xFF
    /* E64C8 800F5CC8 00024230 */  andi       $v0, $v0, 0x200
    /* E64CC 800F5CCC 02004010 */  beqz       $v0, .L800F5CD8
    /* E64D0 800F5CD0 2C00A0AF */   sw        $zero, 0x2C($sp)
    /* E64D4 800F5CD4 00010324 */  addiu      $v1, $zero, 0x100
  .L800F5CD8:
    /* E64D8 800F5CD8 2800A3AF */  sw         $v1, 0x28($sp)
    /* E64DC 800F5CDC 1000A0AF */  sw         $zero, 0x10($sp)
    /* E64E0 800F5CE0 2800A78F */  lw         $a3, 0x28($sp)
    /* E64E4 800F5CE4 1800A58F */  lw         $a1, 0x18($sp)
    /* E64E8 800F5CE8 1C00A68F */  lw         $a2, 0x1C($sp)
    /* E64EC 800F5CEC DC1B040C */  jal        _add_mant_d
    /* E64F0 800F5CF0 1800A427 */   addiu     $a0, $sp, 0x18
    /* E64F4 800F5CF4 1C00A28F */  lw         $v0, 0x1C($sp)
    /* E64F8 800F5CF8 00000000 */  nop
    /* E64FC 800F5CFC 24105000 */  and        $v0, $v0, $s0
    /* E6500 800F5D00 08004010 */  beqz       $v0, .L800F5D24
    /* E6504 800F5D04 1800A427 */   addiu     $a0, $sp, 0x18
    /* E6508 800F5D08 01000524 */  addiu      $a1, $zero, 0x1
    /* E650C 800F5D0C 01000224 */  addiu      $v0, $zero, 0x1
    /* E6510 800F5D10 1000A2AF */  sw         $v0, 0x10($sp)
    /* E6514 800F5D14 1800A68F */  lw         $a2, 0x18($sp)
    /* E6518 800F5D18 1C00A78F */  lw         $a3, 0x1C($sp)
    /* E651C 800F5D1C 901B040C */  jal        _dbl_shift
    /* E6520 800F5D20 01009426 */   addiu     $s4, $s4, 0x1
  .L800F5D24:
    /* E6524 800F5D24 1800A427 */  addiu      $a0, $sp, 0x18
    /* E6528 800F5D28 09000224 */  addiu      $v0, $zero, 0x9
    /* E652C 800F5D2C 1000A2AF */  sw         $v0, 0x10($sp)
    /* E6530 800F5D30 1800A68F */  lw         $a2, 0x18($sp)
    /* E6534 800F5D34 1C00A78F */  lw         $a3, 0x1C($sp)
    /* E6538 800F5D38 901B040C */  jal        _dbl_shift
    /* E653C 800F5D3C 01000524 */   addiu     $a1, $zero, 0x1
    /* E6540 800F5D40 EFFF033C */  lui        $v1, (0xFFEFFFFF >> 16)
    /* E6544 800F5D44 1C00A28F */  lw         $v0, 0x1C($sp)
    /* E6548 800F5D48 FFFF6334 */  ori        $v1, $v1, (0xFFEFFFFF & 0xFFFF)
    /* E654C 800F5D4C 24184300 */  and        $v1, $v0, $v1
    /* E6550 800F5D50 FF07822A */  slti       $v0, $s4, 0x7FF
    /* E6554 800F5D54 0A004014 */  bnez       $v0, .L800F5D80
    /* E6558 800F5D58 1C00A3AF */   sw        $v1, 0x1C($sp)
    /* E655C 800F5D5C 22000424 */  addiu      $a0, $zero, 0x22
    /* E6560 800F5D60 951A040C */  jal        _err_math
    /* E6564 800F5D64 0B000524 */   addiu     $a1, $zero, 0xB
    /* E6568 800F5D68 0200E012 */  beqz       $s7, .L800F5D74
    /* E656C 800F5D6C F07F023C */   lui       $v0, (0x7FF00000 >> 16)
    /* E6570 800F5D70 F0FF023C */  lui        $v0, (0xFFF00000 >> 16)
  .L800F5D74:
    /* E6574 800F5D74 21984000 */  addu       $s3, $v0, $zero
    /* E6578 800F5D78 65D70308 */  j          .L800F5D94
    /* E657C 800F5D7C 21900000 */   addu      $s2, $zero, $zero
  .L800F5D80:
    /* E6580 800F5D80 00151400 */  sll        $v0, $s4, 20
    /* E6584 800F5D84 2510E202 */  or         $v0, $s7, $v0
    /* E6588 800F5D88 25984300 */  or         $s3, $v0, $v1
    /* E658C 800F5D8C 1800B28F */  lw         $s2, 0x18($sp)
    /* E6590 800F5D90 00000000 */  nop
  .L800F5D94:
    /* E6594 800F5D94 21104002 */  addu       $v0, $s2, $zero
    /* E6598 800F5D98 21186002 */  addu       $v1, $s3, $zero
  .L800F5D9C:
    /* E659C 800F5D9C 5800BF8F */  lw         $ra, 0x58($sp)
    /* E65A0 800F5DA0 5400B78F */  lw         $s7, 0x54($sp)
    /* E65A4 800F5DA4 5000B68F */  lw         $s6, 0x50($sp)
    /* E65A8 800F5DA8 4C00B58F */  lw         $s5, 0x4C($sp)
    /* E65AC 800F5DAC 4800B48F */  lw         $s4, 0x48($sp)
    /* E65B0 800F5DB0 4400B38F */  lw         $s3, 0x44($sp)
    /* E65B4 800F5DB4 4000B28F */  lw         $s2, 0x40($sp)
    /* E65B8 800F5DB8 3C00B18F */  lw         $s1, 0x3C($sp)
    /* E65BC 800F5DBC 3800B08F */  lw         $s0, 0x38($sp)
    /* E65C0 800F5DC0 0800E003 */  jr         $ra
    /* E65C4 800F5DC4 6000BD27 */   addiu     $sp, $sp, 0x60
endlabel __adddf3
    /* E65C8 800F5DC8 00000000 */  nop
    /* E65CC 800F5DCC 00000000 */  nop
    /* E65D0 800F5DD0 00000000 */  nop
