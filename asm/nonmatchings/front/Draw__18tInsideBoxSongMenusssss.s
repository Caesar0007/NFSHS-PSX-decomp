.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Draw__18tInsideBoxSongMenusssss, 0x270

glabel Draw__18tInsideBoxSongMenusssss
    /* F1D8 8001E9D8 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* F1DC 8001E9DC 2800B2AF */  sw         $s2, 0x28($sp)
    /* F1E0 8001E9E0 21908000 */  addu       $s2, $a0, $zero
    /* F1E4 8001E9E4 0580023C */  lui        $v0, %hi(screenAudio)
    /* F1E8 8001E9E8 E828428C */  lw         $v0, %lo(screenAudio)($v0)
    /* F1EC 8001E9EC 5C00A48F */  lw         $a0, 0x5C($sp)
    /* F1F0 8001E9F0 3C00B7AF */  sw         $s7, 0x3C($sp)
    /* F1F4 8001E9F4 4400BFAF */  sw         $ra, 0x44($sp)
    /* F1F8 8001E9F8 4000BEAF */  sw         $fp, 0x40($sp)
    /* F1FC 8001E9FC 3800B6AF */  sw         $s6, 0x38($sp)
    /* F200 8001EA00 3400B5AF */  sw         $s5, 0x34($sp)
    /* F204 8001EA04 3000B4AF */  sw         $s4, 0x30($sp)
    /* F208 8001EA08 2C00B3AF */  sw         $s3, 0x2C($sp)
    /* F20C 8001EA0C 2400B1AF */  sw         $s1, 0x24($sp)
    /* F210 8001EA10 2000B0AF */  sw         $s0, 0x20($sp)
    /* F214 8001EA14 7800428C */  lw         $v0, 0x78($v0)
    /* F218 8001EA18 5800B697 */  lhu        $s6, 0x58($sp)
    /* F21C 8001EA1C 7E004010 */  beqz       $v0, .L8001EC18
    /* F220 8001EA20 21B8A000 */   addu      $s7, $a1, $zero
    /* F224 8001EA24 001C0600 */  sll        $v1, $a2, 16
    /* F228 8001EA28 031C0300 */  sra        $v1, $v1, 16
    /* F22C 8001EA2C 00140400 */  sll        $v0, $a0, 16
    /* F230 8001EA30 03140200 */  sra        $v0, $v0, 16
    /* F234 8001EA34 EBFF4224 */  addiu      $v0, $v0, -0x15
    /* F238 8001EA38 43100200 */  sra        $v0, $v0, 1
    /* F23C 8001EA3C 21A86200 */  addu       $s5, $v1, $v0
    /* F240 8001EA40 21880000 */  addu       $s1, $zero, $zero
    /* F244 8001EA44 02000424 */  addiu      $a0, $zero, 0x2
    /* F248 8001EA48 21184002 */  addu       $v1, $s2, $zero
  .L8001EA4C:
    /* F24C 8001EA4C 08002412 */  beq        $s1, $a0, .L8001EA70
    /* F250 8001EA50 00000000 */   nop
    /* F254 8001EA54 7E006284 */  lh         $v0, 0x7E($v1)
    /* F258 8001EA58 00000000 */  nop
    /* F25C 8001EA5C F8FF4224 */  addiu      $v0, $v0, -0x8
    /* F260 8001EA60 02004104 */  bgez       $v0, .L8001EA6C
    /* F264 8001EA64 00000000 */   nop
    /* F268 8001EA68 21100000 */  addu       $v0, $zero, $zero
  .L8001EA6C:
    /* F26C 8001EA6C 7E0062A4 */  sh         $v0, 0x7E($v1)
  .L8001EA70:
    /* F270 8001EA70 01003126 */  addiu      $s1, $s1, 0x1
    /* F274 8001EA74 0500222A */  slti       $v0, $s1, 0x5
    /* F278 8001EA78 F4FF4014 */  bnez       $v0, .L8001EA4C
    /* F27C 8001EA7C 02006324 */   addiu     $v1, $v1, 0x2
    /* F280 8001EA80 82004286 */  lh         $v0, 0x82($s2)
    /* F284 8001EA84 00000000 */  nop
    /* F288 8001EA88 08004324 */  addiu      $v1, $v0, 0x8
    /* F28C 8001EA8C 81006228 */  slti       $v0, $v1, 0x81
    /* F290 8001EA90 02004014 */  bnez       $v0, .L8001EA9C
    /* F294 8001EA94 00000000 */   nop
    /* F298 8001EA98 80000324 */  addiu      $v1, $zero, 0x80
  .L8001EA9C:
    /* F29C 8001EA9C 6E004286 */  lh         $v0, 0x6E($s2)
    /* F2A0 8001EAA0 6E004496 */  lhu        $a0, 0x6E($s2)
    /* F2A4 8001EAA4 14004010 */  beqz       $v0, .L8001EAF8
    /* F2A8 8001EAA8 820043A6 */   sh        $v1, 0x82($s2)
    /* F2AC 8001EAAC 70004296 */  lhu        $v0, 0x70($s2)
    /* F2B0 8001EAB0 70004386 */  lh         $v1, 0x70($s2)
    /* F2B4 8001EAB4 40100200 */  sll        $v0, $v0, 1
    /* F2B8 8001EAB8 21108200 */  addu       $v0, $a0, $v0
    /* F2BC 8001EABC 05006104 */  bgez       $v1, .L8001EAD4
    /* F2C0 8001EAC0 6E0042A6 */   sh        $v0, 0x6E($s2)
    /* F2C4 8001EAC4 00140200 */  sll        $v0, $v0, 16
    /* F2C8 8001EAC8 02004104 */  bgez       $v0, .L8001EAD4
    /* F2CC 8001EACC 00000000 */   nop
    /* F2D0 8001EAD0 6E0040A6 */  sh         $zero, 0x6E($s2)
  .L8001EAD4:
    /* F2D4 8001EAD4 70004286 */  lh         $v0, 0x70($s2)
    /* F2D8 8001EAD8 00000000 */  nop
    /* F2DC 8001EADC 07004018 */  blez       $v0, .L8001EAFC
    /* F2E0 8001EAE0 21880000 */   addu      $s1, $zero, $zero
    /* F2E4 8001EAE4 6E004286 */  lh         $v0, 0x6E($s2)
    /* F2E8 8001EAE8 00000000 */  nop
    /* F2EC 8001EAEC 04004018 */  blez       $v0, .L8001EB00
    /* F2F0 8001EAF0 1180023C */   lui       $v0, %hi(frontEnd)
    /* F2F4 8001EAF4 6E0040A6 */  sh         $zero, 0x6E($s2)
  .L8001EAF8:
    /* F2F8 8001EAF8 21880000 */  addu       $s1, $zero, $zero
  .L8001EAFC:
    /* F2FC 8001EAFC 1180023C */  lui        $v0, %hi(frontEnd)
  .L8001EB00:
    /* F300 8001EB00 00465E24 */  addiu      $fp, $v0, %lo(frontEnd)
    /* F304 8001EB04 00140700 */  sll        $v0, $a3, 16
    /* F308 8001EB08 03A40200 */  sra        $s4, $v0, 16
    /* F30C 8001EB0C D8FF1324 */  addiu      $s3, $zero, -0x28
    /* F310 8001EB10 21804002 */  addu       $s0, $s2, $zero
  .L8001EB14:
    /* F314 8001EB14 0580023C */  lui        $v0, %hi(screenAudio)
    /* F318 8001EB18 E828438C */  lw         $v1, %lo(screenAudio)($v0)
    /* F31C 8001EB1C 00000000 */  nop
    /* F320 8001EB20 74006284 */  lh         $v0, 0x74($v1)
    /* F324 8001EB24 00000000 */  nop
    /* F328 8001EB28 21105100 */  addu       $v0, $v0, $s1
    /* F32C 8001EB2C FEFF4524 */  addiu      $a1, $v0, -0x2
    /* F330 8001EB30 3400A004 */  bltz       $a1, .L8001EC04
    /* F334 8001EB34 00000000 */   nop
    /* F338 8001EB38 7800628C */  lw         $v0, 0x78($v1)
    /* F33C 8001EB3C 00000000 */  nop
    /* F340 8001EB40 0000428C */  lw         $v0, 0x0($v0)
    /* F344 8001EB44 00000000 */  nop
    /* F348 8001EB48 2A10A200 */  slt        $v0, $a1, $v0
    /* F34C 8001EB4C 2D004010 */  beqz       $v0, .L8001EC04
    /* F350 8001EB50 80100500 */   sll       $v0, $a1, 2
    /* F354 8001EB54 21105E00 */  addu       $v0, $v0, $fp
    /* F358 8001EB58 9C03428C */  lw         $v0, 0x39C($v0)
    /* F35C 8001EB5C 00000000 */  nop
    /* F360 8001EB60 04004010 */  beqz       $v0, .L8001EB74
    /* F364 8001EB64 00000000 */   nop
    /* F368 8001EB68 74000296 */  lhu        $v0, 0x74($s0)
    /* F36C 8001EB6C E07A0008 */  j          .L8001EB80
    /* F370 8001EB70 20004224 */   addiu     $v0, $v0, 0x20
  .L8001EB74:
    /* F374 8001EB74 74000296 */  lhu        $v0, 0x74($s0)
    /* F378 8001EB78 00000000 */  nop
    /* F37C 8001EB7C E0FF4224 */  addiu      $v0, $v0, -0x20
  .L8001EB80:
    /* F380 8001EB80 740002A6 */  sh         $v0, 0x74($s0)
    /* F384 8001EB84 74000286 */  lh         $v0, 0x74($s0)
    /* F388 8001EB88 00000000 */  nop
    /* F38C 8001EB8C 81004228 */  slti       $v0, $v0, 0x81
    /* F390 8001EB90 02004014 */  bnez       $v0, .L8001EB9C
    /* F394 8001EB94 80000224 */   addiu     $v0, $zero, 0x80
    /* F398 8001EB98 740002A6 */  sh         $v0, 0x74($s0)
  .L8001EB9C:
    /* F39C 8001EB9C 74000286 */  lh         $v0, 0x74($s0)
    /* F3A0 8001EBA0 00000000 */  nop
    /* F3A4 8001EBA4 02004104 */  bgez       $v0, .L8001EBB0
    /* F3A8 8001EBA8 00000000 */   nop
    /* F3AC 8001EBAC 740000A6 */  sh         $zero, 0x74($s0)
  .L8001EBB0:
    /* F3B0 8001EBB0 002C0500 */  sll        $a1, $a1, 16
    /* F3B4 8001EBB4 00341700 */  sll        $a2, $s7, 16
    /* F3B8 8001EBB8 6800438E */  lw         $v1, 0x68($s2)
    /* F3BC 8001EBBC 6E004796 */  lhu        $a3, 0x6E($s2)
    /* F3C0 8001EBC0 60006484 */  lh         $a0, 0x60($v1)
    /* F3C4 8001EBC4 032C0500 */  sra        $a1, $a1, 16
    /* F3C8 8001EBC8 1000B4AF */  sw         $s4, 0x10($sp)
    /* F3CC 8001EBCC 74000286 */  lh         $v0, 0x74($s0)
    /* F3D0 8001EBD0 03340600 */  sra        $a2, $a2, 16
    /* F3D4 8001EBD4 1400A2AF */  sw         $v0, 0x14($sp)
    /* F3D8 8001EBD8 7E000286 */  lh         $v0, 0x7E($s0)
    /* F3DC 8001EBDC 21204402 */  addu       $a0, $s2, $a0
    /* F3E0 8001EBE0 1800A2AF */  sw         $v0, 0x18($sp)
    /* F3E4 8001EBE4 2110B302 */  addu       $v0, $s5, $s3
    /* F3E8 8001EBE8 2138E200 */  addu       $a3, $a3, $v0
    /* F3EC 8001EBEC 2138C702 */  addu       $a3, $s6, $a3
    /* F3F0 8001EBF0 003C0700 */  sll        $a3, $a3, 16
    /* F3F4 8001EBF4 6400628C */  lw         $v0, 0x64($v1)
    /* F3F8 8001EBF8 00000000 */  nop
    /* F3FC 8001EBFC 09F84000 */  jalr       $v0
    /* F400 8001EC00 033C0700 */   sra       $a3, $a3, 16
  .L8001EC04:
    /* F404 8001EC04 15007326 */  addiu      $s3, $s3, 0x15
    /* F408 8001EC08 01003126 */  addiu      $s1, $s1, 0x1
    /* F40C 8001EC0C 0500222A */  slti       $v0, $s1, 0x5
    /* F410 8001EC10 C0FF4014 */  bnez       $v0, .L8001EB14
    /* F414 8001EC14 02001026 */   addiu     $s0, $s0, 0x2
  .L8001EC18:
    /* F418 8001EC18 4400BF8F */  lw         $ra, 0x44($sp)
    /* F41C 8001EC1C 4000BE8F */  lw         $fp, 0x40($sp)
    /* F420 8001EC20 3C00B78F */  lw         $s7, 0x3C($sp)
    /* F424 8001EC24 3800B68F */  lw         $s6, 0x38($sp)
    /* F428 8001EC28 3400B58F */  lw         $s5, 0x34($sp)
    /* F42C 8001EC2C 3000B48F */  lw         $s4, 0x30($sp)
    /* F430 8001EC30 2C00B38F */  lw         $s3, 0x2C($sp)
    /* F434 8001EC34 2800B28F */  lw         $s2, 0x28($sp)
    /* F438 8001EC38 2400B18F */  lw         $s1, 0x24($sp)
    /* F43C 8001EC3C 2000B08F */  lw         $s0, 0x20($sp)
    /* F440 8001EC40 0800E003 */  jr         $ra
    /* F444 8001EC44 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel Draw__18tInsideBoxSongMenusssss
