.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDstreamhotroddatachunks, 0x158

glabel iSNDstreamhotroddatachunks
    /* D9C38 800E9438 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* D9C3C 800E943C 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* D9C40 800E9440 21980000 */  addu       $s3, $zero, $zero
    /* D9C44 800E9444 2400B5AF */  sw         $s5, 0x24($sp)
    /* D9C48 800E9448 21A86002 */  addu       $s5, $s3, $zero
    /* D9C4C 800E944C 1480023C */  lui        $v0, %hi(sndss)
    /* D9C50 800E9450 2000B4AF */  sw         $s4, 0x20($sp)
    /* D9C54 800E9454 80EA5424 */  addiu      $s4, $v0, %lo(sndss)
    /* D9C58 800E9458 2800BFAF */  sw         $ra, 0x28($sp)
    /* D9C5C 800E945C 1800B2AF */  sw         $s2, 0x18($sp)
    /* D9C60 800E9460 1400B1AF */  sw         $s1, 0x14($sp)
    /* D9C64 800E9464 1000B0AF */  sw         $s0, 0x10($sp)
  .L800E9468:
    /* D9C68 800E9468 0000918E */  lw         $s1, 0x0($s4)
    /* D9C6C 800E946C 00000000 */  nop
    /* D9C70 800E9470 3B002012 */  beqz       $s1, .L800E9560
    /* D9C74 800E9474 00000000 */   nop
    /* D9C78 800E9478 16002292 */  lbu        $v0, 0x16($s1)
    /* D9C7C 800E947C 00000000 */  nop
    /* D9C80 800E9480 37004010 */  beqz       $v0, .L800E9560
    /* D9C84 800E9484 00000000 */   nop
    /* D9C88 800E9488 14002292 */  lbu        $v0, 0x14($s1)
    /* D9C8C 800E948C 01000324 */  addiu      $v1, $zero, 0x1
    /* D9C90 800E9490 00160200 */  sll        $v0, $v0, 24
    /* D9C94 800E9494 03160200 */  sra        $v0, $v0, 24
    /* D9C98 800E9498 31004314 */  bne        $v0, $v1, .L800E9560
    /* D9C9C 800E949C 00000000 */   nop
    /* D9CA0 800E94A0 C6A4030C */  jal        iSNDstreamisheld
    /* D9CA4 800E94A4 21202002 */   addu      $a0, $s1, $zero
    /* D9CA8 800E94A8 2D004014 */  bnez       $v0, .L800E9560
    /* D9CAC 800E94AC 00000000 */   nop
    /* D9CB0 800E94B0 17002392 */  lbu        $v1, 0x17($s1)
    /* D9CB4 800E94B4 00000000 */  nop
    /* D9CB8 800E94B8 001E0300 */  sll        $v1, $v1, 24
    /* D9CBC 800E94BC 031E0300 */  sra        $v1, $v1, 24
    /* D9CC0 800E94C0 40100300 */  sll        $v0, $v1, 1
    /* D9CC4 800E94C4 21104300 */  addu       $v0, $v0, $v1
    /* D9CC8 800E94C8 80100200 */  sll        $v0, $v0, 2
    /* D9CCC 800E94CC 23104300 */  subu       $v0, $v0, $v1
    /* D9CD0 800E94D0 0000238E */  lw         $v1, 0x0($s1)
    /* D9CD4 800E94D4 80100200 */  sll        $v0, $v0, 2
    /* D9CD8 800E94D8 21206200 */  addu       $a0, $v1, $v0
    /* D9CDC 800E94DC 2400828C */  lw         $v0, 0x24($a0)
    /* D9CE0 800E94E0 00000000 */  nop
    /* D9CE4 800E94E4 1E004010 */  beqz       $v0, .L800E9560
    /* D9CE8 800E94E8 00000000 */   nop
    /* D9CEC 800E94EC 2000828C */  lw         $v0, 0x20($a0)
    /* D9CF0 800E94F0 00000000 */  nop
    /* D9CF4 800E94F4 1A004010 */  beqz       $v0, .L800E9560
    /* D9CF8 800E94F8 00000000 */   nop
    /* D9CFC 800E94FC 2400838C */  lw         $v1, 0x24($a0)
    /* D9D00 800E9500 2000828C */  lw         $v0, 0x20($a0)
    /* D9D04 800E9504 0C00248E */  lw         $a0, 0xC($s1)
    /* D9D08 800E9508 9C0B040C */  jal        SNDPKTPLAY_submitspace
    /* D9D0C 800E950C 23906200 */   subu      $s2, $v1, $v0
    /* D9D10 800E9510 21804000 */  addu       $s0, $v0, $zero
    /* D9D14 800E9514 2A105002 */  slt        $v0, $s2, $s0
    /* D9D18 800E9518 02004010 */  beqz       $v0, .L800E9524
    /* D9D1C 800E951C 00000000 */   nop
    /* D9D20 800E9520 21804002 */  addu       $s0, $s2, $zero
  .L800E9524:
    /* D9D24 800E9524 0E00001A */  blez       $s0, .L800E9560
    /* D9D28 800E9528 00000000 */   nop
  .L800E952C:
    /* D9D2C 800E952C 0400248E */  lw         $a0, 0x4($s1)
    /* D9D30 800E9530 6BF6030C */  jal        STREAM_get
    /* D9D34 800E9534 FFFF1026 */   addiu     $s0, $s0, -0x1
    /* D9D38 800E9538 21284000 */  addu       $a1, $v0, $zero
    /* D9D3C 800E953C 0400A010 */  beqz       $a1, .L800E9550
    /* D9D40 800E9540 21202002 */   addu      $a0, $s1, $zero
    /* D9D44 800E9544 0400A28C */  lw         $v0, 0x4($a1)
    /* D9D48 800E9548 2BA4030C */  jal        iSNDstreamparsedata
    /* D9D4C 800E954C 21986202 */   addu      $s3, $s3, $v0
  .L800E9550:
    /* D9D50 800E9550 0300001A */  blez       $s0, .L800E9560
    /* D9D54 800E9554 0040622A */   slti      $v0, $s3, 0x4000
    /* D9D58 800E9558 F4FF4014 */  bnez       $v0, .L800E952C
    /* D9D5C 800E955C 00000000 */   nop
  .L800E9560:
    /* D9D60 800E9560 0100B526 */  addiu      $s5, $s5, 0x1
    /* D9D64 800E9564 C0FFA01A */  blez       $s5, .L800E9468
    /* D9D68 800E9568 04009426 */   addiu     $s4, $s4, 0x4
    /* D9D6C 800E956C 2800BF8F */  lw         $ra, 0x28($sp)
    /* D9D70 800E9570 2400B58F */  lw         $s5, 0x24($sp)
    /* D9D74 800E9574 2000B48F */  lw         $s4, 0x20($sp)
    /* D9D78 800E9578 1C00B38F */  lw         $s3, 0x1C($sp)
    /* D9D7C 800E957C 1800B28F */  lw         $s2, 0x18($sp)
    /* D9D80 800E9580 1400B18F */  lw         $s1, 0x14($sp)
    /* D9D84 800E9584 1000B08F */  lw         $s0, 0x10($sp)
    /* D9D88 800E9588 0800E003 */  jr         $ra
    /* D9D8C 800E958C 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel iSNDstreamhotroddatachunks
