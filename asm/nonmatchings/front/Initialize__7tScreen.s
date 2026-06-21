.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Initialize__7tScreen, 0xF4

glabel Initialize__7tScreen
    /* 168AC 800260AC C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* 168B0 800260B0 2C00B1AF */  sw         $s1, 0x2C($sp)
    /* 168B4 800260B4 21888000 */  addu       $s1, $a0, $zero
    /* 168B8 800260B8 3000BFAF */  sw         $ra, 0x30($sp)
    /* 168BC 800260BC AE96000C */  jal        DisplayLoadingText__7tScreen
    /* 168C0 800260C0 2800B0AF */   sw        $s0, 0x28($sp)
    /* 168C4 800260C4 6000228E */  lw         $v0, 0x60($s1)
    /* 168C8 800260C8 00000000 */  nop
    /* 168CC 800260CC 28004484 */  lh         $a0, 0x28($v0)
    /* 168D0 800260D0 2C00428C */  lw         $v0, 0x2C($v0)
    /* 168D4 800260D4 00000000 */  nop
    /* 168D8 800260D8 09F84000 */  jalr       $v0
    /* 168DC 800260DC 21202402 */   addu      $a0, $s1, $a0
    /* 168E0 800260E0 1800A527 */  addiu      $a1, $sp, 0x18
    /* 168E4 800260E4 2000A227 */  addiu      $v0, $sp, 0x20
    /* 168E8 800260E8 6000238E */  lw         $v1, 0x60($s1)
    /* 168EC 800260EC 1A00A627 */  addiu      $a2, $sp, 0x1A
    /* 168F0 800260F0 08006484 */  lh         $a0, 0x8($v1)
    /* 168F4 800260F4 1C00A727 */  addiu      $a3, $sp, 0x1C
    /* 168F8 800260F8 1000A2AF */  sw         $v0, 0x10($sp)
    /* 168FC 800260FC 0C00628C */  lw         $v0, 0xC($v1)
    /* 16900 80026100 00000000 */  nop
    /* 16904 80026104 09F84000 */  jalr       $v0
    /* 16908 80026108 21202402 */   addu      $a0, $s1, $a0
  .L8002610C:
    /* 1690C 8002610C 5256000C */  jal        FeAudio_systemtask__Fi
    /* 16910 80026110 21200000 */   addu      $a0, $zero, $zero
    /* 16914 80026114 21202002 */  addu       $a0, $s1, $zero
    /* 16918 80026118 8397000C */  jal        IsShapeFileLoaded__7tScreenR17tShapeInformation
    /* 1691C 8002611C 21282002 */   addu      $a1, $s1, $zero
    /* 16920 80026120 0400238E */  lw         $v1, 0x4($s1)
    /* 16924 80026124 00000000 */  nop
    /* 16928 80026128 04006010 */  beqz       $v1, .L8002613C
    /* 1692C 8002612C 21804000 */   addu      $s0, $v0, $zero
    /* 16930 80026130 1800A587 */  lh         $a1, 0x18($sp)
    /* 16934 80026134 E197000C */  jal        UploadPermanentShapes__7tScreeni
    /* 16938 80026138 21202002 */   addu      $a0, $s1, $zero
  .L8002613C:
    /* 1693C 8002613C 05000012 */  beqz       $s0, .L80026154
    /* 16940 80026140 21180000 */   addu      $v1, $zero, $zero
    /* 16944 80026144 21202002 */  addu       $a0, $s1, $zero
    /* 16948 80026148 8397000C */  jal        IsShapeFileLoaded__7tScreenR17tShapeInformation
    /* 1694C 8002614C 28002526 */   addiu     $a1, $s1, 0x28
    /* 16950 80026150 2B180200 */  sltu       $v1, $zero, $v0
  .L80026154:
    /* 16954 80026154 2C00228E */  lw         $v0, 0x2C($s1)
    /* 16958 80026158 00000000 */  nop
    /* 1695C 8002615C 04004010 */  beqz       $v0, .L80026170
    /* 16960 80026160 21806000 */   addu      $s0, $v1, $zero
    /* 16964 80026164 1A00A587 */  lh         $a1, 0x1A($sp)
    /* 16968 80026168 F497000C */  jal        UploadSwapShapes__7tScreeni
    /* 1696C 8002616C 21202002 */   addu      $a0, $s1, $zero
  .L80026170:
    /* 16970 80026170 E6FF0012 */  beqz       $s0, .L8002610C
    /* 16974 80026174 00000000 */   nop
    /* 16978 80026178 1800A297 */  lhu        $v0, 0x18($sp)
    /* 1697C 8002617C 1A00A397 */  lhu        $v1, 0x1A($sp)
    /* 16980 80026180 100022A6 */  sh         $v0, 0x10($s1)
    /* 16984 80026184 FE96000C */  jal        GoNonInterlaced__7tScreen
    /* 16988 80026188 380023A6 */   sh        $v1, 0x38($s1)
    /* 1698C 8002618C 3000BF8F */  lw         $ra, 0x30($sp)
    /* 16990 80026190 2C00B18F */  lw         $s1, 0x2C($sp)
    /* 16994 80026194 2800B08F */  lw         $s0, 0x28($sp)
    /* 16998 80026198 0800E003 */  jr         $ra
    /* 1699C 8002619C 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel Initialize__7tScreen
