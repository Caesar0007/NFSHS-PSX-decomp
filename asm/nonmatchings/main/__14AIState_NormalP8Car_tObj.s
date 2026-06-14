.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __14AIState_NormalP8Car_tObj, 0x58

glabel __14AIState_NormalP8Car_tObj
    /* 602DC 8006FADC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 602E0 8006FAE0 1000B0AF */  sw         $s0, 0x10($sp)
    /* 602E4 8006FAE4 1400BFAF */  sw         $ra, 0x14($sp)
    /* 602E8 8006FAE8 9DBE010C */  jal        __12AIState_BaseP8Car_tObj
    /* 602EC 8006FAEC 21808000 */   addu      $s0, $a0, $zero
    /* 602F0 8006FAF0 0580023C */  lui        $v0, %hi(_vt_14AIState_Normal)
    /* 602F4 8006FAF4 0000038E */  lw         $v1, 0x0($s0)
    /* 602F8 8006FAF8 20564224 */  addiu      $v0, $v0, %lo(_vt_14AIState_Normal)
    /* 602FC 8006FAFC 040002AE */  sw         $v0, 0x4($s0)
    /* 60300 8006FB00 100760AC */  sw         $zero, 0x710($v1)
    /* 60304 8006FB04 0C0760AC */  sw         $zero, 0x70C($v1)
    /* 60308 8006FB08 080760AC */  sw         $zero, 0x708($v1)
    /* 6030C 8006FB0C 0000038E */  lw         $v1, 0x0($s0)
    /* 60310 8006FB10 21100002 */  addu       $v0, $s0, $zero
    /* 60314 8006FB14 140760AC */  sw         $zero, 0x714($v1)
    /* 60318 8006FB18 0000448C */  lw         $a0, 0x0($v0)
    /* 6031C 8006FB1C 01000324 */  addiu      $v1, $zero, 0x1
    /* 60320 8006FB20 910083A0 */  sb         $v1, 0x91($a0)
    /* 60324 8006FB24 1400BF8F */  lw         $ra, 0x14($sp)
    /* 60328 8006FB28 1000B08F */  lw         $s0, 0x10($sp)
    /* 6032C 8006FB2C 0800E003 */  jr         $ra
    /* 60330 8006FB30 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel __14AIState_NormalP8Car_tObj
