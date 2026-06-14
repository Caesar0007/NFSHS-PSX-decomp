.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Draw_StartRenderingView__Fi, 0xB8

glabel Draw_StartRenderingView__Fi
    /* AE860 800BE060 21408000 */  addu       $t0, $a0, $zero
    /* AE864 800BE064 40100800 */  sll        $v0, $t0, 1
    /* AE868 800BE068 21104800 */  addu       $v0, $v0, $t0
    /* AE86C 800BE06C C0100200 */  sll        $v0, $v0, 3
    /* AE870 800BE070 21104800 */  addu       $v0, $v0, $t0
    /* AE874 800BE074 C0100200 */  sll        $v0, $v0, 3
    /* AE878 800BE078 1280033C */  lui        $v1, %hi(Draw_gView)
    /* AE87C 800BE07C 54EC6324 */  addiu      $v1, $v1, %lo(Draw_gView)
    /* AE880 800BE080 21304300 */  addu       $a2, $v0, $v1
    /* AE884 800BE084 0000C28C */  lw         $v0, 0x0($a2)
    /* AE888 800BE088 00000000 */  nop
    /* AE88C 800BE08C C0180200 */  sll        $v1, $v0, 3
    /* AE890 800BE090 23286200 */  subu       $a1, $v1, $v0
    /* AE894 800BE094 641282AF */  sw         $v0, %gp_rel(Draw_gViewOtSize)($gp)
    /* AE898 800BE098 0200A104 */  bgez       $a1, .L800BE0A4
    /* AE89C 800BE09C 801F073C */   lui       $a3, (0x1F800008 >> 16)
    /* AE8A0 800BE0A0 0700A524 */  addiu      $a1, $a1, 0x7
  .L800BE0A4:
    /* AE8A4 800BE0A4 0C00C294 */  lhu        $v0, 0xC($a2)
    /* AE8A8 800BE0A8 1480043C */  lui        $a0, %hi(Draw_gPlayer1View)
    /* AE8AC 800BE0AC CCD3848C */  lw         $a0, %lo(Draw_gPlayer1View)($a0)
    /* AE8B0 800BE0B0 1000E2A4 */  sh         $v0, (0x1F800010 & 0xFFFF)($a3)
    /* AE8B4 800BE0B4 6812828F */  lw         $v0, %gp_rel(gFlip)($gp)
    /* AE8B8 800BE0B8 0E00C394 */  lhu        $v1, 0xE($a2)
    /* AE8BC 800BE0BC 80100200 */  sll        $v0, $v0, 2
    /* AE8C0 800BE0C0 2110C200 */  addu       $v0, $a2, $v0
    /* AE8C4 800BE0C4 1200E3A4 */  sh         $v1, (0x1F800012 & 0xFFFF)($a3)
    /* AE8C8 800BE0C8 C000438C */  lw         $v1, 0xC0($v0)
    /* AE8CC 800BE0CC C3100500 */  sra        $v0, $a1, 3
    /* AE8D0 800BE0D0 701282AF */  sw         $v0, %gp_rel(Draw_gMidGroundOtz)($gp)
    /* AE8D4 800BE0D4 09000411 */  beq        $t0, $a0, .L800BE0FC
    /* AE8D8 800BE0D8 0000E3AC */   sw        $v1, (0x1F800000 & 0xFFFF)($a3)
    /* AE8DC 800BE0DC 1480023C */  lui        $v0, %hi(Draw_gPlayer2View)
    /* AE8E0 800BE0E0 D0D3428C */  lw         $v0, %lo(Draw_gPlayer2View)($v0)
    /* AE8E4 800BE0E4 00000000 */  nop
    /* AE8E8 800BE0E8 04000211 */  beq        $t0, $v0, .L800BE0FC
    /* AE8EC 800BE0EC 00000000 */   nop
    /* AE8F0 800BE0F0 7412828F */  lw         $v0, %gp_rel(Draw_gMaxPrim)($gp)
    /* AE8F4 800BE0F4 44F80208 */  j          .L800BE110
    /* AE8F8 800BE0F8 0800E2AC */   sw        $v0, (0x1F800008 & 0xFFFF)($a3)
  .L800BE0FC:
    /* AE8FC 800BE0FC 0400E28C */  lw         $v0, (0x1F800004 & 0xFFFF)($a3)
    /* AE900 800BE100 0400C38C */  lw         $v1, 0x4($a2)
    /* AE904 800BE104 00000000 */  nop
    /* AE908 800BE108 21104300 */  addu       $v0, $v0, $v1
    /* AE90C 800BE10C 0800E2AC */  sw         $v0, (0x1F800008 & 0xFFFF)($a3)
  .L800BE110:
    /* AE910 800BE110 0800E003 */  jr         $ra
    /* AE914 800BE114 0C00E0AC */   sw        $zero, (0x1F80000C & 0xFFFF)($a3)
endlabel Draw_StartRenderingView__Fi
