.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FETextRender_WordWrapFade__FisR4RECT14tMenuTextState13tMenuTextType, 0x68

glabel FETextRender_WordWrapFade__FisR4RECT14tMenuTextState13tMenuTextType
    /* 12024 80021824 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 12028 80021828 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* 1202C 8002182C 21888000 */  addu       $s1, $a0, $zero
    /* 12030 80021830 00240500 */  sll        $a0, $a1, 16
    /* 12034 80021834 1800B0AF */  sw         $s0, 0x18($sp)
    /* 12038 80021838 4000B08F */  lw         $s0, 0x40($sp)
    /* 1203C 8002183C 03240400 */  sra        $a0, $a0, 16
    /* 12040 80021840 2000B2AF */  sw         $s2, 0x20($sp)
    /* 12044 80021844 2190C000 */  addu       $s2, $a2, $zero
    /* 12048 80021848 2400B3AF */  sw         $s3, 0x24($sp)
    /* 1204C 8002184C 2800BFAF */  sw         $ra, 0x28($sp)
    /* 12050 80021850 94E4020C */  jal        TextSys_Word__Fi
    /* 12054 80021854 2198E000 */   addu      $s3, $a3, $zero
    /* 12058 80021858 21202002 */  addu       $a0, $s1, $zero
    /* 1205C 8002185C 21284000 */  addu       $a1, $v0, $zero
    /* 12060 80021860 21304002 */  addu       $a2, $s2, $zero
    /* 12064 80021864 21386002 */  addu       $a3, $s3, $zero
    /* 12068 80021868 D085000C */  jal        FETextRender_WordWrapTextFade__FiPcR4RECT14tMenuTextState13tMenuTextType
    /* 1206C 8002186C 1000B0AF */   sw        $s0, 0x10($sp)
    /* 12070 80021870 2800BF8F */  lw         $ra, 0x28($sp)
    /* 12074 80021874 2400B38F */  lw         $s3, 0x24($sp)
    /* 12078 80021878 2000B28F */  lw         $s2, 0x20($sp)
    /* 1207C 8002187C 1C00B18F */  lw         $s1, 0x1C($sp)
    /* 12080 80021880 1800B08F */  lw         $s0, 0x18($sp)
    /* 12084 80021884 0800E003 */  jr         $ra
    /* 12088 80021888 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel FETextRender_WordWrapFade__FisR4RECT14tMenuTextState13tMenuTextType
