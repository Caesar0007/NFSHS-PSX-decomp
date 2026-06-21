.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __14tFEApplication, 0x224

glabel __14tFEApplication
    /* 37A0 80012FA0 C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* 37A4 80012FA4 2C00B7AF */  sw         $s7, 0x2C($sp)
    /* 37A8 80012FA8 21B88000 */  addu       $s7, $a0, $zero
    /* 37AC 80012FAC 1000B0AF */  sw         $s0, 0x10($sp)
    /* 37B0 80012FB0 2C00F026 */  addiu      $s0, $s7, 0x2C
    /* 37B4 80012FB4 21200002 */  addu       $a0, $s0, $zero
    /* 37B8 80012FB8 3000BFAF */  sw         $ra, 0x30($sp)
    /* 37BC 80012FBC 2800B6AF */  sw         $s6, 0x28($sp)
    /* 37C0 80012FC0 2400B5AF */  sw         $s5, 0x24($sp)
    /* 37C4 80012FC4 2000B4AF */  sw         $s4, 0x20($sp)
    /* 37C8 80012FC8 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 37CC 80012FCC 1800B2AF */  sw         $s2, 0x18($sp)
    /* 37D0 80012FD0 0898000C */  jal        __7tScreen
    /* 37D4 80012FD4 1400B1AF */   sw        $s1, 0x14($sp)
    /* 37D8 80012FD8 5801F126 */  addiu      $s1, $s7, 0x158
    /* 37DC 80012FDC 21202002 */  addu       $a0, $s1, $zero
    /* 37E0 80012FE0 0180123C */  lui        $s2, %hi(_vt_11tDialogBase)
    /* 37E4 80012FE4 B0055226 */  addiu      $s2, $s2, %lo(_vt_11tDialogBase)
    /* 37E8 80012FE8 20011524 */  addiu      $s5, $zero, 0x120
    /* 37EC 80012FEC FFFF1424 */  addiu      $s4, $zero, -0x1
    /* 37F0 80012FF0 0180133C */  lui        $s3, %hi(_vt_20tDialogMessageString)
    /* 37F4 80012FF4 F0047326 */  addiu      $s3, $s3, %lo(_vt_20tDialogMessageString)
    /* 37F8 80012FF8 80001624 */  addiu      $s6, $zero, 0x80
    /* 37FC 80012FFC 600012AE */  sw         $s2, 0x60($s0)
    /* 3800 80013000 700000AE */  sw         $zero, 0x70($s0)
    /* 3804 80013004 6E0000A6 */  sh         $zero, 0x6E($s0)
    /* 3808 80013008 820000A6 */  sh         $zero, 0x82($s0)
    /* 380C 8001300C 7E0000A6 */  sh         $zero, 0x7E($s0)
    /* 3810 80013010 7C0000A6 */  sh         $zero, 0x7C($s0)
    /* 3814 80013014 6C0000A6 */  sh         $zero, 0x6C($s0)
    /* 3818 80013018 6A0000A6 */  sh         $zero, 0x6A($s0)
    /* 381C 8001301C 680000A6 */  sh         $zero, 0x68($s0)
    /* 3820 80013020 660000A6 */  sh         $zero, 0x66($s0)
    /* 3824 80013024 800015A6 */  sh         $s5, 0x80($s0)
    /* 3828 80013028 640014A6 */  sh         $s4, 0x64($s0)
    /* 382C 8001302C 880000A6 */  sh         $zero, 0x88($s0)
    /* 3830 80013030 780000AE */  sw         $zero, 0x78($s0)
    /* 3834 80013034 600013AE */  sw         $s3, 0x60($s0)
    /* 3838 80013038 940000AE */  sw         $zero, 0x94($s0)
    /* 383C 8001303C 840000AE */  sw         $zero, 0x84($s0)
    /* 3840 80013040 780000AE */  sw         $zero, 0x78($s0)
    /* 3844 80013044 0898000C */  jal        __7tScreen
    /* 3848 80013048 8C0016AE */   sw        $s6, 0x8C($s0)
    /* 384C 8001304C 3802F026 */  addiu      $s0, $s7, 0x238
    /* 3850 80013050 21200002 */  addu       $a0, $s0, $zero
    /* 3854 80013054 0180023C */  lui        $v0, %hi(_vt_11tDialogHelp)
    /* 3858 80013058 50054224 */  addiu      $v0, $v0, %lo(_vt_11tDialogHelp)
    /* 385C 8001305C 600032AE */  sw         $s2, 0x60($s1)
    /* 3860 80013060 600022AE */  sw         $v0, 0x60($s1)
    /* 3864 80013064 78050224 */  addiu      $v0, $zero, 0x578
    /* 3868 80013068 700020AE */  sw         $zero, 0x70($s1)
    /* 386C 8001306C 6E0020A6 */  sh         $zero, 0x6E($s1)
    /* 3870 80013070 820020A6 */  sh         $zero, 0x82($s1)
    /* 3874 80013074 7E0020A6 */  sh         $zero, 0x7E($s1)
    /* 3878 80013078 7C0020A6 */  sh         $zero, 0x7C($s1)
    /* 387C 8001307C 6C0020A6 */  sh         $zero, 0x6C($s1)
    /* 3880 80013080 6A0020A6 */  sh         $zero, 0x6A($s1)
    /* 3884 80013084 680020A6 */  sh         $zero, 0x68($s1)
    /* 3888 80013088 660020A6 */  sh         $zero, 0x66($s1)
    /* 388C 8001308C 800035A6 */  sh         $s5, 0x80($s1)
    /* 3890 80013090 640034A6 */  sh         $s4, 0x64($s1)
    /* 3894 80013094 880020A6 */  sh         $zero, 0x88($s1)
    /* 3898 80013098 780020AE */  sw         $zero, 0x78($s1)
    /* 389C 8001309C 900034A6 */  sh         $s4, 0x90($s1)
    /* 38A0 800130A0 0898000C */  jal        __7tScreen
    /* 38A4 800130A4 780022AE */   sw        $v0, 0x78($s1)
    /* 38A8 800130A8 D002F126 */  addiu      $s1, $s7, 0x2D0
    /* 38AC 800130AC 21202002 */  addu       $a0, $s1, $zero
    /* 38B0 800130B0 0180023C */  lui        $v0, %hi(D_80010098)
    /* 38B4 800130B4 98004224 */  addiu      $v0, $v0, %lo(D_80010098)
    /* 38B8 800130B8 600012AE */  sw         $s2, 0x60($s0)
    /* 38BC 800130BC 600013AE */  sw         $s3, 0x60($s0)
    /* 38C0 800130C0 600002AE */  sw         $v0, 0x60($s0)
    /* 38C4 800130C4 80040224 */  addiu      $v0, $zero, 0x480
    /* 38C8 800130C8 700000AE */  sw         $zero, 0x70($s0)
    /* 38CC 800130CC 6E0000A6 */  sh         $zero, 0x6E($s0)
    /* 38D0 800130D0 820000A6 */  sh         $zero, 0x82($s0)
    /* 38D4 800130D4 7E0000A6 */  sh         $zero, 0x7E($s0)
    /* 38D8 800130D8 7C0000A6 */  sh         $zero, 0x7C($s0)
    /* 38DC 800130DC 6C0000A6 */  sh         $zero, 0x6C($s0)
    /* 38E0 800130E0 6A0000A6 */  sh         $zero, 0x6A($s0)
    /* 38E4 800130E4 680000A6 */  sh         $zero, 0x68($s0)
    /* 38E8 800130E8 660000A6 */  sh         $zero, 0x66($s0)
    /* 38EC 800130EC 800015A6 */  sh         $s5, 0x80($s0)
    /* 38F0 800130F0 640014A6 */  sh         $s4, 0x64($s0)
    /* 38F4 800130F4 880000A6 */  sh         $zero, 0x88($s0)
    /* 38F8 800130F8 780000AE */  sw         $zero, 0x78($s0)
    /* 38FC 800130FC 940000AE */  sw         $zero, 0x94($s0)
    /* 3900 80013100 840000AE */  sw         $zero, 0x84($s0)
    /* 3904 80013104 780000AE */  sw         $zero, 0x78($s0)
    /* 3908 80013108 8C0016AE */  sw         $s6, 0x8C($s0)
    /* 390C 8001310C 0898000C */  jal        __7tScreen
    /* 3910 80013110 780002AE */   sw        $v0, 0x78($s0)
    /* 3914 80013114 21200000 */  addu       $a0, $zero, $zero
    /* 3918 80013118 FFFF0524 */  addiu      $a1, $zero, -0x1
    /* 391C 8001311C 2118E002 */  addu       $v1, $s7, $zero
    /* 3920 80013120 0180023C */  lui        $v0, %hi(_vt_21tDialogNoInputMessage)
    /* 3924 80013124 30044224 */  addiu      $v0, $v0, %lo(_vt_21tDialogNoInputMessage)
    /* 3928 80013128 600032AE */  sw         $s2, 0x60($s1)
    /* 392C 8001312C 700020AE */  sw         $zero, 0x70($s1)
    /* 3930 80013130 6E0020A6 */  sh         $zero, 0x6E($s1)
    /* 3934 80013134 820020A6 */  sh         $zero, 0x82($s1)
    /* 3938 80013138 7E0020A6 */  sh         $zero, 0x7E($s1)
    /* 393C 8001313C 7C0020A6 */  sh         $zero, 0x7C($s1)
    /* 3940 80013140 6C0020A6 */  sh         $zero, 0x6C($s1)
    /* 3944 80013144 6A0020A6 */  sh         $zero, 0x6A($s1)
    /* 3948 80013148 680020A6 */  sh         $zero, 0x68($s1)
    /* 394C 8001314C 660020A6 */  sh         $zero, 0x66($s1)
    /* 3950 80013150 800035A6 */  sh         $s5, 0x80($s1)
    /* 3954 80013154 640034A6 */  sh         $s4, 0x64($s1)
    /* 3958 80013158 880020A6 */  sh         $zero, 0x88($s1)
    /* 395C 8001315C 780020AE */  sw         $zero, 0x78($s1)
    /* 3960 80013160 600033AE */  sw         $s3, 0x60($s1)
    /* 3964 80013164 940020AE */  sw         $zero, 0x94($s1)
    /* 3968 80013168 840020AE */  sw         $zero, 0x84($s1)
    /* 396C 8001316C 780020AE */  sw         $zero, 0x78($s1)
    /* 3970 80013170 8C0036AE */  sw         $s6, 0x8C($s1)
    /* 3974 80013174 600022AE */  sw         $v0, 0x60($s1)
  .L80013178:
    /* 3978 80013178 680360AC */  sw         $zero, 0x368($v1)
    /* 397C 8001317C 700360AC */  sw         $zero, 0x370($v1)
    /* 3980 80013180 780365AC */  sw         $a1, 0x378($v1)
    /* 3984 80013184 01008424 */  addiu      $a0, $a0, 0x1
    /* 3988 80013188 02008228 */  slti       $v0, $a0, 0x2
    /* 398C 8001318C FAFF4014 */  bnez       $v0, .L80013178
    /* 3990 80013190 04006324 */   addiu     $v1, $v1, 0x4
    /* 3994 80013194 2110E002 */  addu       $v0, $s7, $zero
    /* 3998 80013198 3000BF8F */  lw         $ra, 0x30($sp)
    /* 399C 8001319C 2C00B78F */  lw         $s7, 0x2C($sp)
    /* 39A0 800131A0 2800B68F */  lw         $s6, 0x28($sp)
    /* 39A4 800131A4 2400B58F */  lw         $s5, 0x24($sp)
    /* 39A8 800131A8 2000B48F */  lw         $s4, 0x20($sp)
    /* 39AC 800131AC 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 39B0 800131B0 1800B28F */  lw         $s2, 0x18($sp)
    /* 39B4 800131B4 1400B18F */  lw         $s1, 0x14($sp)
    /* 39B8 800131B8 1000B08F */  lw         $s0, 0x10($sp)
    /* 39BC 800131BC 0800E003 */  jr         $ra
    /* 39C0 800131C0 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel __14tFEApplication
