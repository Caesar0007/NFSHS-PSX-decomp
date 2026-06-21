.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching mdecreset__Fv, 0x44

glabel mdecreset__Fv
    /* 412A8 80050AA8 0580023C */  lui        $v0, %hi(gMDECinfo)
    /* 412AC 80050AAC 282B438C */  lw         $v1, %lo(gMDECinfo)($v0)
    /* 412B0 80050AB0 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 412B4 80050AB4 1000B0AF */  sw         $s0, 0x10($sp)
    /* 412B8 80050AB8 282B5024 */  addiu      $s0, $v0, %lo(gMDECinfo)
    /* 412BC 80050ABC 06006010 */  beqz       $v1, .L80050AD8
    /* 412C0 80050AC0 1400BFAF */   sw        $ra, 0x14($sp)
    /* 412C4 80050AC4 72E2030C */  jal        DecDCTReset
    /* 412C8 80050AC8 21200000 */   addu      $a0, $zero, $zero
    /* 412CC 80050ACC 0580043C */  lui        $a0, %hi(MDECCompleteHandler__Fv)
    /* 412D0 80050AD0 B5E2030C */  jal        DecDCToutCallback
    /* 412D4 80050AD4 200C8424 */   addiu     $a0, $a0, %lo(MDECCompleteHandler__Fv)
  .L80050AD8:
    /* 412D8 80050AD8 040000AE */  sw         $zero, 0x4($s0)
    /* 412DC 80050ADC 1400BF8F */  lw         $ra, 0x14($sp)
    /* 412E0 80050AE0 1000B08F */  lw         $s0, 0x10($sp)
    /* 412E4 80050AE4 0800E003 */  jr         $ra
    /* 412E8 80050AE8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel mdecreset__Fv
