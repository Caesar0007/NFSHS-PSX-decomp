.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Newton_CalculateGroundShadowMatrix__FP13BO_tNewtonObjP8coorddefi, 0x374

glabel Newton_CalculateGroundShadowMatrix__FP13BO_tNewtonObjP8coorddefi
    /* 92B18 800A2318 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 92B1C 800A231C 1400B1AF */  sw         $s1, 0x14($sp)
    /* 92B20 800A2320 21888000 */  addu       $s1, $a0, $zero
    /* 92B24 800A2324 1800BFAF */  sw         $ra, 0x18($sp)
    /* 92B28 800A2328 1000B0AF */  sw         $s0, 0x10($sp)
    /* 92B2C 800A232C 6002228E */  lw         $v0, 0x260($s1)
    /* 92B30 800A2330 00000000 */  nop
    /* 92B34 800A2334 04004230 */  andi       $v0, $v0, 0x4
    /* 92B38 800A2338 1B004014 */  bnez       $v0, .L800A23A8
    /* 92B3C 800A233C 66E60234 */   ori       $v0, $zero, 0xE666
    /* 92B40 800A2340 2A104600 */  slt        $v0, $v0, $a2
    /* 92B44 800A2344 18004010 */  beqz       $v0, .L800A23A8
    /* 92B48 800A2348 C4012326 */   addiu     $v1, $s1, 0x1C4
    /* 92B4C 800A234C F0002226 */  addiu      $v0, $s1, 0xF0
    /* 92B50 800A2350 10012426 */  addiu      $a0, $s1, 0x110
  .L800A2354:
    /* 92B54 800A2354 0000488C */  lw         $t0, 0x0($v0)
    /* 92B58 800A2358 0400498C */  lw         $t1, 0x4($v0)
    /* 92B5C 800A235C 08004A8C */  lw         $t2, 0x8($v0)
    /* 92B60 800A2360 0C004B8C */  lw         $t3, 0xC($v0)
    /* 92B64 800A2364 000068AC */  sw         $t0, 0x0($v1)
    /* 92B68 800A2368 040069AC */  sw         $t1, 0x4($v1)
    /* 92B6C 800A236C 08006AAC */  sw         $t2, 0x8($v1)
    /* 92B70 800A2370 0C006BAC */  sw         $t3, 0xC($v1)
    /* 92B74 800A2374 10004224 */  addiu      $v0, $v0, 0x10
    /* 92B78 800A2378 F6FF4414 */  bne        $v0, $a0, .L800A2354
    /* 92B7C 800A237C 10006324 */   addiu     $v1, $v1, 0x10
    /* 92B80 800A2380 0000488C */  lw         $t0, 0x0($v0)
    /* 92B84 800A2384 00000000 */  nop
    /* 92B88 800A2388 000068AC */  sw         $t0, 0x0($v1)
    /* 92B8C 800A238C 0000A28C */  lw         $v0, 0x0($a1)
    /* 92B90 800A2390 0400A38C */  lw         $v1, 0x4($a1)
    /* 92B94 800A2394 0800A48C */  lw         $a0, 0x8($a1)
    /* 92B98 800A2398 D00122AE */  sw         $v0, 0x1D0($s1)
    /* 92B9C 800A239C D40123AE */  sw         $v1, 0x1D4($s1)
    /* 92BA0 800A23A0 9E890208 */  j          .L800A2678
    /* 92BA4 800A23A4 D80124AE */   sw        $a0, 0x1D8($s1)
  .L800A23A8:
    /* 92BA8 800A23A8 0000A28C */  lw         $v0, 0x0($a1)
    /* 92BAC 800A23AC 0400A38C */  lw         $v1, 0x4($a1)
    /* 92BB0 800A23B0 0800A48C */  lw         $a0, 0x8($a1)
    /* 92BB4 800A23B4 D00122AE */  sw         $v0, 0x1D0($s1)
    /* 92BB8 800A23B8 FF7F0224 */  addiu      $v0, $zero, 0x7FFF
    /* 92BBC 800A23BC 2A104600 */  slt        $v0, $v0, $a2
    /* 92BC0 800A23C0 D40123AE */  sw         $v1, 0x1D4($s1)
    /* 92BC4 800A23C4 6F004014 */  bnez       $v0, .L800A2584
    /* 92BC8 800A23C8 D80124AE */   sw        $a0, 0x1D8($s1)
    /* 92BCC 800A23CC F000238E */  lw         $v1, 0xF0($s1)
    /* 92BD0 800A23D0 00000000 */  nop
    /* 92BD4 800A23D4 02006104 */  bgez       $v1, .L800A23E0
    /* 92BD8 800A23D8 00000000 */   nop
    /* 92BDC 800A23DC FF006324 */  addiu      $v1, $v1, 0xFF
  .L800A23E0:
    /* 92BE0 800A23E0 0000A28C */  lw         $v0, 0x0($a1)
    /* 92BE4 800A23E4 00000000 */  nop
    /* 92BE8 800A23E8 02004104 */  bgez       $v0, .L800A23F4
    /* 92BEC 800A23EC 03220300 */   sra       $a0, $v1, 8
    /* 92BF0 800A23F0 FF004224 */  addiu      $v0, $v0, 0xFF
  .L800A23F4:
    /* 92BF4 800A23F4 03120200 */  sra        $v0, $v0, 8
    /* 92BF8 800A23F8 18008200 */  mult       $a0, $v0
    /* 92BFC 800A23FC F400238E */  lw         $v1, 0xF4($s1)
    /* 92C00 800A2400 12200000 */  mflo       $a0
    /* 92C04 800A2404 02006104 */  bgez       $v1, .L800A2410
    /* 92C08 800A2408 00000000 */   nop
    /* 92C0C 800A240C FF006324 */  addiu      $v1, $v1, 0xFF
  .L800A2410:
    /* 92C10 800A2410 0400A28C */  lw         $v0, 0x4($a1)
    /* 92C14 800A2414 00000000 */  nop
    /* 92C18 800A2418 02004104 */  bgez       $v0, .L800A2424
    /* 92C1C 800A241C 031A0300 */   sra       $v1, $v1, 8
    /* 92C20 800A2420 FF004224 */  addiu      $v0, $v0, 0xFF
  .L800A2424:
    /* 92C24 800A2424 03120200 */  sra        $v0, $v0, 8
    /* 92C28 800A2428 18006200 */  mult       $v1, $v0
    /* 92C2C 800A242C F800238E */  lw         $v1, 0xF8($s1)
    /* 92C30 800A2430 12400000 */  mflo       $t0
    /* 92C34 800A2434 02006104 */  bgez       $v1, .L800A2440
    /* 92C38 800A2438 21208800 */   addu      $a0, $a0, $t0
    /* 92C3C 800A243C FF006324 */  addiu      $v1, $v1, 0xFF
  .L800A2440:
    /* 92C40 800A2440 0800A28C */  lw         $v0, 0x8($a1)
    /* 92C44 800A2444 00000000 */  nop
    /* 92C48 800A2448 02004104 */  bgez       $v0, .L800A2454
    /* 92C4C 800A244C 031A0300 */   sra       $v1, $v1, 8
    /* 92C50 800A2450 FF004224 */  addiu      $v0, $v0, 0xFF
  .L800A2454:
    /* 92C54 800A2454 03120200 */  sra        $v0, $v0, 8
    /* 92C58 800A2458 18006200 */  mult       $v1, $v0
    /* 92C5C 800A245C 12400000 */  mflo       $t0
    /* 92C60 800A2460 21208800 */  addu       $a0, $a0, $t0
    /* 92C64 800A2464 02008104 */  bgez       $a0, .L800A2470
    /* 92C68 800A2468 00000000 */   nop
    /* 92C6C 800A246C 23200400 */  negu       $a0, $a0
  .L800A2470:
    /* 92C70 800A2470 F9AD030C */  jal        __floatsidf
    /* 92C74 800A2474 00000000 */   nop
    /* 92C78 800A2478 00000624 */  addiu      $a2, $zero, 0x0
    /* 92C7C 800A247C E03F073C */  lui        $a3, (0x3FE00000 >> 16)
    /* 92C80 800A2480 21204000 */  addu       $a0, $v0, $zero
    /* 92C84 800A2484 45C1030C */  jal        __gtdf2
    /* 92C88 800A2488 21286000 */   addu      $a1, $v1, $zero
    /* 92C8C 800A248C 3D004018 */  blez       $v0, .L800A2584
    /* 92C90 800A2490 00000000 */   nop
    /* 92C94 800A2494 D401248E */  lw         $a0, 0x1D4($s1)
    /* 92C98 800A2498 1001258E */  lw         $a1, 0x110($s1)
    /* 92C9C 800A249C CA90030C */  jal        fixedmult
    /* 92CA0 800A24A0 00000000 */   nop
    /* 92CA4 800A24A4 D801248E */  lw         $a0, 0x1D8($s1)
    /* 92CA8 800A24A8 0C01258E */  lw         $a1, 0x10C($s1)
    /* 92CAC 800A24AC CA90030C */  jal        fixedmult
    /* 92CB0 800A24B0 21804000 */   addu      $s0, $v0, $zero
    /* 92CB4 800A24B4 D801248E */  lw         $a0, 0x1D8($s1)
    /* 92CB8 800A24B8 0801258E */  lw         $a1, 0x108($s1)
    /* 92CBC 800A24BC 23800202 */  subu       $s0, $s0, $v0
    /* 92CC0 800A24C0 CA90030C */  jal        fixedmult
    /* 92CC4 800A24C4 C40130AE */   sw        $s0, 0x1C4($s1)
    /* 92CC8 800A24C8 D001248E */  lw         $a0, 0x1D0($s1)
    /* 92CCC 800A24CC 1001258E */  lw         $a1, 0x110($s1)
    /* 92CD0 800A24D0 CA90030C */  jal        fixedmult
    /* 92CD4 800A24D4 21804000 */   addu      $s0, $v0, $zero
    /* 92CD8 800A24D8 D001248E */  lw         $a0, 0x1D0($s1)
    /* 92CDC 800A24DC 0C01258E */  lw         $a1, 0x10C($s1)
    /* 92CE0 800A24E0 23800202 */  subu       $s0, $s0, $v0
    /* 92CE4 800A24E4 CA90030C */  jal        fixedmult
    /* 92CE8 800A24E8 C80130AE */   sw        $s0, 0x1C8($s1)
    /* 92CEC 800A24EC D401248E */  lw         $a0, 0x1D4($s1)
    /* 92CF0 800A24F0 0801258E */  lw         $a1, 0x108($s1)
    /* 92CF4 800A24F4 CA90030C */  jal        fixedmult
    /* 92CF8 800A24F8 21804000 */   addu      $s0, $v0, $zero
    /* 92CFC 800A24FC C4012426 */  addiu      $a0, $s1, 0x1C4
    /* 92D00 800A2500 23800202 */  subu       $s0, $s0, $v0
    /* 92D04 800A2504 F576020C */  jal        Math_NormalizeShortVector__FP8coorddef
    /* 92D08 800A2508 CC0130AE */   sw        $s0, 0x1CC($s1)
    /* 92D0C 800A250C C801248E */  lw         $a0, 0x1C8($s1)
    /* 92D10 800A2510 D801258E */  lw         $a1, 0x1D8($s1)
    /* 92D14 800A2514 CA90030C */  jal        fixedmult
    /* 92D18 800A2518 00000000 */   nop
    /* 92D1C 800A251C CC01248E */  lw         $a0, 0x1CC($s1)
    /* 92D20 800A2520 D401258E */  lw         $a1, 0x1D4($s1)
    /* 92D24 800A2524 CA90030C */  jal        fixedmult
    /* 92D28 800A2528 21804000 */   addu      $s0, $v0, $zero
    /* 92D2C 800A252C CC01248E */  lw         $a0, 0x1CC($s1)
    /* 92D30 800A2530 D001258E */  lw         $a1, 0x1D0($s1)
    /* 92D34 800A2534 23800202 */  subu       $s0, $s0, $v0
    /* 92D38 800A2538 CA90030C */  jal        fixedmult
    /* 92D3C 800A253C DC0130AE */   sw        $s0, 0x1DC($s1)
    /* 92D40 800A2540 C401248E */  lw         $a0, 0x1C4($s1)
    /* 92D44 800A2544 D801258E */  lw         $a1, 0x1D8($s1)
    /* 92D48 800A2548 CA90030C */  jal        fixedmult
    /* 92D4C 800A254C 21804000 */   addu      $s0, $v0, $zero
    /* 92D50 800A2550 C401248E */  lw         $a0, 0x1C4($s1)
    /* 92D54 800A2554 D401258E */  lw         $a1, 0x1D4($s1)
    /* 92D58 800A2558 23800202 */  subu       $s0, $s0, $v0
    /* 92D5C 800A255C CA90030C */  jal        fixedmult
    /* 92D60 800A2560 E00130AE */   sw        $s0, 0x1E0($s1)
    /* 92D64 800A2564 C801248E */  lw         $a0, 0x1C8($s1)
    /* 92D68 800A2568 D001258E */  lw         $a1, 0x1D0($s1)
    /* 92D6C 800A256C CA90030C */  jal        fixedmult
    /* 92D70 800A2570 21804000 */   addu      $s0, $v0, $zero
    /* 92D74 800A2574 DC012426 */  addiu      $a0, $s1, 0x1DC
    /* 92D78 800A2578 23800202 */  subu       $s0, $s0, $v0
    /* 92D7C 800A257C 9C890208 */  j          .L800A2670
    /* 92D80 800A2580 E40130AE */   sw        $s0, 0x1E4($s1)
  .L800A2584:
    /* 92D84 800A2584 F400248E */  lw         $a0, 0xF4($s1)
    /* 92D88 800A2588 D801258E */  lw         $a1, 0x1D8($s1)
    /* 92D8C 800A258C CA90030C */  jal        fixedmult
    /* 92D90 800A2590 00000000 */   nop
    /* 92D94 800A2594 F800248E */  lw         $a0, 0xF8($s1)
    /* 92D98 800A2598 D401258E */  lw         $a1, 0x1D4($s1)
    /* 92D9C 800A259C CA90030C */  jal        fixedmult
    /* 92DA0 800A25A0 21804000 */   addu      $s0, $v0, $zero
    /* 92DA4 800A25A4 F800248E */  lw         $a0, 0xF8($s1)
    /* 92DA8 800A25A8 D001258E */  lw         $a1, 0x1D0($s1)
    /* 92DAC 800A25AC 23800202 */  subu       $s0, $s0, $v0
    /* 92DB0 800A25B0 CA90030C */  jal        fixedmult
    /* 92DB4 800A25B4 DC0130AE */   sw        $s0, 0x1DC($s1)
    /* 92DB8 800A25B8 F000248E */  lw         $a0, 0xF0($s1)
    /* 92DBC 800A25BC D801258E */  lw         $a1, 0x1D8($s1)
    /* 92DC0 800A25C0 CA90030C */  jal        fixedmult
    /* 92DC4 800A25C4 21804000 */   addu      $s0, $v0, $zero
    /* 92DC8 800A25C8 F000248E */  lw         $a0, 0xF0($s1)
    /* 92DCC 800A25CC D401258E */  lw         $a1, 0x1D4($s1)
    /* 92DD0 800A25D0 23800202 */  subu       $s0, $s0, $v0
    /* 92DD4 800A25D4 CA90030C */  jal        fixedmult
    /* 92DD8 800A25D8 E00130AE */   sw        $s0, 0x1E0($s1)
    /* 92DDC 800A25DC F400248E */  lw         $a0, 0xF4($s1)
    /* 92DE0 800A25E0 D001258E */  lw         $a1, 0x1D0($s1)
    /* 92DE4 800A25E4 CA90030C */  jal        fixedmult
    /* 92DE8 800A25E8 21804000 */   addu      $s0, $v0, $zero
    /* 92DEC 800A25EC DC012426 */  addiu      $a0, $s1, 0x1DC
    /* 92DF0 800A25F0 23800202 */  subu       $s0, $s0, $v0
    /* 92DF4 800A25F4 F576020C */  jal        Math_NormalizeShortVector__FP8coorddef
    /* 92DF8 800A25F8 E40130AE */   sw        $s0, 0x1E4($s1)
    /* 92DFC 800A25FC D401248E */  lw         $a0, 0x1D4($s1)
    /* 92E00 800A2600 E401258E */  lw         $a1, 0x1E4($s1)
    /* 92E04 800A2604 CA90030C */  jal        fixedmult
    /* 92E08 800A2608 00000000 */   nop
    /* 92E0C 800A260C D801248E */  lw         $a0, 0x1D8($s1)
    /* 92E10 800A2610 E001258E */  lw         $a1, 0x1E0($s1)
    /* 92E14 800A2614 CA90030C */  jal        fixedmult
    /* 92E18 800A2618 21804000 */   addu      $s0, $v0, $zero
    /* 92E1C 800A261C D801248E */  lw         $a0, 0x1D8($s1)
    /* 92E20 800A2620 DC01258E */  lw         $a1, 0x1DC($s1)
    /* 92E24 800A2624 23800202 */  subu       $s0, $s0, $v0
    /* 92E28 800A2628 CA90030C */  jal        fixedmult
    /* 92E2C 800A262C C40130AE */   sw        $s0, 0x1C4($s1)
    /* 92E30 800A2630 D001248E */  lw         $a0, 0x1D0($s1)
    /* 92E34 800A2634 E401258E */  lw         $a1, 0x1E4($s1)
    /* 92E38 800A2638 CA90030C */  jal        fixedmult
    /* 92E3C 800A263C 21804000 */   addu      $s0, $v0, $zero
    /* 92E40 800A2640 D001248E */  lw         $a0, 0x1D0($s1)
    /* 92E44 800A2644 E001258E */  lw         $a1, 0x1E0($s1)
    /* 92E48 800A2648 23800202 */  subu       $s0, $s0, $v0
    /* 92E4C 800A264C CA90030C */  jal        fixedmult
    /* 92E50 800A2650 C80130AE */   sw        $s0, 0x1C8($s1)
    /* 92E54 800A2654 D401248E */  lw         $a0, 0x1D4($s1)
    /* 92E58 800A2658 DC01258E */  lw         $a1, 0x1DC($s1)
    /* 92E5C 800A265C CA90030C */  jal        fixedmult
    /* 92E60 800A2660 21804000 */   addu      $s0, $v0, $zero
    /* 92E64 800A2664 C4012426 */  addiu      $a0, $s1, 0x1C4
    /* 92E68 800A2668 23800202 */  subu       $s0, $s0, $v0
    /* 92E6C 800A266C CC0130AE */  sw         $s0, 0x1CC($s1)
  .L800A2670:
    /* 92E70 800A2670 F576020C */  jal        Math_NormalizeShortVector__FP8coorddef
    /* 92E74 800A2674 00000000 */   nop
  .L800A2678:
    /* 92E78 800A2678 1800BF8F */  lw         $ra, 0x18($sp)
    /* 92E7C 800A267C 1400B18F */  lw         $s1, 0x14($sp)
    /* 92E80 800A2680 1000B08F */  lw         $s0, 0x10($sp)
    /* 92E84 800A2684 0800E003 */  jr         $ra
    /* 92E88 800A2688 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Newton_CalculateGroundShadowMatrix__FP13BO_tNewtonObjP8coorddefi
