.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CopSpeak_StartUp__Fv, 0x590

glabel CopSpeak_StartUp__Fv
    /* 8A53C 80099D3C 30FFBD27 */  addiu      $sp, $sp, -0xD0
    /* 8A540 80099D40 CC00BFAF */  sw         $ra, 0xCC($sp)
    /* 8A544 80099D44 C800BEAF */  sw         $fp, 0xC8($sp)
    /* 8A548 80099D48 C400B7AF */  sw         $s7, 0xC4($sp)
    /* 8A54C 80099D4C C000B6AF */  sw         $s6, 0xC0($sp)
    /* 8A550 80099D50 BC00B5AF */  sw         $s5, 0xBC($sp)
    /* 8A554 80099D54 B800B4AF */  sw         $s4, 0xB8($sp)
    /* 8A558 80099D58 B400B3AF */  sw         $s3, 0xB4($sp)
    /* 8A55C 80099D5C B000B2AF */  sw         $s2, 0xB0($sp)
    /* 8A560 80099D60 AC00B1AF */  sw         $s1, 0xAC($sp)
    /* 8A564 80099D64 DC66020C */  jal        CopSpeak_InitVars__Fv
    /* 8A568 80099D68 A800B0AF */   sw        $s0, 0xA8($sp)
    /* 8A56C 80099D6C F764020C */  jal        CopSpeak_RadioStaticInit__Fv
    /* 8A570 80099D70 00000000 */   nop
    /* 8A574 80099D74 1800A427 */  addiu      $a0, $sp, 0x18
    /* 8A578 80099D78 1180023C */  lui        $v0, %hi(D_801164D8)
    /* 8A57C 80099D7C 0580053C */  lui        $a1, %hi(D_80055EC8)
    /* 8A580 80099D80 D864468C */  lw         $a2, %lo(D_801164D8)($v0)
    /* 8A584 80099D84 2F91030C */  jal        sprintf
    /* 8A588 80099D88 C85EA524 */   addiu     $a1, $a1, %lo(D_80055EC8)
    /* 8A58C 80099D8C 1800A427 */  addiu      $a0, $sp, 0x18
    /* 8A590 80099D90 9F96030C */  jal        loadbigfileheader
    /* 8A594 80099D94 10000524 */   addiu     $a1, $zero, 0x10
    /* 8A598 80099D98 21A84000 */  addu       $s5, $v0, $zero
    /* 8A59C 80099D9C 7400A012 */  beqz       $s5, .L80099F70
    /* 8A5A0 80099DA0 1180023C */   lui       $v0, %hi(D_80111EB4)
    /* 8A5A4 80099DA4 B41E5224 */  addiu      $s2, $v0, %lo(D_80111EB4)
    /* 8A5A8 80099DA8 0C0040AE */  sw         $zero, 0xC($s2)
    /* 8A5AC 80099DAC 1180023C */  lui        $v0, %hi(GameSetup_gCarNames)
    /* 8A5B0 80099DB0 44305124 */  addiu      $s1, $v0, %lo(GameSetup_gCarNames)
    /* 8A5B4 80099DB4 1480103C */  lui        $s0, %hi(D_8013D084)
  .L80099DB8:
    /* 8A5B8 80099DB8 0C00428E */  lw         $v0, 0xC($s2)
    /* 8A5BC 80099DBC 84D00526 */  addiu      $a1, $s0, %lo(D_8013D084)
    /* 8A5C0 80099DC0 80200200 */  sll        $a0, $v0, 2
    /* 8A5C4 80099DC4 21208200 */  addu       $a0, $a0, $v0
    /* 8A5C8 80099DC8 5F97030C */  jal        strcmp
    /* 8A5CC 80099DCC 21209100 */   addu      $a0, $a0, $s1
    /* 8A5D0 80099DD0 06004010 */  beqz       $v0, .L80099DEC
    /* 8A5D4 80099DD4 21300000 */   addu      $a2, $zero, $zero
    /* 8A5D8 80099DD8 0C00428E */  lw         $v0, 0xC($s2)
    /* 8A5DC 80099DDC 00000000 */  nop
    /* 8A5E0 80099DE0 01004224 */  addiu      $v0, $v0, 0x1
    /* 8A5E4 80099DE4 6E670208 */  j          .L80099DB8
    /* 8A5E8 80099DE8 0C0042AE */   sw        $v0, 0xC($s2)
  .L80099DEC:
    /* 8A5EC 80099DEC 0580043C */  lui        $a0, %hi(D_80055ED8)
    /* 8A5F0 80099DF0 D85E8424 */  addiu      $a0, $a0, %lo(D_80055ED8)
    /* 8A5F4 80099DF4 2188C000 */  addu       $s1, $a2, $zero
    /* 8A5F8 80099DF8 0C00428E */  lw         $v0, 0xC($s2)
    /* 8A5FC 80099DFC 9800B327 */  addiu      $s3, $sp, 0x98
    /* 8A600 80099E00 40100200 */  sll        $v0, $v0, 1
    /* 8A604 80099E04 01004224 */  addiu      $v0, $v0, 0x1
    /* 8A608 80099E08 C0280200 */  sll        $a1, $v0, 3
    /* 8A60C 80099E0C CF94030C */  jal        reservememadr
    /* 8A610 80099E10 0C0042AE */   sw        $v0, 0xC($s2)
    /* 8A614 80099E14 080042AE */  sw         $v0, 0x8($s2)
    /* 8A618 80099E18 0580023C */  lui        $v0, %hi(D_80055EE4)
    /* 8A61C 80099E1C E45E4224 */  addiu      $v0, $v0, %lo(D_80055EE4)
    /* 8A620 80099E20 9800A2AF */  sw         $v0, 0x98($sp)
  .L80099E24:
    /* 8A624 80099E24 2120A002 */  addu       $a0, $s5, $zero
    /* 8A628 80099E28 0800478E */  lw         $a3, 0x8($s2)
    /* 8A62C 80099E2C C0801100 */  sll        $s0, $s1, 3
    /* 8A630 80099E30 2138F000 */  addu       $a3, $a3, $s0
    /* 8A634 80099E34 0400E224 */  addiu      $v0, $a3, 0x4
    /* 8A638 80099E38 1000A2AF */  sw         $v0, 0x10($sp)
    /* 8A63C 80099E3C 0000658E */  lw         $a1, 0x0($s3)
    /* 8A640 80099E40 FF97030C */  jal        locatebigentryz
    /* 8A644 80099E44 21300000 */   addu      $a2, $zero, $zero
    /* 8A648 80099E48 09004014 */  bnez       $v0, .L80099E70
    /* 8A64C 80099E4C 00000000 */   nop
    /* 8A650 80099E50 0800428E */  lw         $v0, 0x8($s2)
    /* 8A654 80099E54 00000000 */  nop
    /* 8A658 80099E58 21100202 */  addu       $v0, $s0, $v0
    /* 8A65C 80099E5C 000040AC */  sw         $zero, 0x0($v0)
    /* 8A660 80099E60 0800428E */  lw         $v0, 0x8($s2)
    /* 8A664 80099E64 00000000 */  nop
    /* 8A668 80099E68 21100202 */  addu       $v0, $s0, $v0
    /* 8A66C 80099E6C 040040AC */  sw         $zero, 0x4($v0)
  .L80099E70:
    /* 8A670 80099E70 01003126 */  addiu      $s1, $s1, 0x1
    /* 8A674 80099E74 EBFF201A */  blez       $s1, .L80099E24
    /* 8A678 80099E78 04007326 */   addiu     $s3, $s3, 0x4
    /* 8A67C 80099E7C 21880000 */  addu       $s1, $zero, $zero
    /* 8A680 80099E80 1480023C */  lui        $v0, %hi(D_8013D08C)
    /* 8A684 80099E84 8CD05E24 */  addiu      $fp, $v0, %lo(D_8013D08C)
    /* 8A688 80099E88 1480023C */  lui        $v0, %hi(D_8013D094)
    /* 8A68C 80099E8C 94D05724 */  addiu      $s7, $v0, %lo(D_8013D094)
    /* 8A690 80099E90 8000B427 */  addiu      $s4, $sp, 0x80
    /* 8A694 80099E94 1180023C */  lui        $v0, %hi(GameSetup_gCarNames)
    /* 8A698 80099E98 44305624 */  addiu      $s6, $v0, %lo(GameSetup_gCarNames)
    /* 8A69C 80099E9C 08001324 */  addiu      $s3, $zero, 0x8
  .L80099EA0:
    /* 8A6A0 80099EA0 0C00428E */  lw         $v0, 0xC($s2)
    /* 8A6A4 80099EA4 00000000 */  nop
    /* 8A6A8 80099EA8 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* 8A6AC 80099EAC 2A102202 */  slt        $v0, $s1, $v0
    /* 8A6B0 80099EB0 27004010 */  beqz       $v0, .L80099F50
    /* 8A6B4 80099EB4 21208002 */   addu      $a0, $s4, $zero
    /* 8A6B8 80099EB8 0580053C */  lui        $a1, %hi(D_80055EF0)
    /* 8A6BC 80099EBC F05EA524 */  addiu      $a1, $a1, %lo(D_80055EF0)
    /* 8A6C0 80099EC0 C21F1100 */  srl        $v1, $s1, 31
    /* 8A6C4 80099EC4 21182302 */  addu       $v1, $s1, $v1
    /* 8A6C8 80099EC8 43180300 */  sra        $v1, $v1, 1
    /* 8A6CC 80099ECC 40100300 */  sll        $v0, $v1, 1
    /* 8A6D0 80099ED0 23102202 */  subu       $v0, $s1, $v0
    /* 8A6D4 80099ED4 80100200 */  sll        $v0, $v0, 2
    /* 8A6D8 80099ED8 2110A203 */  addu       $v0, $sp, $v0
    /* 8A6DC 80099EDC 80300300 */  sll        $a2, $v1, 2
    /* 8A6E0 80099EE0 2130C300 */  addu       $a2, $a2, $v1
    /* 8A6E4 80099EE4 9000BEAF */  sw         $fp, 0x90($sp)
    /* 8A6E8 80099EE8 9400B7AF */  sw         $s7, 0x94($sp)
    /* 8A6EC 80099EEC 9000478C */  lw         $a3, 0x90($v0)
    /* 8A6F0 80099EF0 2F91030C */  jal        sprintf
    /* 8A6F4 80099EF4 2130D600 */   addu      $a2, $a2, $s6
    /* 8A6F8 80099EF8 2120A002 */  addu       $a0, $s5, $zero
    /* 8A6FC 80099EFC 21288002 */  addu       $a1, $s4, $zero
    /* 8A700 80099F00 21300000 */  addu       $a2, $zero, $zero
    /* 8A704 80099F04 0800478E */  lw         $a3, 0x8($s2)
    /* 8A708 80099F08 C0801100 */  sll        $s0, $s1, 3
    /* 8A70C 80099F0C 2138F300 */  addu       $a3, $a3, $s3
    /* 8A710 80099F10 0400E224 */  addiu      $v0, $a3, 0x4
    /* 8A714 80099F14 FF97030C */  jal        locatebigentryz
    /* 8A718 80099F18 1000A2AF */   sw        $v0, 0x10($sp)
    /* 8A71C 80099F1C 09004014 */  bnez       $v0, .L80099F44
    /* 8A720 80099F20 00000000 */   nop
    /* 8A724 80099F24 0800428E */  lw         $v0, 0x8($s2)
    /* 8A728 80099F28 00000000 */  nop
    /* 8A72C 80099F2C 21100202 */  addu       $v0, $s0, $v0
    /* 8A730 80099F30 080040AC */  sw         $zero, 0x8($v0)
    /* 8A734 80099F34 0800428E */  lw         $v0, 0x8($s2)
    /* 8A738 80099F38 00000000 */  nop
    /* 8A73C 80099F3C 21100202 */  addu       $v0, $s0, $v0
    /* 8A740 80099F40 0C0040AC */  sw         $zero, 0xC($v0)
  .L80099F44:
    /* 8A744 80099F44 08007326 */  addiu      $s3, $s3, 0x8
    /* 8A748 80099F48 A8670208 */  j          .L80099EA0
    /* 8A74C 80099F4C 01003126 */   addiu     $s1, $s1, 0x1
  .L80099F50:
    /* 8A750 80099F50 5095030C */  jal        purgememadr
    /* 8A754 80099F54 2120A002 */   addu      $a0, $s5, $zero
    /* 8A758 80099F58 1800A427 */  addiu      $a0, $sp, 0x18
    /* 8A75C 80099F5C 01000524 */  addiu      $a1, $zero, 0x1
    /* 8A760 80099F60 64000624 */  addiu      $a2, $zero, 0x64
    /* 8A764 80099F64 2AAA030C */  jal        FILE_opensync
    /* 8A768 80099F68 21384002 */   addu      $a3, $s2, $zero
    /* 8A76C 80099F6C 040042AE */  sw         $v0, 0x4($s2)
  .L80099F70:
    /* 8A770 80099F70 1800A427 */  addiu      $a0, $sp, 0x18
    /* 8A774 80099F74 1180023C */  lui        $v0, %hi(Paths_Paths)
    /* 8A778 80099F78 68645024 */  addiu      $s0, $v0, %lo(Paths_Paths)
    /* 8A77C 80099F7C 0580053C */  lui        $a1, %hi(D_80055F00)
    /* 8A780 80099F80 1180023C */  lui        $v0, %hi(D_80113228)
    /* 8A784 80099F84 005FA524 */  addiu      $a1, $a1, %lo(D_80055F00)
    /* 8A788 80099F88 1180073C */  lui        $a3, %hi(GameSetup_gTrackNames)
    /* 8A78C 80099F8C 7000068E */  lw         $a2, 0x70($s0)
    /* 8A790 80099F90 2832428C */  lw         $v0, %lo(D_80113228)($v0)
    /* 8A794 80099F94 4431E724 */  addiu      $a3, $a3, %lo(GameSetup_gTrackNames)
    /* 8A798 80099F98 880B80AF */  sw         $zero, %gp_rel(CopSpeak_gNumTrackSfx)($gp)
    /* 8A79C 80099F9C 80100200 */  sll        $v0, $v0, 2
    /* 8A7A0 80099FA0 2F91030C */  jal        sprintf
    /* 8A7A4 80099FA4 21384700 */   addu      $a3, $v0, $a3
    /* 8A7A8 80099FA8 1800A427 */  addiu      $a0, $sp, 0x18
    /* 8A7AC 80099FAC 9F96030C */  jal        loadbigfileheader
    /* 8A7B0 80099FB0 10000524 */   addiu     $a1, $zero, 0x10
    /* 8A7B4 80099FB4 21A84000 */  addu       $s5, $v0, $zero
    /* 8A7B8 80099FB8 0C00A016 */  bnez       $s5, .L80099FEC
    /* 8A7BC 80099FBC 2120A002 */   addu      $a0, $s5, $zero
    /* 8A7C0 80099FC0 1800A427 */  addiu      $a0, $sp, 0x18
    /* 8A7C4 80099FC4 7000068E */  lw         $a2, 0x70($s0)
    /* 8A7C8 80099FC8 0580053C */  lui        $a1, %hi(D_80055F10)
    /* 8A7CC 80099FCC 2F91030C */  jal        sprintf
    /* 8A7D0 80099FD0 105FA524 */   addiu     $a1, $a1, %lo(D_80055F10)
    /* 8A7D4 80099FD4 1800A427 */  addiu      $a0, $sp, 0x18
    /* 8A7D8 80099FD8 9F96030C */  jal        loadbigfileheader
    /* 8A7DC 80099FDC 10000524 */   addiu     $a1, $zero, 0x10
    /* 8A7E0 80099FE0 21A84000 */  addu       $s5, $v0, $zero
    /* 8A7E4 80099FE4 2500A012 */  beqz       $s5, .L8009A07C
    /* 8A7E8 80099FE8 2120A002 */   addu      $a0, $s5, $zero
  .L80099FEC:
    /* 8A7EC 80099FEC 1180023C */  lui        $v0, %hi(Copspeak_gBank)
    /* 8A7F0 80099FF0 9698030C */  jal        bigcount
    /* 8A7F4 80099FF4 A41E5124 */   addiu     $s1, $v0, %lo(Copspeak_gBank)
    /* 8A7F8 80099FF8 0580043C */  lui        $a0, %hi(D_80055F20)
    /* 8A7FC 80099FFC 205F8424 */  addiu      $a0, $a0, %lo(D_80055F20)
    /* 8A800 8009A000 C0280200 */  sll        $a1, $v0, 3
    /* 8A804 8009A004 21300000 */  addu       $a2, $zero, $zero
    /* 8A808 8009A008 CF94030C */  jal        reservememadr
    /* 8A80C 8009A00C 0C0022AE */   sw        $v0, 0xC($s1)
    /* 8A810 8009A010 0C00238E */  lw         $v1, 0xC($s1)
    /* 8A814 8009A014 080022AE */  sw         $v0, 0x8($s1)
    /* 8A818 8009A018 880B83AF */  sw         $v1, %gp_rel(CopSpeak_gNumTrackSfx)($gp)
    /* 8A81C 8009A01C 0F006018 */  blez       $v1, .L8009A05C
    /* 8A820 8009A020 21800000 */   addu      $s0, $zero, $zero
    /* 8A824 8009A024 2120A002 */  addu       $a0, $s5, $zero
  .L8009A028:
    /* 8A828 8009A028 21280000 */  addu       $a1, $zero, $zero
    /* 8A82C 8009A02C 21300002 */  addu       $a2, $s0, $zero
    /* 8A830 8009A030 0800278E */  lw         $a3, 0x8($s1)
    /* 8A834 8009A034 C0101000 */  sll        $v0, $s0, 3
    /* 8A838 8009A038 2138E200 */  addu       $a3, $a3, $v0
    /* 8A83C 8009A03C 0400E224 */  addiu      $v0, $a3, 0x4
    /* 8A840 8009A040 6E98030C */  jal        locatebigentry
    /* 8A844 8009A044 1000A2AF */   sw        $v0, 0x10($sp)
    /* 8A848 8009A048 0C00228E */  lw         $v0, 0xC($s1)
    /* 8A84C 8009A04C 01001026 */  addiu      $s0, $s0, 0x1
    /* 8A850 8009A050 2A100202 */  slt        $v0, $s0, $v0
    /* 8A854 8009A054 F4FF4014 */  bnez       $v0, .L8009A028
    /* 8A858 8009A058 2120A002 */   addu      $a0, $s5, $zero
  .L8009A05C:
    /* 8A85C 8009A05C 5095030C */  jal        purgememadr
    /* 8A860 8009A060 2120A002 */   addu      $a0, $s5, $zero
    /* 8A864 8009A064 1800A427 */  addiu      $a0, $sp, 0x18
    /* 8A868 8009A068 01000524 */  addiu      $a1, $zero, 0x1
    /* 8A86C 8009A06C 64000624 */  addiu      $a2, $zero, 0x64
    /* 8A870 8009A070 2AAA030C */  jal        FILE_opensync
    /* 8A874 8009A074 21382002 */   addu      $a3, $s1, $zero
    /* 8A878 8009A078 040022AE */  sw         $v0, 0x4($s1)
  .L8009A07C:
    /* 8A87C 8009A07C 1180023C */  lui        $v0, %hi(D_801132CC)
    /* 8A880 8009A080 CC32438C */  lw         $v1, %lo(D_801132CC)($v0)
    /* 8A884 8009A084 01000224 */  addiu      $v0, $zero, 0x1
    /* 8A888 8009A088 06006210 */  beq        $v1, $v0, .L8009A0A4
    /* 8A88C 8009A08C 02000224 */   addiu     $v0, $zero, 0x2
    /* 8A890 8009A090 07006214 */  bne        $v1, $v0, .L8009A0B0
    /* 8A894 8009A094 1480023C */   lui       $v0, %hi(D_8013D0A4)
    /* 8A898 8009A098 1480023C */  lui        $v0, %hi(D_8013D09C)
    /* 8A89C 8009A09C 2D680208 */  j          .L8009A0B4
    /* 8A8A0 8009A0A0 9CD04724 */   addiu     $a3, $v0, %lo(D_8013D09C)
  .L8009A0A4:
    /* 8A8A4 8009A0A4 1480023C */  lui        $v0, %hi(D_8013D0A0)
    /* 8A8A8 8009A0A8 2D680208 */  j          .L8009A0B4
    /* 8A8AC 8009A0AC A0D04724 */   addiu     $a3, $v0, %lo(D_8013D0A0)
  .L8009A0B0:
    /* 8A8B0 8009A0B0 A4D04724 */  addiu      $a3, $v0, %lo(D_8013D0A4)
  .L8009A0B4:
    /* 8A8B4 8009A0B4 1800A427 */  addiu      $a0, $sp, 0x18
    /* 8A8B8 8009A0B8 0580053C */  lui        $a1, %hi(D_80055F2C)
    /* 8A8BC 8009A0BC 1180023C */  lui        $v0, %hi(D_801164DC)
    /* 8A8C0 8009A0C0 DC64468C */  lw         $a2, %lo(D_801164DC)($v0)
    /* 8A8C4 8009A0C4 2F91030C */  jal        sprintf
    /* 8A8C8 8009A0C8 2C5FA524 */   addiu     $a1, $a1, %lo(D_80055F2C)
    /* 8A8CC 8009A0CC 1800A427 */  addiu      $a0, $sp, 0x18
    /* 8A8D0 8009A0D0 9F96030C */  jal        loadbigfileheader
    /* 8A8D4 8009A0D4 10000524 */   addiu     $a1, $zero, 0x10
    /* 8A8D8 8009A0D8 21A84000 */  addu       $s5, $v0, $zero
    /* 8A8DC 8009A0DC 6A00A012 */  beqz       $s5, .L8009A288
    /* 8A8E0 8009A0E0 A000A227 */   addiu     $v0, $sp, 0xA0
    /* 8A8E4 8009A0E4 1000A2AF */  sw         $v0, 0x10($sp)
    /* 8A8E8 8009A0E8 2120A002 */  addu       $a0, $s5, $zero
    /* 8A8EC 8009A0EC 0580053C */  lui        $a1, %hi(D_80055F3C)
    /* 8A8F0 8009A0F0 3C5FA524 */  addiu      $a1, $a1, %lo(D_80055F3C)
    /* 8A8F4 8009A0F4 21300000 */  addu       $a2, $zero, $zero
    /* 8A8F8 8009A0F8 9C00A727 */  addiu      $a3, $sp, 0x9C
    /* 8A8FC 8009A0FC 1180103C */  lui        $s0, %hi(D_80111EC4)
    /* 8A900 8009A100 FF97030C */  jal        locatebigentryz
    /* 8A904 8009A104 C41E1726 */   addiu     $s7, $s0, %lo(D_80111EC4)
    /* 8A908 8009A108 5D004010 */  beqz       $v0, .L8009A280
    /* 8A90C 8009A10C 00000000 */   nop
    /* 8A910 8009A110 A000A58F */  lw         $a1, 0xA0($sp)
    /* 8A914 8009A114 00000000 */  nop
    /* 8A918 8009A118 5900A010 */  beqz       $a1, .L8009A280
    /* 8A91C 8009A11C 0580043C */   lui       $a0, %hi(D_80055F4C)
    /* 8A920 8009A120 4C5F8424 */  addiu      $a0, $a0, %lo(D_80055F4C)
    /* 8A924 8009A124 CF94030C */  jal        reservememadr
    /* 8A928 8009A128 10000624 */   addiu     $a2, $zero, 0x10
    /* 8A92C 8009A12C 1800A427 */  addiu      $a0, $sp, 0x18
    /* 8A930 8009A130 01000524 */  addiu      $a1, $zero, 0x1
    /* 8A934 8009A134 64000624 */  addiu      $a2, $zero, 0x64
    /* 8A938 8009A138 2138E002 */  addu       $a3, $s7, $zero
    /* 8A93C 8009A13C 2AAA030C */  jal        FILE_opensync
    /* 8A940 8009A140 21984000 */   addu      $s3, $v0, $zero
    /* 8A944 8009A144 21306002 */  addu       $a2, $s3, $zero
    /* 8A948 8009A148 C41E048E */  lw         $a0, %lo(D_80111EC4)($s0)
    /* 8A94C 8009A14C 21806002 */  addu       $s0, $s3, $zero
    /* 8A950 8009A150 0400E2AE */  sw         $v0, 0x4($s7)
    /* 8A954 8009A154 9C00A58F */  lw         $a1, 0x9C($sp)
    /* 8A958 8009A158 A000A78F */  lw         $a3, 0xA0($sp)
    /* 8A95C 8009A15C 64000224 */  addiu      $v0, $zero, 0x64
    /* 8A960 8009A160 48AA030C */  jal        FILE_readsync
    /* 8A964 8009A164 1000A2AF */   sw        $v0, 0x10($sp)
    /* 8A968 8009A168 A000A28F */  lw         $v0, 0xA0($sp)
    /* 8A96C 8009A16C 21900000 */  addu       $s2, $zero, $zero
    /* 8A970 8009A170 21186202 */  addu       $v1, $s3, $v0
    /* 8A974 8009A174 2B106302 */  sltu       $v0, $s3, $v1
    /* 8A978 8009A178 11004010 */  beqz       $v0, .L8009A1C0
    /* 8A97C 8009A17C 0C00E0AE */   sw        $zero, 0xC($s7)
    /* 8A980 8009A180 22000424 */  addiu      $a0, $zero, 0x22
  .L8009A184:
    /* 8A984 8009A184 00000292 */  lbu        $v0, 0x0($s0)
    /* 8A988 8009A188 00000000 */  nop
    /* 8A98C 8009A18C 08004414 */  bne        $v0, $a0, .L8009A1B0
    /* 8A990 8009A190 00000000 */   nop
    /* 8A994 8009A194 05004012 */  beqz       $s2, .L8009A1AC
    /* 8A998 8009A198 00000000 */   nop
    /* 8A99C 8009A19C 0C00E28E */  lw         $v0, 0xC($s7)
    /* 8A9A0 8009A1A0 00000000 */  nop
    /* 8A9A4 8009A1A4 01004224 */  addiu      $v0, $v0, 0x1
    /* 8A9A8 8009A1A8 0C00E2AE */  sw         $v0, 0xC($s7)
  .L8009A1AC:
    /* 8A9AC 8009A1AC 0100522E */  sltiu      $s2, $s2, 0x1
  .L8009A1B0:
    /* 8A9B0 8009A1B0 01001026 */  addiu      $s0, $s0, 0x1
    /* 8A9B4 8009A1B4 2B100302 */  sltu       $v0, $s0, $v1
    /* 8A9B8 8009A1B8 F2FF4014 */  bnez       $v0, .L8009A184
    /* 8A9BC 8009A1BC 00000000 */   nop
  .L8009A1C0:
    /* 8A9C0 8009A1C0 0580043C */  lui        $a0, %hi(D_80055F5C)
    /* 8A9C4 8009A1C4 5C5F8424 */  addiu      $a0, $a0, %lo(D_80055F5C)
    /* 8A9C8 8009A1C8 21300000 */  addu       $a2, $zero, $zero
    /* 8A9CC 8009A1CC 21A0C000 */  addu       $s4, $a2, $zero
    /* 8A9D0 8009A1D0 21B06002 */  addu       $s6, $s3, $zero
    /* 8A9D4 8009A1D4 0C00E58E */  lw         $a1, 0xC($s7)
    /* 8A9D8 8009A1D8 21806002 */  addu       $s0, $s3, $zero
    /* 8A9DC 8009A1DC CF94030C */  jal        reservememadr
    /* 8A9E0 8009A1E0 C0280500 */   sll       $a1, $a1, 3
    /* 8A9E4 8009A1E4 A000A38F */  lw         $v1, 0xA0($sp)
    /* 8A9E8 8009A1E8 21900000 */  addu       $s2, $zero, $zero
    /* 8A9EC 8009A1EC 21186302 */  addu       $v1, $s3, $v1
    /* 8A9F0 8009A1F0 2B186302 */  sltu       $v1, $s3, $v1
    /* 8A9F4 8009A1F4 20006010 */  beqz       $v1, .L8009A278
    /* 8A9F8 8009A1F8 0800E2AE */   sw        $v0, 0x8($s7)
  .L8009A1FC:
    /* 8A9FC 8009A1FC 00000392 */  lbu        $v1, 0x0($s0)
    /* 8AA00 8009A200 22000224 */  addiu      $v0, $zero, 0x22
    /* 8AA04 8009A204 16006214 */  bne        $v1, $v0, .L8009A260
    /* 8AA08 8009A208 00000000 */   nop
    /* 8AA0C 8009A20C 03004016 */  bnez       $s2, .L8009A21C
    /* 8AA10 8009A210 2120A002 */   addu      $a0, $s5, $zero
    /* 8AA14 8009A214 97680208 */  j          .L8009A25C
    /* 8AA18 8009A218 01001626 */   addiu     $s6, $s0, 0x1
  .L8009A21C:
    /* 8AA1C 8009A21C 2128C002 */  addu       $a1, $s6, $zero
    /* 8AA20 8009A220 21300000 */  addu       $a2, $zero, $zero
    /* 8AA24 8009A224 000000A2 */  sb         $zero, 0x0($s0)
    /* 8AA28 8009A228 0800E78E */  lw         $a3, 0x8($s7)
    /* 8AA2C 8009A22C C0881400 */  sll        $s1, $s4, 3
    /* 8AA30 8009A230 2138F100 */  addu       $a3, $a3, $s1
    /* 8AA34 8009A234 0400E224 */  addiu      $v0, $a3, 0x4
    /* 8AA38 8009A238 FF97030C */  jal        locatebigentryz
    /* 8AA3C 8009A23C 1000A2AF */   sw        $v0, 0x10($sp)
    /* 8AA40 8009A240 05004014 */  bnez       $v0, .L8009A258
    /* 8AA44 8009A244 00000000 */   nop
    /* 8AA48 8009A248 0800E28E */  lw         $v0, 0x8($s7)
    /* 8AA4C 8009A24C 00000000 */  nop
    /* 8AA50 8009A250 21102202 */  addu       $v0, $s1, $v0
    /* 8AA54 8009A254 040040AC */  sw         $zero, 0x4($v0)
  .L8009A258:
    /* 8AA58 8009A258 01009426 */  addiu      $s4, $s4, 0x1
  .L8009A25C:
    /* 8AA5C 8009A25C 0100523A */  xori       $s2, $s2, 0x1
  .L8009A260:
    /* 8AA60 8009A260 A000A28F */  lw         $v0, 0xA0($sp)
    /* 8AA64 8009A264 01001026 */  addiu      $s0, $s0, 0x1
    /* 8AA68 8009A268 21106202 */  addu       $v0, $s3, $v0
    /* 8AA6C 8009A26C 2B100202 */  sltu       $v0, $s0, $v0
    /* 8AA70 8009A270 E2FF4014 */  bnez       $v0, .L8009A1FC
    /* 8AA74 8009A274 00000000 */   nop
  .L8009A278:
    /* 8AA78 8009A278 5095030C */  jal        purgememadr
    /* 8AA7C 8009A27C 21206002 */   addu      $a0, $s3, $zero
  .L8009A280:
    /* 8AA80 8009A280 5095030C */  jal        purgememadr
    /* 8AA84 8009A284 2120A002 */   addu      $a0, $s5, $zero
  .L8009A288:
    /* 8AA88 8009A288 00800434 */  ori        $a0, $zero, 0x8000
    /* 8AA8C 8009A28C 0580053C */  lui        $a1, %hi(D_80055F68)
    /* 8AA90 8009A290 2D71030C */  jal        Platform_GetDCTBuffer__FiPc
    /* 8AA94 8009A294 685FA524 */   addiu     $a1, $a1, %lo(D_80055F68)
    /* 8AA98 8009A298 CC00BF8F */  lw         $ra, 0xCC($sp)
    /* 8AA9C 8009A29C C800BE8F */  lw         $fp, 0xC8($sp)
    /* 8AAA0 8009A2A0 C400B78F */  lw         $s7, 0xC4($sp)
    /* 8AAA4 8009A2A4 C000B68F */  lw         $s6, 0xC0($sp)
    /* 8AAA8 8009A2A8 BC00B58F */  lw         $s5, 0xBC($sp)
    /* 8AAAC 8009A2AC B800B48F */  lw         $s4, 0xB8($sp)
    /* 8AAB0 8009A2B0 B400B38F */  lw         $s3, 0xB4($sp)
    /* 8AAB4 8009A2B4 B000B28F */  lw         $s2, 0xB0($sp)
    /* 8AAB8 8009A2B8 AC00B18F */  lw         $s1, 0xAC($sp)
    /* 8AABC 8009A2BC A800B08F */  lw         $s0, 0xA8($sp)
    /* 8AAC0 8009A2C0 980B82AF */  sw         $v0, %gp_rel(CopSpeak_gBuffer)($gp)
    /* 8AAC4 8009A2C4 0800E003 */  jr         $ra
    /* 8AAC8 8009A2C8 D000BD27 */   addiu     $sp, $sp, 0xD0
endlabel CopSpeak_StartUp__Fv
