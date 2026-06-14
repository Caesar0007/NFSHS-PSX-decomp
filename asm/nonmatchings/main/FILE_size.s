.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FILE_size, 0x90

glabel FILE_size
    /* DCDD0 800EC5D0 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* DCDD4 800EC5D4 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* DCDD8 800EC5D8 21988000 */  addu       $s3, $a0, $zero
    /* DCDDC 800EC5DC 1400B1AF */  sw         $s1, 0x14($sp)
    /* DCDE0 800EC5E0 2188A000 */  addu       $s1, $a1, $zero
    /* DCDE4 800EC5E4 1000B0AF */  sw         $s0, 0x10($sp)
    /* DCDE8 800EC5E8 2180C000 */  addu       $s0, $a2, $zero
    /* DCDEC 800EC5EC 2000BFAF */  sw         $ra, 0x20($sp)
    /* DCDF0 800EC5F0 37B4030C */  jal        func_800ED0DC
    /* DCDF4 800EC5F4 1800B2AF */   sw        $s2, 0x18($sp)
    /* DCDF8 800EC5F8 0FFF043C */  lui        $a0, (0xFF0FFFFF >> 16)
    /* DCDFC 800EC5FC 21904000 */  addu       $s2, $v0, $zero
    /* DCE00 800EC600 FFFF8434 */  ori        $a0, $a0, (0xFF0FFFFF & 0xFFFF)
    /* DCE04 800EC604 0000438E */  lw         $v1, 0x0($s2)
    /* DCE08 800EC608 6000023C */  lui        $v0, (0x600000 >> 16)
    /* DCE0C 800EC60C 140050AE */  sw         $s0, 0x14($s2)
    /* DCE10 800EC610 100051AE */  sw         $s1, 0x10($s2)
    /* DCE14 800EC614 24186400 */  and        $v1, $v1, $a0
    /* DCE18 800EC618 25186200 */  or         $v1, $v1, $v0
    /* DCE1C 800EC61C 05006016 */  bnez       $s3, .L800EC634
    /* DCE20 800EC620 000043AE */   sw        $v1, 0x0($s2)
    /* DCE24 800EC624 06000224 */  addiu      $v0, $zero, 0x6
    /* DCE28 800EC628 0C0042AE */  sw         $v0, 0xC($s2)
    /* DCE2C 800EC62C 35B4030C */  jal        func_800ED0D4
    /* DCE30 800EC630 21204002 */   addu      $a0, $s2, $zero
  .L800EC634:
    /* DCE34 800EC634 21204002 */  addu       $a0, $s2, $zero
    /* DCE38 800EC638 E6B2030C */  jal        func_800ECB98
    /* DCE3C 800EC63C 240053AE */   sw        $s3, 0x24($s2)
    /* DCE40 800EC640 0000428E */  lw         $v0, 0x0($s2)
    /* DCE44 800EC644 2000BF8F */  lw         $ra, 0x20($sp)
    /* DCE48 800EC648 1C00B38F */  lw         $s3, 0x1C($sp)
    /* DCE4C 800EC64C 1800B28F */  lw         $s2, 0x18($sp)
    /* DCE50 800EC650 1400B18F */  lw         $s1, 0x14($sp)
    /* DCE54 800EC654 1000B08F */  lw         $s0, 0x10($sp)
    /* DCE58 800EC658 0800E003 */  jr         $ra
    /* DCE5C 800EC65C 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel FILE_size
