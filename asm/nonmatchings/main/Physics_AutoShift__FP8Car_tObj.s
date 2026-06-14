.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Physics_AutoShift__FP8Car_tObj, 0x2BC

glabel Physics_AutoShift__FP8Car_tObj
    /* 9A250 800A9A50 C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* 9A254 800A9A54 1000B0AF */  sw         $s0, 0x10($sp)
    /* 9A258 800A9A58 21808000 */  addu       $s0, $a0, $zero
    /* 9A25C 800A9A5C 3000BFAF */  sw         $ra, 0x30($sp)
    /* 9A260 800A9A60 2C00B7AF */  sw         $s7, 0x2C($sp)
    /* 9A264 800A9A64 2800B6AF */  sw         $s6, 0x28($sp)
    /* 9A268 800A9A68 2400B5AF */  sw         $s5, 0x24($sp)
    /* 9A26C 800A9A6C 2000B4AF */  sw         $s4, 0x20($sp)
    /* 9A270 800A9A70 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 9A274 800A9A74 1800B2AF */  sw         $s2, 0x18($sp)
    /* 9A278 800A9A78 1400B1AF */  sw         $s1, 0x14($sp)
    /* 9A27C 800A9A7C 6404048E */  lw         $a0, 0x464($s0)
    /* 9A280 800A9A80 AA2A023C */  lui        $v0, (0x2AAAAAAB >> 16)
    /* 9A284 800A9A84 F000858C */  lw         $a1, 0xF0($a0)
    /* 9A288 800A9A88 ABAA4234 */  ori        $v0, $v0, (0x2AAAAAAB & 0xFFFF)
    /* 9A28C 800A9A8C 1800A200 */  mult       $a1, $v0
    /* 9A290 800A9A90 21B00000 */  addu       $s6, $zero, $zero
    /* 9A294 800A9A94 42040292 */  lbu        $v0, 0x442($s0)
    /* 9A298 800A9A98 C3370500 */  sra        $a2, $a1, 31
    /* 9A29C 800A9A9C 0200422C */  sltiu      $v0, $v0, 0x2
    /* 9A2A0 800A9AA0 10380000 */  mfhi       $a3
    /* 9A2A4 800A9AA4 2318E600 */  subu       $v1, $a3, $a2
    /* 9A2A8 800A9AA8 8D004014 */  bnez       $v0, .L800A9CE0
    /* 9A2AC 800A9AAC 23A8A300 */   subu      $s5, $a1, $v1
    /* 9A2B0 800A9AB0 6004028E */  lw         $v0, 0x460($s0)
    /* 9A2B4 800A9AB4 00000000 */  nop
    /* 9A2B8 800A9AB8 03004010 */  beqz       $v0, .L800A9AC8
    /* 9A2BC 800A9ABC 2310A600 */   subu      $v0, $a1, $a2
    /* 9A2C0 800A9AC0 43100200 */  sra        $v0, $v0, 1
    /* 9A2C4 800A9AC4 23A8A200 */  subu       $s5, $a1, $v0
  .L800A9AC8:
    /* 9A2C8 800A9AC8 0400828C */  lw         $v0, 0x4($a0)
    /* 9A2CC 800A9ACC 7804038E */  lw         $v1, 0x478($s0)
    /* 9A2D0 800A9AD0 FEFF4224 */  addiu      $v0, $v0, -0x2
    /* 9A2D4 800A9AD4 80100200 */  sll        $v0, $v0, 2
    /* 9A2D8 800A9AD8 21108200 */  addu       $v0, $a0, $v0
    /* 9A2DC 800A9ADC 8001448C */  lw         $a0, 0x180($v0)
    /* 9A2E0 800A9AE0 02006104 */  bgez       $v1, .L800A9AEC
    /* 9A2E4 800A9AE4 21B86000 */   addu      $s7, $v1, $zero
    /* 9A2E8 800A9AE8 23B81700 */  negu       $s7, $s7
  .L800A9AEC:
    /* 9A2EC 800A9AEC CA90030C */  jal        fixedmult
    /* 9A2F0 800A9AF0 002C0500 */   sll       $a1, $a1, 16
    /* 9A2F4 800A9AF4 6404058E */  lw         $a1, 0x464($s0)
    /* 9A2F8 800A9AF8 00000000 */  nop
    /* 9A2FC 800A9AFC F400A38C */  lw         $v1, 0xF4($a1)
    /* 9A300 800A9B00 00000000 */  nop
    /* 9A304 800A9B04 2A186200 */  slt        $v1, $v1, $v0
    /* 9A308 800A9B08 03006010 */  beqz       $v1, .L800A9B18
    /* 9A30C 800A9B0C 0100C326 */   addiu     $v1, $s6, 0x1
    /* 9A310 800A9B10 01001624 */  addiu      $s6, $zero, 0x1
    /* 9A314 800A9B14 0100C326 */  addiu      $v1, $s6, 0x1
  .L800A9B18:
    /* 9A318 800A9B18 42040492 */  lbu        $a0, 0x442($s0)
    /* 9A31C 800A9B1C 0400A28C */  lw         $v0, 0x4($a1)
    /* 9A320 800A9B20 00000000 */  nop
    /* 9A324 800A9B24 23104300 */  subu       $v0, $v0, $v1
    /* 9A328 800A9B28 2A108200 */  slt        $v0, $a0, $v0
    /* 9A32C 800A9B2C 02004010 */  beqz       $v0, .L800A9B38
    /* 9A330 800A9B30 21988000 */   addu      $s3, $a0, $zero
    /* 9A334 800A9B34 01007326 */  addiu      $s3, $s3, 0x1
  .L800A9B38:
    /* 9A338 800A9B38 0300822C */  sltiu      $v0, $a0, 0x3
    /* 9A33C 800A9B3C 02004014 */  bnez       $v0, .L800A9B48
    /* 9A340 800A9B40 21908000 */   addu      $s2, $a0, $zero
    /* 9A344 800A9B44 FFFF9224 */  addiu      $s2, $a0, -0x1
  .L800A9B48:
    /* 9A348 800A9B48 2004028E */  lw         $v0, 0x420($s0)
    /* 9A34C 800A9B4C C000118E */  lw         $s1, 0xC0($s0)
    /* 9A350 800A9B50 02004104 */  bgez       $v0, .L800A9B5C
    /* 9A354 800A9B54 00000000 */   nop
    /* 9A358 800A9B58 23881100 */  negu       $s1, $s1
  .L800A9B5C:
    /* 9A35C 800A9B5C 42040292 */  lbu        $v0, 0x442($s0)
    /* 9A360 800A9B60 6404038E */  lw         $v1, 0x464($s0)
    /* 9A364 800A9B64 80100200 */  sll        $v0, $v0, 2
    /* 9A368 800A9B68 21186200 */  addu       $v1, $v1, $v0
    /* 9A36C 800A9B6C 0C00658C */  lw         $a1, 0xC($v1)
    /* 9A370 800A9B70 CA90030C */  jal        fixedmult
    /* 9A374 800A9B74 21202002 */   addu      $a0, $s1, $zero
    /* 9A378 800A9B78 21304000 */  addu       $a2, $v0, $zero
    /* 9A37C 800A9B7C 0200C104 */  bgez       $a2, .L800A9B88
    /* 9A380 800A9B80 FFFF0234 */   ori       $v0, $zero, 0xFFFF
    /* 9A384 800A9B84 2130C200 */  addu       $a2, $a2, $v0
  .L800A9B88:
    /* 9A388 800A9B88 21202002 */  addu       $a0, $s1, $zero
    /* 9A38C 800A9B8C 6404028E */  lw         $v0, 0x464($s0)
    /* 9A390 800A9B90 80181300 */  sll        $v1, $s3, 2
    /* 9A394 800A9B94 21104300 */  addu       $v0, $v0, $v1
    /* 9A398 800A9B98 0C00458C */  lw         $a1, 0xC($v0)
    /* 9A39C 800A9B9C CA90030C */  jal        fixedmult
    /* 9A3A0 800A9BA0 03A40600 */   sra       $s4, $a2, 16
    /* 9A3A4 800A9BA4 6404028E */  lw         $v0, 0x464($s0)
    /* 9A3A8 800A9BA8 80181200 */  sll        $v1, $s2, 2
    /* 9A3AC 800A9BAC 21104300 */  addu       $v0, $v0, $v1
    /* 9A3B0 800A9BB0 0C00458C */  lw         $a1, 0xC($v0)
    /* 9A3B4 800A9BB4 CA90030C */  jal        fixedmult
    /* 9A3B8 800A9BB8 21202002 */   addu      $a0, $s1, $zero
    /* 9A3BC 800A9BBC 21184000 */  addu       $v1, $v0, $zero
    /* 9A3C0 800A9BC0 04006104 */  bgez       $v1, .L800A9BD4
    /* 9A3C4 800A9BC4 032C0300 */   sra       $a1, $v1, 16
    /* 9A3C8 800A9BC8 FFFF0234 */  ori        $v0, $zero, 0xFFFF
    /* 9A3CC 800A9BCC 21186200 */  addu       $v1, $v1, $v0
    /* 9A3D0 800A9BD0 032C0300 */  sra        $a1, $v1, 16
  .L800A9BD4:
    /* 9A3D4 800A9BD4 A80D838F */  lw         $v1, %gp_rel(gGasRatio)($gp)
    /* 9A3D8 800A9BD8 00800234 */  ori        $v0, $zero, 0x8000
    /* 9A3DC 800A9BDC 2A104300 */  slt        $v0, $v0, $v1
    /* 9A3E0 800A9BE0 0A004014 */  bnez       $v0, .L800A9C0C
    /* 9A3E4 800A9BE4 F401A226 */   addiu     $v0, $s5, 0x1F4
    /* 9A3E8 800A9BE8 6404028E */  lw         $v0, 0x464($s0)
    /* 9A3EC 800A9BEC 00000000 */  nop
    /* 9A3F0 800A9BF0 F000428C */  lw         $v0, 0xF0($v0)
    /* 9A3F4 800A9BF4 02008106 */  bgez       $s4, .L800A9C00
    /* 9A3F8 800A9BF8 21188002 */   addu      $v1, $s4, $zero
    /* 9A3FC 800A9BFC 23180300 */  negu       $v1, $v1
  .L800A9C00:
    /* 9A400 800A9C00 2A104300 */  slt        $v0, $v0, $v1
    /* 9A404 800A9C04 25004010 */  beqz       $v0, .L800A9C9C
    /* 9A408 800A9C08 F401A226 */   addiu     $v0, $s5, 0x1F4
  .L800A9C0C:
    /* 9A40C 800A9C0C 2A105400 */  slt        $v0, $v0, $s4
    /* 9A410 800A9C10 13004010 */  beqz       $v0, .L800A9C60
    /* 9A414 800A9C14 0100C326 */   addiu     $v1, $s6, 0x1
    /* 9A418 800A9C18 6404028E */  lw         $v0, 0x464($s0)
    /* 9A41C 800A9C1C 00000000 */  nop
    /* 9A420 800A9C20 0400428C */  lw         $v0, 0x4($v0)
    /* 9A424 800A9C24 42040492 */  lbu        $a0, 0x442($s0)
    /* 9A428 800A9C28 23104300 */  subu       $v0, $v0, $v1
    /* 9A42C 800A9C2C 2A108200 */  slt        $v0, $a0, $v0
    /* 9A430 800A9C30 0C004010 */  beqz       $v0, .L800A9C64
    /* 9A434 800A9C34 2A10B500 */   slt       $v0, $a1, $s5
    /* 9A438 800A9C38 29006412 */  beq        $s3, $a0, .L800A9CE0
    /* 9A43C 800A9C3C 00000000 */   nop
    /* 9A440 800A9C40 42040292 */  lbu        $v0, 0x442($s0)
    /* 9A444 800A9C44 6404038E */  lw         $v1, 0x464($s0)
    /* 9A448 800A9C48 430400A2 */  sb         $zero, 0x443($s0)
    /* 9A44C 800A9C4C 420413A2 */  sb         $s3, 0x442($s0)
    /* 9A450 800A9C50 410402A2 */  sb         $v0, 0x441($s0)
    /* 9A454 800A9C54 08006290 */  lbu        $v0, 0x8($v1)
    /* 9A458 800A9C58 38A70208 */  j          .L800A9CE0
    /* 9A45C 800A9C5C 440402A2 */   sb        $v0, 0x444($s0)
  .L800A9C60:
    /* 9A460 800A9C60 2A10B500 */  slt        $v0, $a1, $s5
  .L800A9C64:
    /* 9A464 800A9C64 1E004010 */  beqz       $v0, .L800A9CE0
    /* 9A468 800A9C68 00000000 */   nop
    /* 9A46C 800A9C6C 42040292 */  lbu        $v0, 0x442($s0)
    /* 9A470 800A9C70 00000000 */  nop
    /* 9A474 800A9C74 1A004212 */  beq        $s2, $v0, .L800A9CE0
    /* 9A478 800A9C78 01000224 */   addiu     $v0, $zero, 0x1
    /* 9A47C 800A9C7C 42040392 */  lbu        $v1, 0x442($s0)
    /* 9A480 800A9C80 6404048E */  lw         $a0, 0x464($s0)
    /* 9A484 800A9C84 430402A2 */  sb         $v0, 0x443($s0)
    /* 9A488 800A9C88 420412A2 */  sb         $s2, 0x442($s0)
    /* 9A48C 800A9C8C 410403A2 */  sb         $v1, 0x441($s0)
    /* 9A490 800A9C90 08008290 */  lbu        $v0, 0x8($a0)
    /* 9A494 800A9C94 38A70208 */  j          .L800A9CE0
    /* 9A498 800A9C98 440402A2 */   sb        $v0, 0x444($s0)
  .L800A9C9C:
    /* 9A49C 800A9C9C 2A10B500 */  slt        $v0, $a1, $s5
    /* 9A4A0 800A9CA0 0F004010 */  beqz       $v0, .L800A9CE0
    /* 9A4A4 800A9CA4 0200422A */   slti      $v0, $s2, 0x2
    /* 9A4A8 800A9CA8 0D004014 */  bnez       $v0, .L800A9CE0
    /* 9A4AC 800A9CAC 9919E22A */   slti      $v0, $s7, 0x1999
    /* 9A4B0 800A9CB0 0B004010 */  beqz       $v0, .L800A9CE0
    /* 9A4B4 800A9CB4 00000000 */   nop
    /* 9A4B8 800A9CB8 42040292 */  lbu        $v0, 0x442($s0)
    /* 9A4BC 800A9CBC 00000000 */  nop
    /* 9A4C0 800A9CC0 07004212 */  beq        $s2, $v0, .L800A9CE0
    /* 9A4C4 800A9CC4 01000324 */   addiu     $v1, $zero, 0x1
    /* 9A4C8 800A9CC8 6404028E */  lw         $v0, 0x464($s0)
    /* 9A4CC 800A9CCC 430403A2 */  sb         $v1, 0x443($s0)
    /* 9A4D0 800A9CD0 420412A2 */  sb         $s2, 0x442($s0)
    /* 9A4D4 800A9CD4 08004290 */  lbu        $v0, 0x8($v0)
    /* 9A4D8 800A9CD8 00000000 */  nop
    /* 9A4DC 800A9CDC 440402A2 */  sb         $v0, 0x444($s0)
  .L800A9CE0:
    /* 9A4E0 800A9CE0 3000BF8F */  lw         $ra, 0x30($sp)
    /* 9A4E4 800A9CE4 2C00B78F */  lw         $s7, 0x2C($sp)
    /* 9A4E8 800A9CE8 2800B68F */  lw         $s6, 0x28($sp)
    /* 9A4EC 800A9CEC 2400B58F */  lw         $s5, 0x24($sp)
    /* 9A4F0 800A9CF0 2000B48F */  lw         $s4, 0x20($sp)
    /* 9A4F4 800A9CF4 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 9A4F8 800A9CF8 1800B28F */  lw         $s2, 0x18($sp)
    /* 9A4FC 800A9CFC 1400B18F */  lw         $s1, 0x14($sp)
    /* 9A500 800A9D00 1000B08F */  lw         $s0, 0x10($sp)
    /* 9A504 800A9D04 0800E003 */  jr         $ra
    /* 9A508 800A9D08 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel Physics_AutoShift__FP8Car_tObj
