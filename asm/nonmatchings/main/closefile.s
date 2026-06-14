.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching closefile, 0x5C

glabel closefile
    /* E4684 800F3E84 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* E4688 800F3E88 1000BFAF */  sw         $ra, 0x10($sp)
    /* E468C 800F3E8C FF00023C */  lui        $v0, (0xFFFFFF >> 16)
    /* E4690 800F3E90 FFFF4234 */  ori        $v0, $v0, (0xFFFFFF & 0xFFFF)
    /* E4694 800F3E94 032E0400 */  sra        $a1, $a0, 24
    /* E4698 800F3E98 24208200 */  and        $a0, $a0, $v0
    /* E469C 800F3E9C 01000224 */  addiu      $v0, $zero, 0x1
    /* E46A0 800F3EA0 0500A214 */  bne        $a1, $v0, .L800F3EB8
    /* E46A4 800F3EA4 21180000 */   addu      $v1, $zero, $zero
    /* E46A8 800F3EA8 97E9030C */  jal        CD_Close
    /* E46AC 800F3EAC 00000000 */   nop
    /* E46B0 800F3EB0 B4CF0308 */  j          .L800F3ED0
    /* E46B4 800F3EB4 21184000 */   addu      $v1, $v0, $zero
  .L800F3EB8:
    /* E46B8 800F3EB8 02000224 */  addiu      $v0, $zero, 0x2
    /* E46BC 800F3EBC 0400A214 */  bne        $a1, $v0, .L800F3ED0
    /* E46C0 800F3EC0 00000000 */   nop
    /* E46C4 800F3EC4 501B040C */  jal        PCclose
    /* E46C8 800F3EC8 00000000 */   nop
    /* E46CC 800F3ECC 21184000 */  addu       $v1, $v0, $zero
  .L800F3ED0:
    /* E46D0 800F3ED0 1000BF8F */  lw         $ra, 0x10($sp)
    /* E46D4 800F3ED4 21106000 */  addu       $v0, $v1, $zero
    /* E46D8 800F3ED8 0800E003 */  jr         $ra
    /* E46DC 800F3EDC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel closefile
