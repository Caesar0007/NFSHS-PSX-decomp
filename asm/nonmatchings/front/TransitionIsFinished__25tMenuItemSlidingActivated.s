.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TransitionIsFinished__25tMenuItemSlidingActivated, 0x88

glabel TransitionIsFinished__25tMenuItemSlidingActivated
    /* E640 8001DE40 1C00828C */  lw         $v0, 0x1C($a0)
    /* E644 8001DE44 00000000 */  nop
    /* E648 8001DE48 05004010 */  beqz       $v0, .L8001DE60
    /* E64C 8001DE4C 00000000 */   nop
    /* E650 8001DE50 2000828C */  lw         $v0, 0x20($a0)
    /* E654 8001DE54 00000000 */  nop
    /* E658 8001DE58 04004014 */  bnez       $v0, .L8001DE6C
    /* E65C 8001DE5C 00000000 */   nop
  .L8001DE60:
    /* E660 8001DE60 2E0080A4 */  sh         $zero, 0x2E($a0)
  .L8001DE64:
    /* E664 8001DE64 AF770008 */  j          .L8001DEBC
    /* E668 8001DE68 300080AC */   sw        $zero, 0x30($a0)
  .L8001DE6C:
    /* E66C 8001DE6C 2E008284 */  lh         $v0, 0x2E($a0)
    /* E670 8001DE70 00000000 */  nop
    /* E674 8001DE74 FBFF4010 */  beqz       $v0, .L8001DE64
    /* E678 8001DE78 00000000 */   nop
    /* E67C 8001DE7C 06004104 */  bgez       $v0, .L8001DE98
    /* E680 8001DE80 00000000 */   nop
    /* E684 8001DE84 2C008284 */  lh         $v0, 0x2C($a0)
    /* E688 8001DE88 00000000 */  nop
    /* E68C 8001DE8C F5FF4018 */  blez       $v0, .L8001DE64
    /* E690 8001DE90 00000000 */   nop
    /* E694 8001DE94 2E008284 */  lh         $v0, 0x2E($a0)
  .L8001DE98:
    /* E698 8001DE98 00000000 */  nop
    /* E69C 8001DE9C 06004018 */  blez       $v0, .L8001DEB8
    /* E6A0 8001DEA0 01000224 */   addiu     $v0, $zero, 0x1
    /* E6A4 8001DEA4 2C008284 */  lh         $v0, 0x2C($a0)
    /* E6A8 8001DEA8 00000000 */  nop
    /* E6AC 8001DEAC 80004228 */  slti       $v0, $v0, 0x80
    /* E6B0 8001DEB0 ECFF4010 */  beqz       $v0, .L8001DE64
    /* E6B4 8001DEB4 01000224 */   addiu     $v0, $zero, 0x1
  .L8001DEB8:
    /* E6B8 8001DEB8 300082AC */  sw         $v0, 0x30($a0)
  .L8001DEBC:
    /* E6BC 8001DEBC 3000828C */  lw         $v0, 0x30($a0)
    /* E6C0 8001DEC0 0800E003 */  jr         $ra
    /* E6C4 8001DEC4 01004238 */   xori      $v0, $v0, 0x1
endlabel TransitionIsFinished__25tMenuItemSlidingActivated
