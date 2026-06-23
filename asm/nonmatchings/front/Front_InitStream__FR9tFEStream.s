.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Front_InitStream__FR9tFEStream, 0x30

glabel Front_InitStream__FR9tFEStream
    /* 18868 80028068 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 1886C 8002806C 1000BFAF */  sw         $ra, 0x10($sp)
    /* 18870 80028070 000080A4 */  sh         $zero, 0x0($a0)
    /* 18874 80028074 020080A4 */  sh         $zero, 0x2($a0)
    /* 18878 80028078 040080A4 */  sh         $zero, 0x4($a0)
    /* 1887C 8002807C 1180043C */  lui        $a0, %hi(carManager)
    /* 18880 80028080 5E5D000C */  jal        InitializeIngameCarList__11tCarManager
    /* 18884 80028084 74428424 */   addiu     $a0, $a0, %lo(carManager)
    /* 18888 80028088 1000BF8F */  lw         $ra, 0x10($sp)
    /* 1888C 8002808C 00000000 */  nop
    /* 18890 80028090 0800E003 */  jr         $ra
    /* 18894 80028094 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Front_InitStream__FR9tFEStream
