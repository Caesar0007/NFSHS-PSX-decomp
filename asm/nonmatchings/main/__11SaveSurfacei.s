.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __11SaveSurfacei, 0x44

glabel __11SaveSurfacei
    /* AB770 800BAF70 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* AB774 800BAF74 1000B0AF */  sw         $s0, 0x10($sp)
    /* AB778 800BAF78 21808000 */  addu       $s0, $a0, $zero
    /* AB77C 800BAF7C 0580043C */  lui        $a0, %hi(D_80056680)
    /* AB780 800BAF80 80668424 */  addiu      $a0, $a0, %lo(D_80056680)
    /* AB784 800BAF84 1400BFAF */  sw         $ra, 0x14($sp)
    /* AB788 800BAF88 020005A6 */  sh         $a1, 0x2($s0)
    /* AB78C 800BAF8C C0280500 */  sll        $a1, $a1, 3
    /* AB790 800BAF90 21300000 */  addu       $a2, $zero, $zero
    /* AB794 800BAF94 CF94030C */  jal        reservememadr
    /* AB798 800BAF98 000000A6 */   sh        $zero, 0x0($s0)
    /* AB79C 800BAF9C 040002AE */  sw         $v0, 0x4($s0)
    /* AB7A0 800BAFA0 21100002 */  addu       $v0, $s0, $zero
    /* AB7A4 800BAFA4 1400BF8F */  lw         $ra, 0x14($sp)
    /* AB7A8 800BAFA8 1000B08F */  lw         $s0, 0x10($sp)
    /* AB7AC 800BAFAC 0800E003 */  jr         $ra
    /* AB7B0 800BAFB0 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel __11SaveSurfacei
