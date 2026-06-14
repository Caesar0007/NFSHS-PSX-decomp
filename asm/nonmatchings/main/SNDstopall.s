.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SNDstopall, 0x78

glabel SNDstopall
    /* D89A8 800E81A8 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* D89AC 800E81AC 1480023C */  lui        $v0, %hi(sndgs)
    /* D89B0 800E81B0 60784324 */  addiu      $v1, $v0, %lo(sndgs)
    /* D89B4 800E81B4 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* D89B8 800E81B8 1800B2AF */  sw         $s2, 0x18($sp)
    /* D89BC 800E81BC 1400B1AF */  sw         $s1, 0x14($sp)
    /* D89C0 800E81C0 1000B0AF */  sw         $s0, 0x10($sp)
    /* D89C4 800E81C4 11006290 */  lbu        $v0, 0x11($v1)
    /* D89C8 800E81C8 00000000 */  nop
    /* D89CC 800E81CC 0E004010 */  beqz       $v0, .L800E8208
    /* D89D0 800E81D0 21800000 */   addu      $s0, $zero, $zero
    /* D89D4 800E81D4 21906000 */  addu       $s2, $v1, $zero
    /* D89D8 800E81D8 21880002 */  addu       $s1, $s0, $zero
  .L800E81DC:
    /* D89DC 800E81DC 9400428E */  lw         $v0, 0x94($s2)
    /* D89E0 800E81E0 00000000 */  nop
    /* D89E4 800E81E4 21102202 */  addu       $v0, $s1, $v0
    /* D89E8 800E81E8 0000448C */  lw         $a0, 0x0($v0)
    /* D89EC 800E81EC A09F030C */  jal        SNDstop
    /* D89F0 800E81F0 01001026 */   addiu     $s0, $s0, 0x1
    /* D89F4 800E81F4 11004292 */  lbu        $v0, 0x11($s2)
    /* D89F8 800E81F8 00000000 */  nop
    /* D89FC 800E81FC 2A100202 */  slt        $v0, $s0, $v0
    /* D8A00 800E8200 F6FF4014 */  bnez       $v0, .L800E81DC
    /* D8A04 800E8204 64003126 */   addiu     $s1, $s1, 0x64
  .L800E8208:
    /* D8A08 800E8208 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* D8A0C 800E820C 1800B28F */  lw         $s2, 0x18($sp)
    /* D8A10 800E8210 1400B18F */  lw         $s1, 0x14($sp)
    /* D8A14 800E8214 1000B08F */  lw         $s0, 0x10($sp)
    /* D8A18 800E8218 0800E003 */  jr         $ra
    /* D8A1C 800E821C 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel SNDstopall
