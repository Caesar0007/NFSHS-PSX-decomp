.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Night_DoLightningEffect__FP13DRender_tView, 0x184

glabel Night_DoLightningEffect__FP13DRender_tView
    /* CBEC4 800DB6C4 1815828F */  lw         $v0, %gp_rel(Night_gLightning)($gp)
    /* CBEC8 800DB6C8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* CBECC 800DB6CC 1000B0AF */  sw         $s0, 0x10($sp)
    /* CBED0 800DB6D0 21808000 */  addu       $s0, $a0, $zero
    /* CBED4 800DB6D4 08004010 */  beqz       $v0, .L800DB6F8
    /* CBED8 800DB6D8 1400BFAF */   sw        $ra, 0x14($sp)
    /* CBEDC 800DB6DC 3015848F */  lw         $a0, %gp_rel(Night_gFlashIntensity)($gp)
    /* CBEE0 800DB6E0 2815858F */  lw         $a1, %gp_rel(Night_gFlashAzimuth)($gp)
    /* CBEE4 800DB6E4 29D9010C */  jal        AudioCmn_PlayThunder__Fii
    /* CBEE8 800DB6E8 00000000 */   nop
    /* CBEEC 800DB6EC D841030C */  jal        Hrz_LightningFlicker__Fi
    /* CBEF0 800DB6F0 21200000 */   addu      $a0, $zero, $zero
    /* CBEF4 800DB6F4 181580AF */  sw         $zero, %gp_rel(Night_gLightning)($gp)
  .L800DB6F8:
    /* CBEF8 800DB6F8 1280023C */  lui        $v0, %hi(D_8011E0B0)
    /* CBEFC 800DB6FC B0E0438C */  lw         $v1, %lo(D_8011E0B0)($v0)
    /* CBF00 800DB700 1C15828F */  lw         $v0, %gp_rel(Night_gNextLightning)($gp)
    /* CBF04 800DB704 00000000 */  nop
    /* CBF08 800DB708 2A104300 */  slt        $v0, $v0, $v1
    /* CBF0C 800DB70C 3E004010 */  beqz       $v0, .L800DB808
    /* CBF10 800DB710 1280023C */   lui       $v0, %hi(D_8011E0B0)
    /* CBF14 800DB714 2015828F */  lw         $v0, %gp_rel(Night_gEndNextLightning)($gp)
    /* CBF18 800DB718 00000000 */  nop
    /* CBF1C 800DB71C 2A106200 */  slt        $v0, $v1, $v0
    /* CBF20 800DB720 39004010 */  beqz       $v0, .L800DB808
    /* CBF24 800DB724 1280023C */   lui       $v0, %hi(D_8011E0B0)
    /* CBF28 800DB728 2415828F */  lw         $v0, %gp_rel(Night_gNextFlicker)($gp)
    /* CBF2C 800DB72C 00000000 */  nop
    /* CBF30 800DB730 2A104300 */  slt        $v0, $v0, $v1
    /* CBF34 800DB734 34004010 */  beqz       $v0, .L800DB808
    /* CBF38 800DB738 1280023C */   lui       $v0, %hi(D_8011E0B0)
    /* CBF3C 800DB73C EA9D030C */  jal        random
    /* CBF40 800DB740 00000000 */   nop
    /* CBF44 800DB744 01000424 */  addiu      $a0, $zero, 0x1
    /* CBF48 800DB748 24104400 */  and        $v0, $v0, $a0
    /* CBF4C 800DB74C F81482AF */  sw         $v0, %gp_rel(Night_gLightningType)($gp)
    /* CBF50 800DB750 D841030C */  jal        Hrz_LightningFlicker__Fi
    /* CBF54 800DB754 00000000 */   nop
    /* CBF58 800DB758 1180043C */  lui        $a0, %hi(D_8010F338)
    /* CBF5C 800DB75C 0400038E */  lw         $v1, 0x4($s0)
    /* CBF60 800DB760 38F38424 */  addiu      $a0, $a0, %lo(D_8010F338)
    /* CBF64 800DB764 00110300 */  sll        $v0, $v1, 4
    /* CBF68 800DB768 21104300 */  addu       $v0, $v0, $v1
    /* CBF6C 800DB76C 00110200 */  sll        $v0, $v0, 4
    /* CBF70 800DB770 F5FF010C */  jal        BWorldSm_TunnelFlagSm__FP12BWorldSm_Pos
    /* CBF74 800DB774 21204400 */   addu      $a0, $v0, $a0
    /* CBF78 800DB778 04004010 */  beqz       $v0, .L800DB78C
    /* CBF7C 800DB77C 01000224 */   addiu     $v0, $zero, 0x1
    /* CBF80 800DB780 941480A3 */  sb         $zero, %gp_rel(Night_gDrawLightning)($gp)
    /* CBF84 800DB784 E66D0308 */  j          .L800DB798
    /* CBF88 800DB788 00000000 */   nop
  .L800DB78C:
    /* CBF8C 800DB78C 01000224 */  addiu      $v0, $zero, 0x1
    /* CBF90 800DB790 941482A3 */  sb         $v0, %gp_rel(Night_gDrawLightning)($gp)
    /* CBF94 800DB794 01000224 */  addiu      $v0, $zero, 0x1
  .L800DB798:
    /* CBF98 800DB798 181582AF */  sw         $v0, %gp_rel(Night_gLightning)($gp)
    /* CBF9C 800DB79C EA9D030C */  jal        random
    /* CBFA0 800DB7A0 00000000 */   nop
    /* CBFA4 800DB7A4 1280033C */  lui        $v1, %hi(D_8011E0B0)
    /* CBFA8 800DB7A8 B0E0638C */  lw         $v1, %lo(D_8011E0B0)($v1)
    /* CBFAC 800DB7AC 03004230 */  andi       $v0, $v0, 0x3
    /* CBFB0 800DB7B0 21186200 */  addu       $v1, $v1, $v0
    /* CBFB4 800DB7B4 241583AF */  sw         $v1, %gp_rel(Night_gNextFlicker)($gp)
    /* CBFB8 800DB7B8 EA9D030C */  jal        random
    /* CBFBC 800DB7BC 00000000 */   nop
    /* CBFC0 800DB7C0 F814838F */  lw         $v1, %gp_rel(Night_gLightningType)($gp)
    /* CBFC4 800DB7C4 1F004230 */  andi       $v0, $v0, 0x1F
    /* CBFC8 800DB7C8 01006324 */  addiu      $v1, $v1, 0x1
    /* CBFCC 800DB7CC 18006200 */  mult       $v1, $v0
    /* CBFD0 800DB7D0 B2148393 */  lbu        $v1, %gp_rel(D_8013D9FE)($gp)
    /* CBFD4 800DB7D4 12300000 */  mflo       $a2
    /* CBFD8 800DB7D8 4000C224 */  addiu      $v0, $a2, 0x40
    /* CBFDC 800DB7DC 301582AF */  sw         $v0, %gp_rel(Night_gFlashIntensity)($gp)
    /* CBFE0 800DB7E0 09006010 */  beqz       $v1, .L800DB808
    /* CBFE4 800DB7E4 1280023C */   lui       $v0, %hi(D_8011E0B0)
    /* CBFE8 800DB7E8 2C158293 */  lbu        $v0, %gp_rel(Night_gShowForks)($gp)
    /* CBFEC 800DB7EC 00000000 */  nop
    /* CBFF0 800DB7F0 03004010 */  beqz       $v0, .L800DB800
    /* CBFF4 800DB7F4 00000000 */   nop
    /* CBFF8 800DB7F8 4D41030C */  jal        Hrz_SetLightingPosInSky__FP13DRender_tView
    /* CBFFC 800DB7FC 21200002 */   addu      $a0, $s0, $zero
  .L800DB800:
    /* CC000 800DB800 B21480A3 */  sb         $zero, %gp_rel(D_8013D9FE)($gp)
    /* CC004 800DB804 1280023C */  lui        $v0, %hi(D_8011E0B0)
  .L800DB808:
    /* CC008 800DB808 B0E0438C */  lw         $v1, %lo(D_8011E0B0)($v0)
    /* CC00C 800DB80C 2015828F */  lw         $v0, %gp_rel(Night_gEndNextLightning)($gp)
    /* CC010 800DB810 00000000 */  nop
    /* CC014 800DB814 2A104300 */  slt        $v0, $v0, $v1
    /* CC018 800DB818 07004010 */  beqz       $v0, .L800DB838
    /* CC01C 800DB81C 00000000 */   nop
    /* CC020 800DB820 736D030C */  jal        Night_GenerateNextLightningEvent__Fv
    /* CC024 800DB824 00000000 */   nop
    /* CC028 800DB828 F240030C */  jal        Hrz_CalculateLightning__Fv
    /* CC02C 800DB82C 00000000 */   nop
    /* CC030 800DB830 01000224 */  addiu      $v0, $zero, 0x1
    /* CC034 800DB834 B21482A3 */  sb         $v0, %gp_rel(D_8013D9FE)($gp)
  .L800DB838:
    /* CC038 800DB838 1400BF8F */  lw         $ra, 0x14($sp)
    /* CC03C 800DB83C 1000B08F */  lw         $s0, 0x10($sp)
    /* CC040 800DB840 0800E003 */  jr         $ra
    /* CC044 800DB844 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Night_DoLightningEffect__FP13DRender_tView
