.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching StSetStream, 0x84

glabel StSetStream
    /* E97F8 800F8FF8 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* E97FC 800F8FFC 1000B0AF */  sw         $s0, 0x10($sp)
    /* E9800 800F9000 21808000 */  addu       $s0, $a0, $zero
    /* E9804 800F9004 1400B1AF */  sw         $s1, 0x14($sp)
    /* E9808 800F9008 2188E000 */  addu       $s1, $a3, $zero
    /* E980C 800F900C 1800B2AF */  sw         $s2, 0x18($sp)
    /* E9810 800F9010 3000B28F */  lw         $s2, 0x30($sp)
    /* E9814 800F9014 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* E9818 800F9018 1722040C */  jal        StSetMask
    /* E981C 800F901C 01000424 */   addiu     $a0, $zero, 0x1
    /* E9820 800F9020 01001032 */  andi       $s0, $s0, 0x1
    /* E9824 800F9024 1480013C */  lui        $at, %hi(StEmu_Addr)
    /* E9828 800F9028 7C6C20AC */  sw         $zero, %lo(StEmu_Addr)($at)
    /* E982C 800F902C 1480013C */  lui        $at, %hi(StFunc1)
    /* E9830 800F9030 744831AC */  sw         $s1, %lo(StFunc1)($at)
    /* E9834 800F9034 1480013C */  lui        $at, %hi(StRgb24)
    /* E9838 800F9038 906C30AC */  sw         $s0, %lo(StRgb24)($at)
    /* E983C 800F903C 1480013C */  lui        $at, %hi(CChannel)
    /* E9840 800F9040 846C20AC */  sw         $zero, %lo(CChannel)($at)
    /* E9844 800F9044 1480013C */  lui        $at, %hi(StCHANNEL)
    /* E9848 800F9048 886C20AC */  sw         $zero, %lo(StCHANNEL)($at)
    /* E984C 800F904C 1480013C */  lui        $at, %hi(Stsector_offset)
    /* E9850 800F9050 A06C20A4 */  sh         $zero, %lo(Stsector_offset)($at)
    /* E9854 800F9054 1480013C */  lui        $at, %hi(Stframe_no)
    /* E9858 800F9058 8C6C20AC */  sw         $zero, %lo(Stframe_no)($at)
    /* E985C 800F905C 1480013C */  lui        $at, %hi(StFunc2)
    /* E9860 800F9060 784832AC */  sw         $s2, %lo(StFunc2)($at)
    /* E9864 800F9064 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* E9868 800F9068 1800B28F */  lw         $s2, 0x18($sp)
    /* E986C 800F906C 1400B18F */  lw         $s1, 0x14($sp)
    /* E9870 800F9070 1000B08F */  lw         $s0, 0x10($sp)
    /* E9874 800F9074 0800E003 */  jr         $ra
    /* E9878 800F9078 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel StSetStream
    /* E987C 800F907C 00000000 */  nop
    /* E9880 800F9080 00000000 */  nop
    /* E9884 800F9084 00000000 */  nop
