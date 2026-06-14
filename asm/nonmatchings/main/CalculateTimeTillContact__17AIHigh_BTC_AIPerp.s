.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CalculateTimeTillContact__17AIHigh_BTC_AIPerp, 0xA4

glabel CalculateTimeTillContact__17AIHigh_BTC_AIPerp
    /* 50F10 80060710 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 50F14 80060714 1000B0AF */  sw         $s0, 0x10($sp)
    /* 50F18 80060718 21808000 */  addu       $s0, $a0, $zero
    /* 50F1C 8006071C 1400BFAF */  sw         $ra, 0x14($sp)
    /* 50F20 80060720 A400048E */  lw         $a0, 0xA4($s0)
    /* 50F24 80060724 00000000 */  nop
    /* 50F28 80060728 1D008010 */  beqz       $a0, .L800607A0
    /* 50F2C 8006072C 00FA0234 */   ori       $v0, $zero, 0xFA00
    /* 50F30 80060730 8800028E */  lw         $v0, 0x88($s0)
    /* 50F34 80060734 00000000 */  nop
    /* 50F38 80060738 0200422C */  sltiu      $v0, $v0, 0x2
    /* 50F3C 8006073C 18004010 */  beqz       $v0, .L800607A0
    /* 50F40 80060740 00FA0234 */   ori       $v0, $zero, 0xFA00
    /* 50F44 80060744 0000028E */  lw         $v0, 0x0($s0)
    /* 50F48 80060748 00000000 */  nop
    /* 50F4C 8006074C 6405438C */  lw         $v1, 0x564($v0)
    /* 50F50 80060750 6405828C */  lw         $v0, 0x564($a0)
    /* 50F54 80060754 A800048E */  lw         $a0, 0xA8($s0)
    /* 50F58 80060758 23286200 */  subu       $a1, $v1, $v0
    /* 50F5C 8006075C FF7FA324 */  addiu      $v1, $a1, 0x7FFF
    /* 50F60 80060760 FEFF0234 */  ori        $v0, $zero, 0xFFFE
    /* 50F64 80060764 2B104300 */  sltu       $v0, $v0, $v1
    /* 50F68 80060768 08004010 */  beqz       $v0, .L8006078C
    /* 50F6C 8006076C E803023C */   lui       $v0, (0x3E80000 >> 16)
    /* 50F70 80060770 0191030C */  jal        rdiv
    /* 50F74 80060774 00000000 */   nop
    /* 50F78 80060778 02004104 */  bgez       $v0, .L80060784
    /* 50F7C 8006077C 00000000 */   nop
    /* 50F80 80060780 FF034224 */  addiu      $v0, $v0, 0x3FF
  .L80060784:
    /* 50F84 80060784 83120200 */  sra        $v0, $v0, 10
    /* 50F88 80060788 23100200 */  negu       $v0, $v0
  .L8006078C:
    /* 50F8C 8006078C 940002AE */  sw         $v0, 0x94($s0)
    /* 50F90 80060790 9400028E */  lw         $v0, 0x94($s0)
    /* 50F94 80060794 00000000 */  nop
    /* 50F98 80060798 02004104 */  bgez       $v0, .L800607A4
    /* 50F9C 8006079C 00FA0234 */   ori       $v0, $zero, 0xFA00
  .L800607A0:
    /* 50FA0 800607A0 940002AE */  sw         $v0, 0x94($s0)
  .L800607A4:
    /* 50FA4 800607A4 1400BF8F */  lw         $ra, 0x14($sp)
    /* 50FA8 800607A8 1000B08F */  lw         $s0, 0x10($sp)
    /* 50FAC 800607AC 0800E003 */  jr         $ra
    /* 50FB0 800607B0 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel CalculateTimeTillContact__17AIHigh_BTC_AIPerp
