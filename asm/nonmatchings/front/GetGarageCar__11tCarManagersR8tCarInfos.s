.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetGarageCar__11tCarManagersR8tCarInfos, 0x10C

glabel GetGarageCar__11tCarManagersR8tCarInfos
    /* 774C 80016F4C D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 7750 80016F50 1800B2AF */  sw         $s2, 0x18($sp)
    /* 7754 80016F54 21908000 */  addu       $s2, $a0, $zero
    /* 7758 80016F58 1400B1AF */  sw         $s1, 0x14($sp)
    /* 775C 80016F5C 2188E000 */  addu       $s1, $a3, $zero
    /* 7760 80016F60 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 7764 80016F64 2198C000 */  addu       $s3, $a2, $zero
    /* 7768 80016F68 2000B4AF */  sw         $s4, 0x20($sp)
    /* 776C 80016F6C 21A0A000 */  addu       $s4, $a1, $zero
    /* 7770 80016F70 003C0700 */  sll        $a3, $a3, 16
    /* 7774 80016F74 033C0700 */  sra        $a3, $a3, 16
    /* 7778 80016F78 01000224 */  addiu      $v0, $zero, 0x1
    /* 777C 80016F7C 2400BFAF */  sw         $ra, 0x24($sp)
    /* 7780 80016F80 0700E214 */  bne        $a3, $v0, .L80016FA0
    /* 7784 80016F84 1000B0AF */   sw        $s0, 0x10($sp)
    /* 7788 80016F88 CD5C000C */  jal        GetNumOwnedCars__11tCarManagers
    /* 778C 80016F8C 21284000 */   addu      $a1, $v0, $zero
    /* 7790 80016F90 00140200 */  sll        $v0, $v0, 16
    /* 7794 80016F94 0300401C */  bgtz       $v0, .L80016FA4
    /* 7798 80016F98 00841400 */   sll       $s0, $s4, 16
    /* 779C 80016F9C 21880000 */  addu       $s1, $zero, $zero
  .L80016FA0:
    /* 77A0 80016FA0 00841400 */  sll        $s0, $s4, 16
  .L80016FA4:
    /* 77A4 80016FA4 03841000 */  sra        $s0, $s0, 16
    /* 77A8 80016FA8 008C1100 */  sll        $s1, $s1, 16
    /* 77AC 80016FAC 0000428E */  lw         $v0, 0x0($s2)
    /* 77B0 80016FB0 438A1100 */  sra        $s1, $s1, 9
    /* 77B4 80016FB4 23100202 */  subu       $v0, $s0, $v0
    /* 77B8 80016FB8 80100200 */  sll        $v0, $v0, 2
    /* 77BC 80016FBC 21105100 */  addu       $v0, $v0, $s1
    /* 77C0 80016FC0 21104202 */  addu       $v0, $s2, $v0
    /* 77C4 80016FC4 08004580 */  lb         $a1, 0x8($v0)
    /* 77C8 80016FC8 9358000C */  jal        GetCarFromID__11tCarManagers
    /* 77CC 80016FCC 21204002 */   addu      $a0, $s2, $zero
    /* 77D0 80016FD0 21204000 */  addu       $a0, $v0, $zero
    /* 77D4 80016FD4 21286002 */  addu       $a1, $s3, $zero
    /* 77D8 80016FD8 B798030C */  jal        blockmove
    /* 77DC 80016FDC CC000624 */   addiu     $a2, $zero, 0xCC
    /* 77E0 80016FE0 01000224 */  addiu      $v0, $zero, 0x1
    /* 77E4 80016FE4 070062A2 */  sb         $v0, 0x7($s3)
    /* 77E8 80016FE8 C60062A2 */  sb         $v0, 0xC6($s3)
    /* 77EC 80016FEC 0000428E */  lw         $v0, 0x0($s2)
    /* 77F0 80016FF0 00000000 */  nop
    /* 77F4 80016FF4 23100202 */  subu       $v0, $s0, $v0
    /* 77F8 80016FF8 80100200 */  sll        $v0, $v0, 2
    /* 77FC 80016FFC 21105100 */  addu       $v0, $v0, $s1
    /* 7800 80017000 21104202 */  addu       $v0, $s2, $v0
    /* 7804 80017004 09004290 */  lbu        $v0, 0x9($v0)
    /* 7808 80017008 00000000 */  nop
    /* 780C 8001700C C40062A2 */  sb         $v0, 0xC4($s3)
    /* 7810 80017010 0000428E */  lw         $v0, 0x0($s2)
    /* 7814 80017014 00000000 */  nop
    /* 7818 80017018 23800202 */  subu       $s0, $s0, $v0
    /* 781C 8001701C 80801000 */  sll        $s0, $s0, 2
    /* 7820 80017020 21801102 */  addu       $s0, $s0, $s1
    /* 7824 80017024 21805002 */  addu       $s0, $s2, $s0
    /* 7828 80017028 0A000292 */  lbu        $v0, 0xA($s0)
    /* 782C 8001702C C70060A2 */  sb         $zero, 0xC7($s3)
    /* 7830 80017030 C80074A2 */  sb         $s4, 0xC8($s3)
    /* 7834 80017034 C50062A2 */  sb         $v0, 0xC5($s3)
    /* 7838 80017038 2400BF8F */  lw         $ra, 0x24($sp)
    /* 783C 8001703C 2000B48F */  lw         $s4, 0x20($sp)
    /* 7840 80017040 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 7844 80017044 1800B28F */  lw         $s2, 0x18($sp)
    /* 7848 80017048 1400B18F */  lw         $s1, 0x14($sp)
    /* 784C 8001704C 1000B08F */  lw         $s0, 0x10($sp)
    /* 7850 80017050 0800E003 */  jr         $ra
    /* 7854 80017054 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel GetGarageCar__11tCarManagersR8tCarInfos
