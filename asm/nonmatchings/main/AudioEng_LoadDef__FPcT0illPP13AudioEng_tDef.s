.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioEng_LoadDef__FPcT0illPP13AudioEng_tDef, 0x78

glabel AudioEng_LoadDef__FPcT0illPP13AudioEng_tDef
    /* 6C5DC 8007BDDC D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 6C5E0 8007BDE0 2000B2AF */  sw         $s2, 0x20($sp)
    /* 6C5E4 8007BDE4 2190C000 */  addu       $s2, $a2, $zero
    /* 6C5E8 8007BDE8 2400B3AF */  sw         $s3, 0x24($sp)
    /* 6C5EC 8007BDEC 2198E000 */  addu       $s3, $a3, $zero
    /* 6C5F0 8007BDF0 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* 6C5F4 8007BDF4 4000B18F */  lw         $s1, 0x40($sp)
    /* 6C5F8 8007BDF8 2120A000 */  addu       $a0, $a1, $zero
    /* 6C5FC 8007BDFC 1800B0AF */  sw         $s0, 0x18($sp)
    /* 6C600 8007BE00 4400B08F */  lw         $s0, 0x44($sp)
    /* 6C604 8007BE04 10000624 */  addiu      $a2, $zero, 0x10
    /* 6C608 8007BE08 2800BFAF */  sw         $ra, 0x28($sp)
    /* 6C60C 8007BE0C CF94030C */  jal        reservememadr
    /* 6C610 8007BE10 21282002 */   addu      $a1, $s1, $zero
    /* 6C614 8007BE14 08004010 */  beqz       $v0, .L8007BE38
    /* 6C618 8007BE18 000002AE */   sw        $v0, 0x0($s0)
    /* 6C61C 8007BE1C 21204002 */  addu       $a0, $s2, $zero
    /* 6C620 8007BE20 21286002 */  addu       $a1, $s3, $zero
    /* 6C624 8007BE24 64000224 */  addiu      $v0, $zero, 0x64
    /* 6C628 8007BE28 1000A2AF */  sw         $v0, 0x10($sp)
    /* 6C62C 8007BE2C 0000068E */  lw         $a2, 0x0($s0)
    /* 6C630 8007BE30 48AA030C */  jal        FILE_readsync
    /* 6C634 8007BE34 21382002 */   addu      $a3, $s1, $zero
  .L8007BE38:
    /* 6C638 8007BE38 2800BF8F */  lw         $ra, 0x28($sp)
    /* 6C63C 8007BE3C 2400B38F */  lw         $s3, 0x24($sp)
    /* 6C640 8007BE40 2000B28F */  lw         $s2, 0x20($sp)
    /* 6C644 8007BE44 1C00B18F */  lw         $s1, 0x1C($sp)
    /* 6C648 8007BE48 1800B08F */  lw         $s0, 0x18($sp)
    /* 6C64C 8007BE4C 0800E003 */  jr         $ra
    /* 6C650 8007BE50 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel AudioEng_LoadDef__FPcT0illPP13AudioEng_tDef
