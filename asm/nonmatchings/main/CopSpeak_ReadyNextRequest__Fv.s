.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CopSpeak_ReadyNextRequest__Fv, 0x270

glabel CopSpeak_ReadyNextRequest__Fv
    /* 89FAC 800997AC D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 89FB0 800997B0 1180033C */  lui        $v1, %hi(CopSpeak_gQueue)
    /* 89FB4 800997B4 900B828F */  lw         $v0, %gp_rel(CopSpeak_gQueueReady)($gp)
    /* 89FB8 800997B8 241F6324 */  addiu      $v1, $v1, %lo(CopSpeak_gQueue)
    /* 89FBC 800997BC 2400BFAF */  sw         $ra, 0x24($sp)
    /* 89FC0 800997C0 2000B2AF */  sw         $s2, 0x20($sp)
    /* 89FC4 800997C4 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* 89FC8 800997C8 1800B0AF */  sw         $s0, 0x18($sp)
    /* 89FCC 800997CC 40110200 */  sll        $v0, $v0, 5
    /* 89FD0 800997D0 21804300 */  addu       $s0, $v0, $v1
    /* 89FD4 800997D4 0400028E */  lw         $v0, 0x4($s0)
    /* 89FD8 800997D8 00000000 */  nop
    /* 89FDC 800997DC 70004004 */  bltz       $v0, .L800999A0
    /* 89FE0 800997E0 01001224 */   addiu     $s2, $zero, 0x1
    /* 89FE4 800997E4 1400048E */  lw         $a0, 0x14($s0)
    /* 89FE8 800997E8 71AF030C */  jal        FILE_opstatus
    /* 89FEC 800997EC 00000000 */   nop
    /* 89FF0 800997F0 84004010 */  beqz       $v0, .L80099A04
    /* 89FF4 800997F4 26105200 */   xor       $v0, $v0, $s2
    /* 89FF8 800997F8 1400048E */  lw         $a0, 0x14($s0)
    /* 89FFC 800997FC ACB0030C */  jal        FILE_completeop
    /* 8A000 80099800 2B905200 */   sltu      $s2, $v0, $s2
    /* 8A004 80099804 340B8393 */  lbu        $v1, %gp_rel(CopSpeak_gHandleCount)($gp)
    /* 8A008 80099808 0C00048E */  lw         $a0, 0xC($s0)
    /* 8A00C 8009980C FFFF6324 */  addiu      $v1, $v1, -0x1
    /* 8A010 80099810 340B83A3 */  sb         $v1, %gp_rel(CopSpeak_gHandleCount)($gp)
    /* 8A014 80099814 02004410 */  beq        $v0, $a0, .L80099820
    /* 8A018 80099818 00000000 */   nop
    /* 8A01C 8009981C 21900000 */  addu       $s2, $zero, $zero
  .L80099820:
    /* 8A020 80099820 980B838F */  lw         $v1, %gp_rel(CopSpeak_gBuffer)($gp)
    /* 8A024 80099824 0400028E */  lw         $v0, 0x4($s0)
    /* 8A028 80099828 4B6C043C */  lui        $a0, (0x6C4B4E42 >> 16)
    /* 8A02C 8009982C 21886200 */  addu       $s1, $v1, $v0
    /* 8A030 80099830 0000228E */  lw         $v0, 0x0($s1)
    /* 8A034 80099834 424E8434 */  ori        $a0, $a0, (0x6C4B4E42 & 0xFFFF)
    /* 8A038 80099838 02004410 */  beq        $v0, $a0, .L80099844
    /* 8A03C 8009983C 00000000 */   nop
    /* 8A040 80099840 21900000 */  addu       $s2, $zero, $zero
  .L80099844:
    /* 8A044 80099844 04002392 */  lbu        $v1, 0x4($s1)
    /* 8A048 80099848 04000224 */  addiu      $v0, $zero, 0x4
    /* 8A04C 8009984C 04006210 */  beq        $v1, $v0, .L80099860
    /* 8A050 80099850 02000224 */   addiu     $v0, $zero, 0x2
    /* 8A054 80099854 02006210 */  beq        $v1, $v0, .L80099860
    /* 8A058 80099858 00000000 */   nop
    /* 8A05C 8009985C 21900000 */  addu       $s2, $zero, $zero
  .L80099860:
    /* 8A060 80099860 21004016 */  bnez       $s2, .L800998E8
    /* 8A064 80099864 00000000 */   nop
    /* 8A068 80099868 1D000292 */  lbu        $v0, 0x1D($s0)
    /* 8A06C 8009986C 00000000 */  nop
    /* 8A070 80099870 09004010 */  beqz       $v0, .L80099898
    /* 8A074 80099874 494C023C */   lui       $v0, (0x4C494146 >> 16)
    /* 8A078 80099878 1E000482 */  lb         $a0, 0x1E($s0)
    /* 8A07C 8009987C 00000000 */  nop
    /* 8A080 80099880 05008004 */  bltz       $a0, .L80099898
    /* 8A084 80099884 21300000 */   addu      $a2, $zero, $zero
    /* 8A088 80099888 1800058E */  lw         $a1, 0x18($s0)
    /* 8A08C 8009988C D7D9010C */  jal        AudioCmn_LoadAsyncSfx__FiiPvi
    /* 8A090 80099890 2138C000 */   addu      $a3, $a2, $zero
    /* 8A094 80099894 494C023C */  lui        $v0, (0x4C494146 >> 16)
  .L80099898:
    /* 8A098 80099898 46414234 */  ori        $v0, $v0, (0x4C494146 & 0xFFFF)
    /* 8A09C 8009989C 000022AE */  sw         $v0, 0x0($s1)
    /* 8A0A0 800998A0 0400028E */  lw         $v0, 0x4($s0)
    /* 8A0A4 800998A4 1000A0AF */  sw         $zero, 0x10($sp)
    /* 8A0A8 800998A8 1400A0AF */  sw         $zero, 0x14($sp)
    /* 8A0AC 800998AC 1000048E */  lw         $a0, 0x10($s0)
    /* 8A0B0 800998B0 0800058E */  lw         $a1, 0x8($s0)
    /* 8A0B4 800998B4 980B868F */  lw         $a2, %gp_rel(CopSpeak_gBuffer)($gp)
    /* 8A0B8 800998B8 0C00078E */  lw         $a3, 0xC($s0)
    /* 8A0BC 800998BC 3BB1030C */  jal        FILE_read
    /* 8A0C0 800998C0 2130C200 */   addu      $a2, $a2, $v0
    /* 8A0C4 800998C4 140002AE */  sw         $v0, 0x14($s0)
    /* 8A0C8 800998C8 340B8293 */  lbu        $v0, %gp_rel(CopSpeak_gHandleCount)($gp)
    /* 8A0CC 800998CC 1400048E */  lw         $a0, 0x14($s0)
    /* 8A0D0 800998D0 01004224 */  addiu      $v0, $v0, 0x1
    /* 8A0D4 800998D4 340B82A3 */  sb         $v0, %gp_rel(CopSpeak_gHandleCount)($gp)
    /* 8A0D8 800998D8 87AF030C */  jal        FILE_operror
    /* 8A0DC 800998DC 00000000 */   nop
    /* 8A0E0 800998E0 78660208 */  j          .L800999E0
    /* 8A0E4 800998E4 00000000 */   nop
  .L800998E8:
    /* 8A0E8 800998E8 1E000482 */  lb         $a0, 0x1E($s0)
    /* 8A0EC 800998EC 00000000 */  nop
    /* 8A0F0 800998F0 25008004 */  bltz       $a0, .L80099988
    /* 8A0F4 800998F4 494C023C */   lui       $v0, (0x4C494146 >> 16)
    /* 8A0F8 800998F8 1D000292 */  lbu        $v0, 0x1D($s0)
    /* 8A0FC 800998FC 00000000 */  nop
    /* 8A100 80099900 05004014 */  bnez       $v0, .L80099918
    /* 8A104 80099904 00000000 */   nop
    /* 8A108 80099908 1800028E */  lw         $v0, 0x18($s0)
    /* 8A10C 8009990C 00000000 */  nop
    /* 8A110 80099910 0E004004 */  bltz       $v0, .L8009994C
    /* 8A114 80099914 01000624 */   addiu     $a2, $zero, 0x1
  .L80099918:
    /* 8A118 80099918 1800058E */  lw         $a1, 0x18($s0)
    /* 8A11C 8009991C 40DA010C */  jal        AudioCmn_GetAsyncSfx__Fiib
    /* 8A120 80099920 01000624 */   addiu     $a2, $zero, 0x1
    /* 8A124 80099924 FFFF0324 */  addiu      $v1, $zero, -0x1
    /* 8A128 80099928 17004314 */  bne        $v0, $v1, .L80099988
    /* 8A12C 8009992C 494C023C */   lui       $v0, (0x4C494146 >> 16)
    /* 8A130 80099930 1E000482 */  lb         $a0, 0x1E($s0)
    /* 8A134 80099934 1800058E */  lw         $a1, 0x18($s0)
    /* 8A138 80099938 980B828F */  lw         $v0, %gp_rel(CopSpeak_gBuffer)($gp)
    /* 8A13C 8009993C 0400068E */  lw         $a2, 0x4($s0)
    /* 8A140 80099940 0C00078E */  lw         $a3, 0xC($s0)
    /* 8A144 80099944 5F660208 */  j          .L8009997C
    /* 8A148 80099948 00000000 */   nop
  .L8009994C:
    /* 8A14C 8009994C 0800058E */  lw         $a1, 0x8($s0)
    /* 8A150 80099950 40DA010C */  jal        AudioCmn_GetAsyncSfx__Fiib
    /* 8A154 80099954 0040A524 */   addiu     $a1, $a1, 0x4000
    /* 8A158 80099958 FFFF0324 */  addiu      $v1, $zero, -0x1
    /* 8A15C 8009995C 0A004314 */  bne        $v0, $v1, .L80099988
    /* 8A160 80099960 494C023C */   lui       $v0, (0x4C494146 >> 16)
    /* 8A164 80099964 1E000482 */  lb         $a0, 0x1E($s0)
    /* 8A168 80099968 0C00078E */  lw         $a3, 0xC($s0)
    /* 8A16C 8009996C 0800058E */  lw         $a1, 0x8($s0)
    /* 8A170 80099970 980B828F */  lw         $v0, %gp_rel(CopSpeak_gBuffer)($gp)
    /* 8A174 80099974 0400068E */  lw         $a2, 0x4($s0)
    /* 8A178 80099978 0040A524 */  addiu      $a1, $a1, 0x4000
  .L8009997C:
    /* 8A17C 8009997C D7D9010C */  jal        AudioCmn_LoadAsyncSfx__FiiPvi
    /* 8A180 80099980 21304600 */   addu      $a2, $v0, $a2
    /* 8A184 80099984 494C023C */  lui        $v0, (0x4C494146 >> 16)
  .L80099988:
    /* 8A188 80099988 46414234 */  ori        $v0, $v0, (0x4C494146 & 0xFFFF)
    /* 8A18C 8009998C 000022AE */  sw         $v0, 0x0($s1)
    /* 8A190 80099990 C765020C */  jal        CopSpeak_Free__FP17CopSpeak_tRequest
    /* 8A194 80099994 21200002 */   addu      $a0, $s0, $zero
    /* 8A198 80099998 78660208 */  j          .L800999E0
    /* 8A19C 8009999C 00000000 */   nop
  .L800999A0:
    /* 8A1A0 800999A0 1D000292 */  lbu        $v0, 0x1D($s0)
    /* 8A1A4 800999A4 00000000 */  nop
    /* 8A1A8 800999A8 09004014 */  bnez       $v0, .L800999D0
    /* 8A1AC 800999AC 21300000 */   addu      $a2, $zero, $zero
    /* 8A1B0 800999B0 1800028E */  lw         $v0, 0x18($s0)
    /* 8A1B4 800999B4 00000000 */  nop
    /* 8A1B8 800999B8 09004004 */  bltz       $v0, .L800999E0
    /* 8A1BC 800999BC 00000000 */   nop
    /* 8A1C0 800999C0 1E000282 */  lb         $v0, 0x1E($s0)
    /* 8A1C4 800999C4 00000000 */  nop
    /* 8A1C8 800999C8 05004004 */  bltz       $v0, .L800999E0
    /* 8A1CC 800999CC 00000000 */   nop
  .L800999D0:
    /* 8A1D0 800999D0 1E000482 */  lb         $a0, 0x1E($s0)
    /* 8A1D4 800999D4 1800058E */  lw         $a1, 0x18($s0)
    /* 8A1D8 800999D8 D7D9010C */  jal        AudioCmn_LoadAsyncSfx__FiiPvi
    /* 8A1DC 800999DC 2138C000 */   addu      $a3, $a2, $zero
  .L800999E0:
    /* 8A1E0 800999E0 08004012 */  beqz       $s2, .L80099A04
    /* 8A1E4 800999E4 00000000 */   nop
    /* 8A1E8 800999E8 900B848F */  lw         $a0, %gp_rel(CopSpeak_gQueueReady)($gp)
    /* 8A1EC 800999EC 00000000 */  nop
    /* 8A1F0 800999F0 3F008228 */  slti       $v0, $a0, 0x3F
    /* 8A1F4 800999F4 02004010 */  beqz       $v0, .L80099A00
    /* 8A1F8 800999F8 21180000 */   addu      $v1, $zero, $zero
    /* 8A1FC 800999FC 01008324 */  addiu      $v1, $a0, 0x1
  .L80099A00:
    /* 8A200 80099A00 900B83AF */  sw         $v1, %gp_rel(CopSpeak_gQueueReady)($gp)
  .L80099A04:
    /* 8A204 80099A04 2400BF8F */  lw         $ra, 0x24($sp)
    /* 8A208 80099A08 2000B28F */  lw         $s2, 0x20($sp)
    /* 8A20C 80099A0C 1C00B18F */  lw         $s1, 0x1C($sp)
    /* 8A210 80099A10 1800B08F */  lw         $s0, 0x18($sp)
    /* 8A214 80099A14 0800E003 */  jr         $ra
    /* 8A218 80099A18 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel CopSpeak_ReadyNextRequest__Fv
