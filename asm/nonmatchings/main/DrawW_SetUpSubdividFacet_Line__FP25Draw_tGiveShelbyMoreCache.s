.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawW_SetUpSubdividFacet_Line__FP25Draw_tGiveShelbyMoreCache, 0x298

glabel DrawW_SetUpSubdividFacet_Line__FP25Draw_tGiveShelbyMoreCache
    /* B9E20 800C9620 C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* B9E24 800C9624 3000B4AF */  sw         $s4, 0x30($sp)
    /* B9E28 800C9628 21A08000 */  addu       $s4, $a0, $zero
    /* B9E2C 800C962C 2C00B3AF */  sw         $s3, 0x2C($sp)
    /* B9E30 800C9630 4C019326 */  addiu      $s3, $s4, 0x14C
    /* B9E34 800C9634 21206002 */  addu       $a0, $s3, $zero
    /* B9E38 800C9638 98008526 */  addiu      $a1, $s4, 0x98
    /* B9E3C 800C963C 2800B2AF */  sw         $s2, 0x28($sp)
    /* B9E40 800C9640 5C019226 */  addiu      $s2, $s4, 0x15C
    /* B9E44 800C9644 2000B0AF */  sw         $s0, 0x20($sp)
    /* B9E48 800C9648 6C019026 */  addiu      $s0, $s4, 0x16C
    /* B9E4C 800C964C 2400B1AF */  sw         $s1, 0x24($sp)
    /* B9E50 800C9650 3400BFAF */  sw         $ra, 0x34($sp)
    /* B9E54 800C9654 ED16030C */  jal        DrawW_LoadPrecVECTOR__FP12Draw_SVertexP6VECTOR
    /* B9E58 800C9658 7C019126 */   addiu     $s1, $s4, 0x17C
    /* B9E5C 800C965C 21204002 */  addu       $a0, $s2, $zero
    /* B9E60 800C9660 ED16030C */  jal        DrawW_LoadPrecVECTOR__FP12Draw_SVertexP6VECTOR
    /* B9E64 800C9664 A8008526 */   addiu     $a1, $s4, 0xA8
    /* B9E68 800C9668 21200002 */  addu       $a0, $s0, $zero
    /* B9E6C 800C966C ED16030C */  jal        DrawW_LoadPrecVECTOR__FP12Draw_SVertexP6VECTOR
    /* B9E70 800C9670 B8008526 */   addiu     $a1, $s4, 0xB8
    /* B9E74 800C9674 21202002 */  addu       $a0, $s1, $zero
    /* B9E78 800C9678 ED16030C */  jal        DrawW_LoadPrecVECTOR__FP12Draw_SVertexP6VECTOR
    /* B9E7C 800C967C C8008526 */   addiu     $a1, $s4, 0xC8
    /* B9E80 800C9680 000060CA */  lwc2       $0, 0x0($s3)
    /* B9E84 800C9684 040061CA */  lwc2       $1, 0x4($s3)
    /* B9E88 800C9688 00000000 */  nop
    /* B9E8C 800C968C 00000000 */  nop
    /* B9E90 800C9690 0100184A */  .word 0x4A180001  /* rtps */
    /* B9E94 800C9694 54018226 */  addiu      $v0, $s4, 0x154
    /* B9E98 800C9698 00004EE8 */  swc2       $14, 0x0($v0)
    /* B9E9C 800C969C 000040CA */  lwc2       $0, 0x0($s2)
    /* B9EA0 800C96A0 040041CA */  lwc2       $1, 0x4($s2)
    /* B9EA4 800C96A4 000002CA */  lwc2       $2, 0x0($s0)
    /* B9EA8 800C96A8 040003CA */  lwc2       $3, 0x4($s0)
    /* B9EAC 800C96AC 000024CA */  lwc2       $4, 0x0($s1)
    /* B9EB0 800C96B0 040025CA */  lwc2       $5, 0x4($s1)
    /* B9EB4 800C96B4 00000000 */  nop
    /* B9EB8 800C96B8 00000000 */  nop
    /* B9EBC 800C96BC 3000284A */  .word 0x4A280030  /* rtpt */
    /* B9EC0 800C96C0 10018326 */  addiu      $v1, $s4, 0x110
    /* B9EC4 800C96C4 1000628C */  lw         $v0, 0x10($v1)
    /* B9EC8 800C96C8 0400648C */  lw         $a0, 0x4($v1)
    /* B9ECC 800C96CC 64018526 */  addiu      $a1, $s4, 0x164
    /* B9ED0 800C96D0 0C0002AE */  sw         $v0, 0xC($s0)
    /* B9ED4 800C96D4 0C0042AE */  sw         $v0, 0xC($s2)
    /* B9ED8 800C96D8 0C0024AE */  sw         $a0, 0xC($s1)
    /* B9EDC 800C96DC 0C0064AE */  sw         $a0, 0xC($s3)
    /* B9EE0 800C96E0 74018426 */  addiu      $a0, $s4, 0x174
    /* B9EE4 800C96E4 84018226 */  addiu      $v0, $s4, 0x184
    /* B9EE8 800C96E8 0000ACE8 */  swc2       $12, 0x0($a1)
    /* B9EEC 800C96EC 00008DE8 */  swc2       $13, 0x0($a0)
    /* B9EF0 800C96F0 00004EE8 */  swc2       $14, 0x0($v0)
    /* B9EF4 800C96F4 0C006294 */  lhu        $v0, 0xC($v1)
    /* B9EF8 800C96F8 18006494 */  lhu        $a0, 0x18($v1)
    /* B9EFC 800C96FC 30006594 */  lhu        $a1, 0x30($v1)
    /* B9F00 800C9700 24006394 */  lhu        $v1, 0x24($v1)
    /* B9F04 800C9704 060062A6 */  sh         $v0, 0x6($s3)
    /* B9F08 800C9708 060044A6 */  sh         $a0, 0x6($s2)
    /* B9F0C 800C970C 060005A6 */  sh         $a1, 0x6($s0)
    /* B9F10 800C9710 060023A6 */  sh         $v1, 0x6($s1)
    /* B9F14 800C9714 08006486 */  lh         $a0, 0x8($s3)
    /* B9F18 800C9718 00000000 */  nop
    /* B9F1C 800C971C E9038228 */  slti       $v0, $a0, 0x3E9
    /* B9F20 800C9720 10004010 */  beqz       $v0, .L800C9764
    /* B9F24 800C9724 0F0060A2 */   sb        $zero, 0xF($s3)
    /* B9F28 800C9728 0A006386 */  lh         $v1, 0xA($s3)
    /* B9F2C 800C972C 00000000 */  nop
    /* B9F30 800C9730 E9036228 */  slti       $v0, $v1, 0x3E9
    /* B9F34 800C9734 0B004010 */  beqz       $v0, .L800C9764
    /* B9F38 800C9738 18FC8228 */   slti      $v0, $a0, -0x3E8
    /* B9F3C 800C973C 0A004014 */  bnez       $v0, .L800C9768
    /* B9F40 800C9740 01000224 */   addiu     $v0, $zero, 0x1
    /* B9F44 800C9744 18FC6228 */  slti       $v0, $v1, -0x3E8
    /* B9F48 800C9748 07004014 */  bnez       $v0, .L800C9768
    /* B9F4C 800C974C 01000224 */   addiu     $v0, $zero, 0x1
    /* B9F50 800C9750 04006286 */  lh         $v0, 0x4($s3)
    /* B9F54 800C9754 00000000 */  nop
    /* B9F58 800C9758 65004228 */  slti       $v0, $v0, 0x65
    /* B9F5C 800C975C 03004010 */  beqz       $v0, .L800C976C
    /* B9F60 800C9760 00000000 */   nop
  .L800C9764:
    /* B9F64 800C9764 01000224 */  addiu      $v0, $zero, 0x1
  .L800C9768:
    /* B9F68 800C9768 0F0062A2 */  sb         $v0, 0xF($s3)
  .L800C976C:
    /* B9F6C 800C976C 08004486 */  lh         $a0, 0x8($s2)
    /* B9F70 800C9770 00000000 */  nop
    /* B9F74 800C9774 E9038228 */  slti       $v0, $a0, 0x3E9
    /* B9F78 800C9778 10004010 */  beqz       $v0, .L800C97BC
    /* B9F7C 800C977C 0F0040A2 */   sb        $zero, 0xF($s2)
    /* B9F80 800C9780 0A004386 */  lh         $v1, 0xA($s2)
    /* B9F84 800C9784 00000000 */  nop
    /* B9F88 800C9788 E9036228 */  slti       $v0, $v1, 0x3E9
    /* B9F8C 800C978C 0B004010 */  beqz       $v0, .L800C97BC
    /* B9F90 800C9790 18FC8228 */   slti      $v0, $a0, -0x3E8
    /* B9F94 800C9794 0A004014 */  bnez       $v0, .L800C97C0
    /* B9F98 800C9798 01000224 */   addiu     $v0, $zero, 0x1
    /* B9F9C 800C979C 18FC6228 */  slti       $v0, $v1, -0x3E8
    /* B9FA0 800C97A0 07004014 */  bnez       $v0, .L800C97C0
    /* B9FA4 800C97A4 01000224 */   addiu     $v0, $zero, 0x1
    /* B9FA8 800C97A8 04004286 */  lh         $v0, 0x4($s2)
    /* B9FAC 800C97AC 00000000 */  nop
    /* B9FB0 800C97B0 65004228 */  slti       $v0, $v0, 0x65
    /* B9FB4 800C97B4 03004010 */  beqz       $v0, .L800C97C4
    /* B9FB8 800C97B8 00000000 */   nop
  .L800C97BC:
    /* B9FBC 800C97BC 01000224 */  addiu      $v0, $zero, 0x1
  .L800C97C0:
    /* B9FC0 800C97C0 0F0042A2 */  sb         $v0, 0xF($s2)
  .L800C97C4:
    /* B9FC4 800C97C4 08000486 */  lh         $a0, 0x8($s0)
    /* B9FC8 800C97C8 00000000 */  nop
    /* B9FCC 800C97CC E9038228 */  slti       $v0, $a0, 0x3E9
    /* B9FD0 800C97D0 10004010 */  beqz       $v0, .L800C9814
    /* B9FD4 800C97D4 0F0000A2 */   sb        $zero, 0xF($s0)
    /* B9FD8 800C97D8 0A000386 */  lh         $v1, 0xA($s0)
    /* B9FDC 800C97DC 00000000 */  nop
    /* B9FE0 800C97E0 E9036228 */  slti       $v0, $v1, 0x3E9
    /* B9FE4 800C97E4 0B004010 */  beqz       $v0, .L800C9814
    /* B9FE8 800C97E8 18FC8228 */   slti      $v0, $a0, -0x3E8
    /* B9FEC 800C97EC 0A004014 */  bnez       $v0, .L800C9818
    /* B9FF0 800C97F0 01000224 */   addiu     $v0, $zero, 0x1
    /* B9FF4 800C97F4 18FC6228 */  slti       $v0, $v1, -0x3E8
    /* B9FF8 800C97F8 07004014 */  bnez       $v0, .L800C9818
    /* B9FFC 800C97FC 01000224 */   addiu     $v0, $zero, 0x1
    /* BA000 800C9800 04000286 */  lh         $v0, 0x4($s0)
    /* BA004 800C9804 00000000 */  nop
    /* BA008 800C9808 65004228 */  slti       $v0, $v0, 0x65
    /* BA00C 800C980C 03004010 */  beqz       $v0, .L800C981C
    /* BA010 800C9810 00000000 */   nop
  .L800C9814:
    /* BA014 800C9814 01000224 */  addiu      $v0, $zero, 0x1
  .L800C9818:
    /* BA018 800C9818 0F0002A2 */  sb         $v0, 0xF($s0)
  .L800C981C:
    /* BA01C 800C981C 08002486 */  lh         $a0, 0x8($s1)
    /* BA020 800C9820 00000000 */  nop
    /* BA024 800C9824 E9038228 */  slti       $v0, $a0, 0x3E9
    /* BA028 800C9828 10004010 */  beqz       $v0, .L800C986C
    /* BA02C 800C982C 0F0020A2 */   sb        $zero, 0xF($s1)
    /* BA030 800C9830 0A002386 */  lh         $v1, 0xA($s1)
    /* BA034 800C9834 00000000 */  nop
    /* BA038 800C9838 E9036228 */  slti       $v0, $v1, 0x3E9
    /* BA03C 800C983C 0B004010 */  beqz       $v0, .L800C986C
    /* BA040 800C9840 18FC8228 */   slti      $v0, $a0, -0x3E8
    /* BA044 800C9844 0A004014 */  bnez       $v0, .L800C9870
    /* BA048 800C9848 01000224 */   addiu     $v0, $zero, 0x1
    /* BA04C 800C984C 18FC6228 */  slti       $v0, $v1, -0x3E8
    /* BA050 800C9850 07004014 */  bnez       $v0, .L800C9870
    /* BA054 800C9854 01000224 */   addiu     $v0, $zero, 0x1
    /* BA058 800C9858 04002286 */  lh         $v0, 0x4($s1)
    /* BA05C 800C985C 00000000 */  nop
    /* BA060 800C9860 65004228 */  slti       $v0, $v0, 0x65
    /* BA064 800C9864 04004010 */  beqz       $v0, .L800C9878
    /* BA068 800C9868 21208002 */   addu      $a0, $s4, $zero
  .L800C986C:
    /* BA06C 800C986C 01000224 */  addiu      $v0, $zero, 0x1
  .L800C9870:
    /* BA070 800C9870 0F0022A2 */  sb         $v0, 0xF($s1)
    /* BA074 800C9874 21208002 */  addu       $a0, $s4, $zero
  .L800C9878:
    /* BA078 800C9878 21280000 */  addu       $a1, $zero, $zero
    /* BA07C 800C987C 21306002 */  addu       $a2, $s3, $zero
    /* BA080 800C9880 21384002 */  addu       $a3, $s2, $zero
    /* BA084 800C9884 1000B0AF */  sw         $s0, 0x10($sp)
    /* BA088 800C9888 1400B1AF */  sw         $s1, 0x14($sp)
    /* BA08C 800C988C 1800A0AF */  sw         $zero, 0x18($sp)
    /* BA090 800C9890 A114030C */  jal        DrawW_SubdividFacet__FP25Draw_tGiveShelbyMoreCacheiP12Draw_SVertexN32ss
    /* BA094 800C9894 1C00A0AF */   sw        $zero, 0x1C($sp)
    /* BA098 800C9898 3400BF8F */  lw         $ra, 0x34($sp)
    /* BA09C 800C989C 3000B48F */  lw         $s4, 0x30($sp)
    /* BA0A0 800C98A0 2C00B38F */  lw         $s3, 0x2C($sp)
    /* BA0A4 800C98A4 2800B28F */  lw         $s2, 0x28($sp)
    /* BA0A8 800C98A8 2400B18F */  lw         $s1, 0x24($sp)
    /* BA0AC 800C98AC 2000B08F */  lw         $s0, 0x20($sp)
    /* BA0B0 800C98B0 0800E003 */  jr         $ra
    /* BA0B4 800C98B4 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel DrawW_SetUpSubdividFacet_Line__FP25Draw_tGiveShelbyMoreCache
