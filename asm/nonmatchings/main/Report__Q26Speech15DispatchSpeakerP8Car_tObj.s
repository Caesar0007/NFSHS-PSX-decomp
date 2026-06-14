.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Report__Q26Speech15DispatchSpeakerP8Car_tObj, 0x1A0

glabel Report__Q26Speech15DispatchSpeakerP8Car_tObj
    /* 879B0 800971B0 3808828F */  lw         $v0, %gp_rel(_6Speech_fgSpeech)($gp)
    /* 879B4 800971B4 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 879B8 800971B8 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* 879BC 800971BC 21888000 */  addu       $s1, $a0, $zero
    /* 879C0 800971C0 2000B2AF */  sw         $s2, 0x20($sp)
    /* 879C4 800971C4 2190A000 */  addu       $s2, $a1, $zero
    /* 879C8 800971C8 1800B0AF */  sw         $s0, 0x18($sp)
    /* 879CC 800971CC 21800000 */  addu       $s0, $zero, $zero
    /* 879D0 800971D0 2400BFAF */  sw         $ra, 0x24($sp)
    /* 879D4 800971D4 8C0340AC */  sw         $zero, 0x38C($v0)
    /* 879D8 800971D8 4C00228E */  lw         $v0, 0x4C($s1)
    /* 879DC 800971DC 00000000 */  nop
    /* 879E0 800971E0 90004484 */  lh         $a0, 0x90($v0)
    /* 879E4 800971E4 9400428C */  lw         $v0, 0x94($v0)
    /* 879E8 800971E8 00000000 */  nop
    /* 879EC 800971EC 09F84000 */  jalr       $v0
    /* 879F0 800971F0 21202402 */   addu      $a0, $s1, $a0
    /* 879F4 800971F4 04004010 */  beqz       $v0, .L80097208
    /* 879F8 800971F8 00000000 */   nop
    /* 879FC 800971FC 4800228E */  lw         $v0, 0x48($s1)
    /* 87A00 80097200 00000000 */  nop
    /* 87A04 80097204 2B800202 */  sltu       $s0, $s0, $v0
  .L80097208:
    /* 87A08 80097208 23000012 */  beqz       $s0, .L80097298
    /* 87A0C 8009720C 00000000 */   nop
    /* 87A10 80097210 3808828F */  lw         $v0, %gp_rel(_6Speech_fgSpeech)($gp)
    /* 87A14 80097214 00000000 */  nop
    /* 87A18 80097218 8803428C */  lw         $v0, 0x388($v0)
    /* 87A1C 8009721C 00000000 */  nop
    /* 87A20 80097220 45004014 */  bnez       $v0, .L80097338
    /* 87A24 80097224 00000000 */   nop
    /* 87A28 80097228 4C00228E */  lw         $v0, 0x4C($s1)
    /* 87A2C 8009722C 00000000 */  nop
    /* 87A30 80097230 F0004484 */  lh         $a0, 0xF0($v0)
    /* 87A34 80097234 F400428C */  lw         $v0, 0xF4($v0)
    /* 87A38 80097238 00000000 */  nop
    /* 87A3C 8009723C 09F84000 */  jalr       $v0
    /* 87A40 80097240 21202402 */   addu      $a0, $s1, $a0
    /* 87A44 80097244 4800238E */  lw         $v1, 0x48($s1)
    /* 87A48 80097248 00000000 */  nop
    /* 87A4C 8009724C 4C00658C */  lw         $a1, 0x4C($v1)
    /* 87A50 80097250 00000000 */  nop
    /* 87A54 80097254 8800A484 */  lh         $a0, 0x88($a1)
    /* 87A58 80097258 00000000 */  nop
    /* 87A5C 8009725C 21206400 */  addu       $a0, $v1, $a0
    /* 87A60 80097260 8C00A38C */  lw         $v1, 0x8C($a1)
    /* 87A64 80097264 00000000 */  nop
    /* 87A68 80097268 09F86000 */  jalr       $v1
    /* 87A6C 8009726C 21804000 */   addu      $s0, $v0, $zero
    /* 87A70 80097270 80100200 */  sll        $v0, $v0, 2
    /* 87A74 80097274 21800202 */  addu       $s0, $s0, $v0
    /* 87A78 80097278 0800058E */  lw         $a1, 0x8($s0)
    /* 87A7C 8009727C 1C002426 */  addiu      $a0, $s1, 0x1C
    /* 87A80 80097280 084E020C */  jal        SPCHNFS_D_C_PERP_SIGHTED_CONFIRM
    /* 87A84 80097284 3C0025AE */   sw        $a1, 0x3C($s1)
    /* 87A88 80097288 919D030C */  jal        SPCH_PlaySpeech
    /* 87A8C 8009728C 00000000 */   nop
    /* 87A90 80097290 CE5C0208 */  j          .L80097338
    /* 87A94 80097294 00000000 */   nop
  .L80097298:
    /* 87A98 80097298 3808828F */  lw         $v0, %gp_rel(_6Speech_fgSpeech)($gp)
    /* 87A9C 8009729C 00000000 */  nop
    /* 87AA0 800972A0 8803428C */  lw         $v0, 0x388($v0)
    /* 87AA4 800972A4 00000000 */  nop
    /* 87AA8 800972A8 1E004014 */  bnez       $v0, .L80097324
    /* 87AAC 800972AC 00000000 */   nop
    /* 87AB0 800972B0 4C00228E */  lw         $v0, 0x4C($s1)
    /* 87AB4 800972B4 00000000 */  nop
    /* 87AB8 800972B8 F0004484 */  lh         $a0, 0xF0($v0)
    /* 87ABC 800972BC F400428C */  lw         $v0, 0xF4($v0)
    /* 87AC0 800972C0 00000000 */  nop
    /* 87AC4 800972C4 09F84000 */  jalr       $v0
    /* 87AC8 800972C8 21202402 */   addu      $a0, $s1, $a0
    /* 87ACC 800972CC 0000448C */  lw         $a0, 0x0($v0)
    /* 87AD0 800972D0 3800258E */  lw         $a1, 0x38($s1)
    /* 87AD4 800972D4 18002626 */  addiu      $a2, $s1, 0x18
    /* 87AD8 800972D8 C54F020C */  jal        SPCHNFS_D_C_INTRO_CALL
    /* 87ADC 800972DC 3C0024AE */   sw        $a0, 0x3C($s1)
    /* 87AE0 800972E0 919D030C */  jal        SPCH_PlaySpeech
    /* 87AE4 800972E4 00000000 */   nop
    /* 87AE8 800972E8 21202002 */  addu       $a0, $s1, $zero
    /* 87AEC 800972EC 7651020C */  jal        SetCar__Q26Speech7SpeakerP8Car_tObj
    /* 87AF0 800972F0 21284002 */   addu      $a1, $s2, $zero
    /* 87AF4 800972F4 21202002 */  addu       $a0, $s1, $zero
    /* 87AF8 800972F8 7652020C */  jal        FindLocation__Q26Speech7SpeakerP8Car_tObj
    /* 87AFC 800972FC 21284002 */   addu      $a1, $s2, $zero
    /* 87B00 80097300 08002426 */  addiu      $a0, $s1, 0x8
    /* 87B04 80097304 21302002 */  addu       $a2, $s1, $zero
    /* 87B08 80097308 3000258E */  lw         $a1, 0x30($s1)
    /* 87B0C 8009730C 3400278E */  lw         $a3, 0x34($s1)
    /* 87B10 80097310 04002226 */  addiu      $v0, $s1, 0x4
    /* 87B14 80097314 FF4B020C */  jal        SPCHNFS_D_C_BEGIN_PURS_REP_SPDR
    /* 87B18 80097318 1000A2AF */   sw        $v0, 0x10($sp)
    /* 87B1C 8009731C 919D030C */  jal        SPCH_PlaySpeech
    /* 87B20 80097320 00000000 */   nop
  .L80097324:
    /* 87B24 80097324 21202002 */  addu       $a0, $s1, $zero
    /* 87B28 80097328 605C020C */  jal        AddPerp__Q26Speech15DispatchSpeakerP8Car_tObj
    /* 87B2C 8009732C 21284002 */   addu      $a1, $s2, $zero
    /* 87B30 80097330 A0020224 */  addiu      $v0, $zero, 0x2A0
    /* 87B34 80097334 500022AE */  sw         $v0, 0x50($s1)
  .L80097338:
    /* 87B38 80097338 2400BF8F */  lw         $ra, 0x24($sp)
    /* 87B3C 8009733C 2000B28F */  lw         $s2, 0x20($sp)
    /* 87B40 80097340 1C00B18F */  lw         $s1, 0x1C($sp)
    /* 87B44 80097344 1800B08F */  lw         $s0, 0x18($sp)
    /* 87B48 80097348 0800E003 */  jr         $ra
    /* 87B4C 8009734C 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel Report__Q26Speech15DispatchSpeakerP8Car_tObj
