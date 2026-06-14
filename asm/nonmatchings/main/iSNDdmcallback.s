.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

/* Handwritten function */
nonmatching iSNDdmcallback, 0x1BC

glabel iSNDdmcallback
    /* FB264 8010AA64 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* FB268 8010AA68 0D000224 */  addiu      $v0, $zero, 0xD
    /* FB26C 8010AA6C 1400A2AF */  sw         $v0, 0x14($sp)
    /* FB270 8010AA70 1000A0AF */  sw         $zero, 0x10($sp)
    /* FB274 8010AA74 1000A28F */  lw         $v0, 0x10($sp)
    /* FB278 8010AA78 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* FB27C 8010AA7C EE024228 */  slti       $v0, $v0, 0x2EE
    /* FB280 8010AA80 11004010 */  beqz       $v0, .L8010AAC8
    /* FB284 8010AA84 1800B0AF */   sw        $s0, 0x18($sp)
  .L8010AA88:
    /* FB288 8010AA88 1400A38F */  lw         $v1, 0x14($sp)
    /* FB28C 8010AA8C 00000000 */  nop
    /* FB290 8010AA90 40100300 */  sll        $v0, $v1, 1
    /* FB294 8010AA94 21104300 */  addu       $v0, $v0, $v1
    /* FB298 8010AA98 80100200 */  sll        $v0, $v0, 2
    /* FB29C 8010AA9C 21104300 */  addu       $v0, $v0, $v1
    /* FB2A0 8010AAA0 1400A2AF */  sw         $v0, 0x14($sp)
    /* FB2A4 8010AAA4 1000A28F */  lw         $v0, 0x10($sp)
    /* FB2A8 8010AAA8 00000000 */  nop
    /* FB2AC 8010AAAC 01004224 */  addiu      $v0, $v0, 0x1
    /* FB2B0 8010AAB0 1000A2AF */  sw         $v0, 0x10($sp)
    /* FB2B4 8010AAB4 1000A28F */  lw         $v0, 0x10($sp)
    /* FB2B8 8010AAB8 00000000 */  nop
    /* FB2BC 8010AABC EE024228 */  slti       $v0, $v0, 0x2EE
    /* FB2C0 8010AAC0 F1FF4014 */  bnez       $v0, .L8010AA88
    /* FB2C4 8010AAC4 00000000 */   nop
  .L8010AAC8:
    /* FB2C8 8010AAC8 1480033C */  lui        $v1, %hi(sndpd)
    /* FB2CC 8010AACC 18796324 */  addiu      $v1, $v1, %lo(sndpd)
    /* FB2D0 8010AAD0 1405648C */  lw         $a0, 0x514($v1)
    /* FB2D4 8010AAD4 00000000 */  nop
    /* FB2D8 8010AAD8 AA018294 */  lhu        $v0, 0x1AA($a0)
    /* FB2DC 8010AADC 00000000 */  nop
    /* FB2E0 8010AAE0 CFFF4230 */  andi       $v0, $v0, 0xFFCF
    /* FB2E4 8010AAE4 AA0182A4 */  sh         $v0, 0x1AA($a0)
    /* FB2E8 8010AAE8 1405648C */  lw         $a0, 0x514($v1)
    /* FB2EC 8010AAEC 00000000 */  nop
    /* FB2F0 8010AAF0 AA018294 */  lhu        $v0, 0x1AA($a0)
    /* FB2F4 8010AAF4 00000000 */  nop
    /* FB2F8 8010AAF8 30004230 */  andi       $v0, $v0, 0x30
    /* FB2FC 8010AAFC 0A004010 */  beqz       $v0, .L8010AB28
    /* FB300 8010AB00 21180000 */   addu      $v1, $zero, $zero
    /* FB304 8010AB04 01006324 */  addiu      $v1, $v1, 0x1
  .L8010AB08:
    /* FB308 8010AB08 A10F6228 */  slti       $v0, $v1, 0xFA1
    /* FB30C 8010AB0C 07004010 */  beqz       $v0, .L8010AB2C
    /* FB310 8010AB10 1480023C */   lui       $v0, %hi(sndpd)
    /* FB314 8010AB14 AA018294 */  lhu        $v0, 0x1AA($a0)
    /* FB318 8010AB18 00000000 */  nop
    /* FB31C 8010AB1C 30004230 */  andi       $v0, $v0, 0x30
    /* FB320 8010AB20 F9FF4014 */  bnez       $v0, .L8010AB08
    /* FB324 8010AB24 01006324 */   addiu     $v1, $v1, 0x1
  .L8010AB28:
    /* FB328 8010AB28 1480023C */  lui        $v0, %hi(sndpd)
  .L8010AB2C:
    /* FB32C 8010AB2C 18794424 */  addiu      $a0, $v0, %lo(sndpd)
    /* FB330 8010AB30 0D008390 */  lbu        $v1, 0xD($a0)
    /* FB334 8010AB34 00000000 */  nop
    /* FB338 8010AB38 001E0300 */  sll        $v1, $v1, 24
    /* FB33C 8010AB3C 031E0300 */  sra        $v1, $v1, 24
    /* FB340 8010AB40 80100300 */  sll        $v0, $v1, 2
    /* FB344 8010AB44 21104300 */  addu       $v0, $v0, $v1
    /* FB348 8010AB48 80100200 */  sll        $v0, $v0, 2
    /* FB34C 8010AB4C 21104400 */  addu       $v0, $v0, $a0
    /* FB350 8010AB50 1000428C */  lw         $v0, 0x10($v0)
    /* FB354 8010AB54 00601040 */  mfc0       $s0, $12 /* handwritten instruction */
    /* FB358 8010AB58 00000000 */  nop
    /* FB35C 8010AB5C FEFB0124 */  addiu      $at, $zero, -0x402
    /* FB360 8010AB60 24400102 */  and        $t0, $s0, $at
    /* FB364 8010AB64 00608840 */  mtc0       $t0, $12 /* handwritten instruction */
    /* FB368 8010AB68 00000000 */  nop
    /* FB36C 8010AB6C 00000000 */  nop
    /* FB370 8010AB70 00000000 */  nop
    /* FB374 8010AB74 23004010 */  beqz       $v0, .L8010AC04
    /* FB378 8010AB78 00000000 */   nop
    /* FB37C 8010AB7C 01008290 */  lbu        $v0, 0x1($a0)
    /* FB380 8010AB80 00000000 */  nop
    /* FB384 8010AB84 08004010 */  beqz       $v0, .L8010ABA8
    /* FB388 8010AB88 1480023C */   lui       $v0, %hi(sndpd)
    /* FB38C 8010AB8C 2807828C */  lw         $v0, 0x728($a0)
    /* FB390 8010AB90 010080A0 */  sb         $zero, 0x1($a0)
    /* FB394 8010AB94 03004010 */  beqz       $v0, .L8010ABA4
    /* FB398 8010AB98 00000000 */   nop
    /* FB39C 8010AB9C 09F84000 */  jalr       $v0
    /* FB3A0 8010ABA0 00000000 */   nop
  .L8010ABA4:
    /* FB3A4 8010ABA4 1480023C */  lui        $v0, %hi(sndpd)
  .L8010ABA8:
    /* FB3A8 8010ABA8 18794424 */  addiu      $a0, $v0, %lo(sndpd)
    /* FB3AC 8010ABAC 0D008390 */  lbu        $v1, 0xD($a0)
    /* FB3B0 8010ABB0 00000000 */  nop
    /* FB3B4 8010ABB4 001E0300 */  sll        $v1, $v1, 24
    /* FB3B8 8010ABB8 031E0300 */  sra        $v1, $v1, 24
    /* FB3BC 8010ABBC 80100300 */  sll        $v0, $v1, 2
    /* FB3C0 8010ABC0 21104300 */  addu       $v0, $v0, $v1
    /* FB3C4 8010ABC4 80100200 */  sll        $v0, $v0, 2
    /* FB3C8 8010ABC8 21104400 */  addu       $v0, $v0, $a0
    /* FB3CC 8010ABCC 100040AC */  sw         $zero, 0x10($v0)
    /* FB3D0 8010ABD0 0C008290 */  lbu        $v0, 0xC($a0)
    /* FB3D4 8010ABD4 00000000 */  nop
    /* FB3D8 8010ABD8 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* FB3DC 8010ABDC 0C0082A0 */  sb         $v0, 0xC($a0)
    /* FB3E0 8010ABE0 0C008290 */  lbu        $v0, 0xC($a0)
    /* FB3E4 8010ABE4 00000000 */  nop
    /* FB3E8 8010ABE8 00160200 */  sll        $v0, $v0, 24
    /* FB3EC 8010ABEC 0500401C */  bgtz       $v0, .L8010AC04
    /* FB3F0 8010ABF0 00000000 */   nop
    /* FB3F4 8010ABF4 0E0080A0 */  sb         $zero, 0xE($a0)
    /* FB3F8 8010ABF8 00609040 */  mtc0       $s0, $12 /* handwritten instruction */
    /* FB3FC 8010ABFC 042B0408 */  j          .L8010AC10
    /* FB400 8010AC00 00000000 */   nop
  .L8010AC04:
    /* FB404 8010AC04 00609040 */  mtc0       $s0, $12 /* handwritten instruction */
    /* FB408 8010AC08 202A040C */  jal        iSNDdmtransfer
    /* FB40C 8010AC0C 00000000 */   nop
  .L8010AC10:
    /* FB410 8010AC10 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* FB414 8010AC14 1800B08F */  lw         $s0, 0x18($sp)
    /* FB418 8010AC18 0800E003 */  jr         $ra
    /* FB41C 8010AC1C 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel iSNDdmcallback
