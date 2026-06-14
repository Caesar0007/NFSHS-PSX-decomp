.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Souffle_CircleClip__FP8coorddefT0i, 0x60

glabel Souffle_CircleClip__FP8coorddefT0i
    /* A8588 800B7D88 0000838C */  lw         $v1, 0x0($a0)
    /* A858C 800B7D8C 0000A28C */  lw         $v0, 0x0($a1)
    /* A8590 800B7D90 00000000 */  nop
    /* A8594 800B7D94 23386200 */  subu       $a3, $v1, $v0
    /* A8598 800B7D98 0200E01C */  bgtz       $a3, .L800B7DA4
    /* A859C 800B7D9C 00000000 */   nop
    /* A85A0 800B7DA0 23384300 */  subu       $a3, $v0, $v1
  .L800B7DA4:
    /* A85A4 800B7DA4 0800848C */  lw         $a0, 0x8($a0)
    /* A85A8 800B7DA8 0800A58C */  lw         $a1, 0x8($a1)
    /* A85AC 800B7DAC 00000000 */  nop
    /* A85B0 800B7DB0 23188500 */  subu       $v1, $a0, $a1
    /* A85B4 800B7DB4 0300601C */  bgtz       $v1, .L800B7DC4
    /* A85B8 800B7DB8 2A106700 */   slt       $v0, $v1, $a3
    /* A85BC 800B7DBC 2318A400 */  subu       $v1, $a1, $a0
    /* A85C0 800B7DC0 2A106700 */  slt        $v0, $v1, $a3
  .L800B7DC4:
    /* A85C4 800B7DC4 04004010 */  beqz       $v0, .L800B7DD8
    /* A85C8 800B7DC8 00000000 */   nop
    /* A85CC 800B7DCC 83100300 */  sra        $v0, $v1, 2
    /* A85D0 800B7DD0 78DF0208 */  j          .L800B7DE0
    /* A85D4 800B7DD4 2110E200 */   addu      $v0, $a3, $v0
  .L800B7DD8:
    /* A85D8 800B7DD8 83100700 */  sra        $v0, $a3, 2
    /* A85DC 800B7DDC 21106200 */  addu       $v0, $v1, $v0
  .L800B7DE0:
    /* A85E0 800B7DE0 0800E003 */  jr         $ra
    /* A85E4 800B7DE4 2A104600 */   slt       $v0, $v0, $a2
endlabel Souffle_CircleClip__FP8coorddefT0i
