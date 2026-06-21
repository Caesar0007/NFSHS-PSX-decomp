.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FeAudio_InitCommentary__Fii, 0xA0

glabel FeAudio_InitCommentary__Fii
    /* 68D8 800160D8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 68DC 800160DC 1000B0AF */  sw         $s0, 0x10($sp)
    /* 68E0 800160E0 0580103C */  lui        $s0, %hi(currentSpeechViv)
    /* 68E4 800160E4 10151026 */  addiu      $s0, $s0, %lo(currentSpeechViv)
    /* 68E8 800160E8 80380400 */  sll        $a3, $a0, 2
    /* 68EC 800160EC 21200002 */  addu       $a0, $s0, $zero
    /* 68F0 800160F0 0580053C */  lui        $a1, %hi(ginfo)
    /* 68F4 800160F4 E814A224 */  addiu      $v0, $a1, %lo(ginfo)
    /* 68F8 800160F8 0180033C */  lui        $v1, %hi(D_8001016C)
    /* 68FC 800160FC 1400BFAF */  sw         $ra, 0x14($sp)
    /* 6900 80016100 080040AC */  sw         $zero, 0x8($v0)
    /* 6904 80016104 6C01668C */  lw         $a2, %lo(D_8001016C)($v1)
    /* 6908 80016108 01000324 */  addiu      $v1, $zero, 0x1
    /* 690C 8001610C 040043AC */  sw         $v1, 0x4($v0)
    /* 6910 80016110 1180033C */  lui        $v1, %hi(D_80116500)
    /* 6914 80016114 0C0040AC */  sw         $zero, 0xC($v0)
    /* 6918 80016118 100040A0 */  sb         $zero, 0x10($v0)
    /* 691C 8001611C 110040A0 */  sb         $zero, 0x11($v0)
    /* 6920 80016120 120040A0 */  sb         $zero, 0x12($v0)
    /* 6924 80016124 140040AC */  sw         $zero, 0x14($v0)
    /* 6928 80016128 180040AC */  sw         $zero, 0x18($v0)
    /* 692C 8001612C 1C0040AC */  sw         $zero, 0x1C($v0)
    /* 6930 80016130 200040AC */  sw         $zero, 0x20($v0)
    /* 6934 80016134 0580023C */  lui        $v0, %hi(allLanguages)
    /* 6938 80016138 D0144224 */  addiu      $v0, $v0, %lo(allLanguages)
    /* 693C 8001613C 2138E200 */  addu       $a3, $a3, $v0
    /* 6940 80016140 E814A6AC */  sw         $a2, %lo(ginfo)($a1)
    /* 6944 80016144 0180053C */  lui        $a1, %hi(D_80010170)
    /* 6948 80016148 0065668C */  lw         $a2, %lo(D_80116500)($v1)
    /* 694C 8001614C 0000E78C */  lw         $a3, 0x0($a3)
    /* 6950 80016150 2F91030C */  jal        sprintf
    /* 6954 80016154 7001A524 */   addiu     $a1, $a1, %lo(D_80010170)
    /* 6958 80016158 C957000C */  jal        FeAudio_InitViv__FPc
    /* 695C 8001615C 21200002 */   addu      $a0, $s0, $zero
    /* 6960 80016160 1400BF8F */  lw         $ra, 0x14($sp)
    /* 6964 80016164 1000B08F */  lw         $s0, 0x10($sp)
    /* 6968 80016168 0580033C */  lui        $v1, %hi(speechfileHeader)
    /* 696C 8001616C 0C1562AC */  sw         $v0, %lo(speechfileHeader)($v1)
    /* 6970 80016170 0800E003 */  jr         $ra
    /* 6974 80016174 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel FeAudio_InitCommentary__Fii
