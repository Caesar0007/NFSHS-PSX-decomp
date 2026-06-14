.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TextSys_LoadInGame__Fi, 0x4C

glabel TextSys_LoadInGame__Fi
    /* A99DC 800B91DC 98FFBD27 */  addiu      $sp, $sp, -0x68
    /* A99E0 800B91E0 6000B0AF */  sw         $s0, 0x60($sp)
    /* A99E4 800B91E4 21808000 */  addu       $s0, $a0, $zero
    /* A99E8 800B91E8 1000A427 */  addiu      $a0, $sp, 0x10
    /* A99EC 800B91EC 1480053C */  lui        $a1, %hi(D_8013D45C)
    /* A99F0 800B91F0 5CD4A524 */  addiu      $a1, $a1, %lo(D_8013D45C)
    /* A99F4 800B91F4 1180023C */  lui        $v0, %hi(D_801164D0)
    /* A99F8 800B91F8 1480073C */  lui        $a3, %hi(D_8013D464)
    /* A99FC 800B91FC D064468C */  lw         $a2, %lo(D_801164D0)($v0)
    /* A9A00 800B9200 6400BFAF */  sw         $ra, 0x64($sp)
    /* A9A04 800B9204 2F91030C */  jal        sprintf
    /* A9A08 800B9208 64D4E724 */   addiu     $a3, $a3, %lo(D_8013D464)
    /* A9A0C 800B920C 21200002 */  addu       $a0, $s0, $zero
    /* A9A10 800B9210 56E4020C */  jal        TextSys_LoadWordsGeneric__FiPc
    /* A9A14 800B9214 1000A527 */   addiu     $a1, $sp, 0x10
    /* A9A18 800B9218 6400BF8F */  lw         $ra, 0x64($sp)
    /* A9A1C 800B921C 6000B08F */  lw         $s0, 0x60($sp)
    /* A9A20 800B9220 0800E003 */  jr         $ra
    /* A9A24 800B9224 6800BD27 */   addiu     $sp, $sp, 0x68
endlabel TextSys_LoadInGame__Fi
