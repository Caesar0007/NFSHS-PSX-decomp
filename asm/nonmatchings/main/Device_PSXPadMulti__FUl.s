.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Device_PSXPadMulti__FUl, 0xDC

glabel Device_PSXPadMulti__FUl
    /* AE0DC 800BD8DC 1280023C */  lui        $v0, %hi(D_8011E0CC)
    /* AE0E0 800BD8E0 CCE0428C */  lw         $v0, %lo(D_8011E0CC)($v0)
    /* AE0E4 800BD8E4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* AE0E8 800BD8E8 1000B0AF */  sw         $s0, 0x10($sp)
    /* AE0EC 800BD8EC 21808000 */  addu       $s0, $a0, $zero
    /* AE0F0 800BD8F0 09004010 */  beqz       $v0, .L800BD918
    /* AE0F4 800BD8F4 1400BFAF */   sw        $ra, 0x14($sp)
    /* AE0F8 800BD8F8 3012848F */  lw         $a0, %gp_rel(Device_gPausePort)($gp)
    /* AE0FC 800BD8FC ABF5020C */  jal        Device_ReadPad__FiUl
    /* AE100 800BD900 21280002 */   addu      $a1, $s0, $zero
    /* AE104 800BD904 21184000 */  addu       $v1, $v0, $zero
    /* AE108 800BD908 27006014 */  bnez       $v1, .L800BD9A8
    /* AE10C 800BD90C FF000224 */   addiu     $v0, $zero, 0xFF
    /* AE110 800BD910 6AF60208 */  j          .L800BD9A8
    /* AE114 800BD914 21100000 */   addu      $v0, $zero, $zero
  .L800BD918:
    /* AE118 800BD918 21200000 */  addu       $a0, $zero, $zero
    /* AE11C 800BD91C ABF5020C */  jal        Device_ReadPad__FiUl
    /* AE120 800BD920 21280002 */   addu      $a1, $s0, $zero
    /* AE124 800BD924 08004010 */  beqz       $v0, .L800BD948
    /* AE128 800BD928 FFFF0332 */   andi      $v1, $s0, 0xFFFF
    /* AE12C 800BD92C 08000224 */  addiu      $v0, $zero, 0x8
    /* AE130 800BD930 1D006214 */  bne        $v1, $v0, .L800BD9A8
    /* AE134 800BD934 FF000224 */   addiu     $v0, $zero, 0xFF
    /* AE138 800BD938 301280AF */  sw         $zero, %gp_rel(Device_gPausePort)($gp)
    /* AE13C 800BD93C 481280A3 */  sb         $zero, %gp_rel(Device_gPausePortIndex)($gp)
    /* AE140 800BD940 6AF60208 */  j          .L800BD9A8
    /* AE144 800BD944 00000000 */   nop
  .L800BD948:
    /* AE148 800BD948 1480023C */  lui        $v0, %hi(Replay_ReplayMode)
    /* AE14C 800BD94C F4D3428C */  lw         $v0, %lo(Replay_ReplayMode)($v0)
    /* AE150 800BD950 00000000 */  nop
    /* AE154 800BD954 02004228 */  slti       $v0, $v0, 0x2
    /* AE158 800BD958 05004010 */  beqz       $v0, .L800BD970
    /* AE15C 800BD95C 1180023C */   lui       $v0, %hi(D_801131F8)
    /* AE160 800BD960 F831438C */  lw         $v1, %lo(D_801131F8)($v0)
    /* AE164 800BD964 01000224 */  addiu      $v0, $zero, 0x1
    /* AE168 800BD968 0F006214 */  bne        $v1, $v0, .L800BD9A8
    /* AE16C 800BD96C 21100000 */   addu      $v0, $zero, $zero
  .L800BD970:
    /* AE170 800BD970 04000424 */  addiu      $a0, $zero, 0x4
    /* AE174 800BD974 ABF5020C */  jal        Device_ReadPad__FiUl
    /* AE178 800BD978 21280002 */   addu      $a1, $s0, $zero
    /* AE17C 800BD97C 09004010 */  beqz       $v0, .L800BD9A4
    /* AE180 800BD980 FFFF0332 */   andi      $v1, $s0, 0xFFFF
    /* AE184 800BD984 08000224 */  addiu      $v0, $zero, 0x8
    /* AE188 800BD988 04006214 */  bne        $v1, $v0, .L800BD99C
    /* AE18C 800BD98C 01000224 */   addiu     $v0, $zero, 0x1
    /* AE190 800BD990 481282A3 */  sb         $v0, %gp_rel(Device_gPausePortIndex)($gp)
    /* AE194 800BD994 04000224 */  addiu      $v0, $zero, 0x4
    /* AE198 800BD998 301282AF */  sw         $v0, %gp_rel(Device_gPausePort)($gp)
  .L800BD99C:
    /* AE19C 800BD99C 6AF60208 */  j          .L800BD9A8
    /* AE1A0 800BD9A0 FF000224 */   addiu     $v0, $zero, 0xFF
  .L800BD9A4:
    /* AE1A4 800BD9A4 21100000 */  addu       $v0, $zero, $zero
  .L800BD9A8:
    /* AE1A8 800BD9A8 1400BF8F */  lw         $ra, 0x14($sp)
    /* AE1AC 800BD9AC 1000B08F */  lw         $s0, 0x10($sp)
    /* AE1B0 800BD9B0 0800E003 */  jr         $ra
    /* AE1B4 800BD9B4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Device_PSXPadMulti__FUl
