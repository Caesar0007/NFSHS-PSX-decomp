.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Input_WingCommandMode__Fi, 0x70

glabel Input_WingCommandMode__Fi
    /* 8CC08 8009C408 1180023C */  lui        $v0, %hi(D_80113CC8)
    /* 8CC0C 8009C40C 02008010 */  beqz       $a0, .L8009C418
    /* 8CC10 8009C410 C83C4324 */   addiu     $v1, $v0, %lo(D_80113CC8)
    /* 8CC14 8009C414 30016324 */  addiu      $v1, $v1, 0x130
  .L8009C418:
    /* 8CC18 8009C418 0000628C */  lw         $v0, 0x0($v1)
    /* 8CC1C 8009C41C 00000000 */  nop
    /* 8CC20 8009C420 09004014 */  bnez       $v0, .L8009C448
    /* 8CC24 8009C424 01008230 */   andi      $v0, $a0, 0x1
    /* 8CC28 8009C428 0400628C */  lw         $v0, 0x4($v1)
    /* 8CC2C 8009C42C 00000000 */  nop
    /* 8CC30 8009C430 05004014 */  bnez       $v0, .L8009C448
    /* 8CC34 8009C434 01008230 */   andi      $v0, $a0, 0x1
    /* 8CC38 8009C438 0800628C */  lw         $v0, 0x8($v1)
    /* 8CC3C 8009C43C 00000000 */  nop
    /* 8CC40 8009C440 09004010 */  beqz       $v0, .L8009C468
    /* 8CC44 8009C444 01008230 */   andi      $v0, $a0, 0x1
  .L8009C448:
    /* 8CC48 8009C448 80100200 */  sll        $v0, $v0, 2
    /* 8CC4C 8009C44C 1480033C */  lui        $v1, %hi(Input_gMode)
    /* 8CC50 8009C450 38D26324 */  addiu      $v1, $v1, %lo(Input_gMode)
    /* 8CC54 8009C454 21104300 */  addu       $v0, $v0, $v1
    /* 8CC58 8009C458 0000438C */  lw         $v1, 0x0($v0)
    /* 8CC5C 8009C45C 01000224 */  addiu      $v0, $zero, 0x1
    /* 8CC60 8009C460 03006210 */  beq        $v1, $v0, .L8009C470
    /* 8CC64 8009C464 00000000 */   nop
  .L8009C468:
    /* 8CC68 8009C468 0800E003 */  jr         $ra
    /* 8CC6C 8009C46C 21100000 */   addu      $v0, $zero, $zero
  .L8009C470:
    /* 8CC70 8009C470 0800E003 */  jr         $ra
    /* 8CC74 8009C474 01000224 */   addiu     $v0, $zero, 0x1
endlabel Input_WingCommandMode__Fi
