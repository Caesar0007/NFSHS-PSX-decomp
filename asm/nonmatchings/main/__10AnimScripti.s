.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __10AnimScripti, 0x6C

glabel __10AnimScripti
    /* 64B60 80074360 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 64B64 80074364 1400B1AF */  sw         $s1, 0x14($sp)
    /* 64B68 80074368 21888000 */  addu       $s1, $a0, $zero
    /* 64B6C 8007436C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 64B70 80074370 2180A000 */  addu       $s0, $a1, $zero
    /* 64B74 80074374 1800BFAF */  sw         $ra, 0x18($sp)
    /* 64B78 80074378 618F020C */  jal        __builtin_vec_new
    /* 64B7C 8007437C 04000424 */   addiu     $a0, $zero, 0x4
    /* 64B80 80074380 21204000 */  addu       $a0, $v0, $zero
    /* 64B84 80074384 1180023C */  lui        $v0, %hi(animScripts)
    /* 64B88 80074388 4CE24224 */  addiu      $v0, $v0, %lo(animScripts)
    /* 64B8C 8007438C 80801000 */  sll        $s0, $s0, 2
    /* 64B90 80074390 21800202 */  addu       $s0, $s0, $v0
    /* 64B94 80074394 100024AE */  sw         $a0, 0x10($s1)
    /* 64B98 80074398 0000038E */  lw         $v1, 0x0($s0)
    /* 64B9C 8007439C 21102002 */  addu       $v0, $s1, $zero
    /* 64BA0 800743A0 000083AC */  sw         $v1, 0x0($a0)
    /* 64BA4 800743A4 1280033C */  lui        $v1, %hi(D_8011E0B0)
    /* 64BA8 800743A8 B0E0648C */  lw         $a0, %lo(D_8011E0B0)($v1)
    /* 64BAC 800743AC 06000324 */  addiu      $v1, $zero, 0x6
    /* 64BB0 800743B0 080043AC */  sw         $v1, 0x8($v0)
    /* 64BB4 800743B4 000044AC */  sw         $a0, 0x0($v0)
    /* 64BB8 800743B8 1800BF8F */  lw         $ra, 0x18($sp)
    /* 64BBC 800743BC 1400B18F */  lw         $s1, 0x14($sp)
    /* 64BC0 800743C0 1000B08F */  lw         $s0, 0x10($sp)
    /* 64BC4 800743C4 0800E003 */  jr         $ra
    /* 64BC8 800743C8 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel __10AnimScripti
