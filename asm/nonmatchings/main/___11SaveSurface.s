.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___11SaveSurface, 0x48

glabel ___11SaveSurface
    /* AB7B4 800BAFB4 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* AB7B8 800BAFB8 1400B1AF */  sw         $s1, 0x14($sp)
    /* AB7BC 800BAFBC 21888000 */  addu       $s1, $a0, $zero
    /* AB7C0 800BAFC0 1800BFAF */  sw         $ra, 0x18($sp)
    /* AB7C4 800BAFC4 1000B0AF */  sw         $s0, 0x10($sp)
    /* AB7C8 800BAFC8 0400248E */  lw         $a0, 0x4($s1)
    /* AB7CC 800BAFCC 5095030C */  jal        purgememadr
    /* AB7D0 800BAFD0 2180A000 */   addu      $s0, $a1, $zero
    /* AB7D4 800BAFD4 01001032 */  andi       $s0, $s0, 0x1
    /* AB7D8 800BAFD8 03000012 */  beqz       $s0, .L800BAFE8
    /* AB7DC 800BAFDC 00000000 */   nop
    /* AB7E0 800BAFE0 6B8F020C */  jal        __builtin_delete
    /* AB7E4 800BAFE4 21202002 */   addu      $a0, $s1, $zero
  .L800BAFE8:
    /* AB7E8 800BAFE8 1800BF8F */  lw         $ra, 0x18($sp)
    /* AB7EC 800BAFEC 1400B18F */  lw         $s1, 0x14($sp)
    /* AB7F0 800BAFF0 1000B08F */  lw         $s0, 0x10($sp)
    /* AB7F4 800BAFF4 0800E003 */  jr         $ra
    /* AB7F8 800BAFF8 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel ___11SaveSurface
