.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

/* Handwritten function */
nonmatching blockmove, 0x31C

glabel blockmove
    /* D6ADC 800E62DC 2A088500 */  slt        $at, $a0, $a1
    /* D6AE0 800E62E0 7B002014 */  bnez       $at, .L800E64D0
  .L800E62E4:
    /* D6AE4 800E62E4 25108500 */   or        $v0, $a0, $a1
    /* D6AE8 800E62E8 03004230 */  andi       $v0, $v0, 0x3
    /* D6AEC 800E62EC 4B004014 */  bnez       $v0, .L800E641C
    /* D6AF0 800E62F0 00000000 */   nop
    /* D6AF4 800E62F4 C0FFC624 */  addiu      $a2, $a2, -0x40
    /* D6AF8 800E62F8 2500C004 */  bltz       $a2, .L800E6390
    /* D6AFC 800E62FC 00000000 */   nop
  .L800E6300:
    /* D6B00 800E6300 0000888C */  lw         $t0, 0x0($a0)
    /* D6B04 800E6304 0400898C */  lw         $t1, 0x4($a0)
    /* D6B08 800E6308 08008A8C */  lw         $t2, 0x8($a0)
    /* D6B0C 800E630C 0C008B8C */  lw         $t3, 0xC($a0)
    /* D6B10 800E6310 10008C8C */  lw         $t4, 0x10($a0)
    /* D6B14 800E6314 14008D8C */  lw         $t5, 0x14($a0)
    /* D6B18 800E6318 18008E8C */  lw         $t6, 0x18($a0)
    /* D6B1C 800E631C 1C008F8C */  lw         $t7, 0x1C($a0)
    /* D6B20 800E6320 0000A8AC */  sw         $t0, 0x0($a1)
    /* D6B24 800E6324 0400A9AC */  sw         $t1, 0x4($a1)
    /* D6B28 800E6328 0800AAAC */  sw         $t2, 0x8($a1)
    /* D6B2C 800E632C 0C00ABAC */  sw         $t3, 0xC($a1)
    /* D6B30 800E6330 1000ACAC */  sw         $t4, 0x10($a1)
    /* D6B34 800E6334 1400ADAC */  sw         $t5, 0x14($a1)
    /* D6B38 800E6338 1800AEAC */  sw         $t6, 0x18($a1)
    /* D6B3C 800E633C 1C00AFAC */  sw         $t7, 0x1C($a1)
    /* D6B40 800E6340 2000888C */  lw         $t0, 0x20($a0)
    /* D6B44 800E6344 2400898C */  lw         $t1, 0x24($a0)
    /* D6B48 800E6348 28008A8C */  lw         $t2, 0x28($a0)
    /* D6B4C 800E634C 2C008B8C */  lw         $t3, 0x2C($a0)
    /* D6B50 800E6350 30008C8C */  lw         $t4, 0x30($a0)
    /* D6B54 800E6354 34008D8C */  lw         $t5, 0x34($a0)
    /* D6B58 800E6358 38008E8C */  lw         $t6, 0x38($a0)
    /* D6B5C 800E635C 3C008F8C */  lw         $t7, 0x3C($a0)
    /* D6B60 800E6360 2000A8AC */  sw         $t0, 0x20($a1)
    /* D6B64 800E6364 2400A9AC */  sw         $t1, 0x24($a1)
    /* D6B68 800E6368 2800AAAC */  sw         $t2, 0x28($a1)
    /* D6B6C 800E636C 2C00ABAC */  sw         $t3, 0x2C($a1)
    /* D6B70 800E6370 3000ACAC */  sw         $t4, 0x30($a1)
    /* D6B74 800E6374 3400ADAC */  sw         $t5, 0x34($a1)
    /* D6B78 800E6378 3800AEAC */  sw         $t6, 0x38($a1)
    /* D6B7C 800E637C 3C00AFAC */  sw         $t7, 0x3C($a1)
    /* D6B80 800E6380 C0FFC624 */  addiu      $a2, $a2, -0x40
    /* D6B84 800E6384 40008424 */  addiu      $a0, $a0, 0x40
    /* D6B88 800E6388 DDFFC104 */  bgez       $a2, .L800E6300
    /* D6B8C 800E638C 4000A524 */   addiu     $a1, $a1, 0x40
  .L800E6390:
    /* D6B90 800E6390 3000C624 */  addiu      $a2, $a2, 0x30
    /* D6B94 800E6394 0D00C004 */  bltz       $a2, .L800E63CC
    /* D6B98 800E6398 00000000 */   nop
  .L800E639C:
    /* D6B9C 800E639C 0000888C */  lw         $t0, 0x0($a0)
    /* D6BA0 800E63A0 0400898C */  lw         $t1, 0x4($a0)
    /* D6BA4 800E63A4 08008A8C */  lw         $t2, 0x8($a0)
    /* D6BA8 800E63A8 0C008B8C */  lw         $t3, 0xC($a0)
    /* D6BAC 800E63AC 0000A8AC */  sw         $t0, 0x0($a1)
    /* D6BB0 800E63B0 0400A9AC */  sw         $t1, 0x4($a1)
    /* D6BB4 800E63B4 0800AAAC */  sw         $t2, 0x8($a1)
    /* D6BB8 800E63B8 0C00ABAC */  sw         $t3, 0xC($a1)
    /* D6BBC 800E63BC F0FFC624 */  addiu      $a2, $a2, -0x10
    /* D6BC0 800E63C0 10008424 */  addiu      $a0, $a0, 0x10
    /* D6BC4 800E63C4 F5FFC104 */  bgez       $a2, .L800E639C
    /* D6BC8 800E63C8 1000A524 */   addiu     $a1, $a1, 0x10
  .L800E63CC:
    /* D6BCC 800E63CC 0C00C624 */  addiu      $a2, $a2, 0xC
    /* D6BD0 800E63D0 0700C004 */  bltz       $a2, .L800E63F0
    /* D6BD4 800E63D4 00000000 */   nop
  .L800E63D8:
    /* D6BD8 800E63D8 0000888C */  lw         $t0, 0x0($a0)
    /* D6BDC 800E63DC FCFFC624 */  addiu      $a2, $a2, -0x4
    /* D6BE0 800E63E0 0000A8AC */  sw         $t0, 0x0($a1)
    /* D6BE4 800E63E4 04008424 */  addiu      $a0, $a0, 0x4
    /* D6BE8 800E63E8 FBFFC104 */  bgez       $a2, .L800E63D8
    /* D6BEC 800E63EC 0400A524 */   addiu     $a1, $a1, 0x4
  .L800E63F0:
    /* D6BF0 800E63F0 0300C624 */  addiu      $a2, $a2, 0x3
    /* D6BF4 800E63F4 0700C004 */  bltz       $a2, .L800E6414
    /* D6BF8 800E63F8 00000000 */   nop
  .L800E63FC:
    /* D6BFC 800E63FC 00008880 */  lb         $t0, 0x0($a0)
    /* D6C00 800E6400 FFFFC624 */  addiu      $a2, $a2, -0x1
    /* D6C04 800E6404 0000A8A0 */  sb         $t0, 0x0($a1)
    /* D6C08 800E6408 01008424 */  addiu      $a0, $a0, 0x1
    /* D6C0C 800E640C FBFFC104 */  bgez       $a2, .L800E63FC
    /* D6C10 800E6410 0100A524 */   addiu     $a1, $a1, 0x1
  .L800E6414:
    /* D6C14 800E6414 0800E003 */  jr         $ra
    /* D6C18 800E6418 00000000 */   nop
  .L800E641C:
    /* D6C1C 800E641C F0FFC624 */  addiu      $a2, $a2, -0x10
    /* D6C20 800E6420 1500C004 */  bltz       $a2, .L800E6478
    /* D6C24 800E6424 00000000 */   nop
  .L800E6428:
    /* D6C28 800E6428 03008888 */  lwl        $t0, 0x3($a0)
    /* D6C2C 800E642C 00008898 */  lwr        $t0, 0x0($a0)
    /* D6C30 800E6430 07008988 */  lwl        $t1, 0x7($a0)
    /* D6C34 800E6434 04008998 */  lwr        $t1, 0x4($a0)
    /* D6C38 800E6438 0B008A88 */  lwl        $t2, 0xB($a0)
    /* D6C3C 800E643C 08008A98 */  lwr        $t2, 0x8($a0)
    /* D6C40 800E6440 0F008B88 */  lwl        $t3, 0xF($a0)
    /* D6C44 800E6444 0C008B98 */  lwr        $t3, 0xC($a0)
    /* D6C48 800E6448 0300A8A8 */  swl        $t0, 0x3($a1)
    /* D6C4C 800E644C 0000A8B8 */  swr        $t0, 0x0($a1)
    /* D6C50 800E6450 0700A9A8 */  swl        $t1, 0x7($a1)
    /* D6C54 800E6454 0400A9B8 */  swr        $t1, 0x4($a1)
    /* D6C58 800E6458 0B00AAA8 */  swl        $t2, 0xB($a1)
    /* D6C5C 800E645C 0800AAB8 */  swr        $t2, 0x8($a1)
    /* D6C60 800E6460 0F00ABA8 */  swl        $t3, 0xF($a1)
    /* D6C64 800E6464 0C00ABB8 */  swr        $t3, 0xC($a1)
    /* D6C68 800E6468 F0FFC624 */  addiu      $a2, $a2, -0x10
    /* D6C6C 800E646C 10008424 */  addiu      $a0, $a0, 0x10
    /* D6C70 800E6470 EDFFC104 */  bgez       $a2, .L800E6428
    /* D6C74 800E6474 1000A524 */   addiu     $a1, $a1, 0x10
  .L800E6478:
    /* D6C78 800E6478 0C00C624 */  addiu      $a2, $a2, 0xC
    /* D6C7C 800E647C 0900C004 */  bltz       $a2, .L800E64A4
    /* D6C80 800E6480 00000000 */   nop
  .L800E6484:
    /* D6C84 800E6484 03008888 */  lwl        $t0, 0x3($a0)
    /* D6C88 800E6488 00008898 */  lwr        $t0, 0x0($a0)
    /* D6C8C 800E648C FCFFC624 */  addiu      $a2, $a2, -0x4
    /* D6C90 800E6490 0300A8A8 */  swl        $t0, 0x3($a1)
    /* D6C94 800E6494 0000A8B8 */  swr        $t0, 0x0($a1)
    /* D6C98 800E6498 04008424 */  addiu      $a0, $a0, 0x4
    /* D6C9C 800E649C F9FFC104 */  bgez       $a2, .L800E6484
    /* D6CA0 800E64A0 0400A524 */   addiu     $a1, $a1, 0x4
  .L800E64A4:
    /* D6CA4 800E64A4 0300C624 */  addiu      $a2, $a2, 0x3
    /* D6CA8 800E64A8 0700C004 */  bltz       $a2, .L800E64C8
    /* D6CAC 800E64AC 00000000 */   nop
  .L800E64B0:
    /* D6CB0 800E64B0 00008880 */  lb         $t0, 0x0($a0)
    /* D6CB4 800E64B4 FFFFC624 */  addiu      $a2, $a2, -0x1
    /* D6CB8 800E64B8 0000A8A0 */  sb         $t0, 0x0($a1)
    /* D6CBC 800E64BC 01008424 */  addiu      $a0, $a0, 0x1
    /* D6CC0 800E64C0 FBFFC104 */  bgez       $a2, .L800E64B0
    /* D6CC4 800E64C4 0100A524 */   addiu     $a1, $a1, 0x1
  .L800E64C8:
    /* D6CC8 800E64C8 0800E003 */  jr         $ra
    /* D6CCC 800E64CC 00000000 */   nop
  .L800E64D0:
    /* D6CD0 800E64D0 20388600 */  add        $a3, $a0, $a2 /* handwritten instruction */
    /* D6CD4 800E64D4 2A08A700 */  slt        $at, $a1, $a3
    /* D6CD8 800E64D8 82FF2010 */  beqz       $at, .L800E62E4
    /* D6CDC 800E64DC 00000000 */   nop
    /* D6CE0 800E64E0 20208600 */  add        $a0, $a0, $a2 /* handwritten instruction */
    /* D6CE4 800E64E4 2028A600 */  add        $a1, $a1, $a2 /* handwritten instruction */
    /* D6CE8 800E64E8 25108500 */  or         $v0, $a0, $a1
    /* D6CEC 800E64EC 03004230 */  andi       $v0, $v0, 0x3
    /* D6CF0 800E64F0 15004014 */  bnez       $v0, .L800E6548
    /* D6CF4 800E64F4 00000000 */   nop
    /* D6CF8 800E64F8 F0FFC624 */  addiu      $a2, $a2, -0x10
    /* D6CFC 800E64FC 0D00C004 */  bltz       $a2, .L800E6534
    /* D6D00 800E6500 00000000 */   nop
  .L800E6504:
    /* D6D04 800E6504 F0FF888C */  lw         $t0, -0x10($a0)
    /* D6D08 800E6508 F4FF898C */  lw         $t1, -0xC($a0)
    /* D6D0C 800E650C F8FF8A8C */  lw         $t2, -0x8($a0)
    /* D6D10 800E6510 FCFF8B8C */  lw         $t3, -0x4($a0)
    /* D6D14 800E6514 F0FFA8AC */  sw         $t0, -0x10($a1)
    /* D6D18 800E6518 F4FFA9AC */  sw         $t1, -0xC($a1)
    /* D6D1C 800E651C F8FFAAAC */  sw         $t2, -0x8($a1)
    /* D6D20 800E6520 FCFFABAC */  sw         $t3, -0x4($a1)
    /* D6D24 800E6524 F0FF8424 */  addiu      $a0, $a0, -0x10
    /* D6D28 800E6528 F0FFC624 */  addiu      $a2, $a2, -0x10
    /* D6D2C 800E652C F5FFC104 */  bgez       $a2, .L800E6504
    /* D6D30 800E6530 F0FFA524 */   addiu     $a1, $a1, -0x10
  .L800E6534:
    /* D6D34 800E6534 0C00C624 */  addiu      $a2, $a2, 0xC
    /* D6D38 800E6538 2500C004 */  bltz       $a2, .L800E65D0
    /* D6D3C 800E653C 00000000 */   nop
    /* D6D40 800E6540 6C990308 */  j          .L800E65B0
    /* D6D44 800E6544 00000000 */   nop
  .L800E6548:
    /* D6D48 800E6548 F0FFC624 */  addiu      $a2, $a2, -0x10
    /* D6D4C 800E654C 1500C004 */  bltz       $a2, .L800E65A4
    /* D6D50 800E6550 00000000 */   nop
  .L800E6554:
    /* D6D54 800E6554 F3FF8888 */  lwl        $t0, -0xD($a0)
    /* D6D58 800E6558 F0FF8898 */  lwr        $t0, -0x10($a0)
    /* D6D5C 800E655C F7FF8988 */  lwl        $t1, -0x9($a0)
    /* D6D60 800E6560 F4FF8998 */  lwr        $t1, -0xC($a0)
    /* D6D64 800E6564 FBFF8A88 */  lwl        $t2, -0x5($a0)
    /* D6D68 800E6568 F8FF8A98 */  lwr        $t2, -0x8($a0)
    /* D6D6C 800E656C FFFF8B88 */  lwl        $t3, -0x1($a0)
    /* D6D70 800E6570 FCFF8B98 */  lwr        $t3, -0x4($a0)
    /* D6D74 800E6574 F3FFA8A8 */  swl        $t0, -0xD($a1)
    /* D6D78 800E6578 F0FFA8B8 */  swr        $t0, -0x10($a1)
    /* D6D7C 800E657C F7FFA9A8 */  swl        $t1, -0x9($a1)
    /* D6D80 800E6580 F4FFA9B8 */  swr        $t1, -0xC($a1)
    /* D6D84 800E6584 FBFFAAA8 */  swl        $t2, -0x5($a1)
    /* D6D88 800E6588 F8FFAAB8 */  swr        $t2, -0x8($a1)
    /* D6D8C 800E658C FFFFABA8 */  swl        $t3, -0x1($a1)
    /* D6D90 800E6590 FCFFABB8 */  swr        $t3, -0x4($a1)
    /* D6D94 800E6594 F0FFC624 */  addiu      $a2, $a2, -0x10
    /* D6D98 800E6598 F0FF8424 */  addiu      $a0, $a0, -0x10
    /* D6D9C 800E659C EDFFC104 */  bgez       $a2, .L800E6554
    /* D6DA0 800E65A0 F0FFA524 */   addiu     $a1, $a1, -0x10
  .L800E65A4:
    /* D6DA4 800E65A4 0C00C624 */  addiu      $a2, $a2, 0xC
    /* D6DA8 800E65A8 0900C004 */  bltz       $a2, .L800E65D0
    /* D6DAC 800E65AC 00000000 */   nop
  .L800E65B0:
    /* D6DB0 800E65B0 FFFF8888 */  lwl        $t0, -0x1($a0)
    /* D6DB4 800E65B4 FCFF8898 */  lwr        $t0, -0x4($a0)
    /* D6DB8 800E65B8 FCFFC624 */  addiu      $a2, $a2, -0x4
    /* D6DBC 800E65BC FFFFA8A8 */  swl        $t0, -0x1($a1)
    /* D6DC0 800E65C0 FCFFA8B8 */  swr        $t0, -0x4($a1)
    /* D6DC4 800E65C4 FCFF8424 */  addiu      $a0, $a0, -0x4
    /* D6DC8 800E65C8 F9FFC104 */  bgez       $a2, .L800E65B0
    /* D6DCC 800E65CC FCFFA524 */   addiu     $a1, $a1, -0x4
  .L800E65D0:
    /* D6DD0 800E65D0 0300C624 */  addiu      $a2, $a2, 0x3
    /* D6DD4 800E65D4 0600C004 */  bltz       $a2, .L800E65F0
  .L800E65D8:
    /* D6DD8 800E65D8 FFFFC624 */   addiu     $a2, $a2, -0x1
    /* D6DDC 800E65DC FFFF8880 */  lb         $t0, -0x1($a0)
    /* D6DE0 800E65E0 FFFF8424 */  addiu      $a0, $a0, -0x1
    /* D6DE4 800E65E4 FFFFA8A0 */  sb         $t0, -0x1($a1)
    /* D6DE8 800E65E8 FBFFC104 */  bgez       $a2, .L800E65D8
    /* D6DEC 800E65EC FFFFA524 */   addiu     $a1, $a1, -0x1
  .L800E65F0:
    /* D6DF0 800E65F0 0800E003 */  jr         $ra
    /* D6DF4 800E65F4 00000000 */   nop
endlabel blockmove
