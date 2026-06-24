.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hud_BuildCdPlayer__Fii, 0x76C

glabel Hud_BuildCdPlayer__Fii
    /* C6BDC 800D63DC B818828F */  lw         $v0, %gp_rel(D_8013DE04)($gp)
    /* C6BE0 800D63E0 38FFBD27 */  addiu      $sp, $sp, -0xC8
    /* C6BE4 800D63E4 B800B6AF */  sw         $s6, 0xB8($sp)
    /* C6BE8 800D63E8 21B08000 */  addu       $s6, $a0, $zero
    /* C6BEC 800D63EC C400BFAF */  sw         $ra, 0xC4($sp)
    /* C6BF0 800D63F0 C000BEAF */  sw         $fp, 0xC0($sp)
    /* C6BF4 800D63F4 BC00B7AF */  sw         $s7, 0xBC($sp)
    /* C6BF8 800D63F8 B400B5AF */  sw         $s5, 0xB4($sp)
    /* C6BFC 800D63FC B000B4AF */  sw         $s4, 0xB0($sp)
    /* C6C00 800D6400 AC00B3AF */  sw         $s3, 0xAC($sp)
    /* C6C04 800D6404 A800B2AF */  sw         $s2, 0xA8($sp)
    /* C6C08 800D6408 A400B1AF */  sw         $s1, 0xA4($sp)
    /* C6C0C 800D640C A000B0AF */  sw         $s0, 0xA0($sp)
    /* C6C10 800D6410 3C004384 */  lh         $v1, 0x3C($v0)
    /* C6C14 800D6414 3E004284 */  lh         $v0, 0x3E($v0)
    /* C6C18 800D6418 02007724 */  addiu      $s7, $v1, 0x2
    /* C6C1C 800D641C 0300C016 */  bnez       $s6, .L800D642C
    /* C6C20 800D6420 02005E24 */   addiu     $fp, $v0, 0x2
    /* C6C24 800D6424 01000224 */  addiu      $v0, $zero, 0x1
    /* C6C28 800D6428 B41382AF */  sw         $v0, %gp_rel(D_8013D900)($gp)
  .L800D642C:
    /* C6C2C 800D642C 21980000 */  addu       $s3, $zero, $zero
    /* C6C30 800D6430 0AE8010C */  jal        AudioMus_GetCurrentSong__Fv
    /* C6C34 800D6434 9900A0A3 */   sb        $zero, 0x99($sp)
    /* C6C38 800D6438 21904000 */  addu       $s2, $v0, $zero
    /* C6C3C 800D643C B6014012 */  beqz       $s2, .L800D6B18
    /* C6C40 800D6440 00000000 */   nop
    /* C6C44 800D6444 E013828F */  lw         $v0, %gp_rel(Hud_gCdActive)($gp)
    /* C6C48 800D6448 00000000 */  nop
    /* C6C4C 800D644C 4E004014 */  bnez       $v0, .L800D6588
    /* C6C50 800D6450 1280023C */   lui       $v0, %hi(D_8011E0B0)
    /* C6C54 800D6454 B0E0428C */  lw         $v0, %lo(D_8011E0B0)($v0)
    /* C6C58 800D6458 00000000 */  nop
    /* C6C5C 800D645C 40024228 */  slti       $v0, $v0, 0x240
    /* C6C60 800D6460 21004014 */  bnez       $v0, .L800D64E8
    /* C6C64 800D6464 21806002 */   addu      $s0, $s3, $zero
    /* C6C68 800D6468 1480023C */  lui        $v0, %hi(countdown)
    /* C6C6C 800D646C 3CC64290 */  lbu        $v0, %lo(countdown)($v0)
    /* C6C70 800D6470 00000000 */  nop
    /* C6C74 800D6474 0400422C */  sltiu      $v0, $v0, 0x4
    /* C6C78 800D6478 05004010 */  beqz       $v0, .L800D6490
    /* C6C7C 800D647C 00000000 */   nop
    /* C6C80 800D6480 F013828F */  lw         $v0, %gp_rel(Hud_BeTheCop)($gp)
    /* C6C84 800D6484 00000000 */  nop
    /* C6C88 800D6488 17004010 */  beqz       $v0, .L800D64E8
    /* C6C8C 800D648C 00000000 */   nop
  .L800D6490:
    /* C6C90 800D6490 6B90030C */  jal        PAD_state
    /* C6C94 800D6494 04000424 */   addiu     $a0, $zero, 0x4
    /* C6C98 800D6498 00044230 */  andi       $v0, $v0, 0x400
    /* C6C9C 800D649C 05004010 */  beqz       $v0, .L800D64B4
    /* C6CA0 800D64A0 1180023C */   lui       $v0, %hi(DashHUD_gInfo)
    /* C6CA4 800D64A4 3027428C */  lw         $v0, %lo(DashHUD_gInfo)($v0)
    /* C6CA8 800D64A8 00000000 */  nop
    /* C6CAC 800D64AC 0E004014 */  bnez       $v0, .L800D64E8
    /* C6CB0 800D64B0 00000000 */   nop
  .L800D64B4:
    /* C6CB4 800D64B4 6B90030C */  jal        PAD_state
    /* C6CB8 800D64B8 21200000 */   addu      $a0, $zero, $zero
    /* C6CBC 800D64BC 00044230 */  andi       $v0, $v0, 0x400
    /* C6CC0 800D64C0 0A004010 */  beqz       $v0, .L800D64EC
    /* C6CC4 800D64C4 00000000 */   nop
    /* C6CC8 800D64C8 F013828F */  lw         $v0, %gp_rel(Hud_BeTheCop)($gp)
    /* C6CCC 800D64CC 00000000 */  nop
    /* C6CD0 800D64D0 05004010 */  beqz       $v0, .L800D64E8
    /* C6CD4 800D64D4 1180023C */   lui       $v0, %hi(DashHUD_gInfo)
    /* C6CD8 800D64D8 3027428C */  lw         $v0, %lo(DashHUD_gInfo)($v0)
    /* C6CDC 800D64DC 00000000 */  nop
    /* C6CE0 800D64E0 02004010 */  beqz       $v0, .L800D64EC
    /* C6CE4 800D64E4 00000000 */   nop
  .L800D64E8:
    /* C6CE8 800D64E8 01001024 */  addiu      $s0, $zero, 0x1
  .L800D64EC:
    /* C6CEC 800D64EC 24000016 */  bnez       $s0, .L800D6580
    /* C6CF0 800D64F0 01000224 */   addiu     $v0, $zero, 0x1
    /* C6CF4 800D64F4 1480023C */  lui        $v0, %hi(gPadinfo)
    /* C6CF8 800D64F8 9CE84424 */  addiu      $a0, $v0, %lo(gPadinfo)
    /* C6CFC 800D64FC 05008390 */  lbu        $v1, 0x5($a0)
    /* C6D00 800D6500 23000224 */  addiu      $v0, $zero, 0x23
    /* C6D04 800D6504 0F006214 */  bne        $v1, $v0, .L800D6544
    /* C6D08 800D6508 1480023C */   lui       $v0, %hi(gPadinfo)
    /* C6D0C 800D650C 0B008290 */  lbu        $v0, 0xB($a0)
    /* C6D10 800D6510 00000000 */  nop
    /* C6D14 800D6514 C000422C */  sltiu      $v0, $v0, 0xC0
    /* C6D18 800D6518 0A004014 */  bnez       $v0, .L800D6544
    /* C6D1C 800D651C 1480023C */   lui       $v0, %hi(gPadinfo)
    /* C6D20 800D6520 F013828F */  lw         $v0, %gp_rel(Hud_BeTheCop)($gp)
    /* C6D24 800D6524 00000000 */  nop
    /* C6D28 800D6528 14004010 */  beqz       $v0, .L800D657C
    /* C6D2C 800D652C 1180023C */   lui       $v0, %hi(DashHUD_gInfo)
    /* C6D30 800D6530 3027428C */  lw         $v0, %lo(DashHUD_gInfo)($v0)
    /* C6D34 800D6534 00000000 */  nop
    /* C6D38 800D6538 11004014 */  bnez       $v0, .L800D6580
    /* C6D3C 800D653C 01000224 */   addiu     $v0, $zero, 0x1
    /* C6D40 800D6540 1480023C */  lui        $v0, %hi(gPadinfo)
  .L800D6544:
    /* C6D44 800D6544 9CE84424 */  addiu      $a0, $v0, %lo(gPadinfo)
    /* C6D48 800D6548 25008390 */  lbu        $v1, 0x25($a0)
    /* C6D4C 800D654C 23000224 */  addiu      $v0, $zero, 0x23
    /* C6D50 800D6550 0D006214 */  bne        $v1, $v0, .L800D6588
    /* C6D54 800D6554 00000000 */   nop
    /* C6D58 800D6558 2B008290 */  lbu        $v0, 0x2B($a0)
    /* C6D5C 800D655C 00000000 */  nop
    /* C6D60 800D6560 C000422C */  sltiu      $v0, $v0, 0xC0
    /* C6D64 800D6564 08004014 */  bnez       $v0, .L800D6588
    /* C6D68 800D6568 1180023C */   lui       $v0, %hi(DashHUD_gInfo)
    /* C6D6C 800D656C 3027428C */  lw         $v0, %lo(DashHUD_gInfo)($v0)
    /* C6D70 800D6570 00000000 */  nop
    /* C6D74 800D6574 04004010 */  beqz       $v0, .L800D6588
    /* C6D78 800D6578 00000000 */   nop
  .L800D657C:
    /* C6D7C 800D657C 01000224 */  addiu      $v0, $zero, 0x1
  .L800D6580:
    /* C6D80 800D6580 E01382AF */  sw         $v0, %gp_rel(Hud_gCdActive)($gp)
    /* C6D84 800D6584 E41382AF */  sw         $v0, %gp_rel(Hud_ActivateCDPlayer)($gp)
  .L800D6588:
    /* C6D88 800D6588 E413828F */  lw         $v0, %gp_rel(Hud_ActivateCDPlayer)($gp)
    /* C6D8C 800D658C 00000000 */  nop
    /* C6D90 800D6590 12004010 */  beqz       $v0, .L800D65DC
    /* C6D94 800D6594 00000000 */   nop
    /* C6D98 800D6598 F013828F */  lw         $v0, %gp_rel(Hud_BeTheCop)($gp)
    /* C6D9C 800D659C 00000000 */  nop
    /* C6DA0 800D65A0 02004010 */  beqz       $v0, .L800D65AC
    /* C6DA4 800D65A4 01000224 */   addiu     $v0, $zero, 0x1
    /* C6DA8 800D65A8 E01382AF */  sw         $v0, %gp_rel(Hud_gCdActive)($gp)
  .L800D65AC:
    /* C6DAC 800D65AC 1480023C */  lui        $v0, %hi(ticks)
    /* C6DB0 800D65B0 ACDC428C */  lw         $v0, %lo(ticks)($v0)
    /* C6DB4 800D65B4 01000324 */  addiu      $v1, $zero, 0x1
    /* C6DB8 800D65B8 E41380AF */  sw         $zero, %gp_rel(Hud_ActivateCDPlayer)($gp)
    /* C6DBC 800D65BC 3C1483AF */  sw         $v1, %gp_rel(Hud_gCdScrollTitle)($gp)
    /* C6DC0 800D65C0 381482AF */  sw         $v0, %gp_rel(Hud_gCdLastTick)($gp)
    /* C6DC4 800D65C4 0400C016 */  bnez       $s6, .L800D65D8
    /* C6DC8 800D65C8 00000000 */   nop
    /* C6DCC 800D65CC B41383AF */  sw         $v1, %gp_rel(D_8013D900)($gp)
    /* C6DD0 800D65D0 77590308 */  j          .L800D65DC
    /* C6DD4 800D65D4 00000000 */   nop
  .L800D65D8:
    /* C6DD8 800D65D8 B41380AF */  sw         $zero, %gp_rel(D_8013D900)($gp)
  .L800D65DC:
    /* C6DDC 800D65DC B413828F */  lw         $v0, %gp_rel(D_8013D900)($gp)
    /* C6DE0 800D65E0 00000000 */  nop
    /* C6DE4 800D65E4 02004010 */  beqz       $v0, .L800D65F0
    /* C6DE8 800D65E8 00000000 */   nop
    /* C6DEC 800D65EC 21B00000 */  addu       $s6, $zero, $zero
  .L800D65F0:
    /* C6DF0 800D65F0 0800558E */  lw         $s5, 0x8($s2)
    /* C6DF4 800D65F4 1000468E */  lw         $a2, 0x10($s2)
    /* C6DF8 800D65F8 0400548E */  lw         $s4, 0x4($s2)
    /* C6DFC 800D65FC 0700C010 */  beqz       $a2, .L800D661C
    /* C6E00 800D6600 6800B027 */   addiu     $s0, $sp, 0x68
    /* C6E04 800D6604 21200002 */  addu       $a0, $s0, $zero
    /* C6E08 800D6608 1480053C */  lui        $a1, %hi(D_8013D904)
    /* C6E0C 800D660C 2F91030C */  jal        sprintf
    /* C6E10 800D6610 04D9A524 */   addiu     $a1, $a1, %lo(D_8013D904)
    /* C6E14 800D6614 88590308 */  j          .L800D6620
    /* C6E18 800D6618 21880002 */   addu      $s1, $s0, $zero
  .L800D661C:
    /* C6E1C 800D661C 21880000 */  addu       $s1, $zero, $zero
  .L800D6620:
    /* C6E20 800D6620 1400468E */  lw         $a2, 0x14($s2)
    /* C6E24 800D6624 00000000 */  nop
    /* C6E28 800D6628 0700C010 */  beqz       $a2, .L800D6648
    /* C6E2C 800D662C 4800B027 */   addiu     $s0, $sp, 0x48
    /* C6E30 800D6630 21200002 */  addu       $a0, $s0, $zero
    /* C6E34 800D6634 1480053C */  lui        $a1, %hi(D_8013D904)
    /* C6E38 800D6638 2F91030C */  jal        sprintf
    /* C6E3C 800D663C 04D9A524 */   addiu     $a1, $a1, %lo(D_8013D904)
    /* C6E40 800D6640 93590308 */  j          .L800D664C
    /* C6E44 800D6644 00000000 */   nop
  .L800D6648:
    /* C6E48 800D6648 21800000 */  addu       $s0, $zero, $zero
  .L800D664C:
    /* C6E4C 800D664C 914A030C */  jal        uppercase__FPc
    /* C6E50 800D6650 21202002 */   addu      $a0, $s1, $zero
    /* C6E54 800D6654 0500C016 */  bnez       $s6, .L800D666C
    /* C6E58 800D6658 00000000 */   nop
    /* C6E5C 800D665C 03000012 */  beqz       $s0, .L800D666C
    /* C6E60 800D6660 00000000 */   nop
    /* C6E64 800D6664 914A030C */  jal        uppercase__FPc
    /* C6E68 800D6668 21200002 */   addu      $a0, $s0, $zero
  .L800D666C:
    /* C6E6C 800D666C E013828F */  lw         $v0, %gp_rel(Hud_gCdActive)($gp)
    /* C6E70 800D6670 00000000 */  nop
    /* C6E74 800D6674 04004014 */  bnez       $v0, .L800D6688
    /* C6E78 800D6678 01000224 */   addiu     $v0, $zero, 0x1
    /* C6E7C 800D667C F41382AF */  sw         $v0, %gp_rel(Hud_kTurnSongOffNext)($gp)
    /* C6E80 800D6680 C65A0308 */  j          .L800D6B18
    /* C6E84 800D6684 00000000 */   nop
  .L800D6688:
    /* C6E88 800D6688 0E00801A */  blez       $s4, .L800D66C4
    /* C6E8C 800D668C 2000A427 */   addiu     $a0, $sp, 0x20
    /* C6E90 800D6690 1480053C */  lui        $a1, %hi(D_8013D908)
    /* C6E94 800D6694 08D9A524 */  addiu      $a1, $a1, %lo(D_8013D908)
    /* C6E98 800D6698 2F91030C */  jal        sprintf
    /* C6E9C 800D669C 21308002 */   addu      $a2, $s4, $zero
    /* C6EA0 800D66A0 22002016 */  bnez       $s1, .L800D672C
    /* C6EA4 800D66A4 21202002 */   addu      $a0, $s1, $zero
    /* C6EA8 800D66A8 1480033C */  lui        $v1, %hi(ticks)
    /* C6EAC 800D66AC ACDC638C */  lw         $v1, %lo(ticks)($v1)
    /* C6EB0 800D66B0 01000224 */  addiu      $v0, $zero, 0x1
    /* C6EB4 800D66B4 3C1482AF */  sw         $v0, %gp_rel(Hud_gCdScrollTitle)($gp)
    /* C6EB8 800D66B8 381483AF */  sw         $v1, %gp_rel(Hud_gCdLastTick)($gp)
    /* C6EBC 800D66BC C9590308 */  j          .L800D6724
    /* C6EC0 800D66C0 00000000 */   nop
  .L800D66C4:
    /* C6EC4 800D66C4 07008016 */  bnez       $s4, .L800D66E4
    /* C6EC8 800D66C8 FEFF0224 */   addiu     $v0, $zero, -0x2
    /* C6ECC 800D66CC 2000A427 */  addiu      $a0, $sp, 0x20
    /* C6ED0 800D66D0 1480053C */  lui        $a1, %hi(D_8013D910)
    /* C6ED4 800D66D4 2F91030C */  jal        sprintf
    /* C6ED8 800D66D8 10D9A524 */   addiu     $a1, $a1, %lo(D_8013D910)
    /* C6EDC 800D66DC C6590308 */  j          .L800D6718
    /* C6EE0 800D66E0 44000424 */   addiu     $a0, $zero, 0x44
  .L800D66E4:
    /* C6EE4 800D66E4 06008216 */  bne        $s4, $v0, .L800D6700
    /* C6EE8 800D66E8 1480053C */   lui       $a1, %hi(D_8013D910)
    /* C6EEC 800D66EC 2000A427 */  addiu      $a0, $sp, 0x20
    /* C6EF0 800D66F0 2F91030C */  jal        sprintf
    /* C6EF4 800D66F4 10D9A524 */   addiu     $a1, $a1, %lo(D_8013D910)
    /* C6EF8 800D66F8 C6590308 */  j          .L800D6718
    /* C6EFC 800D66FC 45000424 */   addiu     $a0, $zero, 0x45
  .L800D6700:
    /* C6F00 800D6700 2000A427 */  addiu      $a0, $sp, 0x20
    /* C6F04 800D6704 2F91030C */  jal        sprintf
    /* C6F08 800D6708 10D9A524 */   addiu     $a1, $a1, %lo(D_8013D910)
    /* C6F0C 800D670C 05002016 */  bnez       $s1, .L800D6724
    /* C6F10 800D6710 21800000 */   addu      $s0, $zero, $zero
    /* C6F14 800D6714 46000424 */  addiu      $a0, $zero, 0x46
  .L800D6718:
    /* C6F18 800D6718 94E4020C */  jal        TextSys_Word__Fi
    /* C6F1C 800D671C 21800000 */   addu      $s0, $zero, $zero
    /* C6F20 800D6720 21884000 */  addu       $s1, $v0, $zero
  .L800D6724:
    /* C6F24 800D6724 5B002012 */  beqz       $s1, .L800D6894
    /* C6F28 800D6728 21202002 */   addu      $a0, $s1, $zero
  .L800D672C:
    /* C6F2C 800D672C 21280000 */  addu       $a1, $zero, $zero
    /* C6F30 800D6730 2130A000 */  addu       $a2, $a1, $zero
    /* C6F34 800D6734 2138A000 */  addu       $a3, $a1, $zero
    /* C6F38 800D6738 01000224 */  addiu      $v0, $zero, 0x1
    /* C6F3C 800D673C 1000A0AF */  sw         $zero, 0x10($sp)
    /* C6F40 800D6740 B250030C */  jal        Hud_BuildString__FPciiiib
    /* C6F44 800D6744 1400A2AF */   sw        $v0, 0x14($sp)
    /* C6F48 800D6748 3C14838F */  lw         $v1, %gp_rel(Hud_gCdScrollTitle)($gp)
    /* C6F4C 800D674C 4C004224 */  addiu      $v0, $v0, 0x4C
    /* C6F50 800D6750 2A186200 */  slt        $v1, $v1, $v0
    /* C6F54 800D6754 0E006010 */  beqz       $v1, .L800D6790
    /* C6F58 800D6758 00000000 */   nop
  .L800D675C:
    /* C6F5C 800D675C 1480023C */  lui        $v0, %hi(ticks)
    /* C6F60 800D6760 ACDC428C */  lw         $v0, %lo(ticks)($v0)
    /* C6F64 800D6764 3814848F */  lw         $a0, %gp_rel(Hud_gCdLastTick)($gp)
    /* C6F68 800D6768 00000000 */  nop
    /* C6F6C 800D676C 2A108200 */  slt        $v0, $a0, $v0
    /* C6F70 800D6770 0F004010 */  beqz       $v0, .L800D67B0
    /* C6F74 800D6774 04008224 */   addiu     $v0, $a0, 0x4
    /* C6F78 800D6778 3C14838F */  lw         $v1, %gp_rel(Hud_gCdScrollTitle)($gp)
    /* C6F7C 800D677C 381482AF */  sw         $v0, %gp_rel(Hud_gCdLastTick)($gp)
    /* C6F80 800D6780 01006324 */  addiu      $v1, $v1, 0x1
    /* C6F84 800D6784 3C1483AF */  sw         $v1, %gp_rel(Hud_gCdScrollTitle)($gp)
    /* C6F88 800D6788 D7590308 */  j          .L800D675C
    /* C6F8C 800D678C 00000000 */   nop
  .L800D6790:
    /* C6F90 800D6790 3814828F */  lw         $v0, %gp_rel(Hud_gCdLastTick)($gp)
    /* C6F94 800D6794 1480033C */  lui        $v1, %hi(ticks)
    /* C6F98 800D6798 ACDC638C */  lw         $v1, %lo(ticks)($v1)
    /* C6F9C 800D679C 80004224 */  addiu      $v0, $v0, 0x80
    /* C6FA0 800D67A0 2A104300 */  slt        $v0, $v0, $v1
    /* C6FA4 800D67A4 03004010 */  beqz       $v0, .L800D67B4
    /* C6FA8 800D67A8 21980000 */   addu      $s3, $zero, $zero
    /* C6FAC 800D67AC E01380AF */  sw         $zero, %gp_rel(Hud_gCdActive)($gp)
  .L800D67B0:
    /* C6FB0 800D67B0 21980000 */  addu       $s3, $zero, $zero
  .L800D67B4:
    /* C6FB4 800D67B4 2800A627 */  addiu      $a2, $sp, 0x28
    /* C6FB8 800D67B8 4C000224 */  addiu      $v0, $zero, 0x4C
    /* C6FBC 800D67BC 3C14838F */  lw         $v1, %gp_rel(Hud_gCdScrollTitle)($gp)
    /* C6FC0 800D67C0 00002492 */  lbu        $a0, 0x0($s1)
    /* C6FC4 800D67C4 00000000 */  nop
    /* C6FC8 800D67C8 30008010 */  beqz       $a0, .L800D688C
    /* C6FCC 800D67CC 23284300 */   subu      $a1, $v0, $v1
    /* C6FD0 800D67D0 20000924 */  addiu      $t1, $zero, 0x20
    /* C6FD4 800D67D4 1180023C */  lui        $v0, %hi(HudPmx_gShapes)
    /* C6FD8 800D67D8 980C4724 */  addiu      $a3, $v0, %lo(HudPmx_gShapes)
    /* C6FDC 800D67DC 21202002 */  addu       $a0, $s1, $zero
    /* C6FE0 800D67E0 3F002826 */  addiu      $t0, $s1, 0x3F
  .L800D67E4:
    /* C6FE4 800D67E4 2A108800 */  slt        $v0, $a0, $t0
    /* C6FE8 800D67E8 28004010 */  beqz       $v0, .L800D688C
    /* C6FEC 800D67EC 00000000 */   nop
    /* C6FF0 800D67F0 00008290 */  lbu        $v0, 0x0($a0)
    /* C6FF4 800D67F4 00000000 */  nop
    /* C6FF8 800D67F8 03004914 */  bne        $v0, $t1, .L800D6808
    /* C6FFC 800D67FC D0FF4224 */   addiu     $v0, $v0, -0x30
    /* C7000 800D6800 125A0308 */  j          .L800D6848
    /* C7004 800D6804 03000324 */   addiu     $v1, $zero, 0x3
  .L800D6808:
    /* C7008 800D6808 0A00422C */  sltiu      $v0, $v0, 0xA
    /* C700C 800D680C 04004010 */  beqz       $v0, .L800D6820
    /* C7010 800D6810 00000000 */   nop
    /* C7014 800D6814 00008290 */  lbu        $v0, 0x0($a0)
    /* C7018 800D6818 0B5A0308 */  j          .L800D682C
    /* C701C 800D681C 6E004224 */   addiu     $v0, $v0, 0x6E
  .L800D6820:
    /* C7020 800D6820 00008290 */  lbu        $v0, 0x0($a0)
    /* C7024 800D6824 00000000 */  nop
    /* C7028 800D6828 43004224 */  addiu      $v0, $v0, 0x43
  .L800D682C:
    /* C702C 800D682C 80180200 */  sll        $v1, $v0, 2
    /* C7030 800D6830 21186200 */  addu       $v1, $v1, $v0
    /* C7034 800D6834 80180300 */  sll        $v1, $v1, 2
    /* C7038 800D6838 21186700 */  addu       $v1, $v1, $a3
    /* C703C 800D683C 10006284 */  lh         $v0, 0x10($v1)
    /* C7040 800D6840 00000000 */  nop
    /* C7044 800D6844 01004324 */  addiu      $v1, $v0, 0x1
  .L800D6848:
    /* C7048 800D6848 2110A300 */  addu       $v0, $a1, $v1
    /* C704C 800D684C 4C004228 */  slti       $v0, $v0, 0x4C
    /* C7050 800D6850 0E004010 */  beqz       $v0, .L800D688C
    /* C7054 800D6854 00000000 */   nop
    /* C7058 800D6858 0600A004 */  bltz       $a1, .L800D6874
    /* C705C 800D685C 00000000 */   nop
    /* C7060 800D6860 00008290 */  lbu        $v0, 0x0($a0)
    /* C7064 800D6864 00000000 */  nop
    /* C7068 800D6868 0000C2A0 */  sb         $v0, 0x0($a2)
    /* C706C 800D686C 1E5A0308 */  j          .L800D6878
    /* C7070 800D6870 0100C624 */   addiu     $a2, $a2, 0x1
  .L800D6874:
    /* C7074 800D6874 21986302 */  addu       $s3, $s3, $v1
  .L800D6878:
    /* C7078 800D6878 01008424 */  addiu      $a0, $a0, 0x1
    /* C707C 800D687C 00008290 */  lbu        $v0, 0x0($a0)
    /* C7080 800D6880 00000000 */  nop
    /* C7084 800D6884 D7FF4014 */  bnez       $v0, .L800D67E4
    /* C7088 800D6888 2128A300 */   addu      $a1, $a1, $v1
  .L800D688C:
    /* C708C 800D688C 295A0308 */  j          .L800D68A4
    /* C7090 800D6890 0000C0A0 */   sb        $zero, 0x0($a2)
  .L800D6894:
    /* C7094 800D6894 1480023C */  lui        $v0, %hi(ticks)
    /* C7098 800D6898 ACDC428C */  lw         $v0, %lo(ticks)($v0)
    /* C709C 800D689C B41380AF */  sw         $zero, %gp_rel(D_8013D900)($gp)
    /* C70A0 800D68A0 381482AF */  sw         $v0, %gp_rel(Hud_gCdLastTick)($gp)
  .L800D68A4:
    /* C70A4 800D68A4 2F00C016 */  bnez       $s6, .L800D6964
    /* C70A8 800D68A8 01000224 */   addiu     $v0, $zero, 0x1
    /* C70AC 800D68AC 9A002012 */  beqz       $s1, .L800D6B18
    /* C70B0 800D68B0 2800A427 */   addiu     $a0, $sp, 0x28
    /* C70B4 800D68B4 0A00C627 */  addiu      $a2, $fp, 0xA
    /* C70B8 800D68B8 BEBE0734 */  ori        $a3, $zero, 0xBEBE
    /* C70BC 800D68BC 01000224 */  addiu      $v0, $zero, 0x1
    /* C70C0 800D68C0 FC1882AF */  sw         $v0, %gp_rel(D_8013DE48)($gp)
    /* C70C4 800D68C4 0A006226 */  addiu      $v0, $s3, 0xA
    /* C70C8 800D68C8 3C14858F */  lw         $a1, %gp_rel(Hud_gCdScrollTitle)($gp)
    /* C70CC 800D68CC 2110E202 */  addu       $v0, $s7, $v0
    /* C70D0 800D68D0 1000A0AF */  sw         $zero, 0x10($sp)
    /* C70D4 800D68D4 1400A0AF */  sw         $zero, 0x14($sp)
    /* C70D8 800D68D8 B4FFA524 */  addiu      $a1, $a1, -0x4C
    /* C70DC 800D68DC B250030C */  jal        Hud_BuildString__FPciiiib
    /* C70E0 800D68E0 23284500 */   subu      $a1, $v0, $a1
    /* C70E4 800D68E4 08000012 */  beqz       $s0, .L800D6908
    /* C70E8 800D68E8 21200002 */   addu      $a0, $s0, $zero
    /* C70EC 800D68EC 0A00E526 */  addiu      $a1, $s7, 0xA
    /* C70F0 800D68F0 1300C627 */  addiu      $a2, $fp, 0x13
    /* C70F4 800D68F4 8000073C */  lui        $a3, (0x808080 >> 16)
    /* C70F8 800D68F8 8080E734 */  ori        $a3, $a3, (0x808080 & 0xFFFF)
    /* C70FC 800D68FC 1000A0AF */  sw         $zero, 0x10($sp)
    /* C7100 800D6900 B250030C */  jal        Hud_BuildString__FPciiiib
    /* C7104 800D6904 1400A0AF */   sw        $zero, 0x14($sp)
  .L800D6908:
    /* C7108 800D6908 5B47030C */  jal        Hud_GoTpage__Fi
    /* C710C 800D690C 21200000 */   addu      $a0, $zero, $zero
    /* C7110 800D6910 50000624 */  addiu      $a2, $zero, 0x50
    /* C7114 800D6914 B818828F */  lw         $v0, %gp_rel(D_8013DE04)($gp)
    /* C7118 800D6918 12000724 */  addiu      $a3, $zero, 0x12
    /* C711C 800D691C 3C004484 */  lh         $a0, 0x3C($v0)
    /* C7120 800D6920 3E004584 */  lh         $a1, 0x3E($v0)
    /* C7124 800D6924 0A008424 */  addiu      $a0, $a0, 0xA
    /* C7128 800D6928 AF5E030C */  jal        Hud_BlackThinBox__Fiiii
    /* C712C 800D692C 0A00A524 */   addiu     $a1, $a1, 0xA
    /* C7130 800D6930 21200000 */  addu       $a0, $zero, $zero
    /* C7134 800D6934 B818828F */  lw         $v0, %gp_rel(D_8013DE04)($gp)
    /* C7138 800D6938 50000724 */  addiu      $a3, $zero, 0x50
    /* C713C 800D693C 3C004584 */  lh         $a1, 0x3C($v0)
    /* C7140 800D6940 3E004684 */  lh         $a2, 0x3E($v0)
    /* C7144 800D6944 12000224 */  addiu      $v0, $zero, 0x12
    /* C7148 800D6948 1000A2AF */  sw         $v0, 0x10($sp)
    /* C714C 800D694C 1400A0AF */  sw         $zero, 0x14($sp)
    /* C7150 800D6950 1800A0AF */  sw         $zero, 0x18($sp)
    /* C7154 800D6954 1C00A0AF */  sw         $zero, 0x1C($sp)
    /* C7158 800D6958 0A00A524 */  addiu      $a1, $a1, 0xA
    /* C715C 800D695C C45A0308 */  j          .L800D6B10
    /* C7160 800D6960 0A00C624 */   addiu     $a2, $a2, 0xA
  .L800D6964:
    /* C7164 800D6964 FC1882AF */  sw         $v0, %gp_rel(D_8013DE48)($gp)
    /* C7168 800D6968 832C030C */  jal        Font_TextColor__Fi
    /* C716C 800D696C 04000424 */   addiu     $a0, $zero, 0x4
    /* C7170 800D6970 2000A427 */  addiu      $a0, $sp, 0x20
    /* C7174 800D6974 2128E002 */  addu       $a1, $s7, $zero
    /* C7178 800D6978 A42E030C */  jal        Font_TextXY__FPcii
    /* C717C 800D697C FEFFC627 */   addiu     $a2, $fp, -0x2
    /* C7180 800D6980 3C002012 */  beqz       $s1, .L800D6A74
    /* C7184 800D6984 00000000 */   nop
    /* C7188 800D6988 832C030C */  jal        Font_TextColor__Fi
    /* C718C 800D698C 03000424 */   addiu     $a0, $zero, 0x3
    /* C7190 800D6990 2800A427 */  addiu      $a0, $sp, 0x28
    /* C7194 800D6994 0300C627 */  addiu      $a2, $fp, 0x3
    /* C7198 800D6998 BEBE0734 */  ori        $a3, $zero, 0xBEBE
    /* C719C 800D699C 16006226 */  addiu      $v0, $s3, 0x16
    /* C71A0 800D69A0 3C14858F */  lw         $a1, %gp_rel(Hud_gCdScrollTitle)($gp)
    /* C71A4 800D69A4 2110E202 */  addu       $v0, $s7, $v0
    /* C71A8 800D69A8 1000A0AF */  sw         $zero, 0x10($sp)
    /* C71AC 800D69AC 1400A0AF */  sw         $zero, 0x14($sp)
    /* C71B0 800D69B0 B4FFA524 */  addiu      $a1, $a1, -0x4C
    /* C71B4 800D69B4 B250030C */  jal        Hud_BuildString__FPciiiib
    /* C71B8 800D69B8 23284500 */   subu      $a1, $v0, $a1
    /* C71BC 800D69BC 5B47030C */  jal        Hud_GoTpage__Fi
    /* C71C0 800D69C0 21200000 */   addu      $a0, $zero, $zero
    /* C71C4 800D69C4 2B008012 */  beqz       $s4, .L800D6A74
    /* C71C8 800D69C8 E745023C */   lui       $v0, (0x45E7B273 >> 16)
    /* C71CC 800D69CC 73B24234 */  ori        $v0, $v0, (0x45E7B273 & 0xFFFF)
    /* C71D0 800D69D0 1800A202 */  mult       $s5, $v0
    /* C71D4 800D69D4 6210043C */  lui        $a0, (0x10624DD3 >> 16)
    /* C71D8 800D69D8 D34D8434 */  ori        $a0, $a0, (0x10624DD3 & 0xFFFF)
    /* C71DC 800D69DC C3171500 */  sra        $v0, $s5, 31
    /* C71E0 800D69E0 10500000 */  mfhi       $t2
    /* C71E4 800D69E4 83330A00 */  sra        $a2, $t2, 14
    /* C71E8 800D69E8 2330C200 */  subu       $a2, $a2, $v0
    /* C71EC 800D69EC 40110600 */  sll        $v0, $a2, 5
    /* C71F0 800D69F0 23104600 */  subu       $v0, $v0, $a2
    /* C71F4 800D69F4 80100200 */  sll        $v0, $v0, 2
    /* C71F8 800D69F8 21104600 */  addu       $v0, $v0, $a2
    /* C71FC 800D69FC 00190200 */  sll        $v1, $v0, 4
    /* C7200 800D6A00 23186200 */  subu       $v1, $v1, $v0
    /* C7204 800D6A04 40190300 */  sll        $v1, $v1, 5
    /* C7208 800D6A08 23A8A302 */  subu       $s5, $s5, $v1
    /* C720C 800D6A0C 1800A402 */  mult       $s5, $a0
    /* C7210 800D6A10 8800B027 */  addiu      $s0, $sp, 0x88
    /* C7214 800D6A14 0580053C */  lui        $a1, %hi(D_800568F8)
    /* C7218 800D6A18 F868A524 */  addiu      $a1, $a1, %lo(D_800568F8)
    /* C721C 800D6A1C 21200002 */  addu       $a0, $s0, $zero
    /* C7220 800D6A20 1180023C */  lui        $v0, %hi(D_801132CC)
    /* C7224 800D6A24 CC32428C */  lw         $v0, %lo(D_801132CC)($v0)
    /* C7228 800D6A28 1480033C */  lui        $v1, %hi(HudminChar)
    /* C722C 800D6A2C 9CD86324 */  addiu      $v1, $v1, %lo(HudminChar)
    /* C7230 800D6A30 21104300 */  addu       $v0, $v0, $v1
    /* C7234 800D6A34 C31F1500 */  sra        $v1, $s5, 31
    /* C7238 800D6A38 00004790 */  lbu        $a3, 0x0($v0)
    /* C723C 800D6A3C 10500000 */  mfhi       $t2
    /* C7240 800D6A40 83110A00 */  sra        $v0, $t2, 6
    /* C7244 800D6A44 23104300 */  subu       $v0, $v0, $v1
    /* C7248 800D6A48 2F91030C */  jal        sprintf
    /* C724C 800D6A4C 1000A2AF */   sw        $v0, 0x10($sp)
    /* C7250 800D6A50 832C030C */  jal        Font_TextColor__Fi
    /* C7254 800D6A54 04000424 */   addiu     $a0, $zero, 0x4
    /* C7258 800D6A58 888F030C */  jal        textpixels
    /* C725C 800D6A5C 21200002 */   addu      $a0, $s0, $zero
    /* C7260 800D6A60 21200002 */  addu       $a0, $s0, $zero
    /* C7264 800D6A64 2310E202 */  subu       $v0, $s7, $v0
    /* C7268 800D6A68 5C004524 */  addiu      $a1, $v0, 0x5C
    /* C726C 800D6A6C A42E030C */  jal        Font_TextXY__FPcii
    /* C7270 800D6A70 0C00C627 */   addiu     $a2, $fp, 0xC
  .L800D6A74:
    /* C7274 800D6A74 B818828F */  lw         $v0, %gp_rel(D_8013DE04)($gp)
    /* C7278 800D6A78 66000624 */  addiu      $a2, $zero, 0x66
    /* C727C 800D6A7C 3C004484 */  lh         $a0, 0x3C($v0)
    /* C7280 800D6A80 3E004584 */  lh         $a1, 0x3E($v0)
    /* C7284 800D6A84 AF5E030C */  jal        Hud_BlackThinBox__Fiiii
    /* C7288 800D6A88 1C000724 */   addiu     $a3, $zero, 0x1C
    /* C728C 800D6A8C 21200000 */  addu       $a0, $zero, $zero
    /* C7290 800D6A90 B818828F */  lw         $v0, %gp_rel(D_8013DE04)($gp)
    /* C7294 800D6A94 66000724 */  addiu      $a3, $zero, 0x66
    /* C7298 800D6A98 3C004584 */  lh         $a1, 0x3C($v0)
    /* C729C 800D6A9C 3E004684 */  lh         $a2, 0x3E($v0)
    /* C72A0 800D6AA0 0E000224 */  addiu      $v0, $zero, 0xE
    /* C72A4 800D6AA4 1000A2AF */  sw         $v0, 0x10($sp)
    /* C72A8 800D6AA8 1400A0AF */  sw         $zero, 0x14($sp)
    /* C72AC 800D6AAC 1800A0AF */  sw         $zero, 0x18($sp)
    /* C72B0 800D6AB0 614A030C */  jal        Hud_FBuildF4__FiiiiiUlcc
    /* C72B4 800D6AB4 1C00A0AF */   sw        $zero, 0x1C($sp)
    /* C72B8 800D6AB8 21200000 */  addu       $a0, $zero, $zero
    /* C72BC 800D6ABC B818828F */  lw         $v0, %gp_rel(D_8013DE04)($gp)
    /* C72C0 800D6AC0 66000724 */  addiu      $a3, $zero, 0x66
    /* C72C4 800D6AC4 3C004584 */  lh         $a1, 0x3C($v0)
    /* C72C8 800D6AC8 3E004684 */  lh         $a2, 0x3E($v0)
    /* C72CC 800D6ACC 01000224 */  addiu      $v0, $zero, 0x1
    /* C72D0 800D6AD0 1000A2AF */  sw         $v0, 0x10($sp)
    /* C72D4 800D6AD4 1400A0AF */  sw         $zero, 0x14($sp)
    /* C72D8 800D6AD8 1800A0AF */  sw         $zero, 0x18($sp)
    /* C72DC 800D6ADC 1C00A0AF */  sw         $zero, 0x1C($sp)
    /* C72E0 800D6AE0 614A030C */  jal        Hud_FBuildF4__FiiiiiUlcc
    /* C72E4 800D6AE4 1B00C624 */   addiu     $a2, $a2, 0x1B
    /* C72E8 800D6AE8 01000424 */  addiu      $a0, $zero, 0x1
    /* C72EC 800D6AEC B818828F */  lw         $v0, %gp_rel(D_8013DE04)($gp)
    /* C72F0 800D6AF0 66000724 */  addiu      $a3, $zero, 0x66
    /* C72F4 800D6AF4 3C004584 */  lh         $a1, 0x3C($v0)
    /* C72F8 800D6AF8 3E004684 */  lh         $a2, 0x3E($v0)
    /* C72FC 800D6AFC 1C000224 */  addiu      $v0, $zero, 0x1C
    /* C7300 800D6B00 1000A2AF */  sw         $v0, 0x10($sp)
    /* C7304 800D6B04 1400A0AF */  sw         $zero, 0x14($sp)
    /* C7308 800D6B08 1800A0AF */  sw         $zero, 0x18($sp)
    /* C730C 800D6B0C 1C00A0AF */  sw         $zero, 0x1C($sp)
  .L800D6B10:
    /* C7310 800D6B10 614A030C */  jal        Hud_FBuildF4__FiiiiiUlcc
    /* C7314 800D6B14 00000000 */   nop
  .L800D6B18:
    /* C7318 800D6B18 C400BF8F */  lw         $ra, 0xC4($sp)
    /* C731C 800D6B1C C000BE8F */  lw         $fp, 0xC0($sp)
    /* C7320 800D6B20 BC00B78F */  lw         $s7, 0xBC($sp)
    /* C7324 800D6B24 B800B68F */  lw         $s6, 0xB8($sp)
    /* C7328 800D6B28 B400B58F */  lw         $s5, 0xB4($sp)
    /* C732C 800D6B2C B000B48F */  lw         $s4, 0xB0($sp)
    /* C7330 800D6B30 AC00B38F */  lw         $s3, 0xAC($sp)
    /* C7334 800D6B34 A800B28F */  lw         $s2, 0xA8($sp)
    /* C7338 800D6B38 A400B18F */  lw         $s1, 0xA4($sp)
    /* C733C 800D6B3C A000B08F */  lw         $s0, 0xA0($sp)
    /* C7340 800D6B40 0800E003 */  jr         $ra
    /* C7344 800D6B44 C800BD27 */   addiu     $sp, $sp, 0xC8
endlabel Hud_BuildCdPlayer__Fii
