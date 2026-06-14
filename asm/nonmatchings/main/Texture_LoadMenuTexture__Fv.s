.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Texture_LoadMenuTexture__Fv, 0x1B4

glabel Texture_LoadMenuTexture__Fv
    /* D0E98 800E0698 C0FEBD27 */  addiu      $sp, $sp, -0x140
    /* D0E9C 800E069C 2801B2AF */  sw         $s2, 0x128($sp)
    /* D0EA0 800E06A0 1280123C */  lui        $s2, %hi(gMenuPixmap)
    /* D0EA4 800E06A4 D00F428E */  lw         $v0, %lo(gMenuPixmap)($s2)
    /* D0EA8 800E06A8 3401B5AF */  sw         $s5, 0x134($sp)
    /* D0EAC 800E06AC D00F5526 */  addiu      $s5, $s2, %lo(gMenuPixmap)
    /* D0EB0 800E06B0 3801BFAF */  sw         $ra, 0x138($sp)
    /* D0EB4 800E06B4 3001B4AF */  sw         $s4, 0x130($sp)
    /* D0EB8 800E06B8 2C01B3AF */  sw         $s3, 0x12C($sp)
    /* D0EBC 800E06BC 2401B1AF */  sw         $s1, 0x124($sp)
    /* D0EC0 800E06C0 59004014 */  bnez       $v0, .L800E0828
    /* D0EC4 800E06C4 2001B0AF */   sw        $s0, 0x120($sp)
    /* D0EC8 800E06C8 2000A427 */  addiu      $a0, $sp, 0x20
    /* D0ECC 800E06CC 1180023C */  lui        $v0, %hi(D_801164CC)
    /* D0ED0 800E06D0 0580053C */  lui        $a1, %hi(D_80056A88)
    /* D0ED4 800E06D4 CC64468C */  lw         $a2, %lo(D_801164CC)($v0)
    /* D0ED8 800E06D8 2F91030C */  jal        sprintf
    /* D0EDC 800E06DC 886AA524 */   addiu     $a1, $a1, %lo(D_80056A88)
    /* D0EE0 800E06E0 2000A427 */  addiu      $a0, $sp, 0x20
    /* D0EE4 800E06E4 FA95030C */  jal        loadfileadr
    /* D0EE8 800E06E8 21280000 */   addu      $a1, $zero, $zero
    /* D0EEC 800E06EC 9E7D030C */  jal        Texture_ResetPaletteSharing__Fv
    /* D0EF0 800E06F0 21984000 */   addu      $s3, $v0, $zero
    /* D0EF4 800E06F4 21206002 */  addu       $a0, $s3, $zero
    /* D0EF8 800E06F8 1480053C */  lui        $a1, %hi(D_8013DAD8)
    /* D0EFC 800E06FC D8DAA524 */  addiu      $a1, $a1, %lo(D_8013DAD8)
    /* D0F00 800E0700 21300000 */  addu       $a2, $zero, $zero
    /* D0F04 800E0704 80030724 */  addiu      $a3, $zero, 0x380
    /* D0F08 800E0708 80011424 */  addiu      $s4, $zero, 0x180
    /* D0F0C 800E070C FFFF1024 */  addiu      $s0, $zero, -0x1
    /* D0F10 800E0710 1280113C */  lui        $s1, %hi(gMenuPixmapAlloc)
    /* D0F14 800E0714 F00F3126 */  addiu      $s1, $s1, %lo(gMenuPixmapAlloc)
    /* D0F18 800E0718 1000B4AF */  sw         $s4, 0x10($sp)
    /* D0F1C 800E071C 1400B0AF */  sw         $s0, 0x14($sp)
    /* D0F20 800E0720 1800B0AF */  sw         $s0, 0x18($sp)
    /* D0F24 800E0724 C67F030C */  jal        Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
    /* D0F28 800E0728 1C00B1AF */   sw        $s1, 0x1C($sp)
    /* D0F2C 800E072C 21206002 */  addu       $a0, $s3, $zero
    /* D0F30 800E0730 1480053C */  lui        $a1, %hi(D_8013DAE0)
    /* D0F34 800E0734 E0DAA524 */  addiu      $a1, $a1, %lo(D_8013DAE0)
    /* D0F38 800E0738 21300000 */  addu       $a2, $zero, $zero
    /* D0F3C 800E073C 80030724 */  addiu      $a3, $zero, 0x380
    /* D0F40 800E0740 D00F51AE */  sw         $s1, %lo(gMenuPixmap)($s2)
    /* D0F44 800E0744 10003226 */  addiu      $s2, $s1, 0x10
    /* D0F48 800E0748 1000B4AF */  sw         $s4, 0x10($sp)
    /* D0F4C 800E074C 1400B0AF */  sw         $s0, 0x14($sp)
    /* D0F50 800E0750 1800B0AF */  sw         $s0, 0x18($sp)
    /* D0F54 800E0754 C67F030C */  jal        Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
    /* D0F58 800E0758 1C00B2AF */   sw        $s2, 0x1C($sp)
    /* D0F5C 800E075C 21206002 */  addu       $a0, $s3, $zero
    /* D0F60 800E0760 1480053C */  lui        $a1, %hi(D_8013DAE8)
    /* D0F64 800E0764 E8DAA524 */  addiu      $a1, $a1, %lo(D_8013DAE8)
    /* D0F68 800E0768 21300000 */  addu       $a2, $zero, $zero
    /* D0F6C 800E076C 80030724 */  addiu      $a3, $zero, 0x380
    /* D0F70 800E0770 0400B2AE */  sw         $s2, 0x4($s5)
    /* D0F74 800E0774 20003226 */  addiu      $s2, $s1, 0x20
    /* D0F78 800E0778 1000B4AF */  sw         $s4, 0x10($sp)
    /* D0F7C 800E077C 1400B0AF */  sw         $s0, 0x14($sp)
    /* D0F80 800E0780 1800B0AF */  sw         $s0, 0x18($sp)
    /* D0F84 800E0784 C67F030C */  jal        Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
    /* D0F88 800E0788 1C00B2AF */   sw        $s2, 0x1C($sp)
    /* D0F8C 800E078C 21206002 */  addu       $a0, $s3, $zero
    /* D0F90 800E0790 1480053C */  lui        $a1, %hi(D_8013DAF0)
    /* D0F94 800E0794 F0DAA524 */  addiu      $a1, $a1, %lo(D_8013DAF0)
    /* D0F98 800E0798 21300000 */  addu       $a2, $zero, $zero
    /* D0F9C 800E079C 80030724 */  addiu      $a3, $zero, 0x380
    /* D0FA0 800E07A0 0C00B2AE */  sw         $s2, 0xC($s5)
    /* D0FA4 800E07A4 30003226 */  addiu      $s2, $s1, 0x30
    /* D0FA8 800E07A8 1000B4AF */  sw         $s4, 0x10($sp)
    /* D0FAC 800E07AC 1400B0AF */  sw         $s0, 0x14($sp)
    /* D0FB0 800E07B0 1800B0AF */  sw         $s0, 0x18($sp)
    /* D0FB4 800E07B4 C67F030C */  jal        Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
    /* D0FB8 800E07B8 1C00B2AF */   sw        $s2, 0x1C($sp)
    /* D0FBC 800E07BC 21206002 */  addu       $a0, $s3, $zero
    /* D0FC0 800E07C0 1480053C */  lui        $a1, %hi(D_8013DAF8)
    /* D0FC4 800E07C4 F8DAA524 */  addiu      $a1, $a1, %lo(D_8013DAF8)
    /* D0FC8 800E07C8 21300000 */  addu       $a2, $zero, $zero
    /* D0FCC 800E07CC 80030724 */  addiu      $a3, $zero, 0x380
    /* D0FD0 800E07D0 1000B2AE */  sw         $s2, 0x10($s5)
    /* D0FD4 800E07D4 40003226 */  addiu      $s2, $s1, 0x40
    /* D0FD8 800E07D8 1000B4AF */  sw         $s4, 0x10($sp)
    /* D0FDC 800E07DC 1400B0AF */  sw         $s0, 0x14($sp)
    /* D0FE0 800E07E0 1800B0AF */  sw         $s0, 0x18($sp)
    /* D0FE4 800E07E4 C67F030C */  jal        Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
    /* D0FE8 800E07E8 1C00B2AF */   sw        $s2, 0x1C($sp)
    /* D0FEC 800E07EC 21206002 */  addu       $a0, $s3, $zero
    /* D0FF0 800E07F0 1480053C */  lui        $a1, %hi(D_8013DB00)
    /* D0FF4 800E07F4 00DBA524 */  addiu      $a1, $a1, %lo(D_8013DB00)
    /* D0FF8 800E07F8 21300000 */  addu       $a2, $zero, $zero
    /* D0FFC 800E07FC 80030724 */  addiu      $a3, $zero, 0x380
    /* D1000 800E0800 50003126 */  addiu      $s1, $s1, 0x50
    /* D1004 800E0804 1400B2AE */  sw         $s2, 0x14($s5)
    /* D1008 800E0808 1000B4AF */  sw         $s4, 0x10($sp)
    /* D100C 800E080C 1400B0AF */  sw         $s0, 0x14($sp)
    /* D1010 800E0810 1800B0AF */  sw         $s0, 0x18($sp)
    /* D1014 800E0814 C67F030C */  jal        Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
    /* D1018 800E0818 1C00B1AF */   sw        $s1, 0x1C($sp)
    /* D101C 800E081C 21206002 */  addu       $a0, $s3, $zero
    /* D1020 800E0820 5095030C */  jal        purgememadr
    /* D1024 800E0824 1800B1AE */   sw        $s1, 0x18($s5)
  .L800E0828:
    /* D1028 800E0828 3801BF8F */  lw         $ra, 0x138($sp)
    /* D102C 800E082C 3401B58F */  lw         $s5, 0x134($sp)
    /* D1030 800E0830 3001B48F */  lw         $s4, 0x130($sp)
    /* D1034 800E0834 2C01B38F */  lw         $s3, 0x12C($sp)
    /* D1038 800E0838 2801B28F */  lw         $s2, 0x128($sp)
    /* D103C 800E083C 2401B18F */  lw         $s1, 0x124($sp)
    /* D1040 800E0840 2001B08F */  lw         $s0, 0x120($sp)
    /* D1044 800E0844 0800E003 */  jr         $ra
    /* D1048 800E0848 4001BD27 */   addiu     $sp, $sp, 0x140
endlabel Texture_LoadMenuTexture__Fv
