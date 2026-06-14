.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Audio_InitDriver__Fii, 0xE0

glabel Audio_InitDriver__Fii
    /* AC384 800BBB84 A0FFBD27 */  addiu      $sp, $sp, -0x60
    /* AC388 800BBB88 5000B0AF */  sw         $s0, 0x50($sp)
    /* AC38C 800BBB8C 21808000 */  addu       $s0, $a0, $zero
    /* AC390 800BBB90 5400B1AF */  sw         $s1, 0x54($sp)
    /* AC394 800BBB94 2188A000 */  addu       $s1, $a1, $zero
    /* AC398 800BBB98 21200000 */  addu       $a0, $zero, $zero
    /* AC39C 800BBB9C 1180023C */  lui        $v0, %hi(gSndBnk)
    /* AC3A0 800BBBA0 A8E84324 */  addiu      $v1, $v0, %lo(gSndBnk)
    /* AC3A4 800BBBA4 5800BFAF */  sw         $ra, 0x58($sp)
  .L800BBBA8:
    /* AC3A8 800BBBA8 000064AC */  sw         $a0, 0x0($v1)
    /* AC3AC 800BBBAC 080060AC */  sw         $zero, 0x8($v1)
    /* AC3B0 800BBBB0 01008424 */  addiu      $a0, $a0, 0x1
    /* AC3B4 800BBBB4 07008228 */  slti       $v0, $a0, 0x7
    /* AC3B8 800BBBB8 FBFF4014 */  bnez       $v0, .L800BBBA8
    /* AC3BC 800BBBBC 0C006324 */   addiu     $v1, $v1, 0xC
    /* AC3C0 800BBBC0 1480023C */  lui        $v0, %hi(AudioCmn_kAudioOn)
    /* AC3C4 800BBBC4 44C6428C */  lw         $v0, %lo(AudioCmn_kAudioOn)($v0)
    /* AC3C8 800BBBC8 00000000 */  nop
    /* AC3CC 800BBBCC 06004014 */  bnez       $v0, .L800BBBE8
    /* AC3D0 800BBBD0 00000000 */   nop
    /* AC3D4 800BBBD4 1480023C */  lui        $v0, %hi(AudioCmn_kAudioStreamingOn)
    /* AC3D8 800BBBD8 48C6428C */  lw         $v0, %lo(AudioCmn_kAudioStreamingOn)($v0)
    /* AC3DC 800BBBDC 00000000 */  nop
    /* AC3E0 800BBBE0 14004010 */  beqz       $v0, .L800BBC34
    /* AC3E4 800BBBE4 00000000 */   nop
  .L800BBBE8:
    /* AC3E8 800BBBE8 56C7030C */  jal        SNDSYS_getopts
    /* AC3EC 800BBBEC 1000A427 */   addiu     $a0, $sp, 0x10
    /* AC3F0 800BBBF0 1000A427 */  addiu      $a0, $sp, 0x10
    /* AC3F4 800BBBF4 30000224 */  addiu      $v0, $zero, 0x30
    /* AC3F8 800BBBF8 85C7030C */  jal        SNDSYS_setopts
    /* AC3FC 800BBBFC 1C00A2A7 */   sh        $v0, 0x1C($sp)
    /* AC400 800BBC00 54C8030C */  jal        SNDSYS_vectortoreal
    /* AC404 800BBC04 00000000 */   nop
    /* AC408 800BBC08 0580043C */  lui        $a0, %hi(D_80056754)
    /* AC40C 800BBC0C 54678424 */  addiu      $a0, $a0, %lo(D_80056754)
    /* AC410 800BBC10 00100524 */  addiu      $a1, $zero, 0x1000
    /* AC414 800BBC14 CF94030C */  jal        reservememadr
    /* AC418 800BBC18 21300000 */   addu      $a2, $zero, $zero
    /* AC41C 800BBC1C 21204000 */  addu       $a0, $v0, $zero
    /* AC420 800BBC20 B40F84AF */  sw         $a0, %gp_rel(Audio_gHeap)($gp)
    /* AC424 800BBC24 C4C7030C */  jal        SNDSYS_init
    /* AC428 800BBC28 00100524 */   addiu     $a1, $zero, 0x1000
    /* AC42C 800BBC2C A2E7010C */  jal        AudioCmn_InitReverb__Fv
    /* AC430 800BBC30 00000000 */   nop
  .L800BBC34:
    /* AC434 800BBC34 0500001A */  blez       $s0, .L800BBC4C
    /* AC438 800BBC38 21200002 */   addu      $a0, $s0, $zero
    /* AC43C 800BBC3C 21282002 */  addu       $a1, $s1, $zero
    /* AC440 800BBC40 1480063C */  lui        $a2, %hi(D_8013D504)
    /* AC444 800BBC44 06EB010C */  jal        AudioMus_SysStartUp__FiiPc
    /* AC448 800BBC48 04D5C624 */   addiu     $a2, $a2, %lo(D_8013D504)
  .L800BBC4C:
    /* AC44C 800BBC4C 5800BF8F */  lw         $ra, 0x58($sp)
    /* AC450 800BBC50 5400B18F */  lw         $s1, 0x54($sp)
    /* AC454 800BBC54 5000B08F */  lw         $s0, 0x50($sp)
    /* AC458 800BBC58 B00F80AF */  sw         $zero, %gp_rel(Audio_direct3davail)($gp)
    /* AC45C 800BBC5C 0800E003 */  jr         $ra
    /* AC460 800BBC60 6000BD27 */   addiu     $sp, $sp, 0x60
endlabel Audio_InitDriver__Fii
