.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching fixedxformz, 0x64

glabel fixedxformz
    /* DB474 800EAC74 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* DB478 800EAC78 1800B0AF */  sw         $s0, 0x18($sp)
    /* DB47C 800EAC7C 21808000 */  addu       $s0, $a0, $zero
    /* DB480 800EAC80 2120A000 */  addu       $a0, $a1, $zero
    /* DB484 800EAC84 1000A527 */  addiu      $a1, $sp, 0x10
    /* DB488 800EAC88 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* DB48C 800EAC8C 9CCD030C */  jal        fixedsincos
    /* DB490 800EAC90 1400A627 */   addiu     $a2, $sp, 0x14
    /* DB494 800EAC94 080000AE */  sw         $zero, 0x8($s0)
    /* DB498 800EAC98 140000AE */  sw         $zero, 0x14($s0)
    /* DB49C 800EAC9C 180000AE */  sw         $zero, 0x18($s0)
    /* DB4A0 800EACA0 1C0000AE */  sw         $zero, 0x1C($s0)
    /* DB4A4 800EACA4 1400A48F */  lw         $a0, 0x14($sp)
    /* DB4A8 800EACA8 1000A38F */  lw         $v1, 0x10($sp)
    /* DB4AC 800EACAC 0100023C */  lui        $v0, (0x10000 >> 16)
    /* DB4B0 800EACB0 200002AE */  sw         $v0, 0x20($s0)
    /* DB4B4 800EACB4 040003AE */  sw         $v1, 0x4($s0)
    /* DB4B8 800EACB8 23180300 */  negu       $v1, $v1
    /* DB4BC 800EACBC 000004AE */  sw         $a0, 0x0($s0)
    /* DB4C0 800EACC0 0C0003AE */  sw         $v1, 0xC($s0)
    /* DB4C4 800EACC4 100004AE */  sw         $a0, 0x10($s0)
    /* DB4C8 800EACC8 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* DB4CC 800EACCC 1800B08F */  lw         $s0, 0x18($sp)
    /* DB4D0 800EACD0 0800E003 */  jr         $ra
    /* DB4D4 800EACD4 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel fixedxformz
