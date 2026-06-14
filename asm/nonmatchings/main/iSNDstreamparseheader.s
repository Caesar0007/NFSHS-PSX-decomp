.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDstreamparseheader, 0x1A8

glabel iSNDstreamparseheader
    /* D969C 800E8E9C D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* D96A0 800E8EA0 2400B3AF */  sw         $s3, 0x24($sp)
    /* D96A4 800E8EA4 21988000 */  addu       $s3, $a0, $zero
    /* D96A8 800E8EA8 2000B2AF */  sw         $s2, 0x20($sp)
    /* D96AC 800E8EAC 2190A000 */  addu       $s2, $a1, $zero
    /* D96B0 800E8EB0 0C004426 */  addiu      $a0, $s2, 0xC
    /* D96B4 800E8EB4 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* D96B8 800E8EB8 20007126 */  addiu      $s1, $s3, 0x20
    /* D96BC 800E8EBC 21282002 */  addu       $a1, $s1, $zero
    /* D96C0 800E8EC0 2800B4AF */  sw         $s4, 0x28($sp)
    /* D96C4 800E8EC4 38007426 */  addiu      $s4, $s3, 0x38
    /* D96C8 800E8EC8 21308002 */  addu       $a2, $s4, $zero
    /* D96CC 800E8ECC 1000A727 */  addiu      $a3, $sp, 0x10
    /* D96D0 800E8ED0 2C00BFAF */  sw         $ra, 0x2C($sp)
    /* D96D4 800E8ED4 1800B0AF */  sw         $s0, 0x18($sp)
    /* D96D8 800E8ED8 17006392 */  lbu        $v1, 0x17($s3)
    /* D96DC 800E8EDC 0000708E */  lw         $s0, 0x0($s3)
    /* D96E0 800E8EE0 001E0300 */  sll        $v1, $v1, 24
    /* D96E4 800E8EE4 031E0300 */  sra        $v1, $v1, 24
    /* D96E8 800E8EE8 40100300 */  sll        $v0, $v1, 1
    /* D96EC 800E8EEC 21104300 */  addu       $v0, $v0, $v1
    /* D96F0 800E8EF0 80100200 */  sll        $v0, $v0, 2
    /* D96F4 800E8EF4 23104300 */  subu       $v0, $v0, $v1
    /* D96F8 800E8EF8 80100200 */  sll        $v0, $v0, 2
    /* D96FC 800E8EFC 790D040C */  jal        iSNDpatchtohdr
    /* D9700 800E8F00 21800202 */   addu      $s0, $s0, $v0
    /* D9704 800E8F04 1000A28F */  lw         $v0, 0x10($sp)
    /* D9708 800E8F08 00000000 */  nop
    /* D970C 800E8F0C 180002AE */  sw         $v0, 0x18($s0)
    /* D9710 800E8F10 0400648E */  lw         $a0, 0x4($s3)
    /* D9714 800E8F14 B4F6030C */  jal        STREAM_release
    /* D9718 800E8F18 21284002 */   addu      $a1, $s2, $zero
    /* D971C 800E8F1C 4992033C */  lui        $v1, (0x92492493 >> 16)
    /* D9720 800E8F20 1800028E */  lw         $v0, 0x18($s0)
    /* D9724 800E8F24 93246334 */  ori        $v1, $v1, (0x92492493 & 0xFFFF)
    /* D9728 800E8F28 1B004224 */  addiu      $v0, $v0, 0x1B
    /* D972C 800E8F2C 18004300 */  mult       $v0, $v1
    /* D9730 800E8F30 21202002 */  addu       $a0, $s1, $zero
    /* D9734 800E8F34 10400000 */  mfhi       $t0
    /* D9738 800E8F38 21180201 */  addu       $v1, $t0, $v0
    /* D973C 800E8F3C 03190300 */  sra        $v1, $v1, 4
    /* D9740 800E8F40 C3170200 */  sra        $v0, $v0, 31
    /* D9744 800E8F44 23186200 */  subu       $v1, $v1, $v0
    /* D9748 800E8F48 C0100300 */  sll        $v0, $v1, 3
    /* D974C 800E8F4C 23104300 */  subu       $v0, $v0, $v1
    /* D9750 800E8F50 80100200 */  sll        $v0, $v0, 2
    /* D9754 800E8F54 180002AE */  sw         $v0, 0x18($s0)
    /* D9758 800E8F58 7B10040C */  jal        iSNDplatformcalcdatarate
    /* D975C 800E8F5C 00000000 */   nop
    /* D9760 800E8F60 1C006426 */  addiu      $a0, $s3, 0x1C
    /* D9764 800E8F64 21282002 */  addu       $a1, $s1, $zero
    /* D9768 800E8F68 04000624 */  addiu      $a2, $zero, 0x4
    /* D976C 800E8F6C 100002AE */  sw         $v0, 0x10($s0)
    /* D9770 800E8F70 CD0D040C */  jal        memcmp
    /* D9774 800E8F74 00000000 */   nop
    /* D9778 800E8F78 06004014 */  bnez       $v0, .L800E8F94
    /* D977C 800E8F7C 24006426 */   addiu     $a0, $s3, 0x24
    /* D9780 800E8F80 21288002 */  addu       $a1, $s4, $zero
    /* D9784 800E8F84 CD0D040C */  jal        memcmp
    /* D9788 800E8F88 14000624 */   addiu     $a2, $zero, 0x14
    /* D978C 800E8F8C 18004010 */  beqz       $v0, .L800E8FF0
    /* D9790 800E8F90 00000000 */   nop
  .L800E8F94:
    /* D9794 800E8F94 1C006296 */  lhu        $v0, 0x1C($s3)
    /* D9798 800E8F98 00000000 */  nop
    /* D979C 800E8F9C 04004010 */  beqz       $v0, .L800E8FB0
    /* D97A0 800E8FA0 02000224 */   addiu     $v0, $zero, 0x2
    /* D97A4 800E8FA4 140062A2 */  sb         $v0, 0x14($s3)
    /* D97A8 800E8FA8 09A40308 */  j          .L800E9024
    /* D97AC 800E8FAC 21100000 */   addu      $v0, $zero, $zero
  .L800E8FB0:
    /* D97B0 800E8FB0 2300698A */  lwl        $t1, 0x23($s3)
    /* D97B4 800E8FB4 2000699A */  lwr        $t1, 0x20($s3)
    /* D97B8 800E8FB8 00000000 */  nop
    /* D97BC 800E8FBC 1F0069AA */  swl        $t1, 0x1F($s3)
    /* D97C0 800E8FC0 1C0069BA */  swr        $t1, 0x1C($s3)
    /* D97C4 800E8FC4 3800698E */  lw         $t1, 0x38($s3)
    /* D97C8 800E8FC8 3C006A8E */  lw         $t2, 0x3C($s3)
    /* D97CC 800E8FCC 40006B8E */  lw         $t3, 0x40($s3)
    /* D97D0 800E8FD0 4400688E */  lw         $t0, 0x44($s3)
    /* D97D4 800E8FD4 240069AE */  sw         $t1, 0x24($s3)
    /* D97D8 800E8FD8 28006AAE */  sw         $t2, 0x28($s3)
    /* D97DC 800E8FDC 2C006BAE */  sw         $t3, 0x2C($s3)
    /* D97E0 800E8FE0 300068AE */  sw         $t0, 0x30($s3)
    /* D97E4 800E8FE4 4800698E */  lw         $t1, 0x48($s3)
    /* D97E8 800E8FE8 00000000 */  nop
    /* D97EC 800E8FEC 340069AE */  sw         $t1, 0x34($s3)
  .L800E8FF0:
    /* D97F0 800E8FF0 14006292 */  lbu        $v0, 0x14($s3)
    /* D97F4 800E8FF4 01001024 */  addiu      $s0, $zero, 0x1
    /* D97F8 800E8FF8 00160200 */  sll        $v0, $v0, 24
    /* D97FC 800E8FFC 03160200 */  sra        $v0, $v0, 24
    /* D9800 800E9000 07005010 */  beq        $v0, $s0, .L800E9020
    /* D9804 800E9004 1C006526 */   addiu     $a1, $s3, 0x1C
    /* D9808 800E9008 24006626 */  addiu      $a2, $s3, 0x24
    /* D980C 800E900C 0C00648E */  lw         $a0, 0xC($s3)
    /* D9810 800E9010 840A040C */  jal        SNDPKTPLAY_start
    /* D9814 800E9014 4C006726 */   addiu     $a3, $s3, 0x4C
    /* D9818 800E9018 080062AE */  sw         $v0, 0x8($s3)
    /* D981C 800E901C 140070A2 */  sb         $s0, 0x14($s3)
  .L800E9020:
    /* D9820 800E9020 21100000 */  addu       $v0, $zero, $zero
  .L800E9024:
    /* D9824 800E9024 2C00BF8F */  lw         $ra, 0x2C($sp)
    /* D9828 800E9028 2800B48F */  lw         $s4, 0x28($sp)
    /* D982C 800E902C 2400B38F */  lw         $s3, 0x24($sp)
    /* D9830 800E9030 2000B28F */  lw         $s2, 0x20($sp)
    /* D9834 800E9034 1C00B18F */  lw         $s1, 0x1C($sp)
    /* D9838 800E9038 1800B08F */  lw         $s0, 0x18($sp)
    /* D983C 800E903C 0800E003 */  jr         $ra
    /* D9840 800E9040 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel iSNDstreamparseheader
