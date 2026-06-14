.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Anim_FreeHandle__Fi, 0x80

glabel Anim_FreeHandle__Fi
    /* 6456C 80073D6C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 64570 80073D70 1400B1AF */  sw         $s1, 0x14($sp)
    /* 64574 80073D74 21888000 */  addu       $s1, $a0, $zero
    /* 64578 80073D78 1180033C */  lui        $v1, %hi(animSlots)
    /* 6457C 80073D7C 4CE16324 */  addiu      $v1, $v1, %lo(animSlots)
    /* 64580 80073D80 80101100 */  sll        $v0, $s1, 2
    /* 64584 80073D84 21104300 */  addu       $v0, $v0, $v1
    /* 64588 80073D88 1800BFAF */  sw         $ra, 0x18($sp)
    /* 6458C 80073D8C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 64590 80073D90 0000508C */  lw         $s0, 0x0($v0)
    /* 64594 80073D94 00000000 */  nop
    /* 64598 80073D98 0A000012 */  beqz       $s0, .L80073DC4
    /* 6459C 80073D9C 1180033C */   lui       $v1, %hi(animSlots)
    /* 645A0 80073DA0 1000048E */  lw         $a0, 0x10($s0)
    /* 645A4 80073DA4 00000000 */  nop
    /* 645A8 80073DA8 03008010 */  beqz       $a0, .L80073DB8
    /* 645AC 80073DAC 00000000 */   nop
    /* 645B0 80073DB0 738F020C */  jal        __builtin_vec_delete
    /* 645B4 80073DB4 00000000 */   nop
  .L80073DB8:
    /* 645B8 80073DB8 6B8F020C */  jal        __builtin_delete
    /* 645BC 80073DBC 21200002 */   addu      $a0, $s0, $zero
    /* 645C0 80073DC0 1180033C */  lui        $v1, %hi(animSlots)
  .L80073DC4:
    /* 645C4 80073DC4 4CE16324 */  addiu      $v1, $v1, %lo(animSlots)
    /* 645C8 80073DC8 80101100 */  sll        $v0, $s1, 2
    /* 645CC 80073DCC 21104300 */  addu       $v0, $v0, $v1
    /* 645D0 80073DD0 000040AC */  sw         $zero, 0x0($v0)
    /* 645D4 80073DD4 1800BF8F */  lw         $ra, 0x18($sp)
    /* 645D8 80073DD8 1400B18F */  lw         $s1, 0x14($sp)
    /* 645DC 80073DDC 1000B08F */  lw         $s0, 0x10($sp)
    /* 645E0 80073DE0 21100000 */  addu       $v0, $zero, $zero
    /* 645E4 80073DE4 0800E003 */  jr         $ra
    /* 645E8 80073DE8 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Anim_FreeHandle__Fi
