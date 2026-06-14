.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_800FDFF4, 0xBC

glabel func_800FDFF4
    /* EE7F4 800FDFF4 45008290 */  lbu        $v0, 0x45($a0)
    /* EE7F8 800FDFF8 36008590 */  lbu        $a1, 0x36($a0)
    /* EE7FC 800FDFFC 00000000 */  nop
    /* EE800 800FE000 0600A010 */  beqz       $a1, .L800FE01C
    /* EE804 800FE004 FDFF4324 */   addiu     $v1, $v0, -0x3
    /* EE808 800FE008 4D000224 */  addiu      $v0, $zero, 0x4D
    /* EE80C 800FE00C 1500A210 */  beq        $a1, $v0, .L800FE064
    /* EE810 800FE010 00000000 */   nop
    /* EE814 800FE014 21F80308 */  j          .L800FE084
    /* EE818 800FE018 00000000 */   nop
  .L800FE01C:
    /* EE81C 800FE01C 06006228 */  slti       $v0, $v1, 0x6
    /* EE820 800FE020 05004010 */  beqz       $v0, .L800FE038
    /* EE824 800FE024 21108300 */   addu      $v0, $a0, $v1
    /* EE828 800FE028 57004290 */  lbu        $v0, 0x57($v0)
    /* EE82C 800FE02C 00000000 */  nop
    /* EE830 800FE030 1D004010 */  beqz       $v0, .L800FE0A8
    /* EE834 800FE034 21100000 */   addu      $v0, $zero, $zero
  .L800FE038:
    /* EE838 800FE038 34008290 */  lbu        $v0, 0x34($a0)
    /* EE83C 800FE03C 00000000 */  nop
    /* EE840 800FE040 2A106200 */  slt        $v0, $v1, $v0
    /* EE844 800FE044 18004010 */  beqz       $v0, .L800FE0A8
    /* EE848 800FE048 21100000 */   addu      $v0, $zero, $zero
    /* EE84C 800FE04C 2800828C */  lw         $v0, 0x28($a0)
    /* EE850 800FE050 00000000 */  nop
    /* EE854 800FE054 21104300 */  addu       $v0, $v0, $v1
  .L800FE058:
    /* EE858 800FE058 00004290 */  lbu        $v0, 0x0($v0)
    /* EE85C 800FE05C 2AF80308 */  j          .L800FE0A8
    /* EE860 800FE060 00000000 */   nop
  .L800FE064:
    /* EE864 800FE064 35008290 */  lbu        $v0, 0x35($a0)
    /* EE868 800FE068 00000000 */  nop
    /* EE86C 800FE06C 2A106200 */  slt        $v0, $v1, $v0
    /* EE870 800FE070 0D004010 */  beqz       $v0, .L800FE0A8
    /* EE874 800FE074 FF000224 */   addiu     $v0, $zero, 0xFF
    /* EE878 800FE078 2C00828C */  lw         $v0, 0x2C($a0)
    /* EE87C 800FE07C 16F80308 */  j          .L800FE058
    /* EE880 800FE080 21104300 */   addu      $v0, $v0, $v1
  .L800FE084:
    /* EE884 800FE084 35008290 */  lbu        $v0, 0x35($a0)
    /* EE888 800FE088 00000000 */  nop
    /* EE88C 800FE08C 2A106200 */  slt        $v0, $v1, $v0
    /* EE890 800FE090 05004010 */  beqz       $v0, .L800FE0A8
    /* EE894 800FE094 21100000 */   addu      $v0, $zero, $zero
    /* EE898 800FE098 2C00828C */  lw         $v0, 0x2C($a0)
    /* EE89C 800FE09C 00000000 */  nop
    /* EE8A0 800FE0A0 21104300 */  addu       $v0, $v0, $v1
    /* EE8A4 800FE0A4 00004290 */  lbu        $v0, 0x0($v0)
  .L800FE0A8:
    /* EE8A8 800FE0A8 0800E003 */  jr         $ra
    /* EE8AC 800FE0AC 00000000 */   nop
endlabel func_800FDFF4
