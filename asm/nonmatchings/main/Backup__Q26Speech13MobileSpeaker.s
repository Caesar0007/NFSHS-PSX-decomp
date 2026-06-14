.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Backup__Q26Speech13MobileSpeaker, 0xF8

glabel Backup__Q26Speech13MobileSpeaker
    /* 89474 80098C74 3808838F */  lw         $v1, %gp_rel(_6Speech_fgSpeech)($gp)
    /* 89478 80098C78 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 8947C 80098C7C 1800B0AF */  sw         $s0, 0x18($sp)
    /* 89480 80098C80 21808000 */  addu       $s0, $a0, $zero
    /* 89484 80098C84 2000BFAF */  sw         $ra, 0x20($sp)
    /* 89488 80098C88 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* 8948C 80098C8C 6000028E */  lw         $v0, 0x60($s0)
    /* 89490 80098C90 00000000 */  nop
    /* 89494 80098C94 8C0362AC */  sw         $v0, 0x38C($v1)
    /* 89498 80098C98 4C00028E */  lw         $v0, 0x4C($s0)
    /* 8949C 80098C9C 00000000 */  nop
    /* 894A0 80098CA0 F0004484 */  lh         $a0, 0xF0($v0)
    /* 894A4 80098CA4 F400428C */  lw         $v0, 0xF4($v0)
    /* 894A8 80098CA8 00000000 */  nop
    /* 894AC 80098CAC 09F84000 */  jalr       $v0
    /* 894B0 80098CB0 21200402 */   addu      $a0, $s0, $a0
    /* 894B4 80098CB4 50001126 */  addiu      $s1, $s0, 0x50
    /* 894B8 80098CB8 21202002 */  addu       $a0, $s1, $zero
    /* 894BC 80098CBC 0400458C */  lw         $a1, 0x4($v0)
    /* 894C0 80098CC0 3800068E */  lw         $a2, 0x38($s0)
    /* 894C4 80098CC4 18000726 */  addiu      $a3, $s0, 0x18
    /* 894C8 80098CC8 D94F020C */  jal        SPCHNFS_C_A_INTRO
    /* 894CC 80098CCC 3C0005AE */   sw        $a1, 0x3C($s0)
    /* 894D0 80098CD0 919D030C */  jal        SPCH_PlaySpeech
    /* 894D4 80098CD4 00000000 */   nop
    /* 894D8 80098CD8 4C00028E */  lw         $v0, 0x4C($s0)
    /* 894DC 80098CDC 00000000 */  nop
    /* 894E0 80098CE0 D8004484 */  lh         $a0, 0xD8($v0)
    /* 894E4 80098CE4 DC00428C */  lw         $v0, 0xDC($v0)
    /* 894E8 80098CE8 00000000 */  nop
    /* 894EC 80098CEC 09F84000 */  jalr       $v0
    /* 894F0 80098CF0 21200402 */   addu      $a0, $s0, $a0
    /* 894F4 80098CF4 21200002 */  addu       $a0, $s0, $zero
    /* 894F8 80098CF8 7651020C */  jal        SetCar__Q26Speech7SpeakerP8Car_tObj
    /* 894FC 80098CFC 21284000 */   addu      $a1, $v0, $zero
    /* 89500 80098D00 4C00028E */  lw         $v0, 0x4C($s0)
    /* 89504 80098D04 00000000 */  nop
    /* 89508 80098D08 C8004484 */  lh         $a0, 0xC8($v0)
    /* 8950C 80098D0C CC00428C */  lw         $v0, 0xCC($v0)
    /* 89510 80098D10 00000000 */  nop
    /* 89514 80098D14 09F84000 */  jalr       $v0
    /* 89518 80098D18 21200402 */   addu      $a0, $s0, $a0
    /* 8951C 80098D1C 21200002 */  addu       $a0, $s0, $zero
    /* 89520 80098D20 7652020C */  jal        FindLocation__Q26Speech7SpeakerP8Car_tObj
    /* 89524 80098D24 21284000 */   addu      $a1, $v0, $zero
    /* 89528 80098D28 21202002 */  addu       $a0, $s1, $zero
    /* 8952C 80098D2C 08000526 */  addiu      $a1, $s0, 0x8
    /* 89530 80098D30 21380002 */  addu       $a3, $s0, $zero
    /* 89534 80098D34 3000068E */  lw         $a2, 0x30($s0)
    /* 89538 80098D38 3400038E */  lw         $v1, 0x34($s0)
    /* 8953C 80098D3C 04000226 */  addiu      $v0, $s0, 0x4
    /* 89540 80098D40 1400A2AF */  sw         $v0, 0x14($sp)
    /* 89544 80098D44 8E4D020C */  jal        SPCHNFS_C_D_REQUEST_BKUP
    /* 89548 80098D48 1000A3AF */   sw        $v1, 0x10($sp)
    /* 8954C 80098D4C 919D030C */  jal        SPCH_PlaySpeech
    /* 89550 80098D50 00000000 */   nop
    /* 89554 80098D54 140000AE */  sw         $zero, 0x14($s0)
    /* 89558 80098D58 2000BF8F */  lw         $ra, 0x20($sp)
    /* 8955C 80098D5C 1C00B18F */  lw         $s1, 0x1C($sp)
    /* 89560 80098D60 1800B08F */  lw         $s0, 0x18($sp)
    /* 89564 80098D64 0800E003 */  jr         $ra
    /* 89568 80098D68 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel Backup__Q26Speech13MobileSpeaker
