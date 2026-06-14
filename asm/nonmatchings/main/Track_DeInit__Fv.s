.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Track_DeInit__Fv, 0xD4

glabel Track_DeInit__Fv
    /* AB474 800BAC74 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* AB478 800BAC78 1000B0AF */  sw         $s0, 0x10($sp)
    /* AB47C 800BAC7C 8C0F908F */  lw         $s0, %gp_rel(Track_mem)($gp)
    /* AB480 800BAC80 00000000 */  nop
    /* AB484 800BAC84 07000012 */  beqz       $s0, .L800BACA4
    /* AB488 800BAC88 1400BFAF */   sw        $ra, 0x14($sp)
    /* AB48C 800BAC8C 0000048E */  lw         $a0, 0x0($s0)
    /* AB490 800BAC90 5095030C */  jal        purgememadr
    /* AB494 800BAC94 00000000 */   nop
    /* AB498 800BAC98 21200002 */  addu       $a0, $s0, $zero
    /* AB49C 800BAC9C 6B8F020C */  jal        __builtin_delete
    /* AB4A0 800BACA0 040080AC */   sw        $zero, 0x4($a0)
  .L800BACA4:
    /* AB4A4 800BACA4 800F848F */  lw         $a0, %gp_rel(Track_gSaveSurface)($gp)
    /* AB4A8 800BACA8 00000000 */  nop
    /* AB4AC 800BACAC 05008010 */  beqz       $a0, .L800BACC4
    /* AB4B0 800BACB0 1280023C */   lui       $v0, %hi(gInitialArt)
    /* AB4B4 800BACB4 EDEB020C */  jal        ___11SaveSurface
    /* AB4B8 800BACB8 03000524 */   addiu     $a1, $zero, 0x3
    /* AB4BC 800BACBC 800F80AF */  sw         $zero, %gp_rel(Track_gSaveSurface)($gp)
    /* AB4C0 800BACC0 1280023C */  lui        $v0, %hi(gInitialArt)
  .L800BACC4:
    /* AB4C4 800BACC4 58E14324 */  addiu      $v1, $v0, %lo(gInitialArt)
    /* AB4C8 800BACC8 0400628C */  lw         $v0, 0x4($v1)
    /* AB4CC 800BACCC 00000000 */  nop
    /* AB4D0 800BACD0 02004010 */  beqz       $v0, .L800BACDC
    /* AB4D4 800BACD4 00000000 */   nop
    /* AB4D8 800BACD8 040060AC */  sw         $zero, 0x4($v1)
  .L800BACDC:
    /* AB4DC 800BACDC 5AFA010C */  jal        BWorldSm_DeInit__Fv
    /* AB4E0 800BACE0 00000000 */   nop
    /* AB4E4 800BACE4 02E5020C */  jal        DeInitArtResources__Fv
    /* AB4E8 800BACE8 00000000 */   nop
    /* AB4EC 800BACEC 1480043C */  lui        $a0, %hi(Chunk_lightTable)
    /* AB4F0 800BACF0 18C8848C */  lw         $a0, %lo(Chunk_lightTable)($a0)
    /* AB4F4 800BACF4 00000000 */  nop
    /* AB4F8 800BACF8 05008010 */  beqz       $a0, .L800BAD10
    /* AB4FC 800BACFC 00000000 */   nop
    /* AB500 800BAD00 5095030C */  jal        purgememadr
    /* AB504 800BAD04 00000000 */   nop
    /* AB508 800BAD08 1480013C */  lui        $at, %hi(Chunk_lightTable)
    /* AB50C 800BAD0C 18C820AC */  sw         $zero, %lo(Chunk_lightTable)($at)
  .L800BAD10:
    /* AB510 800BAD10 7C0F848F */  lw         $a0, %gp_rel(gPersistObjDefBoundingSpheres)($gp)
    /* AB514 800BAD14 00000000 */  nop
    /* AB518 800BAD18 03008010 */  beqz       $a0, .L800BAD28
    /* AB51C 800BAD1C 00000000 */   nop
    /* AB520 800BAD20 5095030C */  jal        purgememadr
    /* AB524 800BAD24 00000000 */   nop
  .L800BAD28:
    /* AB528 800BAD28 1400BF8F */  lw         $ra, 0x14($sp)
    /* AB52C 800BAD2C 1000B08F */  lw         $s0, 0x10($sp)
    /* AB530 800BAD30 7C0F80AF */  sw         $zero, %gp_rel(gPersistObjDefBoundingSpheres)($gp)
    /* AB534 800BAD34 780F80AF */  sw         $zero, %gp_rel(gPersistMidgroundObjInst)($gp)
    /* AB538 800BAD38 740F80AF */  sw         $zero, %gp_rel(gPersistObjInst)($gp)
    /* AB53C 800BAD3C 700F80AF */  sw         $zero, %gp_rel(gPersistObjDef)($gp)
    /* AB540 800BAD40 0800E003 */  jr         $ra
    /* AB544 800BAD44 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Track_DeInit__Fv
