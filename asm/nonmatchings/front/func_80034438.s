.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_80034438, 0x1B4

glabel func_80034438
    /* 24C38 80034438 30FFBD27 */  addiu      $sp, $sp, -0xD0
    /* 24C3C 8003443C C000B2AF */  sw         $s2, 0xC0($sp)
    /* 24C40 80034440 21908000 */  addu       $s2, $a0, $zero
    /* 24C44 80034444 C800B4AF */  sw         $s4, 0xC8($sp)
    /* 24C48 80034448 21A0A000 */  addu       $s4, $a1, $zero
    /* 24C4C 8003444C CC00BFAF */  sw         $ra, 0xCC($sp)
    /* 24C50 80034450 C400B3AF */  sw         $s3, 0xC4($sp)
    /* 24C54 80034454 BC00B1AF */  sw         $s1, 0xBC($sp)
    /* 24C58 80034458 05D1000C */  jal        BringThatBeatBack__Fv
    /* 24C5C 8003445C B800B0AF */   sw        $s0, 0xB8($sp)
    /* 24C60 80034460 1000B027 */  addiu      $s0, $sp, 0x10
    /* 24C64 80034464 A366000C */  jal        __12tDialogYesNo
    /* 24C68 80034468 21200002 */   addu      $a0, $s0, $zero
    /* 24C6C 8003446C 0180023C */  lui        $v0, %hi(_vt_15tDialogYesNoMem)
    /* 24C70 80034470 0580113C */  lui        $s1, %hi(FEApp)
    /* 24C74 80034474 C014238E */  lw         $v1, %lo(FEApp)($s1)
    /* 24C78 80034478 10034224 */  addiu      $v0, $v0, %lo(_vt_15tDialogYesNoMem)
    /* 24C7C 8003447C 600002AE */  sw         $v0, 0x60($s0)
    /* 24C80 80034480 D0026424 */  addiu      $a0, $v1, 0x2D0
    /* 24C84 80034484 7000828C */  lw         $v0, 0x70($a0)
    /* 24C88 80034488 00000000 */  nop
    /* 24C8C 8003448C 03004010 */  beqz       $v0, .L8003449C
    /* 24C90 80034490 21980000 */   addu      $s3, $zero, $zero
    /* 24C94 80034494 4162000C */  jal        Hide__11tDialogBase
    /* 24C98 80034498 01001324 */   addiu     $s3, $zero, 0x1
  .L8003449C:
    /* 24C9C 8003449C 94E4020C */  jal        TextSys_Word__Fi
    /* 24CA0 800344A0 21204002 */   addu      $a0, $s2, $zero
    /* 24CA4 800344A4 900002AE */  sw         $v0, 0x90($s0)
    /* 24CA8 800344A8 92020224 */  addiu      $v0, $zero, 0x292
    /* 24CAC 800344AC A40002AE */  sw         $v0, 0xA4($s0)
    /* 24CB0 800344B0 1180023C */  lui        $v0, %hi(D_80114940)
    /* 24CB4 800344B4 A00014AE */  sw         $s4, 0xA0($s0)
    /* 24CB8 800344B8 880000A6 */  sh         $zero, 0x88($s0)
    /* 24CBC 800344BC 40494390 */  lbu        $v1, %lo(D_80114940)($v0)
    /* 24CC0 800344C0 03000224 */  addiu      $v0, $zero, 0x3
    /* 24CC4 800344C4 03006214 */  bne        $v1, $v0, .L800344D4
    /* 24CC8 800344C8 0A000224 */   addiu     $v0, $zero, 0xA
    /* 24CCC 800344CC 7C0000A6 */  sh         $zero, 0x7C($s0)
    /* 24CD0 800344D0 7E0002A6 */  sh         $v0, 0x7E($s0)
  .L800344D4:
    /* 24CD4 800344D4 FA65000C */  jal        Run__18tDialogInteractive
    /* 24CD8 800344D8 21200002 */   addu      $a0, $s0, $zero
    /* 24CDC 800344DC 00140200 */  sll        $v0, $v0, 16
    /* 24CE0 800344E0 03940200 */  sra        $s2, $v0, 16
    /* 24CE4 800344E4 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 24CE8 800344E8 19004216 */  bne        $s2, $v0, .L80034550
    /* 24CEC 800344EC 0580023C */   lui       $v0, %hi(CURRENTPLAYER)
    /* 24CF0 800344F0 681A448C */  lw         $a0, %lo(CURRENTPLAYER)($v0)
    /* 24CF4 800344F4 C014308E */  lw         $s0, %lo(FEApp)($s1)
    /* 24CF8 800344F8 2B038424 */  addiu      $a0, $a0, 0x32B
    /* 24CFC 800344FC 94E4020C */  jal        TextSys_Word__Fi
    /* 24D00 80034500 38021026 */   addiu     $s0, $s0, 0x238
    /* 24D04 80034504 C014248E */  lw         $a0, %lo(FEApp)($s1)
    /* 24D08 80034508 900002AE */  sw         $v0, 0x90($s0)
    /* 24D0C 8003450C 1062000C */  jal        Display__11tDialogBase
    /* 24D10 80034510 38028424 */   addiu     $a0, $a0, 0x238
  .L80034514:
    /* 24D14 80034514 C014248E */  lw         $a0, %lo(FEApp)($s1)
    /* 24D18 80034518 00000000 */  nop
    /* 24D1C 8003451C BC02828C */  lw         $v0, 0x2BC($a0)
    /* 24D20 80034520 00000000 */  nop
    /* 24D24 80034524 01004238 */  xori       $v0, $v0, 0x1
    /* 24D28 80034528 05004010 */  beqz       $v0, .L80034540
    /* 24D2C 8003452C 00000000 */   nop
    /* 24D30 80034530 CF4D000C */  jal        Redraw__14tFEApplication
    /* 24D34 80034534 00000000 */   nop
    /* 24D38 80034538 45D10008 */  j          .L80034514
    /* 24D3C 8003453C 00000000 */   nop
  .L80034540:
    /* 24D40 80034540 CF4D000C */  jal        Redraw__14tFEApplication
    /* 24D44 80034544 00000000 */   nop
    /* 24D48 80034548 56D10008 */  j          .L80034558
    /* 24D4C 8003454C 0580033C */   lui       $v1, %hi(nomessage)
  .L80034550:
    /* 24D50 80034550 04004016 */  bnez       $s2, .L80034564
    /* 24D54 80034554 0580033C */   lui       $v1, %hi(nomessage)
  .L80034558:
    /* 24D58 80034558 01000224 */  addiu      $v0, $zero, 0x1
    /* 24D5C 8003455C 69D10008 */  j          .L800345A4
    /* 24D60 80034560 781A62AC */   sw        $v0, %lo(nomessage)($v1)
  .L80034564:
    /* 24D64 80034564 0F006012 */  beqz       $s3, .L800345A4
    /* 24D68 80034568 21802002 */   addu      $s0, $s1, $zero
    /* 24D6C 8003456C C014248E */  lw         $a0, %lo(FEApp)($s1)
    /* 24D70 80034570 1062000C */  jal        Display__11tDialogBase
    /* 24D74 80034574 D0028424 */   addiu     $a0, $a0, 0x2D0
  .L80034578:
    /* 24D78 80034578 C014048E */  lw         $a0, %lo(FEApp)($s0)
    /* 24D7C 8003457C 00000000 */  nop
    /* 24D80 80034580 5403828C */  lw         $v0, 0x354($a0)
    /* 24D84 80034584 00000000 */  nop
    /* 24D88 80034588 01004238 */  xori       $v0, $v0, 0x1
    /* 24D8C 8003458C 06004010 */  beqz       $v0, .L800345A8
    /* 24D90 80034590 0580023C */   lui       $v0, %hi(FEApp)
    /* 24D94 80034594 CF4D000C */  jal        Redraw__14tFEApplication
    /* 24D98 80034598 00000000 */   nop
    /* 24D9C 8003459C 5ED10008 */  j          .L80034578
    /* 24DA0 800345A0 00000000 */   nop
  .L800345A4:
    /* 24DA4 800345A4 0580023C */  lui        $v0, %hi(FEApp)
  .L800345A8:
    /* 24DA8 800345A8 C014448C */  lw         $a0, %lo(FEApp)($v0)
    /* 24DAC 800345AC CF4D000C */  jal        Redraw__14tFEApplication
    /* 24DB0 800345B0 00000000 */   nop
    /* 24DB4 800345B4 FCD0000C */  jal        MakeWayForMemoryCard__Fv
    /* 24DB8 800345B8 00000000 */   nop
    /* 24DBC 800345BC 1000A427 */  addiu      $a0, $sp, 0x10
    /* 24DC0 800345C0 1E98000C */  jal        ___7tScreen
    /* 24DC4 800345C4 02000524 */   addiu     $a1, $zero, 0x2
    /* 24DC8 800345C8 21104002 */  addu       $v0, $s2, $zero
    /* 24DCC 800345CC CC00BF8F */  lw         $ra, 0xCC($sp)
    /* 24DD0 800345D0 C800B48F */  lw         $s4, 0xC8($sp)
    /* 24DD4 800345D4 C400B38F */  lw         $s3, 0xC4($sp)
    /* 24DD8 800345D8 C000B28F */  lw         $s2, 0xC0($sp)
    /* 24DDC 800345DC BC00B18F */  lw         $s1, 0xBC($sp)
    /* 24DE0 800345E0 B800B08F */  lw         $s0, 0xB8($sp)
    /* 24DE4 800345E4 0800E003 */  jr         $ra
    /* 24DE8 800345E8 D000BD27 */   addiu     $sp, $sp, 0xD0
endlabel func_80034438
