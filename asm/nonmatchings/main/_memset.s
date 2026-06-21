.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _memset, 0x24

glabel _memset
    /* E0634 800EFE34 0600C010 */  beqz       $a2, .L800EFE50
    /* E0638 800EFE38 FFFFC224 */   addiu     $v0, $a2, -0x1
    /* E063C 800EFE3C FFFF0324 */  addiu      $v1, $zero, -0x1
  .L800EFE40:
    /* E0640 800EFE40 000085A0 */  sb         $a1, 0x0($a0)
    /* E0644 800EFE44 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* E0648 800EFE48 FDFF4314 */  bne        $v0, $v1, .L800EFE40
    /* E064C 800EFE4C 01008424 */   addiu     $a0, $a0, 0x1
  .L800EFE50:
    /* E0650 800EFE50 0800E003 */  jr         $ra
    /* E0654 800EFE54 00000000 */   nop
endlabel _memset
    /* E0658 800EFE58 00000000 */  nop
    /* E065C 800EFE5C 00000000 */  nop
