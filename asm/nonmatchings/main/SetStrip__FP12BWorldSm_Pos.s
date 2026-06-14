.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SetStrip__FP12BWorldSm_Pos, 0xB8

glabel SetStrip__FP12BWorldSm_Pos
    /* 6F6E0 8007EEE0 75008390 */  lbu        $v1, 0x75($a0)
    /* 6F6E4 8007EEE4 21280000 */  addu       $a1, $zero, $zero
    /* 6F6E8 8007EEE8 C0100300 */  sll        $v0, $v1, 3
    /* 6F6EC 8007EEEC 23104300 */  subu       $v0, $v0, $v1
    /* 6F6F0 8007EEF0 1480033C */  lui        $v1, %hi(Track_chunkList)
    /* 6F6F4 8007EEF4 B8D4638C */  lw         $v1, %lo(Track_chunkList)($v1)
    /* 6F6F8 8007EEF8 00110200 */  sll        $v0, $v0, 4
    /* 6F6FC 8007EEFC 21104300 */  addu       $v0, $v0, $v1
    /* 6F700 8007EF00 8000838C */  lw         $v1, 0x80($a0)
    /* 6F704 8007EF04 3800428C */  lw         $v0, 0x38($v0)
    /* 6F708 8007EF08 00006690 */  lbu        $a2, 0x0($v1)
    /* 6F70C 8007EF0C 04004224 */  addiu      $v0, $v0, 0x4
    /* 6F710 8007EF10 0C00C010 */  beqz       $a2, .L8007EF44
    /* 6F714 8007EF14 7C0082AC */   sw        $v0, 0x7C($a0)
  .L8007EF18:
    /* 6F718 8007EF18 7C00828C */  lw         $v0, 0x7C($a0)
    /* 6F71C 8007EF1C 00000000 */  nop
    /* 6F720 8007EF20 02004390 */  lbu        $v1, 0x2($v0)
    /* 6F724 8007EF24 0100A524 */  addiu      $a1, $a1, 0x1
    /* 6F728 8007EF28 40180300 */  sll        $v1, $v1, 1
    /* 6F72C 8007EF2C 04006324 */  addiu      $v1, $v1, 0x4
    /* 6F730 8007EF30 21104300 */  addu       $v0, $v0, $v1
    /* 6F734 8007EF34 7C0082AC */  sw         $v0, 0x7C($a0)
    /* 6F738 8007EF38 2A10A600 */  slt        $v0, $a1, $a2
    /* 6F73C 8007EF3C F6FF4014 */  bnez       $v0, .L8007EF18
    /* 6F740 8007EF40 00000000 */   nop
  .L8007EF44:
    /* 6F744 8007EF44 7C00828C */  lw         $v0, 0x7C($a0)
    /* 6F748 8007EF48 74008580 */  lb         $a1, 0x74($a0)
    /* 6F74C 8007EF4C 02004390 */  lbu        $v1, 0x2($v0)
    /* 6F750 8007EF50 00000000 */  nop
    /* 6F754 8007EF54 2A10A300 */  slt        $v0, $a1, $v1
    /* 6F758 8007EF58 0D004014 */  bnez       $v0, .L8007EF90
    /* 6F75C 8007EF5C 00000000 */   nop
    /* 6F760 8007EF60 2328A300 */  subu       $a1, $a1, $v1
  .L8007EF64:
    /* 6F764 8007EF64 40100300 */  sll        $v0, $v1, 1
    /* 6F768 8007EF68 7C00838C */  lw         $v1, 0x7C($a0)
    /* 6F76C 8007EF6C 04004224 */  addiu      $v0, $v0, 0x4
    /* 6F770 8007EF70 21186200 */  addu       $v1, $v1, $v0
    /* 6F774 8007EF74 7C0083AC */  sw         $v1, 0x7C($a0)
    /* 6F778 8007EF78 02006390 */  lbu        $v1, 0x2($v1)
    /* 6F77C 8007EF7C 00000000 */  nop
    /* 6F780 8007EF80 2A10A300 */  slt        $v0, $a1, $v1
    /* 6F784 8007EF84 F7FF4010 */  beqz       $v0, .L8007EF64
    /* 6F788 8007EF88 2328A300 */   subu      $a1, $a1, $v1
    /* 6F78C 8007EF8C 2128A300 */  addu       $a1, $a1, $v1
  .L8007EF90:
    /* 6F790 8007EF90 0800E003 */  jr         $ra
    /* 6F794 8007EF94 020085A4 */   sh        $a1, 0x2($a0)
endlabel SetStrip__FP12BWorldSm_Pos
