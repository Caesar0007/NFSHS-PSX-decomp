.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching stup1, 0x78

glabel stup1
    /* D4850 800E4050 04000224 */  addiu      $v0, $zero, 0x4
    /* D4854 800E4054 00000000 */  nop
    /* D4858 800E4058 00000000 */  nop
    /* D485C 800E405C 00000000 */  nop
    /* D4860 800E4060 00000000 */  nop
    /* D4864 800E4064 0E80043C */  lui        $a0, %hi(D_800E40D8)
    /* D4868 800E4068 D8408424 */  addiu      $a0, $a0, %lo(D_800E40D8)
    /* D486C 800E406C 21208200 */  addu       $a0, $a0, $v0
    /* D4870 800E4070 0000828C */  lw         $v0, 0x0($a0)
    /* D4874 800E4074 0080083C */  lui        $t0, %hi(D_80000004)
    /* D4878 800E4078 25E84800 */  or         $sp, $v0, $t0
    /* D487C 800E407C 1580043C */  lui        $a0, %hi(__last_org)
    /* D4880 800E4080 048B8424 */  addiu      $a0, $a0, %lo(__last_org)
    /* D4884 800E4084 C0200400 */  sll        $a0, $a0, 3
    /* D4888 800E4088 C2200400 */  srl        $a0, $a0, 3
    /* D488C 800E408C 1380033C */  lui        $v1, %hi(_stacksize)
    /* D4890 800E4090 D06C638C */  lw         $v1, %lo(_stacksize)($v1)
    /* D4894 800E4094 00000000 */  nop
    /* D4898 800E4098 23284300 */  subu       $a1, $v0, $v1
    /* D489C 800E409C 2328A400 */  subu       $a1, $a1, $a0
    /* D48A0 800E40A0 25208800 */  or         $a0, $a0, $t0
    /* D48A4 800E40A4 1480013C */  lui        $at, %hi(D_8013DE5C)
    /* D48A8 800E40A8 5CDE3FAC */  sw         $ra, %lo(D_8013DE5C)($at)
    /* D48AC 800E40AC 14801C3C */  lui        $gp, %hi(_gp)
    /* D48B0 800E40B0 4CC59C27 */  addiu      $gp, $gp, %lo(_gp)
    /* D48B4 800E40B4 21F0A003 */  addu       $fp, $sp, $zero
    /* D48B8 800E40B8 46F7030C */  jal        InitHeap
    /* D48BC 800E40BC 04008420 */   addi      $a0, $a0, %lo(D_80000004) /* handwritten instruction */
    /* D48C0 800E40C0 14801F3C */  lui        $ra, %hi(D_8013DE5C)
    /* D48C4 800E40C4 5CDEFF8F */  lw         $ra, %lo(D_8013DE5C)($ra)
endlabel stup1
    /* D48C8 800E40C8 00000000 */  nop
