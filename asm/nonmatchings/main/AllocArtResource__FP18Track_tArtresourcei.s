.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AllocArtResource__FP18Track_tArtresourcei, 0x40

glabel AllocArtResource__FP18Track_tArtresourcei
    /* A9B98 800B9398 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* A9B9C 800B939C 1000B0AF */  sw         $s0, 0x10($sp)
    /* A9BA0 800B93A0 21808000 */  addu       $s0, $a0, $zero
    /* A9BA4 800B93A4 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* A9BA8 800B93A8 00210500 */  sll        $a0, $a1, 4
    /* A9BAC 800B93AC 1400BFAF */  sw         $ra, 0x14($sp)
    /* A9BB0 800B93B0 000002AE */  sw         $v0, 0x0($s0)
    /* A9BB4 800B93B4 FEF8010C */  jal        BWAllocMem__Fl
    /* A9BB8 800B93B8 140000AE */   sw        $zero, 0x14($s0)
    /* A9BBC 800B93BC 0C0002AE */  sw         $v0, 0xC($s0)
    /* A9BC0 800B93C0 080000AE */  sw         $zero, 0x8($s0)
    /* A9BC4 800B93C4 040000AE */  sw         $zero, 0x4($s0)
    /* A9BC8 800B93C8 1400BF8F */  lw         $ra, 0x14($sp)
    /* A9BCC 800B93CC 1000B08F */  lw         $s0, 0x10($sp)
    /* A9BD0 800B93D0 0800E003 */  jr         $ra
    /* A9BD4 800B93D4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AllocArtResource__FP18Track_tArtresourcei
