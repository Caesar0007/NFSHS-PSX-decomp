.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching UpdateTrackList__18tTournamentManagerss, 0xD0

glabel UpdateTrackList__18tTournamentManagerss
    /* 22D84 80032584 21408000 */  addu       $t0, $a0, $zero
    /* 22D88 80032588 002C0500 */  sll        $a1, $a1, 16
    /* 22D8C 8003258C 032C0500 */  sra        $a1, $a1, 16
    /* 22D90 80032590 40100500 */  sll        $v0, $a1, 1
    /* 22D94 80032594 21104500 */  addu       $v0, $v0, $a1
    /* 22D98 80032598 80100200 */  sll        $v0, $v0, 2
    /* 22D9C 8003259C 1800048D */  lw         $a0, 0x18($t0)
    /* 22DA0 800325A0 00340600 */  sll        $a2, $a2, 16
    /* 22DA4 800325A4 21108200 */  addu       $v0, $a0, $v0
    /* 22DA8 800325A8 02004390 */  lbu        $v1, 0x2($v0)
    /* 22DAC 800325AC 03340600 */  sra        $a2, $a2, 16
    /* 22DB0 800325B0 21186600 */  addu       $v1, $v1, $a2
    /* 22DB4 800325B4 80100300 */  sll        $v0, $v1, 2
    /* 22DB8 800325B8 21104300 */  addu       $v0, $v0, $v1
    /* 22DBC 800325BC 80100200 */  sll        $v0, $v0, 2
    /* 22DC0 800325C0 21104300 */  addu       $v0, $v0, $v1
    /* 22DC4 800325C4 80100200 */  sll        $v0, $v0, 2
    /* 22DC8 800325C8 24004224 */  addiu      $v0, $v0, 0x24
    /* 22DCC 800325CC 21208200 */  addu       $a0, $a0, $v0
    /* 22DD0 800325D0 01008A90 */  lbu        $t2, 0x1($a0)
    /* 22DD4 800325D4 02008690 */  lbu        $a2, 0x2($a0)
    /* 22DD8 800325D8 21104001 */  addu       $v0, $t2, $zero
    /* 22DDC 800325DC 19004010 */  beqz       $v0, .L80032644
    /* 22DE0 800325E0 21380000 */   addu      $a3, $zero, $zero
    /* 22DE4 800325E4 21484000 */  addu       $t1, $v0, $zero
  .L800325E8:
    /* 22DE8 800325E8 2118C000 */  addu       $v1, $a2, $zero
    /* 22DEC 800325EC 0100C624 */  addiu      $a2, $a2, 0x1
    /* 22DF0 800325F0 002C0700 */  sll        $a1, $a3, 16
    /* 22DF4 800325F4 001C0300 */  sll        $v1, $v1, 16
    /* 22DF8 800325F8 031C0300 */  sra        $v1, $v1, 16
    /* 22DFC 800325FC 80100300 */  sll        $v0, $v1, 2
    /* 22E00 80032600 21104300 */  addu       $v0, $v0, $v1
    /* 22E04 80032604 C0100200 */  sll        $v0, $v0, 3
    /* 22E08 80032608 0100E424 */  addiu      $a0, $a3, 0x1
    /* 22E0C 8003260C 21388000 */  addu       $a3, $a0, $zero
    /* 22E10 80032610 C32B0500 */  sra        $a1, $a1, 15
    /* 22E14 80032614 21280501 */  addu       $a1, $t0, $a1
    /* 22E18 80032618 00240400 */  sll        $a0, $a0, 16
    /* 22E1C 8003261C 1800038D */  lw         $v1, 0x18($t0)
    /* 22E20 80032620 03240400 */  sra        $a0, $a0, 16
    /* 22E24 80032624 21186200 */  addu       $v1, $v1, $v0
    /* 22E28 80032628 24156290 */  lbu        $v0, 0x1524($v1)
    /* 22E2C 8003262C 2A208900 */  slt        $a0, $a0, $t1
    /* 22E30 80032630 00160200 */  sll        $v0, $v0, 24
    /* 22E34 80032634 03160200 */  sra        $v0, $v0, 24
    /* 22E38 80032638 D5004224 */  addiu      $v0, $v0, 0xD5
    /* 22E3C 8003263C EAFF8014 */  bnez       $a0, .L800325E8
    /* 22E40 80032640 B600A2A4 */   sh        $v0, 0xB6($a1)
  .L80032644:
    /* 22E44 80032644 40100A00 */  sll        $v0, $t2, 1
    /* 22E48 80032648 21100201 */  addu       $v0, $t0, $v0
    /* 22E4C 8003264C 0800E003 */  jr         $ra
    /* 22E50 80032650 B60040A4 */   sh        $zero, 0xB6($v0)
endlabel UpdateTrackList__18tTournamentManagerss
