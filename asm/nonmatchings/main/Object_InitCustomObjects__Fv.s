.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Object_InitCustomObjects__Fv, 0x84

glabel Object_InitCustomObjects__Fv
    /* 95D88 800A5588 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 95D8C 800A558C 0580043C */  lui        $a0, %hi(D_80056054)
    /* 95D90 800A5590 54608424 */  addiu      $a0, $a0, %lo(D_80056054)
    /* 95D94 800A5594 00040524 */  addiu      $a1, $zero, 0x400
    /* 95D98 800A5598 21300000 */  addu       $a2, $zero, $zero
    /* 95D9C 800A559C 1400BFAF */  sw         $ra, 0x14($sp)
    /* 95DA0 800A55A0 CF94030C */  jal        reservememadr
    /* 95DA4 800A55A4 1000B0AF */   sw        $s0, 0x10($sp)
    /* 95DA8 800A55A8 0580103C */  lui        $s0, %hi(D_80056064)
    /* 95DAC 800A55AC 64601026 */  addiu      $s0, $s0, %lo(D_80056064)
    /* 95DB0 800A55B0 21200002 */  addu       $a0, $s0, $zero
    /* 95DB4 800A55B4 00040524 */  addiu      $a1, $zero, 0x400
    /* 95DB8 800A55B8 21300000 */  addu       $a2, $zero, $zero
    /* 95DBC 800A55BC 7C0D82AF */  sw         $v0, %gp_rel(Object_customObjInst)($gp)
    /* 95DC0 800A55C0 CF94030C */  jal        reservememadr
    /* 95DC4 800A55C4 000040AC */   sw        $zero, 0x0($v0)
    /* 95DC8 800A55C8 04004424 */  addiu      $a0, $v0, 0x4
    /* 95DCC 800A55CC FC030524 */  addiu      $a1, $zero, 0x3FC
    /* 95DD0 800A55D0 21300000 */  addu       $a2, $zero, $zero
    /* 95DD4 800A55D4 800D82AF */  sw         $v0, %gp_rel(Object_customSimObjs)($gp)
    /* 95DD8 800A55D8 E9C5030C */  jal        blockfill
    /* 95DDC 800A55DC 000040AC */   sw        $zero, 0x0($v0)
    /* 95DE0 800A55E0 21200002 */  addu       $a0, $s0, $zero
    /* 95DE4 800A55E4 00040524 */  addiu      $a1, $zero, 0x400
    /* 95DE8 800A55E8 CF94030C */  jal        reservememadr
    /* 95DEC 800A55EC 21300000 */   addu      $a2, $zero, $zero
    /* 95DF0 800A55F0 000040AC */  sw         $zero, 0x0($v0)
    /* 95DF4 800A55F4 1400BF8F */  lw         $ra, 0x14($sp)
    /* 95DF8 800A55F8 1000B08F */  lw         $s0, 0x10($sp)
    /* 95DFC 800A55FC 840D82AF */  sw         $v0, %gp_rel(Object_customSFXInst)($gp)
    /* 95E00 800A5600 880D80AF */  sw         $zero, %gp_rel(Object_customSliceNum)($gp)
    /* 95E04 800A5604 0800E003 */  jr         $ra
    /* 95E08 800A5608 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Object_InitCustomObjects__Fv
