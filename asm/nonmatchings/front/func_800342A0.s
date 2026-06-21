.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_800342A0, 0x78

glabel func_800342A0
    /* 24AA0 800342A0 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 24AA4 800342A4 1000B0AF */  sw         $s0, 0x10($sp)
    /* 24AA8 800342A8 21808000 */  addu       $s0, $a0, $zero
    /* 24AAC 800342AC 08000426 */  addiu      $a0, $s0, 0x8
    /* 24AB0 800342B0 50040524 */  addiu      $a1, $zero, 0x450
    /* 24AB4 800342B4 AC140224 */  addiu      $v0, $zero, 0x14AC
    /* 24AB8 800342B8 1400BFAF */  sw         $ra, 0x14($sp)
    /* 24ABC 800342BC 53D8030C */  jal        crc16
    /* 24AC0 800342C0 000002AE */   sw        $v0, 0x0($s0)
    /* 24AC4 800342C4 58040426 */  addiu      $a0, $s0, 0x458
    /* 24AC8 800342C8 E0000524 */  addiu      $a1, $zero, 0xE0
    /* 24ACC 800342CC 53D8030C */  jal        crc16
    /* 24AD0 800342D0 981402AE */   sw        $v0, 0x1498($s0)
    /* 24AD4 800342D4 38050426 */  addiu      $a0, $s0, 0x538
    /* 24AD8 800342D8 10000524 */  addiu      $a1, $zero, 0x10
    /* 24ADC 800342DC 53D8030C */  jal        crc16
    /* 24AE0 800342E0 9C1402AE */   sw        $v0, 0x149C($s0)
    /* 24AE4 800342E4 48050426 */  addiu      $a0, $s0, 0x548
    /* 24AE8 800342E8 B0000524 */  addiu      $a1, $zero, 0xB0
    /* 24AEC 800342EC 53D8030C */  jal        crc16
    /* 24AF0 800342F0 A01402AE */   sw        $v0, 0x14A0($s0)
    /* 24AF4 800342F4 F8050426 */  addiu      $a0, $s0, 0x5F8
    /* 24AF8 800342F8 9C0E0524 */  addiu      $a1, $zero, 0xE9C
    /* 24AFC 800342FC 53D8030C */  jal        crc16
    /* 24B00 80034300 A41402AE */   sw        $v0, 0x14A4($s0)
    /* 24B04 80034304 A81402AE */  sw         $v0, 0x14A8($s0)
    /* 24B08 80034308 1400BF8F */  lw         $ra, 0x14($sp)
    /* 24B0C 8003430C 1000B08F */  lw         $s0, 0x10($sp)
    /* 24B10 80034310 0800E003 */  jr         $ra
    /* 24B14 80034314 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel func_800342A0
