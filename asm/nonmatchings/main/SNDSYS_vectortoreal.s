.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SNDSYS_vectortoreal, 0x4C

glabel SNDSYS_vectortoreal
    /* E2950 800F2150 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* E2954 800F2154 1000B0AF */  sw         $s0, 0x10($sp)
    /* E2958 800F2158 1380103C */  lui        $s0, %hi(D_80134A6C)
    /* E295C 800F215C 6C4A028E */  lw         $v0, %lo(D_80134A6C)($s0)
    /* E2960 800F2160 00000000 */  nop
    /* E2964 800F2164 08004014 */  bnez       $v0, .L800F2188
    /* E2968 800F2168 1400BFAF */   sw        $ra, 0x14($sp)
    /* E296C 800F216C 0F80043C */  lui        $a0, %hi(iSNDsystemtaskreal)
    /* E2970 800F2170 30218424 */  addiu      $a0, $a0, %lo(iSNDsystemtaskreal)
    /* E2974 800F2174 21280000 */  addu       $a1, $zero, $zero
    /* E2978 800F2178 BD9A030C */  jal        addsystemtask
    /* E297C 800F217C 01000624 */   addiu     $a2, $zero, 0x1
    /* E2980 800F2180 01000224 */  addiu      $v0, $zero, 0x1
    /* E2984 800F2184 6C4A02AE */  sw         $v0, %lo(D_80134A6C)($s0)
  .L800F2188:
    /* E2988 800F2188 1400BF8F */  lw         $ra, 0x14($sp)
    /* E298C 800F218C 1000B08F */  lw         $s0, 0x10($sp)
    /* E2990 800F2190 21100000 */  addu       $v0, $zero, $zero
    /* E2994 800F2194 0800E003 */  jr         $ra
    /* E2998 800F2198 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel SNDSYS_vectortoreal
