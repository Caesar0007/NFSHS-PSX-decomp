.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDplatformfxinit, 0x38

glabel iSNDplatformfxinit
    /* F0D84 80100584 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* F0D88 80100588 2120A000 */  addu       $a0, $a1, $zero
    /* F0D8C 8010058C 1480023C */  lui        $v0, %hi(D_8014789C)
    /* F0D90 80100590 9C784380 */  lb         $v1, %lo(D_8014789C)($v0)
    /* F0D94 80100594 1480023C */  lui        $v0, %hi(D_8014791C)
    /* F0D98 80100598 1000BFAF */  sw         $ra, 0x10($sp)
    /* F0D9C 8010059C 03006010 */  beqz       $v1, .L801005AC
    /* F0DA0 801005A0 1C7944AC */   sw        $a0, %lo(D_8014791C)($v0)
    /* F0DA4 801005A4 8300040C */  jal        iSNDpsxfxinit
    /* F0DA8 801005A8 00000000 */   nop
  .L801005AC:
    /* F0DAC 801005AC 1000BF8F */  lw         $ra, 0x10($sp)
    /* F0DB0 801005B0 21100000 */  addu       $v0, $zero, $zero
    /* F0DB4 801005B4 0800E003 */  jr         $ra
    /* F0DB8 801005B8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel iSNDplatformfxinit
