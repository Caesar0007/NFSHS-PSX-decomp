.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _gpu_init_videomode, 0xA0

glabel _gpu_init_videomode
    /* E0470 800EFC70 0010033C */  lui        $v1, (0x10000007 >> 16)
    /* E0474 800EFC74 1280023C */  lui        $v0, %hi(D_801237A4)
    /* E0478 800EFC78 A437428C */  lw         $v0, %lo(D_801237A4)($v0)
    /* E047C 800EFC7C 07006334 */  ori        $v1, $v1, (0x10000007 & 0xFFFF)
    /* E0480 800EFC80 000043AC */  sw         $v1, 0x0($v0)
    /* E0484 800EFC84 1280053C */  lui        $a1, %hi(D_801237A0)
    /* E0488 800EFC88 A037A58C */  lw         $a1, %lo(D_801237A0)($a1)
    /* E048C 800EFC8C FF00033C */  lui        $v1, (0xFFFFFF >> 16)
    /* E0490 800EFC90 0000A28C */  lw         $v0, 0x0($a1)
    /* E0494 800EFC94 FFFF6334 */  ori        $v1, $v1, (0xFFFFFF & 0xFFFF)
    /* E0498 800EFC98 24104300 */  and        $v0, $v0, $v1
    /* E049C 800EFC9C 02000324 */  addiu      $v1, $zero, 0x2
    /* E04A0 800EFCA0 0F004310 */  beq        $v0, $v1, .L800EFCE0
    /* E04A4 800EFCA4 00E1033C */   lui       $v1, (0xE1001000 >> 16)
    /* E04A8 800EFCA8 1280023C */  lui        $v0, %hi(D_801237A4)
    /* E04AC 800EFCAC A437428C */  lw         $v0, %lo(D_801237A4)($v0)
    /* E04B0 800EFCB0 00000000 */  nop
    /* E04B4 800EFCB4 0000428C */  lw         $v0, 0x0($v0)
    /* E04B8 800EFCB8 00106334 */  ori        $v1, $v1, (0xE1001000 & 0xFFFF)
    /* E04BC 800EFCBC FF3F4230 */  andi       $v0, $v0, 0x3FFF
    /* E04C0 800EFCC0 25104300 */  or         $v0, $v0, $v1
    /* E04C4 800EFCC4 0000A2AC */  sw         $v0, 0x0($a1)
    /* E04C8 800EFCC8 1280033C */  lui        $v1, %hi(D_801237A0)
    /* E04CC 800EFCCC A037638C */  lw         $v1, %lo(D_801237A0)($v1)
    /* E04D0 800EFCD0 21100000 */  addu       $v0, $zero, $zero
    /* E04D4 800EFCD4 0000638C */  lw         $v1, 0x0($v1)
    /* E04D8 800EFCD8 42BF0308 */  j          .L800EFD08
    /* E04DC 800EFCDC 00000000 */   nop
  .L800EFCE0:
    /* E04E0 800EFCE0 08008230 */  andi       $v0, $a0, 0x8
    /* E04E4 800EFCE4 07004010 */  beqz       $v0, .L800EFD04
    /* E04E8 800EFCE8 0009043C */   lui       $a0, (0x9000001 >> 16)
    /* E04EC 800EFCEC 01008434 */  ori        $a0, $a0, (0x9000001 & 0xFFFF)
    /* E04F0 800EFCF0 1280033C */  lui        $v1, %hi(D_801237A4)
    /* E04F4 800EFCF4 A437638C */  lw         $v1, %lo(D_801237A4)($v1)
    /* E04F8 800EFCF8 02000224 */  addiu      $v0, $zero, 0x2
    /* E04FC 800EFCFC 42BF0308 */  j          .L800EFD08
    /* E0500 800EFD00 000064AC */   sw        $a0, 0x0($v1)
  .L800EFD04:
    /* E0504 800EFD04 01000224 */  addiu      $v0, $zero, 0x1
  .L800EFD08:
    /* E0508 800EFD08 0800E003 */  jr         $ra
    /* E050C 800EFD0C 00000000 */   nop
endlabel _gpu_init_videomode
