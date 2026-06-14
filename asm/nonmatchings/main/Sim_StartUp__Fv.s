.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Sim_StartUp__Fv, 0x114

glabel Sim_StartUp__Fv
    /* A6D74 800B6574 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* A6D78 800B6578 1480043C */  lui        $a0, %hi(D_8013D410)
    /* A6D7C 800B657C 10D48424 */  addiu      $a0, $a0, %lo(D_8013D410)
    /* A6D80 800B6580 46000524 */  addiu      $a1, $zero, 0x46
    /* A6D84 800B6584 1280023C */  lui        $v0, %hi(simVar)
    /* A6D88 800B6588 01000324 */  addiu      $v1, $zero, 0x1
    /* A6D8C 800B658C C4E043AC */  sw         $v1, %lo(simVar)($v0)
    /* A6D90 800B6590 C4E04224 */  addiu      $v0, $v0, %lo(simVar)
    /* A6D94 800B6594 1000B0AF */  sw         $s0, 0x10($sp)
    /* A6D98 800B6598 1280103C */  lui        $s0, %hi(simGlobal)
    /* A6D9C 800B659C 1400BFAF */  sw         $ra, 0x14($sp)
    /* A6DA0 800B65A0 040040AC */  sw         $zero, 0x4($v0)
    /* A6DA4 800B65A4 080040AC */  sw         $zero, 0x8($v0)
    /* A6DA8 800B65A8 100040AC */  sw         $zero, 0x10($v0)
    /* A6DAC 800B65AC 140040AC */  sw         $zero, 0x14($v0)
    /* A6DB0 800B65B0 180040AC */  sw         $zero, 0x18($v0)
    /* A6DB4 800B65B4 0C0040AC */  sw         $zero, 0xC($v0)
    /* A6DB8 800B65B8 ACE000AE */  sw         $zero, %lo(simGlobal)($s0)
    /* A6DBC 800B65BC ACE01026 */  addiu      $s0, $s0, %lo(simGlobal)
    /* A6DC0 800B65C0 BCD8020C */  jal        Sched_CreateNewSchedule__FPci
    /* A6DC4 800B65C4 040000AE */   sw        $zero, 0x4($s0)
    /* A6DC8 800B65C8 1480043C */  lui        $a0, %hi(D_8013D418)
    /* A6DCC 800B65CC 18D48424 */  addiu      $a0, $a0, %lo(D_8013D418)
    /* A6DD0 800B65D0 0B000524 */  addiu      $a1, $zero, 0xB
    /* A6DD4 800B65D4 BCD8020C */  jal        Sched_CreateNewSchedule__FPci
    /* A6DD8 800B65D8 100002AE */   sw        $v0, 0x10($s0)
    /* A6DDC 800B65DC 1480043C */  lui        $a0, %hi(D_8013D420)
    /* A6DE0 800B65E0 20D48424 */  addiu      $a0, $a0, %lo(D_8013D420)
    /* A6DE4 800B65E4 1A000524 */  addiu      $a1, $zero, 0x1A
    /* A6DE8 800B65E8 BCD8020C */  jal        Sched_CreateNewSchedule__FPci
    /* A6DEC 800B65EC 140002AE */   sw        $v0, 0x14($s0)
    /* A6DF0 800B65F0 1180033C */  lui        $v1, %hi(D_80113244)
    /* A6DF4 800B65F4 4432648C */  lw         $a0, %lo(D_80113244)($v1)
    /* A6DF8 800B65F8 F46C020C */  jal        FastRandom_StartUp__FUi
    /* A6DFC 800B65FC 0C0002AE */   sw        $v0, 0xC($s0)
    /* A6E00 800B6600 6B9A010C */  jal        AICop_StartUp__Fv
    /* A6E04 800B6604 00000000 */   nop
    /* A6E08 800B6608 EC9A010C */  jal        AIInit_StartUp1__Fv
    /* A6E0C 800B660C 00000000 */   nop
    /* A6E10 800B6610 45B7020C */  jal        R3DCar_StartUp__Fv
    /* A6E14 800B6614 00000000 */   nop
    /* A6E18 800B6618 C4EF020C */  jal        CarIO_StartUp__Fv
    /* A6E1C 800B661C 00000000 */   nop
    /* A6E20 800B6620 7629020C */  jal        Cars_StartUp__Fv
    /* A6E24 800B6624 00000000 */   nop
    /* A6E28 800B6628 79B7020C */  jal        R3DCar_PostStartUp__Fv
    /* A6E2C 800B662C 00000000 */   nop
    /* A6E30 800B6630 656B010C */  jal        AIHigh_StartUp__Fv
    /* A6E34 800B6634 00000000 */   nop
    /* A6E38 800B6638 806C030C */  jal        Loading_UpdateLoadingScreen__Fi
    /* A6E3C 800B663C 08000424 */   addiu     $a0, $zero, 0x8
    /* A6E40 800B6640 806C030C */  jal        Loading_UpdateLoadingScreen__Fi
    /* A6E44 800B6644 09000424 */   addiu     $a0, $zero, 0x9
    /* A6E48 800B6648 099B010C */  jal        AIInit_StartUp2__Fv
    /* A6E4C 800B664C 00000000 */   nop
    /* A6E50 800B6650 806C030C */  jal        Loading_UpdateLoadingScreen__Fi
    /* A6E54 800B6654 0A000424 */   addiu     $a0, $zero, 0xA
    /* A6E58 800B6658 9DDA010C */  jal        AudioCmn_Init__Fv
    /* A6E5C 800B665C 00000000 */   nop
    /* A6E60 800B6660 0880053C */  lui        $a1, %hi(Camera_Update__Fv)
    /* A6E64 800B6664 D833A524 */  addiu      $a1, $a1, %lo(Camera_Update__Fv)
    /* A6E68 800B6668 21300000 */  addu       $a2, $zero, $zero
    /* A6E6C 800B666C 0C00048E */  lw         $a0, 0xC($s0)
    /* A6E70 800B6670 E0D8020C */  jal        Sched_AddFunction__FP15Sched_tSchedulePFPv_vPvi
    /* A6E74 800B6674 64000724 */   addiu     $a3, $zero, 0x64
    /* A6E78 800B6678 1400BF8F */  lw         $ra, 0x14($sp)
    /* A6E7C 800B667C 1000B08F */  lw         $s0, 0x10($sp)
    /* A6E80 800B6680 0800E003 */  jr         $ra
    /* A6E84 800B6684 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Sim_StartUp__Fv
