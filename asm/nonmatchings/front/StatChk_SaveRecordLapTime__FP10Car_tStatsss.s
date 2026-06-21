.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching StatChk_SaveRecordLapTime__FP10Car_tStatsss, 0x190

glabel StatChk_SaveRecordLapTime__FP10Car_tStatsss
    /* 3A37C 80049B7C A8FFBD27 */  addiu      $sp, $sp, -0x58
    /* 3A380 80049B80 5000B4AF */  sw         $s4, 0x50($sp)
    /* 3A384 80049B84 21A08000 */  addu       $s4, $a0, $zero
    /* 3A388 80049B88 1180043C */  lui        $a0, %hi(carManager)
    /* 3A38C 80049B8C 74428424 */  addiu      $a0, $a0, %lo(carManager)
    /* 3A390 80049B90 001C0600 */  sll        $v1, $a2, 16
    /* 3A394 80049B94 031C0300 */  sra        $v1, $v1, 16
    /* 3A398 80049B98 80100300 */  sll        $v0, $v1, 2
    /* 3A39C 80049B9C 21104300 */  addu       $v0, $v0, $v1
    /* 3A3A0 80049BA0 40110200 */  sll        $v0, $v0, 5
    /* 3A3A4 80049BA4 4000B0AF */  sw         $s0, 0x40($sp)
    /* 3A3A8 80049BA8 21805400 */  addu       $s0, $v0, $s4
    /* 3A3AC 80049BAC 5400BFAF */  sw         $ra, 0x54($sp)
    /* 3A3B0 80049BB0 4C00B3AF */  sw         $s3, 0x4C($sp)
    /* 3A3B4 80049BB4 4800B2AF */  sw         $s2, 0x48($sp)
    /* 3A3B8 80049BB8 4400B1AF */  sw         $s1, 0x44($sp)
    /* 3A3BC 80049BBC 60000586 */  lh         $a1, 0x60($s0)
    /* 3A3C0 80049BC0 A758000C */  jal        GetCarFromSimID__11tCarManagers
    /* 3A3C4 80049BC4 2198C000 */   addu      $s3, $a2, $zero
    /* 3A3C8 80049BC8 21904000 */  addu       $s2, $v0, $zero
    /* 3A3CC 80049BCC 02004292 */  lbu        $v0, 0x2($s2)
    /* 3A3D0 80049BD0 00000000 */  nop
    /* 3A3D4 80049BD4 F9FF4224 */  addiu      $v0, $v0, -0x7
    /* 3A3D8 80049BD8 0200422C */  sltiu      $v0, $v0, 0x2
    /* 3A3DC 80049BDC 43004014 */  bnez       $v0, .L80049CEC
    /* 3A3E0 80049BE0 0180043C */   lui       $a0, %hi(D_800124CC)
    /* 3A3E4 80049BE4 CC248424 */  addiu      $a0, $a0, %lo(D_800124CC)
    /* 3A3E8 80049BE8 68010524 */  addiu      $a1, $zero, 0x168
    /* 3A3EC 80049BEC CF94030C */  jal        reservememadr
    /* 3A3F0 80049BF0 10000624 */   addiu     $a2, $zero, 0x10
    /* 3A3F4 80049BF4 58AE000C */  jal        Front_GetTrackRaced__Fv
    /* 3A3F8 80049BF8 21884000 */   addu      $s1, $v0, $zero
    /* 3A3FC 80049BFC 00140200 */  sll        $v0, $v0, 16
    /* 3A400 80049C00 03240200 */  sra        $a0, $v0, 16
    /* 3A404 80049C04 862B010C */  jal        Stattool_GetRecords__FsP13tRecordBuffer
    /* 3A408 80049C08 21282002 */   addu      $a1, $s1, $zero
    /* 3A40C 80049C0C 1000A427 */  addiu      $a0, $sp, 0x10
    /* 3A410 80049C10 14002526 */  addiu      $a1, $s1, 0x14
    /* 3A414 80049C14 B1AA030C */  jal        memcpy
    /* 3A418 80049C18 14000624 */   addiu     $a2, $zero, 0x14
    /* 3A41C 80049C1C 7C00028E */  lw         $v0, 0x7C($s0)
    /* 3A420 80049C20 00000000 */  nop
    /* 3A424 80049C24 08004014 */  bnez       $v0, .L80049C48
    /* 3A428 80049C28 02000224 */   addiu     $v0, $zero, 0x2
    /* 3A42C 80049C2C 8000038E */  lw         $v1, 0x80($s0)
    /* 3A430 80049C30 00000000 */  nop
    /* 3A434 80049C34 04006214 */  bne        $v1, $v0, .L80049C48
    /* 3A438 80049C38 00000000 */   nop
    /* 3A43C 80049C3C 8800028E */  lw         $v0, 0x88($s0)
    /* 3A440 80049C40 13270108 */  j          .L80049C4C
    /* 3A444 80049C44 3400A2AF */   sw        $v0, 0x34($sp)
  .L80049C48:
    /* 3A448 80049C48 3400A0AF */  sw         $zero, 0x34($sp)
  .L80049C4C:
    /* 3A44C 80049C4C 00241300 */  sll        $a0, $s3, 16
    /* 3A450 80049C50 03240400 */  sra        $a0, $a0, 16
    /* 3A454 80049C54 80100400 */  sll        $v0, $a0, 2
    /* 3A458 80049C58 21104400 */  addu       $v0, $v0, $a0
    /* 3A45C 80049C5C 40110200 */  sll        $v0, $v0, 5
    /* 3A460 80049C60 21105400 */  addu       $v0, $v0, $s4
    /* 3A464 80049C64 9C00428C */  lw         $v0, 0x9C($v0)
    /* 3A468 80049C68 00000000 */  nop
    /* 3A46C 80049C6C 3800A2AF */  sw         $v0, 0x38($sp)
    /* 3A470 80049C70 00004282 */  lb         $v0, 0x0($s2)
    /* 3A474 80049C74 7FAE000C */  jal        PlayerName__Fi
    /* 3A478 80049C78 3000A2AF */   sw        $v0, 0x30($sp)
    /* 3A47C 80049C7C 2800B027 */  addiu      $s0, $sp, 0x28
    /* 3A480 80049C80 21200002 */  addu       $a0, $s0, $zero
    /* 3A484 80049C84 CA96030C */  jal        strcpy
    /* 3A488 80049C88 21284000 */   addu      $a1, $v0, $zero
    /* 3A48C 80049C8C 21202002 */  addu       $a0, $s1, $zero
    /* 3A490 80049C90 21280002 */  addu       $a1, $s0, $zero
    /* 3A494 80049C94 B1AA030C */  jal        memcpy
    /* 3A498 80049C98 14000624 */   addiu     $a2, $zero, 0x14
    /* 3A49C 80049C9C 58AE000C */  jal        Front_GetTrackRaced__Fv
    /* 3A4A0 80049CA0 00000000 */   nop
    /* 3A4A4 80049CA4 21202002 */  addu       $a0, $s1, $zero
    /* 3A4A8 80049CA8 00140200 */  sll        $v0, $v0, 16
    /* 3A4AC 80049CAC 03140200 */  sra        $v0, $v0, 16
    /* 3A4B0 80049CB0 80180200 */  sll        $v1, $v0, 2
    /* 3A4B4 80049CB4 21186200 */  addu       $v1, $v1, $v0
    /* 3A4B8 80049CB8 00110300 */  sll        $v0, $v1, 4
    /* 3A4BC 80049CBC 21186200 */  addu       $v1, $v1, $v0
    /* 3A4C0 80049CC0 80180300 */  sll        $v1, $v1, 2
    /* 3A4C4 80049CC4 1180053C */  lui        $a1, %hi(Stats_gTrackRecords)
    /* 3A4C8 80049CC8 944DA524 */  addiu      $a1, $a1, %lo(Stats_gTrackRecords)
    /* 3A4CC 80049CCC 21286500 */  addu       $a1, $v1, $a1
    /* 3A4D0 80049CD0 B798030C */  jal        blockmove
    /* 3A4D4 80049CD4 54010624 */   addiu     $a2, $zero, 0x154
    /* 3A4D8 80049CD8 21202002 */  addu       $a0, $s1, $zero
    /* 3A4DC 80049CDC 01000324 */  addiu      $v1, $zero, 0x1
    /* 3A4E0 80049CE0 0580023C */  lui        $v0, %hi(NewBestLap)
    /* 3A4E4 80049CE4 5095030C */  jal        purgememadr
    /* 3A4E8 80049CE8 982943AC */   sw        $v1, %lo(NewBestLap)($v0)
  .L80049CEC:
    /* 3A4EC 80049CEC 5400BF8F */  lw         $ra, 0x54($sp)
    /* 3A4F0 80049CF0 5000B48F */  lw         $s4, 0x50($sp)
    /* 3A4F4 80049CF4 4C00B38F */  lw         $s3, 0x4C($sp)
    /* 3A4F8 80049CF8 4800B28F */  lw         $s2, 0x48($sp)
    /* 3A4FC 80049CFC 4400B18F */  lw         $s1, 0x44($sp)
    /* 3A500 80049D00 4000B08F */  lw         $s0, 0x40($sp)
    /* 3A504 80049D04 0800E003 */  jr         $ra
    /* 3A508 80049D08 5800BD27 */   addiu     $sp, $sp, 0x58
endlabel StatChk_SaveRecordLapTime__FP10Car_tStatsss
