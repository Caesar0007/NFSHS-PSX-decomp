.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hrz_SetLightingPosInSky__FP13DRender_tView, 0x110

glabel Hrz_SetLightingPosInSky__FP13DRender_tView
    /* C0D34 800D0534 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* C0D38 800D0538 2400BFAF */  sw         $ra, 0x24($sp)
    /* C0D3C 800D053C 2000B0AF */  sw         $s0, 0x20($sp)
    /* C0D40 800D0540 2C00868C */  lw         $a2, 0x2C($a0)
    /* C0D44 800D0544 3000878C */  lw         $a3, 0x30($a0)
    /* C0D48 800D0548 3400888C */  lw         $t0, 0x34($a0)
    /* C0D4C 800D054C 1000A6AF */  sw         $a2, 0x10($sp)
    /* C0D50 800D0550 1400A7AF */  sw         $a3, 0x14($sp)
    /* C0D54 800D0554 1800A8AF */  sw         $t0, 0x18($sp)
    /* C0D58 800D0558 EA9D030C */  jal        random
    /* C0D5C 800D055C 6210103C */   lui       $s0, (0x10624DD3 >> 16)
    /* C0D60 800D0560 D34D1036 */  ori        $s0, $s0, (0x10624DD3 & 0xFFFF)
    /* C0D64 800D0564 19005000 */  multu      $v0, $s0
    /* C0D68 800D0568 1000A48F */  lw         $a0, 0x10($sp)
    /* C0D6C 800D056C 00000000 */  nop
    /* C0D70 800D0570 83200400 */  sra        $a0, $a0, 2
    /* C0D74 800D0574 10300000 */  mfhi       $a2
    /* C0D78 800D0578 422A0600 */  srl        $a1, $a2, 9
    /* C0D7C 800D057C 40190500 */  sll        $v1, $a1, 5
    /* C0D80 800D0580 23186500 */  subu       $v1, $v1, $a1
    /* C0D84 800D0584 80180300 */  sll        $v1, $v1, 2
    /* C0D88 800D0588 21186500 */  addu       $v1, $v1, $a1
    /* C0D8C 800D058C 80190300 */  sll        $v1, $v1, 6
    /* C0D90 800D0590 23104300 */  subu       $v0, $v0, $v1
    /* C0D94 800D0594 21208200 */  addu       $a0, $a0, $v0
    /* C0D98 800D0598 60F08424 */  addiu      $a0, $a0, -0xFA0
    /* C0D9C 800D059C 481384A7 */  sh         $a0, %gp_rel(Hrz_gLightningPosInSky)($gp)
    /* C0DA0 800D05A0 EA9D030C */  jal        random
    /* C0DA4 800D05A4 00000000 */   nop
    /* C0DA8 800D05A8 7605033C */  lui        $v1, (0x57619F1 >> 16)
    /* C0DAC 800D05AC F1196334 */  ori        $v1, $v1, (0x57619F1 & 0xFFFF)
    /* C0DB0 800D05B0 19004300 */  multu      $v0, $v1
    /* C0DB4 800D05B4 1400A48F */  lw         $a0, 0x14($sp)
    /* C0DB8 800D05B8 00000000 */  nop
    /* C0DBC 800D05BC 83200400 */  sra        $a0, $a0, 2
    /* C0DC0 800D05C0 401F8424 */  addiu      $a0, $a0, 0x1F40
    /* C0DC4 800D05C4 10300000 */  mfhi       $a2
    /* C0DC8 800D05C8 82290600 */  srl        $a1, $a2, 6
    /* C0DCC 800D05CC 40180500 */  sll        $v1, $a1, 1
    /* C0DD0 800D05D0 21186500 */  addu       $v1, $v1, $a1
    /* C0DD4 800D05D4 00190300 */  sll        $v1, $v1, 4
    /* C0DD8 800D05D8 23186500 */  subu       $v1, $v1, $a1
    /* C0DDC 800D05DC C0180300 */  sll        $v1, $v1, 3
    /* C0DE0 800D05E0 23186500 */  subu       $v1, $v1, $a1
    /* C0DE4 800D05E4 C0180300 */  sll        $v1, $v1, 3
    /* C0DE8 800D05E8 23104300 */  subu       $v0, $v0, $v1
    /* C0DEC 800D05EC 21208200 */  addu       $a0, $a0, $v0
    /* C0DF0 800D05F0 4A1384A7 */  sh         $a0, %gp_rel(D_8013D896)($gp)
    /* C0DF4 800D05F4 EA9D030C */  jal        random
    /* C0DF8 800D05F8 00000000 */   nop
    /* C0DFC 800D05FC 19005000 */  multu      $v0, $s0
    /* C0E00 800D0600 1800A48F */  lw         $a0, 0x18($sp)
    /* C0E04 800D0604 2400BF8F */  lw         $ra, 0x24($sp)
    /* C0E08 800D0608 2000B08F */  lw         $s0, 0x20($sp)
    /* C0E0C 800D060C 83200400 */  sra        $a0, $a0, 2
    /* C0E10 800D0610 10300000 */  mfhi       $a2
    /* C0E14 800D0614 422A0600 */  srl        $a1, $a2, 9
    /* C0E18 800D0618 40190500 */  sll        $v1, $a1, 5
    /* C0E1C 800D061C 23186500 */  subu       $v1, $v1, $a1
    /* C0E20 800D0620 80180300 */  sll        $v1, $v1, 2
    /* C0E24 800D0624 21186500 */  addu       $v1, $v1, $a1
    /* C0E28 800D0628 80190300 */  sll        $v1, $v1, 6
    /* C0E2C 800D062C 23104300 */  subu       $v0, $v0, $v1
    /* C0E30 800D0630 21208200 */  addu       $a0, $a0, $v0
    /* C0E34 800D0634 60F08424 */  addiu      $a0, $a0, -0xFA0
    /* C0E38 800D0638 4C1384A7 */  sh         $a0, %gp_rel(D_8013D898)($gp)
    /* C0E3C 800D063C 0800E003 */  jr         $ra
    /* C0E40 800D0640 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel Hrz_SetLightingPosInSky__FP13DRender_tView
