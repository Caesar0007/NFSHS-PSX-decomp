.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioMus_DriverStartUp__Fii, 0x144

glabel AudioMus_DriverStartUp__Fii
    /* 6B2D4 8007AAD4 D401828F */  lw         $v0, %gp_rel(AudioMus_g)($gp)
    /* 6B2D8 8007AAD8 A8FFBD27 */  addiu      $sp, $sp, -0x58
    /* 6B2DC 8007AADC 5000B2AF */  sw         $s2, 0x50($sp)
    /* 6B2E0 8007AAE0 21908000 */  addu       $s2, $a0, $zero
    /* 6B2E4 8007AAE4 4800B0AF */  sw         $s0, 0x48($sp)
    /* 6B2E8 8007AAE8 2180A000 */  addu       $s0, $a1, $zero
    /* 6B2EC 8007AAEC 5400BFAF */  sw         $ra, 0x54($sp)
    /* 6B2F0 8007AAF0 43004010 */  beqz       $v0, .L8007AC00
    /* 6B2F4 8007AAF4 4C00B1AF */   sw        $s1, 0x4C($sp)
    /* 6B2F8 8007AAF8 8000428C */  lw         $v0, 0x80($v0)
    /* 6B2FC 8007AAFC 00000000 */  nop
    /* 6B300 8007AB00 03004014 */  bnez       $v0, .L8007AB10
    /* 6B304 8007AB04 00000000 */   nop
    /* 6B308 8007AB08 9EEA010C */  jal        AudioMus_InitDriverGlobals__Fv
    /* 6B30C 8007AB0C 00000000 */   nop
  .L8007AB10:
    /* 6B310 8007AB10 D401848F */  lw         $a0, %gp_rel(AudioMus_g)($gp)
    /* 6B314 8007AB14 21105002 */  addu       $v0, $s2, $s0
    /* 6B318 8007AB18 7400838C */  lw         $v1, 0x74($a0)
    /* 6B31C 8007AB1C 43110200 */  sra        $v0, $v0, 5
    /* 6B320 8007AB20 28006104 */  bgez       $v1, .L8007ABC4
    /* 6B324 8007AB24 880082AC */   sw        $v0, 0x88($a0)
    /* 6B328 8007AB28 7000828C */  lw         $v0, 0x70($a0)
    /* 6B32C 8007AB2C 00000000 */  nop
    /* 6B330 8007AB30 24004010 */  beqz       $v0, .L8007ABC4
    /* 6B334 8007AB34 00000000 */   nop
    /* 6B338 8007AB38 02004106 */  bgez       $s2, .L8007AB44
    /* 6B33C 8007AB3C 21884002 */   addu      $s1, $s2, $zero
    /* 6B340 8007AB40 FF035126 */  addiu      $s1, $s2, 0x3FF
  .L8007AB44:
    /* 6B344 8007AB44 01000424 */  addiu      $a0, $zero, 0x1
    /* 6B348 8007AB48 838A1100 */  sra        $s1, $s1, 10
    /* 6B34C 8007AB4C 25A8030C */  jal        SNDSTRM_overhead
    /* 6B350 8007AB50 21282002 */   addu      $a1, $s1, $zero
    /* 6B354 8007AB54 1800A427 */  addiu      $a0, $sp, 0x18
    /* 6B358 8007AB58 E1A7030C */  jal        SNDgetlimits
    /* 6B35C 8007AB5C 21904202 */   addu      $s2, $s2, $v0
    /* 6B360 8007AB60 1800A427 */  addiu      $a0, $sp, 0x18
    /* 6B364 8007AB64 F5A7030C */  jal        SNDsetlimits
    /* 6B368 8007AB68 2800B0AF */   sw        $s0, 0x28($sp)
    /* 6B36C 8007AB6C 3000B027 */  addiu      $s0, $sp, 0x30
    /* 6B370 8007AB70 0D9A030C */  jal        SNDplaysetdef
    /* 6B374 8007AB74 21200002 */   addu      $a0, $s0, $zero
    /* 6B378 8007AB78 21200002 */  addu       $a0, $s0, $zero
    /* 6B37C 8007AB7C D401828F */  lw         $v0, %gp_rel(AudioMus_g)($gp)
    /* 6B380 8007AB80 01000524 */  addiu      $a1, $zero, 0x1
    /* 6B384 8007AB84 3800A0A3 */  sb         $zero, 0x38($sp)
    /* 6B388 8007AB88 1000B2AF */  sw         $s2, 0x10($sp)
    /* 6B38C 8007AB8C 7000478C */  lw         $a3, 0x70($v0)
    /* 6B390 8007AB90 D1A6030C */  jal        SNDSTRM_create
    /* 6B394 8007AB94 21302002 */   addu      $a2, $s1, $zero
    /* 6B398 8007AB98 D401838F */  lw         $v1, %gp_rel(AudioMus_g)($gp)
    /* 6B39C 8007AB9C 09004004 */  bltz       $v0, .L8007ABC4
    /* 6B3A0 8007ABA0 740062AC */   sw        $v0, 0x74($v1)
    /* 6B3A4 8007ABA4 21204000 */  addu       $a0, $v0, $zero
    /* 6B3A8 8007ABA8 4CA7030C */  jal        SNDSTRM_setgreedylevel
    /* 6B3AC 8007ABAC 21280000 */   addu      $a1, $zero, $zero
    /* 6B3B0 8007ABB0 D401828F */  lw         $v0, %gp_rel(AudioMus_g)($gp)
    /* 6B3B4 8007ABB4 FF000524 */  addiu      $a1, $zero, 0xFF
    /* 6B3B8 8007ABB8 7400448C */  lw         $a0, 0x74($v0)
    /* 6B3BC 8007ABBC 3C9B030C */  jal        SNDSTRM_setpriority
    /* 6B3C0 8007ABC0 05000624 */   addiu     $a2, $zero, 0x5
  .L8007ABC4:
    /* 6B3C4 8007ABC4 D401828F */  lw         $v0, %gp_rel(AudioMus_g)($gp)
    /* 6B3C8 8007ABC8 00000000 */  nop
    /* 6B3CC 8007ABCC 7400438C */  lw         $v1, 0x74($v0)
    /* 6B3D0 8007ABD0 7C00428C */  lw         $v0, 0x7C($v0)
    /* 6B3D4 8007ABD4 1480013C */  lui        $at, %hi(gMusicHandle)
    /* 6B3D8 8007ABD8 1CD523AC */  sw         $v1, %lo(gMusicHandle)($at)
    /* 6B3DC 8007ABDC 08004014 */  bnez       $v0, .L8007AC00
    /* 6B3E0 8007ABE0 0880043C */   lui       $a0, %hi(AudioMus_Server__Fii)
    /* 6B3E4 8007ABE4 D0A38424 */  addiu      $a0, $a0, %lo(AudioMus_Server__Fii)
    /* 6B3E8 8007ABE8 19000524 */  addiu      $a1, $zero, 0x19
    /* 6B3EC 8007ABEC BD9A030C */  jal        addsystemtask
    /* 6B3F0 8007ABF0 21300000 */   addu      $a2, $zero, $zero
    /* 6B3F4 8007ABF4 D401838F */  lw         $v1, %gp_rel(AudioMus_g)($gp)
    /* 6B3F8 8007ABF8 01000224 */  addiu      $v0, $zero, 0x1
    /* 6B3FC 8007ABFC 7C0062AC */  sw         $v0, 0x7C($v1)
  .L8007AC00:
    /* 6B400 8007AC00 5400BF8F */  lw         $ra, 0x54($sp)
    /* 6B404 8007AC04 5000B28F */  lw         $s2, 0x50($sp)
    /* 6B408 8007AC08 4C00B18F */  lw         $s1, 0x4C($sp)
    /* 6B40C 8007AC0C 4800B08F */  lw         $s0, 0x48($sp)
    /* 6B410 8007AC10 0800E003 */  jr         $ra
    /* 6B414 8007AC14 5800BD27 */   addiu     $sp, $sp, 0x58
endlabel AudioMus_DriverStartUp__Fii
