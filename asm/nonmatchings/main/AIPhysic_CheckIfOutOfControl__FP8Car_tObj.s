.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIPhysic_CheckIfOutOfControl__FP8Car_tObj, 0x1A0

glabel AIPhysic_CheckIfOutOfControl__FP8Car_tObj
    /* 5BA60 8006B260 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 5BA64 8006B264 1000B0AF */  sw         $s0, 0x10($sp)
    /* 5BA68 8006B268 21808000 */  addu       $s0, $a0, $zero
    /* 5BA6C 8006B26C 1400BFAF */  sw         $ra, 0x14($sp)
    /* 5BA70 8006B270 5405058E */  lw         $a1, 0x554($s0)
    /* 5BA74 8006B274 B8CD010C */  jal        AIWorld_CalcRoadBend__FP8Car_tObji
    /* 5BA78 8006B278 C0280500 */   sll       $a1, $a1, 3
    /* 5BA7C 8006B27C 1280033C */  lui        $v1, %hi(D_8011E0B0)
    /* 5BA80 8006B280 B0E0638C */  lw         $v1, %lo(D_8011E0B0)($v1)
    /* 5BA84 8006B284 4807048E */  lw         $a0, 0x748($s0)
    /* 5BA88 8006B288 02004104 */  bgez       $v0, .L8006B294
    /* 5BA8C 8006B28C 21384000 */   addu      $a3, $v0, $zero
    /* 5BA90 8006B290 23380700 */  negu       $a3, $a3
  .L8006B294:
    /* 5BA94 8006B294 2A186400 */  slt        $v1, $v1, $a0
    /* 5BA98 8006B298 09006010 */  beqz       $v1, .L8006B2C0
    /* 5BA9C 8006B29C 0200023C */   lui       $v0, (0x2FFFF >> 16)
    /* 5BAA0 8006B2A0 6405038E */  lw         $v1, 0x564($s0)
    /* 5BAA4 8006B2A4 FFFF4234 */  ori        $v0, $v0, (0x2FFFF & 0xFFFF)
    /* 5BAA8 8006B2A8 02006104 */  bgez       $v1, .L8006B2B4
    /* 5BAAC 8006B2AC 00000000 */   nop
    /* 5BAB0 8006B2B0 23180300 */  negu       $v1, $v1
  .L8006B2B4:
    /* 5BAB4 8006B2B4 2A104300 */  slt        $v0, $v0, $v1
    /* 5BAB8 8006B2B8 FCAC0108 */  j          .L8006B3F0
    /* 5BABC 8006B2BC 01004238 */   xori      $v0, $v0, 0x1
  .L8006B2C0:
    /* 5BAC0 8006B2C0 DC06028E */  lw         $v0, 0x6DC($s0)
    /* 5BAC4 8006B2C4 00000000 */  nop
    /* 5BAC8 8006B2C8 02004104 */  bgez       $v0, .L8006B2D4
    /* 5BACC 8006B2CC 00000000 */   nop
    /* 5BAD0 8006B2D0 23100200 */  negu       $v0, $v0
  .L8006B2D4:
    /* 5BAD4 8006B2D4 74004228 */  slti       $v0, $v0, 0x74
    /* 5BAD8 8006B2D8 42004010 */  beqz       $v0, .L8006B3E4
    /* 5BADC 8006B2DC FFFF0224 */   addiu     $v0, $zero, -0x1
    /* 5BAE0 8006B2E0 F006038E */  lw         $v1, 0x6F0($s0)
    /* 5BAE4 8006B2E4 00000000 */  nop
    /* 5BAE8 8006B2E8 3E006210 */  beq        $v1, $v0, .L8006B3E4
    /* 5BAEC 8006B2EC FDFF033C */   lui       $v1, (0xFFFD0000 >> 16)
    /* 5BAF0 8006B2F0 6405028E */  lw         $v0, 0x564($s0)
    /* 5BAF4 8006B2F4 00000000 */  nop
    /* 5BAF8 8006B2F8 02004104 */  bgez       $v0, .L8006B304
    /* 5BAFC 8006B2FC 21404000 */   addu      $t0, $v0, $zero
    /* 5BB00 8006B300 23400800 */  negu       $t0, $t0
  .L8006B304:
    /* 5BB04 8006B304 1180023C */  lui        $v0, %hi(D_8010DCD4)
    /* 5BB08 8006B308 D4DC428C */  lw         $v0, %lo(D_8010DCD4)($v0)
    /* 5BB0C 8006B30C 00000000 */  nop
    /* 5BB10 8006B310 21104300 */  addu       $v0, $v0, $v1
    /* 5BB14 8006B314 2A100201 */  slt        $v0, $t0, $v0
    /* 5BB18 8006B318 35004014 */  bnez       $v0, .L8006B3F0
    /* 5BB1C 8006B31C 01000224 */   addiu     $v0, $zero, 0x1
    /* 5BB20 8006B320 08000286 */  lh         $v0, 0x8($s0)
    /* 5BB24 8006B324 1480033C */  lui        $v1, %hi(BWorldSm_slices)
    /* 5BB28 8006B328 C0C7638C */  lw         $v1, %lo(BWorldSm_slices)($v1)
    /* 5BB2C 8006B32C 40110200 */  sll        $v0, $v0, 5
    /* 5BB30 8006B330 21204300 */  addu       $a0, $v0, $v1
    /* 5BB34 8006B334 1E008290 */  lbu        $v0, 0x1E($a0)
    /* 5BB38 8006B338 1D008690 */  lbu        $a2, 0x1D($a0)
    /* 5BB3C 8006B33C C0130200 */  sll        $v0, $v0, 15
    /* 5BB40 8006B340 02190600 */  srl        $v1, $a2, 4
    /* 5BB44 8006B344 18004300 */  mult       $v0, $v1
    /* 5BB48 8006B348 7405058E */  lw         $a1, 0x574($s0)
    /* 5BB4C 8006B34C 12480000 */  mflo       $t1
    /* 5BB50 8006B350 23100900 */  negu       $v0, $t1
    /* 5BB54 8006B354 2A10A200 */  slt        $v0, $a1, $v0
    /* 5BB58 8006B358 25004014 */  bnez       $v0, .L8006B3F0
    /* 5BB5C 8006B35C 01000224 */   addiu     $v0, $zero, 0x1
    /* 5BB60 8006B360 1F008290 */  lbu        $v0, 0x1F($a0)
    /* 5BB64 8006B364 0F00C330 */  andi       $v1, $a2, 0xF
    /* 5BB68 8006B368 C0130200 */  sll        $v0, $v0, 15
    /* 5BB6C 8006B36C 18004300 */  mult       $v0, $v1
    /* 5BB70 8006B370 12480000 */  mflo       $t1
    /* 5BB74 8006B374 2A102501 */  slt        $v0, $t1, $a1
    /* 5BB78 8006B378 1D004014 */  bnez       $v0, .L8006B3F0
    /* 5BB7C 8006B37C 01000224 */   addiu     $v0, $zero, 0x1
    /* 5BB80 8006B380 CCCC0234 */  ori        $v0, $zero, 0xCCCC
    /* 5BB84 8006B384 2A104700 */  slt        $v0, $v0, $a3
    /* 5BB88 8006B388 19004014 */  bnez       $v0, .L8006B3F0
    /* 5BB8C 8006B38C 01000224 */   addiu     $v0, $zero, 0x1
    /* 5BB90 8006B390 1804028E */  lw         $v0, 0x418($s0)
    /* 5BB94 8006B394 6805048E */  lw         $a0, 0x568($s0)
    /* 5BB98 8006B398 02004104 */  bgez       $v0, .L8006B3A4
    /* 5BB9C 8006B39C 21284000 */   addu      $a1, $v0, $zero
    /* 5BBA0 8006B3A0 23280500 */  negu       $a1, $a1
  .L8006B3A4:
    /* 5BBA4 8006B3A4 03008104 */  bgez       $a0, .L8006B3B4
    /* 5BBA8 8006B3A8 03120400 */   sra       $v0, $a0, 8
    /* 5BBAC 8006B3AC FF008424 */  addiu      $a0, $a0, 0xFF
    /* 5BBB0 8006B3B0 03120400 */  sra        $v0, $a0, 8
  .L8006B3B4:
    /* 5BBB4 8006B3B4 40180200 */  sll        $v1, $v0, 1
    /* 5BBB8 8006B3B8 21186200 */  addu       $v1, $v1, $v0
    /* 5BBBC 8006B3BC 00110300 */  sll        $v0, $v1, 4
    /* 5BBC0 8006B3C0 21186200 */  addu       $v1, $v1, $v0
    /* 5BBC4 8006B3C4 40180300 */  sll        $v1, $v1, 1
    /* 5BBC8 8006B3C8 2A186500 */  slt        $v1, $v1, $a1
    /* 5BBCC 8006B3CC 07006010 */  beqz       $v1, .L8006B3EC
    /* 5BBD0 8006B3D0 0E00023C */   lui       $v0, (0xEFFFF >> 16)
    /* 5BBD4 8006B3D4 FFFF4234 */  ori        $v0, $v0, (0xEFFFF & 0xFFFF)
    /* 5BBD8 8006B3D8 2A104800 */  slt        $v0, $v0, $t0
    /* 5BBDC 8006B3DC 04004014 */  bnez       $v0, .L8006B3F0
    /* 5BBE0 8006B3E0 21100000 */   addu      $v0, $zero, $zero
  .L8006B3E4:
    /* 5BBE4 8006B3E4 FCAC0108 */  j          .L8006B3F0
    /* 5BBE8 8006B3E8 01000224 */   addiu     $v0, $zero, 0x1
  .L8006B3EC:
    /* 5BBEC 8006B3EC 21100000 */  addu       $v0, $zero, $zero
  .L8006B3F0:
    /* 5BBF0 8006B3F0 1400BF8F */  lw         $ra, 0x14($sp)
    /* 5BBF4 8006B3F4 1000B08F */  lw         $s0, 0x10($sp)
    /* 5BBF8 8006B3F8 0800E003 */  jr         $ra
    /* 5BBFC 8006B3FC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AIPhysic_CheckIfOutOfControl__FP8Car_tObj
