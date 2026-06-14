.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hud_BTC_Update__FPcib, 0x64

glabel Hud_BTC_Update__FPcib
    /* C9DC8 800D95C8 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* C9DCC 800D95CC 21108000 */  addu       $v0, $a0, $zero
    /* C9DD0 800D95D0 1400B1AF */  sw         $s1, 0x14($sp)
    /* C9DD4 800D95D4 2188A000 */  addu       $s1, $a1, $zero
    /* C9DD8 800D95D8 1000B0AF */  sw         $s0, 0x10($sp)
    /* C9DDC 800D95DC 2180C000 */  addu       $s0, $a2, $zero
    /* C9DE0 800D95E0 1480043C */  lui        $a0, %hi(D_8013E850)
    /* C9DE4 800D95E4 50E88424 */  addiu      $a0, $a0, %lo(D_8013E850)
    /* C9DE8 800D95E8 1800BFAF */  sw         $ra, 0x18($sp)
    /* C9DEC 800D95EC 2F91030C */  jal        sprintf
    /* C9DF0 800D95F0 21284000 */   addu      $a1, $v0, $zero
    /* C9DF4 800D95F4 DC18828F */  lw         $v0, %gp_rel(D_8013DE28)($gp)
    /* C9DF8 800D95F8 E41890AF */  sw         $s0, %gp_rel(D_8013DE30)($gp)
    /* C9DFC 800D95FC 06004014 */  bnez       $v0, .L800D9618
    /* C9E00 800D9600 00000000 */   nop
    /* C9E04 800D9604 DC13828F */  lw         $v0, %gp_rel(HudBustedOverlay)($gp)
    /* C9E08 800D9608 00000000 */  nop
    /* C9E0C 800D960C 02004014 */  bnez       $v0, .L800D9618
    /* C9E10 800D9610 40101100 */   sll       $v0, $s1, 1
    /* C9E14 800D9614 E81382AF */  sw         $v0, %gp_rel(BTC_Countdown)($gp)
  .L800D9618:
    /* C9E18 800D9618 1800BF8F */  lw         $ra, 0x18($sp)
    /* C9E1C 800D961C 1400B18F */  lw         $s1, 0x14($sp)
    /* C9E20 800D9620 1000B08F */  lw         $s0, 0x10($sp)
    /* C9E24 800D9624 0800E003 */  jr         $ra
    /* C9E28 800D9628 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Hud_BTC_Update__FPcib
