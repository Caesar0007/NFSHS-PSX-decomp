.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Newton_OptzRotxform__FP10matrixtdefiiiPiiT4, 0x19C

glabel Newton_OptzRotxform__FP10matrixtdefiiiPiiT4
    /* 9274C 800A1F4C 30FFBD27 */  addiu      $sp, $sp, -0xD0
    /* 92750 800A1F50 C800B6AF */  sw         $s6, 0xC8($sp)
    /* 92754 800A1F54 21B08000 */  addu       $s6, $a0, $zero
    /* 92758 800A1F58 C000B4AF */  sw         $s4, 0xC0($sp)
    /* 9275C 800A1F5C 21A0A000 */  addu       $s4, $a1, $zero
    /* 92760 800A1F60 2128C000 */  addu       $a1, $a2, $zero
    /* 92764 800A1F64 C400B5AF */  sw         $s5, 0xC4($sp)
    /* 92768 800A1F68 21A8E000 */  addu       $s5, $a3, $zero
    /* 9276C 800A1F6C B800B2AF */  sw         $s2, 0xB8($sp)
    /* 92770 800A1F70 3800B227 */  addiu      $s2, $sp, 0x38
    /* 92774 800A1F74 E000A28F */  lw         $v0, 0xE0($sp)
    /* 92778 800A1F78 E800A68F */  lw         $a2, 0xE8($sp)
    /* 9277C 800A1F7C 21204002 */  addu       $a0, $s2, $zero
    /* 92780 800A1F80 B400B1AF */  sw         $s1, 0xB4($sp)
    /* 92784 800A1F84 02008106 */  bgez       $s4, .L800A1F90
    /* 92788 800A1F88 21888002 */   addu      $s1, $s4, $zero
    /* 9278C 800A1F8C 23881100 */  negu       $s1, $s1
  .L800A1F90:
    /* 92790 800A1F90 B000B0AF */  sw         $s0, 0xB0($sp)
    /* 92794 800A1F94 0200A104 */  bgez       $a1, .L800A1FA0
    /* 92798 800A1F98 2180A000 */   addu      $s0, $a1, $zero
    /* 9279C 800A1F9C 23801000 */  negu       $s0, $s0
  .L800A1FA0:
    /* 927A0 800A1FA0 BC00B3AF */  sw         $s3, 0xBC($sp)
    /* 927A4 800A1FA4 0200A106 */  bgez       $s5, .L800A1FB0
    /* 927A8 800A1FA8 2198A002 */   addu      $s3, $s5, $zero
    /* 927AC 800A1FAC 23981300 */  negu       $s3, $s3
  .L800A1FB0:
    /* 927B0 800A1FB0 CC00BFAF */  sw         $ra, 0xCC($sp)
    /* 927B4 800A1FB4 000040AC */  sw         $zero, 0x0($v0)
    /* 927B8 800A1FB8 21103002 */  addu       $v0, $s1, $s0
    /* 927BC 800A1FBC 0000C38C */  lw         $v1, 0x0($a2)
    /* 927C0 800A1FC0 21105300 */  addu       $v0, $v0, $s3
    /* 927C4 800A1FC4 21186200 */  addu       $v1, $v1, $v0
    /* 927C8 800A1FC8 04AB030C */  jal        fixedxformy
    /* 927CC 800A1FCC 0000C3AC */   sw        $v1, 0x0($a2)
    /* 927D0 800A1FD0 1400102A */  slti       $s0, $s0, 0x14
    /* 927D4 800A1FD4 0E00312A */  slti       $s1, $s1, 0xE
    /* 927D8 800A1FD8 0A002016 */  bnez       $s1, .L800A2004
    /* 927DC 800A1FDC 0100103A */   xori      $s0, $s0, 0x1
    /* 927E0 800A1FE0 1000A427 */  addiu      $a0, $sp, 0x10
    /* 927E4 800A1FE4 EBAA030C */  jal        fixedxformx
    /* 927E8 800A1FE8 21288002 */   addu      $a1, $s4, $zero
    /* 927EC 800A1FEC 1000A427 */  addiu      $a0, $sp, 0x10
    /* 927F0 800A1FF0 21284002 */  addu       $a1, $s2, $zero
    /* 927F4 800A1FF4 6377020C */  jal        Math_fasttransmult__FP10matrixtdefN20
    /* 927F8 800A1FF8 8800A627 */   addiu     $a2, $sp, 0x88
    /* 927FC 800A1FFC 12880208 */  j          .L800A2048
    /* 92800 800A2000 01001024 */   addiu     $s0, $zero, 0x1
  .L800A2004:
    /* 92804 800A2004 8800A227 */  addiu      $v0, $sp, 0x88
    /* 92808 800A2008 21204002 */  addu       $a0, $s2, $zero
    /* 9280C 800A200C 5800A327 */  addiu      $v1, $sp, 0x58
  .L800A2010:
    /* 92810 800A2010 0000888C */  lw         $t0, 0x0($a0)
    /* 92814 800A2014 0400898C */  lw         $t1, 0x4($a0)
    /* 92818 800A2018 08008A8C */  lw         $t2, 0x8($a0)
    /* 9281C 800A201C 0C008B8C */  lw         $t3, 0xC($a0)
    /* 92820 800A2020 000048AC */  sw         $t0, 0x0($v0)
    /* 92824 800A2024 040049AC */  sw         $t1, 0x4($v0)
    /* 92828 800A2028 08004AAC */  sw         $t2, 0x8($v0)
    /* 9282C 800A202C 0C004BAC */  sw         $t3, 0xC($v0)
    /* 92830 800A2030 10008424 */  addiu      $a0, $a0, 0x10
    /* 92834 800A2034 F6FF8314 */  bne        $a0, $v1, .L800A2010
    /* 92838 800A2038 10004224 */   addiu     $v0, $v0, 0x10
    /* 9283C 800A203C 0000888C */  lw         $t0, 0x0($a0)
    /* 92840 800A2040 00000000 */  nop
    /* 92844 800A2044 000048AC */  sw         $t0, 0x0($v0)
  .L800A2048:
    /* 92848 800A2048 0E00622A */  slti       $v0, $s3, 0xE
    /* 9284C 800A204C 0B004014 */  bnez       $v0, .L800A207C
    /* 92850 800A2050 2120C002 */   addu      $a0, $s6, $zero
    /* 92854 800A2054 6000B027 */  addiu      $s0, $sp, 0x60
    /* 92858 800A2058 21200002 */  addu       $a0, $s0, $zero
    /* 9285C 800A205C 1DAB030C */  jal        fixedxformz
    /* 92860 800A2060 2128A002 */   addu      $a1, $s5, $zero
    /* 92864 800A2064 8800A427 */  addiu      $a0, $sp, 0x88
    /* 92868 800A2068 21280002 */  addu       $a1, $s0, $zero
    /* 9286C 800A206C 6377020C */  jal        Math_fasttransmult__FP10matrixtdefN20
    /* 92870 800A2070 2130C002 */   addu      $a2, $s6, $zero
    /* 92874 800A2074 2F880208 */  j          .L800A20BC
    /* 92878 800A2078 01001024 */   addiu     $s0, $zero, 0x1
  .L800A207C:
    /* 9287C 800A207C 8800A227 */  addiu      $v0, $sp, 0x88
    /* 92880 800A2080 A800A327 */  addiu      $v1, $sp, 0xA8
  .L800A2084:
    /* 92884 800A2084 0000488C */  lw         $t0, 0x0($v0)
    /* 92888 800A2088 0400498C */  lw         $t1, 0x4($v0)
    /* 9288C 800A208C 08004A8C */  lw         $t2, 0x8($v0)
    /* 92890 800A2090 0C004B8C */  lw         $t3, 0xC($v0)
    /* 92894 800A2094 000088AC */  sw         $t0, 0x0($a0)
    /* 92898 800A2098 040089AC */  sw         $t1, 0x4($a0)
    /* 9289C 800A209C 08008AAC */  sw         $t2, 0x8($a0)
    /* 928A0 800A20A0 0C008BAC */  sw         $t3, 0xC($a0)
    /* 928A4 800A20A4 10004224 */  addiu      $v0, $v0, 0x10
    /* 928A8 800A20A8 F6FF4314 */  bne        $v0, $v1, .L800A2084
    /* 928AC 800A20AC 10008424 */   addiu     $a0, $a0, 0x10
    /* 928B0 800A20B0 0000488C */  lw         $t0, 0x0($v0)
    /* 928B4 800A20B4 00000000 */  nop
    /* 928B8 800A20B8 000088AC */  sw         $t0, 0x0($a0)
  .L800A20BC:
    /* 928BC 800A20BC 21100002 */  addu       $v0, $s0, $zero
    /* 928C0 800A20C0 CC00BF8F */  lw         $ra, 0xCC($sp)
    /* 928C4 800A20C4 C800B68F */  lw         $s6, 0xC8($sp)
    /* 928C8 800A20C8 C400B58F */  lw         $s5, 0xC4($sp)
    /* 928CC 800A20CC C000B48F */  lw         $s4, 0xC0($sp)
    /* 928D0 800A20D0 BC00B38F */  lw         $s3, 0xBC($sp)
    /* 928D4 800A20D4 B800B28F */  lw         $s2, 0xB8($sp)
    /* 928D8 800A20D8 B400B18F */  lw         $s1, 0xB4($sp)
    /* 928DC 800A20DC B000B08F */  lw         $s0, 0xB0($sp)
    /* 928E0 800A20E0 0800E003 */  jr         $ra
    /* 928E4 800A20E4 D000BD27 */   addiu     $sp, $sp, 0xD0
endlabel Newton_OptzRotxform__FP10matrixtdefiiiPiiT4
