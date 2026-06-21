.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_80013F98, 0x7C

glabel func_80013F98
    /* 4798 80013F98 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 479C 80013F9C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 47A0 80013FA0 21800000 */  addu       $s0, $zero, $zero
    /* 47A4 80013FA4 1800B2AF */  sw         $s2, 0x18($sp)
    /* 47A8 80013FA8 0580123C */  lui        $s2, %hi(gHelpShapes)
    /* 47AC 80013FAC 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 47B0 80013FB0 1400B1AF */  sw         $s1, 0x14($sp)
  .L80013FB4:
    /* 47B4 80013FB4 642A428E */  lw         $v0, %lo(gHelpShapes)($s2)
    /* 47B8 80013FB8 40891000 */  sll        $s1, $s0, 5
    /* 47BC 80013FBC 21182202 */  addu       $v1, $s1, $v0
    /* 47C0 80013FC0 0400628C */  lw         $v0, 0x4($v1)
    /* 47C4 80013FC4 00000000 */  nop
    /* 47C8 80013FC8 08004010 */  beqz       $v0, .L80013FEC
    /* 47CC 80013FCC 00000000 */   nop
    /* 47D0 80013FD0 04006484 */  lh         $a0, 0x4($v1)
    /* 47D4 80013FD4 697E030C */  jal        Texture_MenuReleaseClutId__Fs
    /* 47D8 80013FD8 00000000 */   nop
    /* 47DC 80013FDC 642A428E */  lw         $v0, %lo(gHelpShapes)($s2)
    /* 47E0 80013FE0 00000000 */  nop
    /* 47E4 80013FE4 21102202 */  addu       $v0, $s1, $v0
    /* 47E8 80013FE8 040040AC */  sw         $zero, 0x4($v0)
  .L80013FEC:
    /* 47EC 80013FEC 01001026 */  addiu      $s0, $s0, 0x1
    /* 47F0 80013FF0 3B00022A */  slti       $v0, $s0, 0x3B
    /* 47F4 80013FF4 EFFF4014 */  bnez       $v0, .L80013FB4
    /* 47F8 80013FF8 00000000 */   nop
    /* 47FC 80013FFC 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 4800 80014000 1800B28F */  lw         $s2, 0x18($sp)
    /* 4804 80014004 1400B18F */  lw         $s1, 0x14($sp)
    /* 4808 80014008 1000B08F */  lw         $s0, 0x10($sp)
    /* 480C 8001400C 0800E003 */  jr         $ra
    /* 4810 80014010 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel func_80013F98
