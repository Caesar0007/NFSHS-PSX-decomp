.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AllocatePrimitivesBuffer__Fv, 0x13C

glabel AllocatePrimitivesBuffer__Fv
    /* AE660 800BDE60 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* AE664 800BDE64 1180023C */  lui        $v0, %hi(D_801131F8)
    /* AE668 800BDE68 F831438C */  lw         $v1, %lo(D_801131F8)($v0)
    /* AE66C 800BDE6C 01000224 */  addiu      $v0, $zero, 0x1
    /* AE670 800BDE70 1400BFAF */  sw         $ra, 0x14($sp)
    /* AE674 800BDE74 05006214 */  bne        $v1, $v0, .L800BDE8C
    /* AE678 800BDE78 1000B0AF */   sw        $s0, 0x10($sp)
    /* AE67C 800BDE7C F8F6020C */  jal        Draw_InitViewOT__Fv
    /* AE680 800BDE80 00000000 */   nop
    /* AE684 800BDE84 A6F70208 */  j          .L800BDE98
    /* AE688 800BDE88 1180023C */   lui       $v0, %hi(D_801131F8)
  .L800BDE8C:
    /* AE68C 800BDE8C 19F7020C */  jal        Draw_InitViewOTInGame__Fv
    /* AE690 800BDE90 00000000 */   nop
    /* AE694 800BDE94 1180023C */  lui        $v0, %hi(D_801131F8)
  .L800BDE98:
    /* AE698 800BDE98 F831438C */  lw         $v1, %lo(D_801131F8)($v0)
    /* AE69C 800BDE9C 01000224 */  addiu      $v0, $zero, 0x1
    /* AE6A0 800BDEA0 03006214 */  bne        $v1, $v0, .L800BDEB0
    /* AE6A4 800BDEA4 0200023C */   lui       $v0, (0x22500 >> 16)
    /* AE6A8 800BDEA8 AEF70208 */  j          .L800BDEB8
    /* AE6AC 800BDEAC 00254234 */   ori       $v0, $v0, (0x22500 & 0xFFFF)
  .L800BDEB0:
    /* AE6B0 800BDEB0 0100023C */  lui        $v0, (0x1F600 >> 16)
    /* AE6B4 800BDEB4 00F64234 */  ori        $v0, $v0, (0x1F600 & 0xFFFF)
  .L800BDEB8:
    /* AE6B8 800BDEB8 781282AF */  sw         $v0, %gp_rel(gTotalMem)($gp)
    /* AE6BC 800BDEBC 1480053C */  lui        $a1, %hi(D_8013D7A0)
    /* AE6C0 800BDEC0 7812848F */  lw         $a0, %gp_rel(gTotalMem)($gp)
    /* AE6C4 800BDEC4 BA70030C */  jal        Platform_ReserveMemory__FiPc
    /* AE6C8 800BDEC8 A0D7A524 */   addiu     $a1, $a1, %lo(D_8013D7A0)
    /* AE6CC 800BDECC 1480053C */  lui        $a1, %hi(D_8013D7A4)
    /* AE6D0 800BDED0 A4D7A524 */  addiu      $a1, $a1, %lo(D_8013D7A4)
    /* AE6D4 800BDED4 1280103C */  lui        $s0, %hi(gEnviro)
    /* AE6D8 800BDED8 7812848F */  lw         $a0, %gp_rel(gTotalMem)($gp)
    /* AE6DC 800BDEDC 24F41026 */  addiu      $s0, $s0, %lo(gEnviro)
    /* AE6E0 800BDEE0 BA70030C */  jal        Platform_ReserveMemory__FiPc
    /* AE6E4 800BDEE4 140002AE */   sw        $v0, 0x14($s0)
    /* AE6E8 800BDEE8 2C0002AE */  sw         $v0, 0x2C($s0)
    /* AE6EC 800BDEEC 1180023C */  lui        $v0, %hi(D_801131F8)
    /* AE6F0 800BDEF0 F831438C */  lw         $v1, %lo(D_801131F8)($v0)
    /* AE6F4 800BDEF4 01000224 */  addiu      $v0, $zero, 0x1
    /* AE6F8 800BDEF8 17006214 */  bne        $v1, $v0, .L800BDF58
    /* AE6FC 800BDEFC 1280053C */   lui       $a1, %hi(Draw_gView)
    /* AE700 800BDF00 54ECA524 */  addiu      $a1, $a1, %lo(Draw_gView)
    /* AE704 800BDF04 1480033C */  lui        $v1, %hi(Draw_gPlayer1View)
    /* AE708 800BDF08 CCD3638C */  lw         $v1, %lo(Draw_gPlayer1View)($v1)
    /* AE70C 800BDF0C 7812848F */  lw         $a0, %gp_rel(gTotalMem)($gp)
    /* AE710 800BDF10 04104300 */  sllv       $v0, $v1, $v0
    /* AE714 800BDF14 21104300 */  addu       $v0, $v0, $v1
    /* AE718 800BDF18 C0100200 */  sll        $v0, $v0, 3
    /* AE71C 800BDF1C 21104300 */  addu       $v0, $v0, $v1
    /* AE720 800BDF20 C0100200 */  sll        $v0, $v0, 3
    /* AE724 800BDF24 21104500 */  addu       $v0, $v0, $a1
    /* AE728 800BDF28 43200400 */  sra        $a0, $a0, 1
    /* AE72C 800BDF2C 1480033C */  lui        $v1, %hi(Draw_gPlayer2View)
    /* AE730 800BDF30 D0D3638C */  lw         $v1, %lo(Draw_gPlayer2View)($v1)
    /* AE734 800BDF34 00E68424 */  addiu      $a0, $a0, -0x1A00
    /* AE738 800BDF38 040044AC */  sw         $a0, 0x4($v0)
    /* AE73C 800BDF3C 40100300 */  sll        $v0, $v1, 1
    /* AE740 800BDF40 21104300 */  addu       $v0, $v0, $v1
    /* AE744 800BDF44 C0100200 */  sll        $v0, $v0, 3
    /* AE748 800BDF48 21104300 */  addu       $v0, $v0, $v1
    /* AE74C 800BDF4C C0100200 */  sll        $v0, $v0, 3
    /* AE750 800BDF50 E2F70208 */  j          .L800BDF88
    /* AE754 800BDF54 21104500 */   addu      $v0, $v0, $a1
  .L800BDF58:
    /* AE758 800BDF58 1480033C */  lui        $v1, %hi(Draw_gPlayer1View)
    /* AE75C 800BDF5C CCD3638C */  lw         $v1, %lo(Draw_gPlayer1View)($v1)
    /* AE760 800BDF60 7812848F */  lw         $a0, %gp_rel(gTotalMem)($gp)
    /* AE764 800BDF64 40100300 */  sll        $v0, $v1, 1
    /* AE768 800BDF68 21104300 */  addu       $v0, $v0, $v1
    /* AE76C 800BDF6C C0100200 */  sll        $v0, $v0, 3
    /* AE770 800BDF70 21104300 */  addu       $v0, $v0, $v1
    /* AE774 800BDF74 C0100200 */  sll        $v0, $v0, 3
    /* AE778 800BDF78 1280033C */  lui        $v1, %hi(Draw_gView)
    /* AE77C 800BDF7C 54EC6324 */  addiu      $v1, $v1, %lo(Draw_gView)
    /* AE780 800BDF80 21104300 */  addu       $v0, $v0, $v1
    /* AE784 800BDF84 00E68424 */  addiu      $a0, $a0, -0x1A00
  .L800BDF88:
    /* AE788 800BDF88 040044AC */  sw         $a0, 0x4($v0)
    /* AE78C 800BDF8C 1400BF8F */  lw         $ra, 0x14($sp)
    /* AE790 800BDF90 1000B08F */  lw         $s0, 0x10($sp)
    /* AE794 800BDF94 0800E003 */  jr         $ra
    /* AE798 800BDF98 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AllocatePrimitivesBuffer__Fv
