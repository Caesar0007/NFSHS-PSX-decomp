.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching fixedcos, 0x84

glabel fixedcos
    /* DDCA4 800ED4A4 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* DDCA8 800ED4A8 1000B0AF */  sw         $s0, 0x10($sp)
    /* DDCAC 800ED4AC 21808000 */  addu       $s0, $a0, $zero
    /* DDCB0 800ED4B0 1400B1AF */  sw         $s1, 0x14($sp)
    /* DDCB4 800ED4B4 83891000 */  sra        $s1, $s0, 6
    /* DDCB8 800ED4B8 1800BFAF */  sw         $ra, 0x18($sp)
    /* DDCBC 800ED4BC 39C6030C */  jal        intcos
    /* DDCC0 800ED4C0 21202002 */   addu      $a0, $s1, $zero
    /* DDCC4 800ED4C4 21202002 */  addu       $a0, $s1, $zero
    /* DDCC8 800ED4C8 3AC6030C */  jal        intsin
    /* DDCCC 800ED4CC 21884000 */   addu      $s1, $v0, $zero
    /* DDCD0 800ED4D0 23100200 */  negu       $v0, $v0
    /* DDCD4 800ED4D4 3F001032 */  andi       $s0, $s0, 0x3F
    /* DDCD8 800ED4D8 40181000 */  sll        $v1, $s0, 1
    /* DDCDC 800ED4DC 21187000 */  addu       $v1, $v1, $s0
    /* DDCE0 800ED4E0 80210300 */  sll        $a0, $v1, 6
    /* DDCE4 800ED4E4 21186400 */  addu       $v1, $v1, $a0
    /* DDCE8 800ED4E8 40190300 */  sll        $v1, $v1, 5
    /* DDCEC 800ED4EC 23187000 */  subu       $v1, $v1, $s0
    /* DDCF0 800ED4F0 40210300 */  sll        $a0, $v1, 5
    /* DDCF4 800ED4F4 21186400 */  addu       $v1, $v1, $a0
    /* DDCF8 800ED4F8 40180300 */  sll        $v1, $v1, 1
    /* DDCFC 800ED4FC 431A0300 */  sra        $v1, $v1, 9
    /* DDD00 800ED500 83100200 */  sra        $v0, $v0, 2
    /* DDD04 800ED504 18004300 */  mult       $v0, $v1
    /* DDD08 800ED508 1800BF8F */  lw         $ra, 0x18($sp)
    /* DDD0C 800ED50C 1000B08F */  lw         $s0, 0x10($sp)
    /* DDD10 800ED510 12280000 */  mflo       $a1
    /* DDD14 800ED514 43150500 */  sra        $v0, $a1, 21
    /* DDD18 800ED518 21102202 */  addu       $v0, $s1, $v0
    /* DDD1C 800ED51C 1400B18F */  lw         $s1, 0x14($sp)
    /* DDD20 800ED520 0800E003 */  jr         $ra
    /* DDD24 800ED524 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel fixedcos
