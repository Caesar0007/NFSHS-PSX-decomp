.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Weather_CreateRain__FP7SVECTORP7DVECTORPc, 0x1C4

glabel Weather_CreateRain__FP7SVECTORP7DVECTORPc
    /* D3D6C 800E356C F8FFBD27 */  addiu      $sp, $sp, -0x8
    /* D3D70 800E3570 2168C000 */  addu       $t5, $a2, $zero
    /* D3D74 800E3574 03008E88 */  lwl        $t6, 0x3($a0)
    /* D3D78 800E3578 00008E98 */  lwr        $t6, 0x0($a0)
    /* D3D7C 800E357C 07008F88 */  lwl        $t7, 0x7($a0)
    /* D3D80 800E3580 04008F98 */  lwr        $t7, 0x4($a0)
    /* D3D84 800E3584 0300AEAB */  swl        $t6, 0x3($sp)
    /* D3D88 800E3588 0000AEBB */  swr        $t6, 0x0($sp)
    /* D3D8C 800E358C 0700AFAB */  swl        $t7, 0x7($sp)
    /* D3D90 800E3590 0400AFBB */  swr        $t7, 0x4($sp)
    /* D3D94 800E3594 0000A291 */  lbu        $v0, 0x0($t5)
    /* D3D98 800E3598 00000000 */  nop
    /* D3D9C 800E359C 37004010 */  beqz       $v0, .L800E367C
    /* D3DA0 800E35A0 2160A000 */   addu      $t4, $a1, $zero
    /* D3DA4 800E35A4 00008985 */  lh         $t1, 0x0($t4)
    /* D3DA8 800E35A8 02008B85 */  lh         $t3, 0x2($t4)
    /* D3DAC 800E35AC 0000A0CB */  lwc2       $0, 0x0($sp)
    /* D3DB0 800E35B0 0400A1CB */  lwc2       $1, 0x4($sp)
    /* D3DB4 800E35B4 00000000 */  nop
    /* D3DB8 800E35B8 00000000 */  nop
    /* D3DBC 800E35BC 0100184A */  .word 0x4A180001  /* rtps */
    /* D3DC0 800E35C0 801F073C */  lui        $a3, (0x1F800004 >> 16)
    /* D3DC4 800E35C4 0400E734 */  ori        $a3, $a3, (0x1F800004 & 0xFFFF)
    /* D3DC8 800E35C8 FF00043C */  lui        $a0, (0xFFFFFF >> 16)
    /* D3DCC 800E35CC FFFF8434 */  ori        $a0, $a0, (0xFFFFFF & 0xFFFF)
    /* D3DD0 800E35D0 4000083C */  lui        $t0, (0x402020 >> 16)
    /* D3DD4 800E35D4 20200835 */  ori        $t0, $t0, (0x402020 & 0xFFFF)
    /* D3DD8 800E35D8 00FF063C */  lui        $a2, (0xFF000000 >> 16)
    /* D3DDC 800E35DC 0000EA8C */  lw         $t2, 0x0($a3)
    /* D3DE0 800E35E0 801F053C */  lui        $a1, (0x1F800000 >> 16)
    /* D3DE4 800E35E4 0000A58C */  lw         $a1, (0x1F800000 & 0xFFFF)($a1)
    /* D3DE8 800E35E8 0000438D */  lw         $v1, 0x0($t2)
    /* D3DEC 800E35EC 0000A28C */  lw         $v0, 0x0($a1)
    /* D3DF0 800E35F0 24186600 */  and        $v1, $v1, $a2
    /* D3DF4 800E35F4 24104400 */  and        $v0, $v0, $a0
    /* D3DF8 800E35F8 25186200 */  or         $v1, $v1, $v0
    /* D3DFC 800E35FC 000043AD */  sw         $v1, 0x0($t2)
    /* D3E00 800E3600 14004325 */  addiu      $v1, $t2, 0x14
    /* D3E04 800E3604 0000A28C */  lw         $v0, 0x0($a1)
    /* D3E08 800E3608 24204401 */  and        $a0, $t2, $a0
    /* D3E0C 800E360C 0000E3AC */  sw         $v1, 0x0($a3)
    /* D3E10 800E3610 24104600 */  and        $v0, $v0, $a2
    /* D3E14 800E3614 25104400 */  or         $v0, $v0, $a0
    /* D3E18 800E3618 0000A2AC */  sw         $v0, 0x0($a1)
    /* D3E1C 800E361C 04000224 */  addiu      $v0, $zero, 0x4
    /* D3E20 800E3620 030042A1 */  sb         $v0, 0x3($t2)
    /* D3E24 800E3624 0052023C */  lui        $v0, (0x52000000 >> 16)
    /* D3E28 800E3628 040042AD */  sw         $v0, 0x4($t2)
    /* D3E2C 800E362C 10004225 */  addiu      $v0, $t2, 0x10
    /* D3E30 800E3630 0C0048AD */  sw         $t0, 0xC($t2)
    /* D3E34 800E3634 00004EE8 */  swc2       $14, 0x0($v0)
    /* D3E38 800E3638 10004385 */  lh         $v1, 0x10($t2)
    /* D3E3C 800E363C 00000000 */  nop
    /* D3E40 800E3640 40100300 */  sll        $v0, $v1, 1
    /* D3E44 800E3644 21104300 */  addu       $v0, $v0, $v1
    /* D3E48 800E3648 21182201 */  addu       $v1, $t1, $v0
    /* D3E4C 800E364C 02006104 */  bgez       $v1, .L800E3658
    /* D3E50 800E3650 00000000 */   nop
    /* D3E54 800E3654 03006324 */  addiu      $v1, $v1, 0x3
  .L800E3658:
    /* D3E58 800E3658 12004285 */  lh         $v0, 0x12($t2)
    /* D3E5C 800E365C 83180300 */  sra        $v1, $v1, 2
    /* D3E60 800E3660 080043A5 */  sh         $v1, 0x8($t2)
    /* D3E64 800E3664 21106201 */  addu       $v0, $t3, $v0
    /* D3E68 800E3668 C21F0200 */  srl        $v1, $v0, 31
    /* D3E6C 800E366C 21104300 */  addu       $v0, $v0, $v1
    /* D3E70 800E3670 43100200 */  sra        $v0, $v0, 1
    /* D3E74 800E3674 C58D0308 */  j          .L800E3714
    /* D3E78 800E3678 0A0042A5 */   sh        $v0, 0xA($t2)
  .L800E367C:
    /* D3E7C 800E367C 0000A0CB */  lwc2       $0, 0x0($sp)
    /* D3E80 800E3680 0400A1CB */  lwc2       $1, 0x4($sp)
    /* D3E84 800E3684 00000000 */  nop
    /* D3E88 800E3688 00000000 */  nop
    /* D3E8C 800E368C 0100184A */  .word 0x4A180001  /* rtps */
    /* D3E90 800E3690 801F073C */  lui        $a3, (0x1F800004 >> 16)
    /* D3E94 800E3694 0400E734 */  ori        $a3, $a3, (0x1F800004 & 0xFFFF)
    /* D3E98 800E3698 FF00043C */  lui        $a0, (0xFFFFFF >> 16)
    /* D3E9C 800E369C FFFF8434 */  ori        $a0, $a0, (0xFFFFFF & 0xFFFF)
    /* D3EA0 800E36A0 4000083C */  lui        $t0, (0x402020 >> 16)
    /* D3EA4 800E36A4 20200835 */  ori        $t0, $t0, (0x402020 & 0xFFFF)
    /* D3EA8 800E36A8 00FF063C */  lui        $a2, (0xFF000000 >> 16)
    /* D3EAC 800E36AC 0000EA8C */  lw         $t2, 0x0($a3)
    /* D3EB0 800E36B0 801F053C */  lui        $a1, (0x1F800000 >> 16)
    /* D3EB4 800E36B4 0000A58C */  lw         $a1, (0x1F800000 & 0xFFFF)($a1)
    /* D3EB8 800E36B8 0000438D */  lw         $v1, 0x0($t2)
    /* D3EBC 800E36BC 0000A28C */  lw         $v0, 0x0($a1)
    /* D3EC0 800E36C0 24186600 */  and        $v1, $v1, $a2
    /* D3EC4 800E36C4 24104400 */  and        $v0, $v0, $a0
    /* D3EC8 800E36C8 25186200 */  or         $v1, $v1, $v0
    /* D3ECC 800E36CC 000043AD */  sw         $v1, 0x0($t2)
    /* D3ED0 800E36D0 14004325 */  addiu      $v1, $t2, 0x14
    /* D3ED4 800E36D4 0000A28C */  lw         $v0, 0x0($a1)
    /* D3ED8 800E36D8 24204401 */  and        $a0, $t2, $a0
    /* D3EDC 800E36DC 0000E3AC */  sw         $v1, 0x0($a3)
    /* D3EE0 800E36E0 24104600 */  and        $v0, $v0, $a2
    /* D3EE4 800E36E4 25104400 */  or         $v0, $v0, $a0
    /* D3EE8 800E36E8 0000A2AC */  sw         $v0, 0x0($a1)
    /* D3EEC 800E36EC 04000224 */  addiu      $v0, $zero, 0x4
    /* D3EF0 800E36F0 030042A1 */  sb         $v0, 0x3($t2)
    /* D3EF4 800E36F4 0052023C */  lui        $v0, (0x52000000 >> 16)
    /* D3EF8 800E36F8 040042AD */  sw         $v0, 0x4($t2)
    /* D3EFC 800E36FC 10004225 */  addiu      $v0, $t2, 0x10
    /* D3F00 800E3700 0C0048AD */  sw         $t0, 0xC($t2)
    /* D3F04 800E3704 00004EE8 */  swc2       $14, 0x0($v0)
    /* D3F08 800E3708 1000428D */  lw         $v0, 0x10($t2)
    /* D3F0C 800E370C 00000000 */  nop
    /* D3F10 800E3710 080042AD */  sw         $v0, 0x8($t2)
  .L800E3714:
    /* D3F14 800E3714 01000224 */  addiu      $v0, $zero, 0x1
    /* D3F18 800E3718 0000A2A1 */  sb         $v0, 0x0($t5)
    /* D3F1C 800E371C 1000428D */  lw         $v0, 0x10($t2)
    /* D3F20 800E3720 00000000 */  nop
    /* D3F24 800E3724 000082AD */  sw         $v0, 0x0($t4)
    /* D3F28 800E3728 0800E003 */  jr         $ra
    /* D3F2C 800E372C 0800BD27 */   addiu     $sp, $sp, 0x8
endlabel Weather_CreateRain__FP7SVECTORP7DVECTORPc
