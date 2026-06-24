.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching startIntrVSync_helper_1, 0x6C

glabel startIntrVSync_helper_1
    /* F6D8C 8010658C 1380023C */  lui        $v0, %hi(Vcount)
    /* F6D90 80106590 107D428C */  lw         $v0, %lo(Vcount)($v0)
    /* F6D94 80106594 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* F6D98 80106598 1400B1AF */  sw         $s1, 0x14($sp)
    /* F6D9C 8010659C 21880000 */  addu       $s1, $zero, $zero
    /* F6DA0 801065A0 1000B0AF */  sw         $s0, 0x10($sp)
    /* F6DA4 801065A4 1380103C */  lui        $s0, %hi(D_80137CF0)
    /* F6DA8 801065A8 F07C1026 */  addiu      $s0, $s0, %lo(D_80137CF0)
    /* F6DAC 801065AC 1800BFAF */  sw         $ra, 0x18($sp)
    /* F6DB0 801065B0 01004224 */  addiu      $v0, $v0, 0x1
    /* F6DB4 801065B4 1380013C */  lui        $at, %hi(Vcount)
    /* F6DB8 801065B8 107D22AC */  sw         $v0, %lo(Vcount)($at)
  .L801065BC:
    /* F6DBC 801065BC 0000028E */  lw         $v0, 0x0($s0)
    /* F6DC0 801065C0 00000000 */  nop
    /* F6DC4 801065C4 03004010 */  beqz       $v0, .L801065D4
    /* F6DC8 801065C8 00000000 */   nop
    /* F6DCC 801065CC 09F84000 */  jalr       $v0
    /* F6DD0 801065D0 00000000 */   nop
  .L801065D4:
    /* F6DD4 801065D4 01003126 */  addiu      $s1, $s1, 0x1
    /* F6DD8 801065D8 0800222A */  slti       $v0, $s1, 0x8
    /* F6DDC 801065DC F7FF4014 */  bnez       $v0, .L801065BC
    /* F6DE0 801065E0 04001026 */   addiu     $s0, $s0, 0x4
    /* F6DE4 801065E4 1800BF8F */  lw         $ra, 0x18($sp)
    /* F6DE8 801065E8 1400B18F */  lw         $s1, 0x14($sp)
    /* F6DEC 801065EC 1000B08F */  lw         $s0, 0x10($sp)
    /* F6DF0 801065F0 0800E003 */  jr         $ra
    /* F6DF4 801065F4 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel startIntrVSync_helper_1
