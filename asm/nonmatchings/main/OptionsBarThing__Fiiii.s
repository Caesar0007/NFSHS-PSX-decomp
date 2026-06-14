.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching OptionsBarThing__Fiiii, 0xE0

glabel OptionsBarThing__Fiiii
    /* CA168 800D9968 C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* CA16C 800D996C 2C00B3AF */  sw         $s3, 0x2C($sp)
    /* CA170 800D9970 21988000 */  addu       $s3, $a0, $zero
    /* CA174 800D9974 2000B0AF */  sw         $s0, 0x20($sp)
    /* CA178 800D9978 2180A000 */  addu       $s0, $a1, $zero
    /* CA17C 800D997C 3000B4AF */  sw         $s4, 0x30($sp)
    /* CA180 800D9980 21A0C000 */  addu       $s4, $a2, $zero
    /* CA184 800D9984 2800B2AF */  sw         $s2, 0x28($sp)
    /* CA188 800D9988 2190E000 */  addu       $s2, $a3, $zero
    /* CA18C 800D998C 01000424 */  addiu      $a0, $zero, 0x1
    /* CA190 800D9990 3400BFAF */  sw         $ra, 0x34($sp)
    /* CA194 800D9994 5B47030C */  jal        Hud_GoTpage__Fi
    /* CA198 800D9998 2400B1AF */   sw        $s1, 0x24($sp)
    /* CA19C 800D999C 94E4020C */  jal        TextSys_Word__Fi
    /* CA1A0 800D99A0 40000424 */   addiu     $a0, $zero, 0x40
    /* CA1A4 800D99A4 40000424 */  addiu      $a0, $zero, 0x40
    /* CA1A8 800D99A8 94E4020C */  jal        TextSys_Word__Fi
    /* CA1AC 800D99AC 21884000 */   addu      $s1, $v0, $zero
    /* CA1B0 800D99B0 21204000 */  addu       $a0, $v0, $zero
    /* CA1B4 800D99B4 21280000 */  addu       $a1, $zero, $zero
    /* CA1B8 800D99B8 2130A000 */  addu       $a2, $a1, $zero
    /* CA1BC 800D99BC 2138A000 */  addu       $a3, $a1, $zero
    /* CA1C0 800D99C0 01000224 */  addiu      $v0, $zero, 0x1
    /* CA1C4 800D99C4 1000A0AF */  sw         $zero, 0x10($sp)
    /* CA1C8 800D99C8 B250030C */  jal        Hud_BuildString__FPciiiib
    /* CA1CC 800D99CC 1400A2AF */   sw        $v0, 0x14($sp)
    /* CA1D0 800D99D0 21202002 */  addu       $a0, $s1, $zero
    /* CA1D4 800D99D4 43100200 */  sra        $v0, $v0, 1
    /* CA1D8 800D99D8 A0000524 */  addiu      $a1, $zero, 0xA0
    /* CA1DC 800D99DC 2328A200 */  subu       $a1, $a1, $v0
    /* CA1E0 800D99E0 21801202 */  addu       $s0, $s0, $s2
    /* CA1E4 800D99E4 FAFF0626 */  addiu      $a2, $s0, -0x6
    /* CA1E8 800D99E8 BEBE0734 */  ori        $a3, $zero, 0xBEBE
    /* CA1EC 800D99EC 1000A0AF */  sw         $zero, 0x10($sp)
    /* CA1F0 800D99F0 B250030C */  jal        Hud_BuildString__FPciiiib
    /* CA1F4 800D99F4 1400A0AF */   sw        $zero, 0x14($sp)
    /* CA1F8 800D99F8 21200000 */  addu       $a0, $zero, $zero
    /* CA1FC 800D99FC 21286002 */  addu       $a1, $s3, $zero
    /* CA200 800D9A00 F8FF0626 */  addiu      $a2, $s0, -0x8
    /* CA204 800D9A04 21388002 */  addu       $a3, $s4, $zero
    /* CA208 800D9A08 08000224 */  addiu      $v0, $zero, 0x8
    /* CA20C 800D9A0C 1000A2AF */  sw         $v0, 0x10($sp)
    /* CA210 800D9A10 1400A0AF */  sw         $zero, 0x14($sp)
    /* CA214 800D9A14 1800A0AF */  sw         $zero, 0x18($sp)
    /* CA218 800D9A18 614A030C */  jal        Hud_FBuildF4__FiiiiiUlcc
    /* CA21C 800D9A1C 1C00A0AF */   sw        $zero, 0x1C($sp)
    /* CA220 800D9A20 5B47030C */  jal        Hud_GoTpage__Fi
    /* CA224 800D9A24 21200000 */   addu      $a0, $zero, $zero
    /* CA228 800D9A28 3400BF8F */  lw         $ra, 0x34($sp)
    /* CA22C 800D9A2C 3000B48F */  lw         $s4, 0x30($sp)
    /* CA230 800D9A30 2C00B38F */  lw         $s3, 0x2C($sp)
    /* CA234 800D9A34 2800B28F */  lw         $s2, 0x28($sp)
    /* CA238 800D9A38 2400B18F */  lw         $s1, 0x24($sp)
    /* CA23C 800D9A3C 2000B08F */  lw         $s0, 0x20($sp)
    /* CA240 800D9A40 0800E003 */  jr         $ra
    /* CA244 800D9A44 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel OptionsBarThing__Fiiii
