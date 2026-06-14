.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Clock_SystemStartUp__Fv, 0x5C

glabel Clock_SystemStartUp__Fv
    /* 7C1E4 8008B9E4 D402828F */  lw         $v0, %gp_rel(D_8013C820)($gp)
    /* 7C1E8 8008B9E8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 7C1EC 8008B9EC 1000BFAF */  sw         $ra, 0x10($sp)
    /* 7C1F0 8008B9F0 D80280AF */  sw         $zero, %gp_rel(stopClock)($gp)
    /* 7C1F4 8008B9F4 DC0280AF */  sw         $zero, %gp_rel(generic128HzClock)($gp)
    /* 7C1F8 8008B9F8 0C004014 */  bnez       $v0, .L8008BA2C
    /* 7C1FC 8008B9FC 01000224 */   addiu     $v0, $zero, 0x1
    /* 7C200 8008BA00 0980043C */  lui        $a0, %hi(Clock_MasterInterruptHandler__Fv)
    /* 7C204 8008BA04 D40282AF */  sw         $v0, %gp_rel(D_8013C820)($gp)
    /* 7C208 8008BA08 FAAB030C */  jal        addtimer
    /* 7C20C 8008BA0C 38B98424 */   addiu     $a0, $a0, %lo(Clock_MasterInterruptHandler__Fv)
    /* 7C210 8008BA10 1180023C */  lui        $v0, %hi(clock_realTime)
    /* 7C214 8008BA14 240C40AC */  sw         $zero, %lo(clock_realTime)($v0)
    /* 7C218 8008BA18 240C4224 */  addiu      $v0, $v0, %lo(clock_realTime)
    /* 7C21C 8008BA1C 040040AC */  sw         $zero, 0x4($v0)
    /* 7C220 8008BA20 080040AC */  sw         $zero, 0x8($v0)
    /* 7C224 8008BA24 1480013C */  lui        $at, %hi(Input_gTime)
    /* 7C228 8008BA28 20D220AC */  sw         $zero, %lo(Input_gTime)($at)
  .L8008BA2C:
    /* 7C22C 8008BA2C 1000BF8F */  lw         $ra, 0x10($sp)
    /* 7C230 8008BA30 1480013C */  lui        $at, %hi(R3DCar_ClockLast)
    /* 7C234 8008BA34 ACD320AC */  sw         $zero, %lo(R3DCar_ClockLast)($at)
    /* 7C238 8008BA38 0800E003 */  jr         $ra
    /* 7C23C 8008BA3C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Clock_SystemStartUp__Fv
