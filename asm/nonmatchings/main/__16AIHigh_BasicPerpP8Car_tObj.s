.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __16AIHigh_BasicPerpP8Car_tObj, 0x48

glabel __16AIHigh_BasicPerpP8Car_tObj
    /* 4C8F4 8005C0F4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 4C8F8 8005C0F8 1000B0AF */  sw         $s0, 0x10($sp)
    /* 4C8FC 8005C0FC 1400BFAF */  sw         $ra, 0x14($sp)
    /* 4C900 8005C100 C66C010C */  jal        __11AIHigh_BaseP8Car_tObj
    /* 4C904 8005C104 21808000 */   addu      $s0, $a0, $zero
    /* 4C908 8005C108 21200002 */  addu       $a0, $s0, $zero
    /* 4C90C 8005C10C 0580023C */  lui        $v0, %hi(_vt_16AIHigh_BasicPerp)
    /* 4C910 8005C110 6C4E4224 */  addiu      $v0, $v0, %lo(_vt_16AIHigh_BasicPerp)
    /* 4C914 8005C114 140002AE */  sw         $v0, 0x14($s0)
    /* 4C918 8005C118 700000AE */  sw         $zero, 0x70($s0)
    /* 4C91C 8005C11C 740000AE */  sw         $zero, 0x74($s0)
    /* 4C920 8005C120 2E70010C */  jal        Clear__16AIHigh_BasicPerp
    /* 4C924 8005C124 780000AE */   sw        $zero, 0x78($s0)
    /* 4C928 8005C128 21100002 */  addu       $v0, $s0, $zero
    /* 4C92C 8005C12C 1400BF8F */  lw         $ra, 0x14($sp)
    /* 4C930 8005C130 1000B08F */  lw         $s0, 0x10($sp)
    /* 4C934 8005C134 0800E003 */  jr         $ra
    /* 4C938 8005C138 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel __16AIHigh_BasicPerpP8Car_tObj
