.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching initjoy, 0x3C

glabel initjoy
    /* E41F8 800F39F8 DC17828F */  lw         $v0, %gp_rel(joy_inited)($gp)
    /* E41FC 800F39FC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* E4200 800F3A00 1000BFAF */  sw         $ra, 0x10($sp)
    /* E4204 800F3A04 1480013C */  lui        $at, %hi(numjoy)
    /* E4208 800F3A08 84DC24AC */  sw         $a0, %lo(numjoy)($at)
    /* E420C 800F3A0C 05004014 */  bnez       $v0, .L800F3A24
    /* E4210 800F3A10 00000000 */   nop
    /* E4214 800F3A14 3A90030C */  jal        padinit
    /* E4218 800F3A18 00000000 */   nop
    /* E421C 800F3A1C 01000224 */  addiu      $v0, $zero, 0x1
    /* E4220 800F3A20 DC1782AF */  sw         $v0, %gp_rel(joy_inited)($gp)
  .L800F3A24:
    /* E4224 800F3A24 1000BF8F */  lw         $ra, 0x10($sp)
    /* E4228 800F3A28 00000000 */  nop
    /* E422C 800F3A2C 0800E003 */  jr         $ra
    /* E4230 800F3A30 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel initjoy
