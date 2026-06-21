.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SetPlayList__Fi, 0xEC

glabel SetPlayList__Fi
    /* 1C074 8002B874 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 1C078 8002B878 1000B0AF */  sw         $s0, 0x10($sp)
    /* 1C07C 8002B87C 1400BFAF */  sw         $ra, 0x14($sp)
    /* 1C080 8002B880 63EB010C */  jal        AudioMus_SysCleanUp__Fv
    /* 1C084 8002B884 21808000 */   addu      $s0, $a0, $zero
    /* 1C088 8002B888 00C00434 */  ori        $a0, $zero, 0xC000
    /* 1C08C 8002B88C 0100053C */  lui        $a1, (0x18000 >> 16)
    /* 1C090 8002B890 0080A534 */  ori        $a1, $a1, (0x18000 & 0xFFFF)
    /* 1C094 8002B894 0180063C */  lui        $a2, %hi(D_800114B0)
    /* 1C098 8002B898 06EB010C */  jal        AudioMus_SysStartUp__FiiPc
    /* 1C09C 8002B89C B014C624 */   addiu     $a2, $a2, %lo(D_800114B0)
    /* 1C0A0 8002B8A0 0180043C */  lui        $a0, %hi(D_800114B8)
    /* 1C0A4 8002B8A4 B8148424 */  addiu      $a0, $a0, %lo(D_800114B8)
    /* 1C0A8 8002B8A8 20EA010C */  jal        AudioMus_GetSongList__FPci
    /* 1C0AC 8002B8AC 21280000 */   addu      $a1, $zero, $zero
    /* 1C0B0 8002B8B0 1B000016 */  bnez       $s0, .L8002B920
    /* 1C0B4 8002B8B4 21204000 */   addu      $a0, $v0, $zero
    /* 1C0B8 8002B8B8 27000324 */  addiu      $v1, $zero, 0x27
    /* 1C0BC 8002B8BC 1180023C */  lui        $v0, %hi(frontEnd)
    /* 1C0C0 8002B8C0 00464224 */  addiu      $v0, $v0, %lo(frontEnd)
    /* 1C0C4 8002B8C4 9C004224 */  addiu      $v0, $v0, 0x9C
  .L8002B8C8:
    /* 1C0C8 8002B8C8 9C0340AC */  sw         $zero, 0x39C($v0)
    /* 1C0CC 8002B8CC FFFF6324 */  addiu      $v1, $v1, -0x1
    /* 1C0D0 8002B8D0 FDFF6104 */  bgez       $v1, .L8002B8C8
    /* 1C0D4 8002B8D4 FCFF4224 */   addiu     $v0, $v0, -0x4
    /* 1C0D8 8002B8D8 0000828C */  lw         $v0, 0x0($a0)
    /* 1C0DC 8002B8DC 00000000 */  nop
    /* 1C0E0 8002B8E0 0F004018 */  blez       $v0, .L8002B920
    /* 1C0E4 8002B8E4 21180000 */   addu      $v1, $zero, $zero
    /* 1C0E8 8002B8E8 1180023C */  lui        $v0, %hi(frontEnd)
    /* 1C0EC 8002B8EC 00464724 */  addiu      $a3, $v0, %lo(frontEnd)
    /* 1C0F0 8002B8F0 01000624 */  addiu      $a2, $zero, 0x1
    /* 1C0F4 8002B8F4 21288000 */  addu       $a1, $a0, $zero
  .L8002B8F8:
    /* 1C0F8 8002B8F8 2400A28C */  lw         $v0, 0x24($a1)
    /* 1C0FC 8002B8FC 00000000 */  nop
    /* 1C100 8002B900 80100200 */  sll        $v0, $v0, 2
    /* 1C104 8002B904 21104700 */  addu       $v0, $v0, $a3
    /* 1C108 8002B908 9C0346AC */  sw         $a2, 0x39C($v0)
    /* 1C10C 8002B90C 0000828C */  lw         $v0, 0x0($a0)
    /* 1C110 8002B910 01006324 */  addiu      $v1, $v1, 0x1
    /* 1C114 8002B914 2A106200 */  slt        $v0, $v1, $v0
    /* 1C118 8002B918 F7FF4014 */  bnez       $v0, .L8002B8F8
    /* 1C11C 8002B91C 4000A524 */   addiu     $a1, $a1, 0x40
  .L8002B920:
    /* 1C120 8002B920 1180023C */  lui        $v0, %hi(D_80114A44)
    /* 1C124 8002B924 01000324 */  addiu      $v1, $zero, 0x1
    /* 1C128 8002B928 5095030C */  jal        purgememadr
    /* 1C12C 8002B92C 444A43AC */   sw        $v1, %lo(D_80114A44)($v0)
    /* 1C130 8002B930 63EB010C */  jal        AudioMus_SysCleanUp__Fv
    /* 1C134 8002B934 00000000 */   nop
    /* 1C138 8002B938 00D80434 */  ori        $a0, $zero, 0xD800
    /* 1C13C 8002B93C 0100053C */  lui        $a1, (0x18000 >> 16)
    /* 1C140 8002B940 0080A534 */  ori        $a1, $a1, (0x18000 & 0xFFFF)
    /* 1C144 8002B944 0180063C */  lui        $a2, %hi(D_800114C0)
    /* 1C148 8002B948 06EB010C */  jal        AudioMus_SysStartUp__FiiPc
    /* 1C14C 8002B94C C014C624 */   addiu     $a2, $a2, %lo(D_800114C0)
    /* 1C150 8002B950 1400BF8F */  lw         $ra, 0x14($sp)
    /* 1C154 8002B954 1000B08F */  lw         $s0, 0x10($sp)
    /* 1C158 8002B958 0800E003 */  jr         $ra
    /* 1C15C 8002B95C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel SetPlayList__Fi
