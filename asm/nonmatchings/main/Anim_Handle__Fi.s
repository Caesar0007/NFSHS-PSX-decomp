.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Anim_Handle__Fi, 0x84

glabel Anim_Handle__Fi
    /* 644E8 80073CE8 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 644EC 80073CEC 1800B2AF */  sw         $s2, 0x18($sp)
    /* 644F0 80073CF0 21908000 */  addu       $s2, $a0, $zero
    /* 644F4 80073CF4 1000B0AF */  sw         $s0, 0x10($sp)
    /* 644F8 80073CF8 21800000 */  addu       $s0, $zero, $zero
    /* 644FC 80073CFC 1180023C */  lui        $v0, %hi(animSlots)
    /* 64500 80073D00 1400B1AF */  sw         $s1, 0x14($sp)
    /* 64504 80073D04 4CE15124 */  addiu      $s1, $v0, %lo(animSlots)
    /* 64508 80073D08 21182002 */  addu       $v1, $s1, $zero
    /* 6450C 80073D0C 1C00BFAF */  sw         $ra, 0x1C($sp)
  .L80073D10:
    /* 64510 80073D10 0000628C */  lw         $v0, 0x0($v1)
    /* 64514 80073D14 00000000 */  nop
    /* 64518 80073D18 05004010 */  beqz       $v0, .L80073D30
    /* 6451C 80073D1C 00000000 */   nop
    /* 64520 80073D20 01001026 */  addiu      $s0, $s0, 0x1
    /* 64524 80073D24 2000022A */  slti       $v0, $s0, 0x20
    /* 64528 80073D28 F9FF4014 */  bnez       $v0, .L80073D10
    /* 6452C 80073D2C 04006324 */   addiu     $v1, $v1, 0x4
  .L80073D30:
    /* 64530 80073D30 578F020C */  jal        __builtin_new
    /* 64534 80073D34 14000424 */   addiu     $a0, $zero, 0x14
    /* 64538 80073D38 21204000 */  addu       $a0, $v0, $zero
    /* 6453C 80073D3C D8D0010C */  jal        __10AnimScripti
    /* 64540 80073D40 21284002 */   addu      $a1, $s2, $zero
    /* 64544 80073D44 80181000 */  sll        $v1, $s0, 2
    /* 64548 80073D48 21187100 */  addu       $v1, $v1, $s1
    /* 6454C 80073D4C 000062AC */  sw         $v0, 0x0($v1)
    /* 64550 80073D50 21100002 */  addu       $v0, $s0, $zero
    /* 64554 80073D54 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 64558 80073D58 1800B28F */  lw         $s2, 0x18($sp)
    /* 6455C 80073D5C 1400B18F */  lw         $s1, 0x14($sp)
    /* 64560 80073D60 1000B08F */  lw         $s0, 0x10($sp)
    /* 64564 80073D64 0800E003 */  jr         $ra
    /* 64568 80073D68 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Anim_Handle__Fi
