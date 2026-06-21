.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching finishrequest, 0x3C

glabel finishrequest
    /* E14E8 800F0CE8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* E14EC 800F0CEC 21288000 */  addu       $a1, $a0, $zero
    /* E14F0 800F0CF0 1000BFAF */  sw         $ra, 0x10($sp)
    /* E14F4 800F0CF4 1400A28C */  lw         $v0, 0x14($a1)
    /* E14F8 800F0CF8 00000000 */  nop
    /* E14FC 800F0CFC 05004010 */  beqz       $v0, .L800F0D14
    /* E1500 800F0D00 1800A0AC */   sw        $zero, 0x18($a1)
    /* E1504 800F0D04 1480043C */  lui        $a0, %hi(D_8013DEA8)
    /* E1508 800F0D08 A8DE8424 */  addiu      $a0, $a0, %lo(D_8013DEA8)
    /* E150C 800F0D0C C7C2030C */  jal        queueadd
    /* E1510 800F0D10 00000000 */   nop
  .L800F0D14:
    /* E1514 800F0D14 1000BF8F */  lw         $ra, 0x10($sp)
    /* E1518 800F0D18 00000000 */  nop
    /* E151C 800F0D1C 0800E003 */  jr         $ra
    /* E1520 800F0D20 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel finishrequest
