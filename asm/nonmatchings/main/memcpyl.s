.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching memcpyl, 0x74

glabel memcpyl
    /* E59C0 800F51C0 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* E59C4 800F51C4 1000B0AF */  sw         $s0, 0x10($sp)
    /* E59C8 800F51C8 21808000 */  addu       $s0, $a0, $zero
    /* E59CC 800F51CC 1800B2AF */  sw         $s2, 0x18($sp)
    /* E59D0 800F51D0 2190A000 */  addu       $s2, $a1, $zero
    /* E59D4 800F51D4 1400B1AF */  sw         $s1, 0x14($sp)
    /* E59D8 800F51D8 2188C000 */  addu       $s1, $a2, $zero
    /* E59DC 800F51DC 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* E59E0 800F51E0 21981102 */  addu       $s3, $s0, $s1
    /* E59E4 800F51E4 2000BFAF */  sw         $ra, 0x20($sp)
  .L800F51E8:
    /* E59E8 800F51E8 21204002 */  addu       $a0, $s2, $zero
    /* E59EC 800F51EC 23CC030C */  jal        geti
    /* E59F0 800F51F0 04000524 */   addiu     $a1, $zero, 0x4
    /* E59F4 800F51F4 21200002 */  addu       $a0, $s0, $zero
    /* E59F8 800F51F8 21284000 */  addu       $a1, $v0, $zero
    /* E59FC 800F51FC 35CC030C */  jal        puti
    /* E5A00 800F5200 04000624 */   addiu     $a2, $zero, 0x4
    /* E5A04 800F5204 04001026 */  addiu      $s0, $s0, 0x4
    /* E5A08 800F5208 FCFF3126 */  addiu      $s1, $s1, -0x4
    /* E5A0C 800F520C F6FF201E */  bgtz       $s1, .L800F51E8
    /* E5A10 800F5210 04005226 */   addiu     $s2, $s2, 0x4
    /* E5A14 800F5214 21106002 */  addu       $v0, $s3, $zero
    /* E5A18 800F5218 2000BF8F */  lw         $ra, 0x20($sp)
    /* E5A1C 800F521C 1C00B38F */  lw         $s3, 0x1C($sp)
    /* E5A20 800F5220 1800B28F */  lw         $s2, 0x18($sp)
    /* E5A24 800F5224 1400B18F */  lw         $s1, 0x14($sp)
    /* E5A28 800F5228 1000B08F */  lw         $s0, 0x10($sp)
    /* E5A2C 800F522C 0800E003 */  jr         $ra
    /* E5A30 800F5230 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel memcpyl
