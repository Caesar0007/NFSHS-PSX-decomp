.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SNDfxinitbus, 0x78

glabel SNDfxinitbus
    /* D7558 800E6D58 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* D755C 800E6D5C 1400B1AF */  sw         $s1, 0x14($sp)
    /* D7560 800E6D60 21888000 */  addu       $s1, $a0, $zero
    /* D7564 800E6D64 1800B2AF */  sw         $s2, 0x18($sp)
    /* D7568 800E6D68 2190A000 */  addu       $s2, $a1, $zero
    /* D756C 800E6D6C 1000B0AF */  sw         $s0, 0x10($sp)
    /* D7570 800E6D70 2180C000 */  addu       $s0, $a2, $zero
    /* D7574 800E6D74 2130E000 */  addu       $a2, $a3, $zero
    /* D7578 800E6D78 21280002 */  addu       $a1, $s0, $zero
    /* D757C 800E6D7C 00191100 */  sll        $v1, $s1, 4
    /* D7580 800E6D80 1480023C */  lui        $v0, %hi(D_801478FC)
    /* D7584 800E6D84 FC784224 */  addiu      $v0, $v0, %lo(D_801478FC)
    /* D7588 800E6D88 3000A78F */  lw         $a3, 0x30($sp)
    /* D758C 800E6D8C 21186200 */  addu       $v1, $v1, $v0
    /* D7590 800E6D90 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* D7594 800E6D94 000070AC */  sw         $s0, 0x0($v1)
    /* D7598 800E6D98 080066AC */  sw         $a2, 0x8($v1)
    /* D759C 800E6D9C 6101040C */  jal        iSNDplatformfxinit
    /* D75A0 800E6DA0 0C0067AC */   sw        $a3, 0xC($v1)
    /* D75A4 800E6DA4 02000016 */  bnez       $s0, .L800E6DB0
    /* D75A8 800E6DA8 21202002 */   addu      $a0, $s1, $zero
    /* D75AC 800E6DAC 21900000 */  addu       $s2, $zero, $zero
  .L800E6DB0:
    /* D75B0 800E6DB0 749B030C */  jal        SNDfxmasterlevel
    /* D75B4 800E6DB4 21284002 */   addu      $a1, $s2, $zero
    /* D75B8 800E6DB8 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* D75BC 800E6DBC 1800B28F */  lw         $s2, 0x18($sp)
    /* D75C0 800E6DC0 1400B18F */  lw         $s1, 0x14($sp)
    /* D75C4 800E6DC4 1000B08F */  lw         $s0, 0x10($sp)
    /* D75C8 800E6DC8 0800E003 */  jr         $ra
    /* D75CC 800E6DCC 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel SNDfxinitbus
