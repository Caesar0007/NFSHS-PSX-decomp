.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MenuExtended_PurchaseUpgrade__Fi, 0x140

glabel MenuExtended_PurchaseUpgrade__Fi
    /* 1DE4C 8002D64C 60FEBD27 */  addiu      $sp, $sp, -0x1A0
    /* 1DE50 8002D650 8801B0AF */  sw         $s0, 0x188($sp)
    /* 1DE54 8002D654 21808000 */  addu       $s0, $a0, $zero
    /* 1DE58 8002D658 1180023C */  lui        $v0, %hi(carManager)
    /* 1DE5C 8002D65C 9801B4AF */  sw         $s4, 0x198($sp)
    /* 1DE60 8002D660 74425424 */  addiu      $s4, $v0, %lo(carManager)
    /* 1DE64 8002D664 21208002 */  addu       $a0, $s4, $zero
    /* 1DE68 8002D668 1000A627 */  addiu      $a2, $sp, 0x10
    /* 1DE6C 8002D66C 21380000 */  addu       $a3, $zero, $zero
    /* 1DE70 8002D670 1180023C */  lui        $v0, %hi(frontEnd)
    /* 1DE74 8002D674 9401B3AF */  sw         $s3, 0x194($sp)
    /* 1DE78 8002D678 00465324 */  addiu      $s3, $v0, %lo(frontEnd)
    /* 1DE7C 8002D67C 01000224 */  addiu      $v0, $zero, 0x1
    /* 1DE80 8002D680 9C01BFAF */  sw         $ra, 0x19C($sp)
    /* 1DE84 8002D684 9001B2AF */  sw         $s2, 0x190($sp)
    /* 1DE88 8002D688 8C01B1AF */  sw         $s1, 0x18C($sp)
    /* 1DE8C 8002D68C 23016592 */  lbu        $a1, 0x123($s3)
    /* 1DE90 8002D690 D35B000C */  jal        GetGarageCar__11tCarManagersR8tCarInfos
    /* 1DE94 8002D694 04900202 */   sllv      $s2, $v0, $s0
    /* 1DE98 8002D698 D400A293 */  lbu        $v0, 0xD4($sp)
    /* 1DE9C 8002D69C 00000000 */  nop
    /* 1DEA0 8002D6A0 24105200 */  and        $v0, $v0, $s2
    /* 1DEA4 8002D6A4 31004014 */  bnez       $v0, .L8002D76C
    /* 1DEA8 8002D6A8 01000226 */   addiu     $v0, $s0, 0x1
    /* 1DEAC 8002D6AC 80100200 */  sll        $v0, $v0, 2
    /* 1DEB0 8002D6B0 2118A203 */  addu       $v1, $sp, $v0
    /* 1DEB4 8002D6B4 1180023C */  lui        $v0, %hi(tournamentManager)
    /* 1DEB8 8002D6B8 D84A5124 */  addiu      $s1, $v0, %lo(tournamentManager)
    /* 1DEBC 8002D6BC 1400228E */  lw         $v0, 0x14($s1)
    /* 1DEC0 8002D6C0 3000638C */  lw         $v1, 0x30($v1)
    /* 1DEC4 8002D6C4 00000000 */  nop
    /* 1DEC8 8002D6C8 2A104300 */  slt        $v0, $v0, $v1
    /* 1DECC 8002D6CC 20004014 */  bnez       $v0, .L8002D750
    /* 1DED0 8002D6D0 0580023C */   lui       $v0, %hi(FEApp)
    /* 1DED4 8002D6D4 E000B027 */  addiu      $s0, $sp, 0xE0
    /* 1DED8 8002D6D8 A366000C */  jal        __12tDialogYesNo
    /* 1DEDC 8002D6DC 21200002 */   addu      $a0, $s0, $zero
    /* 1DEE0 8002D6E0 94E4020C */  jal        TextSys_Word__Fi
    /* 1DEE4 8002D6E4 A6000424 */   addiu     $a0, $zero, 0xA6
    /* 1DEE8 8002D6E8 21200002 */  addu       $a0, $s0, $zero
    /* 1DEEC 8002D6EC 7001A2AF */  sw         $v0, 0x170($sp)
    /* 1DEF0 8002D6F0 21030224 */  addiu      $v0, $zero, 0x321
    /* 1DEF4 8002D6F4 A00002AE */  sw         $v0, 0xA0($s0)
    /* 1DEF8 8002D6F8 22030224 */  addiu      $v0, $zero, 0x322
    /* 1DEFC 8002D6FC A40002AE */  sw         $v0, 0xA4($s0)
    /* 1DF00 8002D700 FA65000C */  jal        Run__18tDialogInteractive
    /* 1DF04 8002D704 6801A0A7 */   sh        $zero, 0x168($sp)
    /* 1DF08 8002D708 00140200 */  sll        $v0, $v0, 16
    /* 1DF0C 8002D70C 0B004010 */  beqz       $v0, .L8002D73C
    /* 1DF10 8002D710 21208002 */   addu      $a0, $s4, $zero
    /* 1DF14 8002D714 00341200 */  sll        $a2, $s2, 16
    /* 1DF18 8002D718 03340600 */  sra        $a2, $a2, 16
    /* 1DF1C 8002D71C 23016592 */  lbu        $a1, 0x123($s3)
    /* 1DF20 8002D720 AB59000C */  jal        PurchaseUpgrade__11tCarManagersss
    /* 1DF24 8002D724 21380000 */   addu      $a3, $zero, $zero
    /* 1DF28 8002D728 1400238E */  lw         $v1, 0x14($s1)
    /* 1DF2C 8002D72C 1A000424 */  addiu      $a0, $zero, 0x1A
    /* 1DF30 8002D730 23186200 */  subu       $v1, $v1, $v0
    /* 1DF34 8002D734 81E5010C */  jal        AudioCmn_PlayFESFX__Fi
    /* 1DF38 8002D738 140023AE */   sw        $v1, 0x14($s1)
  .L8002D73C:
    /* 1DF3C 8002D73C 21200002 */  addu       $a0, $s0, $zero
    /* 1DF40 8002D740 1E98000C */  jal        ___7tScreen
    /* 1DF44 8002D744 02000524 */   addiu     $a1, $zero, 0x2
    /* 1DF48 8002D748 DBB50008 */  j          .L8002D76C
    /* 1DF4C 8002D74C 00000000 */   nop
  .L8002D750:
    /* 1DF50 8002D750 C014508C */  lw         $s0, %lo(FEApp)($v0)
    /* 1DF54 8002D754 A8000424 */  addiu      $a0, $zero, 0xA8
    /* 1DF58 8002D758 94E4020C */  jal        TextSys_Word__Fi
    /* 1DF5C 8002D75C 2C001026 */   addiu     $s0, $s0, 0x2C
    /* 1DF60 8002D760 21200002 */  addu       $a0, $s0, $zero
    /* 1DF64 8002D764 1062000C */  jal        Display__11tDialogBase
    /* 1DF68 8002D768 900082AC */   sw        $v0, 0x90($a0)
  .L8002D76C:
    /* 1DF6C 8002D76C 9C01BF8F */  lw         $ra, 0x19C($sp)
    /* 1DF70 8002D770 9801B48F */  lw         $s4, 0x198($sp)
    /* 1DF74 8002D774 9401B38F */  lw         $s3, 0x194($sp)
    /* 1DF78 8002D778 9001B28F */  lw         $s2, 0x190($sp)
    /* 1DF7C 8002D77C 8C01B18F */  lw         $s1, 0x18C($sp)
    /* 1DF80 8002D780 8801B08F */  lw         $s0, 0x188($sp)
    /* 1DF84 8002D784 0800E003 */  jr         $ra
    /* 1DF88 8002D788 A001BD27 */   addiu     $sp, $sp, 0x1A0
endlabel MenuExtended_PurchaseUpgrade__Fi
