.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CopSpeak_InitVars__Fv, 0x7C

glabel CopSpeak_InitVars__Fv
    /* 8A370 80099B70 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 8A374 80099B74 1000BFAF */  sw         $ra, 0x10($sp)
    /* 8A378 80099B78 21200000 */  addu       $a0, $zero, $zero
    /* 8A37C 80099B7C 1180023C */  lui        $v0, %hi(Copspeak_gBank)
    /* 8A380 80099B80 A41E4324 */  addiu      $v1, $v0, %lo(Copspeak_gBank)
  .L80099B84:
    /* 8A384 80099B84 040060AC */  sw         $zero, 0x4($v1)
    /* 8A388 80099B88 080060AC */  sw         $zero, 0x8($v1)
    /* 8A38C 80099B8C 01008424 */  addiu      $a0, $a0, 0x1
    /* 8A390 80099B90 04008228 */  slti       $v0, $a0, 0x4
    /* 8A394 80099B94 FBFF4014 */  bnez       $v0, .L80099B84
    /* 8A398 80099B98 10006324 */   addiu     $v1, $v1, 0x10
    /* 8A39C 80099B9C FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 8A3A0 80099BA0 840B82AF */  sw         $v0, %gp_rel(CopSpeak_gSpchHandle)($gp)
    /* 8A3A4 80099BA4 FC7F0224 */  addiu      $v0, $zero, 0x7FFC
    /* 8A3A8 80099BA8 1180043C */  lui        $a0, %hi(CopSpeak_gCurrent)
    /* 8A3AC 80099BAC 980B80AF */  sw         $zero, %gp_rel(CopSpeak_gBuffer)($gp)
    /* 8A3B0 80099BB0 7C0B80AF */  sw         $zero, %gp_rel(CopSpeak_gQueueHead)($gp)
    /* 8A3B4 80099BB4 8C0B80AF */  sw         $zero, %gp_rel(CopSpeak_gQueueLoad)($gp)
    /* 8A3B8 80099BB8 900B80AF */  sw         $zero, %gp_rel(CopSpeak_gQueueReady)($gp)
    /* 8A3BC 80099BBC 800B80AF */  sw         $zero, %gp_rel(CopSpeak_gQueuePlay)($gp)
    /* 8A3C0 80099BC0 940B80AF */  sw         $zero, %gp_rel(CopSpeak_gWrongWay)($gp)
    /* 8A3C4 80099BC4 9C0B80A7 */  sh         $zero, %gp_rel(CopSpeak_gBufferLow)($gp)
    /* 8A3C8 80099BC8 A20B80A7 */  sh         $zero, %gp_rel(CopSpeak_gBufferHigh)($gp)
    /* 8A3CC 80099BCC 9E0B80A7 */  sh         $zero, %gp_rel(CopSpeak_gBufferStart)($gp)
    /* 8A3D0 80099BD0 A00B82A7 */  sh         $v0, %gp_rel(CopSpeak_gBufferEnd)($gp)
    /* 8A3D4 80099BD4 7C65020C */  jal        CopSpeak_InitRequest__FP17CopSpeak_tRequest
    /* 8A3D8 80099BD8 041F8424 */   addiu     $a0, $a0, %lo(CopSpeak_gCurrent)
    /* 8A3DC 80099BDC 1000BF8F */  lw         $ra, 0x10($sp)
    /* 8A3E0 80099BE0 00000000 */  nop
    /* 8A3E4 80099BE4 0800E003 */  jr         $ra
    /* 8A3E8 80099BE8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel CopSpeak_InitVars__Fv
