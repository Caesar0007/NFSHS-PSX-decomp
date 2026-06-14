.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TrgSfx_CrashCar__FP8coorddef, 0xAC

glabel TrgSfx_CrashCar__FP8coorddef
    /* ABB70 800BB370 1280023C */  lui        $v0, %hi(D_8011E0B0)
    /* ABB74 800BB374 B0E0438C */  lw         $v1, %lo(D_8011E0B0)($v0)
    /* ABB78 800BB378 A80F828F */  lw         $v0, %gp_rel(gTAddCSmoke)($gp)
    /* ABB7C 800BB37C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* ABB80 800BB380 1800B0AF */  sw         $s0, 0x18($sp)
    /* ABB84 800BB384 21808000 */  addu       $s0, $a0, $zero
    /* ABB88 800BB388 23106200 */  subu       $v0, $v1, $v0
    /* ABB8C 800BB38C 05004228 */  slti       $v0, $v0, 0x5
    /* ABB90 800BB390 1E004014 */  bnez       $v0, .L800BB40C
    /* ABB94 800BB394 1C00BFAF */   sw        $ra, 0x1C($sp)
    /* ABB98 800BB398 A80F83AF */  sw         $v1, %gp_rel(gTAddCSmoke)($gp)
    /* ABB9C 800BB39C EA9D030C */  jal        random
    /* ABBA0 800BB3A0 00000000 */   nop
    /* ABBA4 800BB3A4 0F004230 */  andi       $v0, $v0, 0xF
    /* ABBA8 800BB3A8 0C004010 */  beqz       $v0, .L800BB3DC
    /* ABBAC 800BB3AC 21200002 */   addu      $a0, $s0, $zero
    /* ABBB0 800BB3B0 01000524 */  addiu      $a1, $zero, 0x1
    /* ABBB4 800BB3B4 21300000 */  addu       $a2, $zero, $zero
    /* ABBB8 800BB3B8 2138C000 */  addu       $a3, $a2, $zero
    /* ABBBC 800BB3BC 1000A0AF */  sw         $zero, 0x10($sp)
    /* ABBC0 800BB3C0 C3DD020C */  jal        Souffle_Add__FP8coorddefiT0iii
    /* ABBC4 800BB3C4 1400A0AF */   sw        $zero, 0x14($sp)
    /* ABBC8 800BB3C8 21184000 */  addu       $v1, $v0, $zero
    /* ABBCC 800BB3CC 1C00628C */  lw         $v0, 0x1C($v1)
    /* ABBD0 800BB3D0 00000000 */  nop
    /* ABBD4 800BB3D4 5C0F4224 */  addiu      $v0, $v0, 0xF5C
    /* ABBD8 800BB3D8 1C0062AC */  sw         $v0, 0x1C($v1)
  .L800BB3DC:
    /* ABBDC 800BB3DC 21200002 */  addu       $a0, $s0, $zero
    /* ABBE0 800BB3E0 03000524 */  addiu      $a1, $zero, 0x3
    /* ABBE4 800BB3E4 21300000 */  addu       $a2, $zero, $zero
    /* ABBE8 800BB3E8 2138C000 */  addu       $a3, $a2, $zero
    /* ABBEC 800BB3EC 1000A0AF */  sw         $zero, 0x10($sp)
    /* ABBF0 800BB3F0 C3DD020C */  jal        Souffle_Add__FP8coorddefiT0iii
    /* ABBF4 800BB3F4 1400A0AF */   sw        $zero, 0x14($sp)
    /* ABBF8 800BB3F8 21184000 */  addu       $v1, $v0, $zero
    /* ABBFC 800BB3FC 1C00628C */  lw         $v0, 0x1C($v1)
    /* ABC00 800BB400 00000000 */  nop
    /* ABC04 800BB404 5C0F4224 */  addiu      $v0, $v0, 0xF5C
    /* ABC08 800BB408 1C0062AC */  sw         $v0, 0x1C($v1)
  .L800BB40C:
    /* ABC0C 800BB40C 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* ABC10 800BB410 1800B08F */  lw         $s0, 0x18($sp)
    /* ABC14 800BB414 0800E003 */  jr         $ra
    /* ABC18 800BB418 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel TrgSfx_CrashCar__FP8coorddef
