.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CalcObjYawAngle__FP8CCOORD16, 0x38

glabel CalcObjYawAngle__FP8CCOORD16
    /* 952E4 800A4AE4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 952E8 800A4AE8 1000BFAF */  sw         $ra, 0x10($sp)
    /* 952EC 800A4AEC 08008684 */  lh         $a2, 0x8($a0)
    /* 952F0 800A4AF0 00008284 */  lh         $v0, 0x0($a0)
    /* 952F4 800A4AF4 0C008384 */  lh         $v1, 0xC($a0)
    /* 952F8 800A4AF8 04008584 */  lh         $a1, 0x4($a0)
    /* 952FC 800A4AFC 2320C200 */  subu       $a0, $a2, $v0
    /* 95300 800A4B00 4AB5030C */  jal        fixedatan
    /* 95304 800A4B04 23286500 */   subu      $a1, $v1, $a1
    /* 95308 800A4B08 00C04224 */  addiu      $v0, $v0, -0x4000
    /* 9530C 800A4B0C 1000BF8F */  lw         $ra, 0x10($sp)
    /* 95310 800A4B10 03120200 */  sra        $v0, $v0, 8
    /* 95314 800A4B14 0800E003 */  jr         $ra
    /* 95318 800A4B18 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel CalcObjYawAngle__FP8CCOORD16
