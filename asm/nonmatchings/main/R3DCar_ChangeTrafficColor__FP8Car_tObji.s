.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching R3DCar_ChangeTrafficColor__FP8Car_tObji, 0xE8

glabel R3DCar_ChangeTrafficColor__FP8Car_tObji
    /* 9E42C 800ADC2C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 9E430 800ADC30 1000B0AF */  sw         $s0, 0x10($sp)
    /* 9E434 800ADC34 21808000 */  addu       $s0, $a0, $zero
    /* 9E438 800ADC38 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 9E43C 800ADC3C 1800B2AF */  sw         $s2, 0x18($sp)
    /* 9E440 800ADC40 1400B1AF */  sw         $s1, 0x14($sp)
    /* 9E444 800ADC44 8408028E */  lw         $v0, 0x884($s0)
    /* 9E448 800ADC48 00000000 */  nop
    /* 9E44C 800ADC4C 2B004010 */  beqz       $v0, .L800ADCFC
    /* 9E450 800ADC50 2188A000 */   addu      $s1, $a1, $zero
    /* 9E454 800ADC54 40080296 */  lhu        $v0, 0x840($s0)
    /* 9E458 800ADC58 07003132 */  andi       $s1, $s1, 0x7
    /* 9E45C 800ADC5C 08004330 */  andi       $v1, $v0, 0x8
    /* 9E460 800ADC60 21907100 */  addu       $s2, $v1, $s1
    /* 9E464 800ADC64 00140200 */  sll        $v0, $v0, 16
    /* 9E468 800ADC68 03140200 */  sra        $v0, $v0, 16
    /* 9E46C 800ADC6C 23004212 */  beq        $s2, $v0, .L800ADCFC
    /* 9E470 800ADC70 00000000 */   nop
    /* 9E474 800ADC74 1FB6030C */  jal        DrawSync
    /* 9E478 800ADC78 21200000 */   addu      $a0, $zero, $zero
    /* 9E47C 800ADC7C BC080286 */  lh         $v0, 0x8BC($s0)
    /* 9E480 800ADC80 00000000 */  nop
    /* 9E484 800ADC84 1C004228 */  slti       $v0, $v0, 0x1C
    /* 9E488 800ADC88 15004010 */  beqz       $v0, .L800ADCE0
    /* 9E48C 800ADC8C 21280000 */   addu      $a1, $zero, $zero
    /* 9E490 800ADC90 B3080292 */  lbu        $v0, 0x8B3($s0)
    /* 9E494 800ADC94 8408048E */  lw         $a0, 0x884($s0)
    /* 9E498 800ADC98 02004230 */  andi       $v0, $v0, 0x2
    /* 9E49C 800ADC9C 80100200 */  sll        $v0, $v0, 2
    /* 9E4A0 800ADCA0 21102202 */  addu       $v0, $s1, $v0
    /* 9E4A4 800ADCA4 1480013C */  lui        $at, %hi(Texture_CarColor)
    /* 9E4A8 800ADCA8 08DB22AC */  sw         $v0, %lo(Texture_CarColor)($at)
    /* 9E4AC 800ADCAC A77E030C */  jal        Texture_ProcessPaletteCopy__FP15Texture_pal8bitii
    /* 9E4B0 800ADCB0 01000624 */   addiu     $a2, $zero, 0x1
    /* 9E4B4 800ADCB4 01000524 */  addiu      $a1, $zero, 0x1
    /* 9E4B8 800ADCB8 8408048E */  lw         $a0, 0x884($s0)
    /* 9E4BC 800ADCBC B3080292 */  lbu        $v0, 0x8B3($s0)
    /* 9E4C0 800ADCC0 88080686 */  lh         $a2, 0x888($s0)
    /* 9E4C4 800ADCC4 24104500 */  and        $v0, $v0, $a1
    /* 9E4C8 800ADCC8 C0100200 */  sll        $v0, $v0, 3
    /* 9E4CC 800ADCCC 21102202 */  addu       $v0, $s1, $v0
    /* 9E4D0 800ADCD0 1480013C */  lui        $at, %hi(Texture_CarColor)
    /* 9E4D4 800ADCD4 08DB22AC */  sw         $v0, %lo(Texture_CarColor)($at)
    /* 9E4D8 800ADCD8 3CB70208 */  j          .L800ADCF0
    /* 9E4DC 800ADCDC 00000000 */   nop
  .L800ADCE0:
    /* 9E4E0 800ADCE0 8408048E */  lw         $a0, 0x884($s0)
    /* 9E4E4 800ADCE4 88080686 */  lh         $a2, 0x888($s0)
    /* 9E4E8 800ADCE8 1480013C */  lui        $at, %hi(Texture_CarColor)
    /* 9E4EC 800ADCEC 08DB31AC */  sw         $s1, %lo(Texture_CarColor)($at)
  .L800ADCF0:
    /* 9E4F0 800ADCF0 A77E030C */  jal        Texture_ProcessPaletteCopy__FP15Texture_pal8bitii
    /* 9E4F4 800ADCF4 00000000 */   nop
    /* 9E4F8 800ADCF8 400812A6 */  sh         $s2, 0x840($s0)
  .L800ADCFC:
    /* 9E4FC 800ADCFC 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 9E500 800ADD00 1800B28F */  lw         $s2, 0x18($sp)
    /* 9E504 800ADD04 1400B18F */  lw         $s1, 0x14($sp)
    /* 9E508 800ADD08 1000B08F */  lw         $s0, 0x10($sp)
    /* 9E50C 800ADD0C 0800E003 */  jr         $ra
    /* 9E510 800ADD10 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel R3DCar_ChangeTrafficColor__FP8Car_tObji
