.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FILE_read, 0xE4

glabel FILE_read
    /* DCCEC 800EC4EC D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* DCCF0 800EC4F0 1400B1AF */  sw         $s1, 0x14($sp)
    /* DCCF4 800EC4F4 4000B18F */  lw         $s1, 0x40($sp)
    /* DCCF8 800EC4F8 1000B0AF */  sw         $s0, 0x10($sp)
    /* DCCFC 800EC4FC 4400B08F */  lw         $s0, 0x44($sp)
    /* DCD00 800EC500 2000B4AF */  sw         $s4, 0x20($sp)
    /* DCD04 800EC504 21A08000 */  addu       $s4, $a0, $zero
    /* DCD08 800EC508 2400B5AF */  sw         $s5, 0x24($sp)
    /* DCD0C 800EC50C 21A8A000 */  addu       $s5, $a1, $zero
    /* DCD10 800EC510 2800B6AF */  sw         $s6, 0x28($sp)
    /* DCD14 800EC514 21B0C000 */  addu       $s6, $a2, $zero
    /* DCD18 800EC518 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* DCD1C 800EC51C 2198E000 */  addu       $s3, $a3, $zero
    /* DCD20 800EC520 2C00BFAF */  sw         $ra, 0x2C($sp)
    /* DCD24 800EC524 37B4030C */  jal        func_800ED0DC
    /* DCD28 800EC528 1800B2AF */   sw        $s2, 0x18($sp)
    /* DCD2C 800EC52C 0FFF033C */  lui        $v1, (0xFF0FFFFF >> 16)
    /* DCD30 800EC530 21904000 */  addu       $s2, $v0, $zero
    /* DCD34 800EC534 0000428E */  lw         $v0, 0x0($s2)
    /* DCD38 800EC538 FFFF6334 */  ori        $v1, $v1, (0xFF0FFFFF & 0xFFFF)
    /* DCD3C 800EC53C 24104300 */  and        $v0, $v0, $v1
    /* DCD40 800EC540 4000033C */  lui        $v1, (0x400000 >> 16)
    /* DCD44 800EC544 25104300 */  or         $v0, $v0, $v1
    /* DCD48 800EC548 000042AE */  sw         $v0, 0x0($s2)
    /* DCD4C 800EC54C 140050AE */  sw         $s0, 0x14($s2)
    /* DCD50 800EC550 05008016 */  bnez       $s4, .L800EC568
    /* DCD54 800EC554 100051AE */   sw        $s1, 0x10($s2)
    /* DCD58 800EC558 06000224 */  addiu      $v0, $zero, 0x6
    /* DCD5C 800EC55C 0C0042AE */  sw         $v0, 0xC($s2)
    /* DCD60 800EC560 35B4030C */  jal        func_800ED0D4
    /* DCD64 800EC564 21204002 */   addu      $a0, $s2, $zero
  .L800EC568:
    /* DCD68 800EC568 240054AE */  sw         $s4, 0x24($s2)
    /* DCD6C 800EC56C 0400848E */  lw         $a0, 0x4($s4)
    /* DCD70 800EC570 2110B302 */  addu       $v0, $s5, $s3
    /* DCD74 800EC574 2A108200 */  slt        $v0, $a0, $v0
    /* DCD78 800EC578 05004010 */  beqz       $v0, .L800EC590
    /* DCD7C 800EC57C 00000000 */   nop
    /* DCD80 800EC580 23989500 */  subu       $s3, $a0, $s5
    /* DCD84 800EC584 03006106 */  bgez       $s3, .L800EC594
    /* DCD88 800EC588 21204002 */   addu      $a0, $s2, $zero
    /* DCD8C 800EC58C 21980000 */  addu       $s3, $zero, $zero
  .L800EC590:
    /* DCD90 800EC590 21204002 */  addu       $a0, $s2, $zero
  .L800EC594:
    /* DCD94 800EC594 1C0053AE */  sw         $s3, 0x1C($s2)
    /* DCD98 800EC598 200056AE */  sw         $s6, 0x20($s2)
    /* DCD9C 800EC59C E6B2030C */  jal        func_800ECB98
    /* DCDA0 800EC5A0 180055AE */   sw        $s5, 0x18($s2)
    /* DCDA4 800EC5A4 0000428E */  lw         $v0, 0x0($s2)
    /* DCDA8 800EC5A8 2C00BF8F */  lw         $ra, 0x2C($sp)
    /* DCDAC 800EC5AC 2800B68F */  lw         $s6, 0x28($sp)
    /* DCDB0 800EC5B0 2400B58F */  lw         $s5, 0x24($sp)
    /* DCDB4 800EC5B4 2000B48F */  lw         $s4, 0x20($sp)
    /* DCDB8 800EC5B8 1C00B38F */  lw         $s3, 0x1C($sp)
    /* DCDBC 800EC5BC 1800B28F */  lw         $s2, 0x18($sp)
    /* DCDC0 800EC5C0 1400B18F */  lw         $s1, 0x14($sp)
    /* DCDC4 800EC5C4 1000B08F */  lw         $s0, 0x10($sp)
    /* DCDC8 800EC5C8 0800E003 */  jr         $ra
    /* DCDCC 800EC5CC 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel FILE_read
