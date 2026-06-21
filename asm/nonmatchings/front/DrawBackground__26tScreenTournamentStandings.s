.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawBackground__26tScreenTournamentStandings, 0x8C4

glabel DrawBackground__26tScreenTournamentStandings
    /* 2A384 80039B84 08FFBD27 */  addiu      $sp, $sp, -0xF8
    /* 2A388 80039B88 EC00B7AF */  sw         $s7, 0xEC($sp)
    /* 2A38C 80039B8C 21B88000 */  addu       $s7, $a0, $zero
    /* 2A390 80039B90 E000B4AF */  sw         $s4, 0xE0($sp)
    /* 2A394 80039B94 21A00000 */  addu       $s4, $zero, $zero
    /* 2A398 80039B98 1180093C */  lui        $t1, %hi(tournamentManager)
    /* 2A39C 80039B9C D84A2925 */  addiu      $t1, $t1, %lo(tournamentManager)
    /* 2A3A0 80039BA0 F400BFAF */  sw         $ra, 0xF4($sp)
    /* 2A3A4 80039BA4 F000BEAF */  sw         $fp, 0xF0($sp)
    /* 2A3A8 80039BA8 E800B6AF */  sw         $s6, 0xE8($sp)
    /* 2A3AC 80039BAC E400B5AF */  sw         $s5, 0xE4($sp)
    /* 2A3B0 80039BB0 DC00B3AF */  sw         $s3, 0xDC($sp)
    /* 2A3B4 80039BB4 D800B2AF */  sw         $s2, 0xD8($sp)
    /* 2A3B8 80039BB8 D400B1AF */  sw         $s1, 0xD4($sp)
    /* 2A3BC 80039BBC D000B0AF */  sw         $s0, 0xD0($sp)
    /* 2A3C0 80039BC0 0400238D */  lw         $v1, 0x4($t1)
    /* 2A3C4 80039BC4 1800248D */  lw         $a0, 0x18($t1)
    /* 2A3C8 80039BC8 5C00FE86 */  lh         $fp, 0x5C($s7)
    /* 2A3CC 80039BCC 40100300 */  sll        $v0, $v1, 1
    /* 2A3D0 80039BD0 21104300 */  addu       $v0, $v0, $v1
    /* 2A3D4 80039BD4 80100200 */  sll        $v0, $v0, 2
    /* 2A3D8 80039BD8 21108200 */  addu       $v0, $a0, $v0
    /* 2A3DC 80039BDC 02004390 */  lbu        $v1, 0x2($v0)
    /* 2A3E0 80039BE0 0800228D */  lw         $v0, 0x8($t1)
    /* 2A3E4 80039BE4 FE021624 */  addiu      $s6, $zero, 0x2FE
    /* 2A3E8 80039BE8 BC00BEAF */  sw         $fp, 0xBC($sp)
    /* 2A3EC 80039BEC 21186200 */  addu       $v1, $v1, $v0
    /* 2A3F0 80039BF0 80100300 */  sll        $v0, $v1, 2
    /* 2A3F4 80039BF4 21104300 */  addu       $v0, $v0, $v1
    /* 2A3F8 80039BF8 80100200 */  sll        $v0, $v0, 2
    /* 2A3FC 80039BFC 21104300 */  addu       $v0, $v0, $v1
    /* 2A400 80039C00 80100200 */  sll        $v0, $v0, 2
    /* 2A404 80039C04 24004224 */  addiu      $v0, $v0, 0x24
    /* 2A408 80039C08 21208200 */  addu       $a0, $a0, $v0
    /* 2A40C 80039C0C C000A4AF */  sw         $a0, 0xC0($sp)
    /* 2A410 80039C10 05008390 */  lbu        $v1, 0x5($a0)
    /* 2A414 80039C14 10002285 */  lh         $v0, 0x10($t1)
    /* 2A418 80039C18 2B188302 */  sltu       $v1, $s4, $v1
    /* 2A41C 80039C1C 21104300 */  addu       $v0, $v0, $v1
    /* 2A420 80039C20 00140200 */  sll        $v0, $v0, 16
    /* 2A424 80039C24 03140200 */  sra        $v0, $v0, 16
    /* 2A428 80039C28 FFFF4924 */  addiu      $t1, $v0, -0x1
    /* 2A42C 80039C2C C400A2AF */  sw         $v0, 0xC4($sp)
    /* 2A430 80039C30 C800A9AF */  sw         $t1, 0xC8($sp)
  .L80039C34:
    /* 2A434 80039C34 C400A98F */  lw         $t1, 0xC4($sp)
    /* 2A438 80039C38 00000000 */  nop
    /* 2A43C 80039C3C 2A108902 */  slt        $v0, $s4, $t1
    /* 2A440 80039C40 71004010 */  beqz       $v0, .L80039E08
    /* 2A444 80039C44 1180093C */   lui       $t1, %hi(tournamentManager)
    /* 2A448 80039C48 D84A2425 */  addiu      $a0, $t1, %lo(tournamentManager)
    /* 2A44C 80039C4C 01008526 */  addiu      $a1, $s4, 0x1
    /* 2A450 80039C50 002C0500 */  sll        $a1, $a1, 16
    /* 2A454 80039C54 AACE000C */  jal        PlayerRanking__18tTournamentManagers
    /* 2A458 80039C58 032C0500 */   sra       $a1, $a1, 16
    /* 2A45C 80039C5C 00140200 */  sll        $v0, $v0, 16
    /* 2A460 80039C60 039C0200 */  sra        $s3, $v0, 16
    /* 2A464 80039C64 04006016 */  bnez       $s3, .L80039C78
    /* 2A468 80039C68 01001524 */   addiu     $s5, $zero, 0x1
    /* 2A46C 80039C6C 02001524 */  addiu      $s5, $zero, 0x2
    /* 2A470 80039C70 1FE70008 */  j          .L80039C7C
    /* 2A474 80039C74 2190A002 */   addu      $s2, $s5, $zero
  .L80039C78:
    /* 2A478 80039C78 21900000 */  addu       $s2, $zero, $zero
  .L80039C7C:
    /* 2A47C 80039C7C 94E4020C */  jal        TextSys_Word__Fi
    /* 2A480 80039C80 57028426 */   addiu     $a0, $s4, 0x257
    /* 2A484 80039C84 F7020424 */  addiu      $a0, $zero, 0x2F7
    /* 2A488 80039C88 A4E4020C */  jal        TextSys_WordX__Fi
    /* 2A48C 80039C8C 21884000 */   addu      $s1, $v0, $zero
    /* 2A490 80039C90 2120C002 */  addu       $a0, $s6, $zero
    /* 2A494 80039C94 00840200 */  sll        $s0, $v0, 16
    /* 2A498 80039C98 ACE4020C */  jal        TextSys_WordY__Fi
    /* 2A49C 80039C9C 03841000 */   sra       $s0, $s0, 16
    /* 2A4A0 80039CA0 2120C003 */  addu       $a0, $fp, $zero
    /* 2A4A4 80039CA4 21282002 */  addu       $a1, $s1, $zero
    /* 2A4A8 80039CA8 21300002 */  addu       $a2, $s0, $zero
    /* 2A4AC 80039CAC 00140200 */  sll        $v0, $v0, 16
    /* 2A4B0 80039CB0 033C0200 */  sra        $a3, $v0, 16
    /* 2A4B4 80039CB4 0B000924 */  addiu      $t1, $zero, 0xB
    /* 2A4B8 80039CB8 1000A9AF */  sw         $t1, 0x10($sp)
    /* 2A4BC 80039CBC 1400B2AF */  sw         $s2, 0x14($sp)
    /* 2A4C0 80039CC0 D183000C */  jal        FETextRender_FullTextFade__FiPcss13tMenuTextType14tMenuTextStates
    /* 2A4C4 80039CC4 1800A0AF */   sw        $zero, 0x18($sp)
    /* 2A4C8 80039CC8 05006016 */  bnez       $s3, .L80039CE0
    /* 2A4CC 80039CCC 00111300 */   sll       $v0, $s3, 4
    /* 2A4D0 80039CD0 7FAE000C */  jal        PlayerName__Fi
    /* 2A4D4 80039CD4 21200000 */   addu      $a0, $zero, $zero
    /* 2A4D8 80039CD8 3FE70008 */  j          .L80039CFC
    /* 2A4DC 80039CDC 21884000 */   addu      $s1, $v0, $zero
  .L80039CE0:
    /* 2A4E0 80039CE0 1180093C */  lui        $t1, %hi(tournamentManager)
    /* 2A4E4 80039CE4 D84A2925 */  addiu      $t1, $t1, %lo(tournamentManager)
    /* 2A4E8 80039CE8 21104900 */  addu       $v0, $v0, $t1
    /* 2A4EC 80039CEC 1801448C */  lw         $a0, 0x118($v0)
    /* 2A4F0 80039CF0 D32B010C */  jal        Stattool_GetAINameFromPersonality__F14tPersonalities
    /* 2A4F4 80039CF4 00000000 */   nop
    /* 2A4F8 80039CF8 21884000 */  addu       $s1, $v0, $zero
  .L80039CFC:
    /* 2A4FC 80039CFC A4E4020C */  jal        TextSys_WordX__Fi
    /* 2A500 80039D00 F8020424 */   addiu     $a0, $zero, 0x2F8
    /* 2A504 80039D04 2120C002 */  addu       $a0, $s6, $zero
    /* 2A508 80039D08 00840200 */  sll        $s0, $v0, 16
    /* 2A50C 80039D0C ACE4020C */  jal        TextSys_WordY__Fi
    /* 2A510 80039D10 03841000 */   sra       $s0, $s0, 16
    /* 2A514 80039D14 2120C003 */  addu       $a0, $fp, $zero
    /* 2A518 80039D18 21282002 */  addu       $a1, $s1, $zero
    /* 2A51C 80039D1C 21300002 */  addu       $a2, $s0, $zero
    /* 2A520 80039D20 00140200 */  sll        $v0, $v0, 16
    /* 2A524 80039D24 033C0200 */  sra        $a3, $v0, 16
    /* 2A528 80039D28 0B000924 */  addiu      $t1, $zero, 0xB
    /* 2A52C 80039D2C 1000A9AF */  sw         $t1, 0x10($sp)
    /* 2A530 80039D30 1400B5AF */  sw         $s5, 0x14($sp)
    /* 2A534 80039D34 D183000C */  jal        FETextRender_FullTextFade__FiPcss13tMenuTextType14tMenuTextStates
    /* 2A538 80039D38 1800A0AF */   sw        $zero, 0x18($sp)
    /* 2A53C 80039D3C C000A98F */  lw         $t1, 0xC0($sp)
    /* 2A540 80039D40 B800B3A7 */  sh         $s3, 0xB8($sp)
    /* 2A544 80039D44 05002291 */  lbu        $v0, 0x5($t1)
    /* 2A548 80039D48 00000000 */  nop
    /* 2A54C 80039D4C 0D004010 */  beqz       $v0, .L80039D84
    /* 2A550 80039D50 1180093C */   lui       $t1, %hi(tournamentManager)
    /* 2A554 80039D54 C800A98F */  lw         $t1, 0xC8($sp)
    /* 2A558 80039D58 00000000 */  nop
    /* 2A55C 80039D5C 02008916 */  bne        $s4, $t1, .L80039D68
    /* 2A560 80039D60 1B030424 */   addiu     $a0, $zero, 0x31B
    /* 2A564 80039D64 1C030424 */  addiu      $a0, $zero, 0x31C
  .L80039D68:
    /* 2A568 80039D68 94E4020C */  jal        TextSys_Word__Fi
    /* 2A56C 80039D6C 00000000 */   nop
    /* 2A570 80039D70 2000A427 */  addiu      $a0, $sp, 0x20
    /* 2A574 80039D74 2F91030C */  jal        sprintf
    /* 2A578 80039D78 21284000 */   addu      $a1, $v0, $zero
    /* 2A57C 80039D7C 6EE70008 */  j          .L80039DB8
    /* 2A580 80039D80 00000000 */   nop
  .L80039D84:
    /* 2A584 80039D84 D84A2425 */  addiu      $a0, $t1, %lo(tournamentManager)
    /* 2A588 80039D88 A3CE000C */  jal        TournPointTotal__18tTournamentManagerPs
    /* 2A58C 80039D8C B800A527 */   addiu     $a1, $sp, 0xB8
    /* 2A590 80039D90 1D030424 */  addiu      $a0, $zero, 0x31D
    /* 2A594 80039D94 00840200 */  sll        $s0, $v0, 16
    /* 2A598 80039D98 94E4020C */  jal        TextSys_Word__Fi
    /* 2A59C 80039D9C 03841000 */   sra       $s0, $s0, 16
    /* 2A5A0 80039DA0 2000A427 */  addiu      $a0, $sp, 0x20
    /* 2A5A4 80039DA4 0180053C */  lui        $a1, %hi(D_8001199C)
    /* 2A5A8 80039DA8 9C19A524 */  addiu      $a1, $a1, %lo(D_8001199C)
    /* 2A5AC 80039DAC 21300002 */  addu       $a2, $s0, $zero
    /* 2A5B0 80039DB0 2F91030C */  jal        sprintf
    /* 2A5B4 80039DB4 21384000 */   addu      $a3, $v0, $zero
  .L80039DB8:
    /* 2A5B8 80039DB8 A4E4020C */  jal        TextSys_WordX__Fi
    /* 2A5BC 80039DBC FB020424 */   addiu     $a0, $zero, 0x2FB
    /* 2A5C0 80039DC0 2120C002 */  addu       $a0, $s6, $zero
    /* 2A5C4 80039DC4 00840200 */  sll        $s0, $v0, 16
    /* 2A5C8 80039DC8 ACE4020C */  jal        TextSys_WordY__Fi
    /* 2A5CC 80039DCC 03841000 */   sra       $s0, $s0, 16
    /* 2A5D0 80039DD0 2120C003 */  addu       $a0, $fp, $zero
    /* 2A5D4 80039DD4 2000A527 */  addiu      $a1, $sp, 0x20
    /* 2A5D8 80039DD8 21300002 */  addu       $a2, $s0, $zero
    /* 2A5DC 80039DDC 00140200 */  sll        $v0, $v0, 16
    /* 2A5E0 80039DE0 033C0200 */  sra        $a3, $v0, 16
    /* 2A5E4 80039DE4 0B000924 */  addiu      $t1, $zero, 0xB
    /* 2A5E8 80039DE8 01000224 */  addiu      $v0, $zero, 0x1
    /* 2A5EC 80039DEC 1000A9AF */  sw         $t1, 0x10($sp)
    /* 2A5F0 80039DF0 1400B5AF */  sw         $s5, 0x14($sp)
    /* 2A5F4 80039DF4 D183000C */  jal        FETextRender_FullTextFade__FiPcss13tMenuTextType14tMenuTextStates
    /* 2A5F8 80039DF8 1800A2AF */   sw        $v0, 0x18($sp)
    /* 2A5FC 80039DFC 0100D626 */  addiu      $s6, $s6, 0x1
    /* 2A600 80039E00 0DE70008 */  j          .L80039C34
    /* 2A604 80039E04 01009426 */   addiu     $s4, $s4, 0x1
  .L80039E08:
    /* 2A608 80039E08 58AE000C */  jal        Front_GetTrackRaced__Fv
    /* 2A60C 80039E0C 00000000 */   nop
    /* 2A610 80039E10 1180043C */  lui        $a0, %hi(trackManager)
    /* 2A614 80039E14 504A8424 */  addiu      $a0, $a0, %lo(trackManager)
    /* 2A618 80039E18 00140200 */  sll        $v0, $v0, 16
    /* 2A61C 80039E1C 032C0200 */  sra        $a1, $v0, 16
    /* 2A620 80039E20 A986000C */  jal        GetTrack__13tTrackManagersR17tTrackInformation
    /* 2A624 80039E24 7000A627 */   addiu     $a2, $sp, 0x70
    /* 2A628 80039E28 58AE000C */  jal        Front_GetTrackRaced__Fv
    /* 2A62C 80039E2C 00000000 */   nop
    /* 2A630 80039E30 00140200 */  sll        $v0, $v0, 16
    /* 2A634 80039E34 03140200 */  sra        $v0, $v0, 16
    /* 2A638 80039E38 94E4020C */  jal        TextSys_Word__Fi
    /* 2A63C 80039E3C D5004424 */   addiu     $a0, $v0, 0xD5
    /* 2A640 80039E40 F6020424 */  addiu      $a0, $zero, 0x2F6
    /* 2A644 80039E44 A4E4020C */  jal        TextSys_WordX__Fi
    /* 2A648 80039E48 21884000 */   addu      $s1, $v0, $zero
    /* 2A64C 80039E4C FD020424 */  addiu      $a0, $zero, 0x2FD
    /* 2A650 80039E50 00840200 */  sll        $s0, $v0, 16
    /* 2A654 80039E54 ACE4020C */  jal        TextSys_WordY__Fi
    /* 2A658 80039E58 03841000 */   sra       $s0, $s0, 16
    /* 2A65C 80039E5C 2120C003 */  addu       $a0, $fp, $zero
    /* 2A660 80039E60 21282002 */  addu       $a1, $s1, $zero
    /* 2A664 80039E64 21300002 */  addu       $a2, $s0, $zero
    /* 2A668 80039E68 00140200 */  sll        $v0, $v0, 16
    /* 2A66C 80039E6C 033C0200 */  sra        $a3, $v0, 16
    /* 2A670 80039E70 0B000924 */  addiu      $t1, $zero, 0xB
    /* 2A674 80039E74 02000224 */  addiu      $v0, $zero, 0x2
    /* 2A678 80039E78 1000A9AF */  sw         $t1, 0x10($sp)
    /* 2A67C 80039E7C 1400A2AF */  sw         $v0, 0x14($sp)
    /* 2A680 80039E80 D183000C */  jal        FETextRender_FullTextFade__FiPcss13tMenuTextType14tMenuTextStates
    /* 2A684 80039E84 1800A2AF */   sw        $v0, 0x18($sp)
    /* 2A688 80039E88 1180023C */  lui        $v0, %hi(D_80114722)
    /* 2A68C 80039E8C 22474290 */  lbu        $v0, %lo(D_80114722)($v0)
    /* 2A690 80039E90 00000000 */  nop
    /* 2A694 80039E94 05004010 */  beqz       $v0, .L80039EAC
    /* 2A698 80039E98 0580023C */   lui       $v0, %hi(menuDefs)
    /* 2A69C 80039E9C 581A448C */  lw         $a0, %lo(menuDefs)($v0)
    /* 2A6A0 80039EA0 FFFF0524 */  addiu      $a1, $zero, -0x1
    /* 2A6A4 80039EA4 AEE70008 */  j          .L80039EB8
    /* 2A6A8 80039EA8 8C078424 */   addiu     $a0, $a0, 0x78C
  .L80039EAC:
    /* 2A6AC 80039EAC 581A448C */  lw         $a0, %lo(menuDefs)($v0)
    /* 2A6B0 80039EB0 FFFF0524 */  addiu      $a1, $zero, -0x1
    /* 2A6B4 80039EB4 A8068424 */  addiu      $a0, $a0, 0x6A8
  .L80039EB8:
    /* 2A6B8 80039EB8 8ACF000C */  jal        TextValue__23tListIteratorTournament7tPlayer
    /* 2A6BC 80039EBC 00000000 */   nop
    /* 2A6C0 80039EC0 00140200 */  sll        $v0, $v0, 16
    /* 2A6C4 80039EC4 03A40200 */  sra        $s4, $v0, 16
    /* 2A6C8 80039EC8 13009426 */  addiu      $s4, $s4, 0x13
    /* 2A6CC 80039ECC A4E4020C */  jal        TextSys_WordX__Fi
    /* 2A6D0 80039ED0 F6020424 */   addiu     $a0, $zero, 0x2F6
    /* 2A6D4 80039ED4 FC020424 */  addiu      $a0, $zero, 0x2FC
    /* 2A6D8 80039ED8 00840200 */  sll        $s0, $v0, 16
    /* 2A6DC 80039EDC ACE4020C */  jal        TextSys_WordY__Fi
    /* 2A6E0 80039EE0 03841000 */   sra       $s0, $s0, 16
    /* 2A6E4 80039EE4 2120C003 */  addu       $a0, $fp, $zero
    /* 2A6E8 80039EE8 002C1400 */  sll        $a1, $s4, 16
    /* 2A6EC 80039EEC 032C0500 */  sra        $a1, $a1, 16
    /* 2A6F0 80039EF0 21300002 */  addu       $a2, $s0, $zero
    /* 2A6F4 80039EF4 00140200 */  sll        $v0, $v0, 16
    /* 2A6F8 80039EF8 033C0200 */  sra        $a3, $v0, 16
    /* 2A6FC 80039EFC 02000224 */  addiu      $v0, $zero, 0x2
    /* 2A700 80039F00 0B000924 */  addiu      $t1, $zero, 0xB
    /* 2A704 80039F04 1000A2AF */  sw         $v0, 0x10($sp)
    /* 2A708 80039F08 1400A2AF */  sw         $v0, 0x14($sp)
    /* 2A70C 80039F0C 7584000C */  jal        FETextRender_MenuTextPositionedJustifyFade__Fissss14tMenuTextState13tMenuTextType
    /* 2A710 80039F10 1800A9AF */   sw        $t1, 0x18($sp)
    /* 2A714 80039F14 94E4020C */  jal        TextSys_Word__Fi
    /* 2A718 80039F18 21208002 */   addu      $a0, $s4, $zero
    /* 2A71C 80039F1C 888F030C */  jal        textpixels
    /* 2A720 80039F20 21204000 */   addu      $a0, $v0, $zero
    /* 2A724 80039F24 F6020424 */  addiu      $a0, $zero, 0x2F6
    /* 2A728 80039F28 A4E4020C */  jal        TextSys_WordX__Fi
    /* 2A72C 80039F2C 21884000 */   addu      $s1, $v0, $zero
    /* 2A730 80039F30 FC020424 */  addiu      $a0, $zero, 0x2FC
    /* 2A734 80039F34 43181100 */  sra        $v1, $s1, 1
    /* 2A738 80039F38 ACE4020C */  jal        TextSys_WordY__Fi
    /* 2A73C 80039F3C 23804300 */   subu      $s0, $v0, $v1
    /* 2A740 80039F40 21200000 */  addu       $a0, $zero, $zero
    /* 2A744 80039F44 21280002 */  addu       $a1, $s0, $zero
    /* 2A748 80039F48 FFFF4624 */  addiu      $a2, $v0, -0x1
    /* 2A74C 80039F4C 21382002 */  addu       $a3, $s1, $zero
    /* 2A750 80039F50 09000224 */  addiu      $v0, $zero, 0x9
    /* 2A754 80039F54 113B010C */  jal        PSXDrawSquare__Fiiiii
    /* 2A758 80039F58 1000A2AF */   sw        $v0, 0x10($sp)
    /* 2A75C 80039F5C 0580023C */  lui        $v0, %hi(gCurrentShapes)
    /* 2A760 80039F60 CC17448C */  lw         $a0, %lo(gCurrentShapes)($v0)
    /* 2A764 80039F64 1480143C */  lui        $s4, %hi(ticks)
    /* 2A768 80039F68 E0048424 */  addiu      $a0, $a0, 0x4E0
    /* 2A76C 80039F6C 10008394 */  lhu        $v1, 0x10($a0)
    /* 2A770 80039F70 ACDC828E */  lw         $v0, %lo(ticks)($s4)
    /* 2A774 80039F74 001C0300 */  sll        $v1, $v1, 16
    /* 2A778 80039F78 032C0300 */  sra        $a1, $v1, 16
    /* 2A77C 80039F7C 1A004500 */  div        $zero, $v0, $a1
    /* 2A780 80039F80 0200A014 */  bnez       $a1, .L80039F8C
    /* 2A784 80039F84 00000000 */   nop
    /* 2A788 80039F88 0D000700 */  break      7
  .L80039F8C:
    /* 2A78C 80039F8C FFFF0124 */  addiu      $at, $zero, -0x1
    /* 2A790 80039F90 0400A114 */  bne        $a1, $at, .L80039FA4
    /* 2A794 80039F94 0080013C */   lui       $at, (0x80000000 >> 16)
    /* 2A798 80039F98 02004114 */  bne        $v0, $at, .L80039FA4
    /* 2A79C 80039F9C 00000000 */   nop
    /* 2A7A0 80039FA0 0D000600 */  break      6
  .L80039FA4:
    /* 2A7A4 80039FA4 10800000 */  mfhi       $s0
    /* 2A7A8 80039FA8 14008484 */  lh         $a0, 0x14($a0)
    /* 2A7AC 80039FAC 43140300 */  sra        $v0, $v1, 17
    /* 2A7B0 80039FB0 FEFF4224 */  addiu      $v0, $v0, -0x2
    /* 2A7B4 80039FB4 C21F0300 */  srl        $v1, $v1, 31
    /* 2A7B8 80039FB8 2118A300 */  addu       $v1, $a1, $v1
    /* 2A7BC 80039FBC 43180300 */  sra        $v1, $v1, 1
    /* 2A7C0 80039FC0 2A187000 */  slt        $v1, $v1, $s0
    /* 2A7C4 80039FC4 02006010 */  beqz       $v1, .L80039FD0
    /* 2A7C8 80039FC8 23904400 */   subu      $s2, $v0, $a0
    /* 2A7CC 80039FCC 2380B000 */  subu       $s0, $a1, $s0
  .L80039FD0:
    /* 2A7D0 80039FD0 ACE4020C */  jal        TextSys_WordY__Fi
    /* 2A7D4 80039FD4 FC020424 */   addiu     $a0, $zero, 0x2FC
    /* 2A7D8 80039FD8 28000424 */  addiu      $a0, $zero, 0x28
    /* 2A7DC 80039FDC 21280000 */  addu       $a1, $zero, $zero
    /* 2A7E0 80039FE0 21305002 */  addu       $a2, $s2, $s0
    /* 2A7E4 80039FE4 01004724 */  addiu      $a3, $v0, 0x1
    /* 2A7E8 80039FE8 5C00E286 */  lh         $v0, 0x5C($s7)
    /* 2A7EC 80039FEC 01001124 */  addiu      $s1, $zero, 0x1
    /* 2A7F0 80039FF0 1400B1AF */  sw         $s1, 0x14($sp)
    /* 2A7F4 80039FF4 1800A0AF */  sw         $zero, 0x18($sp)
    /* 2A7F8 80039FF8 9E39010C */  jal        DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* 2A7FC 80039FFC 1000A2AF */   sw        $v0, 0x10($sp)
    /* 2A800 8003A000 ACE4020C */  jal        TextSys_WordY__Fi
    /* 2A804 8003A004 FC020424 */   addiu     $a0, $zero, 0x2FC
    /* 2A808 8003A008 28000424 */  addiu      $a0, $zero, 0x28
    /* 2A80C 8003A00C 21280000 */  addu       $a1, $zero, $zero
    /* 2A810 8003A010 23305002 */  subu       $a2, $s2, $s0
    /* 2A814 8003A014 5C00E386 */  lh         $v1, 0x5C($s7)
    /* 2A818 8003A018 21385100 */  addu       $a3, $v0, $s1
    /* 2A81C 8003A01C 1400B1AF */  sw         $s1, 0x14($sp)
    /* 2A820 8003A020 1800A0AF */  sw         $zero, 0x18($sp)
    /* 2A824 8003A024 9E39010C */  jal        DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* 2A828 8003A028 1000A3AF */   sw        $v1, 0x10($sp)
    /* 2A82C 8003A02C 2800023C */  lui        $v0, (0x282828 >> 16)
    /* 2A830 8003A030 28284234 */  ori        $v0, $v0, (0x282828 & 0xFFFF)
    /* 2A834 8003A034 27000424 */  addiu      $a0, $zero, 0x27
    /* 2A838 8003A038 00040524 */  addiu      $a1, $zero, 0x400
    /* 2A83C 8003A03C 21300000 */  addu       $a2, $zero, $zero
    /* 2A840 8003A040 FFFF0724 */  addiu      $a3, $zero, -0x1
    /* 2A844 8003A044 A400A2AF */  sw         $v0, 0xA4($sp)
    /* 2A848 8003A048 5C00E386 */  lh         $v1, 0x5C($s7)
    /* 2A84C 8003A04C A000A227 */  addiu      $v0, $sp, 0xA0
    /* 2A850 8003A050 1400A0AF */  sw         $zero, 0x14($sp)
    /* 2A854 8003A054 1800A2AF */  sw         $v0, 0x18($sp)
    /* 2A858 8003A058 9E39010C */  jal        DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* 2A85C 8003A05C 1000A3AF */   sw        $v1, 0x10($sp)
    /* 2A860 8003A060 A4E4020C */  jal        TextSys_WordX__Fi
    /* 2A864 8003A064 F6020424 */   addiu     $a0, $zero, 0x2F6
    /* 2A868 8003A068 FD020424 */  addiu      $a0, $zero, 0x2FD
    /* 2A86C 8003A06C ACE4020C */  jal        TextSys_WordY__Fi
    /* 2A870 8003A070 6AFF5024 */   addiu     $s0, $v0, -0x96
    /* 2A874 8003A074 2300043C */  lui        $a0, (0x232323 >> 16)
    /* 2A878 8003A078 23238434 */  ori        $a0, $a0, (0x232323 & 0xFFFF)
    /* 2A87C 8003A07C 21280002 */  addu       $a1, $s0, $zero
    /* 2A880 8003A080 0A004624 */  addiu      $a2, $v0, 0xA
    /* 2A884 8003A084 2C010724 */  addiu      $a3, $zero, 0x12C
    /* 2A888 8003A088 BC00A98F */  lw         $t1, 0xBC($sp)
    /* 2A88C 8003A08C 03000224 */  addiu      $v0, $zero, 0x3
    /* 2A890 8003A090 1400A2AF */  sw         $v0, 0x14($sp)
    /* 2A894 8003A094 1E000224 */  addiu      $v0, $zero, 0x1E
    /* 2A898 8003A098 1000B1AF */  sw         $s1, 0x10($sp)
    /* 2A89C 8003A09C 1C00A2AF */  sw         $v0, 0x1C($sp)
    /* 2A8A0 8003A0A0 CE2E010C */  jal        PSXDrawBrightEndLine__Fiiiiiiii
    /* 2A8A4 8003A0A4 1800A9AF */   sw        $t1, 0x18($sp)
    /* 2A8A8 8003A0A8 0580033C */  lui        $v1, %hi(kRGBVals)
    /* 2A8AC 8003A0AC 0580023C */  lui        $v0, %hi(D_800515FF)
    /* 2A8B0 8003A0B0 FF154290 */  lbu        $v0, %lo(D_800515FF)($v0)
    /* 2A8B4 8003A0B4 C8166324 */  addiu      $v1, $v1, %lo(kRGBVals)
    /* 2A8B8 8003A0B8 80100200 */  sll        $v0, $v0, 2
    /* 2A8BC 8003A0BC 21104300 */  addu       $v0, $v0, $v1
    /* 2A8C0 8003A0C0 0000448C */  lw         $a0, 0x0($v0)
    /* 2A8C4 8003A0C4 222E010C */  jal        CalcFadeVal__Fii
    /* 2A8C8 8003A0C8 2128C003 */   addu      $a1, $fp, $zero
    /* 2A8CC 8003A0CC 2300043C */  lui        $a0, (0x232323 >> 16)
    /* 2A8D0 8003A0D0 23238434 */  ori        $a0, $a0, (0x232323 & 0xFFFF)
    /* 2A8D4 8003A0D4 2128C003 */  addu       $a1, $fp, $zero
    /* 2A8D8 8003A0D8 222E010C */  jal        CalcFadeVal__Fii
    /* 2A8DC 8003A0DC 21984000 */   addu      $s3, $v0, $zero
    /* 2A8E0 8003A0E0 ACDC838E */  lw         $v1, %lo(ticks)($s4)
    /* 2A8E4 8003A0E4 7400E48E */  lw         $a0, 0x74($s7)
    /* 2A8E8 8003A0E8 00000000 */  nop
    /* 2A8EC 8003A0EC 23186400 */  subu       $v1, $v1, $a0
    /* 2A8F0 8003A0F0 E9036328 */  slti       $v1, $v1, 0x3E9
    /* 2A8F4 8003A0F4 05006010 */  beqz       $v1, .L8003A10C
    /* 2A8F8 8003A0F8 21904000 */   addu      $s2, $v0, $zero
    /* 2A8FC 8003A0FC 8C00E28E */  lw         $v0, 0x8C($s7)
    /* 2A900 8003A100 00000000 */  nop
    /* 2A904 8003A104 22004010 */  beqz       $v0, .L8003A190
    /* 2A908 8003A108 00000000 */   nop
  .L8003A10C:
    /* 2A90C 8003A10C 6800E28E */  lw         $v0, 0x68($s7)
    /* 2A910 8003A110 00000000 */  nop
    /* 2A914 8003A114 0900401C */  bgtz       $v0, .L8003A13C
    /* 2A918 8003A118 00000000 */   nop
    /* 2A91C 8003A11C 6C00E28E */  lw         $v0, 0x6C($s7)
    /* 2A920 8003A120 00000000 */  nop
    /* 2A924 8003A124 0500401C */  bgtz       $v0, .L8003A13C
    /* 2A928 8003A128 00000000 */   nop
    /* 2A92C 8003A12C 7000E28E */  lw         $v0, 0x70($s7)
    /* 2A930 8003A130 00000000 */  nop
    /* 2A934 8003A134 03004018 */  blez       $v0, .L8003A144
    /* 2A938 8003A138 00000000 */   nop
  .L8003A13C:
    /* 2A93C 8003A13C 81E5010C */  jal        AudioCmn_PlayFESFX__Fi
    /* 2A940 8003A140 15000424 */   addiu     $a0, $zero, 0x15
  .L8003A144:
    /* 2A944 8003A144 6800E28E */  lw         $v0, 0x68($s7)
    /* 2A948 8003A148 9000E38E */  lw         $v1, 0x90($s7)
    /* 2A94C 8003A14C 00000000 */  nop
    /* 2A950 8003A150 23104300 */  subu       $v0, $v0, $v1
    /* 2A954 8003A154 0E00401C */  bgtz       $v0, .L8003A190
    /* 2A958 8003A158 6800E2AE */   sw        $v0, 0x68($s7)
    /* 2A95C 8003A15C 6C00E28E */  lw         $v0, 0x6C($s7)
    /* 2A960 8003A160 6800E0AE */  sw         $zero, 0x68($s7)
    /* 2A964 8003A164 23104300 */  subu       $v0, $v0, $v1
    /* 2A968 8003A168 0900401C */  bgtz       $v0, .L8003A190
    /* 2A96C 8003A16C 6C00E2AE */   sw        $v0, 0x6C($s7)
    /* 2A970 8003A170 7000E48E */  lw         $a0, 0x70($s7)
    /* 2A974 8003A174 01000224 */  addiu      $v0, $zero, 0x1
    /* 2A978 8003A178 8800E2AE */  sw         $v0, 0x88($s7)
    /* 2A97C 8003A17C 23208300 */  subu       $a0, $a0, $v1
    /* 2A980 8003A180 02008104 */  bgez       $a0, .L8003A18C
    /* 2A984 8003A184 6C00E0AE */   sw        $zero, 0x6C($s7)
    /* 2A988 8003A188 21200000 */  addu       $a0, $zero, $zero
  .L8003A18C:
    /* 2A98C 8003A18C 7000E4AE */  sw         $a0, 0x70($s7)
  .L8003A190:
    /* 2A990 8003A190 8400E28E */  lw         $v0, 0x84($s7)
    /* 2A994 8003A194 00000000 */  nop
    /* 2A998 8003A198 71004010 */  beqz       $v0, .L8003A360
    /* 2A99C 8003A19C 00000000 */   nop
    /* 2A9A0 8003A1A0 94E4020C */  jal        TextSys_Word__Fi
    /* 2A9A4 8003A1A4 12030424 */   addiu     $a0, $zero, 0x312
    /* 2A9A8 8003A1A8 FA020424 */  addiu      $a0, $zero, 0x2FA
    /* 2A9AC 8003A1AC A4E4020C */  jal        TextSys_WordX__Fi
    /* 2A9B0 8003A1B0 21884000 */   addu      $s1, $v0, $zero
    /* 2A9B4 8003A1B4 12030424 */  addiu      $a0, $zero, 0x312
    /* 2A9B8 8003A1B8 00140200 */  sll        $v0, $v0, 16
    /* 2A9BC 8003A1BC ACE4020C */  jal        TextSys_WordY__Fi
    /* 2A9C0 8003A1C0 03840200 */   sra       $s0, $v0, 16
    /* 2A9C4 8003A1C4 0B000924 */  addiu      $t1, $zero, 0xB
    /* 2A9C8 8003A1C8 00140200 */  sll        $v0, $v0, 16
    /* 2A9CC 8003A1CC 1000A9AF */  sw         $t1, 0x10($sp)
    /* 2A9D0 8003A1D0 7800E38E */  lw         $v1, 0x78($s7)
    /* 2A9D4 8003A1D4 00000000 */  nop
    /* 2A9D8 8003A1D8 04006010 */  beqz       $v1, .L8003A1EC
    /* 2A9DC 8003A1DC 033C0200 */   sra       $a3, $v0, 16
    /* 2A9E0 8003A1E0 01000224 */  addiu      $v0, $zero, 0x1
    /* 2A9E4 8003A1E4 7CE80008 */  j          .L8003A1F0
    /* 2A9E8 8003A1E8 1400A2AF */   sw        $v0, 0x14($sp)
  .L8003A1EC:
    /* 2A9EC 8003A1EC 1400A0AF */  sw         $zero, 0x14($sp)
  .L8003A1F0:
    /* 2A9F0 8003A1F0 2120C003 */  addu       $a0, $fp, $zero
    /* 2A9F4 8003A1F4 21282002 */  addu       $a1, $s1, $zero
    /* 2A9F8 8003A1F8 21300002 */  addu       $a2, $s0, $zero
    /* 2A9FC 8003A1FC 01001424 */  addiu      $s4, $zero, 0x1
    /* 2AA00 8003A200 D183000C */  jal        FETextRender_FullTextFade__FiPcss13tMenuTextType14tMenuTextStates
    /* 2AA04 8003A204 1800B4AF */   sw        $s4, 0x18($sp)
    /* 2AA08 8003A208 A4E4020C */  jal        TextSys_WordX__Fi
    /* 2AA0C 8003A20C FB020424 */   addiu     $a0, $zero, 0x2FB
    /* 2AA10 8003A210 12030424 */  addiu      $a0, $zero, 0x312
    /* 2AA14 8003A214 ACE4020C */  jal        TextSys_WordY__Fi
    /* 2AA18 8003A218 21804000 */   addu      $s0, $v0, $zero
    /* 2AA1C 8003A21C 21200002 */  addu       $a0, $s0, $zero
    /* 2AA20 8003A220 21284000 */  addu       $a1, $v0, $zero
    /* 2AA24 8003A224 1000B3AF */  sw         $s3, 0x10($sp)
    /* 2AA28 8003A228 1400B2AF */  sw         $s2, 0x14($sp)
    /* 2AA2C 8003A22C 6800E78E */  lw         $a3, 0x68($s7)
    /* 2AA30 8003A230 FCE5000C */  jal        DrawMoney__Fiiilii
    /* 2AA34 8003A234 06000624 */   addiu     $a2, $zero, 0x6
    /* 2AA38 8003A238 94E4020C */  jal        TextSys_Word__Fi
    /* 2AA3C 8003A23C 13030424 */   addiu     $a0, $zero, 0x313
    /* 2AA40 8003A240 FA020424 */  addiu      $a0, $zero, 0x2FA
    /* 2AA44 8003A244 A4E4020C */  jal        TextSys_WordX__Fi
    /* 2AA48 8003A248 21884000 */   addu      $s1, $v0, $zero
    /* 2AA4C 8003A24C 13030424 */  addiu      $a0, $zero, 0x313
    /* 2AA50 8003A250 00140200 */  sll        $v0, $v0, 16
    /* 2AA54 8003A254 ACE4020C */  jal        TextSys_WordY__Fi
    /* 2AA58 8003A258 03840200 */   sra       $s0, $v0, 16
    /* 2AA5C 8003A25C 0B000924 */  addiu      $t1, $zero, 0xB
    /* 2AA60 8003A260 00140200 */  sll        $v0, $v0, 16
    /* 2AA64 8003A264 1000A9AF */  sw         $t1, 0x10($sp)
    /* 2AA68 8003A268 8000E38E */  lw         $v1, 0x80($s7)
    /* 2AA6C 8003A26C 00000000 */  nop
    /* 2AA70 8003A270 03006010 */  beqz       $v1, .L8003A280
    /* 2AA74 8003A274 033C0200 */   sra       $a3, $v0, 16
    /* 2AA78 8003A278 A1E80008 */  j          .L8003A284
    /* 2AA7C 8003A27C 1400B4AF */   sw        $s4, 0x14($sp)
  .L8003A280:
    /* 2AA80 8003A280 1400A0AF */  sw         $zero, 0x14($sp)
  .L8003A284:
    /* 2AA84 8003A284 2120C003 */  addu       $a0, $fp, $zero
    /* 2AA88 8003A288 21282002 */  addu       $a1, $s1, $zero
    /* 2AA8C 8003A28C 21300002 */  addu       $a2, $s0, $zero
    /* 2AA90 8003A290 01001424 */  addiu      $s4, $zero, 0x1
    /* 2AA94 8003A294 D183000C */  jal        FETextRender_FullTextFade__FiPcss13tMenuTextType14tMenuTextStates
    /* 2AA98 8003A298 1800B4AF */   sw        $s4, 0x18($sp)
    /* 2AA9C 8003A29C A4E4020C */  jal        TextSys_WordX__Fi
    /* 2AAA0 8003A2A0 FB020424 */   addiu     $a0, $zero, 0x2FB
    /* 2AAA4 8003A2A4 13030424 */  addiu      $a0, $zero, 0x313
    /* 2AAA8 8003A2A8 ACE4020C */  jal        TextSys_WordY__Fi
    /* 2AAAC 8003A2AC 21804000 */   addu      $s0, $v0, $zero
    /* 2AAB0 8003A2B0 21200002 */  addu       $a0, $s0, $zero
    /* 2AAB4 8003A2B4 21284000 */  addu       $a1, $v0, $zero
    /* 2AAB8 8003A2B8 1000B3AF */  sw         $s3, 0x10($sp)
    /* 2AABC 8003A2BC 1400B2AF */  sw         $s2, 0x14($sp)
    /* 2AAC0 8003A2C0 6C00E78E */  lw         $a3, 0x6C($s7)
    /* 2AAC4 8003A2C4 FCE5000C */  jal        DrawMoney__Fiiilii
    /* 2AAC8 8003A2C8 06000624 */   addiu     $a2, $zero, 0x6
    /* 2AACC 8003A2CC 94E4020C */  jal        TextSys_Word__Fi
    /* 2AAD0 8003A2D0 14030424 */   addiu     $a0, $zero, 0x314
    /* 2AAD4 8003A2D4 FA020424 */  addiu      $a0, $zero, 0x2FA
    /* 2AAD8 8003A2D8 A4E4020C */  jal        TextSys_WordX__Fi
    /* 2AADC 8003A2DC 21884000 */   addu      $s1, $v0, $zero
    /* 2AAE0 8003A2E0 14030424 */  addiu      $a0, $zero, 0x314
    /* 2AAE4 8003A2E4 00140200 */  sll        $v0, $v0, 16
    /* 2AAE8 8003A2E8 ACE4020C */  jal        TextSys_WordY__Fi
    /* 2AAEC 8003A2EC 03840200 */   sra       $s0, $v0, 16
    /* 2AAF0 8003A2F0 0B000924 */  addiu      $t1, $zero, 0xB
    /* 2AAF4 8003A2F4 00140200 */  sll        $v0, $v0, 16
    /* 2AAF8 8003A2F8 1000A9AF */  sw         $t1, 0x10($sp)
    /* 2AAFC 8003A2FC 7C00E38E */  lw         $v1, 0x7C($s7)
    /* 2AB00 8003A300 00000000 */  nop
    /* 2AB04 8003A304 03006010 */  beqz       $v1, .L8003A314
    /* 2AB08 8003A308 033C0200 */   sra       $a3, $v0, 16
    /* 2AB0C 8003A30C C6E80008 */  j          .L8003A318
    /* 2AB10 8003A310 1400B4AF */   sw        $s4, 0x14($sp)
  .L8003A314:
    /* 2AB14 8003A314 1400A0AF */  sw         $zero, 0x14($sp)
  .L8003A318:
    /* 2AB18 8003A318 2120C003 */  addu       $a0, $fp, $zero
    /* 2AB1C 8003A31C 21282002 */  addu       $a1, $s1, $zero
    /* 2AB20 8003A320 21300002 */  addu       $a2, $s0, $zero
    /* 2AB24 8003A324 01000224 */  addiu      $v0, $zero, 0x1
    /* 2AB28 8003A328 D183000C */  jal        FETextRender_FullTextFade__FiPcss13tMenuTextType14tMenuTextStates
    /* 2AB2C 8003A32C 1800A2AF */   sw        $v0, 0x18($sp)
    /* 2AB30 8003A330 A4E4020C */  jal        TextSys_WordX__Fi
    /* 2AB34 8003A334 FB020424 */   addiu     $a0, $zero, 0x2FB
    /* 2AB38 8003A338 14030424 */  addiu      $a0, $zero, 0x314
    /* 2AB3C 8003A33C ACE4020C */  jal        TextSys_WordY__Fi
    /* 2AB40 8003A340 21804000 */   addu      $s0, $v0, $zero
    /* 2AB44 8003A344 21200002 */  addu       $a0, $s0, $zero
    /* 2AB48 8003A348 21284000 */  addu       $a1, $v0, $zero
    /* 2AB4C 8003A34C 1000B3AF */  sw         $s3, 0x10($sp)
    /* 2AB50 8003A350 1400B2AF */  sw         $s2, 0x14($sp)
    /* 2AB54 8003A354 7000E78E */  lw         $a3, 0x70($s7)
    /* 2AB58 8003A358 FCE5000C */  jal        DrawMoney__Fiiilii
    /* 2AB5C 8003A35C 06000624 */   addiu     $a2, $zero, 0x6
  .L8003A360:
    /* 2AB60 8003A360 94E4020C */  jal        TextSys_Word__Fi
    /* 2AB64 8003A364 15030424 */   addiu     $a0, $zero, 0x315
    /* 2AB68 8003A368 FA020424 */  addiu      $a0, $zero, 0x2FA
    /* 2AB6C 8003A36C A4E4020C */  jal        TextSys_WordX__Fi
    /* 2AB70 8003A370 21884000 */   addu      $s1, $v0, $zero
    /* 2AB74 8003A374 15030424 */  addiu      $a0, $zero, 0x315
    /* 2AB78 8003A378 00840200 */  sll        $s0, $v0, 16
    /* 2AB7C 8003A37C ACE4020C */  jal        TextSys_WordY__Fi
    /* 2AB80 8003A380 03841000 */   sra       $s0, $s0, 16
    /* 2AB84 8003A384 2120C003 */  addu       $a0, $fp, $zero
    /* 2AB88 8003A388 21282002 */  addu       $a1, $s1, $zero
    /* 2AB8C 8003A38C 21300002 */  addu       $a2, $s0, $zero
    /* 2AB90 8003A390 00140200 */  sll        $v0, $v0, 16
    /* 2AB94 8003A394 033C0200 */  sra        $a3, $v0, 16
    /* 2AB98 8003A398 0B000924 */  addiu      $t1, $zero, 0xB
    /* 2AB9C 8003A39C 02000224 */  addiu      $v0, $zero, 0x2
    /* 2ABA0 8003A3A0 1400A2AF */  sw         $v0, 0x14($sp)
    /* 2ABA4 8003A3A4 01000224 */  addiu      $v0, $zero, 0x1
    /* 2ABA8 8003A3A8 1000A9AF */  sw         $t1, 0x10($sp)
    /* 2ABAC 8003A3AC D183000C */  jal        FETextRender_FullTextFade__FiPcss13tMenuTextType14tMenuTextStates
    /* 2ABB0 8003A3B0 1800A2AF */   sw        $v0, 0x18($sp)
    /* 2ABB4 8003A3B4 A4E4020C */  jal        TextSys_WordX__Fi
    /* 2ABB8 8003A3B8 FB020424 */   addiu     $a0, $zero, 0x2FB
    /* 2ABBC 8003A3BC 15030424 */  addiu      $a0, $zero, 0x315
    /* 2ABC0 8003A3C0 ACE4020C */  jal        TextSys_WordY__Fi
    /* 2ABC4 8003A3C4 21804000 */   addu      $s0, $v0, $zero
    /* 2ABC8 8003A3C8 21200002 */  addu       $a0, $s0, $zero
    /* 2ABCC 8003A3CC 21284000 */  addu       $a1, $v0, $zero
    /* 2ABD0 8003A3D0 6400E78E */  lw         $a3, 0x64($s7)
    /* 2ABD4 8003A3D4 6800E28E */  lw         $v0, 0x68($s7)
    /* 2ABD8 8003A3D8 6C00E38E */  lw         $v1, 0x6C($s7)
    /* 2ABDC 8003A3DC 7000E88E */  lw         $t0, 0x70($s7)
    /* 2ABE0 8003A3E0 09000624 */  addiu      $a2, $zero, 0x9
    /* 2ABE4 8003A3E4 1000B3AF */  sw         $s3, 0x10($sp)
    /* 2ABE8 8003A3E8 1400B2AF */  sw         $s2, 0x14($sp)
    /* 2ABEC 8003A3EC 2338E200 */  subu       $a3, $a3, $v0
    /* 2ABF0 8003A3F0 2138E300 */  addu       $a3, $a3, $v1
    /* 2ABF4 8003A3F4 FCE5000C */  jal        DrawMoney__Fiiilii
    /* 2ABF8 8003A3F8 2338E800 */   subu      $a3, $a3, $t0
    /* 2ABFC 8003A3FC 2120E002 */  addu       $a0, $s7, $zero
    /* 2AC00 8003A400 0A000524 */  addiu      $a1, $zero, 0xA
    /* 2AC04 8003A404 0580023C */  lui        $v0, %hi(gCurrentShapes)
    /* 2AC08 8003A408 CC17478C */  lw         $a3, %lo(gCurrentShapes)($v0)
    /* 2AC0C 8003A40C 1D000624 */  addiu      $a2, $zero, 0x1D
    /* 2AC10 8003A410 3297000C */  jal        DrawBackgroundImage__7tScreeniiP18tTexture_ShapeInfoi
    /* 2AC14 8003A414 1000A0AF */   sw        $zero, 0x10($sp)
    /* 2AC18 8003A418 F400BF8F */  lw         $ra, 0xF4($sp)
    /* 2AC1C 8003A41C F000BE8F */  lw         $fp, 0xF0($sp)
    /* 2AC20 8003A420 EC00B78F */  lw         $s7, 0xEC($sp)
    /* 2AC24 8003A424 E800B68F */  lw         $s6, 0xE8($sp)
    /* 2AC28 8003A428 E400B58F */  lw         $s5, 0xE4($sp)
    /* 2AC2C 8003A42C E000B48F */  lw         $s4, 0xE0($sp)
    /* 2AC30 8003A430 DC00B38F */  lw         $s3, 0xDC($sp)
    /* 2AC34 8003A434 D800B28F */  lw         $s2, 0xD8($sp)
    /* 2AC38 8003A438 D400B18F */  lw         $s1, 0xD4($sp)
    /* 2AC3C 8003A43C D000B08F */  lw         $s0, 0xD0($sp)
    /* 2AC40 8003A440 0800E003 */  jr         $ra
    /* 2AC44 8003A444 F800BD27 */   addiu     $sp, $sp, 0xF8
endlabel DrawBackground__26tScreenTournamentStandings
