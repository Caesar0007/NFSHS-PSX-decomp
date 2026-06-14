.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Draw_CircleClip__FP8coorddefT0i, 0x60

glabel Draw_CircleClip__FP8coorddefT0i
    /* B983C 800C903C 0000838C */  lw         $v1, 0x0($a0)
    /* B9840 800C9040 0000A28C */  lw         $v0, 0x0($a1)
    /* B9844 800C9044 00000000 */  nop
    /* B9848 800C9048 23386200 */  subu       $a3, $v1, $v0
    /* B984C 800C904C 0200E01C */  bgtz       $a3, .L800C9058
    /* B9850 800C9050 00000000 */   nop
    /* B9854 800C9054 23384300 */  subu       $a3, $v0, $v1
  .L800C9058:
    /* B9858 800C9058 0800848C */  lw         $a0, 0x8($a0)
    /* B985C 800C905C 0800A58C */  lw         $a1, 0x8($a1)
    /* B9860 800C9060 00000000 */  nop
    /* B9864 800C9064 23188500 */  subu       $v1, $a0, $a1
    /* B9868 800C9068 0300601C */  bgtz       $v1, .L800C9078
    /* B986C 800C906C 2A106700 */   slt       $v0, $v1, $a3
    /* B9870 800C9070 2318A400 */  subu       $v1, $a1, $a0
    /* B9874 800C9074 2A106700 */  slt        $v0, $v1, $a3
  .L800C9078:
    /* B9878 800C9078 04004010 */  beqz       $v0, .L800C908C
    /* B987C 800C907C 00000000 */   nop
    /* B9880 800C9080 83100300 */  sra        $v0, $v1, 2
    /* B9884 800C9084 25240308 */  j          .L800C9094
    /* B9888 800C9088 2110E200 */   addu      $v0, $a3, $v0
  .L800C908C:
    /* B988C 800C908C 83100700 */  sra        $v0, $a3, 2
    /* B9890 800C9090 21106200 */  addu       $v0, $v1, $v0
  .L800C9094:
    /* B9894 800C9094 0800E003 */  jr         $ra
    /* B9898 800C9098 2A104600 */   slt       $v0, $v0, $a2
endlabel Draw_CircleClip__FP8coorddefT0i
