.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSPCH_FindEvent, 0x70

glabel iSPCH_FindEvent
    /* D774C 800E6F4C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* D7750 800E6F50 1800B2AF */  sw         $s2, 0x18($sp)
    /* D7754 800E6F54 21908000 */  addu       $s2, $a0, $zero
    /* D7758 800E6F58 1400B1AF */  sw         $s1, 0x14($sp)
    /* D775C 800E6F5C 21880000 */  addu       $s1, $zero, $zero
    /* D7760 800E6F60 1580023C */  lui        $v0, %hi(gEventDats)
    /* D7764 800E6F64 1000B0AF */  sw         $s0, 0x10($sp)
    /* D7768 800E6F68 48805024 */  addiu      $s0, $v0, %lo(gEventDats)
    /* D776C 800E6F6C 1C00BFAF */  sw         $ra, 0x1C($sp)
  .L800E6F70:
    /* D7770 800E6F70 0000048E */  lw         $a0, 0x0($s0)
    /* D7774 800E6F74 00000000 */  nop
    /* D7778 800E6F78 05008010 */  beqz       $a0, .L800E6F90
    /* D777C 800E6F7C 00000000 */   nop
    /* D7780 800E6F80 B19B030C */  jal        iSPCH_SearchEventDat
    /* D7784 800E6F84 21284002 */   addu      $a1, $s2, $zero
    /* D7788 800E6F88 06004014 */  bnez       $v0, .L800E6FA4
    /* D778C 800E6F8C 00000000 */   nop
  .L800E6F90:
    /* D7790 800E6F90 01003126 */  addiu      $s1, $s1, 0x1
    /* D7794 800E6F94 0400222A */  slti       $v0, $s1, 0x4
    /* D7798 800E6F98 F5FF4014 */  bnez       $v0, .L800E6F70
    /* D779C 800E6F9C 04001026 */   addiu     $s0, $s0, 0x4
    /* D77A0 800E6FA0 21100000 */  addu       $v0, $zero, $zero
  .L800E6FA4:
    /* D77A4 800E6FA4 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* D77A8 800E6FA8 1800B28F */  lw         $s2, 0x18($sp)
    /* D77AC 800E6FAC 1400B18F */  lw         $s1, 0x14($sp)
    /* D77B0 800E6FB0 1000B08F */  lw         $s0, 0x10($sp)
    /* D77B4 800E6FB4 0800E003 */  jr         $ra
    /* D77B8 800E6FB8 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel iSPCH_FindEvent
