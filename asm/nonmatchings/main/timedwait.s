.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching timedwait, 0x4C

glabel timedwait
    /* D8A84 800E8284 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* D8A88 800E8288 1000B0AF */  sw         $s0, 0x10($sp)
    /* D8A8C 800E828C 1400BFAF */  sw         $ra, 0x14($sp)
    /* D8A90 800E8290 88A0030C */  jal        gettick
    /* D8A94 800E8294 21808000 */   addu      $s0, $a0, $zero
    /* D8A98 800E8298 21805000 */  addu       $s0, $v0, $s0
  .L800E829C:
    /* D8A9C 800E829C 88A0030C */  jal        gettick
    /* D8AA0 800E82A0 00000000 */   nop
    /* D8AA4 800E82A4 23105000 */  subu       $v0, $v0, $s0
    /* D8AA8 800E82A8 05004104 */  bgez       $v0, .L800E82C0
    /* D8AAC 800E82AC 00000000 */   nop
    /* D8AB0 800E82B0 019B030C */  jal        systemtask
    /* D8AB4 800E82B4 21200000 */   addu      $a0, $zero, $zero
    /* D8AB8 800E82B8 A7A00308 */  j          .L800E829C
    /* D8ABC 800E82BC 00000000 */   nop
  .L800E82C0:
    /* D8AC0 800E82C0 1400BF8F */  lw         $ra, 0x14($sp)
    /* D8AC4 800E82C4 1000B08F */  lw         $s0, 0x10($sp)
    /* D8AC8 800E82C8 0800E003 */  jr         $ra
    /* D8ACC 800E82CC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel timedwait
