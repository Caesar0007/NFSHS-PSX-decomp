.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __17AIState_GotoSliceP8Car_tObjii, 0x54

glabel __17AIState_GotoSliceP8Car_tObjii
    /* 62B6C 8007236C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 62B70 80072370 1000B0AF */  sw         $s0, 0x10($sp)
    /* 62B74 80072374 21808000 */  addu       $s0, $a0, $zero
    /* 62B78 80072378 1400B1AF */  sw         $s1, 0x14($sp)
    /* 62B7C 8007237C 2188C000 */  addu       $s1, $a2, $zero
    /* 62B80 80072380 1800B2AF */  sw         $s2, 0x18($sp)
    /* 62B84 80072384 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 62B88 80072388 B7BE010C */  jal        __14AIState_NormalP8Car_tObj
    /* 62B8C 8007238C 2190E000 */   addu      $s2, $a3, $zero
    /* 62B90 80072390 21100002 */  addu       $v0, $s0, $zero
    /* 62B94 80072394 0580033C */  lui        $v1, %hi(_vt_17AIState_GotoSlice)
    /* 62B98 80072398 20556324 */  addiu      $v1, $v1, %lo(_vt_17AIState_GotoSlice)
    /* 62B9C 8007239C 040043AC */  sw         $v1, 0x4($v0)
    /* 62BA0 800723A0 080051AC */  sw         $s1, 0x8($v0)
    /* 62BA4 800723A4 0C0052AC */  sw         $s2, 0xC($v0)
    /* 62BA8 800723A8 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 62BAC 800723AC 1800B28F */  lw         $s2, 0x18($sp)
    /* 62BB0 800723B0 1400B18F */  lw         $s1, 0x14($sp)
    /* 62BB4 800723B4 1000B08F */  lw         $s0, 0x10($sp)
    /* 62BB8 800723B8 0800E003 */  jr         $ra
    /* 62BBC 800723BC 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel __17AIState_GotoSliceP8Car_tObjii
