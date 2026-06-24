.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Font_Getcharacter__Fi, 0x8C

glabel Font_Getcharacter__Fi
    /* BBF40 800CB740 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* BBF44 800CB744 1400B1AF */  sw         $s1, 0x14($sp)
    /* BBF48 800CB748 21888000 */  addu       $s1, $a0, $zero
    /* BBF4C 800CB74C 02000524 */  addiu      $a1, $zero, 0x2
    /* BBF50 800CB750 1380023C */  lui        $v0, %hi(currentfont)
    /* BBF54 800CB754 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* BBF58 800CB758 A05B5324 */  addiu      $s3, $v0, %lo(currentfont)
    /* BBF5C 800CB75C E0FF2326 */  addiu      $v1, $s1, -0x20
    /* BBF60 800CB760 40100300 */  sll        $v0, $v1, 1
    /* BBF64 800CB764 21104300 */  addu       $v0, $v0, $v1
    /* BBF68 800CB768 0410A200 */  sllv       $v0, $v0, $a1
    /* BBF6C 800CB76C 2000BFAF */  sw         $ra, 0x20($sp)
    /* BBF70 800CB770 1800B2AF */  sw         $s2, 0x18($sp)
    /* BBF74 800CB774 1000B0AF */  sw         $s0, 0x10($sp)
    /* BBF78 800CB778 8400728E */  lw         $s2, 0x84($s3)
    /* BBF7C 800CB77C 23104300 */  subu       $v0, $v0, $v1
    /* BBF80 800CB780 21804202 */  addu       $s0, $s2, $v0
    /* BBF84 800CB784 23CC030C */  jal        geti
    /* BBF88 800CB788 21200002 */   addu      $a0, $s0, $zero
    /* BBF8C 800CB78C 07005110 */  beq        $v0, $s1, .L800CB7AC
    /* BBF90 800CB790 21202002 */   addu      $a0, $s1, $zero
    /* BBF94 800CB794 21284002 */  addu       $a1, $s2, $zero
    /* BBF98 800CB798 7400668E */  lw         $a2, 0x74($s3)
    /* BBF9C 800CB79C A82D030C */  jal        Font_textbsearch__FiPcUlUl
    /* BBFA0 800CB7A0 0B000724 */   addiu     $a3, $zero, 0xB
    /* BBFA4 800CB7A4 EC2D0308 */  j          .L800CB7B0
    /* BBFA8 800CB7A8 00000000 */   nop
  .L800CB7AC:
    /* BBFAC 800CB7AC 21100002 */  addu       $v0, $s0, $zero
  .L800CB7B0:
    /* BBFB0 800CB7B0 2000BF8F */  lw         $ra, 0x20($sp)
    /* BBFB4 800CB7B4 1C00B38F */  lw         $s3, 0x1C($sp)
    /* BBFB8 800CB7B8 1800B28F */  lw         $s2, 0x18($sp)
    /* BBFBC 800CB7BC 1400B18F */  lw         $s1, 0x14($sp)
    /* BBFC0 800CB7C0 1000B08F */  lw         $s0, 0x10($sp)
    /* BBFC4 800CB7C4 0800E003 */  jr         $ra
    /* BBFC8 800CB7C8 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel Font_Getcharacter__Fi
