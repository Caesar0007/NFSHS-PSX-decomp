.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hud_RenderStatsView__Fv, 0x22C

glabel Hud_RenderStatsView__Fv
    /* CB68C 800DAE8C 1280023C */  lui        $v0, %hi(D_8011E0B0)
    /* CB690 800DAE90 1180043C */  lui        $a0, %hi(Cars_gHumanRaceCarList)
    /* CB694 800DAE94 B0E0438C */  lw         $v1, %lo(D_8011E0B0)($v0)
    /* CB698 800DAE98 48FA828C */  lw         $v0, %lo(Cars_gHumanRaceCarList)($a0)
    /* CB69C 800DAE9C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* CB6A0 800DAEA0 1000BFAF */  sw         $ra, 0x10($sp)
    /* CB6A4 800DAEA4 431A0300 */  sra        $v1, $v1, 9
    /* CB6A8 800DAEA8 6002428C */  lw         $v0, 0x260($v0)
    /* CB6AC 800DAEAC 00000000 */  nop
    /* CB6B0 800DAEB0 00024230 */  andi       $v0, $v0, 0x200
    /* CB6B4 800DAEB4 08004010 */  beqz       $v0, .L800DAED8
    /* CB6B8 800DAEB8 01006430 */   andi      $a0, $v1, 0x1
    /* CB6BC 800DAEBC 1180023C */  lui        $v0, %hi(D_801131F8)
    /* CB6C0 800DAEC0 F831438C */  lw         $v1, %lo(D_801131F8)($v0)
    /* CB6C4 800DAEC4 01000224 */  addiu      $v0, $zero, 0x1
    /* CB6C8 800DAEC8 09006210 */  beq        $v1, $v0, .L800DAEF0
    /* CB6CC 800DAECC 1180033C */   lui       $v1, %hi(Cars_gHumanRaceCarList)
  .L800DAED0:
    /* CB6D0 800DAED0 FA6B0308 */  j          .L800DAFE8
    /* CB6D4 800DAED4 21200000 */   addu      $a0, $zero, $zero
  .L800DAED8:
    /* CB6D8 800DAED8 1180023C */  lui        $v0, %hi(D_801131F8)
    /* CB6DC 800DAEDC F831428C */  lw         $v0, %lo(D_801131F8)($v0)
    /* CB6E0 800DAEE0 01000324 */  addiu      $v1, $zero, 0x1
    /* CB6E4 800DAEE4 3A004314 */  bne        $v0, $v1, .L800DAFD0
    /* CB6E8 800DAEE8 00000000 */   nop
    /* CB6EC 800DAEEC 1180033C */  lui        $v1, %hi(Cars_gHumanRaceCarList)
  .L800DAEF0:
    /* CB6F0 800DAEF0 48FA628C */  lw         $v0, %lo(Cars_gHumanRaceCarList)($v1)
    /* CB6F4 800DAEF4 00000000 */  nop
    /* CB6F8 800DAEF8 6002428C */  lw         $v0, 0x260($v0)
    /* CB6FC 800DAEFC 00000000 */  nop
    /* CB700 800DAF00 00024230 */  andi       $v0, $v0, 0x200
    /* CB704 800DAF04 0A004010 */  beqz       $v0, .L800DAF30
    /* CB708 800DAF08 48FA6324 */   addiu     $v1, $v1, %lo(Cars_gHumanRaceCarList)
    /* CB70C 800DAF0C 0400628C */  lw         $v0, 0x4($v1)
    /* CB710 800DAF10 00000000 */  nop
    /* CB714 800DAF14 6002428C */  lw         $v0, 0x260($v0)
    /* CB718 800DAF18 00000000 */  nop
    /* CB71C 800DAF1C 00024230 */  andi       $v0, $v0, 0x200
    /* CB720 800DAF20 0A004014 */  bnez       $v0, .L800DAF4C
    /* CB724 800DAF24 1180023C */   lui       $v0, %hi(Cars_gHumanRaceCarList)
    /* CB728 800DAF28 FA6B0308 */  j          .L800DAFE8
    /* CB72C 800DAF2C 21200000 */   addu      $a0, $zero, $zero
  .L800DAF30:
    /* CB730 800DAF30 0400628C */  lw         $v0, 0x4($v1)
    /* CB734 800DAF34 00000000 */  nop
    /* CB738 800DAF38 6002428C */  lw         $v0, 0x260($v0)
    /* CB73C 800DAF3C 00000000 */  nop
    /* CB740 800DAF40 00024230 */  andi       $v0, $v0, 0x200
    /* CB744 800DAF44 10004010 */  beqz       $v0, .L800DAF88
    /* CB748 800DAF48 1180023C */   lui       $v0, %hi(Cars_gHumanRaceCarList)
  .L800DAF4C:
    /* CB74C 800DAF4C 48FA428C */  lw         $v0, %lo(Cars_gHumanRaceCarList)($v0)
    /* CB750 800DAF50 00000000 */  nop
    /* CB754 800DAF54 6002428C */  lw         $v0, 0x260($v0)
    /* CB758 800DAF58 00000000 */  nop
    /* CB75C 800DAF5C 00024230 */  andi       $v0, $v0, 0x200
    /* CB760 800DAF60 20004010 */  beqz       $v0, .L800DAFE4
    /* CB764 800DAF64 00000000 */   nop
    /* CB768 800DAF68 48148287 */  lh         $v0, %gp_rel(Hud_NextPerp)($gp)
    /* CB76C 800DAF6C 00000000 */  nop
    /* CB770 800DAF70 D7FF4014 */  bnez       $v0, .L800DAED0
    /* CB774 800DAF74 1180023C */   lui       $v0, %hi(D_801131F8)
    /* CB778 800DAF78 F831438C */  lw         $v1, %lo(D_801131F8)($v0)
    /* CB77C 800DAF7C 01000224 */  addiu      $v0, $zero, 0x1
    /* CB780 800DAF80 D3FF6214 */  bne        $v1, $v0, .L800DAED0
    /* CB784 800DAF84 00000000 */   nop
  .L800DAF88:
    /* CB788 800DAF88 1180023C */  lui        $v0, %hi(D_8010FA4C)
    /* CB78C 800DAF8C 4CFA428C */  lw         $v0, %lo(D_8010FA4C)($v0)
    /* CB790 800DAF90 00000000 */  nop
    /* CB794 800DAF94 6002428C */  lw         $v0, 0x260($v0)
    /* CB798 800DAF98 00000000 */  nop
    /* CB79C 800DAF9C 00024230 */  andi       $v0, $v0, 0x200
    /* CB7A0 800DAFA0 11004010 */  beqz       $v0, .L800DAFE8
    /* CB7A4 800DAFA4 1180023C */   lui       $v0, %hi(D_801131F8)
    /* CB7A8 800DAFA8 F831438C */  lw         $v1, %lo(D_801131F8)($v0)
    /* CB7AC 800DAFAC 01000224 */  addiu      $v0, $zero, 0x1
    /* CB7B0 800DAFB0 0D006214 */  bne        $v1, $v0, .L800DAFE8
    /* CB7B4 800DAFB4 00000000 */   nop
    /* CB7B8 800DAFB8 4A148287 */  lh         $v0, %gp_rel(D_8013D996)($gp)
    /* CB7BC 800DAFBC 00000000 */  nop
    /* CB7C0 800DAFC0 09004010 */  beqz       $v0, .L800DAFE8
    /* CB7C4 800DAFC4 00000000 */   nop
    /* CB7C8 800DAFC8 FA6B0308 */  j          .L800DAFE8
    /* CB7CC 800DAFCC 01000424 */   addiu     $a0, $zero, 0x1
  .L800DAFD0:
    /* CB7D0 800DAFD0 1480023C */  lui        $v0, %hi(Cars_gNumRaceCars)
    /* CB7D4 800DAFD4 F8C7428C */  lw         $v0, %lo(Cars_gNumRaceCars)($v0)
    /* CB7D8 800DAFD8 00000000 */  nop
    /* CB7DC 800DAFDC 02004314 */  bne        $v0, $v1, .L800DAFE8
    /* CB7E0 800DAFE0 00000000 */   nop
  .L800DAFE4:
    /* CB7E4 800DAFE4 01000424 */  addiu      $a0, $zero, 0x1
  .L800DAFE8:
    /* CB7E8 800DAFE8 15008014 */  bnez       $a0, .L800DB040
    /* CB7EC 800DAFEC 00000000 */   nop
    /* CB7F0 800DAFF0 4C14828F */  lw         $v0, %gp_rel(StatsTimer)($gp)
    /* CB7F4 800DAFF4 501480AF */  sw         $zero, %gp_rel(D_8013D99C)($gp)
    /* CB7F8 800DAFF8 01004224 */  addiu      $v0, $v0, 0x1
    /* CB7FC 800DAFFC 21184000 */  addu       $v1, $v0, $zero
    /* CB800 800DB000 11276228 */  slti       $v0, $v1, 0x2711
    /* CB804 800DB004 4C1483AF */  sw         $v1, %gp_rel(StatsTimer)($gp)
    /* CB808 800DB008 02004014 */  bnez       $v0, .L800DB014
    /* CB80C 800DB00C 1180023C */   lui       $v0, %hi(Cars_gHumanRaceCarList)
    /* CB810 800DB010 10270324 */  addiu      $v1, $zero, 0x2710
  .L800DB014:
    /* CB814 800DB014 48FA428C */  lw         $v0, %lo(Cars_gHumanRaceCarList)($v0)
    /* CB818 800DB018 4C1483AF */  sw         $v1, %gp_rel(StatsTimer)($gp)
    /* CB81C 800DB01C 6002428C */  lw         $v0, 0x260($v0)
    /* CB820 800DB020 00000000 */  nop
    /* CB824 800DB024 00024230 */  andi       $v0, $v0, 0x200
    /* CB828 800DB028 19004014 */  bnez       $v0, .L800DB090
    /* CB82C 800DB02C 21200000 */   addu      $a0, $zero, $zero
    /* CB830 800DB030 9266030C */  jal        RaceSummary__Fv
    /* CB834 800DB034 00000000 */   nop
    /* CB838 800DB038 2A6C0308 */  j          .L800DB0A8
    /* CB83C 800DB03C 00000000 */   nop
  .L800DB040:
    /* CB840 800DB040 5014828F */  lw         $v0, %gp_rel(D_8013D99C)($gp)
    /* CB844 800DB044 4C1480AF */  sw         $zero, %gp_rel(StatsTimer)($gp)
    /* CB848 800DB048 01004224 */  addiu      $v0, $v0, 0x1
    /* CB84C 800DB04C 21184000 */  addu       $v1, $v0, $zero
    /* CB850 800DB050 11276228 */  slti       $v0, $v1, 0x2711
    /* CB854 800DB054 501483AF */  sw         $v1, %gp_rel(D_8013D99C)($gp)
    /* CB858 800DB058 02004014 */  bnez       $v0, .L800DB064
    /* CB85C 800DB05C 1180023C */   lui       $v0, %hi(D_8010FA4C)
    /* CB860 800DB060 10270324 */  addiu      $v1, $zero, 0x2710
  .L800DB064:
    /* CB864 800DB064 4CFA428C */  lw         $v0, %lo(D_8010FA4C)($v0)
    /* CB868 800DB068 501483AF */  sw         $v1, %gp_rel(D_8013D99C)($gp)
    /* CB86C 800DB06C 6002428C */  lw         $v0, 0x260($v0)
    /* CB870 800DB070 00000000 */  nop
    /* CB874 800DB074 00024230 */  andi       $v0, $v0, 0x200
    /* CB878 800DB078 09004010 */  beqz       $v0, .L800DB0A0
    /* CB87C 800DB07C 1180023C */   lui       $v0, %hi(D_801131F8)
    /* CB880 800DB080 F831438C */  lw         $v1, %lo(D_801131F8)($v0)
    /* CB884 800DB084 01000224 */  addiu      $v0, $zero, 0x1
    /* CB888 800DB088 05006214 */  bne        $v1, $v0, .L800DB0A0
    /* CB88C 800DB08C 21204000 */   addu      $a0, $v0, $zero
  .L800DB090:
    /* CB890 800DB090 CA69030C */  jal        Hud_BTCStats__Fsb
    /* CB894 800DB094 01000524 */   addiu     $a1, $zero, 0x1
    /* CB898 800DB098 2A6C0308 */  j          .L800DB0A8
    /* CB89C 800DB09C 00000000 */   nop
  .L800DB0A0:
    /* CB8A0 800DB0A0 EF67030C */  jal        RaceStatistics__Fv
    /* CB8A4 800DB0A4 00000000 */   nop
  .L800DB0A8:
    /* CB8A8 800DB0A8 1000BF8F */  lw         $ra, 0x10($sp)
    /* CB8AC 800DB0AC 00000000 */  nop
    /* CB8B0 800DB0B0 0800E003 */  jr         $ra
    /* CB8B4 800DB0B4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Hud_RenderStatsView__Fv
