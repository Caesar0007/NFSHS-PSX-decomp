.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching fixedmult, 0x2C

glabel fixedmult
    /* D4B28 800E4328 18008500 */  mult       $a0, $a1
    /* D4B2C 800E432C 00800A34 */  ori        $t2, $zero, 0x8000
    /* D4B30 800E4330 12400000 */  mflo       $t0
    /* D4B34 800E4334 10480000 */  mfhi       $t1
    /* D4B38 800E4338 21400A01 */  addu       $t0, $t0, $t2
    /* D4B3C 800E433C 2B500A01 */  sltu       $t2, $t0, $t2
    /* D4B40 800E4340 21482A01 */  addu       $t1, $t1, $t2
    /* D4B44 800E4344 02540800 */  srl        $t2, $t0, 16
    /* D4B48 800E4348 005C0900 */  sll        $t3, $t1, 16
    /* D4B4C 800E434C 0800E003 */  jr         $ra
    /* D4B50 800E4350 25104B01 */   or        $v0, $t2, $t3
endlabel fixedmult
