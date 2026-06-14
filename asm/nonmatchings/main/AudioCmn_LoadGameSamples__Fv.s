.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioCmn_LoadGameSamples__Fv, 0x134

glabel AudioCmn_LoadGameSamples__Fv
    /* 67F7C 8007777C 48FFBD27 */  addiu      $sp, $sp, -0xB8
    /* 67F80 80077780 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* 67F84 80077784 A800B0AF */  sw         $s0, 0xA8($sp)
    /* 67F88 80077788 EC315024 */  addiu      $s0, $v0, %lo(GameSetup_gData)
    /* 67F8C 8007778C B000BFAF */  sw         $ra, 0xB0($sp)
    /* 67F90 80077790 AC00B1AF */  sw         $s1, 0xAC($sp)
    /* 67F94 80077794 D403028E */  lw         $v0, 0x3D4($s0)
    /* 67F98 80077798 21200000 */  addu       $a0, $zero, $zero
    /* 67F9C 8007779C 80280200 */  sll        $a1, $v0, 2
    /* 67FA0 800777A0 2128A200 */  addu       $a1, $a1, $v0
    /* 67FA4 800777A4 1180023C */  lui        $v0, %hi(GameSetup_gCarNames)
    /* 67FA8 800777A8 44305124 */  addiu      $s1, $v0, %lo(GameSetup_gCarNames)
    /* 67FAC 800777AC 95EF010C */  jal        AudioEng_StartUp__FiPc
    /* 67FB0 800777B0 2128B100 */   addu      $a1, $a1, $s1
    /* 67FB4 800777B4 0C00038E */  lw         $v1, 0xC($s0)
    /* 67FB8 800777B8 01000224 */  addiu      $v0, $zero, 0x1
    /* 67FBC 800777BC 07006214 */  bne        $v1, $v0, .L800777DC
    /* 67FC0 800777C0 01000424 */   addiu     $a0, $zero, 0x1
    /* 67FC4 800777C4 8804028E */  lw         $v0, 0x488($s0)
    /* 67FC8 800777C8 00000000 */  nop
    /* 67FCC 800777CC 80280200 */  sll        $a1, $v0, 2
    /* 67FD0 800777D0 2128A200 */  addu       $a1, $a1, $v0
    /* 67FD4 800777D4 95EF010C */  jal        AudioEng_StartUp__FiPc
    /* 67FD8 800777D8 2128B100 */   addu      $a1, $a1, $s1
  .L800777DC:
    /* 67FDC 800777DC 0DF1010C */  jal        AudioEng_StartServer__Fv
    /* 67FE0 800777E0 00000000 */   nop
    /* 67FE4 800777E4 1180023C */  lui        $v0, %hi(D_801164D8)
    /* 67FE8 800777E8 D864458C */  lw         $a1, %lo(D_801164D8)($v0)
    /* 67FEC 800777EC CA96030C */  jal        strcpy
    /* 67FF0 800777F0 1000A427 */   addiu     $a0, $sp, 0x10
    /* 67FF4 800777F4 1000A427 */  addiu      $a0, $sp, 0x10
    /* 67FF8 800777F8 1480053C */  lui        $a1, %hi(D_8013C6A0)
    /* 67FFC 800777FC 3A9E030C */  jal        strcat
    /* 68000 80077800 A0C6A524 */   addiu     $a1, $a1, %lo(D_8013C6A0)
    /* 68004 80077804 7800A327 */  addiu      $v1, $sp, 0x78
    /* 68008 80077808 0580023C */  lui        $v0, %hi(D_8005570C)
    /* 6800C 8007780C 0C574224 */  addiu      $v0, $v0, %lo(D_8005570C)
    /* 68010 80077810 20004424 */  addiu      $a0, $v0, 0x20
  .L80077814:
    /* 68014 80077814 0000468C */  lw         $a2, 0x0($v0)
    /* 68018 80077818 0400478C */  lw         $a3, 0x4($v0)
    /* 6801C 8007781C 0800488C */  lw         $t0, 0x8($v0)
    /* 68020 80077820 0C00498C */  lw         $t1, 0xC($v0)
    /* 68024 80077824 000066AC */  sw         $a2, 0x0($v1)
    /* 68028 80077828 040067AC */  sw         $a3, 0x4($v1)
    /* 6802C 8007782C 080068AC */  sw         $t0, 0x8($v1)
    /* 68030 80077830 0C0069AC */  sw         $t1, 0xC($v1)
    /* 68034 80077834 10004224 */  addiu      $v0, $v0, 0x10
    /* 68038 80077838 F6FF4414 */  bne        $v0, $a0, .L80077814
    /* 6803C 8007783C 10006324 */   addiu     $v1, $v1, 0x10
    /* 68040 80077840 0000468C */  lw         $a2, 0x0($v0)
    /* 68044 80077844 0400478C */  lw         $a3, 0x4($v0)
    /* 68048 80077848 0800488C */  lw         $t0, 0x8($v0)
    /* 6804C 8007784C 000066AC */  sw         $a2, 0x0($v1)
    /* 68050 80077850 040067AC */  sw         $a3, 0x4($v1)
    /* 68054 80077854 080068AC */  sw         $t0, 0x8($v1)
    /* 68058 80077858 1180023C */  lui        $v0, %hi(D_80113228)
    /* 6805C 8007785C 2832428C */  lw         $v0, %lo(D_80113228)($v0)
    /* 68060 80077860 00000000 */  nop
    /* 68064 80077864 80100200 */  sll        $v0, $v0, 2
    /* 68068 80077868 2110A203 */  addu       $v0, $sp, $v0
    /* 6806C 8007786C 7800458C */  lw         $a1, 0x78($v0)
    /* 68070 80077870 3A9E030C */  jal        strcat
    /* 68074 80077874 1000A427 */   addiu     $a0, $sp, 0x10
    /* 68078 80077878 1000A427 */  addiu      $a0, $sp, 0x10
    /* 6807C 8007787C A3EF020C */  jal        AudioCmn_LoadBank__FPci
    /* 68080 80077880 03000524 */   addiu     $a1, $zero, 0x3
    /* 68084 80077884 1180023C */  lui        $v0, %hi(gSndBnk)
    /* 68088 80077888 A8E84224 */  addiu      $v0, $v0, %lo(gSndBnk)
    /* 6808C 8007788C FEFF0324 */  addiu      $v1, $zero, -0x2
    /* 68090 80077890 3C0043AC */  sw         $v1, 0x3C($v0)
    /* 68094 80077894 FDFF0324 */  addiu      $v1, $zero, -0x3
    /* 68098 80077898 180043AC */  sw         $v1, 0x18($v0)
    /* 6809C 8007789C B000BF8F */  lw         $ra, 0xB0($sp)
    /* 680A0 800778A0 AC00B18F */  lw         $s1, 0xAC($sp)
    /* 680A4 800778A4 A800B08F */  lw         $s0, 0xA8($sp)
    /* 680A8 800778A8 0800E003 */  jr         $ra
    /* 680AC 800778AC B800BD27 */   addiu     $sp, $sp, 0xB8
endlabel AudioCmn_LoadGameSamples__Fv
