.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching StartUp2__14AIDataRecord_t, 0x6C

glabel StartUp2__14AIDataRecord_t
    /* 5D7A8 8006CFA8 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 5D7AC 8006CFAC 1400B1AF */  sw         $s1, 0x14($sp)
    /* 5D7B0 8006CFB0 21880000 */  addu       $s1, $zero, $zero
    /* 5D7B4 8006CFB4 1480023C */  lui        $v0, %hi(D_8013DF64)
    /* 5D7B8 8006CFB8 1000B0AF */  sw         $s0, 0x10($sp)
    /* 5D7BC 8006CFBC 64DF5024 */  addiu      $s0, $v0, %lo(D_8013DF64)
    /* 5D7C0 8006CFC0 1800BFAF */  sw         $ra, 0x18($sp)
  .L8006CFC4:
    /* 5D7C4 8006CFC4 0000038E */  lw         $v1, 0x0($s0)
    /* 5D7C8 8006CFC8 00000000 */  nop
    /* 5D7CC 8006CFCC 08006010 */  beqz       $v1, .L8006CFF0
    /* 5D7D0 8006CFD0 00000000 */   nop
    /* 5D7D4 8006CFD4 5400628C */  lw         $v0, 0x54($v1)
    /* 5D7D8 8006CFD8 00000000 */  nop
    /* 5D7DC 8006CFDC 10004484 */  lh         $a0, 0x10($v0)
    /* 5D7E0 8006CFE0 1400428C */  lw         $v0, 0x14($v0)
    /* 5D7E4 8006CFE4 00000000 */  nop
    /* 5D7E8 8006CFE8 09F84000 */  jalr       $v0
    /* 5D7EC 8006CFEC 21206400 */   addu      $a0, $v1, $a0
  .L8006CFF0:
    /* 5D7F0 8006CFF0 01003126 */  addiu      $s1, $s1, 0x1
    /* 5D7F4 8006CFF4 1800222A */  slti       $v0, $s1, 0x18
    /* 5D7F8 8006CFF8 F2FF4014 */  bnez       $v0, .L8006CFC4
    /* 5D7FC 8006CFFC 04001026 */   addiu     $s0, $s0, 0x4
    /* 5D800 8006D000 1800BF8F */  lw         $ra, 0x18($sp)
    /* 5D804 8006D004 1400B18F */  lw         $s1, 0x14($sp)
    /* 5D808 8006D008 1000B08F */  lw         $s0, 0x10($sp)
    /* 5D80C 8006D00C 0800E003 */  jr         $ra
    /* 5D810 8006D010 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel StartUp2__14AIDataRecord_t
