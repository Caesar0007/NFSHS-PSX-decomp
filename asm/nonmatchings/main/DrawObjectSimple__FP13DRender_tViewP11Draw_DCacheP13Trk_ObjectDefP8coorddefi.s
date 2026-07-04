.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawObjectSimple__FP13DRender_tViewP11Draw_DCacheP13Trk_ObjectDefP8coorddefi, 0x2F4

glabel DrawObjectSimple__FP13DRender_tViewP11Draw_DCacheP13Trk_ObjectDefP8coorddefi
    /* B8A14 800C8214 B0FFBD27 */  addiu      $sp, $sp, -0x50
    /* B8A18 800C8218 3000B0AF */  sw         $s0, 0x30($sp)
    /* B8A1C 800C821C 2180A000 */  addu       $s0, $a1, $zero
    /* B8A20 800C8220 4000B4AF */  sw         $s4, 0x40($sp)
    /* B8A24 800C8224 21A0C000 */  addu       $s4, $a2, $zero
    /* B8A28 800C8228 1480033C */  lui        $v1, %hi(Track_materials)
    /* B8A2C 800C822C D0D4638C */  lw         $v1, %lo(Track_materials)($v1)
    /* B8A30 800C8230 04008226 */  addiu      $v0, $s4, 0x4
    /* B8A34 800C8234 4800BFAF */  sw         $ra, 0x48($sp)
    /* B8A38 800C8238 4400B5AF */  sw         $s5, 0x44($sp)
    /* B8A3C 800C823C 3C00B3AF */  sw         $s3, 0x3C($sp)
    /* B8A40 800C8240 3800B2AF */  sw         $s2, 0x38($sp)
    /* B8A44 800C8244 3400B1AF */  sw         $s1, 0x34($sp)
    /* B8A48 800C8248 E00002AE */  sw         $v0, 0xE0($s0)
    /* B8A4C 800C824C F00003AE */  sw         $v1, 0xF0($s0)
    /* B8A50 800C8250 03008292 */  lbu        $v0, 0x3($s4)
    /* B8A54 800C8254 6000B58F */  lw         $s5, 0x60($sp)
    /* B8A58 800C8258 E70002A2 */  sb         $v0, 0xE7($s0)
    /* B8A5C 800C825C 02008292 */  lbu        $v0, 0x2($s4)
    /* B8A60 800C8260 21908000 */  addu       $s2, $a0, $zero
    /* B8A64 800C8264 060100A2 */  sb         $zero, 0x106($s0)
    /* B8A68 800C8268 1480033C */  lui        $v1, %hi(gNight_renderNight)
    /* B8A6C 800C826C 28DA638C */  lw         $v1, %lo(gNight_renderNight)($v1)
    /* B8A70 800C8270 2198E000 */  addu       $s3, $a3, $zero
    /* B8A74 800C8274 EC0015AE */  sw         $s5, 0xEC($s0)
    /* B8A78 800C8278 C0100200 */  sll        $v0, $v0, 3
    /* B8A7C 800C827C 04004224 */  addiu      $v0, $v0, 0x4
    /* B8A80 800C8280 21108202 */  addu       $v0, $s4, $v0
    /* B8A84 800C8284 65006010 */  beqz       $v1, .L800C841C
    /* B8A88 800C8288 E80002AE */   sw        $v0, 0xE8($s0)
    /* B8A8C 800C828C 04000224 */  addiu      $v0, $zero, 0x4
    /* B8A90 800C8290 1180033C */  lui        $v1, %hi(Cars_gList)
    /* B8A94 800C8294 060102A2 */  sb         $v0, 0x106($s0)
    /* B8A98 800C8298 0400428E */  lw         $v0, 0x4($s2)
    /* B8A9C 800C829C DCF96324 */  addiu      $v1, $v1, %lo(Cars_gList)
    /* B8AA0 800C82A0 80100200 */  sll        $v0, $v0, 2
    /* B8AA4 800C82A4 21104300 */  addu       $v0, $v0, $v1
    /* B8AA8 800C82A8 0000428C */  lw         $v0, 0x0($v0)
    /* B8AAC 800C82AC 00000000 */  nop
    /* B8AB0 800C82B0 47044290 */  lbu        $v0, 0x447($v0)
    /* B8AB4 800C82B4 00000000 */  nop
    /* B8AB8 800C82B8 06004230 */  andi       $v0, $v0, 0x6
    /* B8ABC 800C82BC 02004010 */  beqz       $v0, .L800C82C8
    /* B8AC0 800C82C0 05000224 */   addiu     $v0, $zero, 0x5
    /* B8AC4 800C82C4 060102A2 */  sb         $v0, 0x106($s0)
  .L800C82C8:
    /* B8AC8 800C82C8 1180063C */  lui        $a2, %hi(Camera_gInfo)
    /* B8ACC 800C82CC 0400438E */  lw         $v1, 0x4($s2)
    /* B8AD0 800C82D0 ACF2C624 */  addiu      $a2, $a2, %lo(Camera_gInfo)
    /* B8AD4 800C82D4 00110300 */  sll        $v0, $v1, 4
    /* B8AD8 800C82D8 21104300 */  addu       $v0, $v0, $v1
    /* B8ADC 800C82DC 00110200 */  sll        $v0, $v0, 4
    /* B8AE0 800C82E0 21104600 */  addu       $v0, $v0, $a2
    /* B8AE4 800C82E4 0400428C */  lw         $v0, 0x4($v0)
    /* B8AE8 800C82E8 00000000 */  nop
    /* B8AEC 800C82EC A000438C */  lw         $v1, 0xA0($v0)
    /* B8AF0 800C82F0 0800428E */  lw         $v0, 0x8($s2)
    /* B8AF4 800C82F4 00000000 */  nop
    /* B8AF8 800C82F8 23104300 */  subu       $v0, $v0, $v1
    /* B8AFC 800C82FC 1000A2AF */  sw         $v0, 0x10($sp)
    /* B8B00 800C8300 0400438E */  lw         $v1, 0x4($s2)
    /* B8B04 800C8304 00000000 */  nop
    /* B8B08 800C8308 00110300 */  sll        $v0, $v1, 4
    /* B8B0C 800C830C 21104300 */  addu       $v0, $v0, $v1
    /* B8B10 800C8310 00110200 */  sll        $v0, $v0, 4
    /* B8B14 800C8314 21104600 */  addu       $v0, $v0, $a2
    /* B8B18 800C8318 0400428C */  lw         $v0, 0x4($v0)
    /* B8B1C 800C831C 1000A427 */  addiu      $a0, $sp, 0x10
    /* B8B20 800C8320 A400438C */  lw         $v1, 0xA4($v0)
    /* B8B24 800C8324 0C00428E */  lw         $v0, 0xC($s2)
    /* B8B28 800C8328 1180053C */  lui        $a1, %hi(gNightMat)
    /* B8B2C 800C832C 23104300 */  subu       $v0, $v0, $v1
    /* B8B30 800C8330 1400A2AF */  sw         $v0, 0x14($sp)
    /* B8B34 800C8334 0400438E */  lw         $v1, 0x4($s2)
    /* B8B38 800C8338 64EEA524 */  addiu      $a1, $a1, %lo(gNightMat)
    /* B8B3C 800C833C 00110300 */  sll        $v0, $v1, 4
    /* B8B40 800C8340 21104300 */  addu       $v0, $v0, $v1
    /* B8B44 800C8344 00110200 */  sll        $v0, $v0, 4
    /* B8B48 800C8348 21104600 */  addu       $v0, $v0, $a2
    /* B8B4C 800C834C 0400428C */  lw         $v0, 0x4($v0)
    /* B8B50 800C8350 2000B127 */  addiu      $s1, $sp, 0x20
    /* B8B54 800C8354 A800438C */  lw         $v1, 0xA8($v0)
    /* B8B58 800C8358 1000428E */  lw         $v0, 0x10($s2)
    /* B8B5C 800C835C 21302002 */  addu       $a2, $s1, $zero
    /* B8B60 800C8360 23104300 */  subu       $v0, $v0, $v1
    /* B8B64 800C8364 B6AB030C */  jal        transform
    /* B8B68 800C8368 1800A2AF */   sw        $v0, 0x18($sp)
    /* B8B6C 800C836C 21202002 */  addu       $a0, $s1, $zero
    /* B8B70 800C8370 761D030C */  jal        DrawW_WorldSetUpTranslation__FP8coorddefP6MATRIX
    /* B8B74 800C8374 34000526 */   addiu     $a1, $s0, 0x34
    /* B8B78 800C8378 1480023C */  lui        $v0, %hi(BW_gCopCarObj)
    /* B8B7C 800C837C B4C7428C */  lw         $v0, %lo(BW_gCopCarObj)($v0)
    /* B8B80 800C8380 00000000 */  nop
    /* B8B84 800C8384 1B004010 */  beqz       $v0, .L800C83F4
    /* B8B88 800C8388 1000A427 */   addiu     $a0, $sp, 0x10
    /* B8B8C 800C838C 06010292 */  lbu        $v0, 0x106($s0)
    /* B8B90 800C8390 00000000 */  nop
    /* B8B94 800C8394 02004234 */  ori        $v0, $v0, 0x2
    /* B8B98 800C8398 060102A2 */  sb         $v0, 0x106($s0)
    /* B8B9C 800C839C 1480033C */  lui        $v1, %hi(BW_gCopCarObj)
    /* B8BA0 800C83A0 B4C7638C */  lw         $v1, %lo(BW_gCopCarObj)($v1)
    /* B8BA4 800C83A4 0800428E */  lw         $v0, 0x8($s2)
    /* B8BA8 800C83A8 A000658C */  lw         $a1, 0xA0($v1)
    /* B8BAC 800C83AC 00000000 */  nop
    /* B8BB0 800C83B0 23104500 */  subu       $v0, $v0, $a1
    /* B8BB4 800C83B4 1180053C */  lui        $a1, %hi(gCopMat)
    /* B8BB8 800C83B8 1000A2AF */  sw         $v0, 0x10($sp)
    /* B8BBC 800C83BC A400668C */  lw         $a2, 0xA4($v1)
    /* B8BC0 800C83C0 0C00428E */  lw         $v0, 0xC($s2)
    /* B8BC4 800C83C4 88EEA524 */  addiu      $a1, $a1, %lo(gCopMat)
    /* B8BC8 800C83C8 23104600 */  subu       $v0, $v0, $a2
    /* B8BCC 800C83CC 1400A2AF */  sw         $v0, 0x14($sp)
    /* B8BD0 800C83D0 A800638C */  lw         $v1, 0xA8($v1)
    /* B8BD4 800C83D4 1000428E */  lw         $v0, 0x10($s2)
    /* B8BD8 800C83D8 21302002 */  addu       $a2, $s1, $zero
    /* B8BDC 800C83DC 23104300 */  subu       $v0, $v0, $v1
    /* B8BE0 800C83E0 B6AB030C */  jal        transform
    /* B8BE4 800C83E4 1800A2AF */   sw        $v0, 0x18($sp)
    /* B8BE8 800C83E8 21202002 */  addu       $a0, $s1, $zero
    /* B8BEC 800C83EC 761D030C */  jal        DrawW_WorldSetUpTranslation__FP8coorddefP6MATRIX
    /* B8BF0 800C83F0 54000526 */   addiu     $a1, $s0, 0x54
  .L800C83F4:
    /* B8BF4 800C83F4 14000226 */  addiu      $v0, $s0, 0x14
    /* B8BF8 800C83F8 1C0040AC */  sw         $zero, 0x1C($v0)
    /* B8BFC 800C83FC 180040AC */  sw         $zero, 0x18($v0)
    /* B8C00 800C8400 280000AE */  sw         $zero, 0x28($s0)
    /* B8C04 800C8404 14004C8C */  lw         $t4, 0x14($v0)
    /* B8C08 800C8408 18004D8C */  lw         $t5, 0x18($v0)
    /* B8C0C 800C840C 0028CC48 */  ctc2       $t4, $5 /* handwritten instruction */
    /* B8C10 800C8410 1C004E8C */  lw         $t6, 0x1C($v0)
    /* B8C14 800C8414 0030CD48 */  ctc2       $t5, $6 /* handwritten instruction */
    /* B8C18 800C8418 0038CE48 */  ctc2       $t6, $7 /* handwritten instruction */
  .L800C841C:
    /* B8C1C 800C841C FFFF0224 */  addiu      $v0, $zero, -0x1
    /* B8C20 800C8420 1700A216 */  bne        $s5, $v0, .L800C8480
    /* B8C24 800C8424 00000000 */   nop
    /* B8C28 800C8428 1480023C */  lui        $v0, %hi(Draw_gMidGroundOtz)
    /* B8C2C 800C842C BCD7428C */  lw         $v0, %lo(Draw_gMidGroundOtz)($v0)
    /* B8C30 800C8430 00000000 */  nop
    /* B8C34 800C8434 EC0002AE */  sw         $v0, 0xEC($s0)
    /* B8C38 800C8438 0800438E */  lw         $v1, 0x8($s2)
    /* B8C3C 800C843C 0000628E */  lw         $v0, 0x0($s3)
    /* B8C40 800C8440 00000000 */  nop
    /* B8C44 800C8444 23104300 */  subu       $v0, $v0, $v1
    /* B8C48 800C8448 03130200 */  sra        $v0, $v0, 12
    /* B8C4C 800C844C F40002A6 */  sh         $v0, 0xF4($s0)
    /* B8C50 800C8450 0C00438E */  lw         $v1, 0xC($s2)
    /* B8C54 800C8454 0400628E */  lw         $v0, 0x4($s3)
    /* B8C58 800C8458 00000000 */  nop
    /* B8C5C 800C845C 23104300 */  subu       $v0, $v0, $v1
    /* B8C60 800C8460 03130200 */  sra        $v0, $v0, 12
    /* B8C64 800C8464 F60002A6 */  sh         $v0, 0xF6($s0)
    /* B8C68 800C8468 1000438E */  lw         $v1, 0x10($s2)
    /* B8C6C 800C846C 0800628E */  lw         $v0, 0x8($s3)
    /* B8C70 800C8470 00000000 */  nop
    /* B8C74 800C8474 23104300 */  subu       $v0, $v0, $v1
    /* B8C78 800C8478 31210308 */  j          .L800C84C4
    /* B8C7C 800C847C 03130200 */   sra       $v0, $v0, 12
  .L800C8480:
    /* B8C80 800C8480 0800438E */  lw         $v1, 0x8($s2)
    /* B8C84 800C8484 0000628E */  lw         $v0, 0x0($s3)
    /* B8C88 800C8488 00000000 */  nop
    /* B8C8C 800C848C 23104300 */  subu       $v0, $v0, $v1
    /* B8C90 800C8490 83120200 */  sra        $v0, $v0, 10
    /* B8C94 800C8494 F40002A6 */  sh         $v0, 0xF4($s0)
    /* B8C98 800C8498 0C00438E */  lw         $v1, 0xC($s2)
    /* B8C9C 800C849C 0400628E */  lw         $v0, 0x4($s3)
    /* B8CA0 800C84A0 00000000 */  nop
    /* B8CA4 800C84A4 23104300 */  subu       $v0, $v0, $v1
    /* B8CA8 800C84A8 83120200 */  sra        $v0, $v0, 10
    /* B8CAC 800C84AC F60002A6 */  sh         $v0, 0xF6($s0)
    /* B8CB0 800C84B0 1000438E */  lw         $v1, 0x10($s2)
    /* B8CB4 800C84B4 0800628E */  lw         $v0, 0x8($s3)
    /* B8CB8 800C84B8 00000000 */  nop
    /* B8CBC 800C84BC 23104300 */  subu       $v0, $v0, $v1
    /* B8CC0 800C84C0 83120200 */  sra        $v0, $v0, 10
  .L800C84C4:
    /* B8CC4 800C84C4 F80002A6 */  sh         $v0, 0xF8($s0)
    /* B8CC8 800C84C8 21200002 */  addu       $a0, $s0, $zero
    /* B8CCC 800C84CC 01000224 */  addiu      $v0, $zero, 0x1
    /* B8CD0 800C84D0 070182A0 */  sb         $v0, 0x107($a0)
    /* B8CD4 800C84D4 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* B8CD8 800C84D8 8E1B030C */  jal        DrawW_kCtrlWorld_High__FP25Draw_tGiveShelbyMoreCache
    /* B8CDC 800C84DC D80082A4 */   sh        $v0, 0xD8($a0)
    /* B8CE0 800C84E0 03008292 */  lbu        $v0, 0x3($s4)
    /* B8CE4 800C84E4 4800BF8F */  lw         $ra, 0x48($sp)
    /* B8CE8 800C84E8 4400B58F */  lw         $s5, 0x44($sp)
    /* B8CEC 800C84EC 4000B48F */  lw         $s4, 0x40($sp)
    /* B8CF0 800C84F0 3C00B38F */  lw         $s3, 0x3C($sp)
    /* B8CF4 800C84F4 3800B28F */  lw         $s2, 0x38($sp)
    /* B8CF8 800C84F8 3400B18F */  lw         $s1, 0x34($sp)
    /* B8CFC 800C84FC 3000B08F */  lw         $s0, 0x30($sp)
    /* B8D00 800C8500 0800E003 */  jr         $ra
    /* B8D04 800C8504 5000BD27 */   addiu     $sp, $sp, 0x50
endlabel DrawObjectSimple__FP13DRender_tViewP11Draw_DCacheP13Trk_ObjectDefP8coorddefi
