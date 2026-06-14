.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Report__Q26Speech13MobileSpeakerP8Car_tObj, 0xEC

glabel Report__Q26Speech13MobileSpeakerP8Car_tObj
    /* 883FC 80097BFC 3808838F */  lw         $v1, %gp_rel(_6Speech_fgSpeech)($gp)
    /* 88400 80097C00 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 88404 80097C04 2000B0AF */  sw         $s0, 0x20($sp)
    /* 88408 80097C08 21808000 */  addu       $s0, $a0, $zero
    /* 8840C 80097C0C 2C00BFAF */  sw         $ra, 0x2C($sp)
    /* 88410 80097C10 2800B2AF */  sw         $s2, 0x28($sp)
    /* 88414 80097C14 2400B1AF */  sw         $s1, 0x24($sp)
    /* 88418 80097C18 6000028E */  lw         $v0, 0x60($s0)
    /* 8841C 80097C1C 00000000 */  nop
    /* 88420 80097C20 8C0362AC */  sw         $v0, 0x38C($v1)
    /* 88424 80097C24 4C00028E */  lw         $v0, 0x4C($s0)
    /* 88428 80097C28 2188A000 */  addu       $s1, $a1, $zero
    /* 8842C 80097C2C F0004484 */  lh         $a0, 0xF0($v0)
    /* 88430 80097C30 F400428C */  lw         $v0, 0xF4($v0)
    /* 88434 80097C34 00000000 */  nop
    /* 88438 80097C38 09F84000 */  jalr       $v0
    /* 8843C 80097C3C 21200402 */   addu      $a0, $s0, $a0
    /* 88440 80097C40 50001226 */  addiu      $s2, $s0, 0x50
    /* 88444 80097C44 21204002 */  addu       $a0, $s2, $zero
    /* 88448 80097C48 0400458C */  lw         $a1, 0x4($v0)
    /* 8844C 80097C4C 3800068E */  lw         $a2, 0x38($s0)
    /* 88450 80097C50 18000726 */  addiu      $a3, $s0, 0x18
    /* 88454 80097C54 D94F020C */  jal        SPCHNFS_C_A_INTRO
    /* 88458 80097C58 3C0005AE */   sw        $a1, 0x3C($s0)
    /* 8845C 80097C5C 919D030C */  jal        SPCH_PlaySpeech
    /* 88460 80097C60 00000000 */   nop
    /* 88464 80097C64 21200002 */  addu       $a0, $s0, $zero
    /* 88468 80097C68 3808838F */  lw         $v1, %gp_rel(_6Speech_fgSpeech)($gp)
    /* 8846C 80097C6C 6000028E */  lw         $v0, 0x60($s0)
    /* 88470 80097C70 21282002 */  addu       $a1, $s1, $zero
    /* 88474 80097C74 7651020C */  jal        SetCar__Q26Speech7SpeakerP8Car_tObj
    /* 88478 80097C78 8C0362AC */   sw        $v0, 0x38C($v1)
    /* 8847C 80097C7C 21200002 */  addu       $a0, $s0, $zero
    /* 88480 80097C80 7652020C */  jal        FindLocation__Q26Speech7SpeakerP8Car_tObj
    /* 88484 80097C84 21282002 */   addu      $a1, $s1, $zero
    /* 88488 80097C88 21200002 */  addu       $a0, $s0, $zero
    /* 8848C 80097C8C 3B5E020C */  jal        SetSpeed__Q26Speech13MobileSpeakerP8Car_tObj
    /* 88490 80097C90 21282002 */   addu      $a1, $s1, $zero
    /* 88494 80097C94 21204002 */  addu       $a0, $s2, $zero
    /* 88498 80097C98 08000526 */  addiu      $a1, $s0, 0x8
    /* 8849C 80097C9C 04000726 */  addiu      $a3, $s0, 0x4
    /* 884A0 80097CA0 3000068E */  lw         $a2, 0x30($s0)
    /* 884A4 80097CA4 3400038E */  lw         $v1, 0x34($s0)
    /* 884A8 80097CA8 20000226 */  addiu      $v0, $s0, 0x20
    /* 884AC 80097CAC 1000B0AF */  sw         $s0, 0x10($sp)
    /* 884B0 80097CB0 1800A2AF */  sw         $v0, 0x18($sp)
    /* 884B4 80097CB4 E54D020C */  jal        SPCHNFS_C_D_PERP_SIGHTED
    /* 884B8 80097CB8 1400A3AF */   sw        $v1, 0x14($sp)
    /* 884BC 80097CBC 919D030C */  jal        SPCH_PlaySpeech
    /* 884C0 80097CC0 00000000 */   nop
    /* 884C4 80097CC4 BC57020C */  jal        Dispatch__6Speech
    /* 884C8 80097CC8 00000000 */   nop
    /* 884CC 80097CCC 480050AC */  sw         $s0, 0x48($v0)
    /* 884D0 80097CD0 2C00BF8F */  lw         $ra, 0x2C($sp)
    /* 884D4 80097CD4 2800B28F */  lw         $s2, 0x28($sp)
    /* 884D8 80097CD8 2400B18F */  lw         $s1, 0x24($sp)
    /* 884DC 80097CDC 2000B08F */  lw         $s0, 0x20($sp)
    /* 884E0 80097CE0 0800E003 */  jr         $ra
    /* 884E4 80097CE4 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel Report__Q26Speech13MobileSpeakerP8Car_tObj
