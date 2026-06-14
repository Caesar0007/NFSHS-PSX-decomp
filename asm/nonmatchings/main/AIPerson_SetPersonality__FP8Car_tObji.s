.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIPerson_SetPersonality__FP8Car_tObji, 0xC8

glabel AIPerson_SetPersonality__FP8Car_tObji
    /* 59234 80068A34 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 59238 80068A38 1400B1AF */  sw         $s1, 0x14($sp)
    /* 5923C 80068A3C 21888000 */  addu       $s1, $a0, $zero
    /* 59240 80068A40 1800BFAF */  sw         $ra, 0x18($sp)
    /* 59244 80068A44 1000B0AF */  sw         $s0, 0x10($sp)
    /* 59248 80068A48 6002228E */  lw         $v0, 0x260($s1)
    /* 5924C 80068A4C 00000000 */  nop
    /* 59250 80068A50 04004230 */  andi       $v0, $v0, 0x4
    /* 59254 80068A54 08004014 */  bnez       $v0, .L80068A78
    /* 59258 80068A58 2180A000 */   addu      $s0, $a1, $zero
    /* 5925C 80068A5C 8802248E */  lw         $a0, 0x288($s1)
    /* 59260 80068A60 C0101000 */  sll        $v0, $s0, 3
    /* 59264 80068A64 1180053C */  lui        $a1, %hi(GameSetup_gPersonalityNames)
    /* 59268 80068A68 7431A524 */  addiu      $a1, $a1, %lo(GameSetup_gPersonalityNames)
    /* 5926C 80068A6C 21284500 */  addu       $a1, $v0, $a1
    /* 59270 80068A70 CA96030C */  jal        strcpy
    /* 59274 80068A74 5C008424 */   addiu     $a0, $a0, 0x5C
  .L80068A78:
    /* 59278 80068A78 6666023C */  lui        $v0, (0x66666667 >> 16)
    /* 5927C 80068A7C 67664234 */  ori        $v0, $v0, (0x66666667 & 0xFFFF)
    /* 59280 80068A80 18000202 */  mult       $s0, $v0
    /* 59284 80068A84 F4042426 */  addiu      $a0, $s1, 0x4F4
    /* 59288 80068A88 C3171000 */  sra        $v0, $s0, 31
    /* 5928C 80068A8C 1180053C */  lui        $a1, %hi(AIPerson_ScriptData)
    /* 59290 80068A90 5CDAA524 */  addiu      $a1, $a1, %lo(AIPerson_ScriptData)
    /* 59294 80068A94 10300000 */  mfhi       $a2
    /* 59298 80068A98 43180600 */  sra        $v1, $a2, 1
    /* 5929C 80068A9C 23186200 */  subu       $v1, $v1, $v0
    /* 592A0 80068AA0 80100300 */  sll        $v0, $v1, 2
    /* 592A4 80068AA4 21104300 */  addu       $v0, $v0, $v1
    /* 592A8 80068AA8 23800202 */  subu       $s0, $s0, $v0
    /* 592AC 80068AAC C0101000 */  sll        $v0, $s0, 3
    /* 592B0 80068AB0 23105000 */  subu       $v0, $v0, $s0
    /* 592B4 80068AB4 C0100200 */  sll        $v0, $v0, 3
    /* 592B8 80068AB8 21284500 */  addu       $a1, $v0, $a1
    /* 592BC 80068ABC 80101000 */  sll        $v0, $s0, 2
    /* 592C0 80068AC0 21105000 */  addu       $v0, $v0, $s0
    /* 592C4 80068AC4 80100200 */  sll        $v0, $v0, 2
    /* 592C8 80068AC8 21105000 */  addu       $v0, $v0, $s0
    /* 592CC 80068ACC 80100200 */  sll        $v0, $v0, 2
    /* 592D0 80068AD0 1180033C */  lui        $v1, %hi(AIPerson_PersonalityData)
    /* 592D4 80068AD4 68D76324 */  addiu      $v1, $v1, %lo(AIPerson_PersonalityData)
    /* 592D8 80068AD8 21104300 */  addu       $v0, $v0, $v1
    /* 592DC 80068ADC EC0430AE */  sw         $s0, 0x4EC($s1)
    /* 592E0 80068AE0 BEBD010C */  jal        AIScript_Assign__FP10AIScript_tPA7_25AIScript_tReactionDetails
    /* 592E4 80068AE4 F00422AE */   sw        $v0, 0x4F0($s1)
    /* 592E8 80068AE8 1800BF8F */  lw         $ra, 0x18($sp)
    /* 592EC 80068AEC 1400B18F */  lw         $s1, 0x14($sp)
    /* 592F0 80068AF0 1000B08F */  lw         $s0, 0x10($sp)
    /* 592F4 80068AF4 0800E003 */  jr         $ra
    /* 592F8 80068AF8 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel AIPerson_SetPersonality__FP8Car_tObji
