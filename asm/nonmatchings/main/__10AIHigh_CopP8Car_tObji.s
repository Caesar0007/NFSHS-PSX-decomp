.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __10AIHigh_CopP8Car_tObji, 0x4C

glabel __10AIHigh_CopP8Car_tObji
    /* 54400 80063C00 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 54404 80063C04 1000B0AF */  sw         $s0, 0x10($sp)
    /* 54408 80063C08 1400BFAF */  sw         $ra, 0x14($sp)
    /* 5440C 80063C0C 5970010C */  jal        __15AIHigh_BasicCopP8Car_tObji
    /* 54410 80063C10 21808000 */   addu      $s0, $a0, $zero
    /* 54414 80063C14 21100002 */  addu       $v0, $s0, $zero
    /* 54418 80063C18 0580033C */  lui        $v1, %hi(_vt_10AIHigh_Cop)
    /* 5441C 80063C1C 54516324 */  addiu      $v1, $v1, %lo(_vt_10AIHigh_Cop)
    /* 54420 80063C20 140043AC */  sw         $v1, 0x14($v0)
    /* 54424 80063C24 FFFF0324 */  addiu      $v1, $zero, -0x1
    /* 54428 80063C28 580040AC */  sw         $zero, 0x58($v0)
    /* 5442C 80063C2C 600040AC */  sw         $zero, 0x60($v0)
    /* 54430 80063C30 640043AC */  sw         $v1, 0x64($v0)
    /* 54434 80063C34 5C0040AC */  sw         $zero, 0x5C($v0)
    /* 54438 80063C38 680040AC */  sw         $zero, 0x68($v0)
    /* 5443C 80063C3C 1400BF8F */  lw         $ra, 0x14($sp)
    /* 54440 80063C40 1000B08F */  lw         $s0, 0x10($sp)
    /* 54444 80063C44 0800E003 */  jr         $ra
    /* 54448 80063C48 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel __10AIHigh_CopP8Car_tObji
