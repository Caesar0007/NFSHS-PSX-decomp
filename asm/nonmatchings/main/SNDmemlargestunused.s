.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SNDmemlargestunused, 0x100

glabel SNDmemlargestunused
    /* D84EC 800E7CEC 21488000 */  addu       $t1, $a0, $zero
    /* D84F0 800E7CF0 41000224 */  addiu      $v0, $zero, 0x41
    /* D84F4 800E7CF4 000022AD */  sw         $v0, 0x0($t1)
    /* D84F8 800E7CF8 1480023C */  lui        $v0, %hi(sndpd)
    /* D84FC 800E7CFC 18794324 */  addiu      $v1, $v0, %lo(sndpd)
    /* D8500 800E7D00 18056294 */  lhu        $v0, 0x518($v1)
    /* D8504 800E7D04 00000000 */  nop
    /* D8508 800E7D08 04004014 */  bnez       $v0, .L800E7D1C
    /* D850C 800E7D0C 21380000 */   addu      $a3, $zero, $zero
    /* D8510 800E7D10 1E056294 */  lhu        $v0, 0x51E($v1)
    /* D8514 800E7D14 759F0308 */  j          .L800E7DD4
    /* D8518 800E7D18 BFFF4724 */   addiu     $a3, $v0, -0x41
  .L800E7D1C:
    /* D851C 800E7D1C 2A10E200 */  slt        $v0, $a3, $v0
    /* D8520 800E7D20 1E004010 */  beqz       $v0, .L800E7D9C
    /* D8524 800E7D24 21280000 */   addu      $a1, $zero, $zero
    /* D8528 800E7D28 1C056A24 */  addiu      $t2, $v1, 0x51C
    /* D852C 800E7D2C 21406000 */  addu       $t0, $v1, $zero
    /* D8530 800E7D30 20050625 */  addiu      $a2, $t0, 0x520
  .L800E7D34:
    /* D8534 800E7D34 0900A014 */  bnez       $a1, .L800E7D5C
    /* D8538 800E7D38 80180500 */   sll       $v1, $a1, 2
    /* D853C 800E7D3C 0000C294 */  lhu        $v0, 0x0($a2)
    /* D8540 800E7D40 00000000 */  nop
    /* D8544 800E7D44 BFFF4324 */  addiu      $v1, $v0, -0x41
    /* D8548 800E7D48 2A10E300 */  slt        $v0, $a3, $v1
    /* D854C 800E7D4C 0E004010 */  beqz       $v0, .L800E7D88
    /* D8550 800E7D50 00000000 */   nop
    /* D8554 800E7D54 629F0308 */  j          .L800E7D88
    /* D8558 800E7D58 21386000 */   addu      $a3, $v1, $zero
  .L800E7D5C:
    /* D855C 800E7D5C 21186A00 */  addu       $v1, $v1, $t2
    /* D8560 800E7D60 00006494 */  lhu        $a0, 0x0($v1)
    /* D8564 800E7D64 02006294 */  lhu        $v0, 0x2($v1)
    /* D8568 800E7D68 0000C394 */  lhu        $v1, 0x0($a2)
    /* D856C 800E7D6C 21208200 */  addu       $a0, $a0, $v0
    /* D8570 800E7D70 23186400 */  subu       $v1, $v1, $a0
    /* D8574 800E7D74 2A10E300 */  slt        $v0, $a3, $v1
    /* D8578 800E7D78 03004010 */  beqz       $v0, .L800E7D88
    /* D857C 800E7D7C 00000000 */   nop
    /* D8580 800E7D80 21386000 */  addu       $a3, $v1, $zero
    /* D8584 800E7D84 000024AD */  sw         $a0, 0x0($t1)
  .L800E7D88:
    /* D8588 800E7D88 18050295 */  lhu        $v0, 0x518($t0)
    /* D858C 800E7D8C 0100A524 */  addiu      $a1, $a1, 0x1
    /* D8590 800E7D90 2A10A200 */  slt        $v0, $a1, $v0
    /* D8594 800E7D94 E7FF4014 */  bnez       $v0, .L800E7D34
    /* D8598 800E7D98 0400C624 */   addiu     $a2, $a2, 0x4
  .L800E7D9C:
    /* D859C 800E7D9C 80180500 */  sll        $v1, $a1, 2
    /* D85A0 800E7DA0 1480023C */  lui        $v0, %hi(D_80147E34)
    /* D85A4 800E7DA4 347E4224 */  addiu      $v0, $v0, %lo(D_80147E34)
    /* D85A8 800E7DA8 21186200 */  addu       $v1, $v1, $v0
    /* D85AC 800E7DAC 00006494 */  lhu        $a0, 0x0($v1)
    /* D85B0 800E7DB0 02006394 */  lhu        $v1, 0x2($v1)
    /* D85B4 800E7DB4 02004294 */  lhu        $v0, 0x2($v0)
    /* D85B8 800E7DB8 21208300 */  addu       $a0, $a0, $v1
    /* D85BC 800E7DBC 23184400 */  subu       $v1, $v0, $a0
    /* D85C0 800E7DC0 2A10E300 */  slt        $v0, $a3, $v1
    /* D85C4 800E7DC4 03004010 */  beqz       $v0, .L800E7DD4
    /* D85C8 800E7DC8 00000000 */   nop
    /* D85CC 800E7DCC 21386000 */  addu       $a3, $v1, $zero
    /* D85D0 800E7DD0 000024AD */  sw         $a0, 0x0($t1)
  .L800E7DD4:
    /* D85D4 800E7DD4 0000228D */  lw         $v0, 0x0($t1)
    /* D85D8 800E7DD8 00000000 */  nop
    /* D85DC 800E7DDC 80110200 */  sll        $v0, $v0, 6
    /* D85E0 800E7DE0 000022AD */  sw         $v0, 0x0($t1)
    /* D85E4 800E7DE4 0800E003 */  jr         $ra
    /* D85E8 800E7DE8 80110700 */   sll       $v0, $a3, 6
endlabel SNDmemlargestunused
