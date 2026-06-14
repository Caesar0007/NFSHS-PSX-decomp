.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Force_Disable__Fv, 0x74

glabel Force_Disable__Fv
    /* BB8E4 800CB0E4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* BB8E8 800CB0E8 1280023C */  lui        $v0, %hi(Force_g)
    /* BB8EC 800CB0EC 60FD4424 */  addiu      $a0, $v0, %lo(Force_g)
    /* BB8F0 800CB0F0 10008324 */  addiu      $v1, $a0, 0x10
    /* BB8F4 800CB0F4 2B108300 */  sltu       $v0, $a0, $v1
    /* BB8F8 800CB0F8 09004010 */  beqz       $v0, .L800CB120
    /* BB8FC 800CB0FC 1000BFAF */   sw        $ra, 0x10($sp)
    /* BB900 800CB100 21286000 */  addu       $a1, $v1, $zero
    /* BB904 800CB104 07008324 */  addiu      $v1, $a0, 0x7
  .L800CB108:
    /* BB908 800CB108 FFFF60A0 */  sb         $zero, -0x1($v1)
    /* BB90C 800CB10C 000060A0 */  sb         $zero, 0x0($v1)
    /* BB910 800CB110 08008424 */  addiu      $a0, $a0, 0x8
    /* BB914 800CB114 2B108500 */  sltu       $v0, $a0, $a1
    /* BB918 800CB118 FBFF4014 */  bnez       $v0, .L800CB108
    /* BB91C 800CB11C 08006324 */   addiu     $v1, $v1, 0x8
  .L800CB120:
    /* BB920 800CB120 1480053C */  lui        $a1, %hi(Force_gOffAlign)
    /* BB924 800CB124 48D8A524 */  addiu      $a1, $a1, %lo(Force_gOffAlign)
    /* BB928 800CB128 4BC0030C */  jal        PadSetActAlign
    /* BB92C 800CB12C 21200000 */   addu      $a0, $zero, $zero
    /* BB930 800CB130 1480053C */  lui        $a1, %hi(Force_gOffAlign)
    /* BB934 800CB134 48D8A524 */  addiu      $a1, $a1, %lo(Force_gOffAlign)
    /* BB938 800CB138 4BC0030C */  jal        PadSetActAlign
    /* BB93C 800CB13C 04000424 */   addiu     $a0, $zero, 0x4
    /* BB940 800CB140 37CA030C */  jal        VSyncCallback
    /* BB944 800CB144 21200000 */   addu      $a0, $zero, $zero
    /* BB948 800CB148 1000BF8F */  lw         $ra, 0x10($sp)
    /* BB94C 800CB14C 00000000 */  nop
    /* BB950 800CB150 0800E003 */  jr         $ra
    /* BB954 800CB154 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Force_Disable__Fv
