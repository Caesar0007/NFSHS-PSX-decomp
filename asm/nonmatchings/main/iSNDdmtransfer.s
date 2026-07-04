.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDdmtransfer, 0x1E4

glabel iSNDdmtransfer
    /* FB080 8010A880 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* FB084 8010A884 1480023C */  lui        $v0, %hi(sndpd)
    /* FB088 8010A888 18794324 */  addiu      $v1, $v0, %lo(sndpd)
    /* FB08C 8010A88C 1800BFAF */  sw         $ra, 0x18($sp)
    /* FB090 8010A890 1400B1AF */  sw         $s1, 0x14($sp)
    /* FB094 8010A894 1000B0AF */  sw         $s0, 0x10($sp)
    /* FB098 8010A898 0C006290 */  lbu        $v0, 0xC($v1)
    /* FB09C 8010A89C 00601140 */  mfc0       $s1, $12 /* handwritten instruction */
    /* FB0A0 8010A8A0 00000000 */  nop
    /* FB0A4 8010A8A4 FEFB0124 */  addiu      $at, $zero, -0x402
    /* FB0A8 8010A8A8 24402102 */  and        $t0, $s1, $at
    /* FB0AC 8010A8AC 00608840 */  mtc0       $t0, $12 /* handwritten instruction */
    /* FB0B0 8010A8B0 00000000 */  nop
    /* FB0B4 8010A8B4 00000000 */  nop
    /* FB0B8 8010A8B8 00000000 */  nop
    /* FB0BC 8010A8BC 00160200 */  sll        $v0, $v0, 24
    /* FB0C0 8010A8C0 0400401C */  bgtz       $v0, .L8010A8D4
    /* FB0C4 8010A8C4 FFFF0624 */   addiu     $a2, $zero, -0x1
    /* FB0C8 8010A8C8 00609140 */  mtc0       $s1, $12 /* handwritten instruction */
    /* FB0CC 8010A8CC 942A0408 */  j          .L8010AA50
    /* FB0D0 8010A8D0 00000000 */   nop
  .L8010A8D4:
    /* FB0D4 8010A8D4 21280000 */  addu       $a1, $zero, $zero
    /* FB0D8 8010A8D8 01000224 */  addiu      $v0, $zero, 0x1
    /* FB0DC 8010A8DC 0E0062A0 */  sb         $v0, 0xE($v1)
    /* FB0E0 8010A8E0 2120A000 */  addu       $a0, $a1, $zero
    /* FB0E4 8010A8E4 21386000 */  addu       $a3, $v1, $zero
    /* FB0E8 8010A8E8 1000E324 */  addiu      $v1, $a3, 0x10
  .L8010A8EC:
    /* FB0EC 8010A8EC 0000628C */  lw         $v0, 0x0($v1)
    /* FB0F0 8010A8F0 00000000 */  nop
    /* FB0F4 8010A8F4 16004010 */  beqz       $v0, .L8010A950
    /* FB0F8 8010A8F8 00000000 */   nop
    /* FB0FC 8010A8FC 0B006290 */  lbu        $v0, 0xB($v1)
    /* FB100 8010A900 00000000 */  nop
    /* FB104 8010A904 2B10A200 */  sltu       $v0, $a1, $v0
    /* FB108 8010A908 06004010 */  beqz       $v0, .L8010A924
    /* FB10C 8010A90C 00000000 */   nop
    /* FB110 8010A910 0D00E4A0 */  sb         $a0, 0xD($a3)
    /* FB114 8010A914 0000668C */  lw         $a2, 0x0($v1)
    /* FB118 8010A918 0B006290 */  lbu        $v0, 0xB($v1)
    /* FB11C 8010A91C 542A0408 */  j          .L8010A950
    /* FB120 8010A920 FF004530 */   andi      $a1, $v0, 0xFF
  .L8010A924:
    /* FB124 8010A924 0B006290 */  lbu        $v0, 0xB($v1)
    /* FB128 8010A928 00000000 */  nop
    /* FB12C 8010A92C 08004514 */  bne        $v0, $a1, .L8010A950
    /* FB130 8010A930 00000000 */   nop
    /* FB134 8010A934 0000628C */  lw         $v0, 0x0($v1)
    /* FB138 8010A938 00000000 */  nop
    /* FB13C 8010A93C 2B104600 */  sltu       $v0, $v0, $a2
    /* FB140 8010A940 03004010 */  beqz       $v0, .L8010A950
    /* FB144 8010A944 00000000 */   nop
    /* FB148 8010A948 0D00E4A0 */  sb         $a0, 0xD($a3)
    /* FB14C 8010A94C 0000668C */  lw         $a2, 0x0($v1)
  .L8010A950:
    /* FB150 8010A950 01008424 */  addiu      $a0, $a0, 0x1
    /* FB154 8010A954 0A008228 */  slti       $v0, $a0, 0xA
    /* FB158 8010A958 E4FF4014 */  bnez       $v0, .L8010A8EC
    /* FB15C 8010A95C 14006324 */   addiu     $v1, $v1, 0x14
    /* FB160 8010A960 1480023C */  lui        $v0, %hi(sndpd)
    /* FB164 8010A964 18794424 */  addiu      $a0, $v0, %lo(sndpd)
    /* FB168 8010A968 0D008290 */  lbu        $v0, 0xD($a0)
    /* FB16C 8010A96C 00000000 */  nop
    /* FB170 8010A970 00160200 */  sll        $v0, $v0, 24
    /* FB174 8010A974 03160200 */  sra        $v0, $v0, 24
    /* FB178 8010A978 80180200 */  sll        $v1, $v0, 2
    /* FB17C 8010A97C 21186200 */  addu       $v1, $v1, $v0
    /* FB180 8010A980 80180300 */  sll        $v1, $v1, 2
    /* FB184 8010A984 10008224 */  addiu      $v0, $a0, 0x10
    /* FB188 8010A988 21806200 */  addu       $s0, $v1, $v0
    /* FB18C 8010A98C 0C000292 */  lbu        $v0, 0xC($s0)
    /* FB190 8010A990 00000000 */  nop
    /* FB194 8010A994 07004010 */  beqz       $v0, .L8010A9B4
    /* FB198 8010A998 01000224 */   addiu     $v0, $zero, 0x1
    /* FB19C 8010A99C 2807838C */  lw         $v1, 0x728($a0)
    /* FB1A0 8010A9A0 010082A0 */  sb         $v0, 0x1($a0)
    /* FB1A4 8010A9A4 04006010 */  beqz       $v1, .L8010A9B8
    /* FB1A8 8010A9A8 1480023C */   lui       $v0, %hi(sndgs)
    /* FB1AC 8010A9AC 09F86000 */  jalr       $v1
    /* FB1B0 8010A9B0 00000000 */   nop
  .L8010A9B4:
    /* FB1B4 8010A9B4 1480023C */  lui        $v0, %hi(sndgs)
  .L8010A9B8:
    /* FB1B8 8010A9B8 60784224 */  addiu      $v0, $v0, %lo(sndgs)
    /* FB1BC 8010A9BC 1480043C */  lui        $a0, %hi(sndpd)
    /* FB1C0 8010A9C0 4400428C */  lw         $v0, 0x44($v0)
    /* FB1C4 8010A9C4 18798424 */  addiu      $a0, $a0, %lo(sndpd)
    /* FB1C8 8010A9C8 0F004224 */  addiu      $v0, $v0, 0xF
    /* FB1CC 8010A9CC 100002AE */  sw         $v0, 0x10($s0)
    /* FB1D0 8010A9D0 1405838C */  lw         $v1, 0x514($a0)
    /* FB1D4 8010A9D4 08000296 */  lhu        $v0, 0x8($s0)
    /* FB1D8 8010A9D8 00000000 */  nop
    /* FB1DC 8010A9DC A60162A4 */  sh         $v0, 0x1A6($v1)
    /* FB1E0 8010A9E0 1405838C */  lw         $v1, 0x514($a0)
    /* FB1E4 8010A9E4 00000000 */  nop
    /* FB1E8 8010A9E8 AA016294 */  lhu        $v0, 0x1AA($v1)
    /* FB1EC 8010A9EC 00000000 */  nop
    /* FB1F0 8010A9F0 CFFF4230 */  andi       $v0, $v0, 0xFFCF
    /* FB1F4 8010A9F4 20004234 */  ori        $v0, $v0, 0x20
    /* FB1F8 8010A9F8 AA0162A4 */  sh         $v0, 0x1AA($v1)
    /* FB1FC 8010A9FC FC04858C */  lw         $a1, 0x4FC($a0)
    /* FB200 8010AA00 FFF0033C */  lui        $v1, (0xF0FFFFFF >> 16)
    /* FB204 8010AA04 0000A28C */  lw         $v0, 0x0($a1)
    /* FB208 8010AA08 FFFF6334 */  ori        $v1, $v1, (0xF0FFFFFF & 0xFFFF)
    /* FB20C 8010AA0C 24104300 */  and        $v0, $v0, $v1
    /* FB210 8010AA10 0020033C */  lui        $v1, (0x20000000 >> 16)
    /* FB214 8010AA14 25104300 */  or         $v0, $v0, $v1
    /* FB218 8010AA18 0000A2AC */  sw         $v0, 0x0($a1)
    /* FB21C 8010AA1C 0005838C */  lw         $v1, 0x500($a0)
    /* FB220 8010AA20 0400028E */  lw         $v0, 0x4($s0)
    /* FB224 8010AA24 0001053C */  lui        $a1, (0x1000201 >> 16)
    /* FB228 8010AA28 000062AC */  sw         $v0, 0x0($v1)
    /* FB22C 8010AA2C 0A000292 */  lbu        $v0, 0xA($s0)
    /* FB230 8010AA30 0405838C */  lw         $v1, 0x504($a0)
    /* FB234 8010AA34 00140200 */  sll        $v0, $v0, 16
    /* FB238 8010AA38 10004234 */  ori        $v0, $v0, 0x10
    /* FB23C 8010AA3C 000062AC */  sw         $v0, 0x0($v1)
    /* FB240 8010AA40 0805828C */  lw         $v0, 0x508($a0)
    /* FB244 8010AA44 0102A534 */  ori        $a1, $a1, (0x1000201 & 0xFFFF)
    /* FB248 8010AA48 000045AC */  sw         $a1, 0x0($v0)
    /* FB24C 8010AA4C 00609140 */  mtc0       $s1, $12 /* handwritten instruction */
  .L8010AA50:
    /* FB250 8010AA50 1800BF8F */  lw         $ra, 0x18($sp)
    /* FB254 8010AA54 1400B18F */  lw         $s1, 0x14($sp)
    /* FB258 8010AA58 1000B08F */  lw         $s0, 0x10($sp)
    /* FB25C 8010AA5C 0800E003 */  jr         $ra
    /* FB260 8010AA60 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel iSNDdmtransfer
