.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hud_RenderTacView__Fv, 0x11C

glabel Hud_RenderTacView__Fv
    /* C9448 800D8C48 1180033C */  lui        $v1, %hi(DashHUD_gInfo)
    /* C944C 800D8C4C 3027628C */  lw         $v0, %lo(DashHUD_gInfo)($v1)
    /* C9450 800D8C50 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* C9454 800D8C54 1400B1AF */  sw         $s1, 0x14($sp)
    /* C9458 800D8C58 21880000 */  addu       $s1, $zero, $zero
    /* C945C 800D8C5C 2800BFAF */  sw         $ra, 0x28($sp)
    /* C9460 800D8C60 2400B5AF */  sw         $s5, 0x24($sp)
    /* C9464 800D8C64 2000B4AF */  sw         $s4, 0x20($sp)
    /* C9468 800D8C68 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* C946C 800D8C6C 1800B2AF */  sw         $s2, 0x18($sp)
    /* C9470 800D8C70 33004004 */  bltz       $v0, .L800D8D40
    /* C9474 800D8C74 1000B0AF */   sw        $s0, 0x10($sp)
    /* C9478 800D8C78 FF00143C */  lui        $s4, (0xFFFFFF >> 16)
    /* C947C 800D8C7C FFFF9436 */  ori        $s4, $s4, (0xFFFFFF & 0xFFFF)
    /* C9480 800D8C80 00FF153C */  lui        $s5, (0xFF000000 >> 16)
    /* C9484 800D8C84 1480023C */  lui        $v0, %hi(D_8013E408)
    /* C9488 800D8C88 08E45224 */  addiu      $s2, $v0, %lo(D_8013E408)
    /* C948C 800D8C8C 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* C9490 800D8C90 EC315324 */  addiu      $s3, $v0, %lo(GameSetup_gData)
  .L800D8C94:
    /* C9494 800D8C94 4C04628E */  lw         $v0, 0x44C($s3)
    /* C9498 800D8C98 00000000 */  nop
    /* C949C 800D8C9C 21004010 */  beqz       $v0, .L800D8D24
    /* C94A0 800D8CA0 30276224 */   addiu     $v0, $v1, %lo(DashHUD_gInfo)
    /* C94A4 800D8CA4 80181100 */  sll        $v1, $s1, 2
    /* C94A8 800D8CA8 21106200 */  addu       $v0, $v1, $v0
    /* C94AC 800D8CAC 1C00428C */  lw         $v0, 0x1C($v0)
    /* C94B0 800D8CB0 00000000 */  nop
    /* C94B4 800D8CB4 1B004010 */  beqz       $v0, .L800D8D24
    /* C94B8 800D8CB8 00000000 */   nop
    /* C94BC 800D8CBC 1480103C */  lui        $s0, %hi(Hud_gTacView)
    /* C94C0 800D8CC0 60D91026 */  addiu      $s0, $s0, %lo(Hud_gTacView)
    /* C94C4 800D8CC4 21807000 */  addu       $s0, $v1, $s0
    /* C94C8 800D8CC8 0000048E */  lw         $a0, 0x0($s0)
    /* C94CC 800D8CCC 18F8020C */  jal        Draw_StartRenderingView__Fi
    /* C94D0 800D8CD0 00000000 */   nop
    /* C94D4 800D8CD4 426C020C */  jal        DashHUD_HUDCalc__Fi
    /* C94D8 800D8CD8 21202002 */   addu      $a0, $s1, $zero
    /* C94DC 800D8CDC A54F030C */  jal        Hud_BuildTach__Fi
    /* C94E0 800D8CE0 21202002 */   addu      $a0, $s1, $zero
    /* C94E4 800D8CE4 801F043C */  lui        $a0, (0x1F800000 >> 16)
    /* C94E8 800D8CE8 0000848C */  lw         $a0, (0x1F800000 & 0xFFFF)($a0)
    /* C94EC 800D8CEC 0000438E */  lw         $v1, 0x0($s2)
    /* C94F0 800D8CF0 0000828C */  lw         $v0, 0x0($a0)
    /* C94F4 800D8CF4 24187500 */  and        $v1, $v1, $s5
    /* C94F8 800D8CF8 24105400 */  and        $v0, $v0, $s4
    /* C94FC 800D8CFC 25186200 */  or         $v1, $v1, $v0
    /* C9500 800D8D00 000043AE */  sw         $v1, 0x0($s2)
    /* C9504 800D8D04 0000828C */  lw         $v0, 0x0($a0)
    /* C9508 800D8D08 24185402 */  and        $v1, $s2, $s4
    /* C950C 800D8D0C 24105500 */  and        $v0, $v0, $s5
    /* C9510 800D8D10 25104300 */  or         $v0, $v0, $v1
    /* C9514 800D8D14 000082AC */  sw         $v0, 0x0($a0)
    /* C9518 800D8D18 0000048E */  lw         $a0, 0x0($s0)
    /* C951C 800D8D1C 46F8020C */  jal        Draw_StopRenderingView__Fi
    /* C9520 800D8D20 00000000 */   nop
  .L800D8D24:
    /* C9524 800D8D24 30005226 */  addiu      $s2, $s2, 0x30
    /* C9528 800D8D28 1180033C */  lui        $v1, %hi(DashHUD_gInfo)
    /* C952C 800D8D2C 3027628C */  lw         $v0, %lo(DashHUD_gInfo)($v1)
    /* C9530 800D8D30 01003126 */  addiu      $s1, $s1, 0x1
    /* C9534 800D8D34 2A105100 */  slt        $v0, $v0, $s1
    /* C9538 800D8D38 D6FF4010 */  beqz       $v0, .L800D8C94
    /* C953C 800D8D3C B4007326 */   addiu     $s3, $s3, 0xB4
  .L800D8D40:
    /* C9540 800D8D40 2800BF8F */  lw         $ra, 0x28($sp)
    /* C9544 800D8D44 2400B58F */  lw         $s5, 0x24($sp)
    /* C9548 800D8D48 2000B48F */  lw         $s4, 0x20($sp)
    /* C954C 800D8D4C 1C00B38F */  lw         $s3, 0x1C($sp)
    /* C9550 800D8D50 1800B28F */  lw         $s2, 0x18($sp)
    /* C9554 800D8D54 1400B18F */  lw         $s1, 0x14($sp)
    /* C9558 800D8D58 1000B08F */  lw         $s0, 0x10($sp)
    /* C955C 800D8D5C 0800E003 */  jr         $ra
    /* C9560 800D8D60 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel Hud_RenderTacView__Fv
