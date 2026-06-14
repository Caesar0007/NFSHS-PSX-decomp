.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDresettimbre, 0xB8

glabel iSNDresettimbre
    /* F22C4 80101AC4 21308000 */  addu       $a2, $a0, $zero
    /* F22C8 80101AC8 25000224 */  addiu      $v0, $zero, 0x25
    /* F22CC 80101ACC 9400A524 */  addiu      $a1, $a1, 0x94
  .L80101AD0:
    /* F22D0 80101AD0 0000A0AC */  sw         $zero, 0x0($a1)
    /* F22D4 80101AD4 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* F22D8 80101AD8 FDFF4104 */  bgez       $v0, .L80101AD0
    /* F22DC 80101ADC FCFFA524 */   addiu     $a1, $a1, -0x4
    /* F22E0 80101AE0 7F000424 */  addiu      $a0, $zero, 0x7F
    /* F22E4 80101AE4 FFFF0324 */  addiu      $v1, $zero, -0x1
    /* F22E8 80101AE8 3C000224 */  addiu      $v0, $zero, 0x3C
    /* F22EC 80101AEC 1400C3AC */  sw         $v1, 0x14($a2)
    /* F22F0 80101AF0 2000C3AC */  sw         $v1, 0x20($a2)
    /* F22F4 80101AF4 01000324 */  addiu      $v1, $zero, 0x1
    /* F22F8 80101AF8 1C00C2AC */  sw         $v0, 0x1C($a2)
    /* F22FC 80101AFC 40000224 */  addiu      $v0, $zero, 0x40
    /* F2300 80101B00 3000C2AC */  sw         $v0, 0x30($a2)
    /* F2304 80101B04 1380023C */  lui        $v0, %hi(snddefaultenvelope)
    /* F2308 80101B08 C4714224 */  addiu      $v0, $v0, %lo(snddefaultenvelope)
    /* F230C 80101B0C 0400C0AC */  sw         $zero, 0x4($a2)
    /* F2310 80101B10 0800C4AC */  sw         $a0, 0x8($a2)
    /* F2314 80101B14 0C00C0AC */  sw         $zero, 0xC($a2)
    /* F2318 80101B18 1000C4AC */  sw         $a0, 0x10($a2)
    /* F231C 80101B1C 1800C0AC */  sw         $zero, 0x18($a2)
    /* F2320 80101B20 2400C3AC */  sw         $v1, 0x24($a2)
    /* F2324 80101B24 2800C0AC */  sw         $zero, 0x28($a2)
    /* F2328 80101B28 2C00C3AC */  sw         $v1, 0x2C($a2)
    /* F232C 80101B2C 3400C0AC */  sw         $zero, 0x34($a2)
    /* F2330 80101B30 3800C4AC */  sw         $a0, 0x38($a2)
    /* F2334 80101B34 3C00C0AC */  sw         $zero, 0x3C($a2)
    /* F2338 80101B38 4000C0AC */  sw         $zero, 0x40($a2)
    /* F233C 80101B3C 4400C0AC */  sw         $zero, 0x44($a2)
    /* F2340 80101B40 4800C0AC */  sw         $zero, 0x48($a2)
    /* F2344 80101B44 4C00C0AC */  sw         $zero, 0x4C($a2)
    /* F2348 80101B48 5400C0AC */  sw         $zero, 0x54($a2)
    /* F234C 80101B4C 5C00C0AC */  sw         $zero, 0x5C($a2)
    /* F2350 80101B50 7000C4AC */  sw         $a0, 0x70($a2)
    /* F2354 80101B54 7400C0AC */  sw         $zero, 0x74($a2)
    /* F2358 80101B58 7800C0AC */  sw         $zero, 0x78($a2)
    /* F235C 80101B5C 7C00C0AC */  sw         $zero, 0x7C($a2)
    /* F2360 80101B60 8000C0AC */  sw         $zero, 0x80($a2)
    /* F2364 80101B64 8400C0AC */  sw         $zero, 0x84($a2)
    /* F2368 80101B68 8C00C0AC */  sw         $zero, 0x8C($a2)
    /* F236C 80101B6C 8800C0AC */  sw         $zero, 0x88($a2)
    /* F2370 80101B70 9400C3AC */  sw         $v1, 0x94($a2)
    /* F2374 80101B74 0800E003 */  jr         $ra
    /* F2378 80101B78 6400C2AC */   sw        $v0, 0x64($a2)
endlabel iSNDresettimbre
