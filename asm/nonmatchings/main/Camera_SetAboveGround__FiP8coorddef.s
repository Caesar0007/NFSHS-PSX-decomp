.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Camera_SetAboveGround__FiP8coorddef, 0x8C

glabel Camera_SetAboveGround__FiP8coorddef
    /* 7500C 8008480C D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 75010 80084810 2400B1AF */  sw         $s1, 0x24($sp)
    /* 75014 80084814 2188A000 */  addu       $s1, $a1, $zero
    /* 75018 80084818 2000B0AF */  sw         $s0, 0x20($sp)
    /* 7501C 8008481C 00810400 */  sll        $s0, $a0, 4
    /* 75020 80084820 21800402 */  addu       $s0, $s0, $a0
    /* 75024 80084824 00811000 */  sll        $s0, $s0, 4
    /* 75028 80084828 1180023C */  lui        $v0, %hi(D_8010F338)
    /* 7502C 8008482C 38F34224 */  addiu      $v0, $v0, %lo(D_8010F338)
    /* 75030 80084830 21800202 */  addu       $s0, $s0, $v0
    /* 75034 80084834 2800BFAF */  sw         $ra, 0x28($sp)
    /* 75038 80084838 4801020C */  jal        BWorldSm_UNormal__FP12BWorldSm_Pos
    /* 7503C 8008483C 21200002 */   addu      $a0, $s0, $zero
    /* 75040 80084840 21202002 */  addu       $a0, $s1, $zero
    /* 75044 80084844 1000A527 */  addiu      $a1, $sp, 0x10
    /* 75048 80084848 0000478C */  lw         $a3, 0x0($v0)
    /* 7504C 8008484C 0400488C */  lw         $t0, 0x4($v0)
    /* 75050 80084850 0800498C */  lw         $t1, 0x8($v0)
    /* 75054 80084854 1000A7AF */  sw         $a3, 0x10($sp)
    /* 75058 80084858 1400A8AF */  sw         $t0, 0x14($sp)
    /* 7505C 8008485C 1800A9AF */  sw         $t1, 0x18($sp)
    /* 75060 80084860 CC7E020C */  jal        Newton_FindGroundElevationGeneral__FP8coorddefN20
    /* 75064 80084864 08000626 */   addiu     $a2, $s0, 0x8
    /* 75068 80084868 0100043C */  lui        $a0, (0x10000 >> 16)
    /* 7506C 8008486C 0400238E */  lw         $v1, 0x4($s1)
    /* 75070 80084870 21104400 */  addu       $v0, $v0, $a0
    /* 75074 80084874 2A186200 */  slt        $v1, $v1, $v0
    /* 75078 80084878 02006010 */  beqz       $v1, .L80084884
    /* 7507C 8008487C 00000000 */   nop
    /* 75080 80084880 040022AE */  sw         $v0, 0x4($s1)
  .L80084884:
    /* 75084 80084884 2800BF8F */  lw         $ra, 0x28($sp)
    /* 75088 80084888 2400B18F */  lw         $s1, 0x24($sp)
    /* 7508C 8008488C 2000B08F */  lw         $s0, 0x20($sp)
    /* 75090 80084890 0800E003 */  jr         $ra
    /* 75094 80084894 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel Camera_SetAboveGround__FiP8coorddef
