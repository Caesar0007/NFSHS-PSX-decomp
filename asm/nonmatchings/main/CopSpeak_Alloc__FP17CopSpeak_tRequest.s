.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CopSpeak_Alloc__FP17CopSpeak_tRequest, 0x98

glabel CopSpeak_Alloc__FP17CopSpeak_tRequest
    /* 89E84 80099684 900B838F */  lw         $v1, %gp_rel(CopSpeak_gQueueReady)($gp)
    /* 89E88 80099688 8C0B828F */  lw         $v0, %gp_rel(CopSpeak_gQueueLoad)($gp)
    /* 89E8C 8009968C 00000000 */  nop
    /* 89E90 80099690 05006214 */  bne        $v1, $v0, .L800996A8
    /* 89E94 80099694 FC7F0224 */   addiu     $v0, $zero, 0x7FFC
    /* 89E98 80099698 9C0B80A7 */  sh         $zero, %gp_rel(CopSpeak_gBufferLow)($gp)
    /* 89E9C 8009969C A20B80A7 */  sh         $zero, %gp_rel(CopSpeak_gBufferHigh)($gp)
    /* 89EA0 800996A0 9E0B80A7 */  sh         $zero, %gp_rel(CopSpeak_gBufferStart)($gp)
    /* 89EA4 800996A4 A00B82A7 */  sh         $v0, %gp_rel(CopSpeak_gBufferEnd)($gp)
  .L800996A8:
    /* 89EA8 800996A8 A00B8287 */  lh         $v0, %gp_rel(CopSpeak_gBufferEnd)($gp)
    /* 89EAC 800996AC 9E0B8587 */  lh         $a1, %gp_rel(CopSpeak_gBufferStart)($gp)
    /* 89EB0 800996B0 0C00868C */  lw         $a2, 0xC($a0)
    /* 89EB4 800996B4 9E0B8397 */  lhu        $v1, %gp_rel(CopSpeak_gBufferStart)($gp)
    /* 89EB8 800996B8 23104500 */  subu       $v0, $v0, $a1
    /* 89EBC 800996BC 2A104600 */  slt        $v0, $v0, $a2
    /* 89EC0 800996C0 07004014 */  bnez       $v0, .L800996E0
    /* 89EC4 800996C4 00000000 */   nop
    /* 89EC8 800996C8 0C008294 */  lhu        $v0, 0xC($a0)
    /* 89ECC 800996CC 040085AC */  sw         $a1, 0x4($a0)
    /* 89ED0 800996D0 21106200 */  addu       $v0, $v1, $v0
    /* 89ED4 800996D4 9E0B82A7 */  sh         $v0, %gp_rel(CopSpeak_gBufferStart)($gp)
    /* 89ED8 800996D8 0800E003 */  jr         $ra
    /* 89EDC 800996DC 00000000 */   nop
  .L800996E0:
    /* 89EE0 800996E0 9C0B8287 */  lh         $v0, %gp_rel(CopSpeak_gBufferLow)($gp)
    /* 89EE4 800996E4 9C0B8597 */  lhu        $a1, %gp_rel(CopSpeak_gBufferLow)($gp)
    /* 89EE8 800996E8 2A104600 */  slt        $v0, $v0, $a2
    /* 89EEC 800996EC 09004014 */  bnez       $v0, .L80099714
    /* 89EF0 800996F0 FFFF0224 */   addiu     $v0, $zero, -0x1
    /* 89EF4 800996F4 0C008294 */  lhu        $v0, 0xC($a0)
    /* 89EF8 800996F8 A20B83A7 */  sh         $v1, %gp_rel(CopSpeak_gBufferHigh)($gp)
    /* 89EFC 800996FC A00B85A7 */  sh         $a1, %gp_rel(CopSpeak_gBufferEnd)($gp)
    /* 89F00 80099700 9C0B80A7 */  sh         $zero, %gp_rel(CopSpeak_gBufferLow)($gp)
    /* 89F04 80099704 040080AC */  sw         $zero, 0x4($a0)
    /* 89F08 80099708 9E0B82A7 */  sh         $v0, %gp_rel(CopSpeak_gBufferStart)($gp)
    /* 89F0C 8009970C 0800E003 */  jr         $ra
    /* 89F10 80099710 00000000 */   nop
  .L80099714:
    /* 89F14 80099714 0800E003 */  jr         $ra
    /* 89F18 80099718 040082AC */   sw        $v0, 0x4($a0)
endlabel CopSpeak_Alloc__FP17CopSpeak_tRequest
