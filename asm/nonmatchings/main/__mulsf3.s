.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __mulsf3, 0x140

glabel __mulsf3
    /* E3CB0 800F34B0 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* E3CB4 800F34B4 21408000 */  addu       $t0, $a0, $zero
    /* E3CB8 800F34B8 2148A000 */  addu       $t1, $a1, $zero
    /* E3CBC 800F34BC FF7F043C */  lui        $a0, (0x7FFFFFFF >> 16)
    /* E3CC0 800F34C0 FFFF8434 */  ori        $a0, $a0, (0x7FFFFFFF & 0xFFFF)
    /* E3CC4 800F34C4 00800A3C */  lui        $t2, (0x80000000 >> 16)
    /* E3CC8 800F34C8 24100A01 */  and        $v0, $t0, $t2
    /* E3CCC 800F34CC 24182A01 */  and        $v1, $t1, $t2
    /* E3CD0 800F34D0 1000B0AF */  sw         $s0, 0x10($sp)
    /* E3CD4 800F34D4 26804300 */  xor        $s0, $v0, $v1
    /* E3CD8 800F34D8 24100401 */  and        $v0, $t0, $a0
    /* E3CDC 800F34DC 04004010 */  beqz       $v0, .L800F34F0
    /* E3CE0 800F34E0 1400BFAF */   sw        $ra, 0x14($sp)
    /* E3CE4 800F34E4 24102401 */  and        $v0, $t1, $a0
    /* E3CE8 800F34E8 03004014 */  bnez       $v0, .L800F34F8
    /* E3CEC 800F34EC 7F00023C */   lui       $v0, (0x7FFFFF >> 16)
  .L800F34F0:
    /* E3CF0 800F34F0 78CD0308 */  j          .L800F35E0
    /* E3CF4 800F34F4 21100002 */   addu      $v0, $s0, $zero
  .L800F34F8:
    /* E3CF8 800F34F8 FFFF4234 */  ori        $v0, $v0, (0x7FFFFF & 0xFFFF)
    /* E3CFC 800F34FC C3350800 */  sra        $a2, $t0, 23
    /* E3D00 800F3500 24180201 */  and        $v1, $t0, $v0
    /* E3D04 800F3504 8000043C */  lui        $a0, (0x800000 >> 16)
    /* E3D08 800F3508 25406400 */  or         $t0, $v1, $a0
    /* E3D0C 800F350C C32D0900 */  sra        $a1, $t1, 23
    /* E3D10 800F3510 24102201 */  and        $v0, $t1, $v0
    /* E3D14 800F3514 25484400 */  or         $t1, $v0, $a0
    /* E3D18 800F3518 03220800 */  sra        $a0, $t0, 8
    /* E3D1C 800F351C 031A0900 */  sra        $v1, $t1, 8
    /* E3D20 800F3520 18008300 */  mult       $a0, $v1
    /* E3D24 800F3524 12380000 */  mflo       $a3
    /* E3D28 800F3528 FF000231 */  andi       $v0, $t0, 0xFF
    /* E3D2C 800F352C 00000000 */  nop
    /* E3D30 800F3530 18004300 */  mult       $v0, $v1
    /* E3D34 800F3534 12400000 */  mflo       $t0
    /* E3D38 800F3538 FF002231 */  andi       $v0, $t1, 0xFF
    /* E3D3C 800F353C 00000000 */  nop
    /* E3D40 800F3540 18004400 */  mult       $v0, $a0
    /* E3D44 800F3544 FF00C630 */  andi       $a2, $a2, 0xFF
    /* E3D48 800F3548 FF00A530 */  andi       $a1, $a1, 0xFF
    /* E3D4C 800F354C 2130C500 */  addu       $a2, $a2, $a1
    /* E3D50 800F3550 03120800 */  sra        $v0, $t0, 8
    /* E3D54 800F3554 2138E200 */  addu       $a3, $a3, $v0
    /* E3D58 800F3558 12200000 */  mflo       $a0
    /* E3D5C 800F355C 03120400 */  sra        $v0, $a0, 8
    /* E3D60 800F3560 2138E200 */  addu       $a3, $a3, $v0
    /* E3D64 800F3564 2410EA00 */  and        $v0, $a3, $t2
    /* E3D68 800F3568 04004010 */  beqz       $v0, .L800F357C
    /* E3D6C 800F356C 82FFC324 */   addiu     $v1, $a2, -0x7E
    /* E3D70 800F3570 8000E724 */  addiu      $a3, $a3, 0x80
    /* E3D74 800F3574 67CD0308 */  j          .L800F359C
    /* E3D78 800F3578 023A0700 */   srl       $a3, $a3, 8
  .L800F357C:
    /* E3D7C 800F357C 4000E724 */  addiu      $a3, $a3, 0x40
    /* E3D80 800F3580 2410EA00 */  and        $v0, $a3, $t2
    /* E3D84 800F3584 03004010 */  beqz       $v0, .L800F3594
    /* E3D88 800F3588 00000000 */   nop
    /* E3D8C 800F358C 67CD0308 */  j          .L800F359C
    /* E3D90 800F3590 023A0700 */   srl       $a3, $a3, 8
  .L800F3594:
    /* E3D94 800F3594 C2390700 */  srl        $a3, $a3, 7
    /* E3D98 800F3598 81FFC324 */  addiu      $v1, $a2, -0x7F
  .L800F359C:
    /* E3D9C 800F359C 7FFF023C */  lui        $v0, (0xFF7FFFFF >> 16)
    /* E3DA0 800F35A0 FFFF4234 */  ori        $v0, $v0, (0xFF7FFFFF & 0xFFFF)
    /* E3DA4 800F35A4 2438E200 */  and        $a3, $a3, $v0
    /* E3DA8 800F35A8 FF006228 */  slti       $v0, $v1, 0xFF
    /* E3DAC 800F35AC 09004014 */  bnez       $v0, .L800F35D4
    /* E3DB0 800F35B0 C0150300 */   sll       $v0, $v1, 23
    /* E3DB4 800F35B4 22000424 */  addiu      $a0, $zero, 0x22
    /* E3DB8 800F35B8 951A040C */  jal        _err_math
    /* E3DBC 800F35BC 0C000524 */   addiu     $a1, $zero, 0xC
    /* E3DC0 800F35C0 02000012 */  beqz       $s0, .L800F35CC
    /* E3DC4 800F35C4 807F043C */   lui       $a0, (0x7F800000 >> 16)
    /* E3DC8 800F35C8 80FF043C */  lui        $a0, (0xFF800000 >> 16)
  .L800F35CC:
    /* E3DCC 800F35CC 77CD0308 */  j          .L800F35DC
    /* E3DD0 800F35D0 21408000 */   addu      $t0, $a0, $zero
  .L800F35D4:
    /* E3DD4 800F35D4 25100202 */  or         $v0, $s0, $v0
    /* E3DD8 800F35D8 25404700 */  or         $t0, $v0, $a3
  .L800F35DC:
    /* E3DDC 800F35DC 21100001 */  addu       $v0, $t0, $zero
  .L800F35E0:
    /* E3DE0 800F35E0 1400BF8F */  lw         $ra, 0x14($sp)
    /* E3DE4 800F35E4 1000B08F */  lw         $s0, 0x10($sp)
    /* E3DE8 800F35E8 0800E003 */  jr         $ra
    /* E3DEC 800F35EC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel __mulsf3
