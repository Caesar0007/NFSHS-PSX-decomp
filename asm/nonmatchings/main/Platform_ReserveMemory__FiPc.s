.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Platform_ReserveMemory__FiPc, 0x4C

glabel Platform_ReserveMemory__FiPc
    /* CCAE8 800DC2E8 03008224 */  addiu      $v0, $a0, 0x3
    /* CCAEC 800DC2EC 02004104 */  bgez       $v0, .L800DC2F8
    /* CCAF0 800DC2F0 21184000 */   addu      $v1, $v0, $zero
    /* CCAF4 800DC2F4 03004324 */  addiu      $v1, $v0, 0x3
  .L800DC2F8:
    /* CCAF8 800DC2F8 83100300 */  sra        $v0, $v1, 2
    /* CCAFC 800DC2FC 6C15858F */  lw         $a1, %gp_rel(gCurrentMemory)($gp)
    /* CCB00 800DC300 80100200 */  sll        $v0, $v0, 2
    /* CCB04 800DC304 2120A200 */  addu       $a0, $a1, $v0
    /* CCB08 800DC308 6415828F */  lw         $v0, %gp_rel(gLowMemory)($gp)
    /* CCB0C 800DC30C 7015838F */  lw         $v1, %gp_rel(gTotalMemory)($gp)
    /* CCB10 800DC310 23108200 */  subu       $v0, $a0, $v0
    /* CCB14 800DC314 2A186200 */  slt        $v1, $v1, $v0
    /* CCB18 800DC318 04006014 */  bnez       $v1, .L800DC32C
    /* CCB1C 800DC31C 2110A000 */   addu      $v0, $a1, $zero
    /* CCB20 800DC320 6C1584AF */  sw         $a0, %gp_rel(gCurrentMemory)($gp)
    /* CCB24 800DC324 0800E003 */  jr         $ra
    /* CCB28 800DC328 00000000 */   nop
  .L800DC32C:
    /* CCB2C 800DC32C 0800E003 */  jr         $ra
    /* CCB30 800DC330 21100000 */   addu      $v0, $zero, $zero
endlabel Platform_ReserveMemory__FiPc
