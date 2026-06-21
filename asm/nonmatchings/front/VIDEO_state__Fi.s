.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching VIDEO_state__Fi, 0xA8

glabel VIDEO_state__Fi
    /* 41798 80050F98 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 4179C 80050F9C 2000B0AF */  sw         $s0, 0x20($sp)
    /* 417A0 80050FA0 21808000 */  addu       $s0, $a0, $zero
    /* 417A4 80050FA4 4457033C */  lui        $v1, (0x57444956 >> 16)
    /* 417A8 80050FA8 2400BFAF */  sw         $ra, 0x24($sp)
    /* 417AC 80050FAC 0000028E */  lw         $v0, 0x0($s0)
    /* 417B0 80050FB0 56496334 */  ori        $v1, $v1, (0x57444956 & 0xFFFF)
    /* 417B4 80050FB4 1E004314 */  bne        $v0, $v1, .L80051030
    /* 417B8 80050FB8 21100000 */   addu      $v0, $zero, $zero
    /* 417BC 80050FBC 1C00038E */  lw         $v1, 0x1C($s0)
    /* 417C0 80050FC0 01000224 */  addiu      $v0, $zero, 0x1
    /* 417C4 80050FC4 11006214 */  bne        $v1, $v0, .L8005100C
    /* 417C8 80050FC8 03000224 */   addiu     $v0, $zero, 0x3
    /* 417CC 80050FCC 1800048E */  lw         $a0, 0x18($s0)
    /* 417D0 80050FD0 01F7030C */  jal        STREAM_state
    /* 417D4 80050FD4 00000000 */   nop
    /* 417D8 80050FD8 02000324 */  addiu      $v1, $zero, 0x2
    /* 417DC 80050FDC 13004314 */  bne        $v0, $v1, .L8005102C
    /* 417E0 80050FE0 1480023C */   lui       $v0, %hi(ticks)
    /* 417E4 80050FE4 ACDC438C */  lw         $v1, %lo(ticks)($v0)
    /* 417E8 80050FE8 03000224 */  addiu      $v0, $zero, 0x3
    /* 417EC 80050FEC 1C0002AE */  sw         $v0, 0x1C($s0)
    /* 417F0 80050FF0 280000AE */  sw         $zero, 0x28($s0)
    /* 417F4 80050FF4 2C0000AE */  sw         $zero, 0x2C($s0)
    /* 417F8 80050FF8 80100300 */  sll        $v0, $v1, 2
    /* 417FC 80050FFC 21104300 */  addu       $v0, $v0, $v1
    /* 41800 80051000 40100200 */  sll        $v0, $v0, 1
    /* 41804 80051004 0B440108 */  j          .L8005102C
    /* 41808 80051008 240002AE */   sw        $v0, 0x24($s0)
  .L8005100C:
    /* 4180C 8005100C 07006214 */  bne        $v1, $v0, .L8005102C
    /* 41810 80051010 00000000 */   nop
    /* 41814 80051014 1800048E */  lw         $a0, 0x18($s0)
    /* 41818 80051018 01F7030C */  jal        STREAM_state
    /* 4181C 8005101C 00000000 */   nop
    /* 41820 80051020 02004014 */  bnez       $v0, .L8005102C
    /* 41824 80051024 00000000 */   nop
    /* 41828 80051028 1C0000AE */  sw         $zero, 0x1C($s0)
  .L8005102C:
    /* 4182C 8005102C 1C00028E */  lw         $v0, 0x1C($s0)
  .L80051030:
    /* 41830 80051030 2400BF8F */  lw         $ra, 0x24($sp)
    /* 41834 80051034 2000B08F */  lw         $s0, 0x20($sp)
    /* 41838 80051038 0800E003 */  jr         $ra
    /* 4183C 8005103C 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel VIDEO_state__Fi
