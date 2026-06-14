.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_800FB118, 0x13C

glabel func_800FB118
    /* EB918 800FB118 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* EB91C 800FB11C 1400B1AF */  sw         $s1, 0x14($sp)
    /* EB920 800FB120 21888000 */  addu       $s1, $a0, $zero
    /* EB924 800FB124 1800BFAF */  sw         $ra, 0x18($sp)
    /* EB928 800FB128 1000B0AF */  sw         $s0, 0x10($sp)
    /* EB92C 800FB12C 0000238E */  lw         $v1, 0x0($s1)
    /* EB930 800FB130 0A001024 */  addiu      $s0, $zero, 0xA
    /* EB934 800FB134 0E007010 */  beq        $v1, $s0, .L800FB170
    /* EB938 800FB138 0B006228 */   slti      $v0, $v1, 0xB
    /* EB93C 800FB13C 05004010 */  beqz       $v0, .L800FB154
    /* EB940 800FB140 1E000224 */   addiu     $v0, $zero, 0x1E
    /* EB944 800FB144 07006010 */  beqz       $v1, .L800FB164
    /* EB948 800FB148 21100000 */   addu      $v0, $zero, $zero
    /* EB94C 800FB14C 90EC0308 */  j          .L800FB240
    /* EB950 800FB150 00000000 */   nop
  .L800FB154:
    /* EB954 800FB154 1D006210 */  beq        $v1, $v0, .L800FB1CC
    /* EB958 800FB158 21100000 */   addu      $v0, $zero, $zero
    /* EB95C 800FB15C 90EC0308 */  j          .L800FB240
    /* EB960 800FB160 00000000 */   nop
  .L800FB164:
    /* EB964 800FB164 1380013C */  lui        $at, %hi(D_80136CB8)
    /* EB968 800FB168 B86C20AC */  sw         $zero, %lo(D_80136CB8)($at)
    /* EB96C 800FB16C 000030AE */  sw         $s0, 0x0($s1)
  .L800FB170:
    /* EB970 800FB170 1480103C */  lui        $s0, %hi(D_80147528)
    /* EB974 800FB174 28751026 */  addiu      $s0, $s0, %lo(D_80147528)
  .L800FB178:
    /* EB978 800FB178 0000048E */  lw         $a0, 0x0($s0)
    /* EB97C 800FB17C 0400058E */  lw         $a1, 0x4($s0)
    /* EB980 800FB180 6427040C */  jal        lseek
    /* EB984 800FB184 21300000 */   addu      $a2, $zero, $zero
    /* EB988 800FB188 0400038E */  lw         $v1, 0x4($s0)
    /* EB98C 800FB18C 00000000 */  nop
    /* EB990 800FB190 F9FF4314 */  bne        $v0, $v1, .L800FB178
    /* EB994 800FB194 00000000 */   nop
    /* EB998 800FB198 3426040C */  jal        _clr_card_event
    /* EB99C 800FB19C 00000000 */   nop
    /* EB9A0 800FB1A0 1480103C */  lui        $s0, %hi(D_80147528)
    /* EB9A4 800FB1A4 28751026 */  addiu      $s0, $s0, %lo(D_80147528)
  .L800FB1A8:
    /* EB9A8 800FB1A8 0000048E */  lw         $a0, 0x0($s0)
    /* EB9AC 800FB1AC 0C00058E */  lw         $a1, 0xC($s0)
    /* EB9B0 800FB1B0 0800068E */  lw         $a2, 0x8($s0)
    /* EB9B4 800FB1B4 6827040C */  jal        read
    /* EB9B8 800FB1B8 00000000 */   nop
    /* EB9BC 800FB1BC FAFF4014 */  bnez       $v0, .L800FB1A8
    /* EB9C0 800FB1C0 1E000224 */   addiu     $v0, $zero, 0x1E
    /* EB9C4 800FB1C4 8FEC0308 */  j          .L800FB23C
    /* EB9C8 800FB1C8 000022AE */   sw        $v0, 0x0($s1)
  .L800FB1CC:
    /* EB9CC 800FB1CC E226040C */  jal        _chk_card_event
    /* EB9D0 800FB1D0 00000000 */   nop
    /* EB9D4 800FB1D4 1A004010 */  beqz       $v0, .L800FB240
    /* EB9D8 800FB1D8 21100000 */   addu      $v0, $zero, $zero
    /* EB9DC 800FB1DC 7626040C */  jal        _get_card_event
    /* EB9E0 800FB1E0 00000000 */   nop
    /* EB9E4 800FB1E4 21204000 */  addu       $a0, $v0, $zero
    /* EB9E8 800FB1E8 0C008010 */  beqz       $a0, .L800FB21C
    /* EB9EC 800FB1EC 00000000 */   nop
    /* EB9F0 800FB1F0 1380023C */  lui        $v0, %hi(D_80136CB8)
    /* EB9F4 800FB1F4 B86C428C */  lw         $v0, %lo(D_80136CB8)($v0)
    /* EB9F8 800FB1F8 00000000 */  nop
    /* EB9FC 800FB1FC 01004224 */  addiu      $v0, $v0, 0x1
    /* EBA00 800FB200 1380013C */  lui        $at, %hi(D_80136CB8)
    /* EBA04 800FB204 B86C22AC */  sw         $v0, %lo(D_80136CB8)($at)
    /* EBA08 800FB208 04004228 */  slti       $v0, $v0, 0x4
    /* EBA0C 800FB20C 04004010 */  beqz       $v0, .L800FB220
    /* EBA10 800FB210 00000000 */   nop
    /* EBA14 800FB214 8FEC0308 */  j          .L800FB23C
    /* EBA18 800FB218 000030AE */   sw        $s0, 0x0($s1)
  .L800FB21C:
    /* EBA1C 800FB21C 21200000 */  addu       $a0, $zero, $zero
  .L800FB220:
    /* EBA20 800FB220 47F0030C */  jal        func_800FC11C
    /* EBA24 800FB224 00000000 */   nop
    /* EBA28 800FB228 1480033C */  lui        $v1, %hi(D_80147518)
    /* EBA2C 800FB22C 18756324 */  addiu      $v1, $v1, %lo(D_80147518)
    /* EBA30 800FB230 040062AC */  sw         $v0, 0x4($v1)
    /* EBA34 800FB234 90EC0308 */  j          .L800FB240
    /* EBA38 800FB238 01000224 */   addiu     $v0, $zero, 0x1
  .L800FB23C:
    /* EBA3C 800FB23C 21100000 */  addu       $v0, $zero, $zero
  .L800FB240:
    /* EBA40 800FB240 1800BF8F */  lw         $ra, 0x18($sp)
    /* EBA44 800FB244 1400B18F */  lw         $s1, 0x14($sp)
    /* EBA48 800FB248 1000B08F */  lw         $s0, 0x10($sp)
    /* EBA4C 800FB24C 0800E003 */  jr         $ra
    /* EBA50 800FB250 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel func_800FB118
