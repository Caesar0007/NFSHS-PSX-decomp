.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SPCHNFS_C_D_REQUEST_BKUP, 0x74

glabel SPCHNFS_C_D_REQUEST_BKUP
    /* 83E38 80093638 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* 83E3C 8009363C 4000BFAF */  sw         $ra, 0x40($sp)
    /* 83E40 80093640 0B000824 */  addiu      $t0, $zero, 0xB
    /* 83E44 80093644 3C00A227 */  addiu      $v0, $sp, 0x3C
  .L80093648:
    /* 83E48 80093648 000040AC */  sw         $zero, 0x0($v0)
    /* 83E4C 8009364C FFFF0825 */  addiu      $t0, $t0, -0x1
    /* 83E50 80093650 FDFF0105 */  bgez       $t0, .L80093648
    /* 83E54 80093654 FCFF4224 */   addiu     $v0, $v0, -0x4
    /* 83E58 80093658 6F010224 */  addiu      $v0, $zero, 0x16F
    /* 83E5C 8009365C 1000A2AF */  sw         $v0, 0x10($sp)
    /* 83E60 80093660 0000828C */  lw         $v0, 0x0($a0)
    /* 83E64 80093664 00000000 */  nop
    /* 83E68 80093668 1400A2AF */  sw         $v0, 0x14($sp)
    /* 83E6C 8009366C 0000A28C */  lw         $v0, 0x0($a1)
    /* 83E70 80093670 1C00A6AF */  sw         $a2, 0x1C($sp)
    /* 83E74 80093674 1800A2AF */  sw         $v0, 0x18($sp)
    /* 83E78 80093678 5800A28F */  lw         $v0, 0x58($sp)
    /* 83E7C 8009367C 0000E38C */  lw         $v1, 0x0($a3)
    /* 83E80 80093680 2400A2AF */  sw         $v0, 0x24($sp)
    /* 83E84 80093684 5C00A28F */  lw         $v0, 0x5C($sp)
    /* 83E88 80093688 2000A3AF */  sw         $v1, 0x20($sp)
    /* 83E8C 8009368C 0000428C */  lw         $v0, 0x0($v0)
    /* 83E90 80093690 1000A427 */  addiu      $a0, $sp, 0x10
    /* 83E94 80093694 6E9C030C */  jal        SPCH_AddEvent
    /* 83E98 80093698 2800A2AF */   sw        $v0, 0x28($sp)
    /* 83E9C 8009369C 4000BF8F */  lw         $ra, 0x40($sp)
    /* 83EA0 800936A0 00000000 */  nop
    /* 83EA4 800936A4 0800E003 */  jr         $ra
    /* 83EA8 800936A8 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel SPCHNFS_C_D_REQUEST_BKUP
