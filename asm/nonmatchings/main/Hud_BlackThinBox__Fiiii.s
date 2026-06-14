.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hud_BlackThinBox__Fiiii, 0x1EC

glabel Hud_BlackThinBox__Fiiii
    /* C82BC 800D7ABC B0FFBD27 */  addiu      $sp, $sp, -0x50
    /* C82C0 800D7AC0 3800B4AF */  sw         $s4, 0x38($sp)
    /* C82C4 800D7AC4 21A08000 */  addu       $s4, $a0, $zero
    /* C82C8 800D7AC8 3C00B5AF */  sw         $s5, 0x3C($sp)
    /* C82CC 800D7ACC 21A8A000 */  addu       $s5, $a1, $zero
    /* C82D0 800D7AD0 FEFFA226 */  addiu      $v0, $s5, -0x2
    /* C82D4 800D7AD4 5800A6AF */  sw         $a2, 0x58($sp)
    /* C82D8 800D7AD8 21304000 */  addu       $a2, $v0, $zero
    /* C82DC 800D7ADC 2000A2AF */  sw         $v0, 0x20($sp)
    /* C82E0 800D7AE0 1180023C */  lui        $v0, %hi(HudPmx_gShapes)
    /* C82E4 800D7AE4 980C4224 */  addiu      $v0, $v0, %lo(HudPmx_gShapes)
    /* C82E8 800D7AE8 4C00BFAF */  sw         $ra, 0x4C($sp)
    /* C82EC 800D7AEC 4800BEAF */  sw         $fp, 0x48($sp)
    /* C82F0 800D7AF0 4400B7AF */  sw         $s7, 0x44($sp)
    /* C82F4 800D7AF4 4000B6AF */  sw         $s6, 0x40($sp)
    /* C82F8 800D7AF8 3400B3AF */  sw         $s3, 0x34($sp)
    /* C82FC 800D7AFC 3000B2AF */  sw         $s2, 0x30($sp)
    /* C8300 800D7B00 2C00B1AF */  sw         $s1, 0x2C($sp)
    /* C8304 800D7B04 2800B0AF */  sw         $s0, 0x28($sp)
    /* C8308 800D7B08 5C00A7AF */  sw         $a3, 0x5C($sp)
    /* C830C 800D7B0C 64015684 */  lh         $s6, 0x164($v0)
    /* C8310 800D7B10 02000224 */  addiu      $v0, $zero, 0x2
    /* C8314 800D7B14 1000A2AF */  sw         $v0, 0x10($sp)
    /* C8318 800D7B18 5800A28F */  lw         $v0, 0x58($sp)
    /* C831C 800D7B1C 21200000 */  addu       $a0, $zero, $zero
    /* C8320 800D7B20 1400A0AF */  sw         $zero, 0x14($sp)
    /* C8324 800D7B24 1800A0AF */  sw         $zero, 0x18($sp)
    /* C8328 800D7B28 1C00A0AF */  sw         $zero, 0x1C($sp)
    /* C832C 800D7B2C 21B89602 */  addu       $s7, $s4, $s6
    /* C8330 800D7B30 FEFFF726 */  addiu      $s7, $s7, -0x2
    /* C8334 800D7B34 2128E002 */  addu       $a1, $s7, $zero
    /* C8338 800D7B38 40981600 */  sll        $s3, $s6, 1
    /* C833C 800D7B3C 23985300 */  subu       $s3, $v0, $s3
    /* C8340 800D7B40 02007326 */  addiu      $s3, $s3, 0x2
    /* C8344 800D7B44 1180023C */  lui        $v0, %hi(HudPmx_gShapes)
    /* C8348 800D7B48 980C4224 */  addiu      $v0, $v0, %lo(HudPmx_gShapes)
    /* C834C 800D7B4C 66015294 */  lhu        $s2, 0x166($v0)
    /* C8350 800D7B50 614A030C */  jal        Hud_FBuildF4__FiiiiiUlcc
    /* C8354 800D7B54 21386002 */   addu      $a3, $s3, $zero
    /* C8358 800D7B58 21200000 */  addu       $a0, $zero, $zero
    /* C835C 800D7B5C FEFF9E26 */  addiu      $fp, $s4, -0x2
    /* C8360 800D7B60 2128C003 */  addu       $a1, $fp, $zero
    /* C8364 800D7B64 5C00A28F */  lw         $v0, 0x5C($sp)
    /* C8368 800D7B68 02000724 */  addiu      $a3, $zero, 0x2
    /* C836C 800D7B6C 1400A0AF */  sw         $zero, 0x14($sp)
    /* C8370 800D7B70 1800A0AF */  sw         $zero, 0x18($sp)
    /* C8374 800D7B74 1C00A0AF */  sw         $zero, 0x1C($sp)
    /* C8378 800D7B78 00941200 */  sll        $s2, $s2, 16
    /* C837C 800D7B7C 03941200 */  sra        $s2, $s2, 16
    /* C8380 800D7B80 2188B202 */  addu       $s1, $s5, $s2
    /* C8384 800D7B84 FEFF3126 */  addiu      $s1, $s1, -0x2
    /* C8388 800D7B88 21302002 */  addu       $a2, $s1, $zero
    /* C838C 800D7B8C 40801200 */  sll        $s0, $s2, 1
    /* C8390 800D7B90 23805000 */  subu       $s0, $v0, $s0
    /* C8394 800D7B94 04001026 */  addiu      $s0, $s0, 0x4
    /* C8398 800D7B98 614A030C */  jal        Hud_FBuildF4__FiiiiiUlcc
    /* C839C 800D7B9C 1000B0AF */   sw        $s0, 0x10($sp)
    /* C83A0 800D7BA0 21200000 */  addu       $a0, $zero, $zero
    /* C83A4 800D7BA4 21302002 */  addu       $a2, $s1, $zero
    /* C83A8 800D7BA8 5800A28F */  lw         $v0, 0x58($sp)
    /* C83AC 800D7BAC 02000724 */  addiu      $a3, $zero, 0x2
    /* C83B0 800D7BB0 1000B0AF */  sw         $s0, 0x10($sp)
    /* C83B4 800D7BB4 1400A0AF */  sw         $zero, 0x14($sp)
    /* C83B8 800D7BB8 1800A0AF */  sw         $zero, 0x18($sp)
    /* C83BC 800D7BBC 1C00A0AF */  sw         $zero, 0x1C($sp)
    /* C83C0 800D7BC0 21A08202 */  addu       $s4, $s4, $v0
    /* C83C4 800D7BC4 614A030C */  jal        Hud_FBuildF4__FiiiiiUlcc
    /* C83C8 800D7BC8 FEFF8526 */   addiu     $a1, $s4, -0x2
    /* C83CC 800D7BCC 21200000 */  addu       $a0, $zero, $zero
    /* C83D0 800D7BD0 2128E002 */  addu       $a1, $s7, $zero
    /* C83D4 800D7BD4 5C00A28F */  lw         $v0, 0x5C($sp)
    /* C83D8 800D7BD8 21386002 */  addu       $a3, $s3, $zero
    /* C83DC 800D7BDC 1400A0AF */  sw         $zero, 0x14($sp)
    /* C83E0 800D7BE0 1800A0AF */  sw         $zero, 0x18($sp)
    /* C83E4 800D7BE4 1C00A0AF */  sw         $zero, 0x1C($sp)
    /* C83E8 800D7BE8 21A8A202 */  addu       $s5, $s5, $v0
    /* C83EC 800D7BEC 2130A002 */  addu       $a2, $s5, $zero
    /* C83F0 800D7BF0 02000224 */  addiu      $v0, $zero, 0x2
    /* C83F4 800D7BF4 614A030C */  jal        Hud_FBuildF4__FiiiiiUlcc
    /* C83F8 800D7BF8 1000A2AF */   sw        $v0, 0x10($sp)
    /* C83FC 800D7BFC 1180023C */  lui        $v0, %hi(HudPmx_gShapes)
    /* C8400 800D7C00 980C4224 */  addiu      $v0, $v0, %lo(HudPmx_gShapes)
    /* C8404 800D7C04 18014424 */  addiu      $a0, $v0, 0x118
    /* C8408 800D7C08 2128C003 */  addu       $a1, $fp, $zero
    /* C840C 800D7C0C 2000A68F */  lw         $a2, 0x20($sp)
    /* C8410 800D7C10 1A4A030C */  jal        Hud_FBuildGT4__FP13HudPmx_tShapeiiUl
    /* C8414 800D7C14 21380000 */   addu      $a3, $zero, $zero
    /* C8418 800D7C18 1180023C */  lui        $v0, %hi(HudPmx_gShapes)
    /* C841C 800D7C1C 980C4224 */  addiu      $v0, $v0, %lo(HudPmx_gShapes)
    /* C8420 800D7C20 2C014424 */  addiu      $a0, $v0, 0x12C
    /* C8424 800D7C24 23A09602 */  subu       $s4, $s4, $s6
    /* C8428 800D7C28 21288002 */  addu       $a1, $s4, $zero
    /* C842C 800D7C2C 2000A68F */  lw         $a2, 0x20($sp)
    /* C8430 800D7C30 1A4A030C */  jal        Hud_FBuildGT4__FP13HudPmx_tShapeiiUl
    /* C8434 800D7C34 21380000 */   addu      $a3, $zero, $zero
    /* C8438 800D7C38 1180023C */  lui        $v0, %hi(HudPmx_gShapes)
    /* C843C 800D7C3C 980C4224 */  addiu      $v0, $v0, %lo(HudPmx_gShapes)
    /* C8440 800D7C40 40014424 */  addiu      $a0, $v0, 0x140
    /* C8444 800D7C44 2128C003 */  addu       $a1, $fp, $zero
    /* C8448 800D7C48 FEFF5226 */  addiu      $s2, $s2, -0x2
    /* C844C 800D7C4C 23A8B202 */  subu       $s5, $s5, $s2
    /* C8450 800D7C50 2130A002 */  addu       $a2, $s5, $zero
    /* C8454 800D7C54 1A4A030C */  jal        Hud_FBuildGT4__FP13HudPmx_tShapeiiUl
    /* C8458 800D7C58 21380000 */   addu      $a3, $zero, $zero
    /* C845C 800D7C5C 1180023C */  lui        $v0, %hi(HudPmx_gShapes)
    /* C8460 800D7C60 980C4224 */  addiu      $v0, $v0, %lo(HudPmx_gShapes)
    /* C8464 800D7C64 54014424 */  addiu      $a0, $v0, 0x154
    /* C8468 800D7C68 21288002 */  addu       $a1, $s4, $zero
    /* C846C 800D7C6C 2130A002 */  addu       $a2, $s5, $zero
    /* C8470 800D7C70 1A4A030C */  jal        Hud_FBuildGT4__FP13HudPmx_tShapeiiUl
    /* C8474 800D7C74 21380000 */   addu      $a3, $zero, $zero
    /* C8478 800D7C78 4C00BF8F */  lw         $ra, 0x4C($sp)
    /* C847C 800D7C7C 4800BE8F */  lw         $fp, 0x48($sp)
    /* C8480 800D7C80 4400B78F */  lw         $s7, 0x44($sp)
    /* C8484 800D7C84 4000B68F */  lw         $s6, 0x40($sp)
    /* C8488 800D7C88 3C00B58F */  lw         $s5, 0x3C($sp)
    /* C848C 800D7C8C 3800B48F */  lw         $s4, 0x38($sp)
    /* C8490 800D7C90 3400B38F */  lw         $s3, 0x34($sp)
    /* C8494 800D7C94 3000B28F */  lw         $s2, 0x30($sp)
    /* C8498 800D7C98 2C00B18F */  lw         $s1, 0x2C($sp)
    /* C849C 800D7C9C 2800B08F */  lw         $s0, 0x28($sp)
    /* C84A0 800D7CA0 0800E003 */  jr         $ra
    /* C84A4 800D7CA4 5000BD27 */   addiu     $sp, $sp, 0x50
endlabel Hud_BlackThinBox__Fiiii
