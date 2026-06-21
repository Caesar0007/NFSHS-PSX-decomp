.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching UpdateVideoWall__18tScreenTournSelectP12tTourneyInfo, 0xA4

glabel UpdateVideoWall__18tScreenTournSelectP12tTourneyInfo
    /* 30328 8003FB28 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 3032C 8003FB2C 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* 30330 8003FB30 21888000 */  addu       $s1, $a0, $zero
    /* 30334 8003FB34 2000B2AF */  sw         $s2, 0x20($sp)
    /* 30338 8003FB38 2190A000 */  addu       $s2, $a1, $zero
    /* 3033C 8003FB3C 2800BFAF */  sw         $ra, 0x28($sp)
    /* 30340 8003FB40 2400B3AF */  sw         $s3, 0x24($sp)
    /* 30344 8003FB44 1800B0AF */  sw         $s0, 0x18($sp)
    /* 30348 8003FB48 16004392 */  lbu        $v1, 0x16($s2)
    /* 3034C 8003FB4C BA022282 */  lb         $v0, 0x2BA($s1)
    /* 30350 8003FB50 00000000 */  nop
    /* 30354 8003FB54 16006210 */  beq        $v1, $v0, .L8003FBB0
    /* 30358 8003FB58 1180043C */   lui       $a0, %hi(tournamentManager)
    /* 3035C 8003FB5C D84A8424 */  addiu      $a0, $a0, %lo(tournamentManager)
    /* 30360 8003FB60 FFFF1324 */  addiu      $s3, $zero, -0x1
    /* 30364 8003FB64 0580103C */  lui        $s0, %hi(D_80052C90)
    /* 30368 8003FB68 902C1026 */  addiu      $s0, $s0, %lo(D_80052C90)
    /* 3036C 8003FB6C 01000624 */  addiu      $a2, $zero, 0x1
    /* 30370 8003FB70 21380002 */  addu       $a3, $s0, $zero
    /* 30374 8003FB74 D9CE000C */  jal        GetTrophyName__18tTournamentManagerP12tTourneyInfo11tTrophySizePci
    /* 30378 8003FB78 1000B3AF */   sw        $s3, 0x10($sp)
    /* 3037C 8003FB7C 21202002 */  addu       $a0, $s1, $zero
    /* 30380 8003FB80 6E97000C */  jal        AsyncLoadSwapShapeFile__7tScreenPc
    /* 30384 8003FB84 21280002 */   addu      $a1, $s0, $zero
    /* 30388 8003FB88 BC0220AE */  sw         $zero, 0x2BC($s1)
    /* 3038C 8003FB8C 16004292 */  lbu        $v0, 0x16($s2)
    /* 30390 8003FB90 B8022386 */  lh         $v1, 0x2B8($s1)
    /* 30394 8003FB94 00000000 */  nop
    /* 30398 8003FB98 05006004 */  bltz       $v1, .L8003FBB0
    /* 3039C 8003FB9C BA0222A2 */   sb        $v0, 0x2BA($s1)
    /* 303A0 8003FBA0 1480023C */  lui        $v0, %hi(ticks)
    /* 303A4 8003FBA4 ACDC428C */  lw         $v0, %lo(ticks)($v0)
    /* 303A8 8003FBA8 B80233A6 */  sh         $s3, 0x2B8($s1)
    /* 303AC 8003FBAC B40222AE */  sw         $v0, 0x2B4($s1)
  .L8003FBB0:
    /* 303B0 8003FBB0 2800BF8F */  lw         $ra, 0x28($sp)
    /* 303B4 8003FBB4 2400B38F */  lw         $s3, 0x24($sp)
    /* 303B8 8003FBB8 2000B28F */  lw         $s2, 0x20($sp)
    /* 303BC 8003FBBC 1C00B18F */  lw         $s1, 0x1C($sp)
    /* 303C0 8003FBC0 1800B08F */  lw         $s0, 0x18($sp)
    /* 303C4 8003FBC4 0800E003 */  jr         $ra
    /* 303C8 8003FBC8 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel UpdateVideoWall__18tScreenTournSelectP12tTourneyInfo
