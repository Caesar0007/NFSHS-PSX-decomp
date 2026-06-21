.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SwapInController__23tScreenControllerConfig, 0x8C

glabel SwapInController__23tScreenControllerConfig
    /* 33EEC 800436EC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 33EF0 800436F0 1000B0AF */  sw         $s0, 0x10($sp)
    /* 33EF4 800436F4 21808000 */  addu       $s0, $a0, $zero
    /* 33EF8 800436F8 1400BFAF */  sw         $ra, 0x14($sp)
    /* 33EFC 800436FC 96000386 */  lh         $v1, 0x96($s0)
    /* 33F00 80043700 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 33F04 80043704 0D006210 */  beq        $v1, $v0, .L8004373C
    /* 33F08 80043708 0580043C */   lui       $a0, %hi(D_800520E8)
    /* 33F0C 8004370C E8208424 */  addiu      $a0, $a0, %lo(D_800520E8)
    /* 33F10 80043710 80180300 */  sll        $v1, $v1, 2
    /* 33F14 80043714 21186400 */  addu       $v1, $v1, $a0
    /* 33F18 80043718 74010292 */  lbu        $v0, 0x174($s0)
    /* 33F1C 8004371C 0000658C */  lw         $a1, 0x0($v1)
    /* 33F20 80043720 80100200 */  sll        $v0, $v0, 2
    /* 33F24 80043724 21104400 */  addu       $v0, $v0, $a0
    /* 33F28 80043728 0000448C */  lw         $a0, 0x0($v0)
    /* 33F2C 8004372C 5F97030C */  jal        strcmp
    /* 33F30 80043730 00000000 */   nop
    /* 33F34 80043734 0C004010 */  beqz       $v0, .L80043768
    /* 33F38 80043738 00000000 */   nop
  .L8004373C:
    /* 33F3C 8004373C 0580023C */  lui        $v0, %hi(D_800520E8)
    /* 33F40 80043740 74010392 */  lbu        $v1, 0x174($s0)
    /* 33F44 80043744 E8204224 */  addiu      $v0, $v0, %lo(D_800520E8)
    /* 33F48 80043748 80180300 */  sll        $v1, $v1, 2
    /* 33F4C 8004374C 21186200 */  addu       $v1, $v1, $v0
    /* 33F50 80043750 0000658C */  lw         $a1, 0x0($v1)
    /* 33F54 80043754 6E97000C */  jal        AsyncLoadSwapShapeFile__7tScreenPc
    /* 33F58 80043758 21200002 */   addu      $a0, $s0, $zero
    /* 33F5C 8004375C 74010292 */  lbu        $v0, 0x174($s0)
    /* 33F60 80043760 00000000 */  nop
    /* 33F64 80043764 960002A6 */  sh         $v0, 0x96($s0)
  .L80043768:
    /* 33F68 80043768 1400BF8F */  lw         $ra, 0x14($sp)
    /* 33F6C 8004376C 1000B08F */  lw         $s0, 0x10($sp)
    /* 33F70 80043770 0800E003 */  jr         $ra
    /* 33F74 80043774 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel SwapInController__23tScreenControllerConfig
