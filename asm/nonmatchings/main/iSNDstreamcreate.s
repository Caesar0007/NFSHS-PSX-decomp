.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDstreamcreate, 0x240

glabel iSNDstreamcreate
    /* D9F30 800E9730 C0FFBD27 */  addiu      $sp, $sp, -0x40
    /* D9F34 800E9734 1480023C */  lui        $v0, %hi(D_8014789C)
    /* D9F38 800E9738 2400B3AF */  sw         $s3, 0x24($sp)
    /* D9F3C 800E973C 5000B38F */  lw         $s3, 0x50($sp)
    /* D9F40 800E9740 9C784280 */  lb         $v0, %lo(D_8014789C)($v0)
    /* D9F44 800E9744 3400B7AF */  sw         $s7, 0x34($sp)
    /* D9F48 800E9748 5800B78F */  lw         $s7, 0x58($sp)
    /* D9F4C 800E974C 3800BEAF */  sw         $fp, 0x38($sp)
    /* D9F50 800E9750 21F08000 */  addu       $fp, $a0, $zero
    /* D9F54 800E9754 2C00B5AF */  sw         $s5, 0x2C($sp)
    /* D9F58 800E9758 21A8A000 */  addu       $s5, $a1, $zero
    /* D9F5C 800E975C 3000B6AF */  sw         $s6, 0x30($sp)
    /* D9F60 800E9760 21B0C000 */  addu       $s6, $a2, $zero
    /* D9F64 800E9764 2000B2AF */  sw         $s2, 0x20($sp)
    /* D9F68 800E9768 2190E000 */  addu       $s2, $a3, $zero
    /* D9F6C 800E976C 3C00BFAF */  sw         $ra, 0x3C($sp)
    /* D9F70 800E9770 2800B4AF */  sw         $s4, 0x28($sp)
    /* D9F74 800E9774 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* D9F78 800E9778 03004014 */  bnez       $v0, .L800E9788
    /* D9F7C 800E977C 1800B0AF */   sw        $s0, 0x18($sp)
    /* D9F80 800E9780 50A60308 */  j          .L800E9940
    /* D9F84 800E9784 F6FF0224 */   addiu     $v0, $zero, -0xA
  .L800E9788:
    /* D9F88 800E9788 21280000 */  addu       $a1, $zero, $zero
    /* D9F8C 800E978C 1480023C */  lui        $v0, %hi(sndss)
    /* D9F90 800E9790 80EA4324 */  addiu      $v1, $v0, %lo(sndss)
  .L800E9794:
    /* D9F94 800E9794 0000628C */  lw         $v0, 0x0($v1)
    /* D9F98 800E9798 00000000 */  nop
    /* D9F9C 800E979C 06004010 */  beqz       $v0, .L800E97B8
    /* D9FA0 800E97A0 21884002 */   addu      $s1, $s2, $zero
    /* D9FA4 800E97A4 0100A524 */  addiu      $a1, $a1, 0x1
    /* D9FA8 800E97A8 FAFFA018 */  blez       $a1, .L800E9794
    /* D9FAC 800E97AC 04006324 */   addiu     $v1, $v1, 0x4
    /* D9FB0 800E97B0 50A60308 */  j          .L800E9940
    /* D9FB4 800E97B4 F7FF0224 */   addiu     $v0, $zero, -0x9
  .L800E97B8:
    /* D9FB8 800E97B8 60003226 */  addiu      $s2, $s1, 0x60
    /* D9FBC 800E97BC A0FF7326 */  addiu      $s3, $s3, -0x60
    /* D9FC0 800E97C0 40101500 */  sll        $v0, $s5, 1
    /* D9FC4 800E97C4 21105500 */  addu       $v0, $v0, $s5
    /* D9FC8 800E97C8 80100200 */  sll        $v0, $v0, 2
    /* D9FCC 800E97CC 23105500 */  subu       $v0, $v0, $s5
    /* D9FD0 800E97D0 80100200 */  sll        $v0, $v0, 2
    /* D9FD4 800E97D4 000032AE */  sw         $s2, 0x0($s1)
    /* D9FD8 800E97D8 21904202 */  addu       $s2, $s2, $v0
    /* D9FDC 800E97DC 23986202 */  subu       $s3, $s3, $v0
    /* D9FE0 800E97E0 2120C002 */  addu       $a0, $s6, $zero
    /* D9FE4 800E97E4 340A040C */  jal        SNDPKTPLAY_overhead
    /* D9FE8 800E97E8 21A0A000 */   addu      $s4, $a1, $zero
    /* D9FEC 800E97EC 21804002 */  addu       $s0, $s2, $zero
    /* D9FF0 800E97F0 21904202 */  addu       $s2, $s2, $v0
    /* D9FF4 800E97F4 23986202 */  subu       $s3, $s3, $v0
    /* D9FF8 800E97F8 340A040C */  jal        SNDPKTPLAY_overhead
    /* D9FFC 800E97FC 2120C002 */   addu      $a0, $s6, $zero
    /* DA000 800E9800 21200002 */  addu       $a0, $s0, $zero
    /* DA004 800E9804 21284000 */  addu       $a1, $v0, $zero
    /* DA008 800E9808 0F80063C */  lui        $a2, %hi(iSNDstreamreleasecallback)
    /* DA00C 800E980C 908DC624 */  addiu      $a2, $a2, %lo(iSNDstreamreleasecallback)
    /* DA010 800E9810 0F80073C */  lui        $a3, %hi(iSNDstreamnotifycallback)
    /* DA014 800E9814 3F0A040C */  jal        SNDPKTPLAY_create
    /* DA018 800E9818 D48DE724 */   addiu     $a3, $a3, %lo(iSNDstreamnotifycallback)
    /* DA01C 800E981C 0C0022AE */  sw         $v0, 0xC($s1)
    /* DA020 800E9820 0C00228E */  lw         $v0, 0xC($s1)
    /* DA024 800E9824 00000000 */  nop
    /* DA028 800E9828 04004104 */  bgez       $v0, .L800E983C
    /* DA02C 800E982C 1480023C */   lui       $v0, %hi(sndss)
    /* DA030 800E9830 0C00228E */  lw         $v0, 0xC($s1)
    /* DA034 800E9834 50A60308 */  j          .L800E9940
    /* DA038 800E9838 00000000 */   nop
  .L800E983C:
    /* DA03C 800E983C 0C00238E */  lw         $v1, 0xC($s1)
    /* DA040 800E9840 80EA4224 */  addiu      $v0, $v0, %lo(sndss)
    /* DA044 800E9844 21186200 */  addu       $v1, $v1, $v0
    /* DA048 800E9848 0800E012 */  beqz       $s7, .L800E986C
    /* DA04C 800E984C 040074A0 */   sb        $s4, 0x4($v1)
    /* DA050 800E9850 5400A28F */  lw         $v0, 0x54($sp)
    /* DA054 800E9854 00000000 */  nop
    /* DA058 800E9858 040022AE */  sw         $v0, 0x4($s1)
    /* DA05C 800E985C 01000224 */  addiu      $v0, $zero, 0x1
    /* DA060 800E9860 180022A2 */  sb         $v0, 0x18($s1)
    /* DA064 800E9864 2FA60308 */  j          .L800E98BC
    /* DA068 800E9868 FFFF0224 */   addiu     $v0, $zero, -0x1
  .L800E986C:
    /* DA06C 800E986C 0100A426 */  addiu      $a0, $s5, 0x1
    /* DA070 800E9870 01000524 */  addiu      $a1, $zero, 0x1
    /* DA074 800E9874 2130A000 */  addu       $a2, $a1, $zero
    /* DA078 800E9878 21384002 */  addu       $a3, $s2, $zero
    /* DA07C 800E987C 85F3030C */  jal        STREAM_create
    /* DA080 800E9880 1000B3AF */   sw        $s3, 0x10($sp)
    /* DA084 800E9884 040022AE */  sw         $v0, 0x4($s1)
    /* DA088 800E9888 21204000 */  addu       $a0, $v0, $zero
    /* DA08C 800E988C 180020A2 */  sb         $zero, 0x18($s1)
    /* DA090 800E9890 26F7030C */  jal        STREAM_buffersize
    /* DA094 800E9894 00000000 */   nop
    /* DA098 800E9898 5555033C */  lui        $v1, (0x55555556 >> 16)
    /* DA09C 800E989C 56556334 */  ori        $v1, $v1, (0x55555556 & 0xFFFF)
    /* DA0A0 800E98A0 18004300 */  mult       $v0, $v1
    /* DA0A4 800E98A4 C3170200 */  sra        $v0, $v0, 31
    /* DA0A8 800E98A8 0400248E */  lw         $a0, 0x4($s1)
    /* DA0AC 800E98AC 10400000 */  mfhi       $t0
    /* DA0B0 800E98B0 4CA7030C */  jal        SNDSTRM_setgreedylevel
    /* DA0B4 800E98B4 23280201 */   subu      $a1, $t0, $v0
    /* DA0B8 800E98B8 FFFF0224 */  addiu      $v0, $zero, -0x1
  .L800E98BC:
    /* DA0BC 800E98BC 100020AE */  sw         $zero, 0x10($s1)
    /* DA0C0 800E98C0 080022AE */  sw         $v0, 0x8($s1)
    /* DA0C4 800E98C4 150035A2 */  sb         $s5, 0x15($s1)
    /* DA0C8 800E98C8 0000C98F */  lw         $t1, 0x0($fp)
    /* DA0CC 800E98CC 0400CA8F */  lw         $t2, 0x4($fp)
    /* DA0D0 800E98D0 0800CB8F */  lw         $t3, 0x8($fp)
    /* DA0D4 800E98D4 0C00C88F */  lw         $t0, 0xC($fp)
    /* DA0D8 800E98D8 4C0029AE */  sw         $t1, 0x4C($s1)
    /* DA0DC 800E98DC 50002AAE */  sw         $t2, 0x50($s1)
    /* DA0E0 800E98E0 54002BAE */  sw         $t3, 0x54($s1)
    /* DA0E4 800E98E4 580028AE */  sw         $t0, 0x58($s1)
    /* DA0E8 800E98E8 1000C98F */  lw         $t1, 0x10($fp)
    /* DA0EC 800E98EC 00000000 */  nop
    /* DA0F0 800E98F0 5C0029AE */  sw         $t1, 0x5C($s1)
    /* DA0F4 800E98F4 BEA5030C */  jal        iSNDstreamnumcreated
    /* DA0F8 800E98F8 00000000 */   nop
    /* DA0FC 800E98FC 09004014 */  bnez       $v0, .L800E9924
    /* DA100 800E9900 1480033C */   lui       $v1, %hi(sndss)
    /* DA104 800E9904 0F80043C */  lui        $a0, %hi(iSNDstreamservice)
    /* DA108 800E9908 E711040C */  jal        iSNDserveraddclient
    /* DA10C 800E990C 90958424 */   addiu     $a0, $a0, %lo(iSNDstreamservice)
    /* DA110 800E9910 1480033C */  lui        $v1, %hi(D_801478E8)
    /* DA114 800E9914 0F80023C */  lui        $v0, %hi(iSNDstreamdestroyall)
    /* DA118 800E9918 148C4224 */  addiu      $v0, $v0, %lo(iSNDstreamdestroyall)
    /* DA11C 800E991C E87862AC */  sw         $v0, %lo(D_801478E8)($v1)
    /* DA120 800E9920 1480033C */  lui        $v1, %hi(sndss)
  .L800E9924:
    /* DA124 800E9924 80EA6324 */  addiu      $v1, $v1, %lo(sndss)
    /* DA128 800E9928 80101400 */  sll        $v0, $s4, 2
    /* DA12C 800E992C 21104300 */  addu       $v0, $v0, $v1
    /* DA130 800E9930 000051AC */  sw         $s1, 0x0($v0)
    /* DA134 800E9934 16A7030C */  jal        SNDSTRM_purge
    /* DA138 800E9938 21208002 */   addu      $a0, $s4, $zero
    /* DA13C 800E993C 21108002 */  addu       $v0, $s4, $zero
  .L800E9940:
    /* DA140 800E9940 3C00BF8F */  lw         $ra, 0x3C($sp)
    /* DA144 800E9944 3800BE8F */  lw         $fp, 0x38($sp)
    /* DA148 800E9948 3400B78F */  lw         $s7, 0x34($sp)
    /* DA14C 800E994C 3000B68F */  lw         $s6, 0x30($sp)
    /* DA150 800E9950 2C00B58F */  lw         $s5, 0x2C($sp)
    /* DA154 800E9954 2800B48F */  lw         $s4, 0x28($sp)
    /* DA158 800E9958 2400B38F */  lw         $s3, 0x24($sp)
    /* DA15C 800E995C 2000B28F */  lw         $s2, 0x20($sp)
    /* DA160 800E9960 1C00B18F */  lw         $s1, 0x1C($sp)
    /* DA164 800E9964 1800B08F */  lw         $s0, 0x18($sp)
    /* DA168 800E9968 0800E003 */  jr         $ra
    /* DA16C 800E996C 4000BD27 */   addiu     $sp, $sp, 0x40
endlabel iSNDstreamcreate
