.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Object_GetAnim__FP13Trk_SimObject, 0x2C

glabel Object_GetAnim__FP13Trk_SimObject
    /* 95AC4 800A52C4 08008010 */  beqz       $a0, .L800A52E8
    /* 95AC8 800A52C8 1180033C */   lui       $v1, %hi(gSimObjAnims)
    /* 95ACC 800A52CC 0E008284 */  lh         $v0, 0xE($a0)
    /* 95AD0 800A52D0 605D6324 */  addiu      $v1, $v1, %lo(gSimObjAnims)
    /* 95AD4 800A52D4 80100200 */  sll        $v0, $v0, 2
    /* 95AD8 800A52D8 21104300 */  addu       $v0, $v0, $v1
    /* 95ADC 800A52DC 0000428C */  lw         $v0, 0x0($v0)
    /* 95AE0 800A52E0 0800E003 */  jr         $ra
    /* 95AE4 800A52E4 00000000 */   nop
  .L800A52E8:
    /* 95AE8 800A52E8 0800E003 */  jr         $ra
    /* 95AEC 800A52EC 21100000 */   addu      $v0, $zero, $zero
endlabel Object_GetAnim__FP13Trk_SimObject
