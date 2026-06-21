.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching filterchunk, 0x50

glabel filterchunk
    /* ECDE4 800FC5E4 1400838C */  lw         $v1, 0x14($a0)
    /* ECDE8 800FC5E8 0000A58C */  lw         $a1, 0x0($a1)
    /* ECDEC 800FC5EC 0F006018 */  blez       $v1, .L800FC62C
    /* ECDF0 800FC5F0 21300000 */   addu      $a2, $zero, $zero
    /* ECDF4 800FC5F4 21386000 */  addu       $a3, $v1, $zero
    /* ECDF8 800FC5F8 1000848C */  lw         $a0, 0x10($a0)
  .L800FC5FC:
    /* ECDFC 800FC5FC 00000000 */  nop
    /* ECE00 800FC600 0000828C */  lw         $v0, 0x0($a0)
    /* ECE04 800FC604 0400838C */  lw         $v1, 0x4($a0)
    /* ECE08 800FC608 2410A200 */  and        $v0, $a1, $v0
    /* ECE0C 800FC60C 04004314 */  bne        $v0, $v1, .L800FC620
    /* ECE10 800FC610 0100C624 */   addiu     $a2, $a2, 0x1
    /* ECE14 800FC614 0800828C */  lw         $v0, 0x8($a0)
    /* ECE18 800FC618 0800E003 */  jr         $ra
    /* ECE1C 800FC61C 00000000 */   nop
  .L800FC620:
    /* ECE20 800FC620 2A10C700 */  slt        $v0, $a2, $a3
    /* ECE24 800FC624 F5FF4014 */  bnez       $v0, .L800FC5FC
    /* ECE28 800FC628 0C008424 */   addiu     $a0, $a0, 0xC
  .L800FC62C:
    /* ECE2C 800FC62C 0800E003 */  jr         $ra
    /* ECE30 800FC630 FEFF0224 */   addiu     $v0, $zero, -0x2
endlabel filterchunk
