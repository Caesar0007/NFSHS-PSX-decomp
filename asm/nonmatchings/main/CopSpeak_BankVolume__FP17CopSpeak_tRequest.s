.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CopSpeak_BankVolume__FP17CopSpeak_tRequest, 0x30

glabel CopSpeak_BankVolume__FP17CopSpeak_tRequest
    /* 8AE04 8009A604 1E008380 */  lb         $v1, 0x1E($a0)
    /* 8AE08 8009A608 02000224 */  addiu      $v0, $zero, 0x2
    /* 8AE0C 8009A60C 05006210 */  beq        $v1, $v0, .L8009A624
    /* 8AE10 8009A610 00000000 */   nop
    /* 8AE14 8009A614 1480023C */  lui        $v0, %hi(gMasterAmbientLevel)
    /* 8AE18 8009A618 60C6428C */  lw         $v0, %lo(gMasterAmbientLevel)($v0)
    /* 8AE1C 8009A61C 0800E003 */  jr         $ra
    /* 8AE20 8009A620 00000000 */   nop
  .L8009A624:
    /* 8AE24 8009A624 1480023C */  lui        $v0, %hi(gMasterFENarrationLevel)
    /* 8AE28 8009A628 5CC6428C */  lw         $v0, %lo(gMasterFENarrationLevel)($v0)
    /* 8AE2C 8009A62C 0800E003 */  jr         $ra
    /* 8AE30 8009A630 00000000 */   nop
endlabel CopSpeak_BankVolume__FP17CopSpeak_tRequest
