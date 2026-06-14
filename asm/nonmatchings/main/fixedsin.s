.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching fixedsin, 0x80

glabel fixedsin
    /* DDC24 800ED424 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* DDC28 800ED428 1000B0AF */  sw         $s0, 0x10($sp)
    /* DDC2C 800ED42C 21808000 */  addu       $s0, $a0, $zero
    /* DDC30 800ED430 1400B1AF */  sw         $s1, 0x14($sp)
    /* DDC34 800ED434 83891000 */  sra        $s1, $s0, 6
    /* DDC38 800ED438 1800BFAF */  sw         $ra, 0x18($sp)
    /* DDC3C 800ED43C 3AC6030C */  jal        intsin
    /* DDC40 800ED440 21202002 */   addu      $a0, $s1, $zero
    /* DDC44 800ED444 21202002 */  addu       $a0, $s1, $zero
    /* DDC48 800ED448 39C6030C */  jal        intcos
    /* DDC4C 800ED44C 21884000 */   addu      $s1, $v0, $zero
    /* DDC50 800ED450 3F001032 */  andi       $s0, $s0, 0x3F
    /* DDC54 800ED454 40181000 */  sll        $v1, $s0, 1
    /* DDC58 800ED458 21187000 */  addu       $v1, $v1, $s0
    /* DDC5C 800ED45C 80210300 */  sll        $a0, $v1, 6
    /* DDC60 800ED460 21186400 */  addu       $v1, $v1, $a0
    /* DDC64 800ED464 40190300 */  sll        $v1, $v1, 5
    /* DDC68 800ED468 23187000 */  subu       $v1, $v1, $s0
    /* DDC6C 800ED46C 40210300 */  sll        $a0, $v1, 5
    /* DDC70 800ED470 21186400 */  addu       $v1, $v1, $a0
    /* DDC74 800ED474 40180300 */  sll        $v1, $v1, 1
    /* DDC78 800ED478 431A0300 */  sra        $v1, $v1, 9
    /* DDC7C 800ED47C 83100200 */  sra        $v0, $v0, 2
    /* DDC80 800ED480 18004300 */  mult       $v0, $v1
    /* DDC84 800ED484 1800BF8F */  lw         $ra, 0x18($sp)
    /* DDC88 800ED488 1000B08F */  lw         $s0, 0x10($sp)
    /* DDC8C 800ED48C 12280000 */  mflo       $a1
    /* DDC90 800ED490 43150500 */  sra        $v0, $a1, 21
    /* DDC94 800ED494 21102202 */  addu       $v0, $s1, $v0
    /* DDC98 800ED498 1400B18F */  lw         $s1, 0x14($sp)
    /* DDC9C 800ED49C 0800E003 */  jr         $ra
    /* DDCA0 800ED4A0 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel fixedsin
