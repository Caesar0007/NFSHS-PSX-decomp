.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CalcObjExtentPoints__FP8coorddefP8CCOORD16T0P5tQuat, 0xCC

glabel CalcObjExtentPoints__FP8coorddefP8CCOORD16T0P5tQuat
    /* 9531C 800A4B1C 98FFBD27 */  addiu      $sp, $sp, -0x68
    /* 95320 800A4B20 6400BFAF */  sw         $ra, 0x64($sp)
    /* 95324 800A4B24 6000B2AF */  sw         $s2, 0x60($sp)
    /* 95328 800A4B28 5C00B1AF */  sw         $s1, 0x5C($sp)
    /* 9532C 800A4B2C 5800B0AF */  sw         $s0, 0x58($sp)
    /* 95330 800A4B30 0000918C */  lw         $s1, 0x0($a0)
    /* 95334 800A4B34 0000A284 */  lh         $v0, 0x0($a1)
    /* 95338 800A4B38 0800928C */  lw         $s2, 0x8($a0)
    /* 9533C 800A4B3C 80120200 */  sll        $v0, $v0, 10
    /* 95340 800A4B40 3800A2AF */  sw         $v0, 0x38($sp)
    /* 95344 800A4B44 0400A284 */  lh         $v0, 0x4($a1)
    /* 95348 800A4B48 2180C000 */  addu       $s0, $a2, $zero
    /* 9534C 800A4B4C 80120200 */  sll        $v0, $v0, 10
    /* 95350 800A4B50 4000A2AF */  sw         $v0, 0x40($sp)
    /* 95354 800A4B54 0800A284 */  lh         $v0, 0x8($a1)
    /* 95358 800A4B58 2120E000 */  addu       $a0, $a3, $zero
    /* 9535C 800A4B5C 80120200 */  sll        $v0, $v0, 10
    /* 95360 800A4B60 4800A2AF */  sw         $v0, 0x48($sp)
    /* 95364 800A4B64 0C00A284 */  lh         $v0, 0xC($a1)
    /* 95368 800A4B68 1000A527 */  addiu      $a1, $sp, 0x10
    /* 9536C 800A4B6C 80120200 */  sll        $v0, $v0, 10
    /* 95370 800A4B70 5000A2AF */  sw         $v0, 0x50($sp)
    /* 95374 800A4B74 000011AE */  sw         $s1, 0x0($s0)
    /* 95378 800A4B78 E0B5020C */  jal        Quatern_QuatToMat__FP5tQuatP10matrixtdef
    /* 9537C 800A4B7C 080012AE */   sw        $s2, 0x8($s0)
    /* 95380 800A4B80 3800A427 */  addiu      $a0, $sp, 0x38
    /* 95384 800A4B84 1000A527 */  addiu      $a1, $sp, 0x10
    /* 95388 800A4B88 B6AB030C */  jal        transform
    /* 9538C 800A4B8C 0C000626 */   addiu     $a2, $s0, 0xC
    /* 95390 800A4B90 4800A427 */  addiu      $a0, $sp, 0x48
    /* 95394 800A4B94 1000A527 */  addiu      $a1, $sp, 0x10
    /* 95398 800A4B98 B6AB030C */  jal        transform
    /* 9539C 800A4B9C 18000626 */   addiu     $a2, $s0, 0x18
    /* 953A0 800A4BA0 0C00028E */  lw         $v0, 0xC($s0)
    /* 953A4 800A4BA4 1400038E */  lw         $v1, 0x14($s0)
    /* 953A8 800A4BA8 21105100 */  addu       $v0, $v0, $s1
    /* 953AC 800A4BAC 0C0002AE */  sw         $v0, 0xC($s0)
    /* 953B0 800A4BB0 1800028E */  lw         $v0, 0x18($s0)
    /* 953B4 800A4BB4 21187200 */  addu       $v1, $v1, $s2
    /* 953B8 800A4BB8 140003AE */  sw         $v1, 0x14($s0)
    /* 953BC 800A4BBC 2000038E */  lw         $v1, 0x20($s0)
    /* 953C0 800A4BC0 21105100 */  addu       $v0, $v0, $s1
    /* 953C4 800A4BC4 21187200 */  addu       $v1, $v1, $s2
    /* 953C8 800A4BC8 180002AE */  sw         $v0, 0x18($s0)
    /* 953CC 800A4BCC 200003AE */  sw         $v1, 0x20($s0)
    /* 953D0 800A4BD0 6400BF8F */  lw         $ra, 0x64($sp)
    /* 953D4 800A4BD4 6000B28F */  lw         $s2, 0x60($sp)
    /* 953D8 800A4BD8 5C00B18F */  lw         $s1, 0x5C($sp)
    /* 953DC 800A4BDC 5800B08F */  lw         $s0, 0x58($sp)
    /* 953E0 800A4BE0 0800E003 */  jr         $ra
    /* 953E4 800A4BE4 6800BD27 */   addiu     $sp, $sp, 0x68
endlabel CalcObjExtentPoints__FP8coorddefP8CCOORD16T0P5tQuat
