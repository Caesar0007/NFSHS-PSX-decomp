.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDvalidbank, 0x68

glabel iSNDvalidbank
    /* EEEBC 800FE6BC 07008004 */  bltz       $a0, .L800FE6DC
    /* EEEC0 800FE6C0 1480023C */   lui       $v0, %hi(sndgs)
    /* EEEC4 800FE6C4 60784324 */  addiu      $v1, $v0, %lo(sndgs)
    /* EEEC8 800FE6C8 0C006294 */  lhu        $v0, 0xC($v1)
    /* EEECC 800FE6CC 00000000 */  nop
    /* EEED0 800FE6D0 2A108200 */  slt        $v0, $a0, $v0
    /* EEED4 800FE6D4 03004014 */  bnez       $v0, .L800FE6E4
    /* EEED8 800FE6D8 40100400 */   sll       $v0, $a0, 1
  .L800FE6DC:
    /* EEEDC 800FE6DC 0800E003 */  jr         $ra
    /* EEEE0 800FE6E0 F8FF0224 */   addiu     $v0, $zero, -0x8
  .L800FE6E4:
    /* EEEE4 800FE6E4 21104400 */  addu       $v0, $v0, $a0
    /* EEEE8 800FE6E8 9800638C */  lw         $v1, 0x98($v1)
    /* EEEEC 800FE6EC 80100200 */  sll        $v0, $v0, 2
    /* EEEF0 800FE6F0 21184300 */  addu       $v1, $v0, $v1
    /* EEEF4 800FE6F4 0000628C */  lw         $v0, 0x0($v1)
    /* EEEF8 800FE6F8 00000000 */  nop
    /* EEEFC 800FE6FC 07004010 */  beqz       $v0, .L800FE71C
    /* EEF00 800FE700 F8FF0224 */   addiu     $v0, $zero, -0x8
    /* EEF04 800FE704 08006380 */  lb         $v1, 0x8($v1)
    /* EEF08 800FE708 00000000 */  nop
    /* EEF0C 800FE70C 03006014 */  bnez       $v1, .L800FE71C
    /* EEF10 800FE710 EEFF0224 */   addiu     $v0, $zero, -0x12
    /* EEF14 800FE714 0800E003 */  jr         $ra
    /* EEF18 800FE718 21100000 */   addu      $v0, $zero, $zero
  .L800FE71C:
    /* EEF1C 800FE71C 0800E003 */  jr         $ra
    /* EEF20 800FE720 00000000 */   nop
endlabel iSNDvalidbank
