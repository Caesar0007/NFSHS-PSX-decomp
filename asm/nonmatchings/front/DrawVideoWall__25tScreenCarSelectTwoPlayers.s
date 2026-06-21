.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawVideoWall__25tScreenCarSelectTwoPlayers, 0x1A0

glabel DrawVideoWall__25tScreenCarSelectTwoPlayers
    /* 2E990 8003E190 F8FEBD27 */  addiu      $sp, $sp, -0x108
    /* 2E994 8003E194 F800B2AF */  sw         $s2, 0xF8($sp)
    /* 2E998 8003E198 21908000 */  addu       $s2, $a0, $zero
    /* 2E99C 8003E19C F000B0AF */  sw         $s0, 0xF0($sp)
    /* 2E9A0 8003E1A0 2180A000 */  addu       $s0, $a1, $zero
    /* 2E9A4 8003E1A4 2000A527 */  addiu      $a1, $sp, 0x20
    /* 2E9A8 8003E1A8 0001BFAF */  sw         $ra, 0x100($sp)
    /* 2E9AC 8003E1AC FC00B3AF */  sw         $s3, 0xFC($sp)
    /* 2E9B0 8003E1B0 F400B1AF */  sw         $s1, 0xF4($sp)
    /* 2E9B4 8003E1B4 6000428E */  lw         $v0, 0x60($s2)
    /* 2E9B8 8003E1B8 21880000 */  addu       $s1, $zero, $zero
    /* 2E9BC 8003E1BC 68004484 */  lh         $a0, 0x68($v0)
    /* 2E9C0 8003E1C0 6C00428C */  lw         $v0, 0x6C($v0)
    /* 2E9C4 8003E1C4 00000000 */  nop
    /* 2E9C8 8003E1C8 09F84000 */  jalr       $v0
    /* 2E9CC 8003E1CC 21204402 */   addu      $a0, $s2, $a0
    /* 2E9D0 8003E1D0 21984000 */  addu       $s3, $v0, $zero
    /* 2E9D4 8003E1D4 00841000 */  sll        $s0, $s0, 16
    /* 2E9D8 8003E1D8 03841000 */  sra        $s0, $s0, 16
    /* 2E9DC 8003E1DC 00241100 */  sll        $a0, $s1, 16
  .L8003E1E0:
    /* 2E9E0 8003E1E0 03240400 */  sra        $a0, $a0, 16
    /* 2E9E4 8003E1E4 21280000 */  addu       $a1, $zero, $zero
    /* 2E9E8 8003E1E8 2130A000 */  addu       $a2, $a1, $zero
    /* 2E9EC 8003E1EC 5C004286 */  lh         $v0, 0x5C($s2)
    /* 2E9F0 8003E1F0 23381000 */  negu       $a3, $s0
    /* 2E9F4 8003E1F4 1400A0AF */  sw         $zero, 0x14($sp)
    /* 2E9F8 8003E1F8 1800A0AF */  sw         $zero, 0x18($sp)
    /* 2E9FC 8003E1FC 9E39010C */  jal        DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* 2EA00 8003E200 1000A2AF */   sw        $v0, 0x10($sp)
    /* 2EA04 8003E204 01002226 */  addiu      $v0, $s1, 0x1
    /* 2EA08 8003E208 21884000 */  addu       $s1, $v0, $zero
    /* 2EA0C 8003E20C 00140200 */  sll        $v0, $v0, 16
    /* 2EA10 8003E210 03140200 */  sra        $v0, $v0, 16
    /* 2EA14 8003E214 0C004228 */  slti       $v0, $v0, 0xC
    /* 2EA18 8003E218 F1FF4014 */  bnez       $v0, .L8003E1E0
    /* 2EA1C 8003E21C 00241100 */   sll       $a0, $s1, 16
    /* 2EA20 8003E220 3A004296 */  lhu        $v0, 0x3A($s2)
    /* 2EA24 8003E224 00000000 */  nop
    /* 2EA28 8003E228 01004230 */  andi       $v0, $v0, 0x1
    /* 2EA2C 8003E22C 1F004010 */  beqz       $v0, .L8003E2AC
    /* 2EA30 8003E230 00000000 */   nop
    /* 2EA34 8003E234 8403428E */  lw         $v0, 0x384($s2)
    /* 2EA38 8003E238 00000000 */  nop
    /* 2EA3C 8003E23C 1B004014 */  bnez       $v0, .L8003E2AC
    /* 2EA40 8003E240 0580113C */   lui       $s1, %hi(FEApp)
    /* 2EA44 8003E244 C014228E */  lw         $v0, %lo(FEApp)($s1)
    /* 2EA48 8003E248 00000000 */  nop
    /* 2EA4C 8003E24C 2C024290 */  lbu        $v0, 0x22C($v0)
    /* 2EA50 8003E250 00000000 */  nop
    /* 2EA54 8003E254 02004010 */  beqz       $v0, .L8003E260
    /* 2EA58 8003E258 21300000 */   addu      $a2, $zero, $zero
    /* 2EA5C 8003E25C 69000624 */  addiu      $a2, $zero, 0x69
  .L8003E260:
    /* 2EA60 8003E260 04035026 */  addiu      $s0, $s2, 0x304
    /* 2EA64 8003E264 21200002 */  addu       $a0, $s0, $zero
    /* 2EA68 8003E268 72DA000C */  jal        SetOffset__10tVideoWallss
    /* 2EA6C 8003E26C 06000524 */   addiu     $a1, $zero, 0x6
    /* 2EA70 8003E270 C014228E */  lw         $v0, %lo(FEApp)($s1)
    /* 2EA74 8003E274 00000000 */  nop
    /* 2EA78 8003E278 2C024290 */  lbu        $v0, 0x22C($v0)
    /* 2EA7C 8003E27C 00000000 */  nop
    /* 2EA80 8003E280 02004010 */  beqz       $v0, .L8003E28C
    /* 2EA84 8003E284 2D000724 */   addiu     $a3, $zero, 0x2D
    /* 2EA88 8003E288 96000724 */  addiu      $a3, $zero, 0x96
  .L8003E28C:
    /* 2EA8C 8003E28C 21200002 */  addu       $a0, $s0, $zero
    /* 2EA90 8003E290 F8000524 */  addiu      $a1, $zero, 0xF8
    /* 2EA94 8003E294 63DA000C */  jal        SetAvailableText__10tVideoWallsss
    /* 2EA98 8003E298 0E010624 */   addiu     $a2, $zero, 0x10E
    /* 2EA9C 8003E29C 10DA000C */  jal        UpdateImages__10tVideoWall
    /* 2EAA0 8003E2A0 21200002 */   addu      $a0, $s0, $zero
    /* 2EAA4 8003E2A4 01000224 */  addiu      $v0, $zero, 0x1
    /* 2EAA8 8003E2A8 840342AE */  sw         $v0, 0x384($s2)
  .L8003E2AC:
    /* 2EAAC 8003E2AC 5C004286 */  lh         $v0, 0x5C($s2)
    /* 2EAB0 8003E2B0 00000000 */  nop
    /* 2EAB4 8003E2B4 0C004018 */  blez       $v0, .L8003E2E8
    /* 2EAB8 8003E2B8 04035026 */   addiu     $s0, $s2, 0x304
    /* 2EABC 8003E2BC 5400428E */  lw         $v0, 0x54($s2)
    /* 2EAC0 8003E2C0 00000000 */  nop
    /* 2EAC4 8003E2C4 08004010 */  beqz       $v0, .L8003E2E8
    /* 2EAC8 8003E2C8 00000000 */   nop
    /* 2EACC 8003E2CC 9FDB000C */  jal        TurnOffInstant__10tVideoWall
    /* 2EAD0 8003E2D0 04034426 */   addiu     $a0, $s2, 0x304
    /* 2EAD4 8003E2D4 21204002 */  addu       $a0, $s2, $zero
    /* 2EAD8 8003E2D8 21280000 */  addu       $a1, $zero, $zero
    /* 2EADC 8003E2DC 29F1000C */  jal        SetBrightness__16tScreenCarSelectss
    /* 2EAE0 8003E2E0 2130A000 */   addu      $a2, $a1, $zero
    /* 2EAE4 8003E2E4 04035026 */  addiu      $s0, $s2, 0x304
  .L8003E2E8:
    /* 2EAE8 8003E2E8 79DA000C */  jal        UpdateTransition__10tVideoWall
    /* 2EAEC 8003E2EC 21200002 */   addu      $a0, $s0, $zero
    /* 2EAF0 8003E2F0 21200002 */  addu       $a0, $s0, $zero
    /* 2EAF4 8003E2F4 002C1300 */  sll        $a1, $s3, 16
    /* 2EAF8 8003E2F8 77DA000C */  jal        SetValid__10tVideoWalls
    /* 2EAFC 8003E2FC 032C0500 */   sra       $a1, $a1, 16
    /* 2EB00 8003E300 2700A593 */  lbu        $a1, 0x27($sp)
    /* 2EB04 8003E304 75DA000C */  jal        SetAvailable__10tVideoWalls
    /* 2EB08 8003E308 21200002 */   addu      $a0, $s0, $zero
    /* 2EB0C 8003E30C EDDA000C */  jal        Draw__10tVideoWall
    /* 2EB10 8003E310 21200002 */   addu      $a0, $s0, $zero
    /* 2EB14 8003E314 0001BF8F */  lw         $ra, 0x100($sp)
    /* 2EB18 8003E318 FC00B38F */  lw         $s3, 0xFC($sp)
    /* 2EB1C 8003E31C F800B28F */  lw         $s2, 0xF8($sp)
    /* 2EB20 8003E320 F400B18F */  lw         $s1, 0xF4($sp)
    /* 2EB24 8003E324 F000B08F */  lw         $s0, 0xF0($sp)
    /* 2EB28 8003E328 0800E003 */  jr         $ra
    /* 2EB2C 8003E32C 0801BD27 */   addiu     $sp, $sp, 0x108
endlabel DrawVideoWall__25tScreenCarSelectTwoPlayers
