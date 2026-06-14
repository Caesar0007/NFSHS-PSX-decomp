.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FREE_findlargest, 0xC0

glabel FREE_findlargest
    /* D55B0 800E4DB0 21380000 */  addu       $a3, $zero, $zero
    /* D55B4 800E4DB4 FFFFA524 */  addiu      $a1, $a1, -0x1
    /* D55B8 800E4DB8 0200A104 */  bgez       $a1, .L800E4DC4
    /* D55BC 800E4DBC 10008424 */   addiu     $a0, $a0, 0x10
    /* D55C0 800E4DC0 2128E000 */  addu       $a1, $a3, $zero
  .L800E4DC4:
    /* D55C4 800E4DC4 1D00C014 */  bnez       $a2, .L800E4E3C
    /* D55C8 800E4DC8 00000000 */   nop
    /* D55CC 800E4DCC 1000848C */  lw         $a0, 0x10($a0)
    /* D55D0 800E4DD0 00000000 */  nop
    /* D55D4 800E4DD4 0400828C */  lw         $v0, 0x4($a0)
    /* D55D8 800E4DD8 00000000 */  nop
    /* D55DC 800E4DDC 2A10A200 */  slt        $v0, $a1, $v0
    /* D55E0 800E4DE0 07004010 */  beqz       $v0, .L800E4E00
    /* D55E4 800E4DE4 53420224 */   addiu     $v0, $zero, 0x4253
    /* D55E8 800E4DE8 00008394 */  lhu        $v1, 0x0($a0)
    /* D55EC 800E4DEC 00000000 */  nop
    /* D55F0 800E4DF0 1D006210 */  beq        $v1, $v0, .L800E4E68
    /* D55F4 800E4DF4 2110E000 */   addu      $v0, $a3, $zero
  .L800E4DF8:
    /* D55F8 800E4DF8 21388000 */  addu       $a3, $a0, $zero
    /* D55FC 800E4DFC 0400858C */  lw         $a1, 0x4($a0)
  .L800E4E00:
    /* D5600 800E4E00 1000848C */  lw         $a0, 0x10($a0)
    /* D5604 800E4E04 00000000 */  nop
    /* D5608 800E4E08 0400828C */  lw         $v0, 0x4($a0)
    /* D560C 800E4E0C 00000000 */  nop
    /* D5610 800E4E10 2A10A200 */  slt        $v0, $a1, $v0
    /* D5614 800E4E14 FAFF4010 */  beqz       $v0, .L800E4E00
    /* D5618 800E4E18 53420224 */   addiu     $v0, $zero, 0x4253
    /* D561C 800E4E1C 00008394 */  lhu        $v1, 0x0($a0)
    /* D5620 800E4E20 00000000 */  nop
    /* D5624 800E4E24 F4FF6214 */  bne        $v1, $v0, .L800E4DF8
    /* D5628 800E4E28 2110E000 */   addu      $v0, $a3, $zero
    /* D562C 800E4E2C 9A930308 */  j          .L800E4E68
    /* D5630 800E4E30 00000000 */   nop
  .L800E4E34:
    /* D5634 800E4E34 21388000 */  addu       $a3, $a0, $zero
    /* D5638 800E4E38 0400858C */  lw         $a1, 0x4($a0)
  .L800E4E3C:
    /* D563C 800E4E3C 1400848C */  lw         $a0, 0x14($a0)
    /* D5640 800E4E40 00000000 */  nop
    /* D5644 800E4E44 0400828C */  lw         $v0, 0x4($a0)
    /* D5648 800E4E48 00000000 */  nop
    /* D564C 800E4E4C 2A10A200 */  slt        $v0, $a1, $v0
    /* D5650 800E4E50 FAFF4010 */  beqz       $v0, .L800E4E3C
    /* D5654 800E4E54 53420224 */   addiu     $v0, $zero, 0x4253
    /* D5658 800E4E58 00008394 */  lhu        $v1, 0x0($a0)
    /* D565C 800E4E5C 00000000 */  nop
    /* D5660 800E4E60 F4FF6214 */  bne        $v1, $v0, .L800E4E34
    /* D5664 800E4E64 2110E000 */   addu      $v0, $a3, $zero
  .L800E4E68:
    /* D5668 800E4E68 0800E003 */  jr         $ra
    /* D566C 800E4E6C 00000000 */   nop
endlabel FREE_findlargest
