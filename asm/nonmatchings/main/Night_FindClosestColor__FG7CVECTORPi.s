.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Night_FindClosestColor__FG7CVECTORPi, 0xC8

glabel Night_FindClosestColor__FG7CVECTORPi
    /* CBB18 800DB318 0200083C */  lui        $t0, (0x2FA03 >> 16)
    /* CBB1C 800DB31C 4815828F */  lw         $v0, %gp_rel(gTableCache)($gp)
    /* CBB20 800DB320 1415838F */  lw         $v1, %gp_rel(Night_gTotalLights)($gp)
    /* CBB24 800DB324 01000724 */  addiu      $a3, $zero, 0x1
    /* CBB28 800DB328 0000A4AF */  sw         $a0, 0x0($sp)
    /* CBB2C 800DB32C 0000AF93 */  lbu        $t7, 0x0($sp)
    /* CBB30 800DB330 0100AE93 */  lbu        $t6, 0x1($sp)
    /* CBB34 800DB334 0200AD93 */  lbu        $t5, 0x2($sp)
    /* CBB38 800DB338 21186700 */  addu       $v1, $v1, $a3
    /* CBB3C 800DB33C 00004B90 */  lbu        $t3, 0x0($v0)
    /* CBB40 800DB340 01004C90 */  lbu        $t4, 0x1($v0)
    /* CBB44 800DB344 02004A90 */  lbu        $t2, 0x2($v0)
    /* CBB48 800DB348 2A10E300 */  slt        $v0, $a3, $v1
    /* CBB4C 800DB34C 22004010 */  beqz       $v0, .L800DB3D8
    /* CBB50 800DB350 03FA0835 */   ori       $t0, $t0, (0x2FA03 & 0xFFFF)
    /* CBB54 800DB354 03000924 */  addiu      $t1, $zero, 0x3
  .L800DB358:
    /* CBB58 800DB358 2310EB01 */  subu       $v0, $t7, $t3
    /* CBB5C 800DB35C 18004200 */  mult       $v0, $v0
    /* CBB60 800DB360 12200000 */  mflo       $a0
    /* CBB64 800DB364 2310CC01 */  subu       $v0, $t6, $t4
    /* CBB68 800DB368 00000000 */  nop
    /* CBB6C 800DB36C 18004200 */  mult       $v0, $v0
    /* CBB70 800DB370 12300000 */  mflo       $a2
    /* CBB74 800DB374 2310AA01 */  subu       $v0, $t5, $t2
    /* CBB78 800DB378 00000000 */  nop
    /* CBB7C 800DB37C 18004200 */  mult       $v0, $v0
    /* CBB80 800DB380 4815828F */  lw         $v0, %gp_rel(gTableCache)($gp)
    /* CBB84 800DB384 21208600 */  addu       $a0, $a0, $a2
    /* CBB88 800DB388 21102201 */  addu       $v0, $t1, $v0
    /* CBB8C 800DB38C 00004B90 */  lbu        $t3, 0x0($v0)
    /* CBB90 800DB390 01004C90 */  lbu        $t4, 0x1($v0)
    /* CBB94 800DB394 02004A90 */  lbu        $t2, 0x2($v0)
    /* CBB98 800DB398 12C80000 */  mflo       $t9
    /* CBB9C 800DB39C 21209900 */  addu       $a0, $a0, $t9
    /* CBBA0 800DB3A0 2A108800 */  slt        $v0, $a0, $t0
    /* CBBA4 800DB3A4 08004010 */  beqz       $v0, .L800DB3C8
    /* CBBA8 800DB3A8 FFFFE224 */   addiu     $v0, $a3, -0x1
    /* CBBAC 800DB3AC 21408000 */  addu       $t0, $a0, $zero
    /* CBBB0 800DB3B0 0000A2AC */  sw         $v0, 0x0($a1)
    /* CBBB4 800DB3B4 40000229 */  slti       $v0, $t0, 0x40
    /* CBBB8 800DB3B8 04004010 */  beqz       $v0, .L800DB3CC
    /* CBBBC 800DB3BC 0100E724 */   addiu     $a3, $a3, 0x1
    /* CBBC0 800DB3C0 0800E003 */  jr         $ra
    /* CBBC4 800DB3C4 21100001 */   addu      $v0, $t0, $zero
  .L800DB3C8:
    /* CBBC8 800DB3C8 0100E724 */  addiu      $a3, $a3, 0x1
  .L800DB3CC:
    /* CBBCC 800DB3CC 2A10E300 */  slt        $v0, $a3, $v1
    /* CBBD0 800DB3D0 E1FF4014 */  bnez       $v0, .L800DB358
    /* CBBD4 800DB3D4 03002925 */   addiu     $t1, $t1, 0x3
  .L800DB3D8:
    /* CBBD8 800DB3D8 0800E003 */  jr         $ra
    /* CBBDC 800DB3DC 21100001 */   addu      $v0, $t0, $zero
endlabel Night_FindClosestColor__FG7CVECTORPi
