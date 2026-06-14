.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Weather_BuildWeather__FP13DRender_tView, 0x5C

glabel Weather_BuildWeather__FP13DRender_tView
    /* D4530 800E3D30 1180023C */  lui        $v0, %hi(D_80113234)
    /* D4534 800E3D34 3432428C */  lw         $v0, %lo(D_80113234)($v0)
    /* D4538 800E3D38 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* D453C 800E3D3C 1000B0AF */  sw         $s0, 0x10($sp)
    /* D4540 800E3D40 21808000 */  addu       $s0, $a0, $zero
    /* D4544 800E3D44 0D004010 */  beqz       $v0, .L800E3D7C
    /* D4548 800E3D48 1400BFAF */   sw        $ra, 0x14($sp)
    /* D454C 800E3D4C 0400038E */  lw         $v1, 0x4($s0)
    /* D4550 800E3D50 1180043C */  lui        $a0, %hi(D_8010F338)
    /* D4554 800E3D54 38F38424 */  addiu      $a0, $a0, %lo(D_8010F338)
    /* D4558 800E3D58 00110300 */  sll        $v0, $v1, 4
    /* D455C 800E3D5C 21104300 */  addu       $v0, $v0, $v1
    /* D4560 800E3D60 00110200 */  sll        $v0, $v0, 4
    /* D4564 800E3D64 F5FF010C */  jal        BWorldSm_TunnelFlagSm__FP12BWorldSm_Pos
    /* D4568 800E3D68 21204400 */   addu      $a0, $v0, $a0
    /* D456C 800E3D6C 03004014 */  bnez       $v0, .L800E3D7C
    /* D4570 800E3D70 00000000 */   nop
    /* D4574 800E3D74 878E030C */  jal        Weather_DoWeather__FP13DRender_tView
    /* D4578 800E3D78 21200002 */   addu      $a0, $s0, $zero
  .L800E3D7C:
    /* D457C 800E3D7C 1400BF8F */  lw         $ra, 0x14($sp)
    /* D4580 800E3D80 1000B08F */  lw         $s0, 0x10($sp)
    /* D4584 800E3D84 0800E003 */  jr         $ra
    /* D4588 800E3D88 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Weather_BuildWeather__FP13DRender_tView
