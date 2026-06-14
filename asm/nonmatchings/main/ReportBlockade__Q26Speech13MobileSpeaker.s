.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ReportBlockade__Q26Speech13MobileSpeaker, 0xFC

glabel ReportBlockade__Q26Speech13MobileSpeaker
    /* 8996C 8009916C 3808838F */  lw         $v1, %gp_rel(_6Speech_fgSpeech)($gp)
    /* 89970 80099170 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 89974 80099174 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* 89978 80099178 21888000 */  addu       $s1, $a0, $zero
    /* 8997C 8009917C 2000BFAF */  sw         $ra, 0x20($sp)
    /* 89980 80099180 1800B0AF */  sw         $s0, 0x18($sp)
    /* 89984 80099184 6000228E */  lw         $v0, 0x60($s1)
    /* 89988 80099188 00000000 */  nop
    /* 8998C 8009918C 8C0362AC */  sw         $v0, 0x38C($v1)
    /* 89990 80099190 4C00228E */  lw         $v0, 0x4C($s1)
    /* 89994 80099194 00000000 */  nop
    /* 89998 80099198 F0004484 */  lh         $a0, 0xF0($v0)
    /* 8999C 8009919C F400428C */  lw         $v0, 0xF4($v0)
    /* 899A0 800991A0 00000000 */  nop
    /* 899A4 800991A4 09F84000 */  jalr       $v0
    /* 899A8 800991A8 21202402 */   addu      $a0, $s1, $a0
    /* 899AC 800991AC 0400428C */  lw         $v0, 0x4($v0)
    /* 899B0 800991B0 4C00238E */  lw         $v1, 0x4C($s1)
    /* 899B4 800991B4 3C0022AE */  sw         $v0, 0x3C($s1)
    /* 899B8 800991B8 C8006484 */  lh         $a0, 0xC8($v1)
    /* 899BC 800991BC CC00628C */  lw         $v0, 0xCC($v1)
    /* 899C0 800991C0 00000000 */  nop
    /* 899C4 800991C4 09F84000 */  jalr       $v0
    /* 899C8 800991C8 21202402 */   addu      $a0, $s1, $a0
    /* 899CC 800991CC 21202002 */  addu       $a0, $s1, $zero
    /* 899D0 800991D0 7652020C */  jal        FindLocation__Q26Speech7SpeakerP8Car_tObj
    /* 899D4 800991D4 21284000 */   addu      $a1, $v0, $zero
    /* 899D8 800991D8 1400238E */  lw         $v1, 0x14($s1)
    /* 899DC 800991DC 04000224 */  addiu      $v0, $zero, 0x4
    /* 899E0 800991E0 240022AE */  sw         $v0, 0x24($s1)
    /* 899E4 800991E4 02000224 */  addiu      $v0, $zero, 0x2
    /* 899E8 800991E8 10006214 */  bne        $v1, $v0, .L8009922C
    /* 899EC 800991EC 50002426 */   addiu     $a0, $s1, 0x50
    /* 899F0 800991F0 50003026 */  addiu      $s0, $s1, 0x50
    /* 899F4 800991F4 21200002 */  addu       $a0, $s0, $zero
    /* 899F8 800991F8 3C00258E */  lw         $a1, 0x3C($s1)
    /* 899FC 800991FC 3800268E */  lw         $a2, 0x38($s1)
    /* 89A00 80099200 D94F020C */  jal        SPCHNFS_C_A_INTRO
    /* 89A04 80099204 18002726 */   addiu     $a3, $s1, 0x18
    /* 89A08 80099208 919D030C */  jal        SPCH_PlaySpeech
    /* 89A0C 8009920C 00000000 */   nop
    /* 89A10 80099210 21200002 */  addu       $a0, $s0, $zero
    /* 89A14 80099214 21282002 */  addu       $a1, $s1, $zero
    /* 89A18 80099218 3400A68C */  lw         $a2, 0x34($a1)
    /* 89A1C 8009921C 4350020C */  jal        SPCHNFS_W_D_RDBLK_PLC
    /* 89A20 80099220 0400A724 */   addiu     $a3, $a1, 0x4
    /* 89A24 80099224 93640208 */  j          .L8009924C
    /* 89A28 80099228 00000000 */   nop
  .L8009922C:
    /* 89A2C 8009922C 21282002 */  addu       $a1, $s1, $zero
    /* 89A30 80099230 2400A624 */  addiu      $a2, $a1, 0x24
    /* 89A34 80099234 3800A78C */  lw         $a3, 0x38($a1)
    /* 89A38 80099238 3400A38C */  lw         $v1, 0x34($a1)
    /* 89A3C 8009923C 0400A224 */  addiu      $v0, $a1, 0x4
    /* 89A40 80099240 1400A2AF */  sw         $v0, 0x14($sp)
    /* 89A44 80099244 5B50020C */  jal        SPCHNFS_W_D_SPBLT_PLC
    /* 89A48 80099248 1000A3AF */   sw        $v1, 0x10($sp)
  .L8009924C:
    /* 89A4C 8009924C 919D030C */  jal        SPCH_PlaySpeech
    /* 89A50 80099250 00000000 */   nop
    /* 89A54 80099254 2000BF8F */  lw         $ra, 0x20($sp)
    /* 89A58 80099258 1C00B18F */  lw         $s1, 0x1C($sp)
    /* 89A5C 8009925C 1800B08F */  lw         $s0, 0x18($sp)
    /* 89A60 80099260 0800E003 */  jr         $ra
    /* 89A64 80099264 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel ReportBlockade__Q26Speech13MobileSpeaker
