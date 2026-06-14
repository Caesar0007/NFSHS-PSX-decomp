.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDplatformpacketplaydestroy, 0x44

glabel iSNDplatformpacketplaydestroy
    /* F4AC0 801042C0 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* F4AC4 801042C4 1480023C */  lui        $v0, %hi(sndpd)
    /* F4AC8 801042C8 18794224 */  addiu      $v0, $v0, %lo(sndpd)
    /* F4ACC 801042CC 1000B0AF */  sw         $s0, 0x10($sp)
    /* F4AD0 801042D0 80800400 */  sll        $s0, $a0, 2
    /* F4AD4 801042D4 21800202 */  addu       $s0, $s0, $v0
    /* F4AD8 801042D8 1400BFAF */  sw         $ra, 0x14($sp)
    /* F4ADC 801042DC F804028E */  lw         $v0, 0x4F8($s0)
    /* F4AE0 801042E0 00000000 */  nop
    /* F4AE4 801042E4 0000448C */  lw         $a0, 0x0($v0)
    /* F4AE8 801042E8 F229040C */  jal        iSNDpsxfree
    /* F4AEC 801042EC 00000000 */   nop
    /* F4AF0 801042F0 F80400AE */  sw         $zero, 0x4F8($s0)
    /* F4AF4 801042F4 1400BF8F */  lw         $ra, 0x14($sp)
    /* F4AF8 801042F8 1000B08F */  lw         $s0, 0x10($sp)
    /* F4AFC 801042FC 0800E003 */  jr         $ra
    /* F4B00 80104300 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel iSNDplatformpacketplaydestroy
