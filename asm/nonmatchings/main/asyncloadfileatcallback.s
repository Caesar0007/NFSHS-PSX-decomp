.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching asyncloadfileatcallback, 0xB4

glabel asyncloadfileatcallback
    /* E1B88 800F1388 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* E1B8C 800F138C 1400B1AF */  sw         $s1, 0x14($sp)
    /* E1B90 800F1390 21888000 */  addu       $s1, $a0, $zero
    /* E1B94 800F1394 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* E1B98 800F1398 2198A000 */  addu       $s3, $a1, $zero
    /* E1B9C 800F139C 1800B2AF */  sw         $s2, 0x18($sp)
    /* E1BA0 800F13A0 2190C000 */  addu       $s2, $a2, $zero
    /* E1BA4 800F13A4 1480043C */  lui        $a0, %hi(D_8013DEA0)
    /* E1BA8 800F13A8 A0DE8424 */  addiu      $a0, $a0, %lo(D_8013DEA0)
    /* E1BAC 800F13AC 2000BFAF */  sw         $ra, 0x20($sp)
    /* E1BB0 800F13B0 DDC2030C */  jal        func_800F0B74
    /* E1BB4 800F13B4 1000B0AF */   sw        $s0, 0x10($sp)
    /* E1BB8 800F13B8 21804000 */  addu       $s0, $v0, $zero
    /* E1BBC 800F13BC 18000012 */  beqz       $s0, .L800F1420
    /* E1BC0 800F13C0 21100000 */   addu      $v0, $zero, $zero
    /* E1BC4 800F13C4 F0C2030C */  jal        func_800F0BC0
    /* E1BC8 800F13C8 21200002 */   addu      $a0, $s0, $zero
    /* E1BCC 800F13CC 21202002 */  addu       $a0, $s1, $zero
    /* E1BD0 800F13D0 01000524 */  addiu      $a1, $zero, 0x1
    /* E1BD4 800F13D4 64000624 */  addiu      $a2, $zero, 0x64
    /* E1BD8 800F13D8 21380002 */  addu       $a3, $s0, $zero
    /* E1BDC 800F13DC 080000AE */  sw         $zero, 0x8($s0)
    /* E1BE0 800F13E0 0C0000AE */  sw         $zero, 0xC($s0)
    /* E1BE4 800F13E4 100000AE */  sw         $zero, 0x10($s0)
    /* E1BE8 800F13E8 140012AE */  sw         $s2, 0x14($s0)
    /* E1BEC 800F13EC 200000AE */  sw         $zero, 0x20($s0)
    /* E1BF0 800F13F0 DBB0030C */  jal        FILE_open
    /* E1BF4 800F13F4 280013AE */   sw        $s3, 0x28($s0)
    /* E1BF8 800F13F8 08004010 */  beqz       $v0, .L800F141C
    /* E1BFC 800F13FC 180002AE */   sw        $v0, 0x18($s0)
    /* E1C00 800F1400 21204000 */  addu       $a0, $v0, $zero
    /* E1C04 800F1404 0F80053C */  lui        $a1, %hi(func_800F0F18)
    /* E1C08 800F1408 93AF030C */  jal        FILE_callbackop
    /* E1C0C 800F140C 180FA524 */   addiu     $a1, $a1, %lo(func_800F0F18)
    /* E1C10 800F1410 0000028E */  lw         $v0, 0x0($s0)
    /* E1C14 800F1414 08C50308 */  j          .L800F1420
    /* E1C18 800F1418 00000000 */   nop
  .L800F141C:
    /* E1C1C 800F141C 21100000 */  addu       $v0, $zero, $zero
  .L800F1420:
    /* E1C20 800F1420 2000BF8F */  lw         $ra, 0x20($sp)
    /* E1C24 800F1424 1C00B38F */  lw         $s3, 0x1C($sp)
    /* E1C28 800F1428 1800B28F */  lw         $s2, 0x18($sp)
    /* E1C2C 800F142C 1400B18F */  lw         $s1, 0x14($sp)
    /* E1C30 800F1430 1000B08F */  lw         $s0, 0x10($sp)
    /* E1C34 800F1434 0800E003 */  jr         $ra
    /* E1C38 800F1438 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel asyncloadfileatcallback
