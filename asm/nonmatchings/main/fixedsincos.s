.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching fixedsincos, 0xB8

glabel fixedsincos
    /* E3E70 800F3670 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* E3E74 800F3674 1800B0AF */  sw         $s0, 0x18($sp)
    /* E3E78 800F3678 21808000 */  addu       $s0, $a0, $zero
    /* E3E7C 800F367C 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* E3E80 800F3680 2188A000 */  addu       $s1, $a1, $zero
    /* E3E84 800F3684 2000B2AF */  sw         $s2, 0x20($sp)
    /* E3E88 800F3688 2190C000 */  addu       $s2, $a2, $zero
    /* E3E8C 800F368C 83211000 */  sra        $a0, $s0, 6
    /* E3E90 800F3690 1000A527 */  addiu      $a1, $sp, 0x10
    /* E3E94 800F3694 2400BFAF */  sw         $ra, 0x24($sp)
    /* E3E98 800F3698 6FAB030C */  jal        intsincos
    /* E3E9C 800F369C 1400A627 */   addiu     $a2, $sp, 0x14
    /* E3EA0 800F36A0 3F001032 */  andi       $s0, $s0, 0x3F
    /* E3EA4 800F36A4 40101000 */  sll        $v0, $s0, 1
    /* E3EA8 800F36A8 21105000 */  addu       $v0, $v0, $s0
    /* E3EAC 800F36AC 80190200 */  sll        $v1, $v0, 6
    /* E3EB0 800F36B0 21104300 */  addu       $v0, $v0, $v1
    /* E3EB4 800F36B4 40110200 */  sll        $v0, $v0, 5
    /* E3EB8 800F36B8 23105000 */  subu       $v0, $v0, $s0
    /* E3EBC 800F36BC 40190200 */  sll        $v1, $v0, 5
    /* E3EC0 800F36C0 21104300 */  addu       $v0, $v0, $v1
    /* E3EC4 800F36C4 40100200 */  sll        $v0, $v0, 1
    /* E3EC8 800F36C8 1400A38F */  lw         $v1, 0x14($sp)
    /* E3ECC 800F36CC 43120200 */  sra        $v0, $v0, 9
    /* E3ED0 800F36D0 83180300 */  sra        $v1, $v1, 2
    /* E3ED4 800F36D4 18006200 */  mult       $v1, $v0
    /* E3ED8 800F36D8 1000A38F */  lw         $v1, 0x10($sp)
    /* E3EDC 800F36DC 12380000 */  mflo       $a3
    /* E3EE0 800F36E0 43250700 */  sra        $a0, $a3, 21
    /* E3EE4 800F36E4 21186400 */  addu       $v1, $v1, $a0
    /* E3EE8 800F36E8 000023AE */  sw         $v1, 0x0($s1)
    /* E3EEC 800F36EC 1000A38F */  lw         $v1, 0x10($sp)
    /* E3EF0 800F36F0 00000000 */  nop
    /* E3EF4 800F36F4 83180300 */  sra        $v1, $v1, 2
    /* E3EF8 800F36F8 18006200 */  mult       $v1, $v0
    /* E3EFC 800F36FC 1400A28F */  lw         $v0, 0x14($sp)
    /* E3F00 800F3700 12380000 */  mflo       $a3
    /* E3F04 800F3704 43250700 */  sra        $a0, $a3, 21
    /* E3F08 800F3708 23104400 */  subu       $v0, $v0, $a0
    /* E3F0C 800F370C 000042AE */  sw         $v0, 0x0($s2)
    /* E3F10 800F3710 2400BF8F */  lw         $ra, 0x24($sp)
    /* E3F14 800F3714 2000B28F */  lw         $s2, 0x20($sp)
    /* E3F18 800F3718 1C00B18F */  lw         $s1, 0x1C($sp)
    /* E3F1C 800F371C 1800B08F */  lw         $s0, 0x18($sp)
    /* E3F20 800F3720 0800E003 */  jr         $ra
    /* E3F24 800F3724 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel fixedsincos
