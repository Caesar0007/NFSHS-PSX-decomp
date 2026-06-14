.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AISpeeds_NeedToSlowDownForCurve__FP8Car_tObjiii, 0xA4

glabel AISpeeds_NeedToSlowDownForCurve__FP8Car_tObjiii
    /* 5E690 8006DE90 2A10C700 */  slt        $v0, $a2, $a3
    /* 5E694 8006DE94 25004014 */  bnez       $v0, .L8006DF2C
    /* 5E698 8006DE98 21100000 */   addu      $v0, $zero, $zero
    /* 5E69C 8006DE9C B806848C */  lw         $a0, 0x6B8($a0)
    /* 5E6A0 8006DEA0 0200C104 */  bgez       $a2, .L8006DEAC
    /* 5E6A4 8006DEA4 FFFF0234 */   ori       $v0, $zero, 0xFFFF
    /* 5E6A8 8006DEA8 2130C200 */  addu       $a2, $a2, $v0
  .L8006DEAC:
    /* 5E6AC 8006DEAC 03340600 */  sra        $a2, $a2, 16
    /* 5E6B0 8006DEB0 0300C104 */  bgez       $a2, .L8006DEC0
    /* 5E6B4 8006DEB4 8000C228 */   slti      $v0, $a2, 0x80
    /* 5E6B8 8006DEB8 23300600 */  negu       $a2, $a2
    /* 5E6BC 8006DEBC 8000C228 */  slti       $v0, $a2, 0x80
  .L8006DEC0:
    /* 5E6C0 8006DEC0 03004014 */  bnez       $v0, .L8006DED0
    /* 5E6C4 8006DEC4 21108600 */   addu      $v0, $a0, $a2
    /* 5E6C8 8006DEC8 80000624 */  addiu      $a2, $zero, 0x80
    /* 5E6CC 8006DECC 21108600 */  addu       $v0, $a0, $a2
  .L8006DED0:
    /* 5E6D0 8006DED0 00004290 */  lbu        $v0, 0x0($v0)
    /* 5E6D4 8006DED4 0300E104 */  bgez       $a3, .L8006DEE4
    /* 5E6D8 8006DED8 401C0200 */   sll       $v1, $v0, 17
    /* 5E6DC 8006DEDC FFFF0234 */  ori        $v0, $zero, 0xFFFF
    /* 5E6E0 8006DEE0 2138E200 */  addu       $a3, $a3, $v0
  .L8006DEE4:
    /* 5E6E4 8006DEE4 033C0700 */  sra        $a3, $a3, 16
    /* 5E6E8 8006DEE8 0300E104 */  bgez       $a3, .L8006DEF8
    /* 5E6EC 8006DEEC 8000E228 */   slti      $v0, $a3, 0x80
    /* 5E6F0 8006DEF0 23380700 */  negu       $a3, $a3
    /* 5E6F4 8006DEF4 8000E228 */  slti       $v0, $a3, 0x80
  .L8006DEF8:
    /* 5E6F8 8006DEF8 02004014 */  bnez       $v0, .L8006DF04
    /* 5E6FC 8006DEFC 00000000 */   nop
    /* 5E700 8006DF00 80000724 */  addiu      $a3, $zero, 0x80
  .L8006DF04:
    /* 5E704 8006DF04 21108700 */  addu       $v0, $a0, $a3
    /* 5E708 8006DF08 00004290 */  lbu        $v0, 0x0($v0)
    /* 5E70C 8006DF0C 00000000 */  nop
    /* 5E710 8006DF10 40140200 */  sll        $v0, $v0, 17
    /* 5E714 8006DF14 23106200 */  subu       $v0, $v1, $v0
    /* 5E718 8006DF18 C3180200 */  sra        $v1, $v0, 3
    /* 5E71C 8006DF1C 21104300 */  addu       $v0, $v0, $v1
    /* 5E720 8006DF20 2A104500 */  slt        $v0, $v0, $a1
    /* 5E724 8006DF24 0800E003 */  jr         $ra
    /* 5E728 8006DF28 01004238 */   xori      $v0, $v0, 0x1
  .L8006DF2C:
    /* 5E72C 8006DF2C 0800E003 */  jr         $ra
    /* 5E730 8006DF30 00000000 */   nop
endlabel AISpeeds_NeedToSlowDownForCurve__FP8Car_tObjiii
