.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ObjectClipped__FP13DRender_tViewiP8coorddefP25Draw_tGiveShelbyMoreCache, 0xF4

glabel ObjectClipped__FP13DRender_tViewiP8coorddefP25Draw_tGiveShelbyMoreCache
    /* B93D0 800C8BD0 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* B93D4 800C8BD4 21388000 */  addu       $a3, $a0, $zero
    /* B93D8 800C8BD8 4000B0AF */  sw         $s0, 0x40($sp)
    /* B93DC 800C8BDC 1480103C */  lui        $s0, %hi(gPersistObjDefBoundingSpheres)
    /* B93E0 800C8BE0 C8D4108E */  lw         $s0, %lo(gPersistObjDefBoundingSpheres)($s0)
    /* B93E4 800C8BE4 C0280500 */  sll        $a1, $a1, 3
    /* B93E8 800C8BE8 4400BFAF */  sw         $ra, 0x44($sp)
    /* B93EC 800C8BEC 04001026 */  addiu      $s0, $s0, 0x4
    /* B93F0 800C8BF0 21800502 */  addu       $s0, $s0, $a1
    /* B93F4 800C8BF4 00000286 */  lh         $v0, 0x0($s0)
    /* B93F8 800C8BF8 0000C38C */  lw         $v1, 0x0($a2)
    /* B93FC 800C8BFC 80120200 */  sll        $v0, $v0, 10
    /* B9400 800C8C00 21104300 */  addu       $v0, $v0, $v1
    /* B9404 800C8C04 1000A2AF */  sw         $v0, 0x10($sp)
    /* B9408 800C8C08 02000286 */  lh         $v0, 0x2($s0)
    /* B940C 800C8C0C 0400C38C */  lw         $v1, 0x4($a2)
    /* B9410 800C8C10 80120200 */  sll        $v0, $v0, 10
    /* B9414 800C8C14 21104300 */  addu       $v0, $v0, $v1
    /* B9418 800C8C18 1400A2AF */  sw         $v0, 0x14($sp)
    /* B941C 800C8C1C 04000286 */  lh         $v0, 0x4($s0)
    /* B9420 800C8C20 0800C38C */  lw         $v1, 0x8($a2)
    /* B9424 800C8C24 80120200 */  sll        $v0, $v0, 10
    /* B9428 800C8C28 21104300 */  addu       $v0, $v0, $v1
    /* B942C 800C8C2C 1800A2AF */  sw         $v0, 0x18($sp)
    /* B9430 800C8C30 3800E28C */  lw         $v0, 0x38($a3)
    /* B9434 800C8C34 1000A427 */  addiu      $a0, $sp, 0x10
    /* B9438 800C8C38 3000A2AF */  sw         $v0, 0x30($sp)
    /* B943C 800C8C3C 3C00E28C */  lw         $v0, 0x3C($a3)
    /* B9440 800C8C40 4400E524 */  addiu      $a1, $a3, 0x44
    /* B9444 800C8C44 3400A2AF */  sw         $v0, 0x34($sp)
    /* B9448 800C8C48 4000E28C */  lw         $v0, 0x40($a3)
    /* B944C 800C8C4C 2000A627 */  addiu      $a2, $sp, 0x20
    /* B9450 800C8C50 B6AB030C */  jal        transform
    /* B9454 800C8C54 3800A2AF */   sw        $v0, 0x38($sp)
    /* B9458 800C8C58 2000A38F */  lw         $v1, 0x20($sp)
    /* B945C 800C8C5C 3000A28F */  lw         $v0, 0x30($sp)
    /* B9460 800C8C60 3400A48F */  lw         $a0, 0x34($sp)
    /* B9464 800C8C64 3800A58F */  lw         $a1, 0x38($sp)
    /* B9468 800C8C68 21306200 */  addu       $a2, $v1, $v0
    /* B946C 800C8C6C 2400A28F */  lw         $v0, 0x24($sp)
    /* B9470 800C8C70 2800A38F */  lw         $v1, 0x28($sp)
    /* B9474 800C8C74 2000A6AF */  sw         $a2, 0x20($sp)
    /* B9478 800C8C78 21104400 */  addu       $v0, $v0, $a0
    /* B947C 800C8C7C 21186500 */  addu       $v1, $v1, $a1
    /* B9480 800C8C80 2400A2AF */  sw         $v0, 0x24($sp)
    /* B9484 800C8C84 2800A3AF */  sw         $v1, 0x28($sp)
    /* B9488 800C8C88 06000286 */  lh         $v0, 0x6($s0)
    /* B948C 800C8C8C 00000000 */  nop
    /* B9490 800C8C90 80120200 */  sll        $v0, $v0, 10
    /* B9494 800C8C94 21186200 */  addu       $v1, $v1, $v0
    /* B9498 800C8C98 2A106600 */  slt        $v0, $v1, $a2
    /* B949C 800C8C9C 04004014 */  bnez       $v0, .L800C8CB0
    /* B94A0 800C8CA0 2800A3AF */   sw        $v1, 0x28($sp)
    /* B94A4 800C8CA4 23100600 */  negu       $v0, $a2
    /* B94A8 800C8CA8 2D230308 */  j          .L800C8CB4
    /* B94AC 800C8CAC 2A106200 */   slt       $v0, $v1, $v0
  .L800C8CB0:
    /* B94B0 800C8CB0 01000224 */  addiu      $v0, $zero, 0x1
  .L800C8CB4:
    /* B94B4 800C8CB4 4400BF8F */  lw         $ra, 0x44($sp)
    /* B94B8 800C8CB8 4000B08F */  lw         $s0, 0x40($sp)
    /* B94BC 800C8CBC 0800E003 */  jr         $ra
    /* B94C0 800C8CC0 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel ObjectClipped__FP13DRender_tViewiP8coorddefP25Draw_tGiveShelbyMoreCache
