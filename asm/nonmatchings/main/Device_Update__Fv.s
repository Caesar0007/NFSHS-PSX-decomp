.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Device_Update__Fv, 0xE0

glabel Device_Update__Fv
    /* ADCD8 800BD4D8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* ADCDC 800BD4DC 1400BFAF */  sw         $ra, 0x14($sp)
    /* ADCE0 800BD4E0 8490030C */  jal        PAD_update
    /* ADCE4 800BD4E4 1000B0AF */   sw        $s0, 0x10($sp)
    /* ADCE8 800BD4E8 1280023C */  lui        $v0, %hi(D_8011E0CC)
    /* ADCEC 800BD4EC CCE0428C */  lw         $v0, %lo(D_8011E0CC)($v0)
    /* ADCF0 800BD4F0 00000000 */  nop
    /* ADCF4 800BD4F4 07004010 */  beqz       $v0, .L800BD514
    /* ADCF8 800BD4F8 01000224 */   addiu     $v0, $zero, 0x1
    /* ADCFC 800BD4FC 341282AF */  sw         $v0, %gp_rel(Device_gPaused)($gp)
    /* ADD00 800BD500 11000224 */  addiu      $v0, $zero, 0x11
    /* ADD04 800BD504 381282AF */  sw         $v0, %gp_rel(Device_gToggleTime)($gp)
    /* ADD08 800BD508 3C1282AF */  sw         $v0, %gp_rel(D_8013D788)($gp)
    /* ADD0C 800BD50C 4EF50208 */  j          .L800BD538
    /* ADD10 800BD510 1280023C */   lui       $v0, %hi(D_8011E0CC)
  .L800BD514:
    /* ADD14 800BD514 3412828F */  lw         $v0, %gp_rel(Device_gPaused)($gp)
    /* ADD18 800BD518 00000000 */  nop
    /* ADD1C 800BD51C 05004010 */  beqz       $v0, .L800BD534
    /* ADD20 800BD520 FFFF0224 */   addiu     $v0, $zero, -0x1
    /* ADD24 800BD524 341280AF */  sw         $zero, %gp_rel(Device_gPaused)($gp)
    /* ADD28 800BD528 301282AF */  sw         $v0, %gp_rel(Device_gPausePort)($gp)
    /* ADD2C 800BD52C 381280AF */  sw         $zero, %gp_rel(Device_gToggleTime)($gp)
    /* ADD30 800BD530 3C1280AF */  sw         $zero, %gp_rel(D_8013D788)($gp)
  .L800BD534:
    /* ADD34 800BD534 1280023C */  lui        $v0, %hi(D_8011E0CC)
  .L800BD538:
    /* ADD38 800BD538 CCE0428C */  lw         $v0, %lo(D_8011E0CC)($v0)
    /* ADD3C 800BD53C 00000000 */  nop
    /* ADD40 800BD540 19004014 */  bnez       $v0, .L800BD5A8
    /* ADD44 800BD544 00000000 */   nop
    /* ADD48 800BD548 1AF5020C */  jal        Device_Fail__Fi
    /* ADD4C 800BD54C 21200000 */   addu      $a0, $zero, $zero
    /* ADD50 800BD550 06004010 */  beqz       $v0, .L800BD56C
    /* ADD54 800BD554 01000224 */   addiu     $v0, $zero, 0x1
    /* ADD58 800BD558 2C1282AF */  sw         $v0, %gp_rel(Device_gForcePause)($gp)
    /* ADD5C 800BD55C 301280AF */  sw         $zero, %gp_rel(Device_gPausePort)($gp)
    /* ADD60 800BD560 481280A3 */  sb         $zero, %gp_rel(Device_gPausePortIndex)($gp)
    /* ADD64 800BD564 6AF50208 */  j          .L800BD5A8
    /* ADD68 800BD568 00000000 */   nop
  .L800BD56C:
    /* ADD6C 800BD56C 1180023C */  lui        $v0, %hi(D_801131F8)
    /* ADD70 800BD570 F831508C */  lw         $s0, %lo(D_801131F8)($v0)
    /* ADD74 800BD574 01000224 */  addiu      $v0, $zero, 0x1
    /* ADD78 800BD578 0A000216 */  bne        $s0, $v0, .L800BD5A4
    /* ADD7C 800BD57C 00000000 */   nop
    /* ADD80 800BD580 1AF5020C */  jal        Device_Fail__Fi
    /* ADD84 800BD584 04000424 */   addiu     $a0, $zero, 0x4
    /* ADD88 800BD588 06004010 */  beqz       $v0, .L800BD5A4
    /* ADD8C 800BD58C 04000224 */   addiu     $v0, $zero, 0x4
    /* ADD90 800BD590 2C1290AF */  sw         $s0, %gp_rel(Device_gForcePause)($gp)
    /* ADD94 800BD594 301282AF */  sw         $v0, %gp_rel(Device_gPausePort)($gp)
    /* ADD98 800BD598 481290A3 */  sb         $s0, %gp_rel(Device_gPausePortIndex)($gp)
    /* ADD9C 800BD59C 6AF50208 */  j          .L800BD5A8
    /* ADDA0 800BD5A0 00000000 */   nop
  .L800BD5A4:
    /* ADDA4 800BD5A4 2C1280AF */  sw         $zero, %gp_rel(Device_gForcePause)($gp)
  .L800BD5A8:
    /* ADDA8 800BD5A8 1400BF8F */  lw         $ra, 0x14($sp)
    /* ADDAC 800BD5AC 1000B08F */  lw         $s0, 0x10($sp)
    /* ADDB0 800BD5B0 0800E003 */  jr         $ra
    /* ADDB4 800BD5B4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Device_Update__Fv
