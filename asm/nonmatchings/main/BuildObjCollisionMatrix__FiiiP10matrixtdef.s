.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching BuildObjCollisionMatrix__FiiiP10matrixtdef, 0xA4

glabel BuildObjCollisionMatrix__FiiiP10matrixtdef
    /* 953E8 800A4BE8 60FFBD27 */  addiu      $sp, $sp, -0xA0
    /* 953EC 800A4BEC 8800B0AF */  sw         $s0, 0x88($sp)
    /* 953F0 800A4BF0 21808000 */  addu       $s0, $a0, $zero
    /* 953F4 800A4BF4 8C00B1AF */  sw         $s1, 0x8C($sp)
    /* 953F8 800A4BF8 2188A000 */  addu       $s1, $a1, $zero
    /* 953FC 800A4BFC 9000B2AF */  sw         $s2, 0x90($sp)
    /* 95400 800A4C00 2190C000 */  addu       $s2, $a2, $zero
    /* 95404 800A4C04 9400B3AF */  sw         $s3, 0x94($sp)
    /* 95408 800A4C08 2198E000 */  addu       $s3, $a3, $zero
    /* 9540C 800A4C0C 23201200 */  negu       $a0, $s2
    /* 95410 800A4C10 0100053C */  lui        $a1, (0x10000 >> 16)
    /* 95414 800A4C14 9800BFAF */  sw         $ra, 0x98($sp)
    /* 95418 800A4C18 CA90030C */  jal        fixedmult
    /* 9541C 800A4C1C 2328B000 */   subu      $a1, $a1, $s0
    /* 95420 800A4C20 23201100 */  negu       $a0, $s1
    /* 95424 800A4C24 21280002 */  addu       $a1, $s0, $zero
    /* 95428 800A4C28 CA90030C */  jal        fixedmult
    /* 9542C 800A4C2C 21804000 */   addu      $s0, $v0, $zero
    /* 95430 800A4C30 3800B127 */  addiu      $s1, $sp, 0x38
    /* 95434 800A4C34 21202002 */  addu       $a0, $s1, $zero
    /* 95438 800A4C38 04AB030C */  jal        fixedxformy
    /* 9543C 800A4C3C 21280202 */   addu      $a1, $s0, $v0
    /* 95440 800A4C40 1000A427 */  addiu      $a0, $sp, 0x10
    /* 95444 800A4C44 04AB030C */  jal        fixedxformy
    /* 95448 800A4C48 21284002 */   addu      $a1, $s2, $zero
    /* 9544C 800A4C4C 21202002 */  addu       $a0, $s1, $zero
    /* 95450 800A4C50 21286002 */  addu       $a1, $s3, $zero
    /* 95454 800A4C54 6000B027 */  addiu      $s0, $sp, 0x60
    /* 95458 800A4C58 6377020C */  jal        Math_fasttransmult__FP10matrixtdefN20
    /* 9545C 800A4C5C 21300002 */   addu      $a2, $s0, $zero
    /* 95460 800A4C60 21200002 */  addu       $a0, $s0, $zero
    /* 95464 800A4C64 1000A527 */  addiu      $a1, $sp, 0x10
    /* 95468 800A4C68 6377020C */  jal        Math_fasttransmult__FP10matrixtdefN20
    /* 9546C 800A4C6C 21306002 */   addu      $a2, $s3, $zero
    /* 95470 800A4C70 9800BF8F */  lw         $ra, 0x98($sp)
    /* 95474 800A4C74 9400B38F */  lw         $s3, 0x94($sp)
    /* 95478 800A4C78 9000B28F */  lw         $s2, 0x90($sp)
    /* 9547C 800A4C7C 8C00B18F */  lw         $s1, 0x8C($sp)
    /* 95480 800A4C80 8800B08F */  lw         $s0, 0x88($sp)
    /* 95484 800A4C84 0800E003 */  jr         $ra
    /* 95488 800A4C88 A000BD27 */   addiu     $sp, $sp, 0xA0
endlabel BuildObjCollisionMatrix__FiiiP10matrixtdef
