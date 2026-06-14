.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching transmult, 0x144

glabel transmult
    /* F6740 80105F40 98FFBD27 */  addiu      $sp, $sp, -0x68
    /* F6744 80105F44 5400B5AF */  sw         $s5, 0x54($sp)
    /* F6748 80105F48 21A80000 */  addu       $s5, $zero, $zero
    /* F674C 80105F4C 6000BEAF */  sw         $fp, 0x60($sp)
    /* F6750 80105F50 08001E24 */  addiu      $fp, $zero, 0x8
    /* F6754 80105F54 5C00B7AF */  sw         $s7, 0x5C($sp)
    /* F6758 80105F58 04001724 */  addiu      $s7, $zero, 0x4
    /* F675C 80105F5C 5800B6AF */  sw         $s6, 0x58($sp)
    /* F6760 80105F60 6800A4AF */  sw         $a0, 0x68($sp)
    /* F6764 80105F64 21B08000 */  addu       $s6, $a0, $zero
    /* F6768 80105F68 6400BFAF */  sw         $ra, 0x64($sp)
    /* F676C 80105F6C 5000B4AF */  sw         $s4, 0x50($sp)
    /* F6770 80105F70 4C00B3AF */  sw         $s3, 0x4C($sp)
    /* F6774 80105F74 4800B2AF */  sw         $s2, 0x48($sp)
    /* F6778 80105F78 4400B1AF */  sw         $s1, 0x44($sp)
    /* F677C 80105F7C 4000B0AF */  sw         $s0, 0x40($sp)
    /* F6780 80105F80 6C00A5AF */  sw         $a1, 0x6C($sp)
    /* F6784 80105F84 7000A6AF */  sw         $a2, 0x70($sp)
  .L80105F88:
    /* F6788 80105F88 21880000 */  addu       $s1, $zero, $zero
    /* F678C 80105F8C 18001424 */  addiu      $s4, $zero, 0x18
    /* F6790 80105F90 6800A38F */  lw         $v1, 0x68($sp)
    /* F6794 80105F94 0C001324 */  addiu      $s3, $zero, 0xC
    /* F6798 80105F98 21187700 */  addu       $v1, $v1, $s7
    /* F679C 80105F9C 3800A3AF */  sw         $v1, 0x38($sp)
    /* F67A0 80105FA0 6800A38F */  lw         $v1, 0x68($sp)
    /* F67A4 80105FA4 6C00B28F */  lw         $s2, 0x6C($sp)
    /* F67A8 80105FA8 21187E00 */  addu       $v1, $v1, $fp
    /* F67AC 80105FAC 3C00A3AF */  sw         $v1, 0x3C($sp)
  .L80105FB0:
    /* F67B0 80105FB0 0000C48E */  lw         $a0, 0x0($s6)
    /* F67B4 80105FB4 0000458E */  lw         $a1, 0x0($s2)
    /* F67B8 80105FB8 CA90030C */  jal        fixedmult
    /* F67BC 80105FBC 04005226 */   addiu     $s2, $s2, 0x4
    /* F67C0 80105FC0 3800A38F */  lw         $v1, 0x38($sp)
    /* F67C4 80105FC4 00000000 */  nop
    /* F67C8 80105FC8 0000648C */  lw         $a0, 0x0($v1)
    /* F67CC 80105FCC 6C00A38F */  lw         $v1, 0x6C($sp)
    /* F67D0 80105FD0 21804000 */  addu       $s0, $v0, $zero
    /* F67D4 80105FD4 21107300 */  addu       $v0, $v1, $s3
    /* F67D8 80105FD8 0000458C */  lw         $a1, 0x0($v0)
    /* F67DC 80105FDC CA90030C */  jal        fixedmult
    /* F67E0 80105FE0 04007326 */   addiu     $s3, $s3, 0x4
    /* F67E4 80105FE4 3C00A38F */  lw         $v1, 0x3C($sp)
    /* F67E8 80105FE8 00000000 */  nop
    /* F67EC 80105FEC 0000648C */  lw         $a0, 0x0($v1)
    /* F67F0 80105FF0 6C00A38F */  lw         $v1, 0x6C($sp)
    /* F67F4 80105FF4 21800202 */  addu       $s0, $s0, $v0
    /* F67F8 80105FF8 21107400 */  addu       $v0, $v1, $s4
    /* F67FC 80105FFC 0000458C */  lw         $a1, 0x0($v0)
    /* F6800 80106000 CA90030C */  jal        fixedmult
    /* F6804 80106004 04009426 */   addiu     $s4, $s4, 0x4
    /* F6808 80106008 21800202 */  addu       $s0, $s0, $v0
    /* F680C 8010600C 2110B102 */  addu       $v0, $s5, $s1
    /* F6810 80106010 01003126 */  addiu      $s1, $s1, 0x1
    /* F6814 80106014 80100200 */  sll        $v0, $v0, 2
    /* F6818 80106018 1000A427 */  addiu      $a0, $sp, 0x10
    /* F681C 8010601C 21108200 */  addu       $v0, $a0, $v0
    /* F6820 80106020 000050AC */  sw         $s0, 0x0($v0)
    /* F6824 80106024 0300222A */  slti       $v0, $s1, 0x3
    /* F6828 80106028 E1FF4014 */  bnez       $v0, .L80105FB0
    /* F682C 8010602C 00000000 */   nop
    /* F6830 80106030 0C00DE27 */  addiu      $fp, $fp, 0xC
    /* F6834 80106034 0C00F726 */  addiu      $s7, $s7, 0xC
    /* F6838 80106038 0300B526 */  addiu      $s5, $s5, 0x3
    /* F683C 8010603C 0900A22A */  slti       $v0, $s5, 0x9
    /* F6840 80106040 D1FF4014 */  bnez       $v0, .L80105F88
    /* F6844 80106044 0C00D626 */   addiu     $s6, $s6, 0xC
    /* F6848 80106048 7000A58F */  lw         $a1, 0x70($sp)
    /* F684C 8010604C B798030C */  jal        blockmove
    /* F6850 80106050 24000624 */   addiu     $a2, $zero, 0x24
    /* F6854 80106054 6400BF8F */  lw         $ra, 0x64($sp)
    /* F6858 80106058 6000BE8F */  lw         $fp, 0x60($sp)
    /* F685C 8010605C 5C00B78F */  lw         $s7, 0x5C($sp)
    /* F6860 80106060 5800B68F */  lw         $s6, 0x58($sp)
    /* F6864 80106064 5400B58F */  lw         $s5, 0x54($sp)
    /* F6868 80106068 5000B48F */  lw         $s4, 0x50($sp)
    /* F686C 8010606C 4C00B38F */  lw         $s3, 0x4C($sp)
    /* F6870 80106070 4800B28F */  lw         $s2, 0x48($sp)
    /* F6874 80106074 4400B18F */  lw         $s1, 0x44($sp)
    /* F6878 80106078 4000B08F */  lw         $s0, 0x40($sp)
    /* F687C 8010607C 0800E003 */  jr         $ra
    /* F6880 80106080 6800BD27 */   addiu     $sp, $sp, 0x68
endlabel transmult
