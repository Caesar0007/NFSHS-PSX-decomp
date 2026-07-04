.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDrestore, 0x154

glabel iSNDrestore
    /* F01A0 800FF9A0 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* F01A4 800FF9A4 1480023C */  lui        $v0, %hi(sndgs)
    /* F01A8 800FF9A8 60784324 */  addiu      $v1, $v0, %lo(sndgs)
    /* F01AC 800FF9AC 2800BFAF */  sw         $ra, 0x28($sp)
    /* F01B0 800FF9B0 2400B5AF */  sw         $s5, 0x24($sp)
    /* F01B4 800FF9B4 2000B4AF */  sw         $s4, 0x20($sp)
    /* F01B8 800FF9B8 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* F01BC 800FF9BC 1800B2AF */  sw         $s2, 0x18($sp)
    /* F01C0 800FF9C0 1400B1AF */  sw         $s1, 0x14($sp)
    /* F01C4 800FF9C4 1000B0AF */  sw         $s0, 0x10($sp)
    /* F01C8 800FF9C8 3F006290 */  lbu        $v0, 0x3F($v1)
    /* F01CC 800FF9CC 00000000 */  nop
    /* F01D0 800FF9D0 07004010 */  beqz       $v0, .L800FF9F0
    /* F01D4 800FF9D4 21806000 */   addu      $s0, $v1, $zero
  .L800FF9D8:
    /* F01D8 800FF9D8 5BA9030C */  jal        iSNDleaveaudio
    /* F01DC 800FF9DC 00000000 */   nop
    /* F01E0 800FF9E0 3F000292 */  lbu        $v0, 0x3F($s0)
    /* F01E4 800FF9E4 00000000 */  nop
    /* F01E8 800FF9E8 FBFF4014 */  bnez       $v0, .L800FF9D8
    /* F01EC 800FF9EC 00000000 */   nop
  .L800FF9F0:
    /* F01F0 800FF9F0 1480023C */  lui        $v0, %hi(sndgs)
    /* F01F4 800FF9F4 60784224 */  addiu      $v0, $v0, %lo(sndgs)
    /* F01F8 800FF9F8 21984000 */  addu       $s3, $v0, $zero
    /* F01FC 800FF9FC 4400638E */  lw         $v1, 0x44($s3)
    /* F0200 800FFA00 1480023C */  lui        $v0, %hi(sndpd)
    /* F0204 800FFA04 18795524 */  addiu      $s5, $v0, %lo(sndpd)
    /* F0208 800FFA08 64007424 */  addiu      $s4, $v1, 0x64
    /* F020C 800FFA0C 01001224 */  addiu      $s2, $zero, 0x1
  .L800FFA10:
    /* F0210 800FFA10 11006292 */  lbu        $v0, 0x11($s3)
    /* F0214 800FFA14 00000000 */  nop
    /* F0218 800FFA18 17004010 */  beqz       $v0, .L800FFA78
    /* F021C 800FFA1C 21800000 */   addu      $s0, $zero, $zero
    /* F0220 800FFA20 2188A002 */  addu       $s1, $s5, $zero
  .L800FFA24:
    /* F0224 800FFA24 F5002292 */  lbu        $v0, 0xF5($s1)
    /* F0228 800FFA28 00000000 */  nop
    /* F022C 800FFA2C 0D004010 */  beqz       $v0, .L800FFA64
    /* F0230 800FFA30 00000000 */   nop
    /* F0234 800FFA34 4400628E */  lw         $v0, 0x44($s3)
    /* F0238 800FFA38 00000000 */  nop
    /* F023C 800FFA3C 2B108202 */  sltu       $v0, $s4, $v0
    /* F0240 800FFA40 08004010 */  beqz       $v0, .L800FFA64
    /* F0244 800FFA44 21900000 */   addu      $s2, $zero, $zero
    /* F0248 800FFA48 FF00043C */  lui        $a0, (0xFFFFFF >> 16)
    /* F024C 800FFA4C 5AFC030C */  jal        iSNDpsxkeyoff
    /* F0250 800FFA50 FFFF8434 */   ori       $a0, $a0, (0xFFFFFF & 0xFFFF)
    /* F0254 800FFA54 F50020A2 */  sb         $zero, 0xF5($s1)
    /* F0258 800FFA58 03FB030C */  jal        iSNDfreechan
    /* F025C 800FFA5C 21200002 */   addu      $a0, $s0, $zero
    /* F0260 800FFA60 21900000 */  addu       $s2, $zero, $zero
  .L800FFA64:
    /* F0264 800FFA64 11006292 */  lbu        $v0, 0x11($s3)
    /* F0268 800FFA68 01001026 */  addiu      $s0, $s0, 0x1
    /* F026C 800FFA6C 2A100202 */  slt        $v0, $s0, $v0
    /* F0270 800FFA70 ECFF4014 */  bnez       $v0, .L800FFA24
    /* F0274 800FFA74 2C003126 */   addiu     $s1, $s1, 0x2C
  .L800FFA78:
    /* F0278 800FFA78 1E12040C */  jal        SNDSYS_service
    /* F027C 800FFA7C 00000000 */   nop
    /* F0280 800FFA80 E3FF4012 */  beqz       $s2, .L800FFA10
    /* F0284 800FFA84 01001224 */   addiu     $s2, $zero, 0x1
    /* F0288 800FFA88 0F80043C */  lui        $a0, %hi(iSNDserver)
    /* F028C 800FFA8C 12AC030C */  jal        deltimer
    /* F0290 800FFA90 38A18424 */   addiu     $a0, $a0, %lo(iSNDserver)
    /* F0294 800FFA94 8300040C */  jal        iSNDpsxfxinit
    /* F0298 800FFA98 21200000 */   addu      $a0, $zero, $zero
    /* F029C 800FFA9C 04000424 */  addiu      $a0, $zero, 0x4
    /* F02A0 800FFAA0 00601040 */  mfc0       $s0, $12 /* handwritten instruction */
    /* F02A4 800FFAA4 00000000 */  nop
    /* F02A8 800FFAA8 FEFB0124 */  addiu      $at, $zero, -0x402
    /* F02AC 800FFAAC 24400102 */  and        $t0, $s0, $at
    /* F02B0 800FFAB0 00608840 */  mtc0       $t0, $12 /* handwritten instruction */
    /* F02B4 800FFAB4 00000000 */  nop
    /* F02B8 800FFAB8 00000000 */  nop
    /* F02BC 800FFABC 00000000 */  nop
    /* F02C0 800FFAC0 2BCA030C */  jal        DMACallback
    /* F02C4 800FFAC4 21280000 */   addu      $a1, $zero, $zero
    /* F02C8 800FFAC8 00609040 */  mtc0       $s0, $12 /* handwritten instruction */
    /* F02CC 800FFACC 2800BF8F */  lw         $ra, 0x28($sp)
    /* F02D0 800FFAD0 2400B58F */  lw         $s5, 0x24($sp)
    /* F02D4 800FFAD4 2000B48F */  lw         $s4, 0x20($sp)
    /* F02D8 800FFAD8 1C00B38F */  lw         $s3, 0x1C($sp)
    /* F02DC 800FFADC 1800B28F */  lw         $s2, 0x18($sp)
    /* F02E0 800FFAE0 1400B18F */  lw         $s1, 0x14($sp)
    /* F02E4 800FFAE4 1000B08F */  lw         $s0, 0x10($sp)
    /* F02E8 800FFAE8 21100000 */  addu       $v0, $zero, $zero
    /* F02EC 800FFAEC 0800E003 */  jr         $ra
    /* F02F0 800FFAF0 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel iSNDrestore
