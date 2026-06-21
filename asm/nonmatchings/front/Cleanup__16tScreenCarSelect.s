.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Cleanup__16tScreenCarSelect, 0x48

glabel Cleanup__16tScreenCarSelect
    /* 2B4B8 8003ACB8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 2B4BC 8003ACBC 1000B0AF */  sw         $s0, 0x10($sp)
    /* 2B4C0 8003ACC0 1400BFAF */  sw         $ra, 0x14($sp)
    /* 2B4C4 8003ACC4 B136010C */  jal        CleanupSpinningCarsMenu__Fv
    /* 2B4C8 8003ACC8 21808000 */   addu      $s0, $a0, $zero
    /* 2B4CC 8003ACCC 6898000C */  jal        Cleanup__7tScreen
    /* 2B4D0 8003ACD0 21200002 */   addu      $a0, $s0, $zero
    /* 2B4D4 8003ACD4 6000028E */  lw         $v0, 0x60($s0)
    /* 2B4D8 8003ACD8 00000000 */  nop
    /* 2B4DC 8003ACDC 78004484 */  lh         $a0, 0x78($v0)
    /* 2B4E0 8003ACE0 7C00428C */  lw         $v0, 0x7C($v0)
    /* 2B4E4 8003ACE4 00000000 */  nop
    /* 2B4E8 8003ACE8 09F84000 */  jalr       $v0
    /* 2B4EC 8003ACEC 21200402 */   addu      $a0, $s0, $a0
    /* 2B4F0 8003ACF0 1400BF8F */  lw         $ra, 0x14($sp)
    /* 2B4F4 8003ACF4 1000B08F */  lw         $s0, 0x10($sp)
    /* 2B4F8 8003ACF8 0800E003 */  jr         $ra
    /* 2B4FC 8003ACFC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Cleanup__16tScreenCarSelect
