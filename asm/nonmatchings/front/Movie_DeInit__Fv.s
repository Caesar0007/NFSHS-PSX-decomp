.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Movie_DeInit__Fv, 0xD8

glabel Movie_DeInit__Fv
    /* 3CFD8 8004C7D8 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 3CFDC 8004C7DC 0E000424 */  addiu      $a0, $zero, 0xE
    /* 3CFE0 8004C7E0 1000A527 */  addiu      $a1, $sp, 0x10
    /* 3CFE4 8004C7E4 21300000 */  addu       $a2, $zero, $zero
    /* 3CFE8 8004C7E8 0580023C */  lui        $v0, %hi(D_80052D14)
    /* 3CFEC 8004C7EC 142D40AC */  sw         $zero, %lo(D_80052D14)($v0)
    /* 3CFF0 8004C7F0 80000224 */  addiu      $v0, $zero, 0x80
    /* 3CFF4 8004C7F4 1800BFAF */  sw         $ra, 0x18($sp)
    /* 3CFF8 8004C7F8 C9DE030C */  jal        CdControlB
    /* 3CFFC 8004C7FC 1000A2A3 */   sb        $v0, 0x10($sp)
    /* 3D000 8004C800 B5E2030C */  jal        DecDCToutCallback
    /* 3D004 8004C804 21200000 */   addu      $a0, $zero, $zero
    /* 3D008 8004C808 B2E3030C */  jal        StUnSetRing
    /* 3D00C 8004C80C 00000000 */   nop
    /* 3D010 8004C810 2CDF030C */  jal        CdDataCallback
    /* 3D014 8004C814 21200000 */   addu      $a0, $zero, $zero
    /* 3D018 8004C818 28DE030C */  jal        CdReadyCallback
    /* 3D01C 8004C81C 21200000 */   addu      $a0, $zero, $zero
    /* 3D020 8004C820 0B000424 */  addiu      $a0, $zero, 0xB
    /* 3D024 8004C824 21280000 */  addu       $a1, $zero, $zero
    /* 3D028 8004C828 C9DE030C */  jal        CdControlB
    /* 3D02C 8004C82C 2130A000 */   addu      $a2, $a1, $zero
    /* 3D030 8004C830 09000424 */  addiu      $a0, $zero, 0x9
    /* 3D034 8004C834 21280000 */  addu       $a1, $zero, $zero
    /* 3D038 8004C838 C9DE030C */  jal        CdControlB
    /* 3D03C 8004C83C 2130A000 */   addu      $a2, $a1, $zero
    /* 3D040 8004C840 0C000424 */  addiu      $a0, $zero, 0xC
    /* 3D044 8004C844 21280000 */  addu       $a1, $zero, $zero
    /* 3D048 8004C848 C9DE030C */  jal        CdControlB
    /* 3D04C 8004C84C 2130A000 */   addu      $a2, $a1, $zero
    /* 3D050 8004C850 0580023C */  lui        $v0, %hi(D_80052D58)
    /* 3D054 8004C854 582D448C */  lw         $a0, %lo(D_80052D58)($v0)
    /* 3D058 8004C858 5095030C */  jal        purgememadr
    /* 3D05C 8004C85C 00000000 */   nop
    /* 3D060 8004C860 0580023C */  lui        $v0, %hi(D_80052D5C)
    /* 3D064 8004C864 5C2D448C */  lw         $a0, %lo(D_80052D5C)($v0)
    /* 3D068 8004C868 5095030C */  jal        purgememadr
    /* 3D06C 8004C86C 00000000 */   nop
    /* 3D070 8004C870 0580023C */  lui        $v0, %hi(D_80052D60)
    /* 3D074 8004C874 602D448C */  lw         $a0, %lo(D_80052D60)($v0)
    /* 3D078 8004C878 5095030C */  jal        purgememadr
    /* 3D07C 8004C87C 00000000 */   nop
    /* 3D080 8004C880 0580023C */  lui        $v0, %hi(D_80052D64)
    /* 3D084 8004C884 642D448C */  lw         $a0, %lo(D_80052D64)($v0)
    /* 3D088 8004C888 5095030C */  jal        purgememadr
    /* 3D08C 8004C88C 00000000 */   nop
    /* 3D090 8004C890 2871030C */  jal        Platform_ResetDCTBuffer__Fv
    /* 3D094 8004C894 00000000 */   nop
    /* 3D098 8004C898 2AE9030C */  jal        CD_Restart
    /* 3D09C 8004C89C 21200000 */   addu      $a0, $zero, $zero
    /* 3D0A0 8004C8A0 1800BF8F */  lw         $ra, 0x18($sp)
    /* 3D0A4 8004C8A4 00000000 */  nop
    /* 3D0A8 8004C8A8 0800E003 */  jr         $ra
    /* 3D0AC 8004C8AC 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Movie_DeInit__Fv
