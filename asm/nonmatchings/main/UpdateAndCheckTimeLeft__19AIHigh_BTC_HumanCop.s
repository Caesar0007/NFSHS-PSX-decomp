.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching UpdateAndCheckTimeLeft__19AIHigh_BTC_HumanCop, 0x114

glabel UpdateAndCheckTimeLeft__19AIHigh_BTC_HumanCop
    /* 4E1C0 8005D9C0 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 4E1C4 8005D9C4 1000B0AF */  sw         $s0, 0x10($sp)
    /* 4E1C8 8005D9C8 21808000 */  addu       $s0, $a0, $zero
    /* 4E1CC 8005D9CC 1400BFAF */  sw         $ra, 0x14($sp)
    /* 4E1D0 8005D9D0 6000038E */  lw         $v1, 0x60($s0)
    /* 4E1D4 8005D9D4 03000224 */  addiu      $v0, $zero, 0x3
    /* 4E1D8 8005D9D8 09006210 */  beq        $v1, $v0, .L8005DA00
    /* 4E1DC 8005D9DC 01000224 */   addiu     $v0, $zero, 0x1
    /* 4E1E0 8005D9E0 07006210 */  beq        $v1, $v0, .L8005DA00
    /* 4E1E4 8005D9E4 00000000 */   nop
    /* 4E1E8 8005D9E8 7000028E */  lw         $v0, 0x70($s0)
    /* 4E1EC 8005D9EC 1480033C */  lui        $v1, %hi(AI_elapsedTime)
    /* 4E1F0 8005D9F0 54C5638C */  lw         $v1, %lo(AI_elapsedTime)($v1)
    /* 4E1F4 8005D9F4 00000000 */  nop
    /* 4E1F8 8005D9F8 23104300 */  subu       $v0, $v0, $v1
    /* 4E1FC 8005D9FC 700002AE */  sw         $v0, 0x70($s0)
  .L8005DA00:
    /* 4E200 8005DA00 5800028E */  lw         $v0, 0x58($s0)
    /* 4E204 8005DA04 00000000 */  nop
    /* 4E208 8005DA08 08004010 */  beqz       $v0, .L8005DA2C
    /* 4E20C 8005DA0C 00000000 */   nop
    /* 4E210 8005DA10 7000058E */  lw         $a1, 0x70($s0)
    /* 4E214 8005DA14 0000428C */  lw         $v0, 0x0($v0)
    /* 4E218 8005DA18 0000038E */  lw         $v1, 0x0($s0)
    /* 4E21C 8005DA1C 8802448C */  lw         $a0, 0x288($v0)
    /* 4E220 8005DA20 6004668C */  lw         $a2, 0x460($v1)
    /* 4E224 8005DA24 8F760108 */  j          .L8005DA3C
    /* 4E228 8005DA28 5C008424 */   addiu     $a0, $a0, 0x5C
  .L8005DA2C:
    /* 4E22C 8005DA2C 0000028E */  lw         $v0, 0x0($s0)
    /* 4E230 8005DA30 21200000 */  addu       $a0, $zero, $zero
    /* 4E234 8005DA34 6004468C */  lw         $a2, 0x460($v0)
    /* 4E238 8005DA38 21288000 */  addu       $a1, $a0, $zero
  .L8005DA3C:
    /* 4E23C 8005DA3C 7265030C */  jal        Hud_BTC_Update__FPcib
    /* 4E240 8005DA40 0100C62C */   sltiu     $a2, $a2, 0x1
    /* 4E244 8005DA44 7000028E */  lw         $v0, 0x70($s0)
    /* 4E248 8005DA48 00000000 */  nop
    /* 4E24C 8005DA4C 1D004104 */  bgez       $v0, .L8005DAC4
    /* 4E250 8005DA50 00000000 */   nop
    /* 4E254 8005DA54 1800828F */  lw         $v0, %gp_rel(D_8013C564)($gp)
    /* 4E258 8005DA58 00000000 */  nop
    /* 4E25C 8005DA5C 0C004010 */  beqz       $v0, .L8005DA90
    /* 4E260 8005DA60 00000000 */   nop
    /* 4E264 8005DA64 0000048E */  lw         $a0, 0x0($s0)
    /* 4E268 8005DA68 175E020C */  jal        Mobile__6SpeechP8Car_tObj
    /* 4E26C 8005DA6C 00000000 */   nop
    /* 4E270 8005DA70 4C00438C */  lw         $v1, 0x4C($v0)
    /* 4E274 8005DA74 00000000 */  nop
    /* 4E278 8005DA78 38006484 */  lh         $a0, 0x38($v1)
    /* 4E27C 8005DA7C 3C00638C */  lw         $v1, 0x3C($v1)
    /* 4E280 8005DA80 00000000 */  nop
    /* 4E284 8005DA84 09F86000 */  jalr       $v1
    /* 4E288 8005DA88 21204400 */   addu      $a0, $v0, $a0
    /* 4E28C 8005DA8C 180080AF */  sw         $zero, %gp_rel(D_8013C564)($gp)
  .L8005DA90:
    /* 4E290 8005DA90 7000028E */  lw         $v0, 0x70($s0)
    /* 4E294 8005DA94 00000000 */  nop
    /* 4E298 8005DA98 60FF4228 */  slti       $v0, $v0, -0xA0
    /* 4E29C 8005DA9C 09004010 */  beqz       $v0, .L8005DAC4
    /* 4E2A0 8005DAA0 21200002 */   addu      $a0, $s0, $zero
    /* 4E2A4 8005DAA4 01000324 */  addiu      $v1, $zero, 0x1
    /* 4E2A8 8005DAA8 1280023C */  lui        $v0, %hi(D_8011E0C8)
    /* 4E2AC 8005DAAC C8E043AC */  sw         $v1, %lo(D_8011E0C8)($v0)
    /* 4E2B0 8005DAB0 5800858C */  lw         $a1, 0x58($a0)
    /* 4E2B4 8005DAB4 0000878C */  lw         $a3, 0x0($a0)
    /* 4E2B8 8005DAB8 180083AF */  sw         $v1, %gp_rel(D_8013C564)($gp)
    /* 4E2BC 8005DABC A178010C */  jal        HudOn__19AIHigh_BTC_HumanCopP15AIHigh_BTC_PerpiP8Car_tObj
    /* 4E2C0 8005DAC0 21306000 */   addu      $a2, $v1, $zero
  .L8005DAC4:
    /* 4E2C4 8005DAC4 1400BF8F */  lw         $ra, 0x14($sp)
    /* 4E2C8 8005DAC8 1000B08F */  lw         $s0, 0x10($sp)
    /* 4E2CC 8005DACC 0800E003 */  jr         $ra
    /* 4E2D0 8005DAD0 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel UpdateAndCheckTimeLeft__19AIHigh_BTC_HumanCop
