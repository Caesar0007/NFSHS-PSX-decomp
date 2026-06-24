.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _VSync_wait, 0x98

glabel _VSync_wait
    /* E2C94 800F2494 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* E2C98 800F2498 C02B0500 */  sll        $a1, $a1, 15
    /* E2C9C 800F249C 1000A5AF */  sw         $a1, 0x10($sp)
    /* E2CA0 800F24A0 1380023C */  lui        $v0, %hi(Vcount)
    /* E2CA4 800F24A4 107D428C */  lw         $v0, %lo(Vcount)($v0)
    /* E2CA8 800F24A8 00000000 */  nop
    /* E2CAC 800F24AC 2A104400 */  slt        $v0, $v0, $a0
    /* E2CB0 800F24B0 1A004010 */  beqz       $v0, .L800F251C
    /* E2CB4 800F24B4 1800BFAF */   sw        $ra, 0x18($sp)
    /* E2CB8 800F24B8 FFFF0324 */  addiu      $v1, $zero, -0x1
  .L800F24BC:
    /* E2CBC 800F24BC 1000A28F */  lw         $v0, 0x10($sp)
    /* E2CC0 800F24C0 00000000 */  nop
    /* E2CC4 800F24C4 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* E2CC8 800F24C8 1000A2AF */  sw         $v0, 0x10($sp)
    /* E2CCC 800F24CC 1000A28F */  lw         $v0, 0x10($sp)
    /* E2CD0 800F24D0 00000000 */  nop
    /* E2CD4 800F24D4 0B004314 */  bne        $v0, $v1, .L800F2504
    /* E2CD8 800F24D8 00000000 */   nop
    /* E2CDC 800F24DC 0580043C */  lui        $a0, %hi(D_80056F3C)
    /* E2CE0 800F24E0 33A0030C */  jal        puts
    /* E2CE4 800F24E4 3C6F8424 */   addiu     $a0, $a0, %lo(D_80056F3C)
    /* E2CE8 800F24E8 9519040C */  jal        ChangeClearPAD
    /* E2CEC 800F24EC 21200000 */   addu      $a0, $zero, $zero
    /* E2CF0 800F24F0 03000424 */  addiu      $a0, $zero, 0x3
    /* E2CF4 800F24F4 9919040C */  jal        ChangeClearRCnt
    /* E2CF8 800F24F8 21280000 */   addu      $a1, $zero, $zero
    /* E2CFC 800F24FC 47C90308 */  j          .L800F251C
    /* E2D00 800F2500 00000000 */   nop
  .L800F2504:
    /* E2D04 800F2504 1380023C */  lui        $v0, %hi(Vcount)
    /* E2D08 800F2508 107D428C */  lw         $v0, %lo(Vcount)($v0)
    /* E2D0C 800F250C 00000000 */  nop
    /* E2D10 800F2510 2A104400 */  slt        $v0, $v0, $a0
    /* E2D14 800F2514 E9FF4014 */  bnez       $v0, .L800F24BC
    /* E2D18 800F2518 00000000 */   nop
  .L800F251C:
    /* E2D1C 800F251C 1800BF8F */  lw         $ra, 0x18($sp)
    /* E2D20 800F2520 2000BD27 */  addiu      $sp, $sp, 0x20
    /* E2D24 800F2524 0800E003 */  jr         $ra
    /* E2D28 800F2528 00000000 */   nop
endlabel _VSync_wait
