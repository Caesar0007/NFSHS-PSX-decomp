.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FEInput_GetDebounceKey__Fii, 0x114

glabel FEInput_GetDebounceKey__Fii
    /* 14374 80023B74 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 14378 80023B78 1000B0AF */  sw         $s0, 0x10($sp)
    /* 1437C 80023B7C 21808000 */  addu       $s0, $a0, $zero
    /* 14380 80023B80 1400B1AF */  sw         $s1, 0x14($sp)
    /* 14384 80023B84 1800BFAF */  sw         $ra, 0x18($sp)
    /* 14388 80023B88 3E8E000C */  jal        FEInput_GetNoDebounceKey__Fii
    /* 1438C 80023B8C 2188A000 */   addu      $s1, $a1, $zero
    /* 14390 80023B90 2F004010 */  beqz       $v0, .L80023C50
    /* 14394 80023B94 0580023C */   lui       $v0, %hi(D_80052B60)
    /* 14398 80023B98 602B4224 */  addiu      $v0, $v0, %lo(D_80052B60)
    /* 1439C 80023B9C 80181100 */  sll        $v1, $s1, 2
    /* 143A0 80023BA0 21206200 */  addu       $a0, $v1, $v0
    /* 143A4 80023BA4 0000838C */  lw         $v1, 0x0($a0)
    /* 143A8 80023BA8 00000000 */  nop
    /* 143AC 80023BAC 24107000 */  and        $v0, $v1, $s0
    /* 143B0 80023BB0 21004010 */  beqz       $v0, .L80023C38
    /* 143B4 80023BB4 1480023C */   lui       $v0, %hi(ticks)
    /* 143B8 80023BB8 ACDC448C */  lw         $a0, %lo(ticks)($v0)
    /* 143BC 80023BBC 10000224 */  addiu      $v0, $zero, 0x10
    /* 143C0 80023BC0 07000212 */  beq        $s0, $v0, .L80023BE0
    /* 143C4 80023BC4 80000224 */   addiu     $v0, $zero, 0x80
    /* 143C8 80023BC8 05000212 */  beq        $s0, $v0, .L80023BE0
    /* 143CC 80023BCC 20000224 */   addiu     $v0, $zero, 0x20
    /* 143D0 80023BD0 03000212 */  beq        $s0, $v0, .L80023BE0
    /* 143D4 80023BD4 40000224 */   addiu     $v0, $zero, 0x40
    /* 143D8 80023BD8 26000216 */  bne        $s0, $v0, .L80023C74
    /* 143DC 80023BDC 21100000 */   addu      $v0, $zero, $zero
  .L80023BE0:
    /* 143E0 80023BE0 0580053C */  lui        $a1, %hi(D_80051738)
    /* 143E4 80023BE4 3817A28C */  lw         $v0, %lo(D_80051738)($a1)
    /* 143E8 80023BE8 00000000 */  nop
    /* 143EC 80023BEC 0A004014 */  bnez       $v0, .L80023C18
    /* 143F0 80023BF0 2A108200 */   slt       $v0, $a0, $v0
    /* 143F4 80023BF4 0580023C */  lui        $v0, %hi(FeTools_gScrollTicksOut)
    /* 143F8 80023BF8 D017428C */  lw         $v0, %lo(FeTools_gScrollTicksOut)($v0)
    /* 143FC 80023BFC 00000000 */  nop
    /* 14400 80023C00 21108200 */  addu       $v0, $a0, $v0
    /* 14404 80023C04 0A004224 */  addiu      $v0, $v0, 0xA
    /* 14408 80023C08 3817A2AC */  sw         $v0, %lo(D_80051738)($a1)
    /* 1440C 80023C0C 3817A28C */  lw         $v0, %lo(D_80051738)($a1)
    /* 14410 80023C10 00000000 */  nop
    /* 14414 80023C14 2A108200 */  slt        $v0, $a0, $v0
  .L80023C18:
    /* 14418 80023C18 16004014 */  bnez       $v0, .L80023C74
    /* 1441C 80023C1C 21100000 */   addu      $v0, $zero, $zero
    /* 14420 80023C20 0580023C */  lui        $v0, %hi(FeTools_gScrollTicksOut)
    /* 14424 80023C24 D017438C */  lw         $v1, %lo(FeTools_gScrollTicksOut)($v0)
    /* 14428 80023C28 01000224 */  addiu      $v0, $zero, 0x1
    /* 1442C 80023C2C 21188300 */  addu       $v1, $a0, $v1
    /* 14430 80023C30 1D8F0008 */  j          .L80023C74
    /* 14434 80023C34 3817A3AC */   sw        $v1, %lo(D_80051738)($a1)
  .L80023C38:
    /* 14438 80023C38 01000224 */  addiu      $v0, $zero, 0x1
    /* 1443C 80023C3C 25187000 */  or         $v1, $v1, $s0
    /* 14440 80023C40 000083AC */  sw         $v1, 0x0($a0)
    /* 14444 80023C44 0580033C */  lui        $v1, %hi(D_80051738)
    /* 14448 80023C48 1D8F0008 */  j          .L80023C74
    /* 1444C 80023C4C 381760AC */   sw        $zero, %lo(D_80051738)($v1)
  .L80023C50:
    /* 14450 80023C50 21100000 */  addu       $v0, $zero, $zero
    /* 14454 80023C54 0580033C */  lui        $v1, %hi(D_80052B60)
    /* 14458 80023C58 602B6324 */  addiu      $v1, $v1, %lo(D_80052B60)
    /* 1445C 80023C5C 80201100 */  sll        $a0, $s1, 2
    /* 14460 80023C60 21208300 */  addu       $a0, $a0, $v1
    /* 14464 80023C64 0000838C */  lw         $v1, 0x0($a0)
    /* 14468 80023C68 27281000 */  nor        $a1, $zero, $s0
    /* 1446C 80023C6C 24186500 */  and        $v1, $v1, $a1
    /* 14470 80023C70 000083AC */  sw         $v1, 0x0($a0)
  .L80023C74:
    /* 14474 80023C74 1800BF8F */  lw         $ra, 0x18($sp)
    /* 14478 80023C78 1400B18F */  lw         $s1, 0x14($sp)
    /* 1447C 80023C7C 1000B08F */  lw         $s0, 0x10($sp)
    /* 14480 80023C80 0800E003 */  jr         $ra
    /* 14484 80023C84 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel FEInput_GetDebounceKey__Fii
