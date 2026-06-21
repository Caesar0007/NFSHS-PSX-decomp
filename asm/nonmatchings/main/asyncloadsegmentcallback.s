.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching asyncloadsegmentcallback, 0xF4

glabel asyncloadsegmentcallback
    /* E1CBC 800F14BC D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* E1CC0 800F14C0 2400B3AF */  sw         $s3, 0x24($sp)
    /* E1CC4 800F14C4 21988000 */  addu       $s3, $a0, $zero
    /* E1CC8 800F14C8 2800B4AF */  sw         $s4, 0x28($sp)
    /* E1CCC 800F14CC 21A0A000 */  addu       $s4, $a1, $zero
    /* E1CD0 800F14D0 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* E1CD4 800F14D4 2188C000 */  addu       $s1, $a2, $zero
    /* E1CD8 800F14D8 2000B2AF */  sw         $s2, 0x20($sp)
    /* E1CDC 800F14DC 2190E000 */  addu       $s2, $a3, $zero
    /* E1CE0 800F14E0 1480043C */  lui        $a0, %hi(D_8013DEA0)
    /* E1CE4 800F14E4 A0DE8424 */  addiu      $a0, $a0, %lo(D_8013DEA0)
    /* E1CE8 800F14E8 2C00BFAF */  sw         $ra, 0x2C($sp)
    /* E1CEC 800F14EC DDC2030C */  jal        queuefetch
    /* E1CF0 800F14F0 1800B0AF */   sw        $s0, 0x18($sp)
    /* E1CF4 800F14F4 21804000 */  addu       $s0, $v0, $zero
    /* E1CF8 800F14F8 25000012 */  beqz       $s0, .L800F1590
    /* E1CFC 800F14FC 21100000 */   addu      $v0, $zero, $zero
    /* E1D00 800F1500 F0C2030C */  jal        newrequestid
    /* E1D04 800F1504 21200002 */   addu      $a0, $s0, $zero
    /* E1D08 800F1508 6419848F */  lw         $a0, %gp_rel(D_8013DEB0)($gp)
    /* E1D0C 800F150C 080000AE */  sw         $zero, 0x8($s0)
    /* E1D10 800F1510 0C0000AE */  sw         $zero, 0xC($s0)
    /* E1D14 800F1514 100000AE */  sw         $zero, 0x10($s0)
    /* E1D18 800F1518 140012AE */  sw         $s2, 0x14($s0)
    /* E1D1C 800F151C 200013AE */  sw         $s3, 0x20($s0)
    /* E1D20 800F1520 240011AE */  sw         $s1, 0x24($s0)
    /* E1D24 800F1524 05008014 */  bnez       $a0, .L800F153C
    /* E1D28 800F1528 280014AE */   sw        $s4, 0x28($s0)
    /* E1D2C 800F152C 3AC3030C */  jal        finishrequest
    /* E1D30 800F1530 21200002 */   addu      $a0, $s0, $zero
    /* E1D34 800F1534 63C50308 */  j          .L800F158C
    /* E1D38 800F1538 00000000 */   nop
  .L800F153C:
    /* E1D3C 800F153C 4419838F */  lw         $v1, %gp_rel(D_8013DE90)($gp)
    /* E1D40 800F1540 00000000 */  nop
    /* E1D44 800F1544 2A107100 */  slt        $v0, $v1, $s1
    /* E1D48 800F1548 02004010 */  beqz       $v0, .L800F1554
    /* E1D4C 800F154C 64000224 */   addiu     $v0, $zero, 0x64
    /* E1D50 800F1550 21886000 */  addu       $s1, $v1, $zero
  .L800F1554:
    /* E1D54 800F1554 1000A2AF */  sw         $v0, 0x10($sp)
    /* E1D58 800F1558 1400B0AF */  sw         $s0, 0x14($sp)
    /* E1D5C 800F155C 2000058E */  lw         $a1, 0x20($s0)
    /* E1D60 800F1560 2800068E */  lw         $a2, 0x28($s0)
    /* E1D64 800F1564 3BB1030C */  jal        FILE_read
    /* E1D68 800F1568 21382002 */   addu      $a3, $s1, $zero
    /* E1D6C 800F156C 03004014 */  bnez       $v0, .L800F157C
    /* E1D70 800F1570 180002AE */   sw        $v0, 0x18($s0)
    /* E1D74 800F1574 64C50308 */  j          .L800F1590
    /* E1D78 800F1578 21100000 */   addu      $v0, $zero, $zero
  .L800F157C:
    /* E1D7C 800F157C 21204000 */  addu       $a0, $v0, $zero
    /* E1D80 800F1580 0F80053C */  lui        $a1, %hi(loadsegreadcallback)
    /* E1D84 800F1584 93AF030C */  jal        FILE_callbackop
    /* E1D88 800F1588 2410A524 */   addiu     $a1, $a1, %lo(loadsegreadcallback)
  .L800F158C:
    /* E1D8C 800F158C 0000028E */  lw         $v0, 0x0($s0)
  .L800F1590:
    /* E1D90 800F1590 2C00BF8F */  lw         $ra, 0x2C($sp)
    /* E1D94 800F1594 2800B48F */  lw         $s4, 0x28($sp)
    /* E1D98 800F1598 2400B38F */  lw         $s3, 0x24($sp)
    /* E1D9C 800F159C 2000B28F */  lw         $s2, 0x20($sp)
    /* E1DA0 800F15A0 1C00B18F */  lw         $s1, 0x1C($sp)
    /* E1DA4 800F15A4 1800B08F */  lw         $s0, 0x18($sp)
    /* E1DA8 800F15A8 0800E003 */  jr         $ra
    /* E1DAC 800F15AC 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel asyncloadsegmentcallback
