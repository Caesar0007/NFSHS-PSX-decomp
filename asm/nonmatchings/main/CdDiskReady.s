.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CdDiskReady, 0x13C

glabel CdDiskReady
    /* D8C48 800E8448 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* D8C4C 800E844C 1800B0AF */  sw         $s0, 0x18($sp)
    /* D8C50 800E8450 21808000 */  addu       $s0, $a0, $zero
    /* D8C54 800E8454 01000424 */  addiu      $a0, $zero, 0x1
    /* D8C58 800E8458 21280000 */  addu       $a1, $zero, $zero
    /* D8C5C 800E845C 1000A627 */  addiu      $a2, $sp, 0x10
    /* D8C60 800E8460 2000BFAF */  sw         $ra, 0x20($sp)
    /* D8C64 800E8464 C9DE030C */  jal        CdControlB
    /* D8C68 800E8468 1C00B1AF */   sw        $s1, 0x1C($sp)
    /* D8C6C 800E846C 1000A293 */  lbu        $v0, 0x10($sp)
    /* D8C70 800E8470 00000000 */  nop
    /* D8C74 800E8474 10004230 */  andi       $v0, $v0, 0x10
    /* D8C78 800E8478 03004010 */  beqz       $v0, .L800E8488
    /* D8C7C 800E847C 13000424 */   addiu     $a0, $zero, 0x13
  .L800E8480:
    /* D8C80 800E8480 5CA10308 */  j          .L800E8570
    /* D8C84 800E8484 10000224 */   addiu     $v0, $zero, 0x10
  .L800E8488:
    /* D8C88 800E8488 21280000 */  addu       $a1, $zero, $zero
    /* D8C8C 800E848C C9DE030C */  jal        CdControlB
    /* D8C90 800E8490 1000A627 */   addiu     $a2, $sp, 0x10
    /* D8C94 800E8494 21204000 */  addu       $a0, $v0, $zero
    /* D8C98 800E8498 01000224 */  addiu      $v0, $zero, 0x1
    /* D8C9C 800E849C 09000216 */  bne        $s0, $v0, .L800E84C4
    /* D8CA0 800E84A0 02001124 */   addiu     $s1, $zero, 0x2
    /* D8CA4 800E84A4 1000A393 */  lbu        $v1, 0x10($sp)
    /* D8CA8 800E84A8 02000224 */  addiu      $v0, $zero, 0x2
    /* D8CAC 800E84AC 2F006214 */  bne        $v1, $v0, .L800E856C
    /* D8CB0 800E84B0 00000000 */   nop
    /* D8CB4 800E84B4 2E008014 */  bnez       $a0, .L800E8570
    /* D8CB8 800E84B8 00000000 */   nop
    /* D8CBC 800E84BC 5CA10308 */  j          .L800E8570
    /* D8CC0 800E84C0 05000224 */   addiu     $v0, $zero, 0x5
  .L800E84C4:
    /* D8CC4 800E84C4 21800000 */  addu       $s0, $zero, $zero
  .L800E84C8:
    /* D8CC8 800E84C8 1000A393 */  lbu        $v1, 0x10($sp)
    /* D8CCC 800E84CC 00000000 */  nop
    /* D8CD0 800E84D0 02006230 */  andi       $v0, $v1, 0x2
    /* D8CD4 800E84D4 16004010 */  beqz       $v0, .L800E8530
    /* D8CD8 800E84D8 00000000 */   nop
    /* D8CDC 800E84DC 03007114 */  bne        $v1, $s1, .L800E84EC
    /* D8CE0 800E84E0 00000000 */   nop
    /* D8CE4 800E84E4 22008014 */  bnez       $a0, .L800E8570
    /* D8CE8 800E84E8 02000224 */   addiu     $v0, $zero, 0x2
  .L800E84EC:
    /* D8CEC 800E84EC C7C8030C */  jal        VSync
    /* D8CF0 800E84F0 1E000424 */   addiu     $a0, $zero, 0x1E
    /* D8CF4 800E84F4 13000424 */  addiu      $a0, $zero, 0x13
    /* D8CF8 800E84F8 21280000 */  addu       $a1, $zero, $zero
    /* D8CFC 800E84FC C9DE030C */  jal        CdControlB
    /* D8D00 800E8500 1000A627 */   addiu     $a2, $sp, 0x10
    /* D8D04 800E8504 1000A393 */  lbu        $v1, 0x10($sp)
    /* D8D08 800E8508 21204000 */  addu       $a0, $v0, $zero
    /* D8D0C 800E850C 10006230 */  andi       $v0, $v1, 0x10
    /* D8D10 800E8510 DBFF4014 */  bnez       $v0, .L800E8480
    /* D8D14 800E8514 00000000 */   nop
    /* D8D18 800E8518 F4FF7114 */  bne        $v1, $s1, .L800E84EC
    /* D8D1C 800E851C 00000000 */   nop
    /* D8D20 800E8520 F2FF8010 */  beqz       $a0, .L800E84EC
    /* D8D24 800E8524 02000224 */   addiu     $v0, $zero, 0x2
    /* D8D28 800E8528 5CA10308 */  j          .L800E8570
    /* D8D2C 800E852C 00000000 */   nop
  .L800E8530:
    /* D8D30 800E8530 C7C8030C */  jal        VSync
    /* D8D34 800E8534 1E000424 */   addiu     $a0, $zero, 0x1E
    /* D8D38 800E8538 13000424 */  addiu      $a0, $zero, 0x13
    /* D8D3C 800E853C 21280000 */  addu       $a1, $zero, $zero
    /* D8D40 800E8540 C9DE030C */  jal        CdControlB
    /* D8D44 800E8544 1000A627 */   addiu     $a2, $sp, 0x10
    /* D8D48 800E8548 1000A393 */  lbu        $v1, 0x10($sp)
    /* D8D4C 800E854C 00000000 */  nop
    /* D8D50 800E8550 10006330 */  andi       $v1, $v1, 0x10
    /* D8D54 800E8554 CAFF6014 */  bnez       $v1, .L800E8480
    /* D8D58 800E8558 21204000 */   addu      $a0, $v0, $zero
    /* D8D5C 800E855C 01001026 */  addiu      $s0, $s0, 0x1
    /* D8D60 800E8560 0A00022A */  slti       $v0, $s0, 0xA
    /* D8D64 800E8564 D8FF4014 */  bnez       $v0, .L800E84C8
    /* D8D68 800E8568 00000000 */   nop
  .L800E856C:
    /* D8D6C 800E856C 05000224 */  addiu      $v0, $zero, 0x5
  .L800E8570:
    /* D8D70 800E8570 2000BF8F */  lw         $ra, 0x20($sp)
    /* D8D74 800E8574 1C00B18F */  lw         $s1, 0x1C($sp)
    /* D8D78 800E8578 1800B08F */  lw         $s0, 0x18($sp)
    /* D8D7C 800E857C 0800E003 */  jr         $ra
    /* D8D80 800E8580 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel CdDiskReady
