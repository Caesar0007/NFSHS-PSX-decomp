.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Udff_GetBuffer__FP10Udff_tInfoPci, 0x48

glabel Udff_GetBuffer__FP10Udff_tInfoPci
    /* AC33C 800BBB3C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* AC340 800BBB40 1000B0AF */  sw         $s0, 0x10($sp)
    /* AC344 800BBB44 21808000 */  addu       $s0, $a0, $zero
    /* AC348 800BBB48 1400B1AF */  sw         $s1, 0x14($sp)
    /* AC34C 800BBB4C 2120A000 */  addu       $a0, $a1, $zero
    /* AC350 800BBB50 1800BFAF */  sw         $ra, 0x18($sp)
    /* AC354 800BBB54 0800058E */  lw         $a1, 0x8($s0)
    /* AC358 800BBB58 B1AA030C */  jal        memcpy
    /* AC35C 800BBB5C 2188C000 */   addu      $s1, $a2, $zero
    /* AC360 800BBB60 0800028E */  lw         $v0, 0x8($s0)
    /* AC364 800BBB64 00000000 */  nop
    /* AC368 800BBB68 21105100 */  addu       $v0, $v0, $s1
    /* AC36C 800BBB6C 080002AE */  sw         $v0, 0x8($s0)
    /* AC370 800BBB70 1800BF8F */  lw         $ra, 0x18($sp)
    /* AC374 800BBB74 1400B18F */  lw         $s1, 0x14($sp)
    /* AC378 800BBB78 1000B08F */  lw         $s0, 0x10($sp)
    /* AC37C 800BBB7C 0800E003 */  jr         $ra
    /* AC380 800BBB80 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Udff_GetBuffer__FP10Udff_tInfoPci
