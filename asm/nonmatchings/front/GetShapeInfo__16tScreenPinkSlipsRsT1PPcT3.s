.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetShapeInfo__16tScreenPinkSlipsRsT1PPcT3, 0xC0

glabel GetShapeInfo__16tScreenPinkSlipsRsT1PPcT3
    /* 29918 80039118 A0FFBD27 */  addiu      $sp, $sp, -0x60
    /* 2991C 8003911C 5400B5AF */  sw         $s5, 0x54($sp)
    /* 29920 80039120 21A88000 */  addu       $s5, $a0, $zero
    /* 29924 80039124 4400B1AF */  sw         $s1, 0x44($sp)
    /* 29928 80039128 2188A000 */  addu       $s1, $a1, $zero
    /* 2992C 8003912C 4800B2AF */  sw         $s2, 0x48($sp)
    /* 29930 80039130 2190C000 */  addu       $s2, $a2, $zero
    /* 29934 80039134 5000B4AF */  sw         $s4, 0x50($sp)
    /* 29938 80039138 21A0E000 */  addu       $s4, $a3, $zero
    /* 2993C 8003913C 1180043C */  lui        $a0, %hi(trackManager)
    /* 29940 80039140 1180023C */  lui        $v0, %hi(D_80114623)
    /* 29944 80039144 23464590 */  lbu        $a1, %lo(D_80114623)($v0)
    /* 29948 80039148 504A8424 */  addiu      $a0, $a0, %lo(trackManager)
    /* 2994C 8003914C 4C00B3AF */  sw         $s3, 0x4C($sp)
    /* 29950 80039150 7000B38F */  lw         $s3, 0x70($sp)
    /* 29954 80039154 1000A627 */  addiu      $a2, $sp, 0x10
    /* 29958 80039158 5800BFAF */  sw         $ra, 0x58($sp)
    /* 2995C 8003915C A986000C */  jal        GetTrack__13tTrackManagersR17tTrackInformation
    /* 29960 80039160 4000B0AF */   sw        $s0, 0x40($sp)
    /* 29964 80039164 0580103C */  lui        $s0, %hi(D_80052C00)
    /* 29968 80039168 002C1026 */  addiu      $s0, $s0, %lo(D_80052C00)
    /* 2996C 8003916C 21200002 */  addu       $a0, $s0, $zero
    /* 29970 80039170 39000224 */  addiu      $v0, $zero, 0x39
    /* 29974 80039174 000022A6 */  sh         $v0, 0x0($s1)
    /* 29978 80039178 04000224 */  addiu      $v0, $zero, 0x4
    /* 2997C 8003917C 000042A6 */  sh         $v0, 0x0($s2)
    /* 29980 80039180 0180023C */  lui        $v0, %hi(D_8001191C)
    /* 29984 80039184 1C194224 */  addiu      $v0, $v0, %lo(D_8001191C)
    /* 29988 80039188 0180053C */  lui        $a1, %hi(D_80011924)
    /* 2998C 8003918C 000082AE */  sw         $v0, 0x0($s4)
    /* 29990 80039190 1000A683 */  lb         $a2, 0x10($sp)
    /* 29994 80039194 2F91030C */  jal        sprintf
    /* 29998 80039198 2419A524 */   addiu     $a1, $a1, %lo(D_80011924)
    /* 2999C 8003919C 000070AE */  sw         $s0, 0x0($s3)
    /* 299A0 800391A0 1000A293 */  lbu        $v0, 0x10($sp)
    /* 299A4 800391A4 00000000 */  nop
    /* 299A8 800391A8 00160200 */  sll        $v0, $v0, 24
    /* 299AC 800391AC 03160200 */  sra        $v0, $v0, 24
    /* 299B0 800391B0 7000A2A6 */  sh         $v0, 0x70($s5)
    /* 299B4 800391B4 5800BF8F */  lw         $ra, 0x58($sp)
    /* 299B8 800391B8 5400B58F */  lw         $s5, 0x54($sp)
    /* 299BC 800391BC 5000B48F */  lw         $s4, 0x50($sp)
    /* 299C0 800391C0 4C00B38F */  lw         $s3, 0x4C($sp)
    /* 299C4 800391C4 4800B28F */  lw         $s2, 0x48($sp)
    /* 299C8 800391C8 4400B18F */  lw         $s1, 0x44($sp)
    /* 299CC 800391CC 4000B08F */  lw         $s0, 0x40($sp)
    /* 299D0 800391D0 0800E003 */  jr         $ra
    /* 299D4 800391D4 6000BD27 */   addiu     $sp, $sp, 0x60
endlabel GetShapeInfo__16tScreenPinkSlipsRsT1PPcT3
