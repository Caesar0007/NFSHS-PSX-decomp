.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Promote__Q26Speech7Speaker, 0x6C

glabel Promote__Q26Speech7Speaker
    /* 8658C 80095D8C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 86590 80095D90 1000B0AF */  sw         $s0, 0x10($sp)
    /* 86594 80095D94 1400BFAF */  sw         $ra, 0x14($sp)
    /* 86598 80095D98 BC57020C */  jal        Dispatch__6Speech
    /* 8659C 80095D9C 21808000 */   addu      $s0, $a0, $zero
    /* 865A0 80095DA0 21204000 */  addu       $a0, $v0, $zero
  .L80095DA4:
    /* 865A4 80095DA4 4800838C */  lw         $v1, 0x48($a0)
    /* 865A8 80095DA8 00000000 */  nop
    /* 865AC 80095DAC 03006010 */  beqz       $v1, .L80095DBC
    /* 865B0 80095DB0 21100000 */   addu      $v0, $zero, $zero
    /* 865B4 80095DB4 26107000 */  xor        $v0, $v1, $s0
    /* 865B8 80095DB8 2B100200 */  sltu       $v0, $zero, $v0
  .L80095DBC:
    /* 865BC 80095DBC 03004010 */  beqz       $v0, .L80095DCC
    /* 865C0 80095DC0 00000000 */   nop
    /* 865C4 80095DC4 69570208 */  j          .L80095DA4
    /* 865C8 80095DC8 21206000 */   addu      $a0, $v1, $zero
  .L80095DCC:
    /* 865CC 80095DCC 4800028E */  lw         $v0, 0x48($s0)
    /* 865D0 80095DD0 BC57020C */  jal        Dispatch__6Speech
    /* 865D4 80095DD4 480082AC */   sw        $v0, 0x48($a0)
    /* 865D8 80095DD8 4800428C */  lw         $v0, 0x48($v0)
    /* 865DC 80095DDC BC57020C */  jal        Dispatch__6Speech
    /* 865E0 80095DE0 480002AE */   sw        $v0, 0x48($s0)
    /* 865E4 80095DE4 480050AC */  sw         $s0, 0x48($v0)
    /* 865E8 80095DE8 1400BF8F */  lw         $ra, 0x14($sp)
    /* 865EC 80095DEC 1000B08F */  lw         $s0, 0x10($sp)
    /* 865F0 80095DF0 0800E003 */  jr         $ra
    /* 865F4 80095DF4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Promote__Q26Speech7Speaker
