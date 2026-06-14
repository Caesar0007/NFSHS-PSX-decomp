.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching asyncloadfilecallback, 0xB8

glabel asyncloadfilecallback
    /* E1AB0 800F12B0 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* E1AB4 800F12B4 1400B1AF */  sw         $s1, 0x14($sp)
    /* E1AB8 800F12B8 21888000 */  addu       $s1, $a0, $zero
    /* E1ABC 800F12BC 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* E1AC0 800F12C0 2198A000 */  addu       $s3, $a1, $zero
    /* E1AC4 800F12C4 1800B2AF */  sw         $s2, 0x18($sp)
    /* E1AC8 800F12C8 2190C000 */  addu       $s2, $a2, $zero
    /* E1ACC 800F12CC 1480043C */  lui        $a0, %hi(D_8013DEA0)
    /* E1AD0 800F12D0 A0DE8424 */  addiu      $a0, $a0, %lo(D_8013DEA0)
    /* E1AD4 800F12D4 2000BFAF */  sw         $ra, 0x20($sp)
    /* E1AD8 800F12D8 DDC2030C */  jal        func_800F0B74
    /* E1ADC 800F12DC 1000B0AF */   sw        $s0, 0x10($sp)
    /* E1AE0 800F12E0 21804000 */  addu       $s0, $v0, $zero
    /* E1AE4 800F12E4 19000012 */  beqz       $s0, .L800F134C
    /* E1AE8 800F12E8 21100000 */   addu      $v0, $zero, $zero
    /* E1AEC 800F12EC F0C2030C */  jal        func_800F0BC0
    /* E1AF0 800F12F0 21200002 */   addu      $a0, $s0, $zero
    /* E1AF4 800F12F4 21202002 */  addu       $a0, $s1, $zero
    /* E1AF8 800F12F8 01000524 */  addiu      $a1, $zero, 0x1
    /* E1AFC 800F12FC 2110A000 */  addu       $v0, $a1, $zero
    /* E1B00 800F1300 64000624 */  addiu      $a2, $zero, 0x64
    /* E1B04 800F1304 21380002 */  addu       $a3, $s0, $zero
    /* E1B08 800F1308 080000AE */  sw         $zero, 0x8($s0)
    /* E1B0C 800F130C 0C0000AE */  sw         $zero, 0xC($s0)
    /* E1B10 800F1310 100002AE */  sw         $v0, 0x10($s0)
    /* E1B14 800F1314 140012AE */  sw         $s2, 0x14($s0)
    /* E1B18 800F1318 200000AE */  sw         $zero, 0x20($s0)
    /* E1B1C 800F131C DBB0030C */  jal        FILE_open
    /* E1B20 800F1320 240013AE */   sw        $s3, 0x24($s0)
    /* E1B24 800F1324 08004010 */  beqz       $v0, .L800F1348
    /* E1B28 800F1328 180002AE */   sw        $v0, 0x18($s0)
    /* E1B2C 800F132C 21204000 */  addu       $a0, $v0, $zero
    /* E1B30 800F1330 0F80053C */  lui        $a1, %hi(func_800F0F18)
    /* E1B34 800F1334 93AF030C */  jal        FILE_callbackop
    /* E1B38 800F1338 180FA524 */   addiu     $a1, $a1, %lo(func_800F0F18)
    /* E1B3C 800F133C 0000028E */  lw         $v0, 0x0($s0)
    /* E1B40 800F1340 D3C40308 */  j          .L800F134C
    /* E1B44 800F1344 00000000 */   nop
  .L800F1348:
    /* E1B48 800F1348 21100000 */  addu       $v0, $zero, $zero
  .L800F134C:
    /* E1B4C 800F134C 2000BF8F */  lw         $ra, 0x20($sp)
    /* E1B50 800F1350 1C00B38F */  lw         $s3, 0x1C($sp)
    /* E1B54 800F1354 1800B28F */  lw         $s2, 0x18($sp)
    /* E1B58 800F1358 1400B18F */  lw         $s1, 0x14($sp)
    /* E1B5C 800F135C 1000B08F */  lw         $s0, 0x10($sp)
    /* E1B60 800F1360 0800E003 */  jr         $ra
    /* E1B64 800F1364 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel asyncloadfilecallback
