.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Init_PSX_FrontEnd__Fv, 0x140

glabel Init_PSX_FrontEnd__Fv
    /* 3E5F8 8004DDF8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 3E5FC 8004DDFC 0E80043C */  lui        $a0, %hi(PAD_update)
    /* 3E600 8004DE00 10428424 */  addiu      $a0, $a0, %lo(PAD_update)
    /* 3E604 8004DE04 1480033C */  lui        $v1, %hi(gFlip)
    /* 3E608 8004DE08 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 3E60C 8004DE0C 1000BFAF */  sw         $ra, 0x10($sp)
    /* 3E610 8004DE10 FAAB030C */  jal        addtimer
    /* 3E614 8004DE14 B4D762AC */   sw        $v0, %lo(gFlip)($v1)
    /* 3E618 8004DE18 69C8030C */  jal        InitGeom
    /* 3E61C 8004DE1C 00000000 */   nop
    /* 3E620 8004DE20 3237010C */  jal        PSX_AllocShapes__Fv
    /* 3E624 8004DE24 00000000 */   nop
    /* 3E628 8004DE28 4481030C */  jal        Texture_InitMenuClut__Fv
    /* 3E62C 8004DE2C 00000000 */   nop
    /* 3E630 8004DE30 1480033C */  lui        $v1, %hi(screenwidth)
    /* 3E634 8004DE34 00020224 */  addiu      $v0, $zero, 0x200
    /* 3E638 8004DE38 1480043C */  lui        $a0, %hi(screenbpp)
    /* 3E63C 8004DE3C 88DC62AC */  sw         $v0, %lo(screenwidth)($v1)
    /* 3E640 8004DE40 0580023C */  lui        $v0, %hi(ComingIntoTheFrontEndTheVeryFirstTime)
    /* 3E644 8004DE44 EC17438C */  lw         $v1, %lo(ComingIntoTheFrontEndTheVeryFirstTime)($v0)
    /* 3E648 8004DE48 10000224 */  addiu      $v0, $zero, 0x10
    /* 3E64C 8004DE4C 22006010 */  beqz       $v1, .L8004DED8
    /* 3E650 8004DE50 90DC82AC */   sw        $v0, %lo(screenbpp)($a0)
    /* 3E654 8004DE54 BD33010C */  jal        play_movie__Fc
    /* 3E658 8004DE58 04000424 */   addiu     $a0, $zero, 0x4
    /* 3E65C 8004DE5C 01000324 */  addiu      $v1, $zero, 0x1
    /* 3E660 8004DE60 04004310 */  beq        $v0, $v1, .L8004DE74
    /* 3E664 8004DE64 21200000 */   addu      $a0, $zero, $zero
    /* 3E668 8004DE68 BD33010C */  jal        play_movie__Fc
    /* 3E66C 8004DE6C 21200000 */   addu      $a0, $zero, $zero
    /* 3E670 8004DE70 21200000 */  addu       $a0, $zero, $zero
  .L8004DE74:
    /* 3E674 8004DE74 01000524 */  addiu      $a1, $zero, 0x1
    /* 3E678 8004DE78 7DC1030C */  jal        initlinkmode
    /* 3E67C 8004DE7C 2130A000 */   addu      $a2, $a1, $zero
    /* 3E680 8004DE80 4337010C */  jal        Init_RenderingEnvironment__Fv
    /* 3E684 8004DE84 00000000 */   nop
    /* 3E688 8004DE88 21200000 */  addu       $a0, $zero, $zero
    /* 3E68C 8004DE8C 14000524 */  addiu      $a1, $zero, 0x14
    /* 3E690 8004DE90 7DC1030C */  jal        initlinkmode
    /* 3E694 8004DE94 21308000 */   addu      $a2, $a0, $zero
    /* 3E698 8004DE98 0D37010C */  jal        DoLanguageScreen__Fv
    /* 3E69C 8004DE9C 00000000 */   nop
    /* 3E6A0 8004DEA0 1180023C */  lui        $v0, %hi(D_80114940)
    /* 3E6A4 8004DEA4 40494490 */  lbu        $a0, %lo(D_80114940)($v0)
    /* 3E6A8 8004DEA8 8AE4020C */  jal        TextSys_LoadWords__Fi
    /* 3E6AC 8004DEAC 00000000 */   nop
    /* 3E6B0 8004DEB0 CD36010C */  jal        DoTitleScreen__Fv
    /* 3E6B4 8004DEB4 00000000 */   nop
    /* 3E6B8 8004DEB8 21200000 */  addu       $a0, $zero, $zero
    /* 3E6BC 8004DEBC 01000524 */  addiu      $a1, $zero, 0x1
    /* 3E6C0 8004DEC0 7DC1030C */  jal        initlinkmode
    /* 3E6C4 8004DEC4 2130A000 */   addu      $a2, $a1, $zero
    /* 3E6C8 8004DEC8 659E000C */  jal        Front_SecondaryMemCardCheck__Fv
    /* 3E6CC 8004DECC 00000000 */   nop
    /* 3E6D0 8004DED0 BC370108 */  j          .L8004DEF0
    /* 3E6D4 8004DED4 00000000 */   nop
  .L8004DED8:
    /* 3E6D8 8004DED8 4337010C */  jal        Init_RenderingEnvironment__Fv
    /* 3E6DC 8004DEDC 00000000 */   nop
    /* 3E6E0 8004DEE0 1180023C */  lui        $v0, %hi(D_80114940)
    /* 3E6E4 8004DEE4 40494490 */  lbu        $a0, %lo(D_80114940)($v0)
    /* 3E6E8 8004DEE8 8AE4020C */  jal        TextSys_LoadWords__Fi
    /* 3E6EC 8004DEEC 00000000 */   nop
  .L8004DEF0:
    /* 3E6F0 8004DEF0 EA9A000C */  jal        FeTools_init__Fv
    /* 3E6F4 8004DEF4 00000000 */   nop
    /* 3E6F8 8004DEF8 00D80434 */  ori        $a0, $zero, 0xD800
    /* 3E6FC 8004DEFC 0100053C */  lui        $a1, (0x18000 >> 16)
    /* 3E700 8004DF00 E1EE020C */  jal        Audio_InitDriver__Fii
    /* 3E704 8004DF04 0080A534 */   ori       $a1, $a1, (0x18000 & 0xFFFF)
    /* 3E708 8004DF08 1180023C */  lui        $v0, %hi(D_80114A44)
    /* 3E70C 8004DF0C 444A448C */  lw         $a0, %lo(D_80114A44)($v0)
    /* 3E710 8004DF10 1DAE000C */  jal        SetPlayList__Fi
    /* 3E714 8004DF14 00000000 */   nop
    /* 3E718 8004DF18 CEDD010C */  jal        AudioCmn_LoadFESamples__Fv
    /* 3E71C 8004DF1C 00000000 */   nop
    /* 3E720 8004DF20 ED3A010C */  jal        LoadAllHelpShapes__Fv
    /* 3E724 8004DF24 00000000 */   nop
    /* 3E728 8004DF28 1000BF8F */  lw         $ra, 0x10($sp)
    /* 3E72C 8004DF2C 00000000 */  nop
    /* 3E730 8004DF30 0800E003 */  jr         $ra
    /* 3E734 8004DF34 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Init_PSX_FrontEnd__Fv
