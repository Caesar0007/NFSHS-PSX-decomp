.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CopSpeak_Cancel__Fv, 0xA0

glabel CopSpeak_Cancel__Fv
    /* 8A21C 80099A1C 900B838F */  lw         $v1, %gp_rel(CopSpeak_gQueueReady)($gp)
    /* 8A220 80099A20 8C0B828F */  lw         $v0, %gp_rel(CopSpeak_gQueueLoad)($gp)
    /* 8A224 80099A24 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 8A228 80099A28 1400BFAF */  sw         $ra, 0x14($sp)
    /* 8A22C 80099A2C 0A006210 */  beq        $v1, $v0, .L80099A58
    /* 8A230 80099A30 1000B0AF */   sw        $s0, 0x10($sp)
  .L80099A34:
    /* 8A234 80099A34 EB65020C */  jal        CopSpeak_ReadyNextRequest__Fv
    /* 8A238 80099A38 00000000 */   nop
    /* 8A23C 80099A3C 019B030C */  jal        systemtask
    /* 8A240 80099A40 21200000 */   addu      $a0, $zero, $zero
    /* 8A244 80099A44 900B838F */  lw         $v1, %gp_rel(CopSpeak_gQueueReady)($gp)
    /* 8A248 80099A48 8C0B828F */  lw         $v0, %gp_rel(CopSpeak_gQueueLoad)($gp)
    /* 8A24C 80099A4C 00000000 */  nop
    /* 8A250 80099A50 F8FF6214 */  bne        $v1, $v0, .L80099A34
    /* 8A254 80099A54 00000000 */   nop
  .L80099A58:
    /* 8A258 80099A58 840B848F */  lw         $a0, %gp_rel(CopSpeak_gSpchHandle)($gp)
    /* 8A25C 80099A5C FFFF1024 */  addiu      $s0, $zero, -0x1
    /* 8A260 80099A60 03009010 */  beq        $a0, $s0, .L80099A70
    /* 8A264 80099A64 00000000 */   nop
    /* 8A268 80099A68 A09F030C */  jal        SNDstop
    /* 8A26C 80099A6C 00000000 */   nop
  .L80099A70:
    /* 8A270 80099A70 6265020C */  jal        CopSpeak_RadioStaticSquelch__Fv
    /* 8A274 80099A74 00000000 */   nop
    /* 8A278 80099A78 1180043C */  lui        $a0, %hi(CopSpeak_gCurrent)
    /* 8A27C 80099A7C 840B90AF */  sw         $s0, %gp_rel(CopSpeak_gSpchHandle)($gp)
    /* 8A280 80099A80 7C65020C */  jal        CopSpeak_InitRequest__FP17CopSpeak_tRequest
    /* 8A284 80099A84 041F8424 */   addiu     $a0, $a0, %lo(CopSpeak_gCurrent)
    /* 8A288 80099A88 1400BF8F */  lw         $ra, 0x14($sp)
    /* 8A28C 80099A8C 1000B08F */  lw         $s0, 0x10($sp)
    /* 8A290 80099A90 FC7F0224 */  addiu      $v0, $zero, 0x7FFC
    /* 8A294 80099A94 7C0B80AF */  sw         $zero, %gp_rel(CopSpeak_gQueueHead)($gp)
    /* 8A298 80099A98 8C0B80AF */  sw         $zero, %gp_rel(CopSpeak_gQueueLoad)($gp)
    /* 8A29C 80099A9C 900B80AF */  sw         $zero, %gp_rel(CopSpeak_gQueueReady)($gp)
    /* 8A2A0 80099AA0 800B80AF */  sw         $zero, %gp_rel(CopSpeak_gQueuePlay)($gp)
    /* 8A2A4 80099AA4 9C0B80A7 */  sh         $zero, %gp_rel(CopSpeak_gBufferLow)($gp)
    /* 8A2A8 80099AA8 A20B80A7 */  sh         $zero, %gp_rel(CopSpeak_gBufferHigh)($gp)
    /* 8A2AC 80099AAC 9E0B80A7 */  sh         $zero, %gp_rel(CopSpeak_gBufferStart)($gp)
    /* 8A2B0 80099AB0 A00B82A7 */  sh         $v0, %gp_rel(CopSpeak_gBufferEnd)($gp)
    /* 8A2B4 80099AB4 0800E003 */  jr         $ra
    /* 8A2B8 80099AB8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel CopSpeak_Cancel__Fv
