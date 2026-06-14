.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Udff_Close__FP10Udff_tInfo, 0x54

glabel Udff_Close__FP10Udff_tInfo
    /* AC2D0 800BBAD0 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* AC2D4 800BBAD4 1000B0AF */  sw         $s0, 0x10($sp)
    /* AC2D8 800BBAD8 21808000 */  addu       $s0, $a0, $zero
    /* AC2DC 800BBADC 0D000012 */  beqz       $s0, .L800BBB14
    /* AC2E0 800BBAE0 1400BFAF */   sw        $ra, 0x14($sp)
    /* AC2E4 800BBAE4 0000028E */  lw         $v0, 0x0($s0)
    /* AC2E8 800BBAE8 00000000 */  nop
    /* AC2EC 800BBAEC 07004014 */  bnez       $v0, .L800BBB0C
    /* AC2F0 800BBAF0 00000000 */   nop
    /* AC2F4 800BBAF4 0400048E */  lw         $a0, 0x4($s0)
    /* AC2F8 800BBAF8 00000000 */  nop
    /* AC2FC 800BBAFC 03008010 */  beqz       $a0, .L800BBB0C
    /* AC300 800BBB00 00000000 */   nop
    /* AC304 800BBB04 5095030C */  jal        purgememadr
    /* AC308 800BBB08 00000000 */   nop
  .L800BBB0C:
    /* AC30C 800BBB0C 5095030C */  jal        purgememadr
    /* AC310 800BBB10 21200002 */   addu      $a0, $s0, $zero
  .L800BBB14:
    /* AC314 800BBB14 1400BF8F */  lw         $ra, 0x14($sp)
    /* AC318 800BBB18 1000B08F */  lw         $s0, 0x10($sp)
    /* AC31C 800BBB1C 0800E003 */  jr         $ra
    /* AC320 800BBB20 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Udff_Close__FP10Udff_tInfo
