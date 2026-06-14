.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Draw__25tPMenuItemLeftRightSliderb, 0x2A4

glabel Draw__25tPMenuItemLeftRightSliderb
    /* 981C8 800A79C8 B0FFBD27 */  addiu      $sp, $sp, -0x50
    /* 981CC 800A79CC 3C00B5AF */  sw         $s5, 0x3C($sp)
    /* 981D0 800A79D0 21A80000 */  addu       $s5, $zero, $zero
    /* 981D4 800A79D4 3800B4AF */  sw         $s4, 0x38($sp)
    /* 981D8 800A79D8 801F143C */  lui        $s4, (0x1F800004 >> 16)
    /* 981DC 800A79DC 04009436 */  ori        $s4, $s4, (0x1F800004 & 0xFFFF)
    /* 981E0 800A79E0 2C00B1AF */  sw         $s1, 0x2C($sp)
    /* 981E4 800A79E4 FF00113C */  lui        $s1, (0xFFFFFF >> 16)
    /* 981E8 800A79E8 FFFF3136 */  ori        $s1, $s1, (0xFFFFFF & 0xFFFF)
    /* 981EC 800A79EC 4C00BFAF */  sw         $ra, 0x4C($sp)
    /* 981F0 800A79F0 4800BEAF */  sw         $fp, 0x48($sp)
    /* 981F4 800A79F4 4400B7AF */  sw         $s7, 0x44($sp)
    /* 981F8 800A79F8 4000B6AF */  sw         $s6, 0x40($sp)
    /* 981FC 800A79FC 3400B3AF */  sw         $s3, 0x34($sp)
    /* 98200 800A7A00 3000B2AF */  sw         $s2, 0x30($sp)
    /* 98204 800A7A04 2800B0AF */  sw         $s0, 0x28($sp)
    /* 98208 800A7A08 5000A4AF */  sw         $a0, 0x50($sp)
    /* 9820C 800A7A0C 5400A5AF */  sw         $a1, 0x54($sp)
    /* 98210 800A7A10 0400848C */  lw         $a0, 0x4($a0)
    /* 98214 800A7A14 A4E4020C */  jal        TextSys_WordX__Fi
    /* 98218 800A7A18 42001724 */   addiu     $s7, $zero, 0x42
    /* 9821C 800A7A1C 003C0200 */  sll        $a3, $v0, 16
    /* 98220 800A7A20 033C0700 */  sra        $a3, $a3, 16
    /* 98224 800A7A24 5400A98F */  lw         $t1, 0x54($sp)
    /* 98228 800A7A28 21B0E000 */  addu       $s6, $a3, $zero
    /* 9822C 800A7A2C 002C0900 */  sll        $a1, $t1, 16
    /* 98230 800A7A30 5000A98F */  lw         $t1, 0x50($sp)
    /* 98234 800A7A34 78189397 */  lhu        $s3, %gp_rel(D_8013DDC4)($gp)
    /* 98238 800A7A38 0000268D */  lw         $a2, 0x0($t1)
    /* 9823C 800A7A3C 04002485 */  lh         $a0, 0x4($t1)
    /* 98240 800A7A40 032C0500 */  sra        $a1, $a1, 16
    /* 98244 800A7A44 2000A2A7 */  sh         $v0, 0x20($sp)
    /* 98248 800A7A48 C59B020C */  jal        PauseMenu_MenuTextPositioned__Fssss
    /* 9824C 800A7A4C 0100C630 */   andi      $a2, $a2, 0x1
    /* 98250 800A7A50 04007326 */  addiu      $s3, $s3, 0x4
  .L800A7A54:
    /* 98254 800A7A54 0F00A22A */  slti       $v0, $s5, 0xF
    /* 98258 800A7A58 69004010 */  beqz       $v0, .L800A7C00
    /* 9825C 800A7A5C 3200123C */   lui       $s2, (0x323232 >> 16)
    /* 98260 800A7A60 5000A98F */  lw         $t1, 0x50($sp)
    /* 98264 800A7A64 00000000 */  nop
    /* 98268 800A7A68 0C00228D */  lw         $v0, 0xC($t1)
    /* 9826C 800A7A6C 00000000 */  nop
    /* 98270 800A7A70 0000448C */  lw         $a0, 0x0($v0)
    /* 98274 800A7A74 10002391 */  lbu        $v1, 0x10($t1)
    /* 98278 800A7A78 00110400 */  sll        $v0, $a0, 4
    /* 9827C 800A7A7C 23104400 */  subu       $v0, $v0, $a0
    /* 98280 800A7A80 1A004300 */  div        $zero, $v0, $v1
    /* 98284 800A7A84 02006014 */  bnez       $v1, .L800A7A90
    /* 98288 800A7A88 00000000 */   nop
    /* 9828C 800A7A8C 0D000700 */  break      7
  .L800A7A90:
    /* 98290 800A7A90 FFFF0124 */  addiu      $at, $zero, -0x1
    /* 98294 800A7A94 04006114 */  bne        $v1, $at, .L800A7AA8
    /* 98298 800A7A98 0080013C */   lui       $at, (0x80000000 >> 16)
    /* 9829C 800A7A9C 02004114 */  bne        $v0, $at, .L800A7AA8
    /* 982A0 800A7AA0 00000000 */   nop
    /* 982A4 800A7AA4 0D000600 */  break      6
  .L800A7AA8:
    /* 982A8 800A7AA8 12100000 */  mflo       $v0
    /* 982AC 800A7AAC 32325236 */  ori        $s2, $s2, (0x323232 & 0xFFFF)
    /* 982B0 800A7AB0 2A10A202 */  slt        $v0, $s5, $v0
    /* 982B4 800A7AB4 07004010 */  beqz       $v0, .L800A7AD4
    /* 982B8 800A7AB8 21F0D702 */   addu      $fp, $s6, $s7
    /* 982BC 800A7ABC 8000123C */  lui        $s2, (0x808080 >> 16)
    /* 982C0 800A7AC0 5400A98F */  lw         $t1, 0x54($sp)
    /* 982C4 800A7AC4 00000000 */  nop
    /* 982C8 800A7AC8 3E002011 */  beqz       $t1, .L800A7BC4
    /* 982CC 800A7ACC 80805236 */   ori       $s2, $s2, (0x808080 & 0xFFFF)
    /* 982D0 800A7AD0 BEBE1234 */  ori        $s2, $zero, 0xBEBE
  .L800A7AD4:
    /* 982D4 800A7AD4 5400A98F */  lw         $t1, 0x54($sp)
    /* 982D8 800A7AD8 00000000 */  nop
    /* 982DC 800A7ADC 39002011 */  beqz       $t1, .L800A7BC4
    /* 982E0 800A7AE0 1180023C */   lui       $v0, %hi(D_801132CC)
    /* 982E4 800A7AE4 CC32428C */  lw         $v0, %lo(D_801132CC)($v0)
    /* 982E8 800A7AE8 00000000 */  nop
    /* 982EC 800A7AEC 36004014 */  bnez       $v0, .L800A7BC8
    /* 982F0 800A7AF0 21200000 */   addu      $a0, $zero, $zero
    /* 982F4 800A7AF4 1180053C */  lui        $a1, %hi(D_80110E00)
    /* 982F8 800A7AF8 000EA524 */  addiu      $a1, $a1, %lo(D_80110E00)
    /* 982FC 800A7AFC 3500C626 */  addiu      $a2, $s6, 0x35
    /* 98300 800A7B00 00841300 */  sll        $s0, $s3, 16
    /* 98304 800A7B04 03841000 */  sra        $s0, $s0, 16
    /* 98308 800A7B08 02001026 */  addiu      $s0, $s0, 0x2
    /* 9830C 800A7B0C 21380002 */  addu       $a3, $s0, $zero
    /* 98310 800A7B10 00FF093C */  lui        $t1, (0xFF000000 >> 16)
    /* 98314 800A7B14 0000848E */  lw         $a0, 0x0($s4)
    /* 98318 800A7B18 801F083C */  lui        $t0, (0x1F800000 >> 16)
    /* 9831C 800A7B1C 0000088D */  lw         $t0, (0x1F800000 & 0xFFFF)($t0)
    /* 98320 800A7B20 0000838C */  lw         $v1, 0x0($a0)
    /* 98324 800A7B24 0000028D */  lw         $v0, 0x0($t0)
    /* 98328 800A7B28 24186900 */  and        $v1, $v1, $t1
    /* 9832C 800A7B2C 24105100 */  and        $v0, $v0, $s1
    /* 98330 800A7B30 25186200 */  or         $v1, $v1, $v0
    /* 98334 800A7B34 000083AC */  sw         $v1, 0x0($a0)
    /* 98338 800A7B38 0000038D */  lw         $v1, 0x0($t0)
    /* 9833C 800A7B3C 34008224 */  addiu      $v0, $a0, 0x34
    /* 98340 800A7B40 000082AE */  sw         $v0, 0x0($s4)
    /* 98344 800A7B44 24109100 */  and        $v0, $a0, $s1
    /* 98348 800A7B48 24186900 */  and        $v1, $v1, $t1
    /* 9834C 800A7B4C 25186200 */  or         $v1, $v1, $v0
    /* 98350 800A7B50 000003AD */  sw         $v1, 0x0($t0)
    /* 98354 800A7B54 BEBE0934 */  ori        $t1, $zero, 0xBEBE
    /* 98358 800A7B58 A248030C */  jal        Hud_BuildGT4__FP8POLY_GT4P13HudPmx_tShapeiiUl
    /* 9835C 800A7B5C 1000A9AF */   sw        $t1, 0x10($sp)
    /* 98360 800A7B60 1180093C */  lui        $t1, %hi(D_80110E00)
    /* 98364 800A7B64 000E2925 */  addiu      $t1, $t1, %lo(D_80110E00)
    /* 98368 800A7B68 14002525 */  addiu      $a1, $t1, 0x14
    /* 9836C 800A7B6C 9000C626 */  addiu      $a2, $s6, 0x90
    /* 98370 800A7B70 21380002 */  addu       $a3, $s0, $zero
    /* 98374 800A7B74 00FF093C */  lui        $t1, (0xFF000000 >> 16)
    /* 98378 800A7B78 0000848E */  lw         $a0, 0x0($s4)
    /* 9837C 800A7B7C 801F083C */  lui        $t0, (0x1F800000 >> 16)
    /* 98380 800A7B80 0000088D */  lw         $t0, (0x1F800000 & 0xFFFF)($t0)
    /* 98384 800A7B84 0000838C */  lw         $v1, 0x0($a0)
    /* 98388 800A7B88 0000028D */  lw         $v0, 0x0($t0)
    /* 9838C 800A7B8C 24186900 */  and        $v1, $v1, $t1
    /* 98390 800A7B90 24105100 */  and        $v0, $v0, $s1
    /* 98394 800A7B94 25186200 */  or         $v1, $v1, $v0
    /* 98398 800A7B98 000083AC */  sw         $v1, 0x0($a0)
    /* 9839C 800A7B9C 0000038D */  lw         $v1, 0x0($t0)
    /* 983A0 800A7BA0 34008224 */  addiu      $v0, $a0, 0x34
    /* 983A4 800A7BA4 000082AE */  sw         $v0, 0x0($s4)
    /* 983A8 800A7BA8 24109100 */  and        $v0, $a0, $s1
    /* 983AC 800A7BAC 24186900 */  and        $v1, $v1, $t1
    /* 983B0 800A7BB0 25186200 */  or         $v1, $v1, $v0
    /* 983B4 800A7BB4 000003AD */  sw         $v1, 0x0($t0)
    /* 983B8 800A7BB8 BEBE0934 */  ori        $t1, $zero, 0xBEBE
    /* 983BC 800A7BBC A248030C */  jal        Hud_BuildGT4__FP8POLY_GT4P13HudPmx_tShapeiiUl
    /* 983C0 800A7BC0 1000A9AF */   sw        $t1, 0x10($sp)
  .L800A7BC4:
    /* 983C4 800A7BC4 21200000 */  addu       $a0, $zero, $zero
  .L800A7BC8:
    /* 983C8 800A7BC8 2128C003 */  addu       $a1, $fp, $zero
    /* 983CC 800A7BCC 00341300 */  sll        $a2, $s3, 16
    /* 983D0 800A7BD0 03340600 */  sra        $a2, $a2, 16
    /* 983D4 800A7BD4 0200C624 */  addiu      $a2, $a2, 0x2
    /* 983D8 800A7BD8 03000724 */  addiu      $a3, $zero, 0x3
    /* 983DC 800A7BDC 05000224 */  addiu      $v0, $zero, 0x5
    /* 983E0 800A7BE0 1000A2AF */  sw         $v0, 0x10($sp)
    /* 983E4 800A7BE4 1400B2AF */  sw         $s2, 0x14($sp)
    /* 983E8 800A7BE8 1800A0AF */  sw         $zero, 0x18($sp)
    /* 983EC 800A7BEC 614A030C */  jal        Hud_FBuildF4__FiiiiiUlcc
    /* 983F0 800A7BF0 1C00A0AF */   sw        $zero, 0x1C($sp)
    /* 983F4 800A7BF4 0500F726 */  addiu      $s7, $s7, 0x5
    /* 983F8 800A7BF8 959E0208 */  j          .L800A7A54
    /* 983FC 800A7BFC 0100B526 */   addiu     $s5, $s5, 0x1
  .L800A7C00:
    /* 98400 800A7C00 21200000 */  addu       $a0, $zero, $zero
    /* 98404 800A7C04 00341300 */  sll        $a2, $s3, 16
    /* 98408 800A7C08 03340600 */  sra        $a2, $a2, 16
    /* 9840C 800A7C0C 0100C624 */  addiu      $a2, $a2, 0x1
    /* 98410 800A7C10 4F000724 */  addiu      $a3, $zero, 0x4F
    /* 98414 800A7C14 2000A997 */  lhu        $t1, 0x20($sp)
    /* 98418 800A7C18 07000224 */  addiu      $v0, $zero, 0x7
    /* 9841C 800A7C1C 1000A2AF */  sw         $v0, 0x10($sp)
    /* 98420 800A7C20 1400A0AF */  sw         $zero, 0x14($sp)
    /* 98424 800A7C24 1800A0AF */  sw         $zero, 0x18($sp)
    /* 98428 800A7C28 1C00A0AF */  sw         $zero, 0x1C($sp)
    /* 9842C 800A7C2C 002C0900 */  sll        $a1, $t1, 16
    /* 98430 800A7C30 032C0500 */  sra        $a1, $a1, 16
    /* 98434 800A7C34 614A030C */  jal        Hud_FBuildF4__FiiiiiUlcc
    /* 98438 800A7C38 3F00A524 */   addiu     $a1, $a1, 0x3F
    /* 9843C 800A7C3C 4C00BF8F */  lw         $ra, 0x4C($sp)
    /* 98440 800A7C40 4800BE8F */  lw         $fp, 0x48($sp)
    /* 98444 800A7C44 4400B78F */  lw         $s7, 0x44($sp)
    /* 98448 800A7C48 4000B68F */  lw         $s6, 0x40($sp)
    /* 9844C 800A7C4C 3C00B58F */  lw         $s5, 0x3C($sp)
    /* 98450 800A7C50 3800B48F */  lw         $s4, 0x38($sp)
    /* 98454 800A7C54 3400B38F */  lw         $s3, 0x34($sp)
    /* 98458 800A7C58 3000B28F */  lw         $s2, 0x30($sp)
    /* 9845C 800A7C5C 2C00B18F */  lw         $s1, 0x2C($sp)
    /* 98460 800A7C60 2800B08F */  lw         $s0, 0x28($sp)
    /* 98464 800A7C64 0800E003 */  jr         $ra
    /* 98468 800A7C68 5000BD27 */   addiu     $sp, $sp, 0x50
endlabel Draw__25tPMenuItemLeftRightSliderb
