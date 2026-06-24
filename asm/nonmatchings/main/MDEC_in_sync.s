.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MDEC_in_sync, 0x94

glabel MDEC_in_sync
    /* E9504 800F8D04 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* E9508 800F8D08 1380033C */  lui        $v1, %hi(D_80136C3C)
    /* E950C 800F8D0C 3C6C638C */  lw         $v1, %lo(D_80136C3C)($v1)
    /* E9510 800F8D10 1000023C */  lui        $v0, (0x100000 >> 16)
    /* E9514 800F8D14 1800BFAF */  sw         $ra, 0x18($sp)
    /* E9518 800F8D18 1000A2AF */  sw         $v0, 0x10($sp)
    /* E951C 800F8D1C 0000628C */  lw         $v0, 0x0($v1)
    /* E9520 800F8D20 0020033C */  lui        $v1, (0x20000000 >> 16)
    /* E9524 800F8D24 24104300 */  and        $v0, $v0, $v1
    /* E9528 800F8D28 17004010 */  beqz       $v0, .L800F8D88
    /* E952C 800F8D2C 21100000 */   addu      $v0, $zero, $zero
    /* E9530 800F8D30 FFFF0424 */  addiu      $a0, $zero, -0x1
  .L800F8D34:
    /* E9534 800F8D34 1000A28F */  lw         $v0, 0x10($sp)
    /* E9538 800F8D38 00000000 */  nop
    /* E953C 800F8D3C FFFF4224 */  addiu      $v0, $v0, -0x1
    /* E9540 800F8D40 1000A2AF */  sw         $v0, 0x10($sp)
    /* E9544 800F8D44 1000A28F */  lw         $v0, 0x10($sp)
    /* E9548 800F8D48 00000000 */  nop
    /* E954C 800F8D4C 06004414 */  bne        $v0, $a0, .L800F8D68
    /* E9550 800F8D50 00000000 */   nop
    /* E9554 800F8D54 0580043C */  lui        $a0, %hi(D_8005714C)
    /* E9558 800F8D58 91E3030C */  jal        MDEC_status
    /* E955C 800F8D5C 4C718424 */   addiu     $a0, $a0, %lo(D_8005714C)
    /* E9560 800F8D60 62E30308 */  j          .L800F8D88
    /* E9564 800F8D64 FFFF0224 */   addiu     $v0, $zero, -0x1
  .L800F8D68:
    /* E9568 800F8D68 1380023C */  lui        $v0, %hi(D_80136C3C)
    /* E956C 800F8D6C 3C6C428C */  lw         $v0, %lo(D_80136C3C)($v0)
    /* E9570 800F8D70 00000000 */  nop
    /* E9574 800F8D74 0000428C */  lw         $v0, 0x0($v0)
    /* E9578 800F8D78 00000000 */  nop
    /* E957C 800F8D7C 24104300 */  and        $v0, $v0, $v1
    /* E9580 800F8D80 ECFF4014 */  bnez       $v0, .L800F8D34
    /* E9584 800F8D84 21100000 */   addu      $v0, $zero, $zero
  .L800F8D88:
    /* E9588 800F8D88 1800BF8F */  lw         $ra, 0x18($sp)
    /* E958C 800F8D8C 2000BD27 */  addiu      $sp, $sp, 0x20
    /* E9590 800F8D90 0800E003 */  jr         $ra
    /* E9594 800F8D94 00000000 */   nop
endlabel MDEC_in_sync
