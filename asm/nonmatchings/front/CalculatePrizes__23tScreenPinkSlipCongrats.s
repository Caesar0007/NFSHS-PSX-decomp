.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CalculatePrizes__23tScreenPinkSlipCongrats, 0x110

glabel CalculatePrizes__23tScreenPinkSlipCongrats
    /* 394DC 80048CDC 08FFBD27 */  addiu      $sp, $sp, -0xF8
    /* 394E0 80048CE0 EC00B3AF */  sw         $s3, 0xEC($sp)
    /* 394E4 80048CE4 21988000 */  addu       $s3, $a0, $zero
    /* 394E8 80048CE8 E800B2AF */  sw         $s2, 0xE8($sp)
    /* 394EC 80048CEC FFFF1224 */  addiu      $s2, $zero, -0x1
    /* 394F0 80048CF0 F000BFAF */  sw         $ra, 0xF0($sp)
    /* 394F4 80048CF4 E400B1AF */  sw         $s1, 0xE4($sp)
    /* 394F8 80048CF8 E000B0AF */  sw         $s0, 0xE0($sp)
    /* 394FC 80048CFC 84017186 */  lh         $s1, 0x184($s3)
    /* 39500 80048D00 03000224 */  addiu      $v0, $zero, 0x3
    /* 39504 80048D04 680062AE */  sw         $v0, 0x68($s3)
    /* 39508 80048D08 02000224 */  addiu      $v0, $zero, 0x2
    /* 3950C 80048D0C 6C0062AE */  sw         $v0, 0x6C($s3)
    /* 39510 80048D10 84016286 */  lh         $v0, 0x184($s3)
    /* 39514 80048D14 01001024 */  addiu      $s0, $zero, 0x1
    /* 39518 80048D18 7C0060AE */  sw         $zero, 0x7C($s3)
    /* 3951C 80048D1C 800072AE */  sw         $s2, 0x80($s3)
    /* 39520 80048D20 640060AE */  sw         $zero, 0x64($s3)
    /* 39524 80048D24 23881102 */  subu       $s1, $s0, $s1
    /* 39528 80048D28 21202002 */  addu       $a0, $s1, $zero
    /* 3952C 80048D2C 23100202 */  subu       $v0, $s0, $v0
    /* 39530 80048D30 7CF1020C */  jal        CarIO_CleanUpLicense__Fi
    /* 39534 80048D34 780062AE */   sw        $v0, 0x78($s3)
    /* 39538 80048D38 23801102 */  subu       $s0, $s0, $s1
    /* 3953C 80048D3C C0801000 */  sll        $s0, $s0, 3
    /* 39540 80048D40 1180043C */  lui        $a0, %hi(D_80114984)
    /* 39544 80048D44 84498424 */  addiu      $a0, $a0, %lo(D_80114984)
    /* 39548 80048D48 21200402 */  addu       $a0, $s0, $a0
    /* 3954C 80048D4C 21280000 */  addu       $a1, $zero, $zero
    /* 39550 80048D50 97F0020C */  jal        CarIO_CreateLicense__FPcii
    /* 39554 80048D54 21302002 */   addu      $a2, $s1, $zero
    /* 39558 80048D58 6000628E */  lw         $v0, 0x60($s3)
    /* 3955C 80048D5C 1000A527 */  addiu      $a1, $sp, 0x10
    /* 39560 80048D60 60004484 */  lh         $a0, 0x60($v0)
    /* 39564 80048D64 6400428C */  lw         $v0, 0x64($v0)
    /* 39568 80048D68 00000000 */  nop
    /* 3956C 80048D6C 09F84000 */  jalr       $v0
    /* 39570 80048D70 21206402 */   addu      $a0, $s3, $a0
    /* 39574 80048D74 D100A383 */  lb         $v1, 0xD1($sp)
    /* 39578 80048D78 00000000 */  nop
    /* 3957C 80048D7C 07007210 */  beq        $v1, $s2, .L80048D9C
    /* 39580 80048D80 40180300 */   sll       $v1, $v1, 1
    /* 39584 80048D84 84016286 */  lh         $v0, 0x184($s3)
    /* 39588 80048D88 00000000 */  nop
    /* 3958C 80048D8C 13004224 */  addiu      $v0, $v0, 0x13
    /* 39590 80048D90 21186200 */  addu       $v1, $v1, $v0
    /* 39594 80048D94 6B230108 */  j          .L80048DAC
    /* 39598 80048D98 740163AE */   sw        $v1, 0x174($s3)
  .L80048D9C:
    /* 3959C 80048D9C 84016286 */  lh         $v0, 0x184($s3)
    /* 395A0 80048DA0 00000000 */  nop
    /* 395A4 80048DA4 17004224 */  addiu      $v0, $v0, 0x17
    /* 395A8 80048DA8 740162AE */  sw         $v0, 0x174($s3)
  .L80048DAC:
    /* 395AC 80048DAC 8040033C */  lui        $v1, (0x40800000 >> 16)
    /* 395B0 80048DB0 ECC0043C */  lui        $a0, (0xC0ECCCCD >> 16)
    /* 395B4 80048DB4 CDCC8434 */  ori        $a0, $a0, (0xC0ECCCCD & 0xFFFF)
    /* 395B8 80048DB8 16010224 */  addiu      $v0, $zero, 0x116
    /* 395BC 80048DBC 780162A6 */  sh         $v0, 0x178($s3)
    /* 395C0 80048DC0 4B000224 */  addiu      $v0, $zero, 0x4B
    /* 395C4 80048DC4 7A0162A6 */  sh         $v0, 0x17A($s3)
    /* 395C8 80048DC8 7C0163AE */  sw         $v1, 0x17C($s3)
    /* 395CC 80048DCC 800164AE */  sw         $a0, 0x180($s3)
    /* 395D0 80048DD0 F000BF8F */  lw         $ra, 0xF0($sp)
    /* 395D4 80048DD4 EC00B38F */  lw         $s3, 0xEC($sp)
    /* 395D8 80048DD8 E800B28F */  lw         $s2, 0xE8($sp)
    /* 395DC 80048DDC E400B18F */  lw         $s1, 0xE4($sp)
    /* 395E0 80048DE0 E000B08F */  lw         $s0, 0xE0($sp)
    /* 395E4 80048DE4 0800E003 */  jr         $ra
    /* 395E8 80048DE8 F800BD27 */   addiu     $sp, $sp, 0xF8
endlabel CalculatePrizes__23tScreenPinkSlipCongrats
