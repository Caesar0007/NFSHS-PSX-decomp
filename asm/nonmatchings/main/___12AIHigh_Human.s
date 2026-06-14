.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___12AIHigh_Human, 0x28

glabel ___12AIHigh_Human
    /* 53AE0 800632E0 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 53AE4 800632E4 0580023C */  lui        $v0, %hi(_vt_16AIHigh_BasicPerp)
    /* 53AE8 800632E8 6C4E4224 */  addiu      $v0, $v0, %lo(_vt_16AIHigh_BasicPerp)
    /* 53AEC 800632EC 1000BFAF */  sw         $ra, 0x10($sp)
    /* 53AF0 800632F0 F16C010C */  jal        ___11AIHigh_Base
    /* 53AF4 800632F4 140082AC */   sw        $v0, 0x14($a0)
    /* 53AF8 800632F8 1000BF8F */  lw         $ra, 0x10($sp)
    /* 53AFC 800632FC 00000000 */  nop
    /* 53B00 80063300 0800E003 */  jr         $ra
    /* 53B04 80063304 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___12AIHigh_Human
