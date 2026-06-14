.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Night_NightCalc__FP6VECTORPsP25Draw_tGiveShelbyMoreCache, 0xE4

glabel Night_NightCalc__FP6VECTORPsP25Draw_tGiveShelbyMoreCache
    /* B67B8 800C5FB8 01000A24 */  addiu      $t2, $zero, 0x1
    /* B67BC 800C5FBC 0B01C290 */  lbu        $v0, 0x10B($a2)
    /* B67C0 800C5FC0 0800878C */  lw         $a3, 0x8($a0)
    /* B67C4 800C5FC4 0801C884 */  lh         $t0, 0x108($a2)
    /* B67C8 800C5FC8 0C01C390 */  lbu        $v1, 0x10C($a2)
    /* B67CC 800C5FCC 06004224 */  addiu      $v0, $v0, 0x6
    /* B67D0 800C5FD0 04104A00 */  sllv       $v0, $t2, $v0
    /* B67D4 800C5FD4 0D006010 */  beqz       $v1, .L800C600C
    /* B67D8 800C5FD8 21480201 */   addu      $t1, $t0, $v0
    /* B67DC 800C5FDC 0D01C290 */  lbu        $v0, 0x10D($a2)
    /* B67E0 800C5FE0 1480033C */  lui        $v1, %hi(Night_gWeatherLightingTable)
    /* B67E4 800C5FE4 F0D96324 */  addiu      $v1, $v1, %lo(Night_gWeatherLightingTable)
    /* B67E8 800C5FE8 80100200 */  sll        $v0, $v0, 2
    /* B67EC 800C5FEC 21104300 */  addu       $v0, $v0, $v1
    /* B67F0 800C5FF0 0000A384 */  lh         $v1, 0x0($a1)
    /* B67F4 800C5FF4 0000428C */  lw         $v0, 0x0($v0)
    /* B67F8 800C5FF8 00000000 */  nop
    /* B67FC 800C5FFC 21104300 */  addu       $v0, $v0, $v1
    /* B6800 800C6000 00004290 */  lbu        $v0, 0x0($v0)
    /* B6804 800C6004 00000000 */  nop
    /* B6808 800C6008 0000A2A4 */  sh         $v0, 0x0($a1)
  .L800C600C:
    /* B680C 800C600C 2A100701 */  slt        $v0, $t0, $a3
    /* B6810 800C6010 20004010 */  beqz       $v0, .L800C6094
    /* B6814 800C6014 2A10E900 */   slt       $v0, $a3, $t1
    /* B6818 800C6018 1E004010 */  beqz       $v0, .L800C6094
    /* B681C 800C601C 00000000 */   nop
    /* B6820 800C6020 0A01C990 */  lbu        $t1, 0x10A($a2)
    /* B6824 800C6024 0000848C */  lw         $a0, 0x0($a0)
    /* B6828 800C6028 05002225 */  addiu      $v0, $t1, 0x5
    /* B682C 800C602C 04184A00 */  sllv       $v1, $t2, $v0
    /* B6830 800C6030 23100300 */  negu       $v0, $v1
    /* B6834 800C6034 2A104400 */  slt        $v0, $v0, $a0
    /* B6838 800C6038 16004010 */  beqz       $v0, .L800C6094
    /* B683C 800C603C 2A108300 */   slt       $v0, $a0, $v1
    /* B6840 800C6040 14004010 */  beqz       $v0, .L800C6094
    /* B6844 800C6044 2338E800 */   subu      $a3, $a3, $t0
    /* B6848 800C6048 21208300 */  addu       $a0, $a0, $v1
    /* B684C 800C604C 0B01C290 */  lbu        $v0, 0x10B($a2)
    /* B6850 800C6050 07202401 */  srav       $a0, $a0, $t1
    /* B6854 800C6054 07384700 */  srav       $a3, $a3, $v0
    /* B6858 800C6058 80190700 */  sll        $v1, $a3, 6
    /* B685C 800C605C 21186400 */  addu       $v1, $v1, $a0
    /* B6860 800C6060 1480043C */  lui        $a0, %hi(Night_gNightTbl)
    /* B6864 800C6064 40DA848C */  lw         $a0, %lo(Night_gNightTbl)($a0)
    /* B6868 800C6068 0000A284 */  lh         $v0, 0x0($a1)
    /* B686C 800C606C 21208300 */  addu       $a0, $a0, $v1
    /* B6870 800C6070 00110200 */  sll        $v0, $v0, 4
    /* B6874 800C6074 1480033C */  lui        $v1, %hi(Night_gCurrentNightColor)
    /* B6878 800C6078 48DA638C */  lw         $v1, %lo(Night_gCurrentNightColor)($v1)
    /* B687C 800C607C 00008490 */  lbu        $a0, 0x0($a0)
    /* B6880 800C6080 21104300 */  addu       $v0, $v0, $v1
    /* B6884 800C6084 21104400 */  addu       $v0, $v0, $a0
    /* B6888 800C6088 00004290 */  lbu        $v0, 0x0($v0)
    /* B688C 800C608C 00000000 */  nop
    /* B6890 800C6090 0000A2A4 */  sh         $v0, 0x0($a1)
  .L800C6094:
    /* B6894 800C6094 0800E003 */  jr         $ra
    /* B6898 800C6098 00000000 */   nop
endlabel Night_NightCalc__FP6VECTORPsP25Draw_tGiveShelbyMoreCache
