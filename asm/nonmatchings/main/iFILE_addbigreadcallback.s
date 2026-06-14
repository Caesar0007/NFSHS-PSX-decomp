.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iFILE_addbigreadcallback, 0x140

glabel iFILE_addbigreadcallback
    /* DCE60 800EC660 C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* DCE64 800EC664 2400B1AF */  sw         $s1, 0x24($sp)
    /* DCE68 800EC668 2188C000 */  addu       $s1, $a2, $zero
    /* DCE6C 800EC66C 1480023C */  lui        $v0, %hi(gFileDevice)
    /* DCE70 800EC670 2C00B3AF */  sw         $s3, 0x2C($sp)
    /* DCE74 800EC674 88EA5324 */  addiu      $s3, $v0, %lo(gFileDevice)
    /* DCE78 800EC678 021E0400 */  srl        $v1, $a0, 24
    /* DCE7C 800EC67C 40100300 */  sll        $v0, $v1, 1
    /* DCE80 800EC680 21104300 */  addu       $v0, $v0, $v1
    /* DCE84 800EC684 00110200 */  sll        $v0, $v0, 4
    /* DCE88 800EC688 3400BFAF */  sw         $ra, 0x34($sp)
    /* DCE8C 800EC68C 3000B4AF */  sw         $s4, 0x30($sp)
    /* DCE90 800EC690 2800B2AF */  sw         $s2, 0x28($sp)
    /* DCE94 800EC694 2000B0AF */  sw         $s0, 0x20($sp)
    /* DCE98 800EC698 1800638E */  lw         $v1, 0x18($s3)
    /* DCE9C 800EC69C 0800258E */  lw         $a1, 0x8($s1)
    /* DCEA0 800EC6A0 21186200 */  addu       $v1, $v1, $v0
    /* DCEA4 800EC6A4 2400628C */  lw         $v0, 0x24($v1)
    /* DCEA8 800EC6A8 1000748C */  lw         $s4, 0x10($v1)
    /* DCEAC 800EC6AC 040022AE */  sw         $v0, 0x4($s1)
    /* DCEB0 800EC6B0 ACB0030C */  jal        FILE_completeop
    /* DCEB4 800EC6B4 2400A2AC */   sw        $v0, 0x24($a1)
    /* DCEB8 800EC6B8 0000248E */  lw         $a0, 0x0($s1)
    /* DCEBC 800EC6BC C797030C */  jal        typeofbigfile
    /* DCEC0 800EC6C0 21802002 */   addu      $s0, $s1, $zero
    /* DCEC4 800EC6C4 04004014 */  bnez       $v0, .L800EC6D8
    /* DCEC8 800EC6C8 00000000 */   nop
    /* DCECC 800EC6CC 0000248E */  lw         $a0, 0x0($s1)
    /* DCED0 800EC6D0 5095030C */  jal        purgememadr
    /* DCED4 800EC6D4 00000000 */   nop
  .L800EC6D8:
    /* DCED8 800EC6D8 0000248E */  lw         $a0, 0x0($s1)
    /* DCEDC 800EC6DC E197030C */  jal        sizeofbigfileheader
    /* DCEE0 800EC6E0 00000000 */   nop
    /* DCEE4 800EC6E4 0000248E */  lw         $a0, 0x0($s1)
    /* DCEE8 800EC6E8 B594030C */  jal        getblocksize
    /* DCEEC 800EC6EC 21904000 */   addu      $s2, $v0, $zero
    /* DCEF0 800EC6F0 2A105200 */  slt        $v0, $v0, $s2
    /* DCEF4 800EC6F4 1B004010 */  beqz       $v0, .L800EC764
    /* DCEF8 800EC6F8 0580043C */   lui       $a0, %hi(D_80056C50)
    /* DCEFC 800EC6FC 506C8424 */  addiu      $a0, $a0, %lo(D_80056C50)
    /* DCF00 800EC700 21284002 */  addu       $a1, $s2, $zero
    /* DCF04 800EC704 CF94030C */  jal        reservememadr
    /* DCF08 800EC708 10000624 */   addiu     $a2, $zero, 0x10
    /* DCF0C 800EC70C 21804000 */  addu       $s0, $v0, $zero
    /* DCF10 800EC710 21280002 */  addu       $a1, $s0, $zero
    /* DCF14 800EC714 0000248E */  lw         $a0, 0x0($s1)
    /* DCF18 800EC718 B798030C */  jal        blockmove
    /* DCF1C 800EC71C 00080624 */   addiu     $a2, $zero, 0x800
    /* DCF20 800EC720 0000248E */  lw         $a0, 0x0($s1)
    /* DCF24 800EC724 5095030C */  jal        purgememadr
    /* DCF28 800EC728 00000000 */   nop
    /* DCF2C 800EC72C 00080524 */  addiu      $a1, $zero, 0x800
    /* DCF30 800EC730 21300502 */  addu       $a2, $s0, $a1
    /* DCF34 800EC734 000030AE */  sw         $s0, 0x0($s1)
    /* DCF38 800EC738 1000B4AF */  sw         $s4, 0x10($sp)
    /* DCF3C 800EC73C 1400B1AF */  sw         $s1, 0x14($sp)
    /* DCF40 800EC740 0400248E */  lw         $a0, 0x4($s1)
    /* DCF44 800EC744 3BB1030C */  jal        FILE_read
    /* DCF48 800EC748 00F84726 */   addiu     $a3, $s2, -0x800
    /* DCF4C 800EC74C 21204000 */  addu       $a0, $v0, $zero
    /* DCF50 800EC750 0F80053C */  lui        $a1, %hi(iFILE_addbigreadcallback)
    /* DCF54 800EC754 93AF030C */  jal        FILE_callbackop
    /* DCF58 800EC758 60C6A524 */   addiu     $a1, $a1, %lo(iFILE_addbigreadcallback)
    /* DCF5C 800EC75C E0B10308 */  j          .L800EC780
    /* DCF60 800EC760 00000000 */   nop
  .L800EC764:
    /* DCF64 800EC764 2400628E */  lw         $v0, 0x24($s3)
    /* DCF68 800EC768 00000000 */  nop
    /* DCF6C 800EC76C 0C0002AE */  sw         $v0, 0xC($s0)
    /* DCF70 800EC770 240070AE */  sw         $s0, 0x24($s3)
    /* DCF74 800EC774 0800048E */  lw         $a0, 0x8($s0)
    /* DCF78 800EC778 E6B2030C */  jal        func_800ECB98
    /* DCF7C 800EC77C 00000000 */   nop
  .L800EC780:
    /* DCF80 800EC780 3400BF8F */  lw         $ra, 0x34($sp)
    /* DCF84 800EC784 3000B48F */  lw         $s4, 0x30($sp)
    /* DCF88 800EC788 2C00B38F */  lw         $s3, 0x2C($sp)
    /* DCF8C 800EC78C 2800B28F */  lw         $s2, 0x28($sp)
    /* DCF90 800EC790 2400B18F */  lw         $s1, 0x24($sp)
    /* DCF94 800EC794 2000B08F */  lw         $s0, 0x20($sp)
    /* DCF98 800EC798 0800E003 */  jr         $ra
    /* DCF9C 800EC79C 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel iFILE_addbigreadcallback
