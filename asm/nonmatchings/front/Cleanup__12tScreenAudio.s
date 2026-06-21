.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Cleanup__12tScreenAudio, 0xF8

glabel Cleanup__12tScreenAudio
    /* 36A04 80046204 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 36A08 80046208 1400B1AF */  sw         $s1, 0x14($sp)
    /* 36A0C 8004620C 21888000 */  addu       $s1, $a0, $zero
    /* 36A10 80046210 1800BFAF */  sw         $ra, 0x18($sp)
    /* 36A14 80046214 1000B0AF */  sw         $s0, 0x10($sp)
    /* 36A18 80046218 68002286 */  lh         $v0, 0x68($s1)
    /* 36A1C 8004621C 00000000 */  nop
    /* 36A20 80046220 05004010 */  beqz       $v0, .L80046238
    /* 36A24 80046224 1180103C */   lui       $s0, %hi(frontEnd)
    /* 36A28 80046228 6C00248E */  lw         $a0, 0x6C($s1)
    /* 36A2C 8004622C A09F030C */  jal        SNDstop
    /* 36A30 80046230 00000000 */   nop
    /* 36A34 80046234 680020A6 */  sh         $zero, 0x68($s1)
  .L80046238:
    /* 36A38 80046238 00461026 */  addiu      $s0, $s0, %lo(frontEnd)
    /* 36A3C 8004623C 41030292 */  lbu        $v0, 0x341($s0)
    /* 36A40 80046240 00000000 */  nop
    /* 36A44 80046244 C0200200 */  sll        $a0, $v0, 3
    /* 36A48 80046248 21208200 */  addu       $a0, $a0, $v0
    /* 36A4C 8004624C 80200400 */  sll        $a0, $a0, 2
    /* 36A50 80046250 23208200 */  subu       $a0, $a0, $v0
    /* 36A54 80046254 ACEC010C */  jal        AudioMus_Volume__Fi
    /* 36A58 80046258 83210400 */   sra       $a0, $a0, 6
    /* 36A5C 8004625C 41030292 */  lbu        $v0, 0x341($s0)
    /* 36A60 80046260 00000000 */  nop
    /* 36A64 80046264 C0200200 */  sll        $a0, $v0, 3
    /* 36A68 80046268 21208200 */  addu       $a0, $a0, $v0
    /* 36A6C 8004626C 80200400 */  sll        $a0, $a0, 2
    /* 36A70 80046270 23208200 */  subu       $a0, $a0, $v0
    /* 36A74 80046274 83210400 */  sra        $a0, $a0, 6
    /* 36A78 80046278 21184000 */  addu       $v1, $v0, $zero
    /* 36A7C 8004627C 1480023C */  lui        $v0, %hi(gMasterMusicLevel)
    /* 36A80 80046280 50C643AC */  sw         $v1, %lo(gMasterMusicLevel)($v0)
    /* 36A84 80046284 42030392 */  lbu        $v1, 0x342($s0)
    /* 36A88 80046288 1480023C */  lui        $v0, %hi(gMasterSFXLevel)
    /* 36A8C 8004628C 54C643AC */  sw         $v1, %lo(gMasterSFXLevel)($v0)
    /* 36A90 80046290 43030392 */  lbu        $v1, 0x343($s0)
    /* 36A94 80046294 1480023C */  lui        $v0, %hi(gMasterFENarrationLevel)
    /* 36A98 80046298 5CC643AC */  sw         $v1, %lo(gMasterFENarrationLevel)($v0)
    /* 36A9C 8004629C 44030392 */  lbu        $v1, 0x344($s0)
    /* 36AA0 800462A0 1480023C */  lui        $v0, %hi(gMasterEngineLevel)
    /* 36AA4 800462A4 58C643AC */  sw         $v1, %lo(gMasterEngineLevel)($v0)
    /* 36AA8 800462A8 45030392 */  lbu        $v1, 0x345($s0)
    /* 36AAC 800462AC 1480023C */  lui        $v0, %hi(gMasterAmbientLevel)
    /* 36AB0 800462B0 ACEC010C */  jal        AudioMus_Volume__Fi
    /* 36AB4 800462B4 60C643AC */   sw        $v1, %lo(gMasterAmbientLevel)($v0)
    /* 36AB8 800462B8 6898000C */  jal        Cleanup__7tScreen
    /* 36ABC 800462BC 21202002 */   addu      $a0, $s1, $zero
    /* 36AC0 800462C0 0580023C */  lui        $v0, %hi(ginfo)
    /* 36AC4 800462C4 E8145024 */  addiu      $s0, $v0, %lo(ginfo)
  .L800462C8:
    /* 36AC8 800462C8 10000296 */  lhu        $v0, 0x10($s0)
    /* 36ACC 800462CC 00000000 */  nop
    /* 36AD0 800462D0 05004010 */  beqz       $v0, .L800462E8
    /* 36AD4 800462D4 00000000 */   nop
    /* 36AD8 800462D8 5256000C */  jal        FeAudio_systemtask__Fi
    /* 36ADC 800462DC 21200000 */   addu      $a0, $zero, $zero
    /* 36AE0 800462E0 B2180108 */  j          .L800462C8
    /* 36AE4 800462E4 00000000 */   nop
  .L800462E8:
    /* 36AE8 800462E8 1800BF8F */  lw         $ra, 0x18($sp)
    /* 36AEC 800462EC 1400B18F */  lw         $s1, 0x14($sp)
    /* 36AF0 800462F0 1000B08F */  lw         $s0, 0x10($sp)
    /* 36AF4 800462F4 0800E003 */  jr         $ra
    /* 36AF8 800462F8 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Cleanup__12tScreenAudio
