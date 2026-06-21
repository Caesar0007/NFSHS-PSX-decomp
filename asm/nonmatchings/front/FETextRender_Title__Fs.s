.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FETextRender_Title__Fs, 0xD4

glabel FETextRender_Title__Fs
    /* 12114 80021914 0580023C */  lui        $v0, %hi(FEApp)
    /* 12118 80021918 C014428C */  lw         $v0, %lo(FEApp)($v0)
    /* 1211C 8002191C 80FFBD27 */  addiu      $sp, $sp, -0x80
    /* 12120 80021920 7000B0AF */  sw         $s0, 0x70($sp)
    /* 12124 80021924 7800BFAF */  sw         $ra, 0x78($sp)
    /* 12128 80021928 7400B1AF */  sw         $s1, 0x74($sp)
    /* 1212C 8002192C 2C024290 */  lbu        $v0, 0x22C($v0)
    /* 12130 80021930 01001124 */  addiu      $s1, $zero, 0x1
    /* 12134 80021934 02005114 */  bne        $v0, $s1, .L80021940
    /* 12138 80021938 21800000 */   addu      $s0, $zero, $zero
    /* 1213C 8002193C 69001024 */  addiu      $s0, $zero, 0x69
  .L80021940:
    /* 12140 80021940 00240400 */  sll        $a0, $a0, 16
    /* 12144 80021944 94E4020C */  jal        TextSys_Word__Fi
    /* 12148 80021948 03240400 */   sra       $a0, $a0, 16
    /* 1214C 8002194C 1800A427 */  addiu      $a0, $sp, 0x18
    /* 12150 80021950 CA96030C */  jal        strcpy
    /* 12154 80021954 21284000 */   addu      $a1, $v0, $zero
    /* 12158 80021958 549A000C */  jal        s_lower__FPc
    /* 1215C 8002195C 1800A427 */   addiu     $a0, $sp, 0x18
    /* 12160 80021960 1800A427 */  addiu      $a0, $sp, 0x18
    /* 12164 80021964 30000524 */  addiu      $a1, $zero, 0x30
    /* 12168 80021968 10000636 */  ori        $a2, $s0, 0x10
    /* 1216C 8002196C 21380000 */  addu       $a3, $zero, $zero
    /* 12170 80021970 1000B1AF */  sw         $s1, 0x10($sp)
    /* 12174 80021974 B083000C */  jal        FETextRender_FullText__FPcss13tMenuTextType14tMenuTextStates
    /* 12178 80021978 1400A0AF */   sw        $zero, 0x14($sp)
    /* 1217C 8002197C 1800A427 */  addiu      $a0, $sp, 0x18
    /* 12180 80021980 2B000224 */  addiu      $v0, $zero, 0x2B
    /* 12184 80021984 6800A2A7 */  sh         $v0, 0x68($sp)
    /* 12188 80021988 12000226 */  addiu      $v0, $s0, 0x12
    /* 1218C 8002198C 888F030C */  jal        textpixels
    /* 12190 80021990 6A00A2A7 */   sh        $v0, 0x6A($sp)
    /* 12194 80021994 21200000 */  addu       $a0, $zero, $zero
    /* 12198 80021998 0A004224 */  addiu      $v0, $v0, 0xA
    /* 1219C 8002199C 003C0200 */  sll        $a3, $v0, 16
    /* 121A0 800219A0 6800A587 */  lh         $a1, 0x68($sp)
    /* 121A4 800219A4 6A00A687 */  lh         $a2, 0x6A($sp)
    /* 121A8 800219A8 033C0700 */  sra        $a3, $a3, 16
    /* 121AC 800219AC 6C00A2A7 */  sh         $v0, 0x6C($sp)
    /* 121B0 800219B0 0C000224 */  addiu      $v0, $zero, 0xC
    /* 121B4 800219B4 6E00A2A7 */  sh         $v0, 0x6E($sp)
    /* 121B8 800219B8 0C000224 */  addiu      $v0, $zero, 0xC
    /* 121BC 800219BC 1000A2AF */  sw         $v0, 0x10($sp)
    /* 121C0 800219C0 02000224 */  addiu      $v0, $zero, 0x2
    /* 121C4 800219C4 B43B010C */  jal        PSXDrawTransSquare__Fiiiiis
    /* 121C8 800219C8 1400A2AF */   sw        $v0, 0x14($sp)
    /* 121CC 800219CC B635010C */  jal        FeDraw_SetABRMode__Fi
    /* 121D0 800219D0 21200000 */   addu      $a0, $zero, $zero
    /* 121D4 800219D4 7800BF8F */  lw         $ra, 0x78($sp)
    /* 121D8 800219D8 7400B18F */  lw         $s1, 0x74($sp)
    /* 121DC 800219DC 7000B08F */  lw         $s0, 0x70($sp)
    /* 121E0 800219E0 0800E003 */  jr         $ra
    /* 121E4 800219E4 8000BD27 */   addiu     $sp, $sp, 0x80
endlabel FETextRender_Title__Fs
