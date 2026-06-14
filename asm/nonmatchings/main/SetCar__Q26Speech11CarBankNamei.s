.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SetCar__Q26Speech11CarBankNamei, 0xC8

glabel SetCar__Q26Speech11CarBankNamei
    /* 84B54 80094354 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 84B58 80094358 1800B2AF */  sw         $s2, 0x18($sp)
    /* 84B5C 8009435C 21908000 */  addu       $s2, $a0, $zero
    /* 84B60 80094360 1180043C */  lui        $a0, %hi(GameSetup_gData)
    /* 84B64 80094364 EC318424 */  addiu      $a0, $a0, %lo(GameSetup_gData)
    /* 84B68 80094368 40180500 */  sll        $v1, $a1, 1
    /* 84B6C 8009436C 21186500 */  addu       $v1, $v1, $a1
    /* 84B70 80094370 00110300 */  sll        $v0, $v1, 4
    /* 84B74 80094374 23104300 */  subu       $v0, $v0, $v1
    /* 84B78 80094378 80100200 */  sll        $v0, $v0, 2
    /* 84B7C 8009437C 21104400 */  addu       $v0, $v0, $a0
    /* 84B80 80094380 1180043C */  lui        $a0, %hi(Speech_gCarDescription)
    /* 84B84 80094384 1000B0AF */  sw         $s0, 0x10($sp)
    /* 84B88 80094388 441A9024 */  addiu      $s0, $a0, %lo(Speech_gCarDescription)
    /* 84B8C 8009438C 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 84B90 80094390 1400B1AF */  sw         $s1, 0x14($sp)
    /* 84B94 80094394 D403428C */  lw         $v0, 0x3D4($v0)
    /* 84B98 80094398 441A848C */  lw         $a0, %lo(Speech_gCarDescription)($a0)
    /* 84B9C 8009439C 80180200 */  sll        $v1, $v0, 2
    /* 84BA0 800943A0 21186200 */  addu       $v1, $v1, $v0
    /* 84BA4 800943A4 1180023C */  lui        $v0, %hi(GameSetup_gCarNames)
    /* 84BA8 800943A8 44304224 */  addiu      $v0, $v0, %lo(GameSetup_gCarNames)
    /* 84BAC 800943AC 0C008010 */  beqz       $a0, .L800943E0
    /* 84BB0 800943B0 21886200 */   addu      $s1, $v1, $v0
    /* 84BB4 800943B4 21202002 */  addu       $a0, $s1, $zero
  .L800943B8:
    /* 84BB8 800943B8 0000058E */  lw         $a1, 0x0($s0)
    /* 84BBC 800943BC 74AC030C */  jal        strncmp
    /* 84BC0 800943C0 04000624 */   addiu     $a2, $zero, 0x4
    /* 84BC4 800943C4 06004010 */  beqz       $v0, .L800943E0
    /* 84BC8 800943C8 00000000 */   nop
    /* 84BCC 800943CC 10001026 */  addiu      $s0, $s0, 0x10
    /* 84BD0 800943D0 0000028E */  lw         $v0, 0x0($s0)
    /* 84BD4 800943D4 00000000 */  nop
    /* 84BD8 800943D8 F7FF4014 */  bnez       $v0, .L800943B8
    /* 84BDC 800943DC 21202002 */   addu      $a0, $s1, $zero
  .L800943E0:
    /* 84BE0 800943E0 0400028E */  lw         $v0, 0x4($s0)
    /* 84BE4 800943E4 00000000 */  nop
    /* 84BE8 800943E8 000042AE */  sw         $v0, 0x0($s2)
    /* 84BEC 800943EC 0800028E */  lw         $v0, 0x8($s0)
    /* 84BF0 800943F0 00000000 */  nop
    /* 84BF4 800943F4 040042AE */  sw         $v0, 0x4($s2)
    /* 84BF8 800943F8 0C00028E */  lw         $v0, 0xC($s0)
    /* 84BFC 800943FC 00000000 */  nop
    /* 84C00 80094400 080042AE */  sw         $v0, 0x8($s2)
    /* 84C04 80094404 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 84C08 80094408 1800B28F */  lw         $s2, 0x18($sp)
    /* 84C0C 8009440C 1400B18F */  lw         $s1, 0x14($sp)
    /* 84C10 80094410 1000B08F */  lw         $s0, 0x10($sp)
    /* 84C14 80094414 0800E003 */  jr         $ra
    /* 84C18 80094418 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel SetCar__Q26Speech11CarBankNamei
