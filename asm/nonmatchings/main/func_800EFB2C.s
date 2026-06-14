.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_800EFB2C, 0x144

glabel func_800EFB2C
    /* E032C 800EFB2C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* E0330 800EFB30 1800BFAF */  sw         $ra, 0x18($sp)
    /* E0334 800EFB34 C7C8030C */  jal        VSync
    /* E0338 800EFB38 FFFF0424 */   addiu     $a0, $zero, -0x1
    /* E033C 800EFB3C 1280033C */  lui        $v1, %hi(D_801237D8)
    /* E0340 800EFB40 D837638C */  lw         $v1, %lo(D_801237D8)($v1)
    /* E0344 800EFB44 00000000 */  nop
    /* E0348 800EFB48 2A186200 */  slt        $v1, $v1, $v0
    /* E034C 800EFB4C 0C006014 */  bnez       $v1, .L800EFB80
    /* E0350 800EFB50 00000000 */   nop
    /* E0354 800EFB54 1280033C */  lui        $v1, %hi(D_801237DC)
    /* E0358 800EFB58 DC376324 */  addiu      $v1, $v1, %lo(D_801237DC)
    /* E035C 800EFB5C 0000628C */  lw         $v0, 0x0($v1)
    /* E0360 800EFB60 00000000 */  nop
    /* E0364 800EFB64 21204000 */  addu       $a0, $v0, $zero
    /* E0368 800EFB68 01004224 */  addiu      $v0, $v0, 0x1
    /* E036C 800EFB6C 000062AC */  sw         $v0, 0x0($v1)
    /* E0370 800EFB70 0F00023C */  lui        $v0, (0xF0000 >> 16)
    /* E0374 800EFB74 2A104400 */  slt        $v0, $v0, $a0
    /* E0378 800EFB78 38004010 */  beqz       $v0, .L800EFC5C
    /* E037C 800EFB7C 00000000 */   nop
  .L800EFB80:
    /* E0380 800EFB80 1280063C */  lui        $a2, %hi(D_801237A4)
    /* E0384 800EFB84 A437C68C */  lw         $a2, %lo(D_801237A4)($a2)
    /* E0388 800EFB88 0580043C */  lui        $a0, %hi(D_80056EB8)
    /* E038C 800EFB8C B86E8424 */  addiu      $a0, $a0, %lo(D_80056EB8)
    /* E0390 800EFB90 0000C28C */  lw         $v0, 0x0($a2)
    /* E0394 800EFB94 1280053C */  lui        $a1, %hi(_qin)
    /* E0398 800EFB98 C437A58C */  lw         $a1, %lo(_qin)($a1)
    /* E039C 800EFB9C 1280023C */  lui        $v0, %hi(D_801237A8)
    /* E03A0 800EFBA0 A837428C */  lw         $v0, %lo(D_801237A8)($v0)
    /* E03A4 800EFBA4 1280033C */  lui        $v1, %hi(_qout)
    /* E03A8 800EFBA8 C837638C */  lw         $v1, %lo(_qout)($v1)
    /* E03AC 800EFBAC 0000428C */  lw         $v0, 0x0($v0)
    /* E03B0 800EFBB0 2328A300 */  subu       $a1, $a1, $v1
    /* E03B4 800EFBB4 1000A2AF */  sw         $v0, 0x10($sp)
    /* E03B8 800EFBB8 1280023C */  lui        $v0, %hi(D_801237B0)
    /* E03BC 800EFBBC B037428C */  lw         $v0, %lo(D_801237B0)($v0)
    /* E03C0 800EFBC0 0000C68C */  lw         $a2, 0x0($a2)
    /* E03C4 800EFBC4 0000478C */  lw         $a3, 0x0($v0)
    /* E03C8 800EFBC8 2B0A040C */  jal        printf
    /* E03CC 800EFBCC 3F00A530 */   andi      $a1, $a1, 0x3F
    /* E03D0 800EFBD0 54CA030C */  jal        SetIntrMask
    /* E03D4 800EFBD4 21200000 */   addu      $a0, $zero, $zero
    /* E03D8 800EFBD8 1280013C */  lui        $at, %hi(_qout)
    /* E03DC 800EFBDC C83720AC */  sw         $zero, %lo(_qout)($at)
    /* E03E0 800EFBE0 1280033C */  lui        $v1, %hi(_qout)
    /* E03E4 800EFBE4 C837638C */  lw         $v1, %lo(_qout)($v1)
    /* E03E8 800EFBE8 1280013C */  lui        $at, %hi(D_801237D4)
    /* E03EC 800EFBEC D43722AC */  sw         $v0, %lo(D_801237D4)($at)
    /* E03F0 800EFBF0 1280013C */  lui        $at, %hi(_qin)
    /* E03F4 800EFBF4 C43723AC */  sw         $v1, %lo(_qin)($at)
    /* E03F8 800EFBF8 1280033C */  lui        $v1, %hi(D_801237B0)
    /* E03FC 800EFBFC B037638C */  lw         $v1, %lo(D_801237B0)($v1)
    /* E0400 800EFC00 01040224 */  addiu      $v0, $zero, 0x401
    /* E0404 800EFC04 000062AC */  sw         $v0, 0x0($v1)
    /* E0408 800EFC08 1280033C */  lui        $v1, %hi(D_801237C0)
    /* E040C 800EFC0C C037638C */  lw         $v1, %lo(D_801237C0)($v1)
    /* E0410 800EFC10 00000000 */  nop
    /* E0414 800EFC14 0000628C */  lw         $v0, 0x0($v1)
    /* E0418 800EFC18 00000000 */  nop
    /* E041C 800EFC1C 00084234 */  ori        $v0, $v0, 0x800
    /* E0420 800EFC20 000062AC */  sw         $v0, 0x0($v1)
    /* E0424 800EFC24 1280033C */  lui        $v1, %hi(D_801237A4)
    /* E0428 800EFC28 A437638C */  lw         $v1, %lo(D_801237A4)($v1)
    /* E042C 800EFC2C 0002023C */  lui        $v0, (0x2000000 >> 16)
    /* E0430 800EFC30 000062AC */  sw         $v0, 0x0($v1)
    /* E0434 800EFC34 1280033C */  lui        $v1, %hi(D_801237A4)
    /* E0438 800EFC38 A437638C */  lw         $v1, %lo(D_801237A4)($v1)
    /* E043C 800EFC3C 0001023C */  lui        $v0, (0x1000000 >> 16)
    /* E0440 800EFC40 000062AC */  sw         $v0, 0x0($v1)
    /* E0444 800EFC44 1280043C */  lui        $a0, %hi(D_801237D4)
    /* E0448 800EFC48 D437848C */  lw         $a0, %lo(D_801237D4)($a0)
    /* E044C 800EFC4C 54CA030C */  jal        SetIntrMask
    /* E0450 800EFC50 00000000 */   nop
    /* E0454 800EFC54 18BF0308 */  j          .L800EFC60
    /* E0458 800EFC58 FFFF0224 */   addiu     $v0, $zero, -0x1
  .L800EFC5C:
    /* E045C 800EFC5C 21100000 */  addu       $v0, $zero, $zero
  .L800EFC60:
    /* E0460 800EFC60 1800BF8F */  lw         $ra, 0x18($sp)
    /* E0464 800EFC64 2000BD27 */  addiu      $sp, $sp, 0x20
    /* E0468 800EFC68 0800E003 */  jr         $ra
    /* E046C 800EFC6C 00000000 */   nop
endlabel func_800EFB2C
