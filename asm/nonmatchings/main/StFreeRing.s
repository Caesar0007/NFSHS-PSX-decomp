.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching StFreeRing, 0xAC

glabel StFreeRing
    /* EB194 800FA994 0882053C */  lui        $a1, (0x82082083 >> 16)
    /* EB198 800FA998 8320A534 */  ori        $a1, $a1, (0x82082083 & 0xFFFF)
    /* EB19C 800FA99C 1480023C */  lui        $v0, %hi(StRingSize)
    /* EB1A0 800FA9A0 BC6C428C */  lw         $v0, %lo(StRingSize)($v0)
    /* EB1A4 800FA9A4 1480033C */  lui        $v1, %hi(StRingAddr)
    /* EB1A8 800FA9A8 AC6C638C */  lw         $v1, %lo(StRingAddr)($v1)
    /* EB1AC 800FA9AC 40110200 */  sll        $v0, $v0, 5
    /* EB1B0 800FA9B0 21106200 */  addu       $v0, $v1, $v0
    /* EB1B4 800FA9B4 23208200 */  subu       $a0, $a0, $v0
    /* EB1B8 800FA9B8 83100400 */  sra        $v0, $a0, 2
    /* EB1BC 800FA9BC 18004500 */  mult       $v0, $a1
    /* EB1C0 800FA9C0 C3270400 */  sra        $a0, $a0, 31
    /* EB1C4 800FA9C4 10380000 */  mfhi       $a3
    /* EB1C8 800FA9C8 2110E200 */  addu       $v0, $a3, $v0
    /* EB1CC 800FA9CC 03120200 */  sra        $v0, $v0, 8
    /* EB1D0 800FA9D0 23284400 */  subu       $a1, $v0, $a0
    /* EB1D4 800FA9D4 40110500 */  sll        $v0, $a1, 5
    /* EB1D8 800FA9D8 21186200 */  addu       $v1, $v1, $v0
    /* EB1DC 800FA9DC 04000424 */  addiu      $a0, $zero, 0x4
    /* EB1E0 800FA9E0 00006284 */  lh         $v0, 0x0($v1)
    /* EB1E4 800FA9E4 06006394 */  lhu        $v1, 0x6($v1)
    /* EB1E8 800FA9E8 13004414 */  bne        $v0, $a0, .L800FAA38
    /* EB1EC 800FA9EC 01000224 */   addiu     $v0, $zero, 0x1
    /* EB1F0 800FA9F0 00140300 */  sll        $v0, $v1, 16
    /* EB1F4 800FA9F4 03140200 */  sra        $v0, $v0, 16
    /* EB1F8 800FA9F8 0B004018 */  blez       $v0, .L800FAA28
    /* EB1FC 800FA9FC 21200000 */   addu      $a0, $zero, $zero
    /* EB200 800FAA00 21304000 */  addu       $a2, $v0, $zero
  .L800FAA04:
    /* EB204 800FAA04 21108500 */  addu       $v0, $a0, $a1
    /* EB208 800FAA08 01008424 */  addiu      $a0, $a0, 0x1
    /* EB20C 800FAA0C 1480033C */  lui        $v1, %hi(StRingAddr)
    /* EB210 800FAA10 AC6C638C */  lw         $v1, %lo(StRingAddr)($v1)
    /* EB214 800FAA14 40110200 */  sll        $v0, $v0, 5
    /* EB218 800FAA18 21186200 */  addu       $v1, $v1, $v0
    /* EB21C 800FAA1C 2A108600 */  slt        $v0, $a0, $a2
    /* EB220 800FAA20 F8FF4014 */  bnez       $v0, .L800FAA04
    /* EB224 800FAA24 000060A4 */   sh        $zero, 0x0($v1)
  .L800FAA28:
    /* EB228 800FAA28 21108500 */  addu       $v0, $a0, $a1
    /* EB22C 800FAA2C 1480013C */  lui        $at, %hi(StRingIdx3)
    /* EB230 800FAA30 B86C22AC */  sw         $v0, %lo(StRingIdx3)($at)
    /* EB234 800FAA34 21100000 */  addu       $v0, $zero, $zero
  .L800FAA38:
    /* EB238 800FAA38 0800E003 */  jr         $ra
    /* EB23C 800FAA3C 00000000 */   nop
endlabel StFreeRing
    /* EB240 800FAA40 00000000 */  nop
