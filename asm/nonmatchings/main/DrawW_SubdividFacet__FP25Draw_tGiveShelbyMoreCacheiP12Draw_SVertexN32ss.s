.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawW_SubdividFacet__FP25Draw_tGiveShelbyMoreCacheiP12Draw_SVertexN32ss, 0x930

glabel DrawW_SubdividFacet__FP25Draw_tGiveShelbyMoreCacheiP12Draw_SVertexN32ss
    /* B5A84 800C5284 88FFBD27 */  addiu      $sp, $sp, -0x78
    /* B5A88 800C5288 5800B2AF */  sw         $s2, 0x58($sp)
    /* B5A8C 800C528C 21908000 */  addu       $s2, $a0, $zero
    /* B5A90 800C5290 5400B1AF */  sw         $s1, 0x54($sp)
    /* B5A94 800C5294 2188C000 */  addu       $s1, $a2, $zero
    /* B5A98 800C5298 7400BFAF */  sw         $ra, 0x74($sp)
    /* B5A9C 800C529C 7000BEAF */  sw         $fp, 0x70($sp)
    /* B5AA0 800C52A0 6C00B7AF */  sw         $s7, 0x6C($sp)
    /* B5AA4 800C52A4 6800B6AF */  sw         $s6, 0x68($sp)
    /* B5AA8 800C52A8 6400B5AF */  sw         $s5, 0x64($sp)
    /* B5AAC 800C52AC 6000B4AF */  sw         $s4, 0x60($sp)
    /* B5AB0 800C52B0 5C00B3AF */  sw         $s3, 0x5C($sp)
    /* B5AB4 800C52B4 5000B0AF */  sw         $s0, 0x50($sp)
    /* B5AB8 800C52B8 7C00A5AF */  sw         $a1, 0x7C($sp)
    /* B5ABC 800C52BC 8400A7AF */  sw         $a3, 0x84($sp)
    /* B5AC0 800C52C0 08002286 */  lh         $v0, 0x8($s1)
    /* B5AC4 800C52C4 10004386 */  lh         $v1, 0x10($s2)
    /* B5AC8 800C52C8 9000AF97 */  lhu        $t7, 0x90($sp)
    /* B5ACC 800C52CC 8800BE8F */  lw         $fp, 0x88($sp)
    /* B5AD0 800C52D0 9400B497 */  lhu        $s4, 0x94($sp)
    /* B5AD4 800C52D4 2A106200 */  slt        $v0, $v1, $v0
    /* B5AD8 800C52D8 3800AFA7 */  sh         $t7, 0x38($sp)
    /* B5ADC 800C52DC 12004010 */  beqz       $v0, .L800C5328
    /* B5AE0 800C52E0 4000B4A7 */   sh        $s4, 0x40($sp)
    /* B5AE4 800C52E4 0800E284 */  lh         $v0, 0x8($a3)
    /* B5AE8 800C52E8 00000000 */  nop
    /* B5AEC 800C52EC 2A106200 */  slt        $v0, $v1, $v0
    /* B5AF0 800C52F0 0D004010 */  beqz       $v0, .L800C5328
    /* B5AF4 800C52F4 00000000 */   nop
    /* B5AF8 800C52F8 0800C287 */  lh         $v0, 0x8($fp)
    /* B5AFC 800C52FC 00000000 */  nop
    /* B5B00 800C5300 2A106200 */  slt        $v0, $v1, $v0
    /* B5B04 800C5304 08004010 */  beqz       $v0, .L800C5328
    /* B5B08 800C5308 00000000 */   nop
    /* B5B0C 800C530C 8C00B88F */  lw         $t8, 0x8C($sp)
    /* B5B10 800C5310 00000000 */  nop
    /* B5B14 800C5314 08000287 */  lh         $v0, 0x8($t8)
    /* B5B18 800C5318 00000000 */  nop
    /* B5B1C 800C531C 2A106200 */  slt        $v0, $v1, $v0
    /* B5B20 800C5320 18024014 */  bnez       $v0, .L800C5B84
    /* B5B24 800C5324 00000000 */   nop
  .L800C5328:
    /* B5B28 800C5328 08002286 */  lh         $v0, 0x8($s1)
    /* B5B2C 800C532C 00000000 */  nop
    /* B5B30 800C5330 11004104 */  bgez       $v0, .L800C5378
    /* B5B34 800C5334 00000000 */   nop
    /* B5B38 800C5338 8400B98F */  lw         $t9, 0x84($sp)
    /* B5B3C 800C533C 00000000 */  nop
    /* B5B40 800C5340 08002287 */  lh         $v0, 0x8($t9)
    /* B5B44 800C5344 00000000 */  nop
    /* B5B48 800C5348 0B004104 */  bgez       $v0, .L800C5378
    /* B5B4C 800C534C 00000000 */   nop
    /* B5B50 800C5350 0800C287 */  lh         $v0, 0x8($fp)
    /* B5B54 800C5354 00000000 */  nop
    /* B5B58 800C5358 07004104 */  bgez       $v0, .L800C5378
    /* B5B5C 800C535C 00000000 */   nop
    /* B5B60 800C5360 8C00AF8F */  lw         $t7, 0x8C($sp)
    /* B5B64 800C5364 00000000 */  nop
    /* B5B68 800C5368 0800E285 */  lh         $v0, 0x8($t7)
    /* B5B6C 800C536C 00000000 */  nop
    /* B5B70 800C5370 04024004 */  bltz       $v0, .L800C5B84
    /* B5B74 800C5374 00000000 */   nop
  .L800C5378:
    /* B5B78 800C5378 0A002286 */  lh         $v0, 0xA($s1)
    /* B5B7C 800C537C 12004386 */  lh         $v1, 0x12($s2)
    /* B5B80 800C5380 00000000 */  nop
    /* B5B84 800C5384 2A106200 */  slt        $v0, $v1, $v0
    /* B5B88 800C5388 14004010 */  beqz       $v0, .L800C53DC
    /* B5B8C 800C538C 00000000 */   nop
    /* B5B90 800C5390 8400B48F */  lw         $s4, 0x84($sp)
    /* B5B94 800C5394 00000000 */  nop
    /* B5B98 800C5398 0A008286 */  lh         $v0, 0xA($s4)
    /* B5B9C 800C539C 00000000 */  nop
    /* B5BA0 800C53A0 2A106200 */  slt        $v0, $v1, $v0
    /* B5BA4 800C53A4 0D004010 */  beqz       $v0, .L800C53DC
    /* B5BA8 800C53A8 00000000 */   nop
    /* B5BAC 800C53AC 0A00C287 */  lh         $v0, 0xA($fp)
    /* B5BB0 800C53B0 00000000 */  nop
    /* B5BB4 800C53B4 2A106200 */  slt        $v0, $v1, $v0
    /* B5BB8 800C53B8 08004010 */  beqz       $v0, .L800C53DC
    /* B5BBC 800C53BC 00000000 */   nop
    /* B5BC0 800C53C0 8C00B88F */  lw         $t8, 0x8C($sp)
    /* B5BC4 800C53C4 00000000 */  nop
    /* B5BC8 800C53C8 0A000287 */  lh         $v0, 0xA($t8)
    /* B5BCC 800C53CC 00000000 */  nop
    /* B5BD0 800C53D0 2A106200 */  slt        $v0, $v1, $v0
    /* B5BD4 800C53D4 EB014014 */  bnez       $v0, .L800C5B84
    /* B5BD8 800C53D8 00000000 */   nop
  .L800C53DC:
    /* B5BDC 800C53DC 0A002286 */  lh         $v0, 0xA($s1)
    /* B5BE0 800C53E0 00000000 */  nop
    /* B5BE4 800C53E4 11004104 */  bgez       $v0, .L800C542C
    /* B5BE8 800C53E8 00000000 */   nop
    /* B5BEC 800C53EC 8400B98F */  lw         $t9, 0x84($sp)
    /* B5BF0 800C53F0 00000000 */  nop
    /* B5BF4 800C53F4 0A002287 */  lh         $v0, 0xA($t9)
    /* B5BF8 800C53F8 00000000 */  nop
    /* B5BFC 800C53FC 0B004104 */  bgez       $v0, .L800C542C
    /* B5C00 800C5400 00000000 */   nop
    /* B5C04 800C5404 0A00C287 */  lh         $v0, 0xA($fp)
    /* B5C08 800C5408 00000000 */  nop
    /* B5C0C 800C540C 07004104 */  bgez       $v0, .L800C542C
    /* B5C10 800C5410 00000000 */   nop
    /* B5C14 800C5414 8C00AF8F */  lw         $t7, 0x8C($sp)
    /* B5C18 800C5418 00000000 */  nop
    /* B5C1C 800C541C 0A00E285 */  lh         $v0, 0xA($t7)
    /* B5C20 800C5420 00000000 */  nop
    /* B5C24 800C5424 D7014004 */  bltz       $v0, .L800C5B84
    /* B5C28 800C5428 00000000 */   nop
  .L800C542C:
    /* B5C2C 800C542C 04002286 */  lh         $v0, 0x4($s1)
    /* B5C30 800C5430 00000000 */  nop
    /* B5C34 800C5434 11004104 */  bgez       $v0, .L800C547C
    /* B5C38 800C5438 21204002 */   addu      $a0, $s2, $zero
    /* B5C3C 800C543C 8400B48F */  lw         $s4, 0x84($sp)
    /* B5C40 800C5440 00000000 */  nop
    /* B5C44 800C5444 04008286 */  lh         $v0, 0x4($s4)
    /* B5C48 800C5448 00000000 */  nop
    /* B5C4C 800C544C 0C004104 */  bgez       $v0, .L800C5480
    /* B5C50 800C5450 21282002 */   addu      $a1, $s1, $zero
    /* B5C54 800C5454 0400C287 */  lh         $v0, 0x4($fp)
    /* B5C58 800C5458 00000000 */  nop
    /* B5C5C 800C545C 09004104 */  bgez       $v0, .L800C5484
    /* B5C60 800C5460 2138C003 */   addu      $a3, $fp, $zero
    /* B5C64 800C5464 8C00B88F */  lw         $t8, 0x8C($sp)
    /* B5C68 800C5468 00000000 */  nop
    /* B5C6C 800C546C 04000287 */  lh         $v0, 0x4($t8)
    /* B5C70 800C5470 00000000 */  nop
    /* B5C74 800C5474 C3014004 */  bltz       $v0, .L800C5B84
    /* B5C78 800C5478 00000000 */   nop
  .L800C547C:
    /* B5C7C 800C547C 21282002 */  addu       $a1, $s1, $zero
  .L800C5480:
    /* B5C80 800C5480 2138C003 */  addu       $a3, $fp, $zero
  .L800C5484:
    /* B5C84 800C5484 1280023C */  lui        $v0, %hi(gDiv)
    /* B5C88 800C5488 8C00B98F */  lw         $t9, 0x8C($sp)
    /* B5C8C 800C548C 8400A68F */  lw         $a2, 0x84($sp)
    /* B5C90 800C5490 28F65024 */  addiu      $s0, $v0, %lo(gDiv)
    /* B5C94 800C5494 7F14030C */  jal        DrawW_CalcSubdivision__FP25Draw_tGiveShelbyMoreCacheP12Draw_SVertexN31
    /* B5C98 800C5498 1000B9AF */   sw        $t9, 0x10($sp)
    /* B5C9C 800C549C 7C00AF8F */  lw         $t7, 0x7C($sp)
    /* B5CA0 800C54A0 00000000 */  nop
    /* B5CA4 800C54A4 2A10E201 */  slt        $v0, $t7, $v0
    /* B5CA8 800C54A8 6C014010 */  beqz       $v0, .L800C5A5C
    /* B5CAC 800C54AC 21282002 */   addu      $a1, $s1, $zero
    /* B5CB0 800C54B0 3800B497 */  lhu        $s4, 0x38($sp)
    /* B5CB4 800C54B4 8400A68F */  lw         $a2, 0x84($sp)
    /* B5CB8 800C54B8 01008726 */  addiu      $a3, $s4, 0x1
    /* B5CBC 800C54BC 00141400 */  sll        $v0, $s4, 16
    /* B5CC0 800C54C0 0400F824 */  addiu      $t8, $a3, 0x4
    /* B5CC4 800C54C4 03130200 */  sra        $v0, $v0, 12
    /* B5CC8 800C54C8 21985000 */  addu       $s3, $v0, $s0
    /* B5CCC 800C54CC 21206002 */  addu       $a0, $s3, $zero
    /* B5CD0 800C54D0 0100E324 */  addiu      $v1, $a3, 0x1
    /* B5CD4 800C54D4 00140700 */  sll        $v0, $a3, 16
    /* B5CD8 800C54D8 03130200 */  sra        $v0, $v0, 12
    /* B5CDC 800C54DC 21A85000 */  addu       $s5, $v0, $s0
    /* B5CE0 800C54E0 0200E224 */  addiu      $v0, $a3, 0x2
    /* B5CE4 800C54E4 001C0300 */  sll        $v1, $v1, 16
    /* B5CE8 800C54E8 031B0300 */  sra        $v1, $v1, 12
    /* B5CEC 800C54EC 21B87000 */  addu       $s7, $v1, $s0
    /* B5CF0 800C54F0 0300E724 */  addiu      $a3, $a3, 0x3
    /* B5CF4 800C54F4 00140200 */  sll        $v0, $v0, 16
    /* B5CF8 800C54F8 03130200 */  sra        $v0, $v0, 12
    /* B5CFC 800C54FC 21B05000 */  addu       $s6, $v0, $s0
    /* B5D00 800C5500 003C0700 */  sll        $a3, $a3, 16
    /* B5D04 800C5504 033B0700 */  sra        $a3, $a3, 12
    /* B5D08 800C5508 2138F000 */  addu       $a3, $a3, $s0
    /* B5D0C 800C550C 3800B8A7 */  sh         $t8, 0x38($sp)
    /* B5D10 800C5510 4914030C */  jal        DrawW_DivVertice__FP12Draw_SVertexN20
    /* B5D14 800C5514 4800A7AF */   sw        $a3, 0x48($sp)
    /* B5D18 800C5518 000060CA */  lwc2       $0, 0x0($s3)
    /* B5D1C 800C551C 040061CA */  lwc2       $1, 0x4($s3)
    /* B5D20 800C5520 00000000 */  nop
    /* B5D24 800C5524 00000000 */  nop
    /* B5D28 800C5528 0100184A */  .word 0x4A180001  /* rtps */
    /* B5D2C 800C552C 2120A002 */  addu       $a0, $s5, $zero
    /* B5D30 800C5530 8400A58F */  lw         $a1, 0x84($sp)
    /* B5D34 800C5534 4914030C */  jal        DrawW_DivVertice__FP12Draw_SVertexN20
    /* B5D38 800C5538 2130C003 */   addu      $a2, $fp, $zero
    /* B5D3C 800C553C 2000A227 */  addiu      $v0, $sp, 0x20
    /* B5D40 800C5540 00F84C48 */  cfc2       $t4, $31 /* handwritten instruction */
    /* B5D44 800C5544 00000000 */  nop
    /* B5D48 800C5548 00004CAC */  sw         $t4, 0x0($v0)
    /* B5D4C 800C554C 2000A28F */  lw         $v0, 0x20($sp)
    /* B5D50 800C5550 00000000 */  nop
    /* B5D54 800C5554 03004104 */  bgez       $v0, .L800C5564
    /* B5D58 800C5558 01000224 */   addiu     $v0, $zero, 0x1
    /* B5D5C 800C555C 5A150308 */  j          .L800C5568
    /* B5D60 800C5560 0F0062A2 */   sb        $v0, 0xF($s3)
  .L800C5564:
    /* B5D64 800C5564 0F0060A2 */  sb         $zero, 0xF($s3)
  .L800C5568:
    /* B5D68 800C5568 08006226 */  addiu      $v0, $s3, 0x8
    /* B5D6C 800C556C 00004EE8 */  swc2       $14, 0x0($v0)
    /* B5D70 800C5570 0000A0CA */  lwc2       $0, 0x0($s5)
    /* B5D74 800C5574 0400A1CA */  lwc2       $1, 0x4($s5)
    /* B5D78 800C5578 00000000 */  nop
    /* B5D7C 800C557C 00000000 */  nop
    /* B5D80 800C5580 0100184A */  .word 0x4A180001  /* rtps */
    /* B5D84 800C5584 2120E002 */  addu       $a0, $s7, $zero
    /* B5D88 800C5588 8C00A68F */  lw         $a2, 0x8C($sp)
    /* B5D8C 800C558C 4914030C */  jal        DrawW_DivVertice__FP12Draw_SVertexN20
    /* B5D90 800C5590 2128C003 */   addu      $a1, $fp, $zero
    /* B5D94 800C5594 2400A227 */  addiu      $v0, $sp, 0x24
    /* B5D98 800C5598 00F84C48 */  cfc2       $t4, $31 /* handwritten instruction */
    /* B5D9C 800C559C 00000000 */  nop
    /* B5DA0 800C55A0 00004CAC */  sw         $t4, 0x0($v0)
    /* B5DA4 800C55A4 2400A28F */  lw         $v0, 0x24($sp)
    /* B5DA8 800C55A8 00000000 */  nop
    /* B5DAC 800C55AC 03004104 */  bgez       $v0, .L800C55BC
    /* B5DB0 800C55B0 01000224 */   addiu     $v0, $zero, 0x1
    /* B5DB4 800C55B4 70150308 */  j          .L800C55C0
    /* B5DB8 800C55B8 0F00A2A2 */   sb        $v0, 0xF($s5)
  .L800C55BC:
    /* B5DBC 800C55BC 0F00A0A2 */  sb         $zero, 0xF($s5)
  .L800C55C0:
    /* B5DC0 800C55C0 0800A226 */  addiu      $v0, $s5, 0x8
    /* B5DC4 800C55C4 00004EE8 */  swc2       $14, 0x0($v0)
    /* B5DC8 800C55C8 0000E0CA */  lwc2       $0, 0x0($s7)
    /* B5DCC 800C55CC 0400E1CA */  lwc2       $1, 0x4($s7)
    /* B5DD0 800C55D0 00000000 */  nop
    /* B5DD4 800C55D4 00000000 */  nop
    /* B5DD8 800C55D8 0100184A */  .word 0x4A180001  /* rtps */
    /* B5DDC 800C55DC 2120C002 */  addu       $a0, $s6, $zero
    /* B5DE0 800C55E0 8C00A58F */  lw         $a1, 0x8C($sp)
    /* B5DE4 800C55E4 4914030C */  jal        DrawW_DivVertice__FP12Draw_SVertexN20
    /* B5DE8 800C55E8 21302002 */   addu      $a2, $s1, $zero
    /* B5DEC 800C55EC 2800A227 */  addiu      $v0, $sp, 0x28
    /* B5DF0 800C55F0 00F84C48 */  cfc2       $t4, $31 /* handwritten instruction */
    /* B5DF4 800C55F4 00000000 */  nop
    /* B5DF8 800C55F8 00004CAC */  sw         $t4, 0x0($v0)
    /* B5DFC 800C55FC 2800A28F */  lw         $v0, 0x28($sp)
    /* B5E00 800C5600 00000000 */  nop
    /* B5E04 800C5604 03004104 */  bgez       $v0, .L800C5614
    /* B5E08 800C5608 01000224 */   addiu     $v0, $zero, 0x1
    /* B5E0C 800C560C 86150308 */  j          .L800C5618
    /* B5E10 800C5610 0F00E2A2 */   sb        $v0, 0xF($s7)
  .L800C5614:
    /* B5E14 800C5614 0F00E0A2 */  sb         $zero, 0xF($s7)
  .L800C5618:
    /* B5E18 800C5618 0800E226 */  addiu      $v0, $s7, 0x8
    /* B5E1C 800C561C 00004EE8 */  swc2       $14, 0x0($v0)
    /* B5E20 800C5620 0000C0CA */  lwc2       $0, 0x0($s6)
    /* B5E24 800C5624 0400C1CA */  lwc2       $1, 0x4($s6)
    /* B5E28 800C5628 00000000 */  nop
    /* B5E2C 800C562C 00000000 */  nop
    /* B5E30 800C5630 0100184A */  .word 0x4A180001  /* rtps */
    /* B5E34 800C5634 21282002 */  addu       $a1, $s1, $zero
    /* B5E38 800C5638 4800A48F */  lw         $a0, 0x48($sp)
    /* B5E3C 800C563C 4914030C */  jal        DrawW_DivVertice__FP12Draw_SVertexN20
    /* B5E40 800C5640 2130C003 */   addu      $a2, $fp, $zero
    /* B5E44 800C5644 2C00A227 */  addiu      $v0, $sp, 0x2C
    /* B5E48 800C5648 00F84C48 */  cfc2       $t4, $31 /* handwritten instruction */
    /* B5E4C 800C564C 00000000 */  nop
    /* B5E50 800C5650 00004CAC */  sw         $t4, 0x0($v0)
    /* B5E54 800C5654 2C00A28F */  lw         $v0, 0x2C($sp)
    /* B5E58 800C5658 00000000 */  nop
    /* B5E5C 800C565C 03004104 */  bgez       $v0, .L800C566C
    /* B5E60 800C5660 01000224 */   addiu     $v0, $zero, 0x1
    /* B5E64 800C5664 9C150308 */  j          .L800C5670
    /* B5E68 800C5668 0F00C2A2 */   sb        $v0, 0xF($s6)
  .L800C566C:
    /* B5E6C 800C566C 0F00C0A2 */  sb         $zero, 0xF($s6)
  .L800C5670:
    /* B5E70 800C5670 0800C226 */  addiu      $v0, $s6, 0x8
    /* B5E74 800C5674 00004EE8 */  swc2       $14, 0x0($v0)
    /* B5E78 800C5678 4800B98F */  lw         $t9, 0x48($sp)
    /* B5E7C 800C567C 00000000 */  nop
    /* B5E80 800C5680 000020CB */  lwc2       $0, 0x0($t9)
    /* B5E84 800C5684 040021CB */  lwc2       $1, 0x4($t9)
    /* B5E88 800C5688 00000000 */  nop
    /* B5E8C 800C568C 00000000 */  nop
    /* B5E90 800C5690 0100184A */  .word 0x4A180001  /* rtps */
    /* B5E94 800C5694 3000A227 */  addiu      $v0, $sp, 0x30
    /* B5E98 800C5698 00F84C48 */  cfc2       $t4, $31 /* handwritten instruction */
    /* B5E9C 800C569C 00000000 */  nop
    /* B5EA0 800C56A0 00004CAC */  sw         $t4, 0x0($v0)
    /* B5EA4 800C56A4 3000A28F */  lw         $v0, 0x30($sp)
    /* B5EA8 800C56A8 00000000 */  nop
    /* B5EAC 800C56AC 03004104 */  bgez       $v0, .L800C56BC
    /* B5EB0 800C56B0 01000224 */   addiu     $v0, $zero, 0x1
    /* B5EB4 800C56B4 B2150308 */  j          .L800C56C8
    /* B5EB8 800C56B8 0F0022A3 */   sb        $v0, 0xF($t9)
  .L800C56BC:
    /* B5EBC 800C56BC 4800AF8F */  lw         $t7, 0x48($sp)
    /* B5EC0 800C56C0 00000000 */  nop
    /* B5EC4 800C56C4 0F00E0A1 */  sb         $zero, 0xF($t7)
  .L800C56C8:
    /* B5EC8 800C56C8 DA004286 */  lh         $v0, 0xDA($s2)
    /* B5ECC 800C56CC 00000000 */  nop
    /* B5ED0 800C56D0 AE004010 */  beqz       $v0, .L800C598C
    /* B5ED4 800C56D4 00000000 */   nop
    /* B5ED8 800C56D8 17014292 */  lbu        $v0, 0x117($s2)
    /* B5EDC 800C56DC 00000000 */  nop
    /* B5EE0 800C56E0 F7004230 */  andi       $v0, $v0, 0xF7
    /* B5EE4 800C56E4 170142A2 */  sb         $v0, 0x117($s2)
    /* B5EE8 800C56E8 9400428E */  lw         $v0, 0x94($s2)
    /* B5EEC 800C56EC 0F002392 */  lbu        $v1, 0xF($s1)
    /* B5EF0 800C56F0 00000000 */  nop
    /* B5EF4 800C56F4 26006014 */  bnez       $v1, .L800C5790
    /* B5EF8 800C56F8 08005024 */   addiu     $s0, $v0, 0x8
    /* B5EFC 800C56FC 8400B48F */  lw         $s4, 0x84($sp)
    /* B5F00 800C5700 00000000 */  nop
    /* B5F04 800C5704 0F008292 */  lbu        $v0, 0xF($s4)
    /* B5F08 800C5708 00000000 */  nop
    /* B5F0C 800C570C 49004014 */  bnez       $v0, .L800C5834
    /* B5F10 800C5710 00000000 */   nop
    /* B5F14 800C5714 0F006292 */  lbu        $v0, 0xF($s3)
    /* B5F18 800C5718 00000000 */  nop
    /* B5F1C 800C571C 1C004014 */  bnez       $v0, .L800C5790
    /* B5F20 800C5720 801F0B3C */   lui       $t3, (0x1F800004 >> 16)
    /* B5F24 800C5724 04006B35 */  ori        $t3, $t3, (0x1F800004 & 0xFFFF)
    /* B5F28 800C5728 FF00093C */  lui        $t1, (0xFFFFFF >> 16)
    /* B5F2C 800C572C FFFF2935 */  ori        $t1, $t1, (0xFFFFFF & 0xFFFF)
    /* B5F30 800C5730 21282002 */  addu       $a1, $s1, $zero
    /* B5F34 800C5734 21308002 */  addu       $a2, $s4, $zero
    /* B5F38 800C5738 21386002 */  addu       $a3, $s3, $zero
    /* B5F3C 800C573C 80401000 */  sll        $t0, $s0, 2
    /* B5F40 800C5740 00FF0A3C */  lui        $t2, (0xFF000000 >> 16)
    /* B5F44 800C5744 801F023C */  lui        $v0, (0x1F800000 >> 16)
    /* B5F48 800C5748 0000428C */  lw         $v0, (0x1F800000 & 0xFFFF)($v0)
    /* B5F4C 800C574C 0000648D */  lw         $a0, 0x0($t3)
    /* B5F50 800C5750 21400201 */  addu       $t0, $t0, $v0
    /* B5F54 800C5754 0000838C */  lw         $v1, 0x0($a0)
    /* B5F58 800C5758 0000028D */  lw         $v0, 0x0($t0)
    /* B5F5C 800C575C 24186A00 */  and        $v1, $v1, $t2
    /* B5F60 800C5760 24104900 */  and        $v0, $v0, $t1
    /* B5F64 800C5764 25186200 */  or         $v1, $v1, $v0
    /* B5F68 800C5768 000083AC */  sw         $v1, 0x0($a0)
    /* B5F6C 800C576C 0000028D */  lw         $v0, 0x0($t0)
    /* B5F70 800C5770 28008324 */  addiu      $v1, $a0, 0x28
    /* B5F74 800C5774 000063AD */  sw         $v1, 0x0($t3)
    /* B5F78 800C5778 24188900 */  and        $v1, $a0, $t1
    /* B5F7C 800C577C 24104A00 */  and        $v0, $v0, $t2
    /* B5F80 800C5780 25104300 */  or         $v0, $v0, $v1
    /* B5F84 800C5784 000002AD */  sw         $v0, 0x0($t0)
    /* B5F88 800C5788 2D14030C */  jal        DrawW_AddSubdividPrimGT3__FP8POLY_GT3P12Draw_SVertexN21P25Draw_tGiveShelbyMoreCache
    /* B5F8C 800C578C 1000B2AF */   sw        $s2, 0x10($sp)
  .L800C5790:
    /* B5F90 800C5790 8400B88F */  lw         $t8, 0x84($sp)
    /* B5F94 800C5794 00000000 */  nop
    /* B5F98 800C5798 0F000293 */  lbu        $v0, 0xF($t8)
    /* B5F9C 800C579C 00000000 */  nop
    /* B5FA0 800C57A0 24004014 */  bnez       $v0, .L800C5834
    /* B5FA4 800C57A4 00000000 */   nop
    /* B5FA8 800C57A8 0F00C293 */  lbu        $v0, 0xF($fp)
    /* B5FAC 800C57AC 00000000 */  nop
    /* B5FB0 800C57B0 49004014 */  bnez       $v0, .L800C58D8
    /* B5FB4 800C57B4 00000000 */   nop
    /* B5FB8 800C57B8 0F00A292 */  lbu        $v0, 0xF($s5)
    /* B5FBC 800C57BC 00000000 */  nop
    /* B5FC0 800C57C0 1C004014 */  bnez       $v0, .L800C5834
    /* B5FC4 800C57C4 801F0B3C */   lui       $t3, (0x1F800004 >> 16)
    /* B5FC8 800C57C8 04006B35 */  ori        $t3, $t3, (0x1F800004 & 0xFFFF)
    /* B5FCC 800C57CC FF00093C */  lui        $t1, (0xFFFFFF >> 16)
    /* B5FD0 800C57D0 FFFF2935 */  ori        $t1, $t1, (0xFFFFFF & 0xFFFF)
    /* B5FD4 800C57D4 21280003 */  addu       $a1, $t8, $zero
    /* B5FD8 800C57D8 2130C003 */  addu       $a2, $fp, $zero
    /* B5FDC 800C57DC 2138A002 */  addu       $a3, $s5, $zero
    /* B5FE0 800C57E0 80401000 */  sll        $t0, $s0, 2
    /* B5FE4 800C57E4 00FF0A3C */  lui        $t2, (0xFF000000 >> 16)
    /* B5FE8 800C57E8 801F023C */  lui        $v0, (0x1F800000 >> 16)
    /* B5FEC 800C57EC 0000428C */  lw         $v0, (0x1F800000 & 0xFFFF)($v0)
    /* B5FF0 800C57F0 0000648D */  lw         $a0, 0x0($t3)
    /* B5FF4 800C57F4 21400201 */  addu       $t0, $t0, $v0
    /* B5FF8 800C57F8 0000838C */  lw         $v1, 0x0($a0)
    /* B5FFC 800C57FC 0000028D */  lw         $v0, 0x0($t0)
    /* B6000 800C5800 24186A00 */  and        $v1, $v1, $t2
    /* B6004 800C5804 24104900 */  and        $v0, $v0, $t1
    /* B6008 800C5808 25186200 */  or         $v1, $v1, $v0
    /* B600C 800C580C 000083AC */  sw         $v1, 0x0($a0)
    /* B6010 800C5810 0000028D */  lw         $v0, 0x0($t0)
    /* B6014 800C5814 28008324 */  addiu      $v1, $a0, 0x28
    /* B6018 800C5818 000063AD */  sw         $v1, 0x0($t3)
    /* B601C 800C581C 24188900 */  and        $v1, $a0, $t1
    /* B6020 800C5820 24104A00 */  and        $v0, $v0, $t2
    /* B6024 800C5824 25104300 */  or         $v0, $v0, $v1
    /* B6028 800C5828 000002AD */  sw         $v0, 0x0($t0)
    /* B602C 800C582C 2D14030C */  jal        DrawW_AddSubdividPrimGT3__FP8POLY_GT3P12Draw_SVertexN21P25Draw_tGiveShelbyMoreCache
    /* B6030 800C5830 1000B2AF */   sw        $s2, 0x10($sp)
  .L800C5834:
    /* B6034 800C5834 0F00C293 */  lbu        $v0, 0xF($fp)
    /* B6038 800C5838 00000000 */  nop
    /* B603C 800C583C 26004014 */  bnez       $v0, .L800C58D8
    /* B6040 800C5840 00000000 */   nop
    /* B6044 800C5844 8C00B98F */  lw         $t9, 0x8C($sp)
    /* B6048 800C5848 00000000 */  nop
    /* B604C 800C584C 0F002293 */  lbu        $v0, 0xF($t9)
    /* B6050 800C5850 00000000 */  nop
    /* B6054 800C5854 49004014 */  bnez       $v0, .L800C597C
    /* B6058 800C5858 00000000 */   nop
    /* B605C 800C585C 0F00E292 */  lbu        $v0, 0xF($s7)
    /* B6060 800C5860 00000000 */  nop
    /* B6064 800C5864 1C004014 */  bnez       $v0, .L800C58D8
    /* B6068 800C5868 801F0B3C */   lui       $t3, (0x1F800004 >> 16)
    /* B606C 800C586C 04006B35 */  ori        $t3, $t3, (0x1F800004 & 0xFFFF)
    /* B6070 800C5870 FF00093C */  lui        $t1, (0xFFFFFF >> 16)
    /* B6074 800C5874 FFFF2935 */  ori        $t1, $t1, (0xFFFFFF & 0xFFFF)
    /* B6078 800C5878 2128C003 */  addu       $a1, $fp, $zero
    /* B607C 800C587C 21302003 */  addu       $a2, $t9, $zero
    /* B6080 800C5880 2138E002 */  addu       $a3, $s7, $zero
    /* B6084 800C5884 80401000 */  sll        $t0, $s0, 2
    /* B6088 800C5888 00FF0A3C */  lui        $t2, (0xFF000000 >> 16)
    /* B608C 800C588C 801F023C */  lui        $v0, (0x1F800000 >> 16)
    /* B6090 800C5890 0000428C */  lw         $v0, (0x1F800000 & 0xFFFF)($v0)
    /* B6094 800C5894 0000648D */  lw         $a0, 0x0($t3)
    /* B6098 800C5898 21400201 */  addu       $t0, $t0, $v0
    /* B609C 800C589C 0000838C */  lw         $v1, 0x0($a0)
    /* B60A0 800C58A0 0000028D */  lw         $v0, 0x0($t0)
    /* B60A4 800C58A4 24186A00 */  and        $v1, $v1, $t2
    /* B60A8 800C58A8 24104900 */  and        $v0, $v0, $t1
    /* B60AC 800C58AC 25186200 */  or         $v1, $v1, $v0
    /* B60B0 800C58B0 000083AC */  sw         $v1, 0x0($a0)
    /* B60B4 800C58B4 0000028D */  lw         $v0, 0x0($t0)
    /* B60B8 800C58B8 28008324 */  addiu      $v1, $a0, 0x28
    /* B60BC 800C58BC 000063AD */  sw         $v1, 0x0($t3)
    /* B60C0 800C58C0 24188900 */  and        $v1, $a0, $t1
    /* B60C4 800C58C4 24104A00 */  and        $v0, $v0, $t2
    /* B60C8 800C58C8 25104300 */  or         $v0, $v0, $v1
    /* B60CC 800C58CC 000002AD */  sw         $v0, 0x0($t0)
    /* B60D0 800C58D0 2D14030C */  jal        DrawW_AddSubdividPrimGT3__FP8POLY_GT3P12Draw_SVertexN21P25Draw_tGiveShelbyMoreCache
    /* B60D4 800C58D4 1000B2AF */   sw        $s2, 0x10($sp)
  .L800C58D8:
    /* B60D8 800C58D8 8C00AF8F */  lw         $t7, 0x8C($sp)
    /* B60DC 800C58DC 00000000 */  nop
    /* B60E0 800C58E0 0F00E291 */  lbu        $v0, 0xF($t7)
    /* B60E4 800C58E4 00000000 */  nop
    /* B60E8 800C58E8 24004014 */  bnez       $v0, .L800C597C
    /* B60EC 800C58EC 00000000 */   nop
    /* B60F0 800C58F0 0F002292 */  lbu        $v0, 0xF($s1)
    /* B60F4 800C58F4 00000000 */  nop
    /* B60F8 800C58F8 20004014 */  bnez       $v0, .L800C597C
    /* B60FC 800C58FC 00000000 */   nop
    /* B6100 800C5900 0F00C292 */  lbu        $v0, 0xF($s6)
    /* B6104 800C5904 00000000 */  nop
    /* B6108 800C5908 1C004014 */  bnez       $v0, .L800C597C
    /* B610C 800C590C 801F0B3C */   lui       $t3, (0x1F800004 >> 16)
    /* B6110 800C5910 04006B35 */  ori        $t3, $t3, (0x1F800004 & 0xFFFF)
    /* B6114 800C5914 FF00093C */  lui        $t1, (0xFFFFFF >> 16)
    /* B6118 800C5918 FFFF2935 */  ori        $t1, $t1, (0xFFFFFF & 0xFFFF)
    /* B611C 800C591C 2128E001 */  addu       $a1, $t7, $zero
    /* B6120 800C5920 21302002 */  addu       $a2, $s1, $zero
    /* B6124 800C5924 2138C002 */  addu       $a3, $s6, $zero
    /* B6128 800C5928 80401000 */  sll        $t0, $s0, 2
    /* B612C 800C592C 00FF0A3C */  lui        $t2, (0xFF000000 >> 16)
    /* B6130 800C5930 801F023C */  lui        $v0, (0x1F800000 >> 16)
    /* B6134 800C5934 0000428C */  lw         $v0, (0x1F800000 & 0xFFFF)($v0)
    /* B6138 800C5938 0000648D */  lw         $a0, 0x0($t3)
    /* B613C 800C593C 21400201 */  addu       $t0, $t0, $v0
    /* B6140 800C5940 0000838C */  lw         $v1, 0x0($a0)
    /* B6144 800C5944 0000028D */  lw         $v0, 0x0($t0)
    /* B6148 800C5948 24186A00 */  and        $v1, $v1, $t2
    /* B614C 800C594C 24104900 */  and        $v0, $v0, $t1
    /* B6150 800C5950 25186200 */  or         $v1, $v1, $v0
    /* B6154 800C5954 000083AC */  sw         $v1, 0x0($a0)
    /* B6158 800C5958 0000028D */  lw         $v0, 0x0($t0)
    /* B615C 800C595C 28008324 */  addiu      $v1, $a0, 0x28
    /* B6160 800C5960 000063AD */  sw         $v1, 0x0($t3)
    /* B6164 800C5964 24188900 */  and        $v1, $a0, $t1
    /* B6168 800C5968 24104A00 */  and        $v0, $v0, $t2
    /* B616C 800C596C 25104300 */  or         $v0, $v0, $v1
    /* B6170 800C5970 000002AD */  sw         $v0, 0x0($t0)
    /* B6174 800C5974 2D14030C */  jal        DrawW_AddSubdividPrimGT3__FP8POLY_GT3P12Draw_SVertexN21P25Draw_tGiveShelbyMoreCache
    /* B6178 800C5978 1000B2AF */   sw        $s2, 0x10($sp)
  .L800C597C:
    /* B617C 800C597C 17014292 */  lbu        $v0, 0x117($s2)
    /* B6180 800C5980 00000000 */  nop
    /* B6184 800C5984 08004234 */  ori        $v0, $v0, 0x8
    /* B6188 800C5988 170142A2 */  sb         $v0, 0x117($s2)
  .L800C598C:
    /* B618C 800C598C 7C00B48F */  lw         $s4, 0x7C($sp)
    /* B6190 800C5990 4800B88F */  lw         $t8, 0x48($sp)
    /* B6194 800C5994 01009426 */  addiu      $s4, $s4, 0x1
    /* B6198 800C5998 08000227 */  addiu      $v0, $t8, 0x8
    /* B619C 800C599C 7C00B4AF */  sw         $s4, 0x7C($sp)
    /* B61A0 800C59A0 00004EE8 */  swc2       $14, 0x0($v0)
    /* B61A4 800C59A4 21204002 */  addu       $a0, $s2, $zero
    /* B61A8 800C59A8 21302002 */  addu       $a2, $s1, $zero
    /* B61AC 800C59AC 7C00A58F */  lw         $a1, 0x7C($sp)
    /* B61B0 800C59B0 3800B997 */  lhu        $t9, 0x38($sp)
    /* B61B4 800C59B4 4000AF97 */  lhu        $t7, 0x40($sp)
    /* B61B8 800C59B8 21386002 */  addu       $a3, $s3, $zero
    /* B61BC 800C59BC 1000B8AF */  sw         $t8, 0x10($sp)
    /* B61C0 800C59C0 1400B6AF */  sw         $s6, 0x14($sp)
    /* B61C4 800C59C4 008C1900 */  sll        $s1, $t9, 16
    /* B61C8 800C59C8 038C1100 */  sra        $s1, $s1, 16
    /* B61CC 800C59CC 00840F00 */  sll        $s0, $t7, 16
    /* B61D0 800C59D0 03841000 */  sra        $s0, $s0, 16
    /* B61D4 800C59D4 1800B1AF */  sw         $s1, 0x18($sp)
    /* B61D8 800C59D8 A114030C */  jal        DrawW_SubdividFacet__FP25Draw_tGiveShelbyMoreCacheiP12Draw_SVertexN32ss
    /* B61DC 800C59DC 1C00B0AF */   sw        $s0, 0x1C($sp)
    /* B61E0 800C59E0 21204002 */  addu       $a0, $s2, $zero
    /* B61E4 800C59E4 7C00A58F */  lw         $a1, 0x7C($sp)
    /* B61E8 800C59E8 8400A78F */  lw         $a3, 0x84($sp)
    /* B61EC 800C59EC 4800B48F */  lw         $s4, 0x48($sp)
    /* B61F0 800C59F0 21306002 */  addu       $a2, $s3, $zero
    /* B61F4 800C59F4 1000B5AF */  sw         $s5, 0x10($sp)
    /* B61F8 800C59F8 1800B1AF */  sw         $s1, 0x18($sp)
    /* B61FC 800C59FC 1C00B0AF */  sw         $s0, 0x1C($sp)
    /* B6200 800C5A00 A114030C */  jal        DrawW_SubdividFacet__FP25Draw_tGiveShelbyMoreCacheiP12Draw_SVertexN32ss
    /* B6204 800C5A04 1400B4AF */   sw        $s4, 0x14($sp)
    /* B6208 800C5A08 21204002 */  addu       $a0, $s2, $zero
    /* B620C 800C5A0C 7C00A58F */  lw         $a1, 0x7C($sp)
    /* B6210 800C5A10 4800A68F */  lw         $a2, 0x48($sp)
    /* B6214 800C5A14 2138A002 */  addu       $a3, $s5, $zero
    /* B6218 800C5A18 1000BEAF */  sw         $fp, 0x10($sp)
    /* B621C 800C5A1C 1400B7AF */  sw         $s7, 0x14($sp)
    /* B6220 800C5A20 1800B1AF */  sw         $s1, 0x18($sp)
    /* B6224 800C5A24 A114030C */  jal        DrawW_SubdividFacet__FP25Draw_tGiveShelbyMoreCacheiP12Draw_SVertexN32ss
    /* B6228 800C5A28 1C00B0AF */   sw        $s0, 0x1C($sp)
    /* B622C 800C5A2C 21204002 */  addu       $a0, $s2, $zero
    /* B6230 800C5A30 7C00A58F */  lw         $a1, 0x7C($sp)
    /* B6234 800C5A34 4800A78F */  lw         $a3, 0x48($sp)
    /* B6238 800C5A38 8C00B88F */  lw         $t8, 0x8C($sp)
    /* B623C 800C5A3C 2130C002 */  addu       $a2, $s6, $zero
    /* B6240 800C5A40 1000B7AF */  sw         $s7, 0x10($sp)
    /* B6244 800C5A44 1800B1AF */  sw         $s1, 0x18($sp)
    /* B6248 800C5A48 1C00B0AF */  sw         $s0, 0x1C($sp)
    /* B624C 800C5A4C A114030C */  jal        DrawW_SubdividFacet__FP25Draw_tGiveShelbyMoreCacheiP12Draw_SVertexN32ss
    /* B6250 800C5A50 1400B8AF */   sw        $t8, 0x14($sp)
    /* B6254 800C5A54 E1160308 */  j          .L800C5B84
    /* B6258 800C5A58 00000000 */   nop
  .L800C5A5C:
    /* B625C 800C5A5C 4000B997 */  lhu        $t9, 0x40($sp)
    /* B6260 800C5A60 00000000 */  nop
    /* B6264 800C5A64 00141900 */  sll        $v0, $t9, 16
    /* B6268 800C5A68 30004010 */  beqz       $v0, .L800C5B2C
    /* B626C 800C5A6C 94004226 */   addiu     $v0, $s2, 0x94
    /* B6270 800C5A70 0800348E */  lw         $s4, 0x8($s1)
    /* B6274 800C5A74 8400AF8F */  lw         $t7, 0x84($sp)
    /* B6278 800C5A78 0800D88F */  lw         $t8, 0x8($fp)
    /* B627C 800C5A7C 0800EF8D */  lw         $t7, 0x8($t7)
    /* B6280 800C5A80 00609448 */  mtc2       $s4, $12 /* handwritten instruction */
    /* B6284 800C5A84 00709848 */  mtc2       $t8, $14 /* handwritten instruction */
    /* B6288 800C5A88 00688F48 */  mtc2       $t7, $13 /* handwritten instruction */
    /* B628C 800C5A8C 00000000 */  nop
    /* B6290 800C5A90 00000000 */  nop
    /* B6294 800C5A94 0600404B */  .word 0x4B400006  /* nclip */
    /* B6298 800C5A98 3400A327 */  addiu      $v1, $sp, 0x34
    /* B629C 800C5A9C 000078E8 */  swc2       $24, 0x0($v1)
    /* B62A0 800C5AA0 0C00428E */  lw         $v0, 0xC($s2)
    /* B62A4 800C5AA4 01000424 */  addiu      $a0, $zero, 0x1
    /* B62A8 800C5AA8 05004414 */  bne        $v0, $a0, .L800C5AC0
    /* B62AC 800C5AAC 00000000 */   nop
    /* B62B0 800C5AB0 3400A28F */  lw         $v0, 0x34($sp)
    /* B62B4 800C5AB4 00000000 */  nop
    /* B62B8 800C5AB8 23100200 */  negu       $v0, $v0
    /* B62BC 800C5ABC 3400A2AF */  sw         $v0, 0x34($sp)
  .L800C5AC0:
    /* B62C0 800C5AC0 3400A28F */  lw         $v0, 0x34($sp)
    /* B62C4 800C5AC4 00000000 */  nop
    /* B62C8 800C5AC8 18004104 */  bgez       $v0, .L800C5B2C
    /* B62CC 800C5ACC 94004226 */   addiu     $v0, $s2, 0x94
    /* B62D0 800C5AD0 08002F8E */  lw         $t7, 0x8($s1)
    /* B62D4 800C5AD4 8C00B98F */  lw         $t9, 0x8C($sp)
    /* B62D8 800C5AD8 0800D48F */  lw         $s4, 0x8($fp)
    /* B62DC 800C5ADC 0800398F */  lw         $t9, 0x8($t9)
    /* B62E0 800C5AE0 00608F48 */  mtc2       $t7, $12 /* handwritten instruction */
    /* B62E4 800C5AE4 00709948 */  mtc2       $t9, $14 /* handwritten instruction */
    /* B62E8 800C5AE8 00689448 */  mtc2       $s4, $13 /* handwritten instruction */
    /* B62EC 800C5AEC 00000000 */  nop
    /* B62F0 800C5AF0 00000000 */  nop
    /* B62F4 800C5AF4 0600404B */  .word 0x4B400006  /* nclip */
    /* B62F8 800C5AF8 000078E8 */  swc2       $24, 0x0($v1)
    /* B62FC 800C5AFC 0C00428E */  lw         $v0, 0xC($s2)
    /* B6300 800C5B00 00000000 */  nop
    /* B6304 800C5B04 05004414 */  bne        $v0, $a0, .L800C5B1C
    /* B6308 800C5B08 00000000 */   nop
    /* B630C 800C5B0C 3400A28F */  lw         $v0, 0x34($sp)
    /* B6310 800C5B10 00000000 */  nop
    /* B6314 800C5B14 23100200 */  negu       $v0, $v0
    /* B6318 800C5B18 3400A2AF */  sw         $v0, 0x34($sp)
  .L800C5B1C:
    /* B631C 800C5B1C 3400A28F */  lw         $v0, 0x34($sp)
    /* B6320 800C5B20 00000000 */  nop
    /* B6324 800C5B24 17004004 */  bltz       $v0, .L800C5B84
    /* B6328 800C5B28 94004226 */   addiu     $v0, $s2, 0x94
  .L800C5B2C:
    /* B632C 800C5B2C 0400538E */  lw         $s3, 0x4($s2)
    /* B6330 800C5B30 00004C8C */  lw         $t4, 0x0($v0)
    /* B6334 800C5B34 00004D8E */  lw         $t5, 0x0($s2)
    /* B6338 800C5B38 34006E26 */  addiu      $t6, $s3, 0x34
    /* B633C 800C5B3C 80600C00 */  sll        $t4, $t4, 2
    /* B6340 800C5B40 2168AC01 */  addu       $t5, $t5, $t4
    /* B6344 800C5B44 04004EAE */  sw         $t6, 0x4($s2)
    /* B6348 800C5B48 0200AE89 */  lwl        $t6, 0x2($t5)
    /* B634C 800C5B4C 000C0C3C */  lui        $t4, (0xC000000 >> 16)
    /* B6350 800C5B50 02720E00 */  srl        $t6, $t6, 8
    /* B6354 800C5B54 2570CC01 */  or         $t6, $t6, $t4
    /* B6358 800C5B58 00621300 */  sll        $t4, $s3, 8
    /* B635C 800C5B5C 00006EAE */  sw         $t6, 0x0($s3)
    /* B6360 800C5B60 0200ACA9 */  swl        $t4, 0x2($t5)
    /* B6364 800C5B64 21206002 */  addu       $a0, $s3, $zero
    /* B6368 800C5B68 21282002 */  addu       $a1, $s1, $zero
    /* B636C 800C5B6C 8400A68F */  lw         $a2, 0x84($sp)
    /* B6370 800C5B70 8C00AF8F */  lw         $t7, 0x8C($sp)
    /* B6374 800C5B74 2138C003 */  addu       $a3, $fp, $zero
    /* B6378 800C5B78 1400B2AF */  sw         $s2, 0x14($sp)
    /* B637C 800C5B7C 0A14030C */  jal        DrawW_AddSubdividPrimGT4__FP8POLY_GT4P12Draw_SVertexN31P25Draw_tGiveShelbyMoreCache
    /* B6380 800C5B80 1000AFAF */   sw        $t7, 0x10($sp)
  .L800C5B84:
    /* B6384 800C5B84 7400BF8F */  lw         $ra, 0x74($sp)
    /* B6388 800C5B88 7000BE8F */  lw         $fp, 0x70($sp)
    /* B638C 800C5B8C 6C00B78F */  lw         $s7, 0x6C($sp)
    /* B6390 800C5B90 6800B68F */  lw         $s6, 0x68($sp)
    /* B6394 800C5B94 6400B58F */  lw         $s5, 0x64($sp)
    /* B6398 800C5B98 6000B48F */  lw         $s4, 0x60($sp)
    /* B639C 800C5B9C 5C00B38F */  lw         $s3, 0x5C($sp)
    /* B63A0 800C5BA0 5800B28F */  lw         $s2, 0x58($sp)
    /* B63A4 800C5BA4 5400B18F */  lw         $s1, 0x54($sp)
    /* B63A8 800C5BA8 5000B08F */  lw         $s0, 0x50($sp)
    /* B63AC 800C5BAC 0800E003 */  jr         $ra
    /* B63B0 800C5BB0 7800BD27 */   addiu     $sp, $sp, 0x78
endlabel DrawW_SubdividFacet__FP25Draw_tGiveShelbyMoreCacheiP12Draw_SVertexN32ss
