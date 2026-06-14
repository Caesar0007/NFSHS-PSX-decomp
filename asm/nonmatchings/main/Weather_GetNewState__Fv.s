.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Weather_GetNewState__Fv, 0x40

glabel Weather_GetNewState__Fv
    /* D28EC 800E20EC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* D28F0 800E20F0 1000BFAF */  sw         $ra, 0x10($sp)
    /* D28F4 800E20F4 EA9D030C */  jal        random
    /* D28F8 800E20F8 00000000 */   nop
    /* D28FC 800E20FC 03004430 */  andi       $a0, $v0, 0x3
    /* D2900 800E2100 02008228 */  slti       $v0, $a0, 0x2
    /* D2904 800E2104 05004014 */  bnez       $v0, .L800E211C
    /* D2908 800E2108 21100000 */   addu      $v0, $zero, $zero
    /* D290C 800E210C 02000324 */  addiu      $v1, $zero, 0x2
    /* D2910 800E2110 02008310 */  beq        $a0, $v1, .L800E211C
    /* D2914 800E2114 01000224 */   addiu     $v0, $zero, 0x1
    /* D2918 800E2118 FFFF0224 */  addiu      $v0, $zero, -0x1
  .L800E211C:
    /* D291C 800E211C 1000BF8F */  lw         $ra, 0x10($sp)
    /* D2920 800E2120 00000000 */  nop
    /* D2924 800E2124 0800E003 */  jr         $ra
    /* D2928 800E2128 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Weather_GetNewState__Fv
