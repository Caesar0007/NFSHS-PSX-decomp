.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SNDtimeremaining, 0xB4

glabel SNDtimeremaining
    /* DDB38 800ED338 1480023C */  lui        $v0, %hi(D_8014789C)
    /* DDB3C 800ED33C 9C784280 */  lb         $v0, %lo(D_8014789C)($v0)
    /* DDB40 800ED340 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* DDB44 800ED344 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* DDB48 800ED348 21888000 */  addu       $s1, $a0, $zero
    /* DDB4C 800ED34C 1800B0AF */  sw         $s0, 0x18($sp)
    /* DDB50 800ED350 00FC1024 */  addiu      $s0, $zero, -0x400
    /* DDB54 800ED354 03004014 */  bnez       $v0, .L800ED364
    /* DDB58 800ED358 2000BFAF */   sw        $ra, 0x20($sp)
    /* DDB5C 800ED35C F6B40308 */  j          .L800ED3D8
    /* DDB60 800ED360 F6FF0224 */   addiu     $v0, $zero, -0xA
  .L800ED364:
    /* DDB64 800ED364 4DA9030C */  jal        iSNDenteraudio
    /* DDB68 800ED368 00000000 */   nop
    /* DDB6C 800ED36C 71FB030C */  jal        iSNDgetchan
    /* DDB70 800ED370 21202002 */   addu      $a0, $s1, $zero
    /* DDB74 800ED374 21884000 */  addu       $s1, $v0, $zero
    /* DDB78 800ED378 05002106 */  bgez       $s1, .L800ED390
    /* DDB7C 800ED37C FFFF0224 */   addiu     $v0, $zero, -0x1
    /* DDB80 800ED380 5BA9030C */  jal        iSNDleaveaudio
    /* DDB84 800ED384 00000000 */   nop
    /* DDB88 800ED388 F6B40308 */  j          .L800ED3D8
    /* DDB8C 800ED38C F8FF0224 */   addiu     $v0, $zero, -0x8
  .L800ED390:
    /* DDB90 800ED390 1000A2AF */  sw         $v0, 0x10($sp)
    /* DDB94 800ED394 21202002 */  addu       $a0, $s1, $zero
  .L800ED398:
    /* DDB98 800ED398 D3FB030C */  jal        iSNDpatchkey
    /* DDB9C 800ED39C 1000A527 */   addiu     $a1, $sp, 0x10
    /* DDBA0 800ED3A0 0A004010 */  beqz       $v0, .L800ED3CC
    /* DDBA4 800ED3A4 00000000 */   nop
    /* DDBA8 800ED3A8 1000A48F */  lw         $a0, 0x10($sp)
    /* DDBAC 800ED3AC 6A12040C */  jal        iSNDtimeremaining
    /* DDBB0 800ED3B0 00000000 */   nop
    /* DDBB4 800ED3B4 21184000 */  addu       $v1, $v0, $zero
    /* DDBB8 800ED3B8 2A100302 */  slt        $v0, $s0, $v1
    /* DDBBC 800ED3BC F6FF4010 */  beqz       $v0, .L800ED398
    /* DDBC0 800ED3C0 21202002 */   addu      $a0, $s1, $zero
    /* DDBC4 800ED3C4 E6B40308 */  j          .L800ED398
    /* DDBC8 800ED3C8 21806000 */   addu      $s0, $v1, $zero
  .L800ED3CC:
    /* DDBCC 800ED3CC 5BA9030C */  jal        iSNDleaveaudio
    /* DDBD0 800ED3D0 00000000 */   nop
    /* DDBD4 800ED3D4 21100002 */  addu       $v0, $s0, $zero
  .L800ED3D8:
    /* DDBD8 800ED3D8 2000BF8F */  lw         $ra, 0x20($sp)
    /* DDBDC 800ED3DC 1C00B18F */  lw         $s1, 0x1C($sp)
    /* DDBE0 800ED3E0 1800B08F */  lw         $s0, 0x18($sp)
    /* DDBE4 800ED3E4 0800E003 */  jr         $ra
    /* DDBE8 800ED3E8 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel SNDtimeremaining
