.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawBackground__16tScreenTrackInfo, 0x288

glabel DrawBackground__16tScreenTrackInfo
    /* 32A98 80042298 C0FFBD27 */  addiu      $sp, $sp, -0x40
    /* 32A9C 8004229C 2C00B3AF */  sw         $s3, 0x2C($sp)
    /* 32AA0 800422A0 21988000 */  addu       $s3, $a0, $zero
    /* 32AA4 800422A4 0180023C */  lui        $v0, %hi(D_80011F6C)
    /* 32AA8 800422A8 1180043C */  lui        $a0, %hi(trackManager)
    /* 32AAC 800422AC 3800BFAF */  sw         $ra, 0x38($sp)
    /* 32AB0 800422B0 3400B5AF */  sw         $s5, 0x34($sp)
    /* 32AB4 800422B4 3000B4AF */  sw         $s4, 0x30($sp)
    /* 32AB8 800422B8 2800B2AF */  sw         $s2, 0x28($sp)
    /* 32ABC 800422BC 2400B1AF */  sw         $s1, 0x24($sp)
    /* 32AC0 800422C0 2000B0AF */  sw         $s0, 0x20($sp)
    /* 32AC4 800422C4 6C1F4B24 */  addiu      $t3, $v0, %lo(D_80011F6C)
    /* 32AC8 800422C8 03006889 */  lwl        $t0, 0x3($t3)
    /* 32ACC 800422CC 00006899 */  lwr        $t0, 0x0($t3)
    /* 32AD0 800422D0 07006989 */  lwl        $t1, 0x7($t3)
    /* 32AD4 800422D4 04006999 */  lwr        $t1, 0x4($t3)
    /* 32AD8 800422D8 1B00A8AB */  swl        $t0, 0x1B($sp)
    /* 32ADC 800422DC 1800A8BB */  swr        $t0, 0x18($sp)
    /* 32AE0 800422E0 1F00A9AB */  swl        $t1, 0x1F($sp)
    /* 32AE4 800422E4 1C00A9BB */  swr        $t1, 0x1C($sp)
    /* 32AE8 800422E8 64006582 */  lb         $a1, 0x64($s3)
    /* 32AEC 800422EC 4087000C */  jal        GetTrackByID__13tTrackManagers
    /* 32AF0 800422F0 504A8424 */   addiu     $a0, $a0, %lo(trackManager)
    /* 32AF4 800422F4 21A84000 */  addu       $s5, $v0, $zero
    /* 32AF8 800422F8 1180033C */  lui        $v1, %hi(tournamentManager)
    /* 32AFC 800422FC 1180023C */  lui        $v0, %hi(frontEnd)
    /* 32B00 80042300 00464624 */  addiu      $a2, $v0, %lo(frontEnd)
    /* 32B04 80042304 2201C290 */  lbu        $v0, 0x122($a2)
    /* 32B08 80042308 D84A6424 */  addiu      $a0, $v1, %lo(tournamentManager)
    /* 32B0C 8004230C 04004010 */  beqz       $v0, .L80042320
    /* 32B10 80042310 21284000 */   addu      $a1, $v0, $zero
    /* 32B14 80042314 2101C690 */  lbu        $a2, 0x121($a2)
    /* 32B18 80042318 C9080108 */  j          .L80042324
    /* 32B1C 8004231C 00000000 */   nop
  .L80042320:
    /* 32B20 80042320 2001C690 */  lbu        $a2, 0x120($a2)
  .L80042324:
    /* 32B24 80042324 95C9000C */  jal        GetTrackList__18tTournamentManagerss
    /* 32B28 80042328 21800000 */   addu      $s0, $zero, $zero
    /* 32B2C 8004232C 1180033C */  lui        $v1, %hi(tournamentManager)
    /* 32B30 80042330 D84A7424 */  addiu      $s4, $v1, %lo(tournamentManager)
    /* 32B34 80042334 8F00123C */  lui        $s2, (0x8F0000 >> 16)
    /* 32B38 80042338 21884000 */  addu       $s1, $v0, $zero
  .L8004233C:
    /* 32B3C 8004233C 00002486 */  lh         $a0, 0x0($s1)
    /* 32B40 80042340 00000000 */  nop
    /* 32B44 80042344 10008010 */  beqz       $a0, .L80042388
    /* 32B48 80042348 54010524 */   addiu     $a1, $zero, 0x154
    /* 32B4C 8004234C 0C00828E */  lw         $v0, 0xC($s4)
    /* 32B50 80042350 00000000 */  nop
    /* 32B54 80042354 02000216 */  bne        $s0, $v0, .L80042360
    /* 32B58 80042358 01000724 */   addiu     $a3, $zero, 0x1
    /* 32B5C 8004235C 02000724 */  addiu      $a3, $zero, 0x2
  .L80042360:
    /* 32B60 80042360 04000224 */  addiu      $v0, $zero, 0x4
    /* 32B64 80042364 1000A2AF */  sw         $v0, 0x10($sp)
    /* 32B68 80042368 AA000524 */  addiu      $a1, $zero, 0xAA
    /* 32B6C 8004236C 0584000C */  jal        FETextRender_MenuTextPositioned__Fsss14tMenuTextState13tMenuTextType
    /* 32B70 80042370 03341200 */   sra       $a2, $s2, 16
    /* 32B74 80042374 0900023C */  lui        $v0, (0x90000 >> 16)
    /* 32B78 80042378 21904202 */  addu       $s2, $s2, $v0
    /* 32B7C 8004237C 02003126 */  addiu      $s1, $s1, 0x2
    /* 32B80 80042380 CF080108 */  j          .L8004233C
    /* 32B84 80042384 01001026 */   addiu     $s0, $s0, 0x1
  .L80042388:
    /* 32B88 80042388 21800000 */  addu       $s0, $zero, $zero
    /* 32B8C 8004238C 04001424 */  addiu      $s4, $zero, 0x4
    /* 32B90 80042390 8F00123C */  lui        $s2, (0x8F0000 >> 16)
    /* 32B94 80042394 1800B127 */  addiu      $s1, $sp, 0x18
  .L80042398:
    /* 32B98 80042398 03341200 */  sra        $a2, $s2, 16
    /* 32B9C 8004239C 01000724 */  addiu      $a3, $zero, 0x1
    /* 32BA0 800423A0 00002486 */  lh         $a0, 0x0($s1)
    /* 32BA4 800423A4 02003126 */  addiu      $s1, $s1, 0x2
    /* 32BA8 800423A8 21800702 */  addu       $s0, $s0, $a3
    /* 32BAC 800423AC 0584000C */  jal        FETextRender_MenuTextPositioned__Fsss14tMenuTextState13tMenuTextType
    /* 32BB0 800423B0 1000B4AF */   sw        $s4, 0x10($sp)
    /* 32BB4 800423B4 1200023C */  lui        $v0, (0x120000 >> 16)
    /* 32BB8 800423B8 21904202 */  addu       $s2, $s2, $v0
    /* 32BBC 800423BC 0400022E */  sltiu      $v0, $s0, 0x4
    /* 32BC0 800423C0 F5FF4014 */  bnez       $v0, .L80042398
    /* 32BC4 800423C4 54010524 */   addiu     $a1, $zero, 0x154
    /* 32BC8 800423C8 E0010524 */  addiu      $a1, $zero, 0x1E0
    /* 32BCC 800423CC 98000624 */  addiu      $a2, $zero, 0x98
    /* 32BD0 800423D0 01000724 */  addiu      $a3, $zero, 0x1
    /* 32BD4 800423D4 0580033C */  lui        $v1, %hi(SelectListTrackDirection)
    /* 32BD8 800423D8 8C196324 */  addiu      $v1, $v1, %lo(SelectListTrackDirection)
    /* 32BDC 800423DC 65006292 */  lbu        $v0, 0x65($s3)
    /* 32BE0 800423E0 02001224 */  addiu      $s2, $zero, 0x2
    /* 32BE4 800423E4 0410E200 */  sllv       $v0, $v0, $a3
    /* 32BE8 800423E8 21104300 */  addu       $v0, $v0, $v1
    /* 32BEC 800423EC 00004484 */  lh         $a0, 0x0($v0)
    /* 32BF0 800423F0 04001124 */  addiu      $s1, $zero, 0x4
    /* 32BF4 800423F4 1000B2AF */  sw         $s2, 0x10($sp)
    /* 32BF8 800423F8 6084000C */  jal        FETextRender_MenuTextPositionedJustify__Fssss14tMenuTextState13tMenuTextType
    /* 32BFC 800423FC 1400B1AF */   sw        $s1, 0x14($sp)
    /* 32C00 80042400 E0010524 */  addiu      $a1, $zero, 0x1E0
    /* 32C04 80042404 AA000624 */  addiu      $a2, $zero, 0xAA
    /* 32C08 80042408 0580103C */  lui        $s0, %hi(SelectListOffOn)
    /* 32C0C 8004240C 66006292 */  lbu        $v0, 0x66($s3)
    /* 32C10 80042410 74191026 */  addiu      $s0, $s0, %lo(SelectListOffOn)
    /* 32C14 80042414 40100200 */  sll        $v0, $v0, 1
    /* 32C18 80042418 21105000 */  addu       $v0, $v0, $s0
    /* 32C1C 8004241C 00004484 */  lh         $a0, 0x0($v0)
    /* 32C20 80042420 01000724 */  addiu      $a3, $zero, 0x1
    /* 32C24 80042424 1000B2AF */  sw         $s2, 0x10($sp)
    /* 32C28 80042428 6084000C */  jal        FETextRender_MenuTextPositionedJustify__Fssss14tMenuTextState13tMenuTextType
    /* 32C2C 8004242C 1400B1AF */   sw        $s1, 0x14($sp)
    /* 32C30 80042430 E0010524 */  addiu      $a1, $zero, 0x1E0
    /* 32C34 80042434 67006292 */  lbu        $v0, 0x67($s3)
    /* 32C38 80042438 BC000624 */  addiu      $a2, $zero, 0xBC
    /* 32C3C 8004243C 40100200 */  sll        $v0, $v0, 1
    /* 32C40 80042440 21105000 */  addu       $v0, $v0, $s0
    /* 32C44 80042444 00004484 */  lh         $a0, 0x0($v0)
    /* 32C48 80042448 01000724 */  addiu      $a3, $zero, 0x1
    /* 32C4C 8004244C 1000B2AF */  sw         $s2, 0x10($sp)
    /* 32C50 80042450 6084000C */  jal        FETextRender_MenuTextPositionedJustify__Fssss14tMenuTextState13tMenuTextType
    /* 32C54 80042454 1400B1AF */   sw        $s1, 0x14($sp)
    /* 32C58 80042458 E0010524 */  addiu      $a1, $zero, 0x1E0
    /* 32C5C 8004245C 68006292 */  lbu        $v0, 0x68($s3)
    /* 32C60 80042460 CE000624 */  addiu      $a2, $zero, 0xCE
    /* 32C64 80042464 40100200 */  sll        $v0, $v0, 1
    /* 32C68 80042468 21105000 */  addu       $v0, $v0, $s0
    /* 32C6C 8004246C 00004484 */  lh         $a0, 0x0($v0)
    /* 32C70 80042470 01000724 */  addiu      $a3, $zero, 0x1
    /* 32C74 80042474 1000B2AF */  sw         $s2, 0x10($sp)
    /* 32C78 80042478 6084000C */  jal        FETextRender_MenuTextPositionedJustify__Fssss14tMenuTextState13tMenuTextType
    /* 32C7C 8004247C 1400B1AF */   sw        $s1, 0x14($sp)
    /* 32C80 80042480 DE010524 */  addiu      $a1, $zero, 0x1DE
    /* 32C84 80042484 21000624 */  addiu      $a2, $zero, 0x21
    /* 32C88 80042488 01000724 */  addiu      $a3, $zero, 0x1
    /* 32C8C 8004248C 2A00A492 */  lbu        $a0, 0x2A($s5)
    /* 32C90 80042490 0B000224 */  addiu      $v0, $zero, 0xB
    /* 32C94 80042494 1000A0AF */  sw         $zero, 0x10($sp)
    /* 32C98 80042498 1400A2AF */  sw         $v0, 0x14($sp)
    /* 32C9C 8004249C 6084000C */  jal        FETextRender_MenuTextPositionedJustify__Fssss14tMenuTextState13tMenuTextType
    /* 32CA0 800424A0 43008424 */   addiu     $a0, $a0, 0x43
    /* 32CA4 800424A4 21206002 */  addu       $a0, $s3, $zero
    /* 32CA8 800424A8 21280000 */  addu       $a1, $zero, $zero
    /* 32CAC 800424AC 1000A0AF */  sw         $zero, 0x10($sp)
    /* 32CB0 800424B0 0000678E */  lw         $a3, 0x0($s3)
    /* 32CB4 800424B4 3297000C */  jal        DrawBackgroundImage__7tScreeniiP18tTexture_ShapeInfoi
    /* 32CB8 800424B8 21000624 */   addiu     $a2, $zero, 0x21
    /* 32CBC 800424BC 21200000 */  addu       $a0, $zero, $zero
    /* 32CC0 800424C0 40010524 */  addiu      $a1, $zero, 0x140
    /* 32CC4 800424C4 1E000624 */  addiu      $a2, $zero, 0x1E
    /* 32CC8 800424C8 A0000724 */  addiu      $a3, $zero, 0xA0
    /* 32CCC 800424CC 0A000224 */  addiu      $v0, $zero, 0xA
    /* 32CD0 800424D0 1000A2AF */  sw         $v0, 0x10($sp)
    /* 32CD4 800424D4 01000224 */  addiu      $v0, $zero, 0x1
    /* 32CD8 800424D8 B43B010C */  jal        PSXDrawTransSquare__Fiiiiis
    /* 32CDC 800424DC 1400A2AF */   sw        $v0, 0x14($sp)
    /* 32CE0 800424E0 B635010C */  jal        FeDraw_SetABRMode__Fi
    /* 32CE4 800424E4 21200000 */   addu      $a0, $zero, $zero
    /* 32CE8 800424E8 6C027026 */  addiu      $s0, $s3, 0x26C
    /* 32CEC 800424EC 79DA000C */  jal        UpdateTransition__10tVideoWall
    /* 32CF0 800424F0 21200002 */   addu      $a0, $s0, $zero
    /* 32CF4 800424F4 EDDA000C */  jal        Draw__10tVideoWall
    /* 32CF8 800424F8 21200002 */   addu      $a0, $s0, $zero
    /* 32CFC 800424FC 3800BF8F */  lw         $ra, 0x38($sp)
    /* 32D00 80042500 3400B58F */  lw         $s5, 0x34($sp)
    /* 32D04 80042504 3000B48F */  lw         $s4, 0x30($sp)
    /* 32D08 80042508 2C00B38F */  lw         $s3, 0x2C($sp)
    /* 32D0C 8004250C 2800B28F */  lw         $s2, 0x28($sp)
    /* 32D10 80042510 2400B18F */  lw         $s1, 0x24($sp)
    /* 32D14 80042514 2000B08F */  lw         $s0, 0x20($sp)
    /* 32D18 80042518 0800E003 */  jr         $ra
    /* 32D1C 8004251C 4000BD27 */   addiu     $sp, $sp, 0x40
endlabel DrawBackground__16tScreenTrackInfo
