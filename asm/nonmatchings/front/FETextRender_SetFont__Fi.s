.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FETextRender_SetFont__Fi, 0x74

glabel FETextRender_SetFont__Fi
    /* 114D8 80020CD8 0580033C */  lui        $v1, %hi(currentSize)
    /* 114DC 80020CDC E0176284 */  lh         $v0, %lo(currentSize)($v1)
    /* 114E0 80020CE0 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 114E4 80020CE4 15004410 */  beq        $v0, $a0, .L80020D3C
    /* 114E8 80020CE8 1000BFAF */   sw        $ra, 0x10($sp)
    /* 114EC 80020CEC E01764A4 */  sh         $a0, %lo(currentSize)($v1)
    /* 114F0 80020CF0 00140400 */  sll        $v0, $a0, 16
    /* 114F4 80020CF4 031C0200 */  sra        $v1, $v0, 16
    /* 114F8 80020CF8 05006010 */  beqz       $v1, .L80020D10
    /* 114FC 80020CFC 03000224 */   addiu     $v0, $zero, 0x3
    /* 11500 80020D00 07006210 */  beq        $v1, $v0, .L80020D20
    /* 11504 80020D04 0580023C */   lui       $v0, %hi(font18)
    /* 11508 80020D08 4C830008 */  j          .L80020D30
    /* 1150C 80020D0C 00000000 */   nop
  .L80020D10:
    /* 11510 80020D10 0580023C */  lui        $v0, %hi(font12)
    /* 11514 80020D14 D417448C */  lw         $a0, %lo(font12)($v0)
    /* 11518 80020D18 4D830008 */  j          .L80020D34
    /* 1151C 80020D1C 00000000 */   nop
  .L80020D20:
    /* 11520 80020D20 0580023C */  lui        $v0, %hi(fontTitle)
    /* 11524 80020D24 DC17448C */  lw         $a0, %lo(fontTitle)($v0)
    /* 11528 80020D28 4D830008 */  j          .L80020D34
    /* 1152C 80020D2C 00000000 */   nop
  .L80020D30:
    /* 11530 80020D30 D817448C */  lw         $a0, %lo(font18)($v0)
  .L80020D34:
    /* 11534 80020D34 FB2D030C */  jal        Font_SwitchFont__FPc
    /* 11538 80020D38 00000000 */   nop
  .L80020D3C:
    /* 1153C 80020D3C 1000BF8F */  lw         $ra, 0x10($sp)
    /* 11540 80020D40 00000000 */  nop
    /* 11544 80020D44 0800E003 */  jr         $ra
    /* 11548 80020D48 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel FETextRender_SetFont__Fi
