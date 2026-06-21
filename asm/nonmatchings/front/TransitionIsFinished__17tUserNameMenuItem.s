.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TransitionIsFinished__17tUserNameMenuItem, 0x6C

glabel TransitionIsFinished__17tUserNameMenuItem
    /* 10FB4 800207B4 84008284 */  lh         $v0, 0x84($a0)
    /* 10FB8 800207B8 00000000 */  nop
    /* 10FBC 800207BC 05004104 */  bgez       $v0, .L800207D4
    /* 10FC0 800207C0 880080AC */   sw        $zero, 0x88($a0)
    /* 10FC4 800207C4 82008284 */  lh         $v0, 0x82($a0)
    /* 10FC8 800207C8 00000000 */  nop
    /* 10FCC 800207CC 1000401C */  bgtz       $v0, .L80020810
    /* 10FD0 800207D0 01000224 */   addiu     $v0, $zero, 0x1
  .L800207D4:
    /* 10FD4 800207D4 84008284 */  lh         $v0, 0x84($a0)
    /* 10FD8 800207D8 00000000 */  nop
    /* 10FDC 800207DC 0D004018 */  blez       $v0, .L80020814
    /* 10FE0 800207E0 00000000 */   nop
    /* 10FE4 800207E4 82008284 */  lh         $v0, 0x82($a0)
    /* 10FE8 800207E8 00000000 */  nop
    /* 10FEC 800207EC 80004228 */  slti       $v0, $v0, 0x80
    /* 10FF0 800207F0 07004014 */  bnez       $v0, .L80020810
    /* 10FF4 800207F4 01000224 */   addiu     $v0, $zero, 0x1
    /* 10FF8 800207F8 0580023C */  lui        $v0, %hi(D_800514F8)
    /* 10FFC 800207FC F8144294 */  lhu        $v0, %lo(D_800514F8)($v0)
    /* 11000 80020800 00000000 */  nop
    /* 11004 80020804 03004010 */  beqz       $v0, .L80020814
    /* 11008 80020808 00000000 */   nop
    /* 1100C 8002080C 01000224 */  addiu      $v0, $zero, 0x1
  .L80020810:
    /* 11010 80020810 880082AC */  sw         $v0, 0x88($a0)
  .L80020814:
    /* 11014 80020814 8800828C */  lw         $v0, 0x88($a0)
    /* 11018 80020818 0800E003 */  jr         $ra
    /* 1101C 8002081C 01004238 */   xori      $v0, $v0, 0x1
endlabel TransitionIsFinished__17tUserNameMenuItem
