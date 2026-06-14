.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDplatformpacketplaycreate, 0xA4

glabel iSNDplatformpacketplaycreate
    /* F4A1C 8010421C D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* F4A20 80104220 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* F4A24 80104224 21988000 */  addu       $s3, $a0, $zero
    /* F4A28 80104228 1400B1AF */  sw         $s1, 0x14($sp)
    /* F4A2C 8010422C 2188A000 */  addu       $s1, $a1, $zero
    /* F4A30 80104230 1480023C */  lui        $v0, %hi(sndpd)
    /* F4A34 80104234 1800B2AF */  sw         $s2, 0x18($sp)
    /* F4A38 80104238 18795224 */  addiu      $s2, $v0, %lo(sndpd)
    /* F4A3C 8010423C 1080023C */  lui        $v0, %hi(iSNDpsxpacketstop)
    /* F4A40 80104240 C8464224 */  addiu      $v0, $v0, %lo(iSNDpsxpacketstop)
    /* F4A44 80104244 2000BFAF */  sw         $ra, 0x20($sp)
    /* F4A48 80104248 1000B0AF */  sw         $s0, 0x10($sp)
    /* F4A4C 8010424C 240742AE */  sw         $v0, 0x724($s2)
    /* F4A50 80104250 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* F4A54 80104254 420022A2 */  sb         $v0, 0x42($s1)
    /* F4A58 80104258 50102226 */  addiu      $v0, $s1, 0x1050
    /* F4A5C 8010425C 1280103C */  lui        $s0, %hi(sndpsxlimits)
    /* F4A60 80104260 D4341026 */  addiu      $s0, $s0, %lo(sndpsxlimits)
    /* F4A64 80104264 2C0022AE */  sw         $v0, 0x2C($s1)
    /* F4A68 80104268 1000048E */  lw         $a0, 0x10($s0)
    /* F4A6C 8010426C 7329040C */  jal        iSNDpsxmalloc
    /* F4A70 80104270 00000000 */   nop
    /* F4A74 80104274 000022AE */  sw         $v0, 0x0($s1)
    /* F4A78 80104278 1000028E */  lw         $v0, 0x10($s0)
    /* F4A7C 8010427C 0000238E */  lw         $v1, 0x0($s1)
    /* F4A80 80104280 00000000 */  nop
    /* F4A84 80104284 06006010 */  beqz       $v1, .L801042A0
    /* F4A88 80104288 040022AE */   sw        $v0, 0x4($s1)
    /* F4A8C 8010428C 80101300 */  sll        $v0, $s3, 2
    /* F4A90 80104290 21105200 */  addu       $v0, $v0, $s2
    /* F4A94 80104294 F80451AC */  sw         $s1, 0x4F8($v0)
    /* F4A98 80104298 A9100408 */  j          .L801042A4
    /* F4A9C 8010429C 21100000 */   addu      $v0, $zero, $zero
  .L801042A0:
    /* F4AA0 801042A0 F7FF0224 */  addiu      $v0, $zero, -0x9
  .L801042A4:
    /* F4AA4 801042A4 2000BF8F */  lw         $ra, 0x20($sp)
    /* F4AA8 801042A8 1C00B38F */  lw         $s3, 0x1C($sp)
    /* F4AAC 801042AC 1800B28F */  lw         $s2, 0x18($sp)
    /* F4AB0 801042B0 1400B18F */  lw         $s1, 0x14($sp)
    /* F4AB4 801042B4 1000B08F */  lw         $s0, 0x10($sp)
    /* F4AB8 801042B8 0800E003 */  jr         $ra
    /* F4ABC 801042BC 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel iSNDplatformpacketplaycreate
