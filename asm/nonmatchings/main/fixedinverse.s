.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching fixedinverse, 0x38

glabel fixedinverse
    /* DDBEC 800ED3EC FFFF0824 */  addiu      $t0, $zero, -0x1
    /* DDBF0 800ED3F0 C3570400 */  sra        $t2, $a0, 31
    /* DDBF4 800ED3F4 26488A00 */  xor        $t1, $a0, $t2
    /* DDBF8 800ED3F8 23482A01 */  subu       $t1, $t1, $t2
    /* DDBFC 800ED3FC 1B000901 */  divu       $zero, $t0, $t1
    /* DDC00 800ED400 00000000 */  nop
    /* DDC04 800ED404 43580900 */  sra        $t3, $t1, 1
    /* DDC08 800ED408 12100000 */  mflo       $v0
    /* DDC0C 800ED40C 10180000 */  mfhi       $v1
    /* DDC10 800ED410 2B606301 */  sltu       $t4, $t3, $v1
    /* DDC14 800ED414 21104C00 */  addu       $v0, $v0, $t4
    /* DDC18 800ED418 26104A00 */  xor        $v0, $v0, $t2
    /* DDC1C 800ED41C 0800E003 */  jr         $ra
    /* DDC20 800ED420 23104A00 */   subu      $v0, $v0, $t2
endlabel fixedinverse
