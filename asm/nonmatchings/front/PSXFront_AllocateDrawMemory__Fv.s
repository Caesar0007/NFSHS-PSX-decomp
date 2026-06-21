.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching PSXFront_AllocateDrawMemory__Fv, 0x74

glabel PSXFront_AllocateDrawMemory__Fv
    /* 3DFBC 8004D7BC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 3DFC0 8004D7C0 1400BFAF */  sw         $ra, 0x14($sp)
    /* 3DFC4 8004D7C4 F8F6020C */  jal        Draw_InitViewOT__Fv
    /* 3DFC8 8004D7C8 1000B0AF */   sw        $s0, 0x10($sp)
    /* 3DFCC 8004D7CC 0180043C */  lui        $a0, %hi(D_800127EC)
    /* 3DFD0 8004D7D0 EC278424 */  addiu      $a0, $a0, %lo(D_800127EC)
    /* 3DFD4 8004D7D4 0100053C */  lui        $a1, (0x13880 >> 16)
    /* 3DFD8 8004D7D8 8038A534 */  ori        $a1, $a1, (0x13880 & 0xFFFF)
    /* 3DFDC 8004D7DC CF94030C */  jal        reservememadr
    /* 3DFE0 8004D7E0 10000624 */   addiu     $a2, $zero, 0x10
    /* 3DFE4 8004D7E4 0180043C */  lui        $a0, %hi(D_800127F0)
    /* 3DFE8 8004D7E8 F0278424 */  addiu      $a0, $a0, %lo(D_800127F0)
    /* 3DFEC 8004D7EC 0100053C */  lui        $a1, (0x13880 >> 16)
    /* 3DFF0 8004D7F0 8038A534 */  ori        $a1, $a1, (0x13880 & 0xFFFF)
    /* 3DFF4 8004D7F4 10000624 */  addiu      $a2, $zero, 0x10
    /* 3DFF8 8004D7F8 1280103C */  lui        $s0, %hi(gEnviro)
    /* 3DFFC 8004D7FC 24F41026 */  addiu      $s0, $s0, %lo(gEnviro)
    /* 3E000 8004D800 CF94030C */  jal        reservememadr
    /* 3E004 8004D804 140002AE */   sw        $v0, 0x14($s0)
    /* 3E008 8004D808 0100053C */  lui        $a1, (0x13880 >> 16)
    /* 3E00C 8004D80C 1480033C */  lui        $v1, %hi(Draw_gPlayer1View)
    /* 3E010 8004D810 CCD3648C */  lw         $a0, %lo(Draw_gPlayer1View)($v1)
    /* 3E014 8004D814 8038A534 */  ori        $a1, $a1, (0x13880 & 0xFFFF)
    /* 3E018 8004D818 76F7020C */  jal        Draw_SetViewMemBudget__Fii
    /* 3E01C 8004D81C 2C0002AE */   sw        $v0, 0x2C($s0)
    /* 3E020 8004D820 1400BF8F */  lw         $ra, 0x14($sp)
    /* 3E024 8004D824 1000B08F */  lw         $s0, 0x10($sp)
    /* 3E028 8004D828 0800E003 */  jr         $ra
    /* 3E02C 8004D82C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel PSXFront_AllocateDrawMemory__Fv
