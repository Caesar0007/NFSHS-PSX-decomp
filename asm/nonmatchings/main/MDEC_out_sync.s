.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MDEC_out_sync, 0x94

glabel MDEC_out_sync
    /* E9598 800F8D98 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* E959C 800F8D9C 1380033C */  lui        $v1, %hi(D_80136C1C)
    /* E95A0 800F8DA0 1C6C638C */  lw         $v1, %lo(D_80136C1C)($v1)
    /* E95A4 800F8DA4 1000023C */  lui        $v0, (0x100000 >> 16)
    /* E95A8 800F8DA8 1800BFAF */  sw         $ra, 0x18($sp)
    /* E95AC 800F8DAC 1000A2AF */  sw         $v0, 0x10($sp)
    /* E95B0 800F8DB0 0000628C */  lw         $v0, 0x0($v1)
    /* E95B4 800F8DB4 0001033C */  lui        $v1, (0x1000000 >> 16)
    /* E95B8 800F8DB8 24104300 */  and        $v0, $v0, $v1
    /* E95BC 800F8DBC 17004010 */  beqz       $v0, .L800F8E1C
    /* E95C0 800F8DC0 21100000 */   addu      $v0, $zero, $zero
    /* E95C4 800F8DC4 FFFF0424 */  addiu      $a0, $zero, -0x1
  .L800F8DC8:
    /* E95C8 800F8DC8 1000A28F */  lw         $v0, 0x10($sp)
    /* E95CC 800F8DCC 00000000 */  nop
    /* E95D0 800F8DD0 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* E95D4 800F8DD4 1000A2AF */  sw         $v0, 0x10($sp)
    /* E95D8 800F8DD8 1000A28F */  lw         $v0, 0x10($sp)
    /* E95DC 800F8DDC 00000000 */  nop
    /* E95E0 800F8DE0 06004414 */  bne        $v0, $a0, .L800F8DFC
    /* E95E4 800F8DE4 00000000 */   nop
    /* E95E8 800F8DE8 0580043C */  lui        $a0, %hi(D_8005715C)
    /* E95EC 800F8DEC 91E3030C */  jal        MDEC_status
    /* E95F0 800F8DF0 5C718424 */   addiu     $a0, $a0, %lo(D_8005715C)
    /* E95F4 800F8DF4 87E30308 */  j          .L800F8E1C
    /* E95F8 800F8DF8 FFFF0224 */   addiu     $v0, $zero, -0x1
  .L800F8DFC:
    /* E95FC 800F8DFC 1380023C */  lui        $v0, %hi(D_80136C1C)
    /* E9600 800F8E00 1C6C428C */  lw         $v0, %lo(D_80136C1C)($v0)
    /* E9604 800F8E04 00000000 */  nop
    /* E9608 800F8E08 0000428C */  lw         $v0, 0x0($v0)
    /* E960C 800F8E0C 00000000 */  nop
    /* E9610 800F8E10 24104300 */  and        $v0, $v0, $v1
    /* E9614 800F8E14 ECFF4014 */  bnez       $v0, .L800F8DC8
    /* E9618 800F8E18 21100000 */   addu      $v0, $zero, $zero
  .L800F8E1C:
    /* E961C 800F8E1C 1800BF8F */  lw         $ra, 0x18($sp)
    /* E9620 800F8E20 2000BD27 */  addiu      $sp, $sp, 0x20
    /* E9624 800F8E24 0800E003 */  jr         $ra
    /* E9628 800F8E28 00000000 */   nop
endlabel MDEC_out_sync
