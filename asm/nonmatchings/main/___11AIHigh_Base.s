.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___11AIHigh_Base, 0x74

glabel ___11AIHigh_Base
    /* 4BBC4 8005B3C4 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 4BBC8 8005B3C8 1000B0AF */  sw         $s0, 0x10($sp)
    /* 4BBCC 8005B3CC 21808000 */  addu       $s0, $a0, $zero
    /* 4BBD0 8005B3D0 1400B1AF */  sw         $s1, 0x14($sp)
    /* 4BBD4 8005B3D4 2188A000 */  addu       $s1, $a1, $zero
    /* 4BBD8 8005B3D8 0580023C */  lui        $v0, %hi(_vt_11AIHigh_Base)
    /* 4BBDC 8005B3DC 1800BFAF */  sw         $ra, 0x18($sp)
    /* 4BBE0 8005B3E0 0400038E */  lw         $v1, 0x4($s0)
    /* 4BBE4 8005B3E4 044E4224 */  addiu      $v0, $v0, %lo(_vt_11AIHigh_Base)
    /* 4BBE8 8005B3E8 09006010 */  beqz       $v1, .L8005B410
    /* 4BBEC 8005B3EC 140002AE */   sw        $v0, 0x14($s0)
    /* 4BBF0 8005B3F0 0400628C */  lw         $v0, 0x4($v1)
    /* 4BBF4 8005B3F4 03000524 */  addiu      $a1, $zero, 0x3
    /* 4BBF8 8005B3F8 10004484 */  lh         $a0, 0x10($v0)
    /* 4BBFC 8005B3FC 1400428C */  lw         $v0, 0x14($v0)
    /* 4BC00 8005B400 00000000 */  nop
    /* 4BC04 8005B404 09F84000 */  jalr       $v0
    /* 4BC08 8005B408 21206400 */   addu      $a0, $v1, $a0
    /* 4BC0C 8005B40C 040000AE */  sw         $zero, 0x4($s0)
  .L8005B410:
    /* 4BC10 8005B410 01002232 */  andi       $v0, $s1, 0x1
    /* 4BC14 8005B414 03004010 */  beqz       $v0, .L8005B424
    /* 4BC18 8005B418 00000000 */   nop
    /* 4BC1C 8005B41C 6B8F020C */  jal        __builtin_delete
    /* 4BC20 8005B420 21200002 */   addu      $a0, $s0, $zero
  .L8005B424:
    /* 4BC24 8005B424 1800BF8F */  lw         $ra, 0x18($sp)
    /* 4BC28 8005B428 1400B18F */  lw         $s1, 0x14($sp)
    /* 4BC2C 8005B42C 1000B08F */  lw         $s0, 0x10($sp)
    /* 4BC30 8005B430 0800E003 */  jr         $ra
    /* 4BC34 8005B434 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel ___11AIHigh_Base
