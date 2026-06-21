.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TransitionIsFinished__10tMenuBlank, 0x3C

glabel TransitionIsFinished__10tMenuBlank
    /* C210 8001BA10 76008280 */  lb         $v0, 0x76($a0)
    /* C214 8001BA14 00000000 */  nop
    /* C218 8001BA18 04004018 */  blez       $v0, .L8001BA2C
    /* C21C 8001BA1C 00000000 */   nop
    /* C220 8001BA20 74008284 */  lh         $v0, 0x74($a0)
    /* C224 8001BA24 8F6E0008 */  j          .L8001BA3C
    /* C228 8001BA28 C2170200 */   srl       $v0, $v0, 31
  .L8001BA2C:
    /* C22C 8001BA2C 74008284 */  lh         $v0, 0x74($a0)
    /* C230 8001BA30 00000000 */  nop
    /* C234 8001BA34 91FF4228 */  slti       $v0, $v0, -0x6F
    /* C238 8001BA38 01004238 */  xori       $v0, $v0, 0x1
  .L8001BA3C:
    /* C23C 8001BA3C 700082AC */  sw         $v0, 0x70($a0)
    /* C240 8001BA40 7000828C */  lw         $v0, 0x70($a0)
    /* C244 8001BA44 0800E003 */  jr         $ra
    /* C248 8001BA48 01004238 */   xori      $v0, $v0, 0x1
endlabel TransitionIsFinished__10tMenuBlank
