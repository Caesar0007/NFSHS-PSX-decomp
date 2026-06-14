.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FILE_delbigsync, 0x54

glabel FILE_delbigsync
    /* DB270 800EAA70 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* DB274 800EAA74 1400B1AF */  sw         $s1, 0x14($sp)
    /* DB278 800EAA78 21880000 */  addu       $s1, $zero, $zero
    /* DB27C 800EAA7C 21302002 */  addu       $a2, $s1, $zero
    /* DB280 800EAA80 1800BFAF */  sw         $ra, 0x18($sp)
    /* DB284 800EAA84 6BB2030C */  jal        FILE_delbig
    /* DB288 800EAA88 1000B0AF */   sw        $s0, 0x10($sp)
    /* DB28C 800EAA8C 21804000 */  addu       $s0, $v0, $zero
    /* DB290 800EAA90 07000012 */  beqz       $s0, .L800EAAB0
    /* DB294 800EAA94 21102002 */   addu      $v0, $s1, $zero
    /* DB298 800EAA98 6FB0030C */  jal        FILE_waitop
    /* DB29C 800EAA9C 21200002 */   addu      $a0, $s0, $zero
    /* DB2A0 800EAAA0 ACB0030C */  jal        FILE_completeop
    /* DB2A4 800EAAA4 21200002 */   addu      $a0, $s0, $zero
    /* DB2A8 800EAAA8 21884000 */  addu       $s1, $v0, $zero
    /* DB2AC 800EAAAC 21102002 */  addu       $v0, $s1, $zero
  .L800EAAB0:
    /* DB2B0 800EAAB0 1800BF8F */  lw         $ra, 0x18($sp)
    /* DB2B4 800EAAB4 1400B18F */  lw         $s1, 0x14($sp)
    /* DB2B8 800EAAB8 1000B08F */  lw         $s0, 0x10($sp)
    /* DB2BC 800EAABC 0800E003 */  jr         $ra
    /* DB2C0 800EAAC0 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel FILE_delbigsync
