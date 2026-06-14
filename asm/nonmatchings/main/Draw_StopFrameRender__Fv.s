.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Draw_StopFrameRender__Fv, 0xE4

glabel Draw_StopFrameRender__Fv
    /* AEB6C 800BE36C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* AEB70 800BE370 21200000 */  addu       $a0, $zero, $zero
    /* AEB74 800BE374 1800BFAF */  sw         $ra, 0x18($sp)
    /* AEB78 800BE378 1400B1AF */  sw         $s1, 0x14($sp)
    /* AEB7C 800BE37C 1FB6030C */  jal        DrawSync
    /* AEB80 800BE380 1000B0AF */   sw        $s0, 0x10($sp)
    /* AEB84 800BE384 6C12828F */  lw         $v0, %gp_rel(gLoop)($gp)
    /* AEB88 800BE388 9C18838F */  lw         $v1, %gp_rel(D_8013DDE8)($gp)
    /* AEB8C 800BE38C 01004224 */  addiu      $v0, $v0, 0x1
    /* AEB90 800BE390 6C1282AF */  sw         $v0, %gp_rel(gLoop)($gp)
    /* AEB94 800BE394 03006010 */  beqz       $v1, .L800BE3A4
    /* AEB98 800BE398 00000000 */   nop
    /* AEB9C 800BE39C 09F86000 */  jalr       $v1
    /* AEBA0 800BE3A0 00000000 */   nop
  .L800BE3A4:
    /* AEBA4 800BE3A4 5C12828F */  lw         $v0, %gp_rel(Draw_gDoVSync)($gp)
    /* AEBA8 800BE3A8 00000000 */  nop
    /* AEBAC 800BE3AC 03004010 */  beqz       $v0, .L800BE3BC
    /* AEBB0 800BE3B0 00000000 */   nop
    /* AEBB4 800BE3B4 C7C8030C */  jal        VSync
    /* AEBB8 800BE3B8 21200000 */   addu      $a0, $zero, $zero
  .L800BE3BC:
    /* AEBBC 800BE3BC 6812838F */  lw         $v1, %gp_rel(gFlip)($gp)
    /* AEBC0 800BE3C0 21880000 */  addu       $s1, $zero, $zero
    /* AEBC4 800BE3C4 1280043C */  lui        $a0, %hi(gEnviro)
    /* AEBC8 800BE3C8 24F48424 */  addiu      $a0, $a0, %lo(gEnviro)
    /* AEBCC 800BE3CC 40100300 */  sll        $v0, $v1, 1
    /* AEBD0 800BE3D0 21104300 */  addu       $v0, $v0, $v1
    /* AEBD4 800BE3D4 C0100200 */  sll        $v0, $v0, 3
    /* AEBD8 800BE3D8 79B7030C */  jal        PutDispEnv
    /* AEBDC 800BE3DC 21204400 */   addu      $a0, $v0, $a0
    /* AEBE0 800BE3E0 1280023C */  lui        $v0, %hi(Draw_gView)
    /* AEBE4 800BE3E4 54EC5024 */  addiu      $s0, $v0, %lo(Draw_gView)
  .L800BE3E8:
    /* AEBE8 800BE3E8 6012828F */  lw         $v0, %gp_rel(Draw_gNumView)($gp)
    /* AEBEC 800BE3EC 00000000 */  nop
    /* AEBF0 800BE3F0 2A102202 */  slt        $v0, $s1, $v0
    /* AEBF4 800BE3F4 0D004010 */  beqz       $v0, .L800BE42C
    /* AEBF8 800BE3F8 01003126 */   addiu     $s1, $s1, 0x1
    /* AEBFC 800BE3FC 6812828F */  lw         $v0, %gp_rel(gFlip)($gp)
    /* AEC00 800BE400 0000038E */  lw         $v1, 0x0($s0)
    /* AEC04 800BE404 80100200 */  sll        $v0, $v0, 2
    /* AEC08 800BE408 21100202 */  addu       $v0, $s0, $v0
    /* AEC0C 800BE40C C8001026 */  addiu      $s0, $s0, 0xC8
    /* AEC10 800BE410 C000448C */  lw         $a0, 0xC0($v0)
    /* AEC14 800BE414 80180300 */  sll        $v1, $v1, 2
    /* AEC18 800BE418 21208300 */  addu       $a0, $a0, $v1
    /* AEC1C 800BE41C 2DB7030C */  jal        DrawOTag
    /* AEC20 800BE420 FCFF8424 */   addiu     $a0, $a0, -0x4
    /* AEC24 800BE424 FAF80208 */  j          .L800BE3E8
    /* AEC28 800BE428 00000000 */   nop
  .L800BE42C:
    /* AEC2C 800BE42C 01000224 */  addiu      $v0, $zero, 0x1
    /* AEC30 800BE430 6812838F */  lw         $v1, %gp_rel(gFlip)($gp)
    /* AEC34 800BE434 1800BF8F */  lw         $ra, 0x18($sp)
    /* AEC38 800BE438 1400B18F */  lw         $s1, 0x14($sp)
    /* AEC3C 800BE43C 1000B08F */  lw         $s0, 0x10($sp)
    /* AEC40 800BE440 23104300 */  subu       $v0, $v0, $v1
    /* AEC44 800BE444 681282AF */  sw         $v0, %gp_rel(gFlip)($gp)
    /* AEC48 800BE448 0800E003 */  jr         $ra
    /* AEC4C 800BE44C 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Draw_StopFrameRender__Fv
