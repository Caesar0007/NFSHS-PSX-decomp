.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FEInput_GetKeyFromPlayer__F7tPlayerl, 0x148

glabel FEInput_GetKeyFromPlayer__F7tPlayerl
    /* 14488 80023C88 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 1448C 80023C8C 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 14490 80023C90 21988000 */  addu       $s3, $a0, $zero
    /* 14494 80023C94 2400B5AF */  sw         $s5, 0x24($sp)
    /* 14498 80023C98 21A8A000 */  addu       $s5, $a1, $zero
    /* 1449C 80023C9C 1400B1AF */  sw         $s1, 0x14($sp)
    /* 144A0 80023CA0 21880000 */  addu       $s1, $zero, $zero
    /* 144A4 80023CA4 0580023C */  lui        $v0, %hi(getKeyMappings)
    /* 144A8 80023CA8 2000B4AF */  sw         $s4, 0x20($sp)
    /* 144AC 80023CAC 3C175424 */  addiu      $s4, $v0, %lo(getKeyMappings)
    /* 144B0 80023CB0 2800BFAF */  sw         $ra, 0x28($sp)
    /* 144B4 80023CB4 1800B2AF */  sw         $s2, 0x18($sp)
    /* 144B8 80023CB8 1000B0AF */  sw         $s0, 0x10($sp)
    /* 144BC 80023CBC 21900000 */  addu       $s2, $zero, $zero
  .L80023CC0:
    /* 144C0 80023CC0 FFFF2232 */  andi       $v0, $s1, 0xFFFF
    /* 144C4 80023CC4 C0100200 */  sll        $v0, $v0, 3
    /* 144C8 80023CC8 21805400 */  addu       $s0, $v0, $s4
    /* 144CC 80023CCC 0000048E */  lw         $a0, 0x0($s0)
    /* 144D0 80023CD0 DD8E000C */  jal        FEInput_GetDebounceKey__Fii
    /* 144D4 80023CD4 21286002 */   addu      $a1, $s3, $zero
    /* 144D8 80023CD8 0B004014 */  bnez       $v0, .L80023D08
    /* 144DC 80023CDC 00000000 */   nop
    /* 144E0 80023CE0 0400028E */  lw         $v0, 0x4($s0)
    /* 144E4 80023CE4 00000000 */  nop
    /* 144E8 80023CE8 2410A202 */  and        $v0, $s5, $v0
    /* 144EC 80023CEC 07004014 */  bnez       $v0, .L80023D0C
    /* 144F0 80023CF0 00000000 */   nop
    /* 144F4 80023CF4 0000048E */  lw         $a0, 0x0($s0)
    /* 144F8 80023CF8 3E8E000C */  jal        FEInput_GetNoDebounceKey__Fii
    /* 144FC 80023CFC 21286002 */   addu      $a1, $s3, $zero
    /* 14500 80023D00 02004010 */  beqz       $v0, .L80023D0C
    /* 14504 80023D04 00000000 */   nop
  .L80023D08:
    /* 14508 80023D08 01001224 */  addiu      $s2, $zero, 0x1
  .L80023D0C:
    /* 1450C 80023D0C 1F004016 */  bnez       $s2, .L80023D8C
    /* 14510 80023D10 0580033C */   lui       $v1, %hi(getKeyMappings)
    /* 14514 80023D14 01003126 */  addiu      $s1, $s1, 0x1
    /* 14518 80023D18 FFFF2232 */  andi       $v0, $s1, 0xFFFF
    /* 1451C 80023D1C 1000422C */  sltiu      $v0, $v0, 0x10
    /* 14520 80023D20 E7FF4014 */  bnez       $v0, .L80023CC0
    /* 14524 80023D24 21900000 */   addu      $s2, $zero, $zero
    /* 14528 80023D28 00400424 */  addiu      $a0, $zero, 0x4000
    /* 1452C 80023D2C DD8E000C */  jal        FEInput_GetDebounceKey__Fii
    /* 14530 80023D30 21286002 */   addu      $a1, $s3, $zero
    /* 14534 80023D34 1D004014 */  bnez       $v0, .L80023DAC
    /* 14538 80023D38 02000224 */   addiu     $v0, $zero, 0x2
    /* 1453C 80023D3C 00100424 */  addiu      $a0, $zero, 0x1000
    /* 14540 80023D40 DD8E000C */  jal        FEInput_GetDebounceKey__Fii
    /* 14544 80023D44 21286002 */   addu      $a1, $s3, $zero
    /* 14548 80023D48 18004014 */  bnez       $v0, .L80023DAC
    /* 1454C 80023D4C 10000224 */   addiu     $v0, $zero, 0x10
    /* 14550 80023D50 00200424 */  addiu      $a0, $zero, 0x2000
    /* 14554 80023D54 DD8E000C */  jal        FEInput_GetDebounceKey__Fii
    /* 14558 80023D58 21286002 */   addu      $a1, $s3, $zero
    /* 1455C 80023D5C 13004014 */  bnez       $v0, .L80023DAC
    /* 14560 80023D60 04000224 */   addiu     $v0, $zero, 0x4
    /* 14564 80023D64 00800434 */  ori        $a0, $zero, 0x8000
    /* 14568 80023D68 DD8E000C */  jal        FEInput_GetDebounceKey__Fii
    /* 1456C 80023D6C 21286002 */   addu      $a1, $s3, $zero
    /* 14570 80023D70 0D004014 */  bnez       $v0, .L80023DA8
    /* 14574 80023D74 08000424 */   addiu     $a0, $zero, 0x8
    /* 14578 80023D78 DD8E000C */  jal        FEInput_GetDebounceKey__Fii
    /* 1457C 80023D7C 21286002 */   addu      $a1, $s3, $zero
    /* 14580 80023D80 2B100200 */  sltu       $v0, $zero, $v0
    /* 14584 80023D84 6B8F0008 */  j          .L80023DAC
    /* 14588 80023D88 40130200 */   sll       $v0, $v0, 13
  .L80023D8C:
    /* 1458C 80023D8C 3C176324 */  addiu      $v1, $v1, %lo(getKeyMappings)
    /* 14590 80023D90 FFFF2232 */  andi       $v0, $s1, 0xFFFF
    /* 14594 80023D94 C0100200 */  sll        $v0, $v0, 3
    /* 14598 80023D98 21104300 */  addu       $v0, $v0, $v1
    /* 1459C 80023D9C 0400428C */  lw         $v0, 0x4($v0)
    /* 145A0 80023DA0 6B8F0008 */  j          .L80023DAC
    /* 145A4 80023DA4 00000000 */   nop
  .L80023DA8:
    /* 145A8 80023DA8 08000224 */  addiu      $v0, $zero, 0x8
  .L80023DAC:
    /* 145AC 80023DAC 2800BF8F */  lw         $ra, 0x28($sp)
    /* 145B0 80023DB0 2400B58F */  lw         $s5, 0x24($sp)
    /* 145B4 80023DB4 2000B48F */  lw         $s4, 0x20($sp)
    /* 145B8 80023DB8 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 145BC 80023DBC 1800B28F */  lw         $s2, 0x18($sp)
    /* 145C0 80023DC0 1400B18F */  lw         $s1, 0x14($sp)
    /* 145C4 80023DC4 1000B08F */  lw         $s0, 0x10($sp)
    /* 145C8 80023DC8 0800E003 */  jr         $ra
    /* 145CC 80023DCC 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel FEInput_GetKeyFromPlayer__F7tPlayerl
