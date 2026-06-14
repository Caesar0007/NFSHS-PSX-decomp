.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AISpeeds_CalcTrafficTopSpeed__FP8Car_tObj, 0x1A0

glabel AISpeeds_CalcTrafficTopSpeed__FP8Car_tObj
    /* 5F36C 8006EB6C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 5F370 8006EB70 1400B1AF */  sw         $s1, 0x14($sp)
    /* 5F374 8006EB74 21888000 */  addu       $s1, $a0, $zero
    /* 5F378 8006EB78 1800BFAF */  sw         $ra, 0x18($sp)
    /* 5F37C 8006EB7C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 5F380 8006EB80 08002486 */  lh         $a0, 0x8($s1)
    /* 5F384 8006EB84 43BB010C */  jal        AISpeeds_GetLegalSpeed__Fi
    /* 5F388 8006EB88 00000000 */   nop
    /* 5F38C 8006EB8C 21204000 */  addu       $a0, $v0, $zero
    /* 5F390 8006EB90 CA90030C */  jal        fixedmult
    /* 5F394 8006EB94 00C00534 */   ori       $a1, $zero, 0xC000
    /* 5F398 8006EB98 21804000 */  addu       $s0, $v0, $zero
    /* 5F39C 8006EB9C 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* 5F3A0 8006EBA0 EC31438C */  lw         $v1, %lo(GameSetup_gData)($v0)
    /* 5F3A4 8006EBA4 01000224 */  addiu      $v0, $zero, 0x1
    /* 5F3A8 8006EBA8 03006210 */  beq        $v1, $v0, .L8006EBB8
    /* 5F3AC 8006EBAC 05000224 */   addiu     $v0, $zero, 0x5
    /* 5F3B0 8006EBB0 21006214 */  bne        $v1, $v0, .L8006EC38
    /* 5F3B4 8006EBB4 1180023C */   lui       $v0, %hi(D_8011321C)
  .L8006EBB8:
    /* 5F3B8 8006EBB8 1180033C */  lui        $v1, %hi(Cars_gHumanRaceCarList)
    /* 5F3BC 8006EBBC 48FA648C */  lw         $a0, %lo(Cars_gHumanRaceCarList)($v1)
    /* 5F3C0 8006EBC0 00000000 */  nop
    /* 5F3C4 8006EBC4 6002828C */  lw         $v0, 0x260($a0)
    /* 5F3C8 8006EBC8 00000000 */  nop
    /* 5F3CC 8006EBCC 00024230 */  andi       $v0, $v0, 0x200
    /* 5F3D0 8006EBD0 0D004014 */  bnez       $v0, .L8006EC08
    /* 5F3D4 8006EBD4 48FA6524 */   addiu     $a1, $v1, %lo(Cars_gHumanRaceCarList)
    /* 5F3D8 8006EBD8 1480033C */  lui        $v1, %hi(Cars_gNumHumanRaceCars)
    /* 5F3DC 8006EBDC 00C8638C */  lw         $v1, %lo(Cars_gNumHumanRaceCars)($v1)
    /* 5F3E0 8006EBE0 02000224 */  addiu      $v0, $zero, 0x2
    /* 5F3E4 8006EBE4 14006214 */  bne        $v1, $v0, .L8006EC38
    /* 5F3E8 8006EBE8 1180023C */   lui       $v0, %hi(D_8011321C)
    /* 5F3EC 8006EBEC 0400A28C */  lw         $v0, 0x4($a1)
    /* 5F3F0 8006EBF0 00000000 */  nop
    /* 5F3F4 8006EBF4 6002428C */  lw         $v0, 0x260($v0)
    /* 5F3F8 8006EBF8 00000000 */  nop
    /* 5F3FC 8006EBFC 00024230 */  andi       $v0, $v0, 0x200
    /* 5F400 8006EC00 0D004010 */  beqz       $v0, .L8006EC38
    /* 5F404 8006EC04 1180023C */   lui       $v0, %hi(D_8011321C)
  .L8006EC08:
    /* 5F408 8006EC08 5405238E */  lw         $v1, 0x554($s1)
    /* 5F40C 8006EC0C 5405828C */  lw         $v0, 0x554($a0)
    /* 5F410 8006EC10 00000000 */  nop
    /* 5F414 8006EC14 1A006210 */  beq        $v1, $v0, .L8006EC80
    /* 5F418 8006EC18 00000000 */   nop
    /* 5F41C 8006EC1C A0BB010C */  jal        AISpeeds_CalculateOncomingCarSpeed__FP8Car_tObj
    /* 5F420 8006EC20 21202002 */   addu      $a0, $s1, $zero
    /* 5F424 8006EC24 2A100202 */  slt        $v0, $s0, $v0
    /* 5F428 8006EC28 10004010 */  beqz       $v0, .L8006EC6C
    /* 5F42C 8006EC2C 21100002 */   addu      $v0, $s0, $zero
    /* 5F430 8006EC30 20BB0108 */  j          .L8006EC80
    /* 5F434 8006EC34 21804000 */   addu      $s0, $v0, $zero
  .L8006EC38:
    /* 5F438 8006EC38 1C32428C */  lw         $v0, %lo(D_8011321C)($v0)
    /* 5F43C 8006EC3C 5405238E */  lw         $v1, 0x554($s1)
    /* 5F440 8006EC40 02004014 */  bnez       $v0, .L8006EC4C
    /* 5F444 8006EC44 27100300 */   nor       $v0, $zero, $v1
    /* 5F448 8006EC48 01006238 */  xori       $v0, $v1, 0x1
  .L8006EC4C:
    /* 5F44C 8006EC4C 2B100200 */  sltu       $v0, $zero, $v0
    /* 5F450 8006EC50 0B004010 */  beqz       $v0, .L8006EC80
    /* 5F454 8006EC54 00000000 */   nop
    /* 5F458 8006EC58 A0BB010C */  jal        AISpeeds_CalculateOncomingCarSpeed__FP8Car_tObj
    /* 5F45C 8006EC5C 21202002 */   addu      $a0, $s1, $zero
    /* 5F460 8006EC60 2A100202 */  slt        $v0, $s0, $v0
    /* 5F464 8006EC64 05004014 */  bnez       $v0, .L8006EC7C
    /* 5F468 8006EC68 21100002 */   addu      $v0, $s0, $zero
  .L8006EC6C:
    /* 5F46C 8006EC6C A0BB010C */  jal        AISpeeds_CalculateOncomingCarSpeed__FP8Car_tObj
    /* 5F470 8006EC70 21202002 */   addu      $a0, $s1, $zero
    /* 5F474 8006EC74 20BB0108 */  j          .L8006EC80
    /* 5F478 8006EC78 21804000 */   addu      $s0, $v0, $zero
  .L8006EC7C:
    /* 5F47C 8006EC7C 21804000 */  addu       $s0, $v0, $zero
  .L8006EC80:
    /* 5F480 8006EC80 6002228E */  lw         $v0, 0x260($s1)
    /* 5F484 8006EC84 00000000 */  nop
    /* 5F488 8006EC88 10004230 */  andi       $v0, $v0, 0x10
    /* 5F48C 8006EC8C 0F004010 */  beqz       $v0, .L8006ECCC
    /* 5F490 8006EC90 21202002 */   addu      $a0, $s1, $zero
    /* 5F494 8006EC94 54BB010C */  jal        AISpeeds_RandomizeTrafficSpeed__FP8Car_tObji
    /* 5F498 8006EC98 21280002 */   addu      $a1, $s0, $zero
    /* 5F49C 8006EC9C 21804000 */  addu       $s0, $v0, $zero
    /* 5F4A0 8006ECA0 02000106 */  bgez       $s0, .L8006ECAC
    /* 5F4A4 8006ECA4 21180002 */   addu      $v1, $s0, $zero
    /* 5F4A8 8006ECA8 FF000326 */  addiu      $v1, $s0, 0xFF
  .L8006ECAC:
    /* 5F4AC 8006ECAC BC06228E */  lw         $v0, 0x6BC($s1)
    /* 5F4B0 8006ECB0 00000000 */  nop
    /* 5F4B4 8006ECB4 02004104 */  bgez       $v0, .L8006ECC0
    /* 5F4B8 8006ECB8 032A0300 */   sra       $a1, $v1, 8
    /* 5F4BC 8006ECBC FF004224 */  addiu      $v0, $v0, 0xFF
  .L8006ECC0:
    /* 5F4C0 8006ECC0 03120200 */  sra        $v0, $v0, 8
    /* 5F4C4 8006ECC4 1800A200 */  mult       $a1, $v0
    /* 5F4C8 8006ECC8 12800000 */  mflo       $s0
  .L8006ECCC:
    /* 5F4CC 8006ECCC 0800023C */  lui        $v0, (0x8E38E >> 16)
    /* 5F4D0 8006ECD0 8EE34234 */  ori        $v0, $v0, (0x8E38E & 0xFFFF)
    /* 5F4D4 8006ECD4 2A100202 */  slt        $v0, $s0, $v0
    /* 5F4D8 8006ECD8 03004010 */  beqz       $v0, .L8006ECE8
    /* 5F4DC 8006ECDC 00000000 */   nop
    /* 5F4E0 8006ECE0 0800103C */  lui        $s0, (0x8E38E >> 16)
    /* 5F4E4 8006ECE4 8EE31036 */  ori        $s0, $s0, (0x8E38E & 0xFFFF)
  .L8006ECE8:
    /* 5F4E8 8006ECE8 5405228E */  lw         $v0, 0x554($s1)
    /* 5F4EC 8006ECEC 00000000 */  nop
    /* 5F4F0 8006ECF0 18000202 */  mult       $s0, $v0
    /* 5F4F4 8006ECF4 1800BF8F */  lw         $ra, 0x18($sp)
    /* 5F4F8 8006ECF8 1400B18F */  lw         $s1, 0x14($sp)
    /* 5F4FC 8006ECFC 1000B08F */  lw         $s0, 0x10($sp)
    /* 5F500 8006ED00 12100000 */  mflo       $v0
    /* 5F504 8006ED04 0800E003 */  jr         $ra
    /* 5F508 8006ED08 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel AISpeeds_CalcTrafficTopSpeed__FP8Car_tObj
