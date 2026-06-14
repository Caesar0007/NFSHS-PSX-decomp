.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching StampImage__Fii, 0x15C

glabel StampImage__Fii
    /* A40A8 800B38A8 7C0E828F */  lw         $v0, %gp_rel(Render_gBlurEffectMode)($gp)
    /* A40AC 800B38AC 00000000 */  nop
    /* A40B0 800B38B0 02004230 */  andi       $v0, $v0, 0x2
    /* A40B4 800B38B4 05004010 */  beqz       $v0, .L800B38CC
    /* A40B8 800B38B8 01000224 */   addiu     $v0, $zero, 0x1
    /* A40BC 800B38BC 14800D3C */  lui        $t5, %hi(gFlip)
    /* A40C0 800B38C0 B4D7AD8D */  lw         $t5, %lo(gFlip)($t5)
    /* A40C4 800B38C4 37CE0208 */  j          .L800B38DC
    /* A40C8 800B38C8 00000000 */   nop
  .L800B38CC:
    /* A40CC 800B38CC 1480033C */  lui        $v1, %hi(gFlip)
    /* A40D0 800B38D0 B4D7638C */  lw         $v1, %lo(gFlip)($v1)
    /* A40D4 800B38D4 00000000 */  nop
    /* A40D8 800B38D8 23684300 */  subu       $t5, $v0, $v1
  .L800B38DC:
    /* A40DC 800B38DC 7C0E828F */  lw         $v0, %gp_rel(Render_gBlurEffectMode)($gp)
    /* A40E0 800B38E0 00000000 */  nop
    /* A40E4 800B38E4 04004230 */  andi       $v0, $v0, 0x4
    /* A40E8 800B38E8 02004014 */  bnez       $v0, .L800B38F4
    /* A40EC 800B38EC 21400000 */   addu      $t0, $zero, $zero
    /* A40F0 800B38F0 21200000 */  addu       $a0, $zero, $zero
  .L800B38F4:
    /* A40F4 800B38F4 801F0B3C */  lui        $t3, (0x1F800004 >> 16)
    /* A40F8 800B38F8 04006B35 */  ori        $t3, $t3, (0x1F800004 & 0xFFFF)
    /* A40FC 800B38FC FF000A3C */  lui        $t2, (0xFFFFFF >> 16)
    /* A4100 800B3900 FFFF4A35 */  ori        $t2, $t2, (0xFFFFFF & 0xFFFF)
    /* A4104 800B3904 00FF193C */  lui        $t9, (0xFF000000 >> 16)
    /* A4108 800B3908 40001824 */  addiu      $t8, $zero, 0x40
    /* A410C 800B390C F0000F24 */  addiu      $t7, $zero, 0xF0
    /* A4110 800B3910 F0000E24 */  addiu      $t6, $zero, 0xF0
    /* A4114 800B3914 80000C24 */  addiu      $t4, $zero, 0x80
    /* A4118 800B3918 40010924 */  addiu      $t1, $zero, 0x140
    /* A411C 800B391C 21388000 */  addu       $a3, $a0, $zero
  .L800B3920:
    /* A4120 800B3920 80200500 */  sll        $a0, $a1, 2
    /* A4124 800B3924 801F023C */  lui        $v0, (0x1F800000 >> 16)
    /* A4128 800B3928 0000428C */  lw         $v0, (0x1F800000 & 0xFFFF)($v0)
    /* A412C 800B392C 0000668D */  lw         $a2, 0x0($t3)
    /* A4130 800B3930 21208200 */  addu       $a0, $a0, $v0
    /* A4134 800B3934 0000C38C */  lw         $v1, 0x0($a2)
    /* A4138 800B3938 0000828C */  lw         $v0, 0x0($a0)
    /* A413C 800B393C 24187900 */  and        $v1, $v1, $t9
    /* A4140 800B3940 24104A00 */  and        $v0, $v0, $t2
    /* A4144 800B3944 25186200 */  or         $v1, $v1, $v0
    /* A4148 800B3948 0000C3AC */  sw         $v1, 0x0($a2)
    /* A414C 800B394C 0000838C */  lw         $v1, 0x0($a0)
    /* A4150 800B3950 2800C224 */  addiu      $v0, $a2, 0x28
    /* A4154 800B3954 000062AD */  sw         $v0, 0x0($t3)
    /* A4158 800B3958 2410CA00 */  and        $v0, $a2, $t2
    /* A415C 800B395C 24187900 */  and        $v1, $v1, $t9
    /* A4160 800B3960 25186200 */  or         $v1, $v1, $v0
    /* A4164 800B3964 09000224 */  addiu      $v0, $zero, 0x9
    /* A4168 800B3968 000083AC */  sw         $v1, 0x0($a0)
    /* A416C 800B396C 0300C2A0 */  sb         $v0, 0x3($a2)
    /* A4170 800B3970 2E000224 */  addiu      $v0, $zero, 0x2E
    /* A4174 800B3974 0700C2A0 */  sb         $v0, 0x7($a2)
    /* A4178 800B3978 4000E224 */  addiu      $v0, $a3, 0x40
    /* A417C 800B397C 1000C2A4 */  sh         $v0, 0x10($a2)
    /* A4180 800B3980 2000C2A4 */  sh         $v0, 0x20($a2)
    /* A4184 800B3984 80110800 */  sll        $v0, $t0, 6
    /* A4188 800B3988 0C00C0A0 */  sb         $zero, 0xC($a2)
    /* A418C 800B398C 0D00C0A0 */  sb         $zero, 0xD($a2)
    /* A4190 800B3990 1400D8A0 */  sb         $t8, 0x14($a2)
    /* A4194 800B3994 1500C0A0 */  sb         $zero, 0x15($a2)
    /* A4198 800B3998 1C00C0A0 */  sb         $zero, 0x1C($a2)
    /* A419C 800B399C 1D00CFA0 */  sb         $t7, 0x1D($a2)
    /* A41A0 800B39A0 2400D8A0 */  sb         $t8, 0x24($a2)
    /* A41A4 800B39A4 2500CFA0 */  sb         $t7, 0x25($a2)
    /* A41A8 800B39A8 0800C7A4 */  sh         $a3, 0x8($a2)
    /* A41AC 800B39AC 0A00C0A4 */  sh         $zero, 0xA($a2)
    /* A41B0 800B39B0 1200C0A4 */  sh         $zero, 0x12($a2)
    /* A41B4 800B39B4 1800C7A4 */  sh         $a3, 0x18($a2)
    /* A41B8 800B39B8 1A00CEA4 */  sh         $t6, 0x1A($a2)
    /* A41BC 800B39BC 2200CEA4 */  sh         $t6, 0x22($a2)
    /* A41C0 800B39C0 0400CCA0 */  sb         $t4, 0x4($a2)
    /* A41C4 800B39C4 0500CCA0 */  sb         $t4, 0x5($a2)
    /* A41C8 800B39C8 0300A015 */  bnez       $t5, .L800B39D8
    /* A41CC 800B39CC 0600CCA0 */   sb        $t4, 0x6($a2)
    /* A41D0 800B39D0 77CE0208 */  j          .L800B39DC
    /* A41D4 800B39D4 FF032231 */   andi      $v0, $t1, 0x3FF
  .L800B39D8:
    /* A41D8 800B39D8 FF034230 */  andi       $v0, $v0, 0x3FF
  .L800B39DC:
    /* A41DC 800B39DC 83110200 */  sra        $v0, $v0, 6
    /* A41E0 800B39E0 10014234 */  ori        $v0, $v0, 0x110
    /* A41E4 800B39E4 1600C2A4 */  sh         $v0, 0x16($a2)
    /* A41E8 800B39E8 40002925 */  addiu      $t1, $t1, 0x40
    /* A41EC 800B39EC 01000825 */  addiu      $t0, $t0, 0x1
    /* A41F0 800B39F0 05000229 */  slti       $v0, $t0, 0x5
    /* A41F4 800B39F4 CAFF4014 */  bnez       $v0, .L800B3920
    /* A41F8 800B39F8 4000E724 */   addiu     $a3, $a3, 0x40
    /* A41FC 800B39FC 0800E003 */  jr         $ra
    /* A4200 800B3A00 00000000 */   nop
endlabel StampImage__Fii
