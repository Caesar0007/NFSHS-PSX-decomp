.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SavePinkSlipsCars__11tCarManagerR12tSaveCarInfoss, 0x15C

glabel SavePinkSlipsCars__11tCarManagerR12tSaveCarInfoss
    /* 740C 80016C0C 00FFBD27 */  addiu      $sp, $sp, -0x100
    /* 7410 80016C10 EC00B3AF */  sw         $s3, 0xEC($sp)
    /* 7414 80016C14 21988000 */  addu       $s3, $a0, $zero
    /* 7418 80016C18 F000B4AF */  sw         $s4, 0xF0($sp)
    /* 741C 80016C1C 21A0A000 */  addu       $s4, $a1, $zero
    /* 7420 80016C20 E800B2AF */  sw         $s2, 0xE8($sp)
    /* 7424 80016C24 2190C000 */  addu       $s2, $a2, $zero
    /* 7428 80016C28 F800B6AF */  sw         $s6, 0xF8($sp)
    /* 742C 80016C2C 21B04002 */  addu       $s6, $s2, $zero
    /* 7430 80016C30 F400B5AF */  sw         $s5, 0xF4($sp)
    /* 7434 80016C34 21A8E000 */  addu       $s5, $a3, $zero
    /* 7438 80016C38 003C0700 */  sll        $a3, $a3, 16
    /* 743C 80016C3C E400B1AF */  sw         $s1, 0xE4($sp)
    /* 7440 80016C40 038C0700 */  sra        $s1, $a3, 16
    /* 7444 80016C44 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 7448 80016C48 FC00BFAF */  sw         $ra, 0xFC($sp)
    /* 744C 80016C4C 0B002212 */  beq        $s1, $v0, .L80016C7C
    /* 7450 80016C50 E000B0AF */   sw        $s0, 0xE0($sp)
    /* 7454 80016C54 21282002 */  addu       $a1, $s1, $zero
    /* 7458 80016C58 1000A627 */  addiu      $a2, $sp, 0x10
    /* 745C 80016C5C 00841200 */  sll        $s0, $s2, 16
    /* 7460 80016C60 03841000 */  sra        $s0, $s0, 16
    /* 7464 80016C64 165C000C */  jal        GetPinkSlipsCar__11tCarManagersR8tCarInfos
    /* 7468 80016C68 21380002 */   addu      $a3, $s0, $zero
    /* 746C 80016C6C 21206002 */  addu       $a0, $s3, $zero
    /* 7470 80016C70 21282002 */  addu       $a1, $s1, $zero
    /* 7474 80016C74 EE59000C */  jal        RemoveFromPinkSlipsList__11tCarManagerss
    /* 7478 80016C78 21300002 */   addu      $a2, $s0, $zero
  .L80016C7C:
    /* 747C 80016C7C 00141200 */  sll        $v0, $s2, 16
    /* 7480 80016C80 03840200 */  sra        $s0, $v0, 16
    /* 7484 80016C84 C0211000 */  sll        $a0, $s0, 7
    /* 7488 80016C88 08018424 */  addiu      $a0, $a0, 0x108
    /* 748C 80016C8C 21206402 */  addu       $a0, $s3, $a0
    /* 7490 80016C90 21288002 */  addu       $a1, $s4, $zero
    /* 7494 80016C94 B798030C */  jal        blockmove
    /* 7498 80016C98 80000624 */   addiu     $a2, $zero, 0x80
    /* 749C 80016C9C 0000628E */  lw         $v0, 0x0($s3)
    /* 74A0 80016CA0 00000000 */  nop
    /* 74A4 80016CA4 11004010 */  beqz       $v0, .L80016CEC
    /* 74A8 80016CA8 21280000 */   addu      $a1, $zero, $zero
    /* 74AC 80016CAC 40101000 */  sll        $v0, $s0, 1
    /* 74B0 80016CB0 21105000 */  addu       $v0, $v0, $s0
    /* 74B4 80016CB4 00310200 */  sll        $a2, $v0, 4
    /* 74B8 80016CB8 2110A600 */  addu       $v0, $a1, $a2
  .L80016CBC:
    /* 74BC 80016CBC 21106202 */  addu       $v0, $s3, $v0
    /* 74C0 80016CC0 68024390 */  lbu        $v1, 0x268($v0)
    /* 74C4 80016CC4 21208502 */  addu       $a0, $s4, $a1
    /* 74C8 80016CC8 800083A0 */  sb         $v1, 0x80($a0)
    /* 74CC 80016CCC C8024290 */  lbu        $v0, 0x2C8($v0)
    /* 74D0 80016CD0 00000000 */  nop
    /* 74D4 80016CD4 B00082A0 */  sb         $v0, 0xB0($a0)
    /* 74D8 80016CD8 0000628E */  lw         $v0, 0x0($s3)
    /* 74DC 80016CDC 0100A524 */  addiu      $a1, $a1, 0x1
    /* 74E0 80016CE0 2B10A200 */  sltu       $v0, $a1, $v0
    /* 74E4 80016CE4 F5FF4014 */  bnez       $v0, .L80016CBC
    /* 74E8 80016CE8 2110A600 */   addu      $v0, $a1, $a2
  .L80016CEC:
    /* 74EC 80016CEC 00141500 */  sll        $v0, $s5, 16
    /* 74F0 80016CF0 03140200 */  sra        $v0, $v0, 16
    /* 74F4 80016CF4 FFFF0324 */  addiu      $v1, $zero, -0x1
    /* 74F8 80016CF8 11004310 */  beq        $v0, $v1, .L80016D40
    /* 74FC 80016CFC 1180113C */   lui       $s1, %hi(carManager)
    /* 7500 80016D00 74423126 */  addiu      $s1, $s1, %lo(carManager)
    /* 7504 80016D04 21202002 */  addu       $a0, $s1, $zero
    /* 7508 80016D08 00841600 */  sll        $s0, $s6, 16
    /* 750C 80016D0C 03841000 */  sra        $s0, $s0, 16
    /* 7510 80016D10 1000A583 */  lb         $a1, 0x10($sp)
    /* 7514 80016D14 D500A693 */  lbu        $a2, 0xD5($sp)
    /* 7518 80016D18 405A000C */  jal        AddToPinkSlipsList__11tCarManagersss
    /* 751C 80016D1C 21380002 */   addu      $a3, $s0, $zero
    /* 7520 80016D20 21202002 */  addu       $a0, $s1, $zero
    /* 7524 80016D24 1180023C */  lui        $v0, %hi(frontEnd)
    /* 7528 80016D28 00464224 */  addiu      $v0, $v0, %lo(frontEnd)
    /* 752C 80016D2C 21100202 */  addu       $v0, $s0, $v0
    /* 7530 80016D30 25014590 */  lbu        $a1, 0x125($v0)
    /* 7534 80016D34 D400A693 */  lbu        $a2, 0xD4($sp)
    /* 7538 80016D38 5F5A000C */  jal        AddUpgradesToPinkSlipsList__11tCarManagersss
    /* 753C 80016D3C 21380002 */   addu      $a3, $s0, $zero
  .L80016D40:
    /* 7540 80016D40 FC00BF8F */  lw         $ra, 0xFC($sp)
    /* 7544 80016D44 F800B68F */  lw         $s6, 0xF8($sp)
    /* 7548 80016D48 F400B58F */  lw         $s5, 0xF4($sp)
    /* 754C 80016D4C F000B48F */  lw         $s4, 0xF0($sp)
    /* 7550 80016D50 EC00B38F */  lw         $s3, 0xEC($sp)
    /* 7554 80016D54 E800B28F */  lw         $s2, 0xE8($sp)
    /* 7558 80016D58 E400B18F */  lw         $s1, 0xE4($sp)
    /* 755C 80016D5C E000B08F */  lw         $s0, 0xE0($sp)
    /* 7560 80016D60 0800E003 */  jr         $ra
    /* 7564 80016D64 0001BD27 */   addiu     $sp, $sp, 0x100
endlabel SavePinkSlipsCars__11tCarManagerR12tSaveCarInfoss
