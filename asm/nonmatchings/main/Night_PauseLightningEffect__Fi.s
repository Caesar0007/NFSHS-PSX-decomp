.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Night_PauseLightningEffect__Fi, 0x84

glabel Night_PauseLightningEffect__Fi
    /* CBE40 800DB640 1180033C */  lui        $v1, %hi(Camera_gInfo)
    /* CBE44 800DB644 ACF26324 */  addiu      $v1, $v1, %lo(Camera_gInfo)
    /* CBE48 800DB648 00110400 */  sll        $v0, $a0, 4
    /* CBE4C 800DB64C 21104400 */  addu       $v0, $v0, $a0
    /* CBE50 800DB650 00110200 */  sll        $v0, $v0, 4
    /* CBE54 800DB654 21104300 */  addu       $v0, $v0, $v1
    /* CBE58 800DB658 1180043C */  lui        $a0, %hi(D_80113228)
    /* CBE5C 800DB65C 1280033C */  lui        $v1, %hi(Night_gLightningPauseAreas)
    /* CBE60 800DB660 2C0D6324 */  addiu      $v1, $v1, %lo(Night_gLightningPauseAreas)
    /* CBE64 800DB664 2832848C */  lw         $a0, %lo(D_80113228)($a0)
    /* CBE68 800DB668 8C004584 */  lh         $a1, 0x8C($v0)
    /* CBE6C 800DB66C C0200400 */  sll        $a0, $a0, 3
    /* CBE70 800DB670 21208300 */  addu       $a0, $a0, $v1
    /* CBE74 800DB674 0000828C */  lw         $v0, 0x0($a0)
    /* CBE78 800DB678 0400848C */  lw         $a0, 0x4($a0)
    /* CBE7C 800DB67C 2A104500 */  slt        $v0, $v0, $a1
    /* CBE80 800DB680 02004010 */  beqz       $v0, .L800DB68C
    /* CBE84 800DB684 21180000 */   addu      $v1, $zero, $zero
    /* CBE88 800DB688 2A18A400 */  slt        $v1, $a1, $a0
  .L800DB68C:
    /* CBE8C 800DB68C 1480023C */  lui        $v0, %hi(Weather_gType)
    /* CBE90 800DB690 ECDB428C */  lw         $v0, %lo(Weather_gType)($v0)
    /* CBE94 800DB694 00000000 */  nop
    /* CBE98 800DB698 02004014 */  bnez       $v0, .L800DB6A4
    /* CBE9C 800DB69C 00000000 */   nop
    /* CBEA0 800DB6A0 01000324 */  addiu      $v1, $zero, 0x1
  .L800DB6A4:
    /* CBEA4 800DB6A4 05006010 */  beqz       $v1, .L800DB6BC
    /* CBEA8 800DB6A8 1280023C */   lui       $v0, %hi(D_8011E0B0)
    /* CBEAC 800DB6AC B0E0428C */  lw         $v0, %lo(D_8011E0B0)($v0)
    /* CBEB0 800DB6B0 00000000 */  nop
    /* CBEB4 800DB6B4 1C1582AF */  sw         $v0, %gp_rel(Night_gNextLightning)($gp)
    /* CBEB8 800DB6B8 201582AF */  sw         $v0, %gp_rel(Night_gEndNextLightning)($gp)
  .L800DB6BC:
    /* CBEBC 800DB6BC 0800E003 */  jr         $ra
    /* CBEC0 800DB6C0 00000000 */   nop
endlabel Night_PauseLightningEffect__Fi
