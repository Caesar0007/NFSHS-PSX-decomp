.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching RawFindClosestSlice__FP8coorddefP12BWorldSm_Pos, 0x2B4

glabel RawFindClosestSlice__FP8coorddefP12BWorldSm_Pos
    /* 6F2B0 8007EAB0 21588000 */  addu       $t3, $a0, $zero
    /* 6F2B4 8007EAB4 FFFF0E24 */  addiu      $t6, $zero, -0x1
    /* 6F2B8 8007EAB8 7C02828F */  lw         $v0, %gp_rel(gNumSlices)($gp)
    /* 6F2BC 8007EABC 0000A684 */  lh         $a2, 0x0($a1)
    /* 6F2C0 8007EAC0 74028C8F */  lw         $t4, %gp_rel(BWorldSm_slices)($gp)
    /* 6F2C4 8007EAC4 A500CE10 */  beq        $a2, $t6, .L8007ED5C
    /* 6F2C8 8007EAC8 21684E00 */   addu      $t5, $v0, $t6
    /* 6F2CC 8007EACC 21484000 */  addu       $t1, $v0, $zero
    /* 6F2D0 8007EAD0 2A10CD00 */  slt        $v0, $a2, $t5
  .L8007EAD4:
    /* 6F2D4 8007EAD4 05004010 */  beqz       $v0, .L8007EAEC
    /* 6F2D8 8007EAD8 2170C000 */   addu      $t6, $a2, $zero
    /* 6F2DC 8007EADC 40210600 */  sll        $a0, $a2, 5
    /* 6F2E0 8007EAE0 0000628D */  lw         $v0, 0x0($t3)
    /* 6F2E4 8007EAE4 C9FA0108 */  j          .L8007EB24
    /* 6F2E8 8007EAE8 21208C00 */   addu      $a0, $a0, $t4
  .L8007EAEC:
    /* 6F2EC 8007EAEC 1A00C900 */  div        $zero, $a2, $t1
    /* 6F2F0 8007EAF0 02002015 */  bnez       $t1, .L8007EAFC
    /* 6F2F4 8007EAF4 00000000 */   nop
    /* 6F2F8 8007EAF8 0D000700 */  break      7
  .L8007EAFC:
    /* 6F2FC 8007EAFC FFFF0124 */  addiu      $at, $zero, -0x1
    /* 6F300 8007EB00 04002115 */  bne        $t1, $at, .L8007EB14
    /* 6F304 8007EB04 0080013C */   lui       $at, (0x80000000 >> 16)
    /* 6F308 8007EB08 0200C114 */  bne        $a2, $at, .L8007EB14
    /* 6F30C 8007EB0C 00000000 */   nop
    /* 6F310 8007EB10 0D000600 */  break      6
  .L8007EB14:
    /* 6F314 8007EB14 10200000 */  mfhi       $a0
    /* 6F318 8007EB18 0000628D */  lw         $v0, 0x0($t3)
    /* 6F31C 8007EB1C 40210400 */  sll        $a0, $a0, 5
    /* 6F320 8007EB20 21208C00 */  addu       $a0, $a0, $t4
  .L8007EB24:
    /* 6F324 8007EB24 0000838C */  lw         $v1, 0x0($a0)
    /* 6F328 8007EB28 00000000 */  nop
    /* 6F32C 8007EB2C 23104300 */  subu       $v0, $v0, $v1
    /* 6F330 8007EB30 43120200 */  sra        $v0, $v0, 9
    /* 6F334 8007EB34 18004200 */  mult       $v0, $v0
    /* 6F338 8007EB38 0800628D */  lw         $v0, 0x8($t3)
    /* 6F33C 8007EB3C 0800838C */  lw         $v1, 0x8($a0)
    /* 6F340 8007EB40 12380000 */  mflo       $a3
    /* 6F344 8007EB44 23104300 */  subu       $v0, $v0, $v1
    /* 6F348 8007EB48 43120200 */  sra        $v0, $v0, 9
    /* 6F34C 8007EB4C 18004200 */  mult       $v0, $v0
    /* 6F350 8007EB50 12100000 */  mflo       $v0
    /* 6F354 8007EB54 2150E200 */  addu       $t2, $a3, $v0
    /* 6F358 8007EB58 FFFFA225 */  addiu      $v0, $t5, -0x1
    /* 6F35C 8007EB5C 2A10C200 */  slt        $v0, $a2, $v0
    /* 6F360 8007EB60 15004010 */  beqz       $v0, .L8007EBB8
    /* 6F364 8007EB64 40210600 */   sll       $a0, $a2, 5
    /* 6F368 8007EB68 21208C00 */  addu       $a0, $a0, $t4
    /* 6F36C 8007EB6C 0000628D */  lw         $v0, 0x0($t3)
    /* 6F370 8007EB70 2000838C */  lw         $v1, 0x20($a0)
    /* 6F374 8007EB74 00000000 */  nop
    /* 6F378 8007EB78 23104300 */  subu       $v0, $v0, $v1
    /* 6F37C 8007EB7C 43120200 */  sra        $v0, $v0, 9
    /* 6F380 8007EB80 18004200 */  mult       $v0, $v0
    /* 6F384 8007EB84 0800628D */  lw         $v0, 0x8($t3)
    /* 6F388 8007EB88 2800838C */  lw         $v1, 0x28($a0)
    /* 6F38C 8007EB8C 12380000 */  mflo       $a3
    /* 6F390 8007EB90 23104300 */  subu       $v0, $v0, $v1
    /* 6F394 8007EB94 43120200 */  sra        $v0, $v0, 9
    /* 6F398 8007EB98 18004200 */  mult       $v0, $v0
    /* 6F39C 8007EB9C 12100000 */  mflo       $v0
    /* 6F3A0 8007EBA0 2110E200 */  addu       $v0, $a3, $v0
    /* 6F3A4 8007EBA4 2A104A00 */  slt        $v0, $v0, $t2
    /* 6F3A8 8007EBA8 24004010 */  beqz       $v0, .L8007EC3C
    /* 6F3AC 8007EBAC 00000000 */   nop
    /* 6F3B0 8007EBB0 54FB0108 */  j          .L8007ED50
    /* 6F3B4 8007EBB4 0100C624 */   addiu     $a2, $a2, 0x1
  .L8007EBB8:
    /* 6F3B8 8007EBB8 0100C224 */  addiu      $v0, $a2, 0x1
    /* 6F3BC 8007EBBC 1A004900 */  div        $zero, $v0, $t1
    /* 6F3C0 8007EBC0 02002015 */  bnez       $t1, .L8007EBCC
    /* 6F3C4 8007EBC4 00000000 */   nop
    /* 6F3C8 8007EBC8 0D000700 */  break      7
  .L8007EBCC:
    /* 6F3CC 8007EBCC FFFF0124 */  addiu      $at, $zero, -0x1
    /* 6F3D0 8007EBD0 04002115 */  bne        $t1, $at, .L8007EBE4
    /* 6F3D4 8007EBD4 0080013C */   lui       $at, (0x80000000 >> 16)
    /* 6F3D8 8007EBD8 02004114 */  bne        $v0, $at, .L8007EBE4
    /* 6F3DC 8007EBDC 00000000 */   nop
    /* 6F3E0 8007EBE0 0D000600 */  break      6
  .L8007EBE4:
    /* 6F3E4 8007EBE4 10400000 */  mfhi       $t0
    /* 6F3E8 8007EBE8 0000628D */  lw         $v0, 0x0($t3)
    /* 6F3EC 8007EBEC 40210800 */  sll        $a0, $t0, 5
    /* 6F3F0 8007EBF0 21208C00 */  addu       $a0, $a0, $t4
    /* 6F3F4 8007EBF4 0000838C */  lw         $v1, 0x0($a0)
    /* 6F3F8 8007EBF8 00000000 */  nop
    /* 6F3FC 8007EBFC 23104300 */  subu       $v0, $v0, $v1
    /* 6F400 8007EC00 43120200 */  sra        $v0, $v0, 9
    /* 6F404 8007EC04 18004200 */  mult       $v0, $v0
    /* 6F408 8007EC08 0800628D */  lw         $v0, 0x8($t3)
    /* 6F40C 8007EC0C 0800838C */  lw         $v1, 0x8($a0)
    /* 6F410 8007EC10 12380000 */  mflo       $a3
    /* 6F414 8007EC14 23104300 */  subu       $v0, $v0, $v1
    /* 6F418 8007EC18 43120200 */  sra        $v0, $v0, 9
    /* 6F41C 8007EC1C 18004200 */  mult       $v0, $v0
    /* 6F420 8007EC20 12100000 */  mflo       $v0
    /* 6F424 8007EC24 2110E200 */  addu       $v0, $a3, $v0
    /* 6F428 8007EC28 2A104A00 */  slt        $v0, $v0, $t2
    /* 6F42C 8007EC2C 03004010 */  beqz       $v0, .L8007EC3C
    /* 6F430 8007EC30 00000000 */   nop
    /* 6F434 8007EC34 54FB0108 */  j          .L8007ED50
    /* 6F438 8007EC38 21300001 */   addu      $a2, $t0, $zero
  .L8007EC3C:
    /* 6F43C 8007EC3C 1500C018 */  blez       $a2, .L8007EC94
    /* 6F440 8007EC40 40210600 */   sll       $a0, $a2, 5
    /* 6F444 8007EC44 21208C00 */  addu       $a0, $a0, $t4
    /* 6F448 8007EC48 0000628D */  lw         $v0, 0x0($t3)
    /* 6F44C 8007EC4C E0FF838C */  lw         $v1, -0x20($a0)
    /* 6F450 8007EC50 00000000 */  nop
    /* 6F454 8007EC54 23104300 */  subu       $v0, $v0, $v1
    /* 6F458 8007EC58 43120200 */  sra        $v0, $v0, 9
    /* 6F45C 8007EC5C 18004200 */  mult       $v0, $v0
    /* 6F460 8007EC60 0800628D */  lw         $v0, 0x8($t3)
    /* 6F464 8007EC64 E8FF838C */  lw         $v1, -0x18($a0)
    /* 6F468 8007EC68 12380000 */  mflo       $a3
    /* 6F46C 8007EC6C 23104300 */  subu       $v0, $v0, $v1
    /* 6F470 8007EC70 43120200 */  sra        $v0, $v0, 9
    /* 6F474 8007EC74 18004200 */  mult       $v0, $v0
    /* 6F478 8007EC78 12100000 */  mflo       $v0
    /* 6F47C 8007EC7C 2110E200 */  addu       $v0, $a3, $v0
    /* 6F480 8007EC80 2A104A00 */  slt        $v0, $v0, $t2
    /* 6F484 8007EC84 32004010 */  beqz       $v0, .L8007ED50
    /* 6F488 8007EC88 00000000 */   nop
    /* 6F48C 8007EC8C 54FB0108 */  j          .L8007ED50
    /* 6F490 8007EC90 FFFFC624 */   addiu     $a2, $a2, -0x1
  .L8007EC94:
    /* 6F494 8007EC94 0100C224 */  addiu      $v0, $a2, 0x1
    /* 6F498 8007EC98 21304D00 */  addu       $a2, $v0, $t5
    /* 6F49C 8007EC9C FFFFC724 */  addiu      $a3, $a2, -0x1
    /* 6F4A0 8007ECA0 1A00E900 */  div        $zero, $a3, $t1
    /* 6F4A4 8007ECA4 02002015 */  bnez       $t1, .L8007ECB0
    /* 6F4A8 8007ECA8 00000000 */   nop
    /* 6F4AC 8007ECAC 0D000700 */  break      7
  .L8007ECB0:
    /* 6F4B0 8007ECB0 FFFF0124 */  addiu      $at, $zero, -0x1
    /* 6F4B4 8007ECB4 04002115 */  bne        $t1, $at, .L8007ECC8
    /* 6F4B8 8007ECB8 0080013C */   lui       $at, (0x80000000 >> 16)
    /* 6F4BC 8007ECBC 0200E114 */  bne        $a3, $at, .L8007ECC8
    /* 6F4C0 8007ECC0 00000000 */   nop
    /* 6F4C4 8007ECC4 0D000600 */  break      6
  .L8007ECC8:
    /* 6F4C8 8007ECC8 10200000 */  mfhi       $a0
    /* 6F4CC 8007ECCC 0000628D */  lw         $v0, 0x0($t3)
    /* 6F4D0 8007ECD0 40210400 */  sll        $a0, $a0, 5
    /* 6F4D4 8007ECD4 21208C00 */  addu       $a0, $a0, $t4
    /* 6F4D8 8007ECD8 0000838C */  lw         $v1, 0x0($a0)
    /* 6F4DC 8007ECDC 00000000 */  nop
    /* 6F4E0 8007ECE0 23104300 */  subu       $v0, $v0, $v1
    /* 6F4E4 8007ECE4 43120200 */  sra        $v0, $v0, 9
    /* 6F4E8 8007ECE8 18004200 */  mult       $v0, $v0
    /* 6F4EC 8007ECEC 0800628D */  lw         $v0, 0x8($t3)
    /* 6F4F0 8007ECF0 0800838C */  lw         $v1, 0x8($a0)
    /* 6F4F4 8007ECF4 12400000 */  mflo       $t0
    /* 6F4F8 8007ECF8 23104300 */  subu       $v0, $v0, $v1
    /* 6F4FC 8007ECFC 43120200 */  sra        $v0, $v0, 9
    /* 6F500 8007ED00 18004200 */  mult       $v0, $v0
    /* 6F504 8007ED04 12100000 */  mflo       $v0
    /* 6F508 8007ED08 21100201 */  addu       $v0, $t0, $v0
    /* 6F50C 8007ED0C 2A104A00 */  slt        $v0, $v0, $t2
    /* 6F510 8007ED10 03004010 */  beqz       $v0, .L8007ED20
    /* 6F514 8007ED14 0100C224 */   addiu     $v0, $a2, 0x1
    /* 6F518 8007ED18 2130E000 */  addu       $a2, $a3, $zero
    /* 6F51C 8007ED1C 0100C224 */  addiu      $v0, $a2, 0x1
  .L8007ED20:
    /* 6F520 8007ED20 21304D00 */  addu       $a2, $v0, $t5
    /* 6F524 8007ED24 1A00C900 */  div        $zero, $a2, $t1
    /* 6F528 8007ED28 02002015 */  bnez       $t1, .L8007ED34
    /* 6F52C 8007ED2C 00000000 */   nop
    /* 6F530 8007ED30 0D000700 */  break      7
  .L8007ED34:
    /* 6F534 8007ED34 FFFF0124 */  addiu      $at, $zero, -0x1
    /* 6F538 8007ED38 04002115 */  bne        $t1, $at, .L8007ED4C
    /* 6F53C 8007ED3C 0080013C */   lui       $at, (0x80000000 >> 16)
    /* 6F540 8007ED40 0200C114 */  bne        $a2, $at, .L8007ED4C
    /* 6F544 8007ED44 00000000 */   nop
    /* 6F548 8007ED48 0D000600 */  break      6
  .L8007ED4C:
    /* 6F54C 8007ED4C 10300000 */  mfhi       $a2
  .L8007ED50:
    /* 6F550 8007ED50 00000000 */  nop
    /* 6F554 8007ED54 5FFFC615 */  bne        $t6, $a2, .L8007EAD4
    /* 6F558 8007ED58 2A10CD00 */   slt       $v0, $a2, $t5
  .L8007ED5C:
    /* 6F55C 8007ED5C 0800E003 */  jr         $ra
    /* 6F560 8007ED60 0000A6A4 */   sh        $a2, 0x0($a1)
endlabel RawFindClosestSlice__FP8coorddefP12BWorldSm_Pos
