.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FETextRender_MenuTextFade__Fis14tMenuTextState13tMenuTextType, 0xCC

glabel FETextRender_MenuTextFade__Fis14tMenuTextState13tMenuTextType
    /* 118B4 800210B4 C0FFBD27 */  addiu      $sp, $sp, -0x40
    /* 118B8 800210B8 3400B5AF */  sw         $s5, 0x34($sp)
    /* 118BC 800210BC 21A88000 */  addu       $s5, $a0, $zero
    /* 118C0 800210C0 2000B0AF */  sw         $s0, 0x20($sp)
    /* 118C4 800210C4 2180E000 */  addu       $s0, $a3, $zero
    /* 118C8 800210C8 002C0500 */  sll        $a1, $a1, 16
    /* 118CC 800210CC 2400B1AF */  sw         $s1, 0x24($sp)
    /* 118D0 800210D0 038C0500 */  sra        $s1, $a1, 16
    /* 118D4 800210D4 21202002 */  addu       $a0, $s1, $zero
    /* 118D8 800210D8 3000B4AF */  sw         $s4, 0x30($sp)
    /* 118DC 800210DC 21A0C000 */  addu       $s4, $a2, $zero
    /* 118E0 800210E0 3800BFAF */  sw         $ra, 0x38($sp)
    /* 118E4 800210E4 2C00B3AF */  sw         $s3, 0x2C($sp)
    /* 118E8 800210E8 A4E4020C */  jal        TextSys_WordX__Fi
    /* 118EC 800210EC 2800B2AF */   sw        $s2, 0x28($sp)
    /* 118F0 800210F0 21202002 */  addu       $a0, $s1, $zero
    /* 118F4 800210F4 ACE4020C */  jal        TextSys_WordY__Fi
    /* 118F8 800210F8 21984000 */   addu      $s3, $v0, $zero
    /* 118FC 800210FC 21904000 */  addu       $s2, $v0, $zero
    /* 11900 80021100 0E000224 */  addiu      $v0, $zero, 0xE
    /* 11904 80021104 05000216 */  bne        $s0, $v0, .L8002111C
    /* 11908 80021108 0580033C */   lui       $v1, %hi(textDefinitions)
    /* 1190C 8002110C 9CE4020C */  jal        TextSys_WordFlags__Fi
    /* 11910 80021110 21202002 */   addu      $a0, $s1, $zero
    /* 11914 80021114 21804000 */  addu       $s0, $v0, $zero
    /* 11918 80021118 0580033C */  lui        $v1, %hi(textDefinitions)
  .L8002111C:
    /* 1191C 8002111C B8156324 */  addiu      $v1, $v1, %lo(textDefinitions)
    /* 11920 80021120 40101000 */  sll        $v0, $s0, 1
    /* 11924 80021124 21105000 */  addu       $v0, $v0, $s0
    /* 11928 80021128 40100200 */  sll        $v0, $v0, 1
    /* 1192C 8002112C 21104300 */  addu       $v0, $v0, $v1
    /* 11930 80021130 2120A002 */  addu       $a0, $s5, $zero
    /* 11934 80021134 00341300 */  sll        $a2, $s3, 16
    /* 11938 80021138 003C1200 */  sll        $a3, $s2, 16
    /* 1193C 8002113C 21282002 */  addu       $a1, $s1, $zero
    /* 11940 80021140 03340600 */  sra        $a2, $a2, 16
    /* 11944 80021144 01004290 */  lbu        $v0, 0x1($v0)
    /* 11948 80021148 033C0700 */  sra        $a3, $a3, 16
    /* 1194C 8002114C 1400B4AF */  sw         $s4, 0x14($sp)
    /* 11950 80021150 1800B0AF */  sw         $s0, 0x18($sp)
    /* 11954 80021154 7584000C */  jal        FETextRender_MenuTextPositionedJustifyFade__Fissss14tMenuTextState13tMenuTextType
    /* 11958 80021158 1000A2AF */   sw        $v0, 0x10($sp)
    /* 1195C 8002115C 3800BF8F */  lw         $ra, 0x38($sp)
    /* 11960 80021160 3400B58F */  lw         $s5, 0x34($sp)
    /* 11964 80021164 3000B48F */  lw         $s4, 0x30($sp)
    /* 11968 80021168 2C00B38F */  lw         $s3, 0x2C($sp)
    /* 1196C 8002116C 2800B28F */  lw         $s2, 0x28($sp)
    /* 11970 80021170 2400B18F */  lw         $s1, 0x24($sp)
    /* 11974 80021174 2000B08F */  lw         $s0, 0x20($sp)
    /* 11978 80021178 0800E003 */  jr         $ra
    /* 1197C 8002117C 4000BD27 */   addiu     $sp, $sp, 0x40
endlabel FETextRender_MenuTextFade__Fis14tMenuTextState13tMenuTextType
