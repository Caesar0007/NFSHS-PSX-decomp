.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching PreLoad__17tScreenTrophyRoom, 0x68

glabel PreLoad__17tScreenTrophyRoom
    /* 310A8 800408A8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 310AC 800408AC 1000B0AF */  sw         $s0, 0x10($sp)
    /* 310B0 800408B0 1400BFAF */  sw         $ra, 0x14($sp)
    /* 310B4 800408B4 E099000C */  jal        PreLoad__7tScreen
    /* 310B8 800408B8 21808000 */   addu      $s0, $a0, $zero
    /* 310BC 800408BC 21200002 */  addu       $a0, $s0, $zero
    /* 310C0 800408C0 64000526 */  addiu      $a1, $s0, 0x64
    /* 310C4 800408C4 08000624 */  addiu      $a2, $zero, 0x8
    /* 310C8 800408C8 FB98000C */  jal        InitializeShapes__7tScreenR17tShapeInformationUi
    /* 310CC 800408CC 640000AE */   sw        $zero, 0x64($s0)
    /* 310D0 800408D0 1180023C */  lui        $v0, %hi(D_80114722)
    /* 310D4 800408D4 22474290 */  lbu        $v0, %lo(D_80114722)($v0)
    /* 310D8 800408D8 00000000 */  nop
    /* 310DC 800408DC 03004010 */  beqz       $v0, .L800408EC
    /* 310E0 800408E0 0180023C */   lui       $v0, %hi(D_80011E14)
    /* 310E4 800408E4 3D020108 */  j          .L800408F4
    /* 310E8 800408E8 141E4524 */   addiu     $a1, $v0, %lo(D_80011E14)
  .L800408EC:
    /* 310EC 800408EC 0180023C */  lui        $v0, %hi(D_80011E1C)
    /* 310F0 800408F0 1C1E4524 */  addiu      $a1, $v0, %lo(D_80011E1C)
  .L800408F4:
    /* 310F4 800408F4 21200002 */  addu       $a0, $s0, $zero
    /* 310F8 800408F8 9098000C */  jal        AsyncLoadShapeFile__7tScreenPcR17tShapeInformation
    /* 310FC 800408FC 64008624 */   addiu     $a2, $a0, 0x64
    /* 31100 80040900 1400BF8F */  lw         $ra, 0x14($sp)
    /* 31104 80040904 1000B08F */  lw         $s0, 0x10($sp)
    /* 31108 80040908 0800E003 */  jr         $ra
    /* 3110C 8004090C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel PreLoad__17tScreenTrophyRoom
