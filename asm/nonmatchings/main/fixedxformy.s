.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching fixedxformy, 0x64

glabel fixedxformy
    /* DB410 800EAC10 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* DB414 800EAC14 1800B0AF */  sw         $s0, 0x18($sp)
    /* DB418 800EAC18 21808000 */  addu       $s0, $a0, $zero
    /* DB41C 800EAC1C 2120A000 */  addu       $a0, $a1, $zero
    /* DB420 800EAC20 1000A527 */  addiu      $a1, $sp, 0x10
    /* DB424 800EAC24 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* DB428 800EAC28 9CCD030C */  jal        fixedsincos
    /* DB42C 800EAC2C 1400A627 */   addiu     $a2, $sp, 0x14
    /* DB430 800EAC30 040000AE */  sw         $zero, 0x4($s0)
    /* DB434 800EAC34 0C0000AE */  sw         $zero, 0xC($s0)
    /* DB438 800EAC38 1400A48F */  lw         $a0, 0x14($sp)
    /* DB43C 800EAC3C 1000A38F */  lw         $v1, 0x10($sp)
    /* DB440 800EAC40 0100023C */  lui        $v0, (0x10000 >> 16)
    /* DB444 800EAC44 100002AE */  sw         $v0, 0x10($s0)
    /* DB448 800EAC48 140000AE */  sw         $zero, 0x14($s0)
    /* DB44C 800EAC4C 1C0000AE */  sw         $zero, 0x1C($s0)
    /* DB450 800EAC50 23100300 */  negu       $v0, $v1
    /* DB454 800EAC54 000004AE */  sw         $a0, 0x0($s0)
    /* DB458 800EAC58 080002AE */  sw         $v0, 0x8($s0)
    /* DB45C 800EAC5C 180003AE */  sw         $v1, 0x18($s0)
    /* DB460 800EAC60 200004AE */  sw         $a0, 0x20($s0)
    /* DB464 800EAC64 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* DB468 800EAC68 1800B08F */  lw         $s0, 0x18($sp)
    /* DB46C 800EAC6C 0800E003 */  jr         $ra
    /* DB470 800EAC70 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel fixedxformy
