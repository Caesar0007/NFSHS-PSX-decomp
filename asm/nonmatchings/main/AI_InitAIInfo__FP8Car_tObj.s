.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AI_InitAIInfo__FP8Car_tObj, 0x48

glabel AI_InitAIInfo__FP8Car_tObj
    /* 48224 80057A24 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 48228 80057A28 1180023C */  lui        $v0, %hi(AI_Info)
    /* 4822C 80057A2C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 48230 80057A30 F0CC5024 */  addiu      $s0, $v0, %lo(AI_Info)
    /* 48234 80057A34 1400BFAF */  sw         $ra, 0x14($sp)
    /* 48238 80057A38 080000AE */  sw         $zero, 0x8($s0)
    /* 4823C 80057A3C 040000AE */  sw         $zero, 0x4($s0)
    /* 48240 80057A40 F0CC40AC */  sw         $zero, %lo(AI_Info)($v0)
    /* 48244 80057A44 140000AE */  sw         $zero, 0x14($s0)
    /* 48248 80057A48 100000AE */  sw         $zero, 0x10($s0)
    /* 4824C 80057A4C 96CD010C */  jal        AIWorld_CalculateDeltaRoadYaw__FP8Car_tObj
    /* 48250 80057A50 0C0000AE */   sw        $zero, 0xC($s0)
    /* 48254 80057A54 440002AE */  sw         $v0, 0x44($s0)
    /* 48258 80057A58 3C0000AE */  sw         $zero, 0x3C($s0)
    /* 4825C 80057A5C 1400BF8F */  lw         $ra, 0x14($sp)
    /* 48260 80057A60 1000B08F */  lw         $s0, 0x10($sp)
    /* 48264 80057A64 0800E003 */  jr         $ra
    /* 48268 80057A68 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AI_InitAIInfo__FP8Car_tObj
