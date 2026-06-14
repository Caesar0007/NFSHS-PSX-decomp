.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Texture_InitMenuClut__Fv, 0x100

glabel Texture_InitMenuClut__Fv
    /* D0D10 800E0510 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* D0D14 800E0514 0580043C */  lui        $a0, %hi(D_80056A68)
    /* D0D18 800E0518 686A8424 */  addiu      $a0, $a0, %lo(D_80056A68)
    /* D0D1C 800E051C 00030524 */  addiu      $a1, $zero, 0x300
    /* D0D20 800E0520 1000BFAF */  sw         $ra, 0x10($sp)
    /* D0D24 800E0524 CF94030C */  jal        reservememadr
    /* D0D28 800E0528 21300000 */   addu      $a2, $zero, $zero
    /* D0D2C 800E052C 0580043C */  lui        $a0, %hi(D_80056A78)
    /* D0D30 800E0530 786A8424 */  addiu      $a0, $a0, %lo(D_80056A78)
    /* D0D34 800E0534 80110524 */  addiu      $a1, $zero, 0x1180
    /* D0D38 800E0538 E01582AF */  sw         $v0, %gp_rel(gFreePal4)($gp)
    /* D0D3C 800E053C CF94030C */  jal        reservememadr
    /* D0D40 800E0540 21300000 */   addu      $a2, $zero, $zero
    /* D0D44 800E0544 E015898F */  lw         $t1, %gp_rel(gFreePal4)($gp)
    /* D0D48 800E0548 21380000 */  addu       $a3, $zero, $zero
    /* D0D4C 800E054C E81582AF */  sw         $v0, %gp_rel(gFreePal8)($gp)
    /* D0D50 800E0550 E41580AF */  sw         $zero, %gp_rel(gNbFreePal4)($gp)
    /* D0D54 800E0554 21300000 */  addu       $a2, $zero, $zero
  .L800E0558:
    /* D0D58 800E0558 0002E224 */  addiu      $v0, $a3, 0x200
    /* D0D5C 800E055C 03110200 */  sra        $v0, $v0, 4
    /* D0D60 800E0560 3F004830 */  andi       $t0, $v0, 0x3F
    /* D0D64 800E0564 007A0524 */  addiu      $a1, $zero, 0x7A00
  .L800E0568:
    /* D0D68 800E0568 2520A800 */  or         $a0, $a1, $t0
    /* D0D6C 800E056C E415838F */  lw         $v1, %gp_rel(gNbFreePal4)($gp)
    /* D0D70 800E0570 0100C624 */  addiu      $a2, $a2, 0x1
    /* D0D74 800E0574 40100300 */  sll        $v0, $v1, 1
    /* D0D78 800E0578 01006324 */  addiu      $v1, $v1, 0x1
    /* D0D7C 800E057C 21104900 */  addu       $v0, $v0, $t1
    /* D0D80 800E0580 000044A4 */  sh         $a0, 0x0($v0)
    /* D0D84 800E0584 1800C228 */  slti       $v0, $a2, 0x18
    /* D0D88 800E0588 E41583AF */  sw         $v1, %gp_rel(gNbFreePal4)($gp)
    /* D0D8C 800E058C F6FF4014 */  bnez       $v0, .L800E0568
    /* D0D90 800E0590 4000A524 */   addiu     $a1, $a1, 0x40
    /* D0D94 800E0594 1000E724 */  addiu      $a3, $a3, 0x10
    /* D0D98 800E0598 0001E228 */  slti       $v0, $a3, 0x100
    /* D0D9C 800E059C EEFF4014 */  bnez       $v0, .L800E0558
    /* D0DA0 800E05A0 21300000 */   addu      $a2, $zero, $zero
    /* D0DA4 800E05A4 E815898F */  lw         $t1, %gp_rel(gFreePal8)($gp)
    /* D0DA8 800E05A8 21380000 */  addu       $a3, $zero, $zero
    /* D0DAC 800E05AC EC1580AF */  sw         $zero, %gp_rel(gNbFreePal8)($gp)
  .L800E05B0:
    /* D0DB0 800E05B0 21300000 */  addu       $a2, $zero, $zero
    /* D0DB4 800E05B4 0002E224 */  addiu      $v0, $a3, 0x200
    /* D0DB8 800E05B8 03110200 */  sra        $v0, $v0, 4
    /* D0DBC 800E05BC 3F004830 */  andi       $t0, $v0, 0x3F
    /* D0DC0 800E05C0 00570524 */  addiu      $a1, $zero, 0x5700
  .L800E05C4:
    /* D0DC4 800E05C4 2520A800 */  or         $a0, $a1, $t0
    /* D0DC8 800E05C8 EC15838F */  lw         $v1, %gp_rel(gNbFreePal8)($gp)
    /* D0DCC 800E05CC 0100C624 */  addiu      $a2, $a2, 0x1
    /* D0DD0 800E05D0 40100300 */  sll        $v0, $v1, 1
    /* D0DD4 800E05D4 01006324 */  addiu      $v1, $v1, 0x1
    /* D0DD8 800E05D8 21104900 */  addu       $v0, $v0, $t1
    /* D0DDC 800E05DC 000044A4 */  sh         $a0, 0x0($v0)
    /* D0DE0 800E05E0 8C00C228 */  slti       $v0, $a2, 0x8C
    /* D0DE4 800E05E4 EC1583AF */  sw         $v1, %gp_rel(gNbFreePal8)($gp)
    /* D0DE8 800E05E8 F6FF4014 */  bnez       $v0, .L800E05C4
    /* D0DEC 800E05EC 4000A524 */   addiu     $a1, $a1, 0x40
    /* D0DF0 800E05F0 0001E724 */  addiu      $a3, $a3, 0x100
    /* D0DF4 800E05F4 0001E228 */  slti       $v0, $a3, 0x100
    /* D0DF8 800E05F8 EDFF4014 */  bnez       $v0, .L800E05B0
    /* D0DFC 800E05FC 00000000 */   nop
    /* D0E00 800E0600 1000BF8F */  lw         $ra, 0x10($sp)
    /* D0E04 800E0604 00000000 */  nop
    /* D0E08 800E0608 0800E003 */  jr         $ra
    /* D0E0C 800E060C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Texture_InitMenuClut__Fv
