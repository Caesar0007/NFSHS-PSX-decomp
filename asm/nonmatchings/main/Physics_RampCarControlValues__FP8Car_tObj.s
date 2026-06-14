.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Physics_RampCarControlValues__FP8Car_tObj, 0x7D8

glabel Physics_RampCarControlValues__FP8Car_tObj
    /* 9A50C 800A9D0C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 9A510 800A9D10 1400B1AF */  sw         $s1, 0x14($sp)
    /* 9A514 800A9D14 21888000 */  addu       $s1, $a0, $zero
    /* 9A518 800A9D18 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 9A51C 800A9D1C 1800B2AF */  sw         $s2, 0x18($sp)
    /* 9A520 800A9D20 1000B0AF */  sw         $s0, 0x10($sp)
    /* 9A524 800A9D24 6004228E */  lw         $v0, 0x460($s1)
    /* 9A528 800A9D28 00000000 */  nop
    /* 9A52C 800A9D2C 08004010 */  beqz       $v0, .L800A9D50
    /* 9A530 800A9D30 00000000 */   nop
    /* 9A534 800A9D34 42042292 */  lbu        $v0, 0x442($s1)
    /* 9A538 800A9D38 00000000 */  nop
    /* 9A53C 800A9D3C 0200422C */  sltiu      $v0, $v0, 0x2
    /* 9A540 800A9D40 03004010 */  beqz       $v0, .L800A9D50
    /* 9A544 800A9D44 02000224 */   addiu     $v0, $zero, 0x2
    /* 9A548 800A9D48 3E0422A2 */  sb         $v0, 0x43E($s1)
    /* 9A54C 800A9D4C 420422A2 */  sb         $v0, 0x442($s1)
  .L800A9D50:
    /* 9A550 800A9D50 9003228E */  lw         $v0, 0x390($s1)
    /* 9A554 800A9D54 00000000 */  nop
    /* 9A558 800A9D58 02004228 */  slti       $v0, $v0, 0x2
    /* 9A55C 800A9D5C 21004014 */  bnez       $v0, .L800A9DE4
    /* 9A560 800A9D60 FF000224 */   addiu     $v0, $zero, 0xFF
    /* 9A564 800A9D64 AC00238E */  lw         $v1, 0xAC($s1)
    /* 9A568 800A9D68 500420AE */  sw         $zero, 0x450($s1)
    /* 9A56C 800A9D6C 3F0420A2 */  sb         $zero, 0x43F($s1)
    /* 9A570 800A9D70 400422A2 */  sb         $v0, 0x440($s1)
    /* 9A574 800A9D74 430420A2 */  sb         $zero, 0x443($s1)
    /* 9A578 800A9D78 C0110300 */  sll        $v0, $v1, 7
    /* 9A57C 800A9D7C 23104300 */  subu       $v0, $v0, $v1
    /* 9A580 800A9D80 40100200 */  sll        $v0, $v0, 1
    /* 9A584 800A9D84 02004104 */  bgez       $v0, .L800A9D90
    /* 9A588 800A9D88 540420AE */   sw        $zero, 0x454($s1)
    /* 9A58C 800A9D8C FF004224 */  addiu      $v0, $v0, 0xFF
  .L800A9D90:
    /* 9A590 800A9D90 B000238E */  lw         $v1, 0xB0($s1)
    /* 9A594 800A9D94 03120200 */  sra        $v0, $v0, 8
    /* 9A598 800A9D98 AC0022AE */  sw         $v0, 0xAC($s1)
    /* 9A59C 800A9D9C C0110300 */  sll        $v0, $v1, 7
    /* 9A5A0 800A9DA0 23104300 */  subu       $v0, $v0, $v1
    /* 9A5A4 800A9DA4 40100200 */  sll        $v0, $v0, 1
    /* 9A5A8 800A9DA8 02004104 */  bgez       $v0, .L800A9DB4
    /* 9A5AC 800A9DAC 00000000 */   nop
    /* 9A5B0 800A9DB0 FF004224 */  addiu      $v0, $v0, 0xFF
  .L800A9DB4:
    /* 9A5B4 800A9DB4 B400238E */  lw         $v1, 0xB4($s1)
    /* 9A5B8 800A9DB8 03120200 */  sra        $v0, $v0, 8
    /* 9A5BC 800A9DBC B00022AE */  sw         $v0, 0xB0($s1)
    /* 9A5C0 800A9DC0 C0110300 */  sll        $v0, $v1, 7
    /* 9A5C4 800A9DC4 23104300 */  subu       $v0, $v0, $v1
    /* 9A5C8 800A9DC8 40100200 */  sll        $v0, $v0, 1
    /* 9A5CC 800A9DCC 02004104 */  bgez       $v0, .L800A9DD8
    /* 9A5D0 800A9DD0 00000000 */   nop
    /* 9A5D4 800A9DD4 FF004224 */  addiu      $v0, $v0, 0xFF
  .L800A9DD8:
    /* 9A5D8 800A9DD8 03120200 */  sra        $v0, $v0, 8
    /* 9A5DC 800A9DDC 8DA80208 */  j          .L800AA234
    /* 9A5E0 800A9DE0 B40022AE */   sw        $v0, 0xB4($s1)
  .L800A9DE4:
    /* 9A5E4 800A9DE4 8802228E */  lw         $v0, 0x288($s1)
    /* 9A5E8 800A9DE8 00000000 */  nop
    /* 9A5EC 800A9DEC 1C00428C */  lw         $v0, 0x1C($v0)
    /* 9A5F0 800A9DF0 00000000 */  nop
    /* 9A5F4 800A9DF4 02004010 */  beqz       $v0, .L800A9E00
    /* 9A5F8 800A9DF8 30000424 */   addiu     $a0, $zero, 0x30
    /* 9A5FC 800A9DFC 24000424 */  addiu      $a0, $zero, 0x24
  .L800A9E00:
    /* 9A600 800A9E00 3C042292 */  lbu        $v0, 0x43C($s1)
    /* 9A604 800A9E04 3F042592 */  lbu        $a1, 0x43F($s1)
    /* 9A608 800A9E08 00000000 */  nop
    /* 9A60C 800A9E0C 23184500 */  subu       $v1, $v0, $a1
    /* 9A610 800A9E10 07006004 */  bltz       $v1, .L800A9E30
    /* 9A614 800A9E14 00000000 */   nop
    /* 9A618 800A9E18 FF008430 */  andi       $a0, $a0, 0xFF
    /* 9A61C 800A9E1C 2A106400 */  slt        $v0, $v1, $a0
    /* 9A620 800A9E20 09004014 */  bnez       $v0, .L800A9E48
    /* 9A624 800A9E24 2110A300 */   addu      $v0, $a1, $v1
    /* 9A628 800A9E28 92A70208 */  j          .L800A9E48
    /* 9A62C 800A9E2C 2110A400 */   addu      $v0, $a1, $a0
  .L800A9E30:
    /* 9A630 800A9E30 FF008430 */  andi       $a0, $a0, 0xFF
    /* 9A634 800A9E34 23180300 */  negu       $v1, $v1
    /* 9A638 800A9E38 2A106400 */  slt        $v0, $v1, $a0
    /* 9A63C 800A9E3C 02004014 */  bnez       $v0, .L800A9E48
    /* 9A640 800A9E40 2310A300 */   subu      $v0, $a1, $v1
    /* 9A644 800A9E44 2310A400 */  subu       $v0, $a1, $a0
  .L800A9E48:
    /* 9A648 800A9E48 3F0422A2 */  sb         $v0, 0x43F($s1)
    /* 9A64C 800A9E4C 8802228E */  lw         $v0, 0x288($s1)
    /* 9A650 800A9E50 00000000 */  nop
    /* 9A654 800A9E54 2000428C */  lw         $v0, 0x20($v0)
    /* 9A658 800A9E58 00000000 */  nop
    /* 9A65C 800A9E5C 11004010 */  beqz       $v0, .L800A9EA4
    /* 9A660 800A9E60 00000000 */   nop
    /* 9A664 800A9E64 3D042292 */  lbu        $v0, 0x43D($s1)
    /* 9A668 800A9E68 40042492 */  lbu        $a0, 0x440($s1)
    /* 9A66C 800A9E6C 00000000 */  nop
    /* 9A670 800A9E70 23184400 */  subu       $v1, $v0, $a0
    /* 9A674 800A9E74 05006004 */  bltz       $v1, .L800A9E8C
    /* 9A678 800A9E78 10006228 */   slti      $v0, $v1, 0x10
    /* 9A67C 800A9E7C 0A004014 */  bnez       $v0, .L800A9EA8
    /* 9A680 800A9E80 21108300 */   addu      $v0, $a0, $v1
    /* 9A684 800A9E84 AAA70208 */  j          .L800A9EA8
    /* 9A688 800A9E88 10008224 */   addiu     $v0, $a0, 0x10
  .L800A9E8C:
    /* 9A68C 800A9E8C 23180300 */  negu       $v1, $v1
    /* 9A690 800A9E90 10006228 */  slti       $v0, $v1, 0x10
    /* 9A694 800A9E94 04004014 */  bnez       $v0, .L800A9EA8
    /* 9A698 800A9E98 23108300 */   subu      $v0, $a0, $v1
    /* 9A69C 800A9E9C AAA70208 */  j          .L800A9EA8
    /* 9A6A0 800A9EA0 F0FF8224 */   addiu     $v0, $a0, -0x10
  .L800A9EA4:
    /* 9A6A4 800A9EA4 3D042292 */  lbu        $v0, 0x43D($s1)
  .L800A9EA8:
    /* 9A6A8 800A9EA8 00000000 */  nop
    /* 9A6AC 800A9EAC 400422A2 */  sb         $v0, 0x440($s1)
    /* 9A6B0 800A9EB0 44042292 */  lbu        $v0, 0x444($s1)
    /* 9A6B4 800A9EB4 00000000 */  nop
    /* 9A6B8 800A9EB8 02004010 */  beqz       $v0, .L800A9EC4
    /* 9A6BC 800A9EBC FFFF4224 */   addiu     $v0, $v0, -0x1
    /* 9A6C0 800A9EC0 440422A2 */  sb         $v0, 0x444($s1)
  .L800A9EC4:
    /* 9A6C4 800A9EC4 1280023C */  lui        $v0, %hi(D_8011E0B0)
    /* 9A6C8 800A9EC8 B0E0458C */  lw         $a1, %lo(D_8011E0B0)($v0)
    /* 9A6CC 800A9ECC 00000000 */  nop
    /* 9A6D0 800A9ED0 0102A228 */  slti       $v0, $a1, 0x201
    /* 9A6D4 800A9ED4 BD004014 */  bnez       $v0, .L800AA1CC
    /* 9A6D8 800A9ED8 1180063C */   lui       $a2, %hi(GameSetup_gData)
    /* 9A6DC 800A9EDC 5402228E */  lw         $v0, 0x254($s1)
    /* 9A6E0 800A9EE0 EC31C424 */  addiu      $a0, $a2, %lo(GameSetup_gData)
    /* 9A6E4 800A9EE4 40180200 */  sll        $v1, $v0, 1
    /* 9A6E8 800A9EE8 21186200 */  addu       $v1, $v1, $v0
    /* 9A6EC 800A9EEC 00110300 */  sll        $v0, $v1, 4
    /* 9A6F0 800A9EF0 23104300 */  subu       $v0, $v0, $v1
    /* 9A6F4 800A9EF4 80100200 */  sll        $v0, $v0, 2
    /* 9A6F8 800A9EF8 21104400 */  addu       $v0, $v0, $a0
    /* 9A6FC 800A9EFC DC03438C */  lw         $v1, 0x3DC($v0)
    /* 9A700 800A9F00 01000224 */  addiu      $v0, $zero, 0x1
    /* 9A704 800A9F04 61006214 */  bne        $v1, $v0, .L800AA08C
    /* 9A708 800A9F08 0802A228 */   slti      $v0, $a1, 0x208
    /* 9A70C 800A9F0C 1D004010 */  beqz       $v0, .L800A9F84
    /* 9A710 800A9F10 00000000 */   nop
    /* 9A714 800A9F14 EC31C48C */  lw         $a0, %lo(GameSetup_gData)($a2)
    /* 9A718 800A9F18 00000000 */  nop
    /* 9A71C 800A9F1C 03008310 */  beq        $a0, $v1, .L800A9F2C
    /* 9A720 800A9F20 05000224 */   addiu     $v0, $zero, 0x5
    /* 9A724 800A9F24 15008214 */  bne        $a0, $v0, .L800A9F7C
    /* 9A728 800A9F28 02000224 */   addiu     $v0, $zero, 0x2
  .L800A9F2C:
    /* 9A72C 800A9F2C 1180033C */  lui        $v1, %hi(Cars_gHumanRaceCarList)
    /* 9A730 800A9F30 48FA628C */  lw         $v0, %lo(Cars_gHumanRaceCarList)($v1)
    /* 9A734 800A9F34 00000000 */  nop
    /* 9A738 800A9F38 6002428C */  lw         $v0, 0x260($v0)
    /* 9A73C 800A9F3C 00000000 */  nop
    /* 9A740 800A9F40 00024230 */  andi       $v0, $v0, 0x200
    /* 9A744 800A9F44 0F004014 */  bnez       $v0, .L800A9F84
    /* 9A748 800A9F48 48FA6424 */   addiu     $a0, $v1, %lo(Cars_gHumanRaceCarList)
    /* 9A74C 800A9F4C 1480033C */  lui        $v1, %hi(Cars_gNumHumanRaceCars)
    /* 9A750 800A9F50 00C8638C */  lw         $v1, %lo(Cars_gNumHumanRaceCars)($v1)
    /* 9A754 800A9F54 02000224 */  addiu      $v0, $zero, 0x2
    /* 9A758 800A9F58 08006214 */  bne        $v1, $v0, .L800A9F7C
    /* 9A75C 800A9F5C 02000224 */   addiu     $v0, $zero, 0x2
    /* 9A760 800A9F60 0400828C */  lw         $v0, 0x4($a0)
    /* 9A764 800A9F64 00000000 */  nop
    /* 9A768 800A9F68 6002428C */  lw         $v0, 0x260($v0)
    /* 9A76C 800A9F6C 00000000 */  nop
    /* 9A770 800A9F70 00024230 */  andi       $v0, $v0, 0x200
    /* 9A774 800A9F74 03004014 */  bnez       $v0, .L800A9F84
    /* 9A778 800A9F78 02000224 */   addiu     $v0, $zero, 0x2
  .L800A9F7C:
    /* 9A77C 800A9F7C 23A80208 */  j          .L800AA08C
    /* 9A780 800A9F80 3E0422A2 */   sb        $v0, 0x43E($s1)
  .L800A9F84:
    /* 9A784 800A9F84 3E042392 */  lbu        $v1, 0x43E($s1)
    /* 9A788 800A9F88 42042292 */  lbu        $v0, 0x442($s1)
    /* 9A78C 800A9F8C 00000000 */  nop
    /* 9A790 800A9F90 3D006214 */  bne        $v1, $v0, .L800AA088
    /* 9A794 800A9F94 00000000 */   nop
    /* 9A798 800A9F98 9003228E */  lw         $v0, 0x390($s1)
    /* 9A79C 800A9F9C 00000000 */  nop
    /* 9A7A0 800A9FA0 39004014 */  bnez       $v0, .L800AA088
    /* 9A7A4 800A9FA4 00000000 */   nop
    /* 9A7A8 800A9FA8 7802228E */  lw         $v0, 0x278($s1)
    /* 9A7AC 800A9FAC 00000000 */  nop
    /* 9A7B0 800A9FB0 36004014 */  bnez       $v0, .L800AA08C
    /* 9A7B4 800A9FB4 00000000 */   nop
    /* 9A7B8 800A9FB8 7402228E */  lw         $v0, 0x274($s1)
    /* 9A7BC 800A9FBC 00000000 */  nop
    /* 9A7C0 800A9FC0 32004014 */  bnez       $v0, .L800AA08C
    /* 9A7C4 800A9FC4 00000000 */   nop
    /* 9A7C8 800A9FC8 C000228E */  lw         $v0, 0xC0($s1)
    /* 9A7CC 800A9FCC 00000000 */  nop
    /* 9A7D0 800A9FD0 02004104 */  bgez       $v0, .L800A9FDC
    /* 9A7D4 800A9FD4 00000000 */   nop
    /* 9A7D8 800A9FD8 23100200 */  negu       $v0, $v0
  .L800A9FDC:
    /* 9A7DC 800A9FDC 33334228 */  slti       $v0, $v0, 0x3333
    /* 9A7E0 800A9FE0 2A004010 */  beqz       $v0, .L800AA08C
    /* 9A7E4 800A9FE4 00000000 */   nop
    /* 9A7E8 800A9FE8 3D042292 */  lbu        $v0, 0x43D($s1)
    /* 9A7EC 800A9FEC 00000000 */  nop
    /* 9A7F0 800A9FF0 8100422C */  sltiu      $v0, $v0, 0x81
    /* 9A7F4 800A9FF4 0E004014 */  bnez       $v0, .L800AA030
    /* 9A7F8 800A9FF8 00000000 */   nop
    /* 9A7FC 800A9FFC 3C042292 */  lbu        $v0, 0x43C($s1)
    /* 9A800 800AA000 00000000 */  nop
    /* 9A804 800AA004 0A004014 */  bnez       $v0, .L800AA030
    /* 9A808 800AA008 0200622C */   sltiu     $v0, $v1, 0x2
    /* 9A80C 800AA00C 08004014 */  bnez       $v0, .L800AA030
    /* 9A810 800AA010 00000000 */   nop
    /* 9A814 800AA014 5404228E */  lw         $v0, 0x454($s1)
    /* 9A818 800AA018 00000000 */  nop
    /* 9A81C 800AA01C 04004014 */  bnez       $v0, .L800AA030
    /* 9A820 800AA020 01000224 */   addiu     $v0, $zero, 0x1
    /* 9A824 800AA024 3E0420A2 */  sb         $zero, 0x43E($s1)
    /* 9A828 800AA028 23A80208 */  j          .L800AA08C
    /* 9A82C 800AA02C 540422AE */   sw        $v0, 0x454($s1)
  .L800AA030:
    /* 9A830 800AA030 C000228E */  lw         $v0, 0xC0($s1)
    /* 9A834 800AA034 00000000 */  nop
    /* 9A838 800AA038 02004104 */  bgez       $v0, .L800AA044
    /* 9A83C 800AA03C 00000000 */   nop
    /* 9A840 800AA040 23100200 */  negu       $v0, $v0
  .L800AA044:
    /* 9A844 800AA044 33334228 */  slti       $v0, $v0, 0x3333
    /* 9A848 800AA048 10004010 */  beqz       $v0, .L800AA08C
    /* 9A84C 800AA04C 00000000 */   nop
    /* 9A850 800AA050 3C042292 */  lbu        $v0, 0x43C($s1)
    /* 9A854 800AA054 00000000 */  nop
    /* 9A858 800AA058 8100422C */  sltiu      $v0, $v0, 0x81
    /* 9A85C 800AA05C 0B004014 */  bnez       $v0, .L800AA08C
    /* 9A860 800AA060 00000000 */   nop
    /* 9A864 800AA064 42042292 */  lbu        $v0, 0x442($s1)
    /* 9A868 800AA068 00000000 */  nop
    /* 9A86C 800AA06C 07004014 */  bnez       $v0, .L800AA08C
    /* 9A870 800AA070 00000000 */   nop
    /* 9A874 800AA074 5404228E */  lw         $v0, 0x454($s1)
    /* 9A878 800AA078 00000000 */  nop
    /* 9A87C 800AA07C 03004010 */  beqz       $v0, .L800AA08C
    /* 9A880 800AA080 02000224 */   addiu     $v0, $zero, 0x2
    /* 9A884 800AA084 3E0422A2 */  sb         $v0, 0x43E($s1)
  .L800AA088:
    /* 9A888 800AA088 540420AE */  sw         $zero, 0x454($s1)
  .L800AA08C:
    /* 9A88C 800AA08C 42042792 */  lbu        $a3, 0x442($s1)
    /* 9A890 800AA090 3E042592 */  lbu        $a1, 0x43E($s1)
    /* 9A894 800AA094 FF00E630 */  andi       $a2, $a3, 0xFF
    /* 9A898 800AA098 4C00A610 */  beq        $a1, $a2, .L800AA1CC
    /* 9A89C 800AA09C 1180043C */   lui       $a0, %hi(GameSetup_gData)
    /* 9A8A0 800AA0A0 5402228E */  lw         $v0, 0x254($s1)
    /* 9A8A4 800AA0A4 EC318424 */  addiu      $a0, $a0, %lo(GameSetup_gData)
    /* 9A8A8 800AA0A8 40180200 */  sll        $v1, $v0, 1
    /* 9A8AC 800AA0AC 21186200 */  addu       $v1, $v1, $v0
    /* 9A8B0 800AA0B0 00110300 */  sll        $v0, $v1, 4
    /* 9A8B4 800AA0B4 23104300 */  subu       $v0, $v0, $v1
    /* 9A8B8 800AA0B8 80100200 */  sll        $v0, $v0, 2
    /* 9A8BC 800AA0BC 21104400 */  addu       $v0, $v0, $a0
    /* 9A8C0 800AA0C0 DC03428C */  lw         $v0, 0x3DC($v0)
    /* 9A8C4 800AA0C4 01000324 */  addiu      $v1, $zero, 0x1
    /* 9A8C8 800AA0C8 05004310 */  beq        $v0, $v1, .L800AA0E0
    /* 9A8CC 800AA0CC 0200A22C */   sltiu     $v0, $a1, 0x2
    /* 9A8D0 800AA0D0 6004228E */  lw         $v0, 0x460($s1)
    /* 9A8D4 800AA0D4 00000000 */  nop
    /* 9A8D8 800AA0D8 2C004010 */  beqz       $v0, .L800AA18C
    /* 9A8DC 800AA0DC 0200A22C */   sltiu     $v0, $a1, 0x2
  .L800AA0E0:
    /* 9A8E0 800AA0E0 06004010 */  beqz       $v0, .L800AA0FC
    /* 9A8E4 800AA0E4 02000224 */   addiu     $v0, $zero, 0x2
    /* 9A8E8 800AA0E8 42042292 */  lbu        $v0, 0x442($s1)
    /* 9A8EC 800AA0EC 3E042392 */  lbu        $v1, 0x43E($s1)
    /* 9A8F0 800AA0F0 6404248E */  lw         $a0, 0x464($s1)
    /* 9A8F4 800AA0F4 6EA80208 */  j          .L800AA1B8
    /* 9A8F8 800AA0F8 430420A2 */   sb        $zero, 0x443($s1)
  .L800AA0FC:
    /* 9A8FC 800AA0FC 3300A214 */  bne        $a1, $v0, .L800AA1CC
    /* 9A900 800AA100 2B10C200 */   sltu      $v0, $a2, $v0
    /* 9A904 800AA104 31004010 */  beqz       $v0, .L800AA1CC
    /* 9A908 800AA108 02001224 */   addiu     $s2, $zero, 0x2
    /* 9A90C 800AA10C 6404238E */  lw         $v1, 0x464($s1)
    /* 9A910 800AA110 410427A2 */  sb         $a3, 0x441($s1)
    /* 9A914 800AA114 0400628C */  lw         $v0, 0x4($v1)
    /* 9A918 800AA118 00000000 */  nop
    /* 9A91C 800AA11C 2A10A200 */  slt        $v0, $a1, $v0
    /* 9A920 800AA120 14004010 */  beqz       $v0, .L800AA174
    /* 9A924 800AA124 21804002 */   addu      $s0, $s2, $zero
    /* 9A928 800AA128 80101000 */  sll        $v0, $s0, 2
  .L800AA12C:
    /* 9A92C 800AA12C 21106200 */  addu       $v0, $v1, $v0
    /* 9A930 800AA130 F000658C */  lw         $a1, 0xF0($v1)
    /* 9A934 800AA134 8001448C */  lw         $a0, 0x180($v0)
    /* 9A938 800AA138 CA90030C */  jal        fixedmult
    /* 9A93C 800AA13C 002C0500 */   sll       $a1, $a1, 16
    /* 9A940 800AA140 2004238E */  lw         $v1, 0x420($s1)
    /* 9A944 800AA144 00000000 */  nop
    /* 9A948 800AA148 2A104300 */  slt        $v0, $v0, $v1
    /* 9A94C 800AA14C 02004010 */  beqz       $v0, .L800AA158
    /* 9A950 800AA150 00000000 */   nop
    /* 9A954 800AA154 21900002 */  addu       $s2, $s0, $zero
  .L800AA158:
    /* 9A958 800AA158 6404238E */  lw         $v1, 0x464($s1)
    /* 9A95C 800AA15C 00000000 */  nop
    /* 9A960 800AA160 0400628C */  lw         $v0, 0x4($v1)
    /* 9A964 800AA164 01001026 */  addiu      $s0, $s0, 0x1
    /* 9A968 800AA168 2A100202 */  slt        $v0, $s0, $v0
    /* 9A96C 800AA16C EFFF4014 */  bnez       $v0, .L800AA12C
    /* 9A970 800AA170 80101000 */   sll       $v0, $s0, 2
  .L800AA174:
    /* 9A974 800AA174 6404228E */  lw         $v0, 0x464($s1)
    /* 9A978 800AA178 430420A2 */  sb         $zero, 0x443($s1)
    /* 9A97C 800AA17C 420432A2 */  sb         $s2, 0x442($s1)
    /* 9A980 800AA180 08004290 */  lbu        $v0, 0x8($v0)
    /* 9A984 800AA184 73A80208 */  j          .L800AA1CC
    /* 9A988 800AA188 440422A2 */   sb        $v0, 0x444($s1)
  .L800AA18C:
    /* 9A98C 800AA18C 2B10A600 */  sltu       $v0, $a1, $a2
    /* 9A990 800AA190 05004010 */  beqz       $v0, .L800AA1A8
    /* 9A994 800AA194 0200A22C */   sltiu     $v0, $a1, 0x2
    /* 9A998 800AA198 03004014 */  bnez       $v0, .L800AA1A8
    /* 9A99C 800AA19C 00000000 */   nop
    /* 9A9A0 800AA1A0 6BA80208 */  j          .L800AA1AC
    /* 9A9A4 800AA1A4 430423A2 */   sb        $v1, 0x443($s1)
  .L800AA1A8:
    /* 9A9A8 800AA1A8 430420A2 */  sb         $zero, 0x443($s1)
  .L800AA1AC:
    /* 9A9AC 800AA1AC 42042292 */  lbu        $v0, 0x442($s1)
    /* 9A9B0 800AA1B0 3E042392 */  lbu        $v1, 0x43E($s1)
    /* 9A9B4 800AA1B4 6404248E */  lw         $a0, 0x464($s1)
  .L800AA1B8:
    /* 9A9B8 800AA1B8 410422A2 */  sb         $v0, 0x441($s1)
    /* 9A9BC 800AA1BC 420423A2 */  sb         $v1, 0x442($s1)
    /* 9A9C0 800AA1C0 08008290 */  lbu        $v0, 0x8($a0)
    /* 9A9C4 800AA1C4 00000000 */  nop
    /* 9A9C8 800AA1C8 440422A2 */  sb         $v0, 0x444($s1)
  .L800AA1CC:
    /* 9A9CC 800AA1CC 8802228E */  lw         $v0, 0x288($s1)
    /* 9A9D0 800AA1D0 00000000 */  nop
    /* 9A9D4 800AA1D4 1800428C */  lw         $v0, 0x18($v0)
    /* 9A9D8 800AA1D8 00000000 */  nop
    /* 9A9DC 800AA1DC 12004010 */  beqz       $v0, .L800AA228
    /* 9A9E0 800AA1E0 00000000 */   nop
    /* 9A9E4 800AA1E4 4C04238E */  lw         $v1, 0x44C($s1)
    /* 9A9E8 800AA1E8 5004258E */  lw         $a1, 0x450($s1)
    /* 9A9EC 800AA1EC 6404228E */  lw         $v0, 0x464($s1)
    /* 9A9F0 800AA1F0 23186500 */  subu       $v1, $v1, $a1
    /* 9A9F4 800AA1F4 1001448C */  lw         $a0, 0x110($v0)
    /* 9A9F8 800AA1F8 05006004 */  bltz       $v1, .L800AA210
    /* 9A9FC 800AA1FC 2A106400 */   slt       $v0, $v1, $a0
    /* 9AA00 800AA200 0A004014 */  bnez       $v0, .L800AA22C
    /* 9AA04 800AA204 2110A300 */   addu      $v0, $a1, $v1
    /* 9AA08 800AA208 8BA80208 */  j          .L800AA22C
    /* 9AA0C 800AA20C 2110A400 */   addu      $v0, $a1, $a0
  .L800AA210:
    /* 9AA10 800AA210 23180300 */  negu       $v1, $v1
    /* 9AA14 800AA214 2A106400 */  slt        $v0, $v1, $a0
    /* 9AA18 800AA218 04004014 */  bnez       $v0, .L800AA22C
    /* 9AA1C 800AA21C 2310A300 */   subu      $v0, $a1, $v1
    /* 9AA20 800AA220 8BA80208 */  j          .L800AA22C
    /* 9AA24 800AA224 2310A400 */   subu      $v0, $a1, $a0
  .L800AA228:
    /* 9AA28 800AA228 4C04228E */  lw         $v0, 0x44C($s1)
  .L800AA22C:
    /* 9AA2C 800AA22C 00000000 */  nop
    /* 9AA30 800AA230 500422AE */  sw         $v0, 0x450($s1)
  .L800AA234:
    /* 9AA34 800AA234 1280023C */  lui        $v0, %hi(D_8011E0B0)
    /* 9AA38 800AA238 B0E0428C */  lw         $v0, %lo(D_8011E0B0)($v0)
    /* 9AA3C 800AA23C 00000000 */  nop
    /* 9AA40 800AA240 00024228 */  slti       $v0, $v0, 0x200
    /* 9AA44 800AA244 1D004010 */  beqz       $v0, .L800AA2BC
    /* 9AA48 800AA248 1180023C */   lui       $v0, %hi(GameSetup_gData)
    /* 9AA4C 800AA24C EC31438C */  lw         $v1, %lo(GameSetup_gData)($v0)
    /* 9AA50 800AA250 01000224 */  addiu      $v0, $zero, 0x1
    /* 9AA54 800AA254 03006210 */  beq        $v1, $v0, .L800AA264
    /* 9AA58 800AA258 05000224 */   addiu     $v0, $zero, 0x5
    /* 9AA5C 800AA25C 15006214 */  bne        $v1, $v0, .L800AA2B4
    /* 9AA60 800AA260 FF000224 */   addiu     $v0, $zero, 0xFF
  .L800AA264:
    /* 9AA64 800AA264 1180033C */  lui        $v1, %hi(Cars_gHumanRaceCarList)
    /* 9AA68 800AA268 48FA628C */  lw         $v0, %lo(Cars_gHumanRaceCarList)($v1)
    /* 9AA6C 800AA26C 00000000 */  nop
    /* 9AA70 800AA270 6002428C */  lw         $v0, 0x260($v0)
    /* 9AA74 800AA274 00000000 */  nop
    /* 9AA78 800AA278 00024230 */  andi       $v0, $v0, 0x200
    /* 9AA7C 800AA27C 0F004014 */  bnez       $v0, .L800AA2BC
    /* 9AA80 800AA280 48FA6424 */   addiu     $a0, $v1, %lo(Cars_gHumanRaceCarList)
    /* 9AA84 800AA284 1480033C */  lui        $v1, %hi(Cars_gNumHumanRaceCars)
    /* 9AA88 800AA288 00C8638C */  lw         $v1, %lo(Cars_gNumHumanRaceCars)($v1)
    /* 9AA8C 800AA28C 02000224 */  addiu      $v0, $zero, 0x2
    /* 9AA90 800AA290 08006214 */  bne        $v1, $v0, .L800AA2B4
    /* 9AA94 800AA294 FF000224 */   addiu     $v0, $zero, 0xFF
    /* 9AA98 800AA298 0400828C */  lw         $v0, 0x4($a0)
    /* 9AA9C 800AA29C 00000000 */  nop
    /* 9AAA0 800AA2A0 6002428C */  lw         $v0, 0x260($v0)
    /* 9AAA4 800AA2A4 00000000 */  nop
    /* 9AAA8 800AA2A8 00024230 */  andi       $v0, $v0, 0x200
    /* 9AAAC 800AA2AC 03004014 */  bnez       $v0, .L800AA2BC
    /* 9AAB0 800AA2B0 FF000224 */   addiu     $v0, $zero, 0xFF
  .L800AA2B4:
    /* 9AAB4 800AA2B4 C1A80208 */  j          .L800AA304
    /* 9AAB8 800AA2B8 400422A2 */   sb        $v0, 0x440($s1)
  .L800AA2BC:
    /* 9AABC 800AA2BC 7402228E */  lw         $v0, 0x274($s1)
    /* 9AAC0 800AA2C0 00000000 */  nop
    /* 9AAC4 800AA2C4 05004014 */  bnez       $v0, .L800AA2DC
    /* 9AAC8 800AA2C8 00000000 */   nop
    /* 9AACC 800AA2CC 7802228E */  lw         $v0, 0x278($s1)
    /* 9AAD0 800AA2D0 00000000 */  nop
    /* 9AAD4 800AA2D4 0B004010 */  beqz       $v0, .L800AA304
    /* 9AAD8 800AA2D8 00000000 */   nop
  .L800AA2DC:
    /* 9AADC 800AA2DC 5404228E */  lw         $v0, 0x454($s1)
    /* 9AAE0 800AA2E0 00000000 */  nop
    /* 9AAE4 800AA2E4 04004010 */  beqz       $v0, .L800AA2F8
    /* 9AAE8 800AA2E8 80000224 */   addiu     $v0, $zero, 0x80
    /* 9AAEC 800AA2EC 3F0422A2 */  sb         $v0, 0x43F($s1)
    /* 9AAF0 800AA2F0 C0A80208 */  j          .L800AA300
    /* 9AAF4 800AA2F4 400420A2 */   sb        $zero, 0x440($s1)
  .L800AA2F8:
    /* 9AAF8 800AA2F8 3F0420A2 */  sb         $zero, 0x43F($s1)
    /* 9AAFC 800AA2FC 400422A2 */  sb         $v0, 0x440($s1)
  .L800AA300:
    /* 9AB00 800AA300 430420A2 */  sb         $zero, 0x443($s1)
  .L800AA304:
    /* 9AB04 800AA304 EC03238E */  lw         $v1, 0x3EC($s1)
    /* 9AB08 800AA308 02000224 */  addiu      $v0, $zero, 0x2
    /* 9AB0C 800AA30C 02006214 */  bne        $v1, $v0, .L800AA318
    /* 9AB10 800AA310 00000000 */   nop
    /* 9AB14 800AA314 3F0420A2 */  sb         $zero, 0x43F($s1)
  .L800AA318:
    /* 9AB18 800AA318 1480023C */  lui        $v0, %hi(AIInit_forceHumanHandBrake)
    /* 9AB1C 800AA31C 84C5428C */  lw         $v0, %lo(AIInit_forceHumanHandBrake)($v0)
    /* 9AB20 800AA320 00000000 */  nop
    /* 9AB24 800AA324 11004010 */  beqz       $v0, .L800AA36C
    /* 9AB28 800AA328 2184053C */   lui       $a1, (0x84210843 >> 16)
    /* 9AB2C 800AA32C 6004228E */  lw         $v0, 0x460($s1)
    /* 9AB30 800AA330 00000000 */  nop
    /* 9AB34 800AA334 0D004010 */  beqz       $v0, .L800AA36C
    /* 9AB38 800AA338 00000000 */   nop
    /* 9AB3C 800AA33C 7405238E */  lw         $v1, 0x574($s1)
    /* 9AB40 800AA340 5405228E */  lw         $v0, 0x554($s1)
    /* 9AB44 800AA344 00000000 */  nop
    /* 9AB48 800AA348 18006200 */  mult       $v1, $v0
    /* 9AB4C 800AA34C 12400000 */  mflo       $t0
    /* 9AB50 800AA350 0200001D */  bgtz       $t0, .L800AA35C
    /* 9AB54 800AA354 84FF0224 */   addiu     $v0, $zero, -0x7C
    /* 9AB58 800AA358 7C000224 */  addiu      $v0, $zero, 0x7C
  .L800AA35C:
    /* 9AB5C 800AA35C 500422AE */  sw         $v0, 0x450($s1)
    /* 9AB60 800AA360 01000224 */  addiu      $v0, $zero, 0x1
    /* 9AB64 800AA364 450422A2 */  sb         $v0, 0x445($s1)
    /* 9AB68 800AA368 2184053C */  lui        $a1, (0x84210843 >> 16)
  .L800AA36C:
    /* 9AB6C 800AA36C 3F042292 */  lbu        $v0, 0x43F($s1)
    /* 9AB70 800AA370 4308A534 */  ori        $a1, $a1, (0x84210843 & 0xFFFF)
    /* 9AB74 800AA374 01004224 */  addiu      $v0, $v0, 0x1
    /* 9AB78 800AA378 00140200 */  sll        $v0, $v0, 16
    /* 9AB7C 800AA37C 18004500 */  mult       $v0, $a1
    /* 9AB80 800AA380 0100063C */  lui        $a2, (0x10000 >> 16)
    /* 9AB84 800AA384 10400000 */  mfhi       $t0
    /* 9AB88 800AA388 21180201 */  addu       $v1, $t0, $v0
    /* 9AB8C 800AA38C C3190300 */  sra        $v1, $v1, 7
    /* 9AB90 800AA390 C3170200 */  sra        $v0, $v0, 31
    /* 9AB94 800AA394 23186200 */  subu       $v1, $v1, $v0
    /* 9AB98 800AA398 2A10C300 */  slt        $v0, $a2, $v1
    /* 9AB9C 800AA39C 02004010 */  beqz       $v0, .L800AA3A8
    /* 9ABA0 800AA3A0 00000000 */   nop
    /* 9ABA4 800AA3A4 2118C000 */  addu       $v1, $a2, $zero
  .L800AA3A8:
    /* 9ABA8 800AA3A8 A80D83AF */  sw         $v1, %gp_rel(gGasRatio)($gp)
    /* 9ABAC 800AA3AC 40042292 */  lbu        $v0, 0x440($s1)
    /* 9ABB0 800AA3B0 00000000 */  nop
    /* 9ABB4 800AA3B4 01004224 */  addiu      $v0, $v0, 0x1
    /* 9ABB8 800AA3B8 00140200 */  sll        $v0, $v0, 16
    /* 9ABBC 800AA3BC 18004500 */  mult       $v0, $a1
    /* 9ABC0 800AA3C0 10400000 */  mfhi       $t0
    /* 9ABC4 800AA3C4 21180201 */  addu       $v1, $t0, $v0
    /* 9ABC8 800AA3C8 C3190300 */  sra        $v1, $v1, 7
    /* 9ABCC 800AA3CC C3170200 */  sra        $v0, $v0, 31
    /* 9ABD0 800AA3D0 23186200 */  subu       $v1, $v1, $v0
    /* 9ABD4 800AA3D4 2A10C300 */  slt        $v0, $a2, $v1
    /* 9ABD8 800AA3D8 02004010 */  beqz       $v0, .L800AA3E4
    /* 9ABDC 800AA3DC 00000000 */   nop
    /* 9ABE0 800AA3E0 0100033C */  lui        $v1, (0x10000 >> 16)
  .L800AA3E4:
    /* 9ABE4 800AA3E4 5004228E */  lw         $v0, 0x450($s1)
    /* 9ABE8 800AA3E8 1180043C */  lui        $a0, %hi(GameSetup_gData)
    /* 9ABEC 800AA3EC 02004104 */  bgez       $v0, .L800AA3F8
    /* 9ABF0 800AA3F0 00000000 */   nop
    /* 9ABF4 800AA3F4 23100200 */  negu       $v0, $v0
  .L800AA3F8:
    /* 9ABF8 800AA3F8 40120200 */  sll        $v0, $v0, 9
    /* 9ABFC 800AA3FC AC0D82AF */  sw         $v0, %gp_rel(gSteerRatio)($gp)
    /* 9AC00 800AA400 5402228E */  lw         $v0, 0x254($s1)
    /* 9AC04 800AA404 EC318424 */  addiu      $a0, $a0, %lo(GameSetup_gData)
    /* 9AC08 800AA408 A40D83AF */  sw         $v1, %gp_rel(gBrakeRatio)($gp)
    /* 9AC0C 800AA40C 40180200 */  sll        $v1, $v0, 1
    /* 9AC10 800AA410 21186200 */  addu       $v1, $v1, $v0
    /* 9AC14 800AA414 00110300 */  sll        $v0, $v1, 4
    /* 9AC18 800AA418 23104300 */  subu       $v0, $v0, $v1
    /* 9AC1C 800AA41C 80100200 */  sll        $v0, $v0, 2
    /* 9AC20 800AA420 21104400 */  addu       $v0, $v0, $a0
    /* 9AC24 800AA424 DC03438C */  lw         $v1, 0x3DC($v0)
    /* 9AC28 800AA428 01000224 */  addiu      $v0, $zero, 0x1
    /* 9AC2C 800AA42C 27006214 */  bne        $v1, $v0, .L800AA4CC
    /* 9AC30 800AA430 00000000 */   nop
    /* 9AC34 800AA434 42042292 */  lbu        $v0, 0x442($s1)
    /* 9AC38 800AA438 00000000 */  nop
    /* 9AC3C 800AA43C 23004014 */  bnez       $v0, .L800AA4CC
    /* 9AC40 800AA440 00000000 */   nop
    /* 9AC44 800AA444 5404228E */  lw         $v0, 0x454($s1)
    /* 9AC48 800AA448 00000000 */  nop
    /* 9AC4C 800AA44C 1F004314 */  bne        $v0, $v1, .L800AA4CC
    /* 9AC50 800AA450 00000000 */   nop
    /* 9AC54 800AA454 40042292 */  lbu        $v0, 0x440($s1)
    /* 9AC58 800AA458 00000000 */  nop
    /* 9AC5C 800AA45C 01004224 */  addiu      $v0, $v0, 0x1
    /* 9AC60 800AA460 00140200 */  sll        $v0, $v0, 16
    /* 9AC64 800AA464 18004500 */  mult       $v0, $a1
    /* 9AC68 800AA468 10400000 */  mfhi       $t0
    /* 9AC6C 800AA46C 21180201 */  addu       $v1, $t0, $v0
    /* 9AC70 800AA470 C3190300 */  sra        $v1, $v1, 7
    /* 9AC74 800AA474 C3170200 */  sra        $v0, $v0, 31
    /* 9AC78 800AA478 23186200 */  subu       $v1, $v1, $v0
    /* 9AC7C 800AA47C 2A10C300 */  slt        $v0, $a2, $v1
    /* 9AC80 800AA480 02004010 */  beqz       $v0, .L800AA48C
    /* 9AC84 800AA484 00000000 */   nop
    /* 9AC88 800AA488 0100033C */  lui        $v1, (0x10000 >> 16)
  .L800AA48C:
    /* 9AC8C 800AA48C A80D83AF */  sw         $v1, %gp_rel(gGasRatio)($gp)
    /* 9AC90 800AA490 3F042292 */  lbu        $v0, 0x43F($s1)
    /* 9AC94 800AA494 00000000 */  nop
    /* 9AC98 800AA498 01004224 */  addiu      $v0, $v0, 0x1
    /* 9AC9C 800AA49C 00140200 */  sll        $v0, $v0, 16
    /* 9ACA0 800AA4A0 18004500 */  mult       $v0, $a1
    /* 9ACA4 800AA4A4 10400000 */  mfhi       $t0
    /* 9ACA8 800AA4A8 21180201 */  addu       $v1, $t0, $v0
    /* 9ACAC 800AA4AC C3190300 */  sra        $v1, $v1, 7
    /* 9ACB0 800AA4B0 C3170200 */  sra        $v0, $v0, 31
    /* 9ACB4 800AA4B4 23186200 */  subu       $v1, $v1, $v0
    /* 9ACB8 800AA4B8 2A10C300 */  slt        $v0, $a2, $v1
    /* 9ACBC 800AA4BC 02004010 */  beqz       $v0, .L800AA4C8
    /* 9ACC0 800AA4C0 00000000 */   nop
    /* 9ACC4 800AA4C4 0100033C */  lui        $v1, (0x10000 >> 16)
  .L800AA4C8:
    /* 9ACC8 800AA4C8 A40D83AF */  sw         $v1, %gp_rel(gBrakeRatio)($gp)
  .L800AA4CC:
    /* 9ACCC 800AA4CC 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 9ACD0 800AA4D0 1800B28F */  lw         $s2, 0x18($sp)
    /* 9ACD4 800AA4D4 1400B18F */  lw         $s1, 0x14($sp)
    /* 9ACD8 800AA4D8 1000B08F */  lw         $s0, 0x10($sp)
    /* 9ACDC 800AA4DC 0800E003 */  jr         $ra
    /* 9ACE0 800AA4E0 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Physics_RampCarControlValues__FP8Car_tObj
