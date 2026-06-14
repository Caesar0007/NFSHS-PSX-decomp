.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawW_DoObjects__FP13DRender_tViewP11tBuildEntry, 0x378

glabel DrawW_DoObjects__FP13DRender_tViewP11tBuildEntry
    /* B94C4 800C8CC4 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* B94C8 800C8CC8 3000B4AF */  sw         $s4, 0x30($sp)
    /* B94CC 800C8CCC 21A00000 */  addu       $s4, $zero, $zero
    /* B94D0 800C8CD0 3C00B7AF */  sw         $s7, 0x3C($sp)
    /* B94D4 800C8CD4 1280173C */  lui        $s7, %hi(gChunkObjInfo)
    /* B94D8 800C8CD8 2400B1AF */  sw         $s1, 0x24($sp)
    /* B94DC 800C8CDC 48F7F126 */  addiu      $s1, $s7, %lo(gChunkObjInfo)
    /* B94E0 800C8CE0 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* B94E4 800C8CE4 4000BEAF */  sw         $fp, 0x40($sp)
    /* B94E8 800C8CE8 EC315E24 */  addiu      $fp, $v0, %lo(GameSetup_gData)
    /* B94EC 800C8CEC 2800B2AF */  sw         $s2, 0x28($sp)
    /* B94F0 800C8CF0 2190A000 */  addu       $s2, $a1, $zero
    /* B94F4 800C8CF4 3800B6AF */  sw         $s6, 0x38($sp)
    /* B94F8 800C8CF8 801F163C */  lui        $s6, (0x1F8000DA >> 16)
    /* B94FC 800C8CFC 1480083C */  lui        $t0, %hi(BWorld_gChunkCount)
    /* B9500 800C8D00 A8C7088D */  lw         $t0, %lo(BWorld_gChunkCount)($t0)
    /* B9504 800C8D04 1480033C */  lui        $v1, %hi(gCurrContext)
    /* B9508 800C8D08 90C7638C */  lw         $v1, %lo(gCurrContext)($v1)
    /* B950C 800C8D0C 1280023C */  lui        $v0, %hi(gInitialArt)
    /* B9510 800C8D10 4400BFAF */  sw         $ra, 0x44($sp)
    /* B9514 800C8D14 3400B5AF */  sw         $s5, 0x34($sp)
    /* B9518 800C8D18 2C00B3AF */  sw         $s3, 0x2C($sp)
    /* B951C 800C8D1C 2000B0AF */  sw         $s0, 0x20($sp)
    /* B9520 800C8D20 4800A4AF */  sw         $a0, 0x48($sp)
    /* B9524 800C8D24 1800A8AF */  sw         $t0, 0x18($sp)
    /* B9528 800C8D28 8800758C */  lw         $s5, 0x88($v1)
    /* B952C 800C8D2C 58E14224 */  addiu      $v0, $v0, %lo(gInitialArt)
    /* B9530 800C8D30 F01284AF */  sw         $a0, %gp_rel(gVi)($gp)
    /* B9534 800C8D34 FC00C2AE */  sw         $v0, (0x1F8000FC & 0xFFFF)($s6)
  .L800C8D38:
    /* B9538 800C8D38 1800A88F */  lw         $t0, 0x18($sp)
    /* B953C 800C8D3C 00000000 */  nop
    /* B9540 800C8D40 2A108802 */  slt        $v0, $s4, $t0
    /* B9544 800C8D44 48004010 */  beqz       $v0, .L800C8E68
    /* B9548 800C8D48 00040224 */   addiu     $v0, $zero, 0x400
    /* B954C 800C8D4C 03004292 */  lbu        $v0, 0x3($s2)
    /* B9550 800C8D50 00000000 */  nop
    /* B9554 800C8D54 02004230 */  andi       $v0, $v0, 0x2
    /* B9558 800C8D58 40004010 */  beqz       $v0, .L800C8E5C
    /* B955C 800C8D5C 00000000 */   nop
    /* B9560 800C8D60 00004386 */  lh         $v1, 0x0($s2)
    /* B9564 800C8D64 00000000 */  nop
    /* B9568 800C8D68 C0100300 */  sll        $v0, $v1, 3
    /* B956C 800C8D6C 23104300 */  subu       $v0, $v0, $v1
    /* B9570 800C8D70 1480033C */  lui        $v1, %hi(Track_chunkList)
    /* B9574 800C8D74 B8D4638C */  lw         $v1, %lo(Track_chunkList)($v1)
    /* B9578 800C8D78 00110200 */  sll        $v0, $v0, 4
    /* B957C 800C8D7C 21806200 */  addu       $s0, $v1, $v0
    /* B9580 800C8D80 5000028E */  lw         $v0, 0x50($s0)
    /* B9584 800C8D84 00000000 */  nop
    /* B9588 800C8D88 04005324 */  addiu      $s3, $v0, 0x4
    /* B958C 800C8D8C 4000028E */  lw         $v0, 0x40($s0)
    /* B9590 800C8D90 02004582 */  lb         $a1, 0x2($s2)
    /* B9594 800C8D94 16004010 */  beqz       $v0, .L800C8DF0
    /* B9598 800C8D98 801F043C */   lui       $a0, (0x1F8003FC >> 16)
    /* B959C 800C8D9C 01000224 */  addiu      $v0, $zero, 0x1
    /* B95A0 800C8DA0 FC038434 */  ori        $a0, $a0, (0x1F8003FC & 0xFFFF)
    /* B95A4 800C8DA4 DA00C2A6 */  sh         $v0, (0x1F8000DA & 0xFFFF)($s6)
    /* B95A8 800C8DA8 0400A238 */  xori       $v0, $a1, 0x4
    /* B95AC 800C8DAC 4000038E */  lw         $v1, 0x40($s0)
    /* B95B0 800C8DB0 0100422C */  sltiu      $v0, $v0, 0x1
    /* B95B4 800C8DB4 48F7F3AE */  sw         $s3, %lo(gChunkObjInfo)($s7)
    /* B95B8 800C8DB8 080022AE */  sw         $v0, 0x8($s1)
    /* B95BC 800C8DBC 2B91030C */  jal        SetSp
    /* B95C0 800C8DC0 040023AE */   sw        $v1, 0x4($s1)
    /* B95C4 800C8DC4 F012848F */  lw         $a0, %gp_rel(gVi)($gp)
    /* B95C8 800C8DC8 01000824 */  addiu      $t0, $zero, 0x1
    /* B95CC 800C8DCC E41282AF */  sw         $v0, %gp_rel(gWSavePtr)($gp)
    /* B95D0 800C8DD0 D01288AF */  sw         $t0, %gp_rel(stackSpeedUpEnbabledFlag)($gp)
    /* B95D4 800C8DD4 4221030C */  jal        DrawW_BuildChunkObjectFacets__FP13DRender_tViewP15ChunkObjectInfo
    /* B95D8 800C8DD8 21282002 */   addu      $a1, $s1, $zero
    /* B95DC 800C8DDC E412848F */  lw         $a0, %gp_rel(gWSavePtr)($gp)
    /* B95E0 800C8DE0 2B91030C */  jal        SetSp
    /* B95E4 800C8DE4 00000000 */   nop
    /* B95E8 800C8DE8 E41282AF */  sw         $v0, %gp_rel(gWSavePtr)($gp)
    /* B95EC 800C8DEC D01280AF */  sw         $zero, %gp_rel(stackSpeedUpEnbabledFlag)($gp)
  .L800C8DF0:
    /* B95F0 800C8DF0 5400C28F */  lw         $v0, 0x54($fp)
    /* B95F4 800C8DF4 00000000 */  nop
    /* B95F8 800C8DF8 18004014 */  bnez       $v0, .L800C8E5C
    /* B95FC 800C8DFC 00000000 */   nop
    /* B9600 800C8E00 4800C28F */  lw         $v0, 0x48($fp)
    /* B9604 800C8E04 00000000 */  nop
    /* B9608 800C8E08 14004014 */  bnez       $v0, .L800C8E5C
    /* B960C 800C8E0C 00000000 */   nop
    /* B9610 800C8E10 4400028E */  lw         $v0, 0x44($s0)
    /* B9614 800C8E14 00000000 */  nop
    /* B9618 800C8E18 10004010 */  beqz       $v0, .L800C8E5C
    /* B961C 800C8E1C 21282002 */   addu      $a1, $s1, $zero
    /* B9620 800C8E20 00040224 */  addiu      $v0, $zero, 0x400
    /* B9624 800C8E24 4801C2A6 */  sh         $v0, (0x1F800148 & 0xFFFF)($s6)
    /* B9628 800C8E28 DA00C0A6 */  sh         $zero, (0x1F8000DA & 0xFFFF)($s6)
    /* B962C 800C8E2C 140020AE */  sw         $zero, 0x14($s1)
    /* B9630 800C8E30 48F7F3AE */  sw         $s3, %lo(gChunkObjInfo)($s7)
    /* B9634 800C8E34 4400038E */  lw         $v1, 0x44($s0)
    /* B9638 800C8E38 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* B963C 800C8E3C 0C0022AE */  sw         $v0, 0xC($s1)
    /* B9640 800C8E40 32000224 */  addiu      $v0, $zero, 0x32
    /* B9644 800C8E44 F012848F */  lw         $a0, %gp_rel(gVi)($gp)
    /* B9648 800C8E48 01000824 */  addiu      $t0, $zero, 0x1
    /* B964C 800C8E4C 100022AE */  sw         $v0, 0x10($s1)
    /* B9650 800C8E50 080028AE */  sw         $t0, 0x8($s1)
    /* B9654 800C8E54 2A1E030C */  jal        DrawW_BuildObjectFacets__FP13DRender_tViewP15ChunkObjectInfo
    /* B9658 800C8E58 040023AE */   sw        $v1, 0x4($s1)
  .L800C8E5C:
    /* B965C 800C8E5C 04005226 */  addiu      $s2, $s2, 0x4
    /* B9660 800C8E60 4E230308 */  j          .L800C8D38
    /* B9664 800C8E64 01009426 */   addiu     $s4, $s4, 0x1
  .L800C8E68:
    /* B9668 800C8E68 1480053C */  lui        $a1, %hi(gPersistObjInst)
    /* B966C 800C8E6C C0D4A58C */  lw         $a1, %lo(gPersistObjInst)($a1)
    /* B9670 800C8E70 DA00C0A6 */  sh         $zero, (0x1F8000DA & 0xFFFF)($s6)
    /* B9674 800C8E74 3400A010 */  beqz       $a1, .L800C8F48
    /* B9678 800C8E78 4801C2A6 */   sh        $v0, (0x1F800148 & 0xFFFF)($s6)
    /* B967C 800C8E7C 1180023C */  lui        $v0, %hi(D_80113228)
    /* B9680 800C8E80 2832438C */  lw         $v1, %lo(D_80113228)($v0)
    /* B9684 800C8E84 04000224 */  addiu      $v0, $zero, 0x4
    /* B9688 800C8E88 0A006214 */  bne        $v1, $v0, .L800C8EB4
    /* B968C 800C8E8C FFFFA226 */   addiu     $v0, $s5, -0x1
    /* B9690 800C8E90 2800422C */  sltiu      $v0, $v0, 0x28
    /* B9694 800C8E94 2C004014 */  bnez       $v0, .L800C8F48
    /* B9698 800C8E98 C3FFA226 */   addiu     $v0, $s5, -0x3D
    /* B969C 800C8E9C 1E00422C */  sltiu      $v0, $v0, 0x1E
    /* B96A0 800C8EA0 29004014 */  bnez       $v0, .L800C8F48
    /* B96A4 800C8EA4 94FFA226 */   addiu     $v0, $s5, -0x6C
    /* B96A8 800C8EA8 0900422C */  sltiu      $v0, $v0, 0x9
    /* B96AC 800C8EAC 26004014 */  bnez       $v0, .L800C8F48
    /* B96B0 800C8EB0 00000000 */   nop
  .L800C8EB4:
    /* B96B4 800C8EB4 0B006014 */  bnez       $v1, .L800C8EE4
    /* B96B8 800C8EB8 801F043C */   lui       $a0, (0x1F8003FC >> 16)
    /* B96BC 800C8EBC FFFFA226 */  addiu      $v0, $s5, -0x1
    /* B96C0 800C8EC0 3500422C */  sltiu      $v0, $v0, 0x35
    /* B96C4 800C8EC4 20004014 */  bnez       $v0, .L800C8F48
    /* B96C8 800C8EC8 BCFFA226 */   addiu     $v0, $s5, -0x44
    /* B96CC 800C8ECC 1C00422C */  sltiu      $v0, $v0, 0x1C
    /* B96D0 800C8ED0 1D004014 */  bnez       $v0, .L800C8F48
    /* B96D4 800C8ED4 94FFA226 */   addiu     $v0, $s5, -0x6C
    /* B96D8 800C8ED8 1400422C */  sltiu      $v0, $v0, 0x14
    /* B96DC 800C8EDC 1A004014 */  bnez       $v0, .L800C8F48
    /* B96E0 800C8EE0 00000000 */   nop
  .L800C8EE4:
    /* B96E4 800C8EE4 1280023C */  lui        $v0, %hi(gChunkObjInfo)
    /* B96E8 800C8EE8 48F75024 */  addiu      $s0, $v0, %lo(gChunkObjInfo)
    /* B96EC 800C8EEC 040005AE */  sw         $a1, 0x4($s0)
    /* B96F0 800C8EF0 48F740AC */  sw         $zero, %lo(gChunkObjInfo)($v0)
    /* B96F4 800C8EF4 7D000224 */  addiu      $v0, $zero, 0x7D
    /* B96F8 800C8EF8 100002AE */  sw         $v0, 0x10($s0)
    /* B96FC 800C8EFC 1480023C */  lui        $v0, %hi(gCurrContext)
    /* B9700 800C8F00 90C7428C */  lw         $v0, %lo(gCurrContext)($v0)
    /* B9704 800C8F04 01001124 */  addiu      $s1, $zero, 0x1
    /* B9708 800C8F08 080011AE */  sw         $s1, 0x8($s0)
    /* B970C 800C8F0C 9000428C */  lw         $v0, 0x90($v0)
    /* B9710 800C8F10 FC038434 */  ori        $a0, $a0, (0x1F8003FC & 0xFFFF)
    /* B9714 800C8F14 140000AE */  sw         $zero, 0x14($s0)
    /* B9718 800C8F18 2B91030C */  jal        SetSp
    /* B971C 800C8F1C 0C0002AE */   sw        $v0, 0xC($s0)
    /* B9720 800C8F20 F012848F */  lw         $a0, %gp_rel(gVi)($gp)
    /* B9724 800C8F24 E41282AF */  sw         $v0, %gp_rel(gWSavePtr)($gp)
    /* B9728 800C8F28 D01291AF */  sw         $s1, %gp_rel(stackSpeedUpEnbabledFlag)($gp)
    /* B972C 800C8F2C 2A1E030C */  jal        DrawW_BuildObjectFacets__FP13DRender_tViewP15ChunkObjectInfo
    /* B9730 800C8F30 21280002 */   addu      $a1, $s0, $zero
    /* B9734 800C8F34 E412848F */  lw         $a0, %gp_rel(gWSavePtr)($gp)
    /* B9738 800C8F38 2B91030C */  jal        SetSp
    /* B973C 800C8F3C 00000000 */   nop
    /* B9740 800C8F40 E41282AF */  sw         $v0, %gp_rel(gWSavePtr)($gp)
    /* B9744 800C8F44 D01280AF */  sw         $zero, %gp_rel(stackSpeedUpEnbabledFlag)($gp)
  .L800C8F48:
    /* B9748 800C8F48 1480023C */  lui        $v0, %hi(gPersistMidgroundObjInst)
    /* B974C 800C8F4C C4D4428C */  lw         $v0, %lo(gPersistMidgroundObjInst)($v0)
    /* B9750 800C8F50 00000000 */  nop
    /* B9754 800C8F54 1B004010 */  beqz       $v0, .L800C8FC4
    /* B9758 800C8F58 801F043C */   lui       $a0, (0x1F8003FC >> 16)
    /* B975C 800C8F5C FC038434 */  ori        $a0, $a0, (0x1F8003FC & 0xFFFF)
    /* B9760 800C8F60 1280103C */  lui        $s0, %hi(gChunkObjInfo)
    /* B9764 800C8F64 48F700AE */  sw         $zero, %lo(gChunkObjInfo)($s0)
    /* B9768 800C8F68 48F71026 */  addiu      $s0, $s0, %lo(gChunkObjInfo)
    /* B976C 800C8F6C 040002AE */  sw         $v0, 0x4($s0)
    /* B9770 800C8F70 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* B9774 800C8F74 01001124 */  addiu      $s1, $zero, 0x1
    /* B9778 800C8F78 0C0002AE */  sw         $v0, 0xC($s0)
    /* B977C 800C8F7C 100002AE */  sw         $v0, 0x10($s0)
    /* B9780 800C8F80 1480023C */  lui        $v0, %hi(Track_gInViewList)
    /* B9784 800C8F84 ACD4428C */  lw         $v0, %lo(Track_gInViewList)($v0)
    /* B9788 800C8F88 80191500 */  sll        $v1, $s5, 6
    /* B978C 800C8F8C 080011AE */  sw         $s1, 0x8($s0)
    /* B9790 800C8F90 21104300 */  addu       $v0, $v0, $v1
    /* B9794 800C8F94 2B91030C */  jal        SetSp
    /* B9798 800C8F98 140002AE */   sw        $v0, 0x14($s0)
    /* B979C 800C8F9C F012848F */  lw         $a0, %gp_rel(gVi)($gp)
    /* B97A0 800C8FA0 E41282AF */  sw         $v0, %gp_rel(gWSavePtr)($gp)
    /* B97A4 800C8FA4 D01291AF */  sw         $s1, %gp_rel(stackSpeedUpEnbabledFlag)($gp)
    /* B97A8 800C8FA8 2A1E030C */  jal        DrawW_BuildObjectFacets__FP13DRender_tViewP15ChunkObjectInfo
    /* B97AC 800C8FAC 21280002 */   addu      $a1, $s0, $zero
    /* B97B0 800C8FB0 E412848F */  lw         $a0, %gp_rel(gWSavePtr)($gp)
    /* B97B4 800C8FB4 2B91030C */  jal        SetSp
    /* B97B8 800C8FB8 00000000 */   nop
    /* B97BC 800C8FBC E41282AF */  sw         $v0, %gp_rel(gWSavePtr)($gp)
    /* B97C0 800C8FC0 D01280AF */  sw         $zero, %gp_rel(stackSpeedUpEnbabledFlag)($gp)
  .L800C8FC4:
    /* B97C4 800C8FC4 1480073C */  lui        $a3, %hi(Object_customObjInst)
    /* B97C8 800C8FC8 C8D2E78C */  lw         $a3, %lo(Object_customObjInst)($a3)
    /* B97CC 800C8FCC 00000000 */  nop
    /* B97D0 800C8FD0 0E00E010 */  beqz       $a3, .L800C900C
    /* B97D4 800C8FD4 00000000 */   nop
    /* B97D8 800C8FD8 0000E28C */  lw         $v0, 0x0($a3)
    /* B97DC 800C8FDC 00000000 */  nop
    /* B97E0 800C8FE0 0A004018 */  blez       $v0, .L800C900C
    /* B97E4 800C8FE4 2128C002 */   addu      $a1, $s6, $zero
    /* B97E8 800C8FE8 4800A48F */  lw         $a0, 0x48($sp)
    /* B97EC 800C8FEC 1480023C */  lui        $v0, %hi(gCurrContext)
    /* B97F0 800C8FF0 90C7428C */  lw         $v0, %lo(gCurrContext)($v0)
    /* B97F4 800C8FF4 1480063C */  lui        $a2, %hi(Object_customSimObjs)
    /* B97F8 800C8FF8 CCD2C68C */  lw         $a2, %lo(Object_customSimObjs)($a2)
    /* B97FC 800C8FFC 9000428C */  lw         $v0, 0x90($v0)
    /* B9800 800C9000 0400C624 */  addiu      $a2, $a2, 0x4
    /* B9804 800C9004 E71E030C */  jal        DrawW_BuildCustomObjectFacets__FP13DRender_tViewP11Draw_DCacheP13Trk_SimObjectP5Groupi
    /* B9808 800C9008 1000A2AF */   sw        $v0, 0x10($sp)
  .L800C900C:
    /* B980C 800C900C 4400BF8F */  lw         $ra, 0x44($sp)
    /* B9810 800C9010 4000BE8F */  lw         $fp, 0x40($sp)
    /* B9814 800C9014 3C00B78F */  lw         $s7, 0x3C($sp)
    /* B9818 800C9018 3800B68F */  lw         $s6, 0x38($sp)
    /* B981C 800C901C 3400B58F */  lw         $s5, 0x34($sp)
    /* B9820 800C9020 3000B48F */  lw         $s4, 0x30($sp)
    /* B9824 800C9024 2C00B38F */  lw         $s3, 0x2C($sp)
    /* B9828 800C9028 2800B28F */  lw         $s2, 0x28($sp)
    /* B982C 800C902C 2400B18F */  lw         $s1, 0x24($sp)
    /* B9830 800C9030 2000B08F */  lw         $s0, 0x20($sp)
    /* B9834 800C9034 0800E003 */  jr         $ra
    /* B9838 800C9038 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel DrawW_DoObjects__FP13DRender_tViewP11tBuildEntry
