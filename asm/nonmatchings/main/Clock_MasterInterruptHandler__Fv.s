.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Clock_MasterInterruptHandler__Fv, 0xAC

glabel Clock_MasterInterruptHandler__Fv
    /* 7C138 8008B938 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 7C13C 8008B93C 1800BFAF */  sw         $ra, 0x18($sp)
    /* 7C140 8008B940 24AC030C */  jal        savegp
    /* 7C144 8008B944 1000A427 */   addiu     $a0, $sp, 0x10
    /* 7C148 8008B948 D802828F */  lw         $v0, %gp_rel(stopClock)($gp)
    /* 7C14C 8008B94C 00000000 */  nop
    /* 7C150 8008B950 1D004014 */  bnez       $v0, .L8008B9C8
    /* 7C154 8008B954 1180043C */   lui       $a0, %hi(clock_realTime)
    /* 7C158 8008B958 240C838C */  lw         $v1, %lo(clock_realTime)($a0)
    /* 7C15C 8008B95C DC02828F */  lw         $v0, %gp_rel(generic128HzClock)($gp)
    /* 7C160 8008B960 01006324 */  addiu      $v1, $v1, 0x1
    /* 7C164 8008B964 01004224 */  addiu      $v0, $v0, 0x1
    /* 7C168 8008B968 240C83AC */  sw         $v1, %lo(clock_realTime)($a0)
    /* 7C16C 8008B96C 240C8424 */  addiu      $a0, $a0, %lo(clock_realTime)
    /* 7C170 8008B970 01006330 */  andi       $v1, $v1, 0x1
    /* 7C174 8008B974 DC0282AF */  sw         $v0, %gp_rel(generic128HzClock)($gp)
    /* 7C178 8008B978 13006014 */  bnez       $v1, .L8008B9C8
    /* 7C17C 8008B97C 00000000 */   nop
    /* 7C180 8008B980 0400828C */  lw         $v0, 0x4($a0)
    /* 7C184 8008B984 00000000 */  nop
    /* 7C188 8008B988 01004224 */  addiu      $v0, $v0, 0x1
    /* 7C18C 8008B98C 040082AC */  sw         $v0, 0x4($a0)
    /* 7C190 8008B990 01004230 */  andi       $v0, $v0, 0x1
    /* 7C194 8008B994 0C004014 */  bnez       $v0, .L8008B9C8
    /* 7C198 8008B998 00000000 */   nop
    /* 7C19C 8008B99C 0800828C */  lw         $v0, 0x8($a0)
    /* 7C1A0 8008B9A0 00000000 */  nop
    /* 7C1A4 8008B9A4 01004224 */  addiu      $v0, $v0, 0x1
    /* 7C1A8 8008B9A8 080082AC */  sw         $v0, 0x8($a0)
    /* 7C1AC 8008B9AC 01004230 */  andi       $v0, $v0, 0x1
    /* 7C1B0 8008B9B0 03004014 */  bnez       $v0, .L8008B9C0
    /* 7C1B4 8008B9B4 00000000 */   nop
    /* 7C1B8 8008B9B8 1E71020C */  jal        Input_Update__Fv
    /* 7C1BC 8008B9BC 00000000 */   nop
  .L8008B9C0:
    /* 7C1C0 8008B9C0 8274020C */  jal        Input_Store__Fv
    /* 7C1C4 8008B9C4 00000000 */   nop
  .L8008B9C8:
    /* 7C1C8 8008B9C8 1000A48F */  lw         $a0, 0x10($sp)
    /* 7C1CC 8008B9CC 29AC030C */  jal        restoregp
    /* 7C1D0 8008B9D0 00000000 */   nop
    /* 7C1D4 8008B9D4 1800BF8F */  lw         $ra, 0x18($sp)
    /* 7C1D8 8008B9D8 00000000 */  nop
    /* 7C1DC 8008B9DC 0800E003 */  jr         $ra
    /* 7C1E0 8008B9E0 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Clock_MasterInterruptHandler__Fv
