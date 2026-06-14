.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching waitdraw, 0x2C

glabel waitdraw
    /* E0EE0 800F06E0 C417828F */  lw         $v0, %gp_rel(drawpending)($gp)
    /* E0EE4 800F06E4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* E0EE8 800F06E8 04004010 */  beqz       $v0, .L800F06FC
    /* E0EEC 800F06EC 1000BFAF */   sw        $ra, 0x10($sp)
    /* E0EF0 800F06F0 1FB6030C */  jal        DrawSync
    /* E0EF4 800F06F4 21200000 */   addu      $a0, $zero, $zero
    /* E0EF8 800F06F8 C41780AF */  sw         $zero, %gp_rel(drawpending)($gp)
  .L800F06FC:
    /* E0EFC 800F06FC 1000BF8F */  lw         $ra, 0x10($sp)
    /* E0F00 800F0700 00000000 */  nop
    /* E0F04 800F0704 0800E003 */  jr         $ra
    /* E0F08 800F0708 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel waitdraw
