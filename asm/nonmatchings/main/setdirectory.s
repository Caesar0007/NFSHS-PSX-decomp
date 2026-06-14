.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching setdirectory, 0x114

glabel setdirectory
    /* E42CC 800F3ACC E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* E42D0 800F3AD0 1800B2AF */  sw         $s2, 0x18($sp)
    /* E42D4 800F3AD4 21908000 */  addu       $s2, $a0, $zero
    /* E42D8 800F3AD8 1400B1AF */  sw         $s1, 0x14($sp)
    /* E42DC 800F3ADC 21880000 */  addu       $s1, $zero, $zero
    /* E42E0 800F3AE0 E817858F */  lw         $a1, %gp_rel(D_8013DD34)($gp)
    /* E42E4 800F3AE4 06000624 */  addiu      $a2, $zero, 0x6
    /* E42E8 800F3AE8 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* E42EC 800F3AEC 74AC030C */  jal        strncmp
    /* E42F0 800F3AF0 1000B0AF */   sw        $s0, 0x10($sp)
    /* E42F4 800F3AF4 0E004014 */  bnez       $v0, .L800F3B30
    /* E42F8 800F3AF8 21204002 */   addu      $a0, $s2, $zero
    /* E42FC 800F3AFC 1480023C */  lui        $v0, %hi(availablefilesystems)
    /* E4300 800F3B00 60DC428C */  lw         $v0, %lo(availablefilesystems)($v0)
    /* E4304 800F3B04 02000324 */  addiu      $v1, $zero, 0x2
    /* E4308 800F3B08 03004230 */  andi       $v0, $v0, 0x3
    /* E430C 800F3B0C 2E004310 */  beq        $v0, $v1, .L800F3BC8
    /* E4310 800F3B10 00000000 */   nop
    /* E4314 800F3B14 DDA7030C */  jal        strlen
    /* E4318 800F3B18 21204002 */   addu      $a0, $s2, $zero
    /* E431C 800F3B1C 0700422C */  sltiu      $v0, $v0, 0x7
    /* E4320 800F3B20 29004010 */  beqz       $v0, .L800F3BC8
    /* E4324 800F3B24 06001124 */   addiu     $s1, $zero, 0x6
    /* E4328 800F3B28 D8CE0308 */  j          .L800F3B60
    /* E432C 800F3B2C 01000224 */   addiu     $v0, $zero, 0x1
  .L800F3B30:
    /* E4330 800F3B30 F417858F */  lw         $a1, %gp_rel(D_8013DD40)($gp)
    /* E4334 800F3B34 74AC030C */  jal        strncmp
    /* E4338 800F3B38 04000624 */   addiu     $a2, $zero, 0x4
    /* E433C 800F3B3C 0A004014 */  bnez       $v0, .L800F3B68
    /* E4340 800F3B40 00000000 */   nop
    /* E4344 800F3B44 1480023C */  lui        $v0, %hi(availablefilesystems)
    /* E4348 800F3B48 60DC428C */  lw         $v0, %lo(availablefilesystems)($v0)
    /* E434C 800F3B4C 00000000 */  nop
    /* E4350 800F3B50 02004230 */  andi       $v0, $v0, 0x2
    /* E4354 800F3B54 1C004010 */  beqz       $v0, .L800F3BC8
    /* E4358 800F3B58 04001124 */   addiu     $s1, $zero, 0x4
    /* E435C 800F3B5C 02000224 */  addiu      $v0, $zero, 0x2
  .L800F3B60:
    /* E4360 800F3B60 1480013C */  lui        $at, %hi(currentfilesystem)
    /* E4364 800F3B64 5CDC22AC */  sw         $v0, %lo(currentfilesystem)($at)
  .L800F3B68:
    /* E4368 800F3B68 1480033C */  lui        $v1, %hi(currentfilesystem)
    /* E436C 800F3B6C 5CDC638C */  lw         $v1, %lo(currentfilesystem)($v1)
    /* E4370 800F3B70 02000224 */  addiu      $v0, $zero, 0x2
    /* E4374 800F3B74 14006214 */  bne        $v1, $v0, .L800F3BC8
    /* E4378 800F3B78 1480023C */   lui       $v0, %hi(currentdirectory)
    /* E437C 800F3B7C 14045024 */  addiu      $s0, $v0, %lo(currentdirectory)
    /* E4380 800F3B80 21200002 */  addu       $a0, $s0, $zero
    /* E4384 800F3B84 CA96030C */  jal        strcpy
    /* E4388 800F3B88 21285102 */   addu      $a1, $s2, $s1
    /* E438C 800F3B8C 3F000292 */  lbu        $v0, 0x3F($s0)
    /* E4390 800F3B90 00000000 */  nop
    /* E4394 800F3B94 0C004014 */  bnez       $v0, .L800F3BC8
    /* E4398 800F3B98 00000000 */   nop
    /* E439C 800F3B9C DDA7030C */  jal        strlen
    /* E43A0 800F3BA0 21200002 */   addu      $a0, $s0, $zero
    /* E43A4 800F3BA4 08004018 */  blez       $v0, .L800F3BC8
    /* E43A8 800F3BA8 21105000 */   addu      $v0, $v0, $s0
    /* E43AC 800F3BAC 00004390 */  lbu        $v1, 0x0($v0)
    /* E43B0 800F3BB0 5C000224 */  addiu      $v0, $zero, 0x5C
    /* E43B4 800F3BB4 04006210 */  beq        $v1, $v0, .L800F3BC8
    /* E43B8 800F3BB8 21200002 */   addu      $a0, $s0, $zero
    /* E43BC 800F3BBC 1480053C */  lui        $a1, %hi(D_8013DD44)
    /* E43C0 800F3BC0 3A9E030C */  jal        strcat
    /* E43C4 800F3BC4 44DDA524 */   addiu     $a1, $a1, %lo(D_8013DD44)
  .L800F3BC8:
    /* E43C8 800F3BC8 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* E43CC 800F3BCC 1800B28F */  lw         $s2, 0x18($sp)
    /* E43D0 800F3BD0 1400B18F */  lw         $s1, 0x14($sp)
    /* E43D4 800F3BD4 1000B08F */  lw         $s0, 0x10($sp)
    /* E43D8 800F3BD8 0800E003 */  jr         $ra
    /* E43DC 800F3BDC 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel setdirectory
