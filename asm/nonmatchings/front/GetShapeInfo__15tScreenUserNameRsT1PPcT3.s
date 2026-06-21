.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetShapeInfo__15tScreenUserNameRsT1PPcT3, 0x60

glabel GetShapeInfo__15tScreenUserNameRsT1PPcT3
    /* 3B848 8004B048 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 3B84C 8004B04C 1400B1AF */  sw         $s1, 0x14($sp)
    /* 3B850 8004B050 2188E000 */  addu       $s1, $a3, $zero
    /* 3B854 8004B054 1000B0AF */  sw         $s0, 0x10($sp)
    /* 3B858 8004B058 0580103C */  lui        $s0, %hi(UserPermFileName)
    /* 3B85C 8004B05C B8291026 */  addiu      $s0, $s0, %lo(UserPermFileName)
    /* 3B860 8004B060 3000A28F */  lw         $v0, 0x30($sp)
    /* 3B864 8004B064 21200002 */  addu       $a0, $s0, $zero
    /* 3B868 8004B068 1800BFAF */  sw         $ra, 0x18($sp)
    /* 3B86C 8004B06C 000040AC */  sw         $zero, 0x0($v0)
    /* 3B870 8004B070 5C000224 */  addiu      $v0, $zero, 0x5C
    /* 3B874 8004B074 0000C0A4 */  sh         $zero, 0x0($a2)
    /* 3B878 8004B078 0000A2A4 */  sh         $v0, 0x0($a1)
    /* 3B87C 8004B07C 0180053C */  lui        $a1, %hi(D_800125E0)
    /* 3B880 8004B080 1180023C */  lui        $v0, %hi(D_80114940)
    /* 3B884 8004B084 40494690 */  lbu        $a2, %lo(D_80114940)($v0)
    /* 3B888 8004B088 2F91030C */  jal        sprintf
    /* 3B88C 8004B08C E025A524 */   addiu     $a1, $a1, %lo(D_800125E0)
    /* 3B890 8004B090 000030AE */  sw         $s0, 0x0($s1)
    /* 3B894 8004B094 1800BF8F */  lw         $ra, 0x18($sp)
    /* 3B898 8004B098 1400B18F */  lw         $s1, 0x14($sp)
    /* 3B89C 8004B09C 1000B08F */  lw         $s0, 0x10($sp)
    /* 3B8A0 8004B0A0 0800E003 */  jr         $ra
    /* 3B8A4 8004B0A4 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel GetShapeInfo__15tScreenUserNameRsT1PPcT3
