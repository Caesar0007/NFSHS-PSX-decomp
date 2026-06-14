.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Font_GetUVWH__FcPiN41, 0xC8

glabel Font_GetUVWH__FcPiN41
    /* BC3E8 800CBBE8 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* BC3EC 800CBBEC 2000B4AF */  sw         $s4, 0x20($sp)
    /* BC3F0 800CBBF0 4000B48F */  lw         $s4, 0x40($sp)
    /* BC3F4 800CBBF4 1400B1AF */  sw         $s1, 0x14($sp)
    /* BC3F8 800CBBF8 2188A000 */  addu       $s1, $a1, $zero
    /* BC3FC 800CBBFC 1800B2AF */  sw         $s2, 0x18($sp)
    /* BC400 800CBC00 2190C000 */  addu       $s2, $a2, $zero
    /* BC404 800CBC04 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* BC408 800CBC08 2198E000 */  addu       $s3, $a3, $zero
    /* BC40C 800CBC0C 2400B5AF */  sw         $s5, 0x24($sp)
    /* BC410 800CBC10 4400B58F */  lw         $s5, 0x44($sp)
    /* BC414 800CBC14 FF008430 */  andi       $a0, $a0, 0xFF
    /* BC418 800CBC18 2800BFAF */  sw         $ra, 0x28($sp)
    /* BC41C 800CBC1C D02D030C */  jal        Font_Getcharacter__Fi
    /* BC420 800CBC20 1000B0AF */   sw        $s0, 0x10($sp)
    /* BC424 800CBC24 21804000 */  addu       $s0, $v0, $zero
    /* BC428 800CBC28 04000426 */  addiu      $a0, $s0, 0x4
    /* BC42C 800CBC2C 23CC030C */  jal        geti
    /* BC430 800CBC30 02000524 */   addiu     $a1, $zero, 0x2
    /* BC434 800CBC34 06000426 */  addiu      $a0, $s0, 0x6
    /* BC438 800CBC38 02000524 */  addiu      $a1, $zero, 0x2
    /* BC43C 800CBC3C 23CC030C */  jal        geti
    /* BC440 800CBC40 000022AE */   sw        $v0, 0x0($s1)
    /* BC444 800CBC44 1380033C */  lui        $v1, %hi(D_80135C28)
    /* BC448 800CBC48 285C638C */  lw         $v1, %lo(D_80135C28)($v1)
    /* BC44C 800CBC4C 00000000 */  nop
    /* BC450 800CBC50 0C00638C */  lw         $v1, 0xC($v1)
    /* BC454 800CBC54 00000000 */  nop
    /* BC458 800CBC58 001D0300 */  sll        $v1, $v1, 20
    /* BC45C 800CBC5C 031D0300 */  sra        $v1, $v1, 20
    /* BC460 800CBC60 21186200 */  addu       $v1, $v1, $v0
    /* BC464 800CBC64 000043AE */  sw         $v1, 0x0($s2)
    /* BC468 800CBC68 02000292 */  lbu        $v0, 0x2($s0)
    /* BC46C 800CBC6C 00000000 */  nop
    /* BC470 800CBC70 000062AE */  sw         $v0, 0x0($s3)
    /* BC474 800CBC74 03000292 */  lbu        $v0, 0x3($s0)
    /* BC478 800CBC78 00000000 */  nop
    /* BC47C 800CBC7C 000082AE */  sw         $v0, 0x0($s4)
    /* BC480 800CBC80 0A000282 */  lb         $v0, 0xA($s0)
    /* BC484 800CBC84 00000000 */  nop
    /* BC488 800CBC88 0000A2AE */  sw         $v0, 0x0($s5)
    /* BC48C 800CBC8C 2800BF8F */  lw         $ra, 0x28($sp)
    /* BC490 800CBC90 2400B58F */  lw         $s5, 0x24($sp)
    /* BC494 800CBC94 2000B48F */  lw         $s4, 0x20($sp)
    /* BC498 800CBC98 1C00B38F */  lw         $s3, 0x1C($sp)
    /* BC49C 800CBC9C 1800B28F */  lw         $s2, 0x18($sp)
    /* BC4A0 800CBCA0 1400B18F */  lw         $s1, 0x14($sp)
    /* BC4A4 800CBCA4 1000B08F */  lw         $s0, 0x10($sp)
    /* BC4A8 800CBCA8 0800E003 */  jr         $ra
    /* BC4AC 800CBCAC 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel Font_GetUVWH__FcPiN41
