.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching R3DCcar_ReadeMapData__Fv, 0xB8

glabel R3DCcar_ReadeMapData__Fv
    /* 9EDB0 800AE5B0 D0FEBD27 */  addiu      $sp, $sp, -0x130
    /* 9EDB4 800AE5B4 1000A427 */  addiu      $a0, $sp, 0x10
    /* 9EDB8 800AE5B8 0580053C */  lui        $a1, %hi(D_800563FC)
    /* 9EDBC 800AE5BC 1180023C */  lui        $v0, %hi(D_801164CC)
    /* 9EDC0 800AE5C0 CC64468C */  lw         $a2, %lo(D_801164CC)($v0)
    /* 9EDC4 800AE5C4 FC63A524 */  addiu      $a1, $a1, %lo(D_800563FC)
    /* 9EDC8 800AE5C8 2001B2AF */  sw         $s2, 0x120($sp)
    /* 9EDCC 800AE5CC 21900000 */  addu       $s2, $zero, $zero
    /* 9EDD0 800AE5D0 1C01B1AF */  sw         $s1, 0x11C($sp)
    /* 9EDD4 800AE5D4 1001B127 */  addiu      $s1, $sp, 0x110
    /* 9EDD8 800AE5D8 2801BFAF */  sw         $ra, 0x128($sp)
    /* 9EDDC 800AE5DC 2401B3AF */  sw         $s3, 0x124($sp)
    /* 9EDE0 800AE5E0 2F91030C */  jal        sprintf
    /* 9EDE4 800AE5E4 1801B0AF */   sw        $s0, 0x118($sp)
    /* 9EDE8 800AE5E8 1000A427 */  addiu      $a0, $sp, 0x10
    /* 9EDEC 800AE5EC FA95030C */  jal        loadfileadr
    /* 9EDF0 800AE5F0 10000524 */   addiu     $a1, $zero, 0x10
    /* 9EDF4 800AE5F4 1180033C */  lui        $v1, %hi(R3DCar_EnvMapInfo)
    /* 9EDF8 800AE5F8 BC6D7024 */  addiu      $s0, $v1, %lo(R3DCar_EnvMapInfo)
    /* 9EDFC 800AE5FC 21984000 */  addu       $s3, $v0, $zero
    /* 9EE00 800AE600 1001B3AF */  sw         $s3, 0x110($sp)
  .L800AE604:
    /* 9EE04 800AE604 BF47020C */  jal        Risk_ReadNextValue__FPPc
    /* 9EE08 800AE608 21202002 */   addu      $a0, $s1, $zero
    /* 9EE0C 800AE60C 21202002 */  addu       $a0, $s1, $zero
    /* 9EE10 800AE610 BF47020C */  jal        Risk_ReadNextValue__FPPc
    /* 9EE14 800AE614 000002AE */   sw        $v0, 0x0($s0)
    /* 9EE18 800AE618 21202002 */  addu       $a0, $s1, $zero
    /* 9EE1C 800AE61C BF47020C */  jal        Risk_ReadNextValue__FPPc
    /* 9EE20 800AE620 040002AE */   sw        $v0, 0x4($s0)
    /* 9EE24 800AE624 21202002 */  addu       $a0, $s1, $zero
    /* 9EE28 800AE628 BF47020C */  jal        Risk_ReadNextValue__FPPc
    /* 9EE2C 800AE62C 080002AE */   sw        $v0, 0x8($s0)
    /* 9EE30 800AE630 0C0002AE */  sw         $v0, 0xC($s0)
    /* 9EE34 800AE634 01005226 */  addiu      $s2, $s2, 0x1
    /* 9EE38 800AE638 1C00422A */  slti       $v0, $s2, 0x1C
    /* 9EE3C 800AE63C F1FF4014 */  bnez       $v0, .L800AE604
    /* 9EE40 800AE640 10001026 */   addiu     $s0, $s0, 0x10
    /* 9EE44 800AE644 5095030C */  jal        purgememadr
    /* 9EE48 800AE648 21206002 */   addu      $a0, $s3, $zero
    /* 9EE4C 800AE64C 2801BF8F */  lw         $ra, 0x128($sp)
    /* 9EE50 800AE650 2401B38F */  lw         $s3, 0x124($sp)
    /* 9EE54 800AE654 2001B28F */  lw         $s2, 0x120($sp)
    /* 9EE58 800AE658 1C01B18F */  lw         $s1, 0x11C($sp)
    /* 9EE5C 800AE65C 1801B08F */  lw         $s0, 0x118($sp)
    /* 9EE60 800AE660 0800E003 */  jr         $ra
    /* 9EE64 800AE664 3001BD27 */   addiu     $sp, $sp, 0x130
endlabel R3DCcar_ReadeMapData__Fv
