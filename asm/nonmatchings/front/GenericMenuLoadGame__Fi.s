.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GenericMenuLoadGame__Fi, 0x94

glabel GenericMenuLoadGame__Fi
    /* 1E03C 8002D83C 0580023C */  lui        $v0, %hi(CURRENTLYUSINGMEMCARD)
    /* 1E040 8002D840 7C1A428C */  lw         $v0, %lo(CURRENTLYUSINGMEMCARD)($v0)
    /* 1E044 8002D844 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 1E048 8002D848 1800B2AF */  sw         $s2, 0x18($sp)
    /* 1E04C 8002D84C 21908000 */  addu       $s2, $a0, $zero
    /* 1E050 8002D850 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 1E054 8002D854 1400B1AF */  sw         $s1, 0x14($sp)
    /* 1E058 8002D858 13004014 */  bnez       $v0, .L8002D8A8
    /* 1E05C 8002D85C 1000B0AF */   sw        $s0, 0x10($sp)
    /* 1E060 8002D860 0580103C */  lui        $s0, %hi(FEApp)
    /* 1E064 8002D864 0580113C */  lui        $s1, %hi(screenMemcard)
    /* 1E068 8002D868 C014048E */  lw         $a0, %lo(FEApp)($s0)
    /* 1E06C 8002D86C F028238E */  lw         $v1, %lo(screenMemcard)($s1)
    /* 1E070 8002D870 7D020224 */  addiu      $v0, $zero, 0x27D
    /* 1E074 8002D874 CF4D000C */  jal        Redraw__14tFEApplication
    /* 1E078 8002D878 840562AC */   sw        $v0, 0x584($v1)
    /* 1E07C 8002D87C 00241200 */  sll        $a0, $s2, 16
    /* 1E080 8002D880 03240400 */  sra        $a0, $a0, 16
    /* 1E084 8002D884 21280000 */  addu       $a1, $zero, $zero
    /* 1E088 8002D888 86D3000C */  jal        LoadGame__FsbT1
    /* 1E08C 8002D88C 01000624 */   addiu     $a2, $zero, 0x1
    /* 1E090 8002D890 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 1E094 8002D894 C014048E */  lw         $a0, %lo(FEApp)($s0)
    /* 1E098 8002D898 F028238E */  lw         $v1, %lo(screenMemcard)($s1)
    /* 1E09C 8002D89C D0028424 */  addiu      $a0, $a0, 0x2D0
    /* 1E0A0 8002D8A0 4162000C */  jal        Hide__11tDialogBase
    /* 1E0A4 8002D8A4 840562AC */   sw        $v0, 0x584($v1)
  .L8002D8A8:
    /* 1E0A8 8002D8A8 0580023C */  lui        $v0, %hi(FEApp)
    /* 1E0AC 8002D8AC C014448C */  lw         $a0, %lo(FEApp)($v0)
    /* 1E0B0 8002D8B0 4162000C */  jal        Hide__11tDialogBase
    /* 1E0B4 8002D8B4 D0028424 */   addiu     $a0, $a0, 0x2D0
    /* 1E0B8 8002D8B8 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 1E0BC 8002D8BC 1800B28F */  lw         $s2, 0x18($sp)
    /* 1E0C0 8002D8C0 1400B18F */  lw         $s1, 0x14($sp)
    /* 1E0C4 8002D8C4 1000B08F */  lw         $s0, 0x10($sp)
    /* 1E0C8 8002D8C8 0800E003 */  jr         $ra
    /* 1E0CC 8002D8CC 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel GenericMenuLoadGame__Fi
