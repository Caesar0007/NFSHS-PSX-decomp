.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawCar__FR8tCarInfossffcbUl7tPlayer, 0x1AC

glabel DrawCar__FR8tCarInfossffcbUl7tPlayer
    /* 2B1D4 8003A9D4 1480023C */  lui        $v0, %hi(ticks)
    /* 2B1D8 8003A9D8 ACDC438C */  lw         $v1, %lo(ticks)($v0)
    /* 2B1DC 8003A9DC B0FFBD27 */  addiu      $sp, $sp, -0x50
    /* 2B1E0 8003A9E0 3400B1AF */  sw         $s1, 0x34($sp)
    /* 2B1E4 8003A9E4 7000B18F */  lw         $s1, 0x70($sp)
    /* 2B1E8 8003A9E8 3C00B3AF */  sw         $s3, 0x3C($sp)
    /* 2B1EC 8003A9EC 6400B393 */  lbu        $s3, 0x64($sp)
    /* 2B1F0 8003A9F0 21408000 */  addu       $t0, $a0, $zero
    /* 2B1F4 8003A9F4 4400B5AF */  sw         $s5, 0x44($sp)
    /* 2B1F8 8003A9F8 21A8E000 */  addu       $s5, $a3, $zero
    /* 2B1FC 8003A9FC 3800B2AF */  sw         $s2, 0x38($sp)
    /* 2B200 8003AA00 2190A000 */  addu       $s2, $a1, $zero
    /* 2B204 8003AA04 4000B4AF */  sw         $s4, 0x40($sp)
    /* 2B208 8003AA08 21A0C000 */  addu       $s4, $a2, $zero
    /* 2B20C 8003AA0C 4800BFAF */  sw         $ra, 0x48($sp)
    /* 2B210 8003AA10 3000B0AF */  sw         $s0, 0x30($sp)
    /* 2B214 8003AA14 21106000 */  addu       $v0, $v1, $zero
    /* 2B218 8003AA18 02006104 */  bgez       $v1, .L8003AA24
    /* 2B21C 8003AA1C 21206000 */   addu      $a0, $v1, $zero
    /* 2B220 8003AA20 FF076224 */  addiu      $v0, $v1, 0x7FF
  .L8003AA24:
    /* 2B224 8003AA24 C31A0200 */  sra        $v1, $v0, 11
    /* 2B228 8003AA28 C0120300 */  sll        $v0, $v1, 11
    /* 2B22C 8003AA2C 23188200 */  subu       $v1, $a0, $v0
    /* 2B230 8003AA30 1480023C */  lui        $v0, %hi(DrawC_gMenuLights)
    /* 2B234 8003AA34 08D840AC */  sw         $zero, %lo(DrawC_gMenuLights)($v0)
    /* 2B238 8003AA38 0004622C */  sltiu      $v0, $v1, 0x400
    /* 2B23C 8003AA3C 03004010 */  beqz       $v0, .L8003AA4C
    /* 2B240 8003AA40 1480023C */   lui       $v0, %hi(DrawC_gMenuLightsDirection)
    /* 2B244 8003AA44 96EA0008 */  j          .L8003AA58
    /* 2B248 8003AA48 0CD840AC */   sw        $zero, %lo(DrawC_gMenuLightsDirection)($v0)
  .L8003AA4C:
    /* 2B24C 8003AA4C 1480033C */  lui        $v1, %hi(DrawC_gMenuLightsDirection)
    /* 2B250 8003AA50 01000224 */  addiu      $v0, $zero, 0x1
    /* 2B254 8003AA54 0CD862AC */  sw         $v0, %lo(DrawC_gMenuLightsDirection)($v1)
  .L8003AA58:
    /* 2B258 8003AA58 00000281 */  lb         $v0, 0x0($t0)
    /* 2B25C 8003AA5C 00000000 */  nop
    /* 2B260 8003AA60 3E004004 */  bltz       $v0, .L8003AB5C
    /* 2B264 8003AA64 0580103C */   lui       $s0, %hi(gCarObj)
    /* 2B268 8003AA68 682A1026 */  addiu      $s0, $s0, %lo(gCarObj)
    /* 2B26C 8003AA6C 80281100 */  sll        $a1, $s1, 2
    /* 2B270 8003AA70 2180B000 */  addu       $s0, $a1, $s0
    /* 2B274 8003AA74 0000028E */  lw         $v0, 0x0($s0)
    /* 2B278 8003AA78 C5000491 */  lbu        $a0, 0xC5($t0)
    /* 2B27C 8003AA7C 8802438C */  lw         $v1, 0x288($v0)
    /* 2B280 8003AA80 01000291 */  lbu        $v0, 0x1($t0)
    /* 2B284 8003AA84 00000000 */  nop
    /* 2B288 8003AA88 000062AC */  sw         $v0, 0x0($v1)
    /* 2B28C 8003AA8C 0000028E */  lw         $v0, 0x0($s0)
    /* 2B290 8003AA90 00000000 */  nop
    /* 2B294 8003AA94 8802438C */  lw         $v1, 0x288($v0)
    /* 2B298 8003AA98 C7000291 */  lbu        $v0, 0xC7($t0)
    /* 2B29C 8003AA9C 00000000 */  nop
    /* 2B2A0 8003AAA0 A00062AC */  sw         $v0, 0xA0($v1)
    /* 2B2A4 8003AAA4 0580023C */  lui        $v0, %hi(gMenuRotate)
    /* 2B2A8 8003AAA8 64124224 */  addiu      $v0, $v0, %lo(gMenuRotate)
    /* 2B2AC 8003AAAC 2128A200 */  addu       $a1, $a1, $v0
    /* 2B2B0 8003AAB0 0000A28C */  lw         $v0, 0x0($a1)
    /* 2B2B4 8003AAB4 00000000 */  nop
    /* 2B2B8 8003AAB8 03004224 */  addiu      $v0, $v0, 0x3
    /* 2B2BC 8003AABC 0000A2AC */  sw         $v0, 0x0($a1)
    /* 2B2C0 8003AAC0 C4000291 */  lbu        $v0, 0xC4($t0)
    /* 2B2C4 8003AAC4 0000038E */  lw         $v1, 0x0($s0)
    /* 2B2C8 8003AAC8 82100200 */  srl        $v0, $v0, 2
    /* 2B2CC 8003AACC 8802638C */  lw         $v1, 0x288($v1)
    /* 2B2D0 8003AAD0 01004230 */  andi       $v0, $v0, 0x1
    /* 2B2D4 8003AAD4 3C0062AC */  sw         $v0, 0x3C($v1)
    /* 2B2D8 8003AAD8 C4000291 */  lbu        $v0, 0xC4($t0)
    /* 2B2DC 8003AADC 0000038E */  lw         $v1, 0x0($s0)
    /* 2B2E0 8003AAE0 42100200 */  srl        $v0, $v0, 1
    /* 2B2E4 8003AAE4 8802638C */  lw         $v1, 0x288($v1)
    /* 2B2E8 8003AAE8 01004230 */  andi       $v0, $v0, 0x1
    /* 2B2EC 8003AAEC 400062AC */  sw         $v0, 0x40($v1)
    /* 2B2F0 8003AAF0 0000038E */  lw         $v1, 0x0($s0)
    /* 2B2F4 8003AAF4 C4000291 */  lbu        $v0, 0xC4($t0)
    /* 2B2F8 8003AAF8 8802638C */  lw         $v1, 0x288($v1)
    /* 2B2FC 8003AAFC 01004230 */  andi       $v0, $v0, 0x1
    /* 2B300 8003AB00 440062AC */  sw         $v0, 0x44($v1)
    /* 2B304 8003AB04 0000058E */  lw         $a1, 0x0($s0)
    /* 2B308 8003AB08 C9FA020C */  jal        DrawC_MenuColorData__FiP8Car_tObji
    /* 2B30C 8003AB0C 21302002 */   addu      $a2, $s1, $zero
    /* 2B310 8003AB10 1180053C */  lui        $a1, %hi(gCView)
    /* 2B314 8003AB14 7C6FA524 */  addiu      $a1, $a1, %lo(gCView)
    /* 2B318 8003AB18 6C00A28F */  lw         $v0, 0x6C($sp)
    /* 2B31C 8003AB1C 00341200 */  sll        $a2, $s2, 16
    /* 2B320 8003AB20 1800A2AF */  sw         $v0, 0x18($sp)
    /* 2B324 8003AB24 6000A28F */  lw         $v0, 0x60($sp)
    /* 2B328 8003AB28 03340600 */  sra        $a2, $a2, 16
    /* 2B32C 8003AB2C 2000A2AF */  sw         $v0, 0x20($sp)
    /* 2B330 8003AB30 FF006232 */  andi       $v0, $s3, 0xFF
    /* 2B334 8003AB34 2400A2AF */  sw         $v0, 0x24($sp)
    /* 2B338 8003AB38 6800A28F */  lw         $v0, 0x68($sp)
    /* 2B33C 8003AB3C 003C1400 */  sll        $a3, $s4, 16
    /* 2B340 8003AB40 1000B1AF */  sw         $s1, 0x10($sp)
    /* 2B344 8003AB44 1400A0AF */  sw         $zero, 0x14($sp)
    /* 2B348 8003AB48 1C00B5AF */  sw         $s5, 0x1C($sp)
    /* 2B34C 8003AB4C 2800A2AF */  sw         $v0, 0x28($sp)
    /* 2B350 8003AB50 0000048E */  lw         $a0, 0x0($s0)
    /* 2B354 8003AB54 FE4A000C */  jal        Draw_MenuRenderingView__FP8Car_tObjP13DRender_tViewiiiUliffii
    /* 2B358 8003AB58 033C0700 */   sra       $a3, $a3, 16
  .L8003AB5C:
    /* 2B35C 8003AB5C 4800BF8F */  lw         $ra, 0x48($sp)
    /* 2B360 8003AB60 4400B58F */  lw         $s5, 0x44($sp)
    /* 2B364 8003AB64 4000B48F */  lw         $s4, 0x40($sp)
    /* 2B368 8003AB68 3C00B38F */  lw         $s3, 0x3C($sp)
    /* 2B36C 8003AB6C 3800B28F */  lw         $s2, 0x38($sp)
    /* 2B370 8003AB70 3400B18F */  lw         $s1, 0x34($sp)
    /* 2B374 8003AB74 3000B08F */  lw         $s0, 0x30($sp)
    /* 2B378 8003AB78 0800E003 */  jr         $ra
    /* 2B37C 8003AB7C 5000BD27 */   addiu     $sp, $sp, 0x50
endlabel DrawCar__FR8tCarInfossffcbUl7tPlayer
