.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching PurchaseUpgrade__11tCarManagersss, 0x10C

glabel PurchaseUpgrade__11tCarManagersss
    /* 6EAC 800166AC D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 6EB0 800166B0 1800B2AF */  sw         $s2, 0x18($sp)
    /* 6EB4 800166B4 21908000 */  addu       $s2, $a0, $zero
    /* 6EB8 800166B8 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 6EBC 800166BC 21980000 */  addu       $s3, $zero, $zero
    /* 6EC0 800166C0 2000B4AF */  sw         $s4, 0x20($sp)
    /* 6EC4 800166C4 1000B0AF */  sw         $s0, 0x10($sp)
    /* 6EC8 800166C8 00840500 */  sll        $s0, $a1, 16
    /* 6ECC 800166CC 03841000 */  sra        $s0, $s0, 16
    /* 6ED0 800166D0 1400B1AF */  sw         $s1, 0x14($sp)
    /* 6ED4 800166D4 008C0700 */  sll        $s1, $a3, 16
    /* 6ED8 800166D8 2400BFAF */  sw         $ra, 0x24($sp)
    /* 6EDC 800166DC 0000428E */  lw         $v0, 0x0($s2)
    /* 6EE0 800166E0 438A1100 */  sra        $s1, $s1, 9
    /* 6EE4 800166E4 23100202 */  subu       $v0, $s0, $v0
    /* 6EE8 800166E8 80100200 */  sll        $v0, $v0, 2
    /* 6EEC 800166EC 21105100 */  addu       $v0, $v0, $s1
    /* 6EF0 800166F0 21104202 */  addu       $v0, $s2, $v0
    /* 6EF4 800166F4 08004580 */  lb         $a1, 0x8($v0)
    /* 6EF8 800166F8 9358000C */  jal        GetCarFromID__11tCarManagers
    /* 6EFC 800166FC 21A0C000 */   addu      $s4, $a2, $zero
    /* 6F00 80016700 21404000 */  addu       $t0, $v0, $zero
    /* 6F04 80016704 21386002 */  addu       $a3, $s3, $zero
    /* 6F08 80016708 01000924 */  addiu      $t1, $zero, 0x1
    /* 6F0C 8001670C 00140700 */  sll        $v0, $a3, 16
  .L80016710:
    /* 6F10 80016710 032C0200 */  sra        $a1, $v0, 16
    /* 6F14 80016714 0418A900 */  sllv       $v1, $t1, $a1
    /* 6F18 80016718 24108302 */  and        $v0, $s4, $v1
    /* 6F1C 8001671C 00140200 */  sll        $v0, $v0, 16
    /* 6F20 80016720 15004010 */  beqz       $v0, .L80016778
    /* 6F24 80016724 21306000 */   addu      $a2, $v1, $zero
    /* 6F28 80016728 0000428E */  lw         $v0, 0x0($s2)
    /* 6F2C 8001672C 00000000 */  nop
    /* 6F30 80016730 23100202 */  subu       $v0, $s0, $v0
    /* 6F34 80016734 80100200 */  sll        $v0, $v0, 2
    /* 6F38 80016738 21105100 */  addu       $v0, $v0, $s1
    /* 6F3C 8001673C 21204202 */  addu       $a0, $s2, $v0
    /* 6F40 80016740 00140300 */  sll        $v0, $v1, 16
    /* 6F44 80016744 09008390 */  lbu        $v1, 0x9($a0)
    /* 6F48 80016748 03140200 */  sra        $v0, $v0, 16
    /* 6F4C 8001674C 24106200 */  and        $v0, $v1, $v0
    /* 6F50 80016750 0A004014 */  bnez       $v0, .L8001677C
    /* 6F54 80016754 0100E224 */   addiu     $v0, $a3, 0x1
    /* 6F58 80016758 2510C300 */  or         $v0, $a2, $v1
    /* 6F5C 8001675C 090082A0 */  sb         $v0, 0x9($a0)
    /* 6F60 80016760 0100A224 */  addiu      $v0, $a1, 0x1
    /* 6F64 80016764 80100200 */  sll        $v0, $v0, 2
    /* 6F68 80016768 21100201 */  addu       $v0, $t0, $v0
    /* 6F6C 8001676C 2000428C */  lw         $v0, 0x20($v0)
    /* 6F70 80016770 00000000 */  nop
    /* 6F74 80016774 21986202 */  addu       $s3, $s3, $v0
  .L80016778:
    /* 6F78 80016778 0100E224 */  addiu      $v0, $a3, 0x1
  .L8001677C:
    /* 6F7C 8001677C 21384000 */  addu       $a3, $v0, $zero
    /* 6F80 80016780 00140200 */  sll        $v0, $v0, 16
    /* 6F84 80016784 03140200 */  sra        $v0, $v0, 16
    /* 6F88 80016788 03004228 */  slti       $v0, $v0, 0x3
    /* 6F8C 8001678C E0FF4014 */  bnez       $v0, .L80016710
    /* 6F90 80016790 00140700 */   sll       $v0, $a3, 16
    /* 6F94 80016794 21106002 */  addu       $v0, $s3, $zero
    /* 6F98 80016798 2400BF8F */  lw         $ra, 0x24($sp)
    /* 6F9C 8001679C 2000B48F */  lw         $s4, 0x20($sp)
    /* 6FA0 800167A0 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 6FA4 800167A4 1800B28F */  lw         $s2, 0x18($sp)
    /* 6FA8 800167A8 1400B18F */  lw         $s1, 0x14($sp)
    /* 6FAC 800167AC 1000B08F */  lw         $s0, 0x10($sp)
    /* 6FB0 800167B0 0800E003 */  jr         $ra
    /* 6FB4 800167B4 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel PurchaseUpgrade__11tCarManagersss
