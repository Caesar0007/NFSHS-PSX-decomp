.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDstreamnotifycallback, 0xC8

glabel iSNDstreamnotifycallback
    /* D95D4 800E8DD4 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* D95D8 800E8DD8 1480033C */  lui        $v1, %hi(sndss)
    /* D95DC 800E8DDC 80EA6324 */  addiu      $v1, $v1, %lo(sndss)
    /* D95E0 800E8DE0 21208300 */  addu       $a0, $a0, $v1
    /* D95E4 800E8DE4 1800BFAF */  sw         $ra, 0x18($sp)
    /* D95E8 800E8DE8 1400B1AF */  sw         $s1, 0x14($sp)
    /* D95EC 800E8DEC 1000B0AF */  sw         $s0, 0x10($sp)
    /* D95F0 800E8DF0 04008280 */  lb         $v0, 0x4($a0)
    /* D95F4 800E8DF4 21800000 */  addu       $s0, $zero, $zero
    /* D95F8 800E8DF8 80100200 */  sll        $v0, $v0, 2
    /* D95FC 800E8DFC 21104300 */  addu       $v0, $v0, $v1
    /* D9600 800E8E00 0000518C */  lw         $s1, 0x0($v0)
  .L800E8E04:
    /* D9604 800E8E04 00000000 */  nop
    /* D9608 800E8E08 0000248E */  lw         $a0, 0x0($s1)
    /* D960C 800E8E0C 00000000 */  nop
    /* D9610 800E8E10 1C00828C */  lw         $v0, 0x1C($a0)
    /* D9614 800E8E14 00000000 */  nop
    /* D9618 800E8E18 2B104500 */  sltu       $v0, $v0, $a1
    /* D961C 800E8E1C 05004010 */  beqz       $v0, .L800E8E34
    /* D9620 800E8E20 00000000 */   nop
    /* D9624 800E8E24 1C00828C */  lw         $v0, 0x1C($a0)
    /* D9628 800E8E28 00000000 */  nop
    /* D962C 800E8E2C 2380A200 */  subu       $s0, $a1, $v0
    /* D9630 800E8E30 2328B000 */  subu       $a1, $a1, $s0
  .L800E8E34:
    /* D9634 800E8E34 1400828C */  lw         $v0, 0x14($a0)
    /* D9638 800E8E38 00000000 */  nop
    /* D963C 800E8E3C 21104500 */  addu       $v0, $v0, $a1
    /* D9640 800E8E40 140082AC */  sw         $v0, 0x14($a0)
    /* D9644 800E8E44 1C00828C */  lw         $v0, 0x1C($a0)
    /* D9648 800E8E48 00000000 */  nop
    /* D964C 800E8E4C 23104500 */  subu       $v0, $v0, $a1
    /* D9650 800E8E50 1C0082AC */  sw         $v0, 0x1C($a0)
    /* D9654 800E8E54 1400828C */  lw         $v0, 0x14($a0)
    /* D9658 800E8E58 1800838C */  lw         $v1, 0x18($a0)
    /* D965C 800E8E5C 00000000 */  nop
    /* D9660 800E8E60 2B104300 */  sltu       $v0, $v0, $v1
    /* D9664 800E8E64 04004014 */  bnez       $v0, .L800E8E78
    /* D9668 800E8E68 00000000 */   nop
    /* D966C 800E8E6C 0400848C */  lw         $a0, 0x4($a0)
    /* D9670 800E8E70 19A3030C */  jal        iSNDstreamremoverequest
    /* D9674 800E8E74 00000000 */   nop
  .L800E8E78:
    /* D9678 800E8E78 03000012 */  beqz       $s0, .L800E8E88
    /* D967C 800E8E7C 21280002 */   addu      $a1, $s0, $zero
    /* D9680 800E8E80 81A30308 */  j          .L800E8E04
    /* D9684 800E8E84 21800000 */   addu      $s0, $zero, $zero
  .L800E8E88:
    /* D9688 800E8E88 1800BF8F */  lw         $ra, 0x18($sp)
    /* D968C 800E8E8C 1400B18F */  lw         $s1, 0x14($sp)
    /* D9690 800E8E90 1000B08F */  lw         $s0, 0x10($sp)
    /* D9694 800E8E94 0800E003 */  jr         $ra
    /* D9698 800E8E98 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel iSNDstreamnotifycallback
