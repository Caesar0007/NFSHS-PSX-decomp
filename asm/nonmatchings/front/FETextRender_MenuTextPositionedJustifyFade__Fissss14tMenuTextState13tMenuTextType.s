.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FETextRender_MenuTextPositionedJustifyFade__Fissss14tMenuTextState13tMenuTextType, 0xD0

glabel FETextRender_MenuTextPositionedJustifyFade__Fissss14tMenuTextState13tMenuTextType
    /* 119D4 800211D4 C0FFBD27 */  addiu      $sp, $sp, -0x40
    /* 119D8 800211D8 2000B0AF */  sw         $s0, 0x20($sp)
    /* 119DC 800211DC 5800B08F */  lw         $s0, 0x58($sp)
    /* 119E0 800211E0 3400B5AF */  sw         $s5, 0x34($sp)
    /* 119E4 800211E4 21A88000 */  addu       $s5, $a0, $zero
    /* 119E8 800211E8 2400B1AF */  sw         $s1, 0x24($sp)
    /* 119EC 800211EC 2188A000 */  addu       $s1, $a1, $zero
    /* 119F0 800211F0 2C00B3AF */  sw         $s3, 0x2C($sp)
    /* 119F4 800211F4 2198C000 */  addu       $s3, $a2, $zero
    /* 119F8 800211F8 3000B4AF */  sw         $s4, 0x30($sp)
    /* 119FC 800211FC 21A0E000 */  addu       $s4, $a3, $zero
    /* 11A00 80021200 2800B2AF */  sw         $s2, 0x28($sp)
    /* 11A04 80021204 5000B287 */  lh         $s2, 0x50($sp)
    /* 11A08 80021208 06000224 */  addiu      $v0, $zero, 0x6
    /* 11A0C 8002120C 03004212 */  beq        $s2, $v0, .L8002121C
    /* 11A10 80021210 3800BFAF */   sw        $ra, 0x38($sp)
    /* 11A14 80021214 06000016 */  bnez       $s0, .L80021230
    /* 11A18 80021218 0E000224 */   addiu     $v0, $zero, 0xE
  .L8002121C:
    /* 11A1C 8002121C 00241100 */  sll        $a0, $s1, 16
    /* 11A20 80021220 4586000C */  jal        FETextRender_Title__Fs
    /* 11A24 80021224 03240400 */   sra       $a0, $a0, 16
    /* 11A28 80021228 A0840008 */  j          .L80021280
    /* 11A2C 8002122C 00000000 */   nop
  .L80021230:
    /* 11A30 80021230 05000216 */  bne        $s0, $v0, .L80021248
    /* 11A34 80021234 00000000 */   nop
    /* 11A38 80021238 00241100 */  sll        $a0, $s1, 16
    /* 11A3C 8002123C 9CE4020C */  jal        TextSys_WordFlags__Fi
    /* 11A40 80021240 03240400 */   sra       $a0, $a0, 16
    /* 11A44 80021244 21804000 */  addu       $s0, $v0, $zero
  .L80021248:
    /* 11A48 80021248 00241100 */  sll        $a0, $s1, 16
    /* 11A4C 8002124C 94E4020C */  jal        TextSys_Word__Fi
    /* 11A50 80021250 03240400 */   sra       $a0, $a0, 16
    /* 11A54 80021254 2120A002 */  addu       $a0, $s5, $zero
    /* 11A58 80021258 00341300 */  sll        $a2, $s3, 16
    /* 11A5C 8002125C 003C1400 */  sll        $a3, $s4, 16
    /* 11A60 80021260 21284000 */  addu       $a1, $v0, $zero
    /* 11A64 80021264 03340600 */  sra        $a2, $a2, 16
    /* 11A68 80021268 5400A38F */  lw         $v1, 0x54($sp)
    /* 11A6C 8002126C 033C0700 */  sra        $a3, $a3, 16
    /* 11A70 80021270 1000B0AF */  sw         $s0, 0x10($sp)
    /* 11A74 80021274 1800B2AF */  sw         $s2, 0x18($sp)
    /* 11A78 80021278 D183000C */  jal        FETextRender_FullTextFade__FiPcss13tMenuTextType14tMenuTextStates
    /* 11A7C 8002127C 1400A3AF */   sw        $v1, 0x14($sp)
  .L80021280:
    /* 11A80 80021280 3800BF8F */  lw         $ra, 0x38($sp)
    /* 11A84 80021284 3400B58F */  lw         $s5, 0x34($sp)
    /* 11A88 80021288 3000B48F */  lw         $s4, 0x30($sp)
    /* 11A8C 8002128C 2C00B38F */  lw         $s3, 0x2C($sp)
    /* 11A90 80021290 2800B28F */  lw         $s2, 0x28($sp)
    /* 11A94 80021294 2400B18F */  lw         $s1, 0x24($sp)
    /* 11A98 80021298 2000B08F */  lw         $s0, 0x20($sp)
    /* 11A9C 8002129C 0800E003 */  jr         $ra
    /* 11AA0 800212A0 4000BD27 */   addiu     $sp, $sp, 0x40
endlabel FETextRender_MenuTextPositionedJustifyFade__Fissss14tMenuTextState13tMenuTextType
