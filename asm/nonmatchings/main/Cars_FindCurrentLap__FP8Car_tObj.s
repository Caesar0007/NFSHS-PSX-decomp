.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Cars_FindCurrentLap__FP8Car_tObj, 0xB8

glabel Cars_FindCurrentLap__FP8Car_tObj
    /* 7B3C8 8008ABC8 1180023C */  lui        $v0, %hi(D_8011321C)
    /* 7B3CC 8008ABCC 1C32428C */  lw         $v0, %lo(D_8011321C)($v0)
    /* 7B3D0 8008ABD0 00000000 */  nop
    /* 7B3D4 8008ABD4 08004010 */  beqz       $v0, .L8008ABF8
    /* 7B3D8 8008ABD8 00000000 */   nop
    /* 7B3DC 8008ABDC 08008384 */  lh         $v1, 0x8($a0)
    /* 7B3E0 8008ABE0 1480023C */  lui        $v0, %hi(gNumSlices)
    /* 7B3E4 8008ABE4 C8C7428C */  lw         $v0, %lo(gNumSlices)($v0)
    /* 7B3E8 8008ABE8 00000000 */  nop
    /* 7B3EC 8008ABEC 23104300 */  subu       $v0, $v0, $v1
    /* 7B3F0 8008ABF0 FF2A0208 */  j          .L8008ABFC
    /* 7B3F4 8008ABF4 FFFF4524 */   addiu     $a1, $v0, -0x1
  .L8008ABF8:
    /* 7B3F8 8008ABF8 08008584 */  lh         $a1, 0x8($a0)
  .L8008ABFC:
    /* 7B3FC 8008ABFC 04008394 */  lhu        $v1, 0x4($a0)
    /* 7B400 8008AC00 00000000 */  nop
    /* 7B404 8008AC04 1C006510 */  beq        $v1, $a1, .L8008AC78
    /* 7B408 8008AC08 F501A228 */   slti      $v0, $a1, 0x1F5
    /* 7B40C 8008AC0C 08004014 */  bnez       $v0, .L8008AC30
    /* 7B410 8008AC10 3300A22C */   sltiu     $v0, $a1, 0x33
    /* 7B414 8008AC14 06006014 */  bnez       $v1, .L8008AC30
    /* 7B418 8008AC18 00000000 */   nop
    /* 7B41C 8008AC1C 6802828C */  lw         $v0, 0x268($a0)
    /* 7B420 8008AC20 00000000 */  nop
    /* 7B424 8008AC24 01004224 */  addiu      $v0, $v0, 0x1
    /* 7B428 8008AC28 1D2B0208 */  j          .L8008AC74
    /* 7B42C 8008AC2C 680282AC */   sw        $v0, 0x268($a0)
  .L8008AC30:
    /* 7B430 8008AC30 10004010 */  beqz       $v0, .L8008AC74
    /* 7B434 8008AC34 00000000 */   nop
    /* 7B438 8008AC38 04008294 */  lhu        $v0, 0x4($a0)
    /* 7B43C 8008AC3C 00000000 */  nop
    /* 7B440 8008AC40 F501422C */  sltiu      $v0, $v0, 0x1F5
    /* 7B444 8008AC44 0B004014 */  bnez       $v0, .L8008AC74
    /* 7B448 8008AC48 00000000 */   nop
    /* 7B44C 8008AC4C 6802828C */  lw         $v0, 0x268($a0)
    /* 7B450 8008AC50 00000000 */  nop
    /* 7B454 8008AC54 03004018 */  blez       $v0, .L8008AC64
    /* 7B458 8008AC58 FFFF4224 */   addiu     $v0, $v0, -0x1
    /* 7B45C 8008AC5C 1D2B0208 */  j          .L8008AC74
    /* 7B460 8008AC60 680282AC */   sw        $v0, 0x268($a0)
  .L8008AC64:
    /* 7B464 8008AC64 6402828C */  lw         $v0, 0x264($a0)
    /* 7B468 8008AC68 00000000 */  nop
    /* 7B46C 8008AC6C 01004224 */  addiu      $v0, $v0, 0x1
    /* 7B470 8008AC70 640282AC */  sw         $v0, 0x264($a0)
  .L8008AC74:
    /* 7B474 8008AC74 040085A4 */  sh         $a1, 0x4($a0)
  .L8008AC78:
    /* 7B478 8008AC78 0800E003 */  jr         $ra
    /* 7B47C 8008AC7C 00000000 */   nop
endlabel Cars_FindCurrentLap__FP8Car_tObj
