.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDstreamisheld, 0x120

glabel iSNDstreamisheld
    /* D9B18 800E9318 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* D9B1C 800E931C 1400B1AF */  sw         $s1, 0x14($sp)
    /* D9B20 800E9320 21888000 */  addu       $s1, $a0, $zero
    /* D9B24 800E9324 1800BFAF */  sw         $ra, 0x18($sp)
    /* D9B28 800E9328 1000B0AF */  sw         $s0, 0x10($sp)
    /* D9B2C 800E932C 17002392 */  lbu        $v1, 0x17($s1)
    /* D9B30 800E9330 00000000 */  nop
    /* D9B34 800E9334 001E0300 */  sll        $v1, $v1, 24
    /* D9B38 800E9338 031E0300 */  sra        $v1, $v1, 24
    /* D9B3C 800E933C 40100300 */  sll        $v0, $v1, 1
    /* D9B40 800E9340 21104300 */  addu       $v0, $v0, $v1
    /* D9B44 800E9344 80100200 */  sll        $v0, $v0, 2
    /* D9B48 800E9348 23104300 */  subu       $v0, $v0, $v1
    /* D9B4C 800E934C 0000238E */  lw         $v1, 0x0($s1)
    /* D9B50 800E9350 80100200 */  sll        $v0, $v0, 2
    /* D9B54 800E9354 21806200 */  addu       $s0, $v1, $v0
    /* D9B58 800E9358 1000028E */  lw         $v0, 0x10($s0)
    /* D9B5C 800E935C 00000000 */  nop
    /* D9B60 800E9360 30004010 */  beqz       $v0, .L800E9424
    /* D9B64 800E9364 21100000 */   addu      $v0, $zero, $zero
    /* D9B68 800E9368 28000296 */  lhu        $v0, 0x28($s0)
    /* D9B6C 800E936C 00000000 */  nop
    /* D9B70 800E9370 00140200 */  sll        $v0, $v0, 16
    /* D9B74 800E9374 2B004004 */  bltz       $v0, .L800E9424
    /* D9B78 800E9378 01000224 */   addiu     $v0, $zero, 0x1
    /* D9B7C 800E937C 28000296 */  lhu        $v0, 0x28($s0)
    /* D9B80 800E9380 00000000 */  nop
    /* D9B84 800E9384 27004010 */  beqz       $v0, .L800E9424
    /* D9B88 800E9388 21100000 */   addu      $v0, $zero, $zero
    /* D9B8C 800E938C 0400248E */  lw         $a0, 0x4($s1)
    /* D9B90 800E9390 F3F6030C */  jal        STREAM_gettable
    /* D9B94 800E9394 00000000 */   nop
    /* D9B98 800E9398 21184000 */  addu       $v1, $v0, $zero
    /* D9B9C 800E939C 3D00023C */  lui        $v0, (0x3D0900 >> 16)
    /* D9BA0 800E93A0 00094234 */  ori        $v0, $v0, (0x3D0900 & 0xFFFF)
    /* D9BA4 800E93A4 2B104300 */  sltu       $v0, $v0, $v1
    /* D9BA8 800E93A8 04004010 */  beqz       $v0, .L800E93BC
    /* D9BAC 800E93AC 40110300 */   sll       $v0, $v1, 5
    /* D9BB0 800E93B0 3D00033C */  lui        $v1, (0x3D0900 >> 16)
    /* D9BB4 800E93B4 00096334 */  ori        $v1, $v1, (0x3D0900 & 0xFFFF)
    /* D9BB8 800E93B8 40110300 */  sll        $v0, $v1, 5
  .L800E93BC:
    /* D9BBC 800E93BC 23104300 */  subu       $v0, $v0, $v1
    /* D9BC0 800E93C0 80100200 */  sll        $v0, $v0, 2
    /* D9BC4 800E93C4 21104300 */  addu       $v0, $v0, $v1
    /* D9BC8 800E93C8 1000038E */  lw         $v1, 0x10($s0)
    /* D9BCC 800E93CC C0100200 */  sll        $v0, $v0, 3
    /* D9BD0 800E93D0 1B004300 */  divu       $zero, $v0, $v1
    /* D9BD4 800E93D4 02006014 */  bnez       $v1, .L800E93E0
    /* D9BD8 800E93D8 00000000 */   nop
    /* D9BDC 800E93DC 0D000700 */  break      7
  .L800E93E0:
    /* D9BE0 800E93E0 12100000 */  mflo       $v0
    /* D9BE4 800E93E4 28000396 */  lhu        $v1, 0x28($s0)
    /* D9BE8 800E93E8 00000000 */  nop
    /* D9BEC 800E93EC 001C0300 */  sll        $v1, $v1, 16
    /* D9BF0 800E93F0 031C0300 */  sra        $v1, $v1, 16
    /* D9BF4 800E93F4 2B104300 */  sltu       $v0, $v0, $v1
    /* D9BF8 800E93F8 04004014 */  bnez       $v0, .L800E940C
    /* D9BFC 800E93FC 00000000 */   nop
  .L800E9400:
    /* D9C00 800E9400 280000A6 */  sh         $zero, 0x28($s0)
    /* D9C04 800E9404 09A50308 */  j          .L800E9424
    /* D9C08 800E9408 21100000 */   addu      $v0, $zero, $zero
  .L800E940C:
    /* D9C0C 800E940C 0400248E */  lw         $a0, 0x4($s1)
    /* D9C10 800E9410 01F7030C */  jal        STREAM_state
    /* D9C14 800E9414 00000000 */   nop
    /* D9C18 800E9418 02000324 */  addiu      $v1, $zero, 0x2
    /* D9C1C 800E941C F8FF4310 */  beq        $v0, $v1, .L800E9400
    /* D9C20 800E9420 01000224 */   addiu     $v0, $zero, 0x1
  .L800E9424:
    /* D9C24 800E9424 1800BF8F */  lw         $ra, 0x18($sp)
    /* D9C28 800E9428 1400B18F */  lw         $s1, 0x14($sp)
    /* D9C2C 800E942C 1000B08F */  lw         $s0, 0x10($sp)
    /* D9C30 800E9430 0800E003 */  jr         $ra
    /* D9C34 800E9434 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel iSNDstreamisheld
