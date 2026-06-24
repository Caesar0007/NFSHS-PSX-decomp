.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching VSync, 0x178

glabel VSync
    /* E2B1C 800F231C 1380023C */  lui        $v0, %hi(D_80134A88)
    /* E2B20 800F2320 884A428C */  lw         $v0, %lo(D_80134A88)($v0)
    /* E2B24 800F2324 1380053C */  lui        $a1, %hi(D_80134A8C)
    /* E2B28 800F2328 8C4AA58C */  lw         $a1, %lo(D_80134A8C)($a1)
    /* E2B2C 800F232C D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* E2B30 800F2330 2000BFAF */  sw         $ra, 0x20($sp)
    /* E2B34 800F2334 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* E2B38 800F2338 1800B0AF */  sw         $s0, 0x18($sp)
    /* E2B3C 800F233C 0000508C */  lw         $s0, 0x0($v0)
  .L800F2340:
    /* E2B40 800F2340 0000A28C */  lw         $v0, 0x0($a1)
    /* E2B44 800F2344 00000000 */  nop
    /* E2B48 800F2348 1000A2AF */  sw         $v0, 0x10($sp)
    /* E2B4C 800F234C 1000A38F */  lw         $v1, 0x10($sp)
    /* E2B50 800F2350 0000A28C */  lw         $v0, 0x0($a1)
    /* E2B54 800F2354 00000000 */  nop
    /* E2B58 800F2358 F9FF6214 */  bne        $v1, $v0, .L800F2340
    /* E2B5C 800F235C 00000000 */   nop
    /* E2B60 800F2360 1000A28F */  lw         $v0, 0x10($sp)
    /* E2B64 800F2364 1380033C */  lui        $v1, %hi(Hcount)
    /* E2B68 800F2368 904A638C */  lw         $v1, %lo(Hcount)($v1)
    /* E2B6C 800F236C 00000000 */  nop
    /* E2B70 800F2370 23104300 */  subu       $v0, $v0, $v1
    /* E2B74 800F2374 05008104 */  bgez       $a0, .L800F238C
    /* E2B78 800F2378 FFFF5130 */   andi      $s1, $v0, 0xFFFF
    /* E2B7C 800F237C 1380023C */  lui        $v0, %hi(Vcount)
    /* E2B80 800F2380 107D428C */  lw         $v0, %lo(Vcount)($v0)
    /* E2B84 800F2384 20C90308 */  j          .L800F2480
    /* E2B88 800F2388 00000000 */   nop
  .L800F238C:
    /* E2B8C 800F238C 01000224 */  addiu      $v0, $zero, 0x1
    /* E2B90 800F2390 3A008210 */  beq        $a0, $v0, .L800F247C
    /* E2B94 800F2394 00000000 */   nop
    /* E2B98 800F2398 07008018 */  blez       $a0, .L800F23B8
    /* E2B9C 800F239C 00000000 */   nop
    /* E2BA0 800F23A0 1380023C */  lui        $v0, %hi(D_80134A94)
    /* E2BA4 800F23A4 944A428C */  lw         $v0, %lo(D_80134A94)($v0)
    /* E2BA8 800F23A8 00000000 */  nop
    /* E2BAC 800F23AC FFFF4224 */  addiu      $v0, $v0, -0x1
    /* E2BB0 800F23B0 F0C80308 */  j          .L800F23C0
    /* E2BB4 800F23B4 21104400 */   addu      $v0, $v0, $a0
  .L800F23B8:
    /* E2BB8 800F23B8 1380023C */  lui        $v0, %hi(D_80134A94)
    /* E2BBC 800F23BC 944A428C */  lw         $v0, %lo(D_80134A94)($v0)
  .L800F23C0:
    /* E2BC0 800F23C0 02008018 */  blez       $a0, .L800F23CC
    /* E2BC4 800F23C4 21280000 */   addu      $a1, $zero, $zero
    /* E2BC8 800F23C8 FFFF8524 */  addiu      $a1, $a0, -0x1
  .L800F23CC:
    /* E2BCC 800F23CC 25C9030C */  jal        _VSync_wait
    /* E2BD0 800F23D0 21204000 */   addu      $a0, $v0, $zero
    /* E2BD4 800F23D4 1380023C */  lui        $v0, %hi(D_80134A88)
    /* E2BD8 800F23D8 884A428C */  lw         $v0, %lo(D_80134A88)($v0)
    /* E2BDC 800F23DC 00000000 */  nop
    /* E2BE0 800F23E0 0000508C */  lw         $s0, 0x0($v0)
    /* E2BE4 800F23E4 1380043C */  lui        $a0, %hi(Vcount)
    /* E2BE8 800F23E8 107D848C */  lw         $a0, %lo(Vcount)($a0)
    /* E2BEC 800F23EC 01000524 */  addiu      $a1, $zero, 0x1
    /* E2BF0 800F23F0 25C9030C */  jal        _VSync_wait
    /* E2BF4 800F23F4 01008424 */   addiu     $a0, $a0, 0x1
    /* E2BF8 800F23F8 4000023C */  lui        $v0, (0x400000 >> 16)
    /* E2BFC 800F23FC 24100202 */  and        $v0, $s0, $v0
    /* E2C00 800F2400 0F004010 */  beqz       $v0, .L800F2440
    /* E2C04 800F2404 00000000 */   nop
    /* E2C08 800F2408 1380033C */  lui        $v1, %hi(D_80134A88)
    /* E2C0C 800F240C 884A638C */  lw         $v1, %lo(D_80134A88)($v1)
    /* E2C10 800F2410 00000000 */  nop
    /* E2C14 800F2414 0000628C */  lw         $v0, 0x0($v1)
    /* E2C18 800F2418 00000000 */  nop
    /* E2C1C 800F241C 26100202 */  xor        $v0, $s0, $v0
    /* E2C20 800F2420 07004004 */  bltz       $v0, .L800F2440
    /* E2C24 800F2424 0080043C */   lui       $a0, (0x80000000 >> 16)
  .L800F2428:
    /* E2C28 800F2428 0000628C */  lw         $v0, 0x0($v1)
    /* E2C2C 800F242C 00000000 */  nop
    /* E2C30 800F2430 26100202 */  xor        $v0, $s0, $v0
    /* E2C34 800F2434 24104400 */  and        $v0, $v0, $a0
    /* E2C38 800F2438 FBFF4010 */  beqz       $v0, .L800F2428
    /* E2C3C 800F243C 00000000 */   nop
  .L800F2440:
    /* E2C40 800F2440 1380023C */  lui        $v0, %hi(Vcount)
    /* E2C44 800F2444 107D428C */  lw         $v0, %lo(Vcount)($v0)
    /* E2C48 800F2448 1380043C */  lui        $a0, %hi(D_80134A8C)
    /* E2C4C 800F244C 8C4A848C */  lw         $a0, %lo(D_80134A8C)($a0)
    /* E2C50 800F2450 1380013C */  lui        $at, %hi(D_80134A94)
    /* E2C54 800F2454 944A22AC */  sw         $v0, %lo(D_80134A94)($at)
  .L800F2458:
    /* E2C58 800F2458 0000828C */  lw         $v0, 0x0($a0)
    /* E2C5C 800F245C 1380013C */  lui        $at, %hi(Hcount)
    /* E2C60 800F2460 904A22AC */  sw         $v0, %lo(Hcount)($at)
    /* E2C64 800F2464 1380033C */  lui        $v1, %hi(Hcount)
    /* E2C68 800F2468 904A638C */  lw         $v1, %lo(Hcount)($v1)
    /* E2C6C 800F246C 0000828C */  lw         $v0, 0x0($a0)
    /* E2C70 800F2470 00000000 */  nop
    /* E2C74 800F2474 F8FF6214 */  bne        $v1, $v0, .L800F2458
    /* E2C78 800F2478 00000000 */   nop
  .L800F247C:
    /* E2C7C 800F247C 21102002 */  addu       $v0, $s1, $zero
  .L800F2480:
    /* E2C80 800F2480 2000BF8F */  lw         $ra, 0x20($sp)
    /* E2C84 800F2484 1C00B18F */  lw         $s1, 0x1C($sp)
    /* E2C88 800F2488 1800B08F */  lw         $s0, 0x18($sp)
    /* E2C8C 800F248C 0800E003 */  jr         $ra
    /* E2C90 800F2490 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel VSync
