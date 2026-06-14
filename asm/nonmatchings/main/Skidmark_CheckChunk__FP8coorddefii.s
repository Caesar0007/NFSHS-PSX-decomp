.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Skidmark_CheckChunk__FP8coorddefii, 0x1AC

glabel Skidmark_CheckChunk__FP8coorddefii
    /* CF1EC 800DE9EC 8415838F */  lw         $v1, %gp_rel(gUseSm)($gp)
    /* CF1F0 800DE9F0 00000000 */  nop
    /* CF1F4 800DE9F4 40100300 */  sll        $v0, $v1, 1
    /* CF1F8 800DE9F8 21104300 */  addu       $v0, $v0, $v1
    /* CF1FC 800DE9FC 80100200 */  sll        $v0, $v0, 2
    /* CF200 800DEA00 23104300 */  subu       $v0, $v0, $v1
    /* CF204 800DEA04 80100200 */  sll        $v0, $v0, 2
    /* CF208 800DEA08 23104300 */  subu       $v0, $v0, $v1
    /* CF20C 800DEA0C 7C15838F */  lw         $v1, %gp_rel(gSm)($gp)
    /* CF210 800DEA10 00110200 */  sll        $v0, $v0, 4
    /* CF214 800DEA14 21386200 */  addu       $a3, $v1, $v0
    /* CF218 800DEA18 0C00E284 */  lh         $v0, 0xC($a3)
    /* CF21C 800DEA1C 0000E88C */  lw         $t0, 0x0($a3)
    /* CF220 800DEA20 0000838C */  lw         $v1, 0x0($a0)
    /* CF224 800DEA24 21104500 */  addu       $v0, $v0, $a1
    /* CF228 800DEA28 19004228 */  slti       $v0, $v0, 0x19
    /* CF22C 800DEA2C 23280301 */  subu       $a1, $t0, $v1
    /* CF230 800DEA30 0500A018 */  blez       $a1, .L800DEA48
    /* CF234 800DEA34 01004938 */   xori      $t1, $v0, 0x1
    /* CF238 800DEA38 0F00023C */  lui        $v0, (0xFFFFF >> 16)
    /* CF23C 800DEA3C FFFF4234 */  ori        $v0, $v0, (0xFFFFF & 0xFFFF)
    /* CF240 800DEA40 967A0308 */  j          .L800DEA58
    /* CF244 800DEA44 2A104500 */   slt       $v0, $v0, $a1
  .L800DEA48:
    /* CF248 800DEA48 0F00023C */  lui        $v0, (0xFFFFF >> 16)
    /* CF24C 800DEA4C FFFF4234 */  ori        $v0, $v0, (0xFFFFF & 0xFFFF)
    /* CF250 800DEA50 23186800 */  subu       $v1, $v1, $t0
    /* CF254 800DEA54 2A104300 */  slt        $v0, $v0, $v1
  .L800DEA58:
    /* CF258 800DEA58 20004014 */  bnez       $v0, .L800DEADC
    /* CF25C 800DEA5C 00000000 */   nop
    /* CF260 800DEA60 0400E88C */  lw         $t0, 0x4($a3)
    /* CF264 800DEA64 0400838C */  lw         $v1, 0x4($a0)
    /* CF268 800DEA68 00000000 */  nop
    /* CF26C 800DEA6C 23280301 */  subu       $a1, $t0, $v1
    /* CF270 800DEA70 0400A018 */  blez       $a1, .L800DEA84
    /* CF274 800DEA74 0F00023C */   lui       $v0, (0xFFFFF >> 16)
    /* CF278 800DEA78 FFFF4234 */  ori        $v0, $v0, (0xFFFFF & 0xFFFF)
    /* CF27C 800DEA7C A47A0308 */  j          .L800DEA90
    /* CF280 800DEA80 2A104500 */   slt       $v0, $v0, $a1
  .L800DEA84:
    /* CF284 800DEA84 FFFF4234 */  ori        $v0, $v0, (0xFFFFF & 0xFFFF)
    /* CF288 800DEA88 23186800 */  subu       $v1, $v1, $t0
    /* CF28C 800DEA8C 2A104300 */  slt        $v0, $v0, $v1
  .L800DEA90:
    /* CF290 800DEA90 12004014 */  bnez       $v0, .L800DEADC
    /* CF294 800DEA94 00000000 */   nop
    /* CF298 800DEA98 0800E88C */  lw         $t0, 0x8($a3)
    /* CF29C 800DEA9C 0800838C */  lw         $v1, 0x8($a0)
    /* CF2A0 800DEAA0 00000000 */  nop
    /* CF2A4 800DEAA4 23280301 */  subu       $a1, $t0, $v1
    /* CF2A8 800DEAA8 0700A018 */  blez       $a1, .L800DEAC8
    /* CF2AC 800DEAAC 0F00023C */   lui       $v0, (0xFFFFF >> 16)
    /* CF2B0 800DEAB0 FFFF4234 */  ori        $v0, $v0, (0xFFFFF & 0xFFFF)
    /* CF2B4 800DEAB4 2A104500 */  slt        $v0, $v0, $a1
    /* CF2B8 800DEAB8 09004010 */  beqz       $v0, .L800DEAE0
    /* CF2BC 800DEABC 00000000 */   nop
    /* CF2C0 800DEAC0 B87A0308 */  j          .L800DEAE0
    /* CF2C4 800DEAC4 01000924 */   addiu     $t1, $zero, 0x1
  .L800DEAC8:
    /* CF2C8 800DEAC8 FFFF4234 */  ori        $v0, $v0, (0xFFFFF & 0xFFFF)
    /* CF2CC 800DEACC 23186800 */  subu       $v1, $v1, $t0
    /* CF2D0 800DEAD0 2A104300 */  slt        $v0, $v0, $v1
    /* CF2D4 800DEAD4 02004010 */  beqz       $v0, .L800DEAE0
    /* CF2D8 800DEAD8 00000000 */   nop
  .L800DEADC:
    /* CF2DC 800DEADC 01000924 */  addiu      $t1, $zero, 0x1
  .L800DEAE0:
    /* CF2E0 800DEAE0 20002011 */  beqz       $t1, .L800DEB64
    /* CF2E4 800DEAE4 00000000 */   nop
    /* CF2E8 800DEAE8 8015838F */  lw         $v1, %gp_rel(gCountSm)($gp)
    /* CF2EC 800DEAEC 8815858F */  lw         $a1, %gp_rel(gMaxSChunk)($gp)
    /* CF2F0 800DEAF0 00000000 */  nop
    /* CF2F4 800DEAF4 2A106500 */  slt        $v0, $v1, $a1
    /* CF2F8 800DEAF8 05004010 */  beqz       $v0, .L800DEB10
    /* CF2FC 800DEAFC 01006224 */   addiu     $v0, $v1, 0x1
    /* CF300 800DEB00 841583AF */  sw         $v1, %gp_rel(gUseSm)($gp)
    /* CF304 800DEB04 801582AF */  sw         $v0, %gp_rel(gCountSm)($gp)
    /* CF308 800DEB08 CD7A0308 */  j          .L800DEB34
    /* CF30C 800DEB0C 00000000 */   nop
  .L800DEB10:
    /* CF310 800DEB10 8415838F */  lw         $v1, %gp_rel(gUseSm)($gp)
    /* CF314 800DEB14 FFFFA224 */  addiu      $v0, $a1, -0x1
    /* CF318 800DEB18 2A106200 */  slt        $v0, $v1, $v0
    /* CF31C 800DEB1C 04004010 */  beqz       $v0, .L800DEB30
    /* CF320 800DEB20 01006224 */   addiu     $v0, $v1, 0x1
    /* CF324 800DEB24 841582AF */  sw         $v0, %gp_rel(gUseSm)($gp)
    /* CF328 800DEB28 CD7A0308 */  j          .L800DEB34
    /* CF32C 800DEB2C 00000000 */   nop
  .L800DEB30:
    /* CF330 800DEB30 841580AF */  sw         $zero, %gp_rel(gUseSm)($gp)
  .L800DEB34:
    /* CF334 800DEB34 8415828F */  lw         $v0, %gp_rel(gUseSm)($gp)
    /* CF338 800DEB38 00000000 */  nop
    /* CF33C 800DEB3C 40180200 */  sll        $v1, $v0, 1
    /* CF340 800DEB40 21186200 */  addu       $v1, $v1, $v0
    /* CF344 800DEB44 80180300 */  sll        $v1, $v1, 2
    /* CF348 800DEB48 23186200 */  subu       $v1, $v1, $v0
    /* CF34C 800DEB4C 80180300 */  sll        $v1, $v1, 2
    /* CF350 800DEB50 23186200 */  subu       $v1, $v1, $v0
    /* CF354 800DEB54 7C15828F */  lw         $v0, %gp_rel(gSm)($gp)
    /* CF358 800DEB58 00190300 */  sll        $v1, $v1, 4
    /* CF35C 800DEB5C 21384300 */  addu       $a3, $v0, $v1
    /* CF360 800DEB60 0C00E0A4 */  sh         $zero, 0xC($a3)
  .L800DEB64:
    /* CF364 800DEB64 0C00E284 */  lh         $v0, 0xC($a3)
    /* CF368 800DEB68 00000000 */  nop
    /* CF36C 800DEB6C 08004014 */  bnez       $v0, .L800DEB90
    /* CF370 800DEB70 00000000 */   nop
    /* CF374 800DEB74 00008A8C */  lw         $t2, 0x0($a0)
    /* CF378 800DEB78 04008B8C */  lw         $t3, 0x4($a0)
    /* CF37C 800DEB7C 08008C8C */  lw         $t4, 0x8($a0)
    /* CF380 800DEB80 0000EAAC */  sw         $t2, 0x0($a3)
    /* CF384 800DEB84 0400EBAC */  sw         $t3, 0x4($a3)
    /* CF388 800DEB88 0800ECAC */  sw         $t4, 0x8($a3)
    /* CF38C 800DEB8C 0E00E6A4 */  sh         $a2, 0xE($a3)
  .L800DEB90:
    /* CF390 800DEB90 0800E003 */  jr         $ra
    /* CF394 800DEB94 2110E000 */   addu      $v0, $a3, $zero
endlabel Skidmark_CheckChunk__FP8coorddefii
