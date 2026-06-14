.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIInit_LoadConfigs__Fv, 0x5C

glabel AIInit_LoadConfigs__Fv
    /* 577F8 80066FF8 80FFBD27 */  addiu      $sp, $sp, -0x80
    /* 577FC 80066FFC 1000A427 */  addiu      $a0, $sp, 0x10
    /* 57800 80067000 1180023C */  lui        $v0, %hi(D_80116470)
    /* 57804 80067004 0580053C */  lui        $a1, %hi(D_8005522C)
    /* 57808 80067008 7064468C */  lw         $a2, %lo(D_80116470)($v0)
    /* 5780C 8006700C 2C52A524 */  addiu      $a1, $a1, %lo(D_8005522C)
    /* 57810 80067010 7C00BFAF */  sw         $ra, 0x7C($sp)
    /* 57814 80067014 2F91030C */  jal        sprintf
    /* 57818 80067018 7800B0AF */   sw        $s0, 0x78($sp)
    /* 5781C 8006701C 21200000 */  addu       $a0, $zero, $zero
    /* 57820 80067020 1180053C */  lui        $a1, %hi(trafcfg)
    /* 57824 80067024 60D5A524 */  addiu      $a1, $a1, %lo(trafcfg)
    /* 57828 80067028 82EE020C */  jal        Udff_Opena__FPcT0i
    /* 5782C 8006702C 01000624 */   addiu     $a2, $zero, 0x1
    /* 57830 80067030 21804000 */  addu       $s0, $v0, $zero
    /* 57834 80067034 159C010C */  jal        AIInit_LoadPhysicsConfig__FP10Udff_tInfo
    /* 57838 80067038 21200002 */   addu      $a0, $s0, $zero
    /* 5783C 8006703C B4EE020C */  jal        Udff_Close__FP10Udff_tInfo
    /* 57840 80067040 21200002 */   addu      $a0, $s0, $zero
    /* 57844 80067044 7C00BF8F */  lw         $ra, 0x7C($sp)
    /* 57848 80067048 7800B08F */  lw         $s0, 0x78($sp)
    /* 5784C 8006704C 0800E003 */  jr         $ra
    /* 57850 80067050 8000BD27 */   addiu     $sp, $sp, 0x80
endlabel AIInit_LoadConfigs__Fv
