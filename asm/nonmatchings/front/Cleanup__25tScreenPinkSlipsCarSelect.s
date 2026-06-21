.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Cleanup__25tScreenPinkSlipsCarSelect, 0x54

glabel Cleanup__25tScreenPinkSlipsCarSelect
    /* 2FAAC 8003F2AC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 2FAB0 8003F2B0 1000B0AF */  sw         $s0, 0x10($sp)
    /* 2FAB4 8003F2B4 21808000 */  addu       $s0, $a0, $zero
    /* 2FAB8 8003F2B8 A0030426 */  addiu      $a0, $s0, 0x3A0
    /* 2FABC 8003F2BC 01000224 */  addiu      $v0, $zero, 0x1
    /* 2FAC0 8003F2C0 1400BFAF */  sw         $ra, 0x14($sp)
    /* 2FAC4 8003F2C4 480402AE */  sw         $v0, 0x448($s0)
    /* 2FAC8 8003F2C8 0580023C */  lui        $v0, %hi(PinkSlipsScreenState)
    /* 2FACC 8003F2CC 07000324 */  addiu      $v1, $zero, 0x7
    /* 2FAD0 8003F2D0 342043AC */  sw         $v1, %lo(PinkSlipsScreenState)($v0)
    /* 2FAD4 8003F2D4 34204224 */  addiu      $v0, $v0, %lo(PinkSlipsScreenState)
    /* 2FAD8 8003F2D8 4162000C */  jal        Hide__11tDialogBase
    /* 2FADC 8003F2DC 040043AC */   sw        $v1, 0x4($v0)
    /* 2FAE0 8003F2E0 00D2000C */  jal        DeInit_Memcard__Fv
    /* 2FAE4 8003F2E4 00000000 */   nop
    /* 2FAE8 8003F2E8 84FB000C */  jal        Cleanup__25tScreenCarSelectTwoPlayer
    /* 2FAEC 8003F2EC 21200002 */   addu      $a0, $s0, $zero
    /* 2FAF0 8003F2F0 1400BF8F */  lw         $ra, 0x14($sp)
    /* 2FAF4 8003F2F4 1000B08F */  lw         $s0, 0x10($sp)
    /* 2FAF8 8003F2F8 0800E003 */  jr         $ra
    /* 2FAFC 8003F2FC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Cleanup__25tScreenPinkSlipsCarSelect
