.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching strInit__FP6CdlLOCiPFe_vT2, 0x98

glabel strInit__FP6CdlLOCiPFe_vT2
    /* 3D7A0 8004CFA0 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 3D7A4 8004CFA4 2400B3AF */  sw         $s3, 0x24($sp)
    /* 3D7A8 8004CFA8 21988000 */  addu       $s3, $a0, $zero
    /* 3D7AC 8004CFAC 2000B2AF */  sw         $s2, 0x20($sp)
    /* 3D7B0 8004CFB0 2190A000 */  addu       $s2, $a1, $zero
    /* 3D7B4 8004CFB4 1800B0AF */  sw         $s0, 0x18($sp)
    /* 3D7B8 8004CFB8 2180C000 */  addu       $s0, $a2, $zero
    /* 3D7BC 8004CFBC 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* 3D7C0 8004CFC0 2188E000 */  addu       $s1, $a3, $zero
    /* 3D7C4 8004CFC4 2800BFAF */  sw         $ra, 0x28($sp)
    /* 3D7C8 8004CFC8 72E2030C */  jal        DecDCTReset
    /* 3D7CC 8004CFCC 21200000 */   addu      $a0, $zero, $zero
    /* 3D7D0 8004CFD0 21200002 */  addu       $a0, $s0, $zero
    /* 3D7D4 8004CFD4 0580023C */  lui        $v0, %hi(D_80052D1C)
    /* 3D7D8 8004CFD8 B5E2030C */  jal        DecDCToutCallback
    /* 3D7DC 8004CFDC 1C2D40AC */   sw        $zero, %lo(D_80052D1C)($v0)
    /* 3D7E0 8004CFE0 0580023C */  lui        $v0, %hi(D_80052D64)
    /* 3D7E4 8004CFE4 642D448C */  lw         $a0, %lo(D_80052D64)($v0)
    /* 3D7E8 8004CFE8 7EE6030C */  jal        StSetRing
    /* 3D7EC 8004CFEC 20000524 */   addiu     $a1, $zero, 0x20
    /* 3D7F0 8004CFF0 5AE2030C */  jal        StClearRing
    /* 3D7F4 8004CFF4 00000000 */   nop
    /* 3D7F8 8004CFF8 0580023C */  lui        $v0, %hi(D_80052D04)
    /* 3D7FC 8004CFFC 01000524 */  addiu      $a1, $zero, 0x1
    /* 3D800 8004D000 21304002 */  addu       $a2, $s2, $zero
    /* 3D804 8004D004 042D448C */  lw         $a0, %lo(D_80052D04)($v0)
    /* 3D808 8004D008 21380000 */  addu       $a3, $zero, $zero
    /* 3D80C 8004D00C FEE3030C */  jal        StSetStream
    /* 3D810 8004D010 1000B1AF */   sw        $s1, 0x10($sp)
    /* 3D814 8004D014 A335010C */  jal        strKickCD__FP6CdlLOC
    /* 3D818 8004D018 21206002 */   addu      $a0, $s3, $zero
    /* 3D81C 8004D01C 2800BF8F */  lw         $ra, 0x28($sp)
    /* 3D820 8004D020 2400B38F */  lw         $s3, 0x24($sp)
    /* 3D824 8004D024 2000B28F */  lw         $s2, 0x20($sp)
    /* 3D828 8004D028 1C00B18F */  lw         $s1, 0x1C($sp)
    /* 3D82C 8004D02C 1800B08F */  lw         $s0, 0x18($sp)
    /* 3D830 8004D030 0800E003 */  jr         $ra
    /* 3D834 8004D034 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel strInit__FP6CdlLOCiPFe_vT2
