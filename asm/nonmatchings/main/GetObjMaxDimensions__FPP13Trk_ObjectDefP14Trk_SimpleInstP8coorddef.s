.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetObjMaxDimensions__FPP13Trk_ObjectDefP14Trk_SimpleInstP8coorddef, 0x178

glabel GetObjMaxDimensions__FPP13Trk_ObjectDefP14Trk_SimpleInstP8coorddef
    /* 96558 800A5D58 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 9655C 800A5D5C 2400B1AF */  sw         $s1, 0x24($sp)
    /* 96560 800A5D60 2188C000 */  addu       $s1, $a2, $zero
    /* 96564 800A5D64 2800BFAF */  sw         $ra, 0x28($sp)
    /* 96568 800A5D68 2000B0AF */  sw         $s0, 0x20($sp)
    /* 9656C 800A5D6C 0600A284 */  lh         $v0, 0x6($a1)
    /* 96570 800A5D70 21280000 */  addu       $a1, $zero, $zero
    /* 96574 800A5D74 08000624 */  addiu      $a2, $zero, 0x8
    /* 96578 800A5D78 80100200 */  sll        $v0, $v0, 2
    /* 9657C 800A5D7C 21104400 */  addu       $v0, $v0, $a0
    /* 96580 800A5D80 0000508C */  lw         $s0, 0x0($v0)
    /* 96584 800A5D84 C690030C */  jal        memset
    /* 96588 800A5D88 1000A427 */   addiu     $a0, $sp, 0x10
    /* 9658C 800A5D8C 1800A427 */  addiu      $a0, $sp, 0x18
    /* 96590 800A5D90 21280000 */  addu       $a1, $zero, $zero
    /* 96594 800A5D94 C690030C */  jal        memset
    /* 96598 800A5D98 08000624 */   addiu     $a2, $zero, 0x8
    /* 9659C 800A5D9C FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 965A0 800A5DA0 02000692 */  lbu        $a2, 0x2($s0)
    /* 965A4 800A5DA4 00000000 */  nop
    /* 965A8 800A5DA8 FFFFC624 */  addiu      $a2, $a2, -0x1
    /* 965AC 800A5DAC 3100C210 */  beq        $a2, $v0, .L800A5E74
    /* 965B0 800A5DB0 04000726 */   addiu     $a3, $s0, 0x4
    /* 965B4 800A5DB4 21404000 */  addu       $t0, $v0, $zero
    /* 965B8 800A5DB8 08000526 */  addiu      $a1, $s0, 0x8
  .L800A5DBC:
    /* 965BC 800A5DBC 0000E484 */  lh         $a0, 0x0($a3)
    /* 965C0 800A5DC0 1800A287 */  lh         $v0, 0x18($sp)
    /* 965C4 800A5DC4 0000E394 */  lhu        $v1, 0x0($a3)
    /* 965C8 800A5DC8 2A104400 */  slt        $v0, $v0, $a0
    /* 965CC 800A5DCC 03004010 */  beqz       $v0, .L800A5DDC
    /* 965D0 800A5DD0 00000000 */   nop
    /* 965D4 800A5DD4 7D970208 */  j          .L800A5DF4
    /* 965D8 800A5DD8 1800A3A7 */   sh        $v1, 0x18($sp)
  .L800A5DDC:
    /* 965DC 800A5DDC 1000A287 */  lh         $v0, 0x10($sp)
    /* 965E0 800A5DE0 00000000 */  nop
    /* 965E4 800A5DE4 2A108200 */  slt        $v0, $a0, $v0
    /* 965E8 800A5DE8 02004010 */  beqz       $v0, .L800A5DF4
    /* 965EC 800A5DEC 00000000 */   nop
    /* 965F0 800A5DF0 1000A3A7 */  sh         $v1, 0x10($sp)
  .L800A5DF4:
    /* 965F4 800A5DF4 FEFFA484 */  lh         $a0, -0x2($a1)
    /* 965F8 800A5DF8 1A00A287 */  lh         $v0, 0x1A($sp)
    /* 965FC 800A5DFC FEFFA394 */  lhu        $v1, -0x2($a1)
    /* 96600 800A5E00 2A104400 */  slt        $v0, $v0, $a0
    /* 96604 800A5E04 03004010 */  beqz       $v0, .L800A5E14
    /* 96608 800A5E08 00000000 */   nop
    /* 9660C 800A5E0C 8B970208 */  j          .L800A5E2C
    /* 96610 800A5E10 1A00A3A7 */   sh        $v1, 0x1A($sp)
  .L800A5E14:
    /* 96614 800A5E14 1200A287 */  lh         $v0, 0x12($sp)
    /* 96618 800A5E18 00000000 */  nop
    /* 9661C 800A5E1C 2A108200 */  slt        $v0, $a0, $v0
    /* 96620 800A5E20 02004010 */  beqz       $v0, .L800A5E2C
    /* 96624 800A5E24 00000000 */   nop
    /* 96628 800A5E28 1200A3A7 */  sh         $v1, 0x12($sp)
  .L800A5E2C:
    /* 9662C 800A5E2C 0000A484 */  lh         $a0, 0x0($a1)
    /* 96630 800A5E30 1C00A287 */  lh         $v0, 0x1C($sp)
    /* 96634 800A5E34 0000A394 */  lhu        $v1, 0x0($a1)
    /* 96638 800A5E38 2A104400 */  slt        $v0, $v0, $a0
    /* 9663C 800A5E3C 03004010 */  beqz       $v0, .L800A5E4C
    /* 96640 800A5E40 00000000 */   nop
    /* 96644 800A5E44 99970208 */  j          .L800A5E64
    /* 96648 800A5E48 1C00A3A7 */   sh        $v1, 0x1C($sp)
  .L800A5E4C:
    /* 9664C 800A5E4C 1400A287 */  lh         $v0, 0x14($sp)
    /* 96650 800A5E50 00000000 */  nop
    /* 96654 800A5E54 2A108200 */  slt        $v0, $a0, $v0
    /* 96658 800A5E58 02004010 */  beqz       $v0, .L800A5E64
    /* 9665C 800A5E5C 00000000 */   nop
    /* 96660 800A5E60 1400A3A7 */  sh         $v1, 0x14($sp)
  .L800A5E64:
    /* 96664 800A5E64 0800A524 */  addiu      $a1, $a1, 0x8
    /* 96668 800A5E68 FFFFC624 */  addiu      $a2, $a2, -0x1
    /* 9666C 800A5E6C D3FFC814 */  bne        $a2, $t0, .L800A5DBC
    /* 96670 800A5E70 0800E724 */   addiu     $a3, $a3, 0x8
  .L800A5E74:
    /* 96674 800A5E74 1800A287 */  lh         $v0, 0x18($sp)
    /* 96678 800A5E78 1000A387 */  lh         $v1, 0x10($sp)
    /* 9667C 800A5E7C 00000000 */  nop
    /* 96680 800A5E80 23104300 */  subu       $v0, $v0, $v1
    /* 96684 800A5E84 40120200 */  sll        $v0, $v0, 9
    /* 96688 800A5E88 000022AE */  sw         $v0, 0x0($s1)
    /* 9668C 800A5E8C 1A00A287 */  lh         $v0, 0x1A($sp)
    /* 96690 800A5E90 1200A387 */  lh         $v1, 0x12($sp)
    /* 96694 800A5E94 00000000 */  nop
    /* 96698 800A5E98 23104300 */  subu       $v0, $v0, $v1
    /* 9669C 800A5E9C 40120200 */  sll        $v0, $v0, 9
    /* 966A0 800A5EA0 040022AE */  sw         $v0, 0x4($s1)
    /* 966A4 800A5EA4 1C00A287 */  lh         $v0, 0x1C($sp)
    /* 966A8 800A5EA8 1400A387 */  lh         $v1, 0x14($sp)
    /* 966AC 800A5EAC 00000000 */  nop
    /* 966B0 800A5EB0 23104300 */  subu       $v0, $v0, $v1
    /* 966B4 800A5EB4 40120200 */  sll        $v0, $v0, 9
    /* 966B8 800A5EB8 080022AE */  sw         $v0, 0x8($s1)
    /* 966BC 800A5EBC 2800BF8F */  lw         $ra, 0x28($sp)
    /* 966C0 800A5EC0 2400B18F */  lw         $s1, 0x24($sp)
    /* 966C4 800A5EC4 2000B08F */  lw         $s0, 0x20($sp)
    /* 966C8 800A5EC8 0800E003 */  jr         $ra
    /* 966CC 800A5ECC 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel GetObjMaxDimensions__FPP13Trk_ObjectDefP14Trk_SimpleInstP8coorddef
