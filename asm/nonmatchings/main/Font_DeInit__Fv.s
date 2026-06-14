.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Font_DeInit__Fv, 0x50

glabel Font_DeInit__Fv
    /* BC058 800CB858 0813828F */  lw         $v0, %gp_rel(font_clutx)($gp)
    /* BC05C 800CB85C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* BC060 800CB860 1000B0AF */  sw         $s0, 0x10($sp)
    /* BC064 800CB864 FFFF1024 */  addiu      $s0, $zero, -0x1
    /* BC068 800CB868 09005010 */  beq        $v0, $s0, .L800CB890
    /* BC06C 800CB86C 1400BFAF */   sw        $ra, 0x14($sp)
    /* BC070 800CB870 0C138497 */  lhu        $a0, %gp_rel(font_cluty)($gp)
    /* BC074 800CB874 03110200 */  sra        $v0, $v0, 4
    /* BC078 800CB878 3F004230 */  andi       $v0, $v0, 0x3F
    /* BC07C 800CB87C 80210400 */  sll        $a0, $a0, 6
    /* BC080 800CB880 25208200 */  or         $a0, $a0, $v0
    /* BC084 800CB884 00240400 */  sll        $a0, $a0, 16
    /* BC088 800CB888 697E030C */  jal        Texture_MenuReleaseClutId__Fs
    /* BC08C 800CB88C 03240400 */   sra       $a0, $a0, 16
  .L800CB890:
    /* BC090 800CB890 1400BF8F */  lw         $ra, 0x14($sp)
    /* BC094 800CB894 081390AF */  sw         $s0, %gp_rel(font_clutx)($gp)
    /* BC098 800CB898 0C1390AF */  sw         $s0, %gp_rel(font_cluty)($gp)
    /* BC09C 800CB89C 1000B08F */  lw         $s0, 0x10($sp)
    /* BC0A0 800CB8A0 0800E003 */  jr         $ra
    /* BC0A4 800CB8A4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Font_DeInit__Fv
