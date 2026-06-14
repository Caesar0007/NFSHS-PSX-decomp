.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Replay_GetInput__Fi, 0x460

glabel Replay_GetInput__Fi
    /* A5338 800B4B38 60FFBD27 */  addiu      $sp, $sp, -0xA0
    /* A533C 800B4B3C 9400B1AF */  sw         $s1, 0x94($sp)
    /* A5340 800B4B40 21888000 */  addu       $s1, $a0, $zero
    /* A5344 800B4B44 9800BFAF */  sw         $ra, 0x98($sp)
    /* A5348 800B4B48 A574020C */  jal        Input_Fetch__Fi
    /* A534C 800B4B4C 9000B0AF */   sw        $s0, 0x90($sp)
    /* A5350 800B4B50 80101100 */  sll        $v0, $s1, 2
    /* A5354 800B4B54 1480033C */  lui        $v1, %hi(Replay_ReplayCounter)
    /* A5358 800B4B58 00D46324 */  addiu      $v1, $v1, %lo(Replay_ReplayCounter)
    /* A535C 800B4B5C 21104300 */  addu       $v0, $v0, $v1
    /* A5360 800B4B60 0000428C */  lw         $v0, 0x0($v0)
    /* A5364 800B4B64 00000000 */  nop
    /* A5368 800B4B68 36004014 */  bnez       $v0, .L800B4C44
    /* A536C 800B4B6C 1180023C */   lui       $v0, %hi(Replay_ReplayBuffer)
    /* A5370 800B4B70 B00E838F */  lw         $v1, %gp_rel(Replay_ReplayGetPtr)($gp)
    /* A5374 800B4B74 6C714224 */  addiu      $v0, $v0, %lo(Replay_ReplayBuffer)
    /* A5378 800B4B78 21186200 */  addu       $v1, $v1, $v0
    /* A537C 800B4B7C 2C0A6290 */  lbu        $v0, 0xA2C($v1)
    /* A5380 800B4B80 00000000 */  nop
    /* A5384 800B4B84 05004014 */  bnez       $v0, .L800B4B9C
    /* A5388 800B4B88 1000A427 */   addiu     $a0, $sp, 0x10
    /* A538C 800B4B8C 03000224 */  addiu      $v0, $zero, 0x3
    /* A5390 800B4B90 A80E82AF */  sw         $v0, %gp_rel(Replay_ReplayMode)($gp)
    /* A5394 800B4B94 11D30208 */  j          .L800B4C44
    /* A5398 800B4B98 00000000 */   nop
  .L800B4B9C:
    /* A539C 800B4B9C 1180023C */  lui        $v0, %hi(controlData)
    /* A53A0 800B4BA0 6C704224 */  addiu      $v0, $v0, %lo(controlData)
    /* A53A4 800B4BA4 C0811100 */  sll        $s0, $s1, 7
    /* A53A8 800B4BA8 22D1020C */  jal        Replay_RetreivingControllerData__Fv
    /* A53AC 800B4BAC 21800202 */   addu      $s0, $s0, $v0
    /* A53B0 800B4BB0 03000232 */  andi       $v0, $s0, 0x3
    /* A53B4 800B4BB4 17004010 */  beqz       $v0, .L800B4C14
    /* A53B8 800B4BB8 1000A327 */   addiu     $v1, $sp, 0x10
    /* A53BC 800B4BBC 9000A227 */  addiu      $v0, $sp, 0x90
  .L800B4BC0:
    /* A53C0 800B4BC0 03006788 */  lwl        $a3, 0x3($v1)
    /* A53C4 800B4BC4 00006798 */  lwr        $a3, 0x0($v1)
    /* A53C8 800B4BC8 07006888 */  lwl        $t0, 0x7($v1)
    /* A53CC 800B4BCC 04006898 */  lwr        $t0, 0x4($v1)
    /* A53D0 800B4BD0 0B006988 */  lwl        $t1, 0xB($v1)
    /* A53D4 800B4BD4 08006998 */  lwr        $t1, 0x8($v1)
    /* A53D8 800B4BD8 0F006A88 */  lwl        $t2, 0xF($v1)
    /* A53DC 800B4BDC 0C006A98 */  lwr        $t2, 0xC($v1)
    /* A53E0 800B4BE0 030007AA */  swl        $a3, 0x3($s0)
    /* A53E4 800B4BE4 000007BA */  swr        $a3, 0x0($s0)
    /* A53E8 800B4BE8 070008AA */  swl        $t0, 0x7($s0)
    /* A53EC 800B4BEC 040008BA */  swr        $t0, 0x4($s0)
    /* A53F0 800B4BF0 0B0009AA */  swl        $t1, 0xB($s0)
    /* A53F4 800B4BF4 080009BA */  swr        $t1, 0x8($s0)
    /* A53F8 800B4BF8 0F000AAA */  swl        $t2, 0xF($s0)
    /* A53FC 800B4BFC 0C000ABA */  swr        $t2, 0xC($s0)
    /* A5400 800B4C00 10006324 */  addiu      $v1, $v1, 0x10
    /* A5404 800B4C04 EEFF6214 */  bne        $v1, $v0, .L800B4BC0
    /* A5408 800B4C08 10001026 */   addiu     $s0, $s0, 0x10
    /* A540C 800B4C0C 11D30208 */  j          .L800B4C44
    /* A5410 800B4C10 00000000 */   nop
  .L800B4C14:
    /* A5414 800B4C14 9000A227 */  addiu      $v0, $sp, 0x90
  .L800B4C18:
    /* A5418 800B4C18 0000678C */  lw         $a3, 0x0($v1)
    /* A541C 800B4C1C 0400688C */  lw         $t0, 0x4($v1)
    /* A5420 800B4C20 0800698C */  lw         $t1, 0x8($v1)
    /* A5424 800B4C24 0C006A8C */  lw         $t2, 0xC($v1)
    /* A5428 800B4C28 000007AE */  sw         $a3, 0x0($s0)
    /* A542C 800B4C2C 040008AE */  sw         $t0, 0x4($s0)
    /* A5430 800B4C30 080009AE */  sw         $t1, 0x8($s0)
    /* A5434 800B4C34 0C000AAE */  sw         $t2, 0xC($s0)
    /* A5438 800B4C38 10006324 */  addiu      $v1, $v1, 0x10
    /* A543C 800B4C3C F6FF6214 */  bne        $v1, $v0, .L800B4C18
    /* A5440 800B4C40 10001026 */   addiu     $s0, $s0, 0x10
  .L800B4C44:
    /* A5444 800B4C44 A80E838F */  lw         $v1, %gp_rel(Replay_ReplayMode)($gp)
    /* A5448 800B4C48 02000224 */  addiu      $v0, $zero, 0x2
    /* A544C 800B4C4C 9D006214 */  bne        $v1, $v0, .L800B4EC4
    /* A5450 800B4C50 1180043C */   lui       $a0, %hi(controlData)
    /* A5454 800B4C54 6C708424 */  addiu      $a0, $a0, %lo(controlData)
    /* A5458 800B4C58 04285100 */  sllv       $a1, $s1, $v0
    /* A545C 800B4C5C 1480023C */  lui        $v0, %hi(Replay_ReplayCounter)
    /* A5460 800B4C60 00D44224 */  addiu      $v0, $v0, %lo(Replay_ReplayCounter)
    /* A5464 800B4C64 2110A200 */  addu       $v0, $a1, $v0
    /* A5468 800B4C68 0000428C */  lw         $v0, 0x0($v0)
    /* A546C 800B4C6C C0191100 */  sll        $v1, $s1, 7
    /* A5470 800B4C70 21104300 */  addu       $v0, $v0, $v1
    /* A5474 800B4C74 21104400 */  addu       $v0, $v0, $a0
    /* A5478 800B4C78 00004280 */  lb         $v0, 0x0($v0)
    /* A547C 800B4C7C 00000000 */  nop
    /* A5480 800B4C80 80004230 */  andi       $v0, $v0, 0x80
    /* A5484 800B4C84 09004010 */  beqz       $v0, .L800B4CAC
    /* A5488 800B4C88 1180023C */   lui       $v0, %hi(Cars_gHumanRaceCarList)
    /* A548C 800B4C8C 48FA4224 */  addiu      $v0, $v0, %lo(Cars_gHumanRaceCarList)
    /* A5490 800B4C90 2110A200 */  addu       $v0, $a1, $v0
    /* A5494 800B4C94 0000428C */  lw         $v0, 0x0($v0)
    /* A5498 800B4C98 00000000 */  nop
    /* A549C 800B4C9C 8802438C */  lw         $v1, 0x288($v0)
    /* A54A0 800B4CA0 01000224 */  addiu      $v0, $zero, 0x1
    /* A54A4 800B4CA4 32D30208 */  j          .L800B4CC8
    /* A54A8 800B4CA8 180062AC */   sw        $v0, 0x18($v1)
  .L800B4CAC:
    /* A54AC 800B4CAC 48FA4224 */  addiu      $v0, $v0, %lo(Cars_gHumanRaceCarList)
    /* A54B0 800B4CB0 2110A200 */  addu       $v0, $a1, $v0
    /* A54B4 800B4CB4 0000428C */  lw         $v0, 0x0($v0)
    /* A54B8 800B4CB8 00000000 */  nop
    /* A54BC 800B4CBC 8802428C */  lw         $v0, 0x288($v0)
    /* A54C0 800B4CC0 00000000 */  nop
    /* A54C4 800B4CC4 180040AC */  sw         $zero, 0x18($v0)
  .L800B4CC8:
    /* A54C8 800B4CC8 1180043C */  lui        $a0, %hi(controlData)
    /* A54CC 800B4CCC 6C708424 */  addiu      $a0, $a0, %lo(controlData)
    /* A54D0 800B4CD0 80281100 */  sll        $a1, $s1, 2
    /* A54D4 800B4CD4 1480023C */  lui        $v0, %hi(Replay_ReplayCounter)
    /* A54D8 800B4CD8 00D44224 */  addiu      $v0, $v0, %lo(Replay_ReplayCounter)
    /* A54DC 800B4CDC 2110A200 */  addu       $v0, $a1, $v0
    /* A54E0 800B4CE0 0000428C */  lw         $v0, 0x0($v0)
    /* A54E4 800B4CE4 C0191100 */  sll        $v1, $s1, 7
    /* A54E8 800B4CE8 21104300 */  addu       $v0, $v0, $v1
    /* A54EC 800B4CEC 21104400 */  addu       $v0, $v0, $a0
    /* A54F0 800B4CF0 20004290 */  lbu        $v0, 0x20($v0)
    /* A54F4 800B4CF4 00000000 */  nop
    /* A54F8 800B4CF8 80004230 */  andi       $v0, $v0, 0x80
    /* A54FC 800B4CFC 09004010 */  beqz       $v0, .L800B4D24
    /* A5500 800B4D00 1180023C */   lui       $v0, %hi(Cars_gHumanRaceCarList)
    /* A5504 800B4D04 48FA4224 */  addiu      $v0, $v0, %lo(Cars_gHumanRaceCarList)
    /* A5508 800B4D08 2110A200 */  addu       $v0, $a1, $v0
    /* A550C 800B4D0C 0000428C */  lw         $v0, 0x0($v0)
    /* A5510 800B4D10 00000000 */  nop
    /* A5514 800B4D14 8802438C */  lw         $v1, 0x288($v0)
    /* A5518 800B4D18 01000224 */  addiu      $v0, $zero, 0x1
    /* A551C 800B4D1C 50D30208 */  j          .L800B4D40
    /* A5520 800B4D20 1C0062AC */   sw        $v0, 0x1C($v1)
  .L800B4D24:
    /* A5524 800B4D24 48FA4224 */  addiu      $v0, $v0, %lo(Cars_gHumanRaceCarList)
    /* A5528 800B4D28 2110A200 */  addu       $v0, $a1, $v0
    /* A552C 800B4D2C 0000428C */  lw         $v0, 0x0($v0)
    /* A5530 800B4D30 00000000 */  nop
    /* A5534 800B4D34 8802428C */  lw         $v0, 0x288($v0)
    /* A5538 800B4D38 00000000 */  nop
    /* A553C 800B4D3C 1C0040AC */  sw         $zero, 0x1C($v0)
  .L800B4D40:
    /* A5540 800B4D40 1180043C */  lui        $a0, %hi(controlData)
    /* A5544 800B4D44 6C708424 */  addiu      $a0, $a0, %lo(controlData)
    /* A5548 800B4D48 80281100 */  sll        $a1, $s1, 2
    /* A554C 800B4D4C 1480023C */  lui        $v0, %hi(Replay_ReplayCounter)
    /* A5550 800B4D50 00D44224 */  addiu      $v0, $v0, %lo(Replay_ReplayCounter)
    /* A5554 800B4D54 2110A200 */  addu       $v0, $a1, $v0
    /* A5558 800B4D58 0000428C */  lw         $v0, 0x0($v0)
    /* A555C 800B4D5C C0191100 */  sll        $v1, $s1, 7
    /* A5560 800B4D60 21104300 */  addu       $v0, $v0, $v1
    /* A5564 800B4D64 21104400 */  addu       $v0, $v0, $a0
    /* A5568 800B4D68 40004290 */  lbu        $v0, 0x40($v0)
    /* A556C 800B4D6C 00000000 */  nop
    /* A5570 800B4D70 80004230 */  andi       $v0, $v0, 0x80
    /* A5574 800B4D74 09004010 */  beqz       $v0, .L800B4D9C
    /* A5578 800B4D78 1180023C */   lui       $v0, %hi(Cars_gHumanRaceCarList)
    /* A557C 800B4D7C 48FA4224 */  addiu      $v0, $v0, %lo(Cars_gHumanRaceCarList)
    /* A5580 800B4D80 2110A200 */  addu       $v0, $a1, $v0
    /* A5584 800B4D84 0000428C */  lw         $v0, 0x0($v0)
    /* A5588 800B4D88 00000000 */  nop
    /* A558C 800B4D8C 8802438C */  lw         $v1, 0x288($v0)
    /* A5590 800B4D90 01000224 */  addiu      $v0, $zero, 0x1
    /* A5594 800B4D94 6ED30208 */  j          .L800B4DB8
    /* A5598 800B4D98 200062AC */   sw        $v0, 0x20($v1)
  .L800B4D9C:
    /* A559C 800B4D9C 48FA4224 */  addiu      $v0, $v0, %lo(Cars_gHumanRaceCarList)
    /* A55A0 800B4DA0 2110A200 */  addu       $v0, $a1, $v0
    /* A55A4 800B4DA4 0000428C */  lw         $v0, 0x0($v0)
    /* A55A8 800B4DA8 00000000 */  nop
    /* A55AC 800B4DAC 8802428C */  lw         $v0, 0x288($v0)
    /* A55B0 800B4DB0 00000000 */  nop
    /* A55B4 800B4DB4 200040AC */  sw         $zero, 0x20($v0)
  .L800B4DB8:
    /* A55B8 800B4DB8 1180053C */  lui        $a1, %hi(controlData)
    /* A55BC 800B4DBC 6C70A524 */  addiu      $a1, $a1, %lo(controlData)
    /* A55C0 800B4DC0 80201100 */  sll        $a0, $s1, 2
    /* A55C4 800B4DC4 1480023C */  lui        $v0, %hi(Replay_ReplayCounter)
    /* A55C8 800B4DC8 00D44224 */  addiu      $v0, $v0, %lo(Replay_ReplayCounter)
    /* A55CC 800B4DCC 21208200 */  addu       $a0, $a0, $v0
    /* A55D0 800B4DD0 0000838C */  lw         $v1, 0x0($a0)
    /* A55D4 800B4DD4 C0311100 */  sll        $a2, $s1, 7
    /* A55D8 800B4DD8 21186600 */  addu       $v1, $v1, $a2
    /* A55DC 800B4DDC 21186500 */  addu       $v1, $v1, $a1
    /* A55E0 800B4DE0 00006290 */  lbu        $v0, 0x0($v1)
    /* A55E4 800B4DE4 00000000 */  nop
    /* A55E8 800B4DE8 7F004230 */  andi       $v0, $v0, 0x7F
    /* A55EC 800B4DEC 000062A0 */  sb         $v0, 0x0($v1)
    /* A55F0 800B4DF0 0000838C */  lw         $v1, 0x0($a0)
    /* A55F4 800B4DF4 00000000 */  nop
    /* A55F8 800B4DF8 21186600 */  addu       $v1, $v1, $a2
    /* A55FC 800B4DFC 21186500 */  addu       $v1, $v1, $a1
    /* A5600 800B4E00 20006290 */  lbu        $v0, 0x20($v1)
    /* A5604 800B4E04 00000000 */  nop
    /* A5608 800B4E08 7F004230 */  andi       $v0, $v0, 0x7F
    /* A560C 800B4E0C 200062A0 */  sb         $v0, 0x20($v1)
    /* A5610 800B4E10 0000838C */  lw         $v1, 0x0($a0)
    /* A5614 800B4E14 00000000 */  nop
    /* A5618 800B4E18 21186600 */  addu       $v1, $v1, $a2
    /* A561C 800B4E1C 21186500 */  addu       $v1, $v1, $a1
    /* A5620 800B4E20 40006290 */  lbu        $v0, 0x40($v1)
    /* A5624 800B4E24 00000000 */  nop
    /* A5628 800B4E28 7F004230 */  andi       $v0, $v0, 0x7F
    /* A562C 800B4E2C 400062A0 */  sb         $v0, 0x40($v1)
    /* A5630 800B4E30 0000828C */  lw         $v0, 0x0($a0)
    /* A5634 800B4E34 00000000 */  nop
    /* A5638 800B4E38 21104600 */  addu       $v0, $v0, $a2
    /* A563C 800B4E3C 21104500 */  addu       $v0, $v0, $a1
    /* A5640 800B4E40 00004280 */  lb         $v0, 0x0($v0)
    /* A5644 800B4E44 00000000 */  nop
    /* A5648 800B4E48 C0FF4224 */  addiu      $v0, $v0, -0x40
    /* A564C 800B4E4C 80100200 */  sll        $v0, $v0, 2
    /* A5650 800B4E50 1480013C */  lui        $at, %hi(Input_gSim)
    /* A5654 800B4E54 2CD222A0 */  sb         $v0, %lo(Input_gSim)($at)
    /* A5658 800B4E58 0000828C */  lw         $v0, 0x0($a0)
    /* A565C 800B4E5C 00000000 */  nop
    /* A5660 800B4E60 21104600 */  addu       $v0, $v0, $a2
    /* A5664 800B4E64 21104500 */  addu       $v0, $v0, $a1
    /* A5668 800B4E68 20004290 */  lbu        $v0, 0x20($v0)
    /* A566C 800B4E6C 00000000 */  nop
    /* A5670 800B4E70 C0100200 */  sll        $v0, $v0, 3
    /* A5674 800B4E74 1480013C */  lui        $at, %hi(D_8013D22D)
    /* A5678 800B4E78 2DD222A0 */  sb         $v0, %lo(D_8013D22D)($at)
    /* A567C 800B4E7C 0000828C */  lw         $v0, 0x0($a0)
    /* A5680 800B4E80 00000000 */  nop
    /* A5684 800B4E84 21104600 */  addu       $v0, $v0, $a2
    /* A5688 800B4E88 21104500 */  addu       $v0, $v0, $a1
    /* A568C 800B4E8C 40004290 */  lbu        $v0, 0x40($v0)
    /* A5690 800B4E90 00000000 */  nop
    /* A5694 800B4E94 C0100200 */  sll        $v0, $v0, 3
    /* A5698 800B4E98 1480013C */  lui        $at, %hi(D_8013D22E)
    /* A569C 800B4E9C 2ED222A0 */  sb         $v0, %lo(D_8013D22E)($at)
    /* A56A0 800B4EA0 0000828C */  lw         $v0, 0x0($a0)
    /* A56A4 800B4EA4 00000000 */  nop
    /* A56A8 800B4EA8 21104600 */  addu       $v0, $v0, $a2
    /* A56AC 800B4EAC 21104500 */  addu       $v0, $v0, $a1
    /* A56B0 800B4EB0 60004290 */  lbu        $v0, 0x60($v0)
    /* A56B4 800B4EB4 1480013C */  lui        $at, %hi(D_8013D22F)
    /* A56B8 800B4EB8 2FD222A0 */  sb         $v0, %lo(D_8013D22F)($at)
    /* A56BC 800B4EBC BCD30208 */  j          .L800B4EF0
    /* A56C0 800B4EC0 80281100 */   sll       $a1, $s1, 2
  .L800B4EC4:
    /* A56C4 800B4EC4 03000224 */  addiu      $v0, $zero, 0x3
    /* A56C8 800B4EC8 09006214 */  bne        $v1, $v0, .L800B4EF0
    /* A56CC 800B4ECC 80281100 */   sll       $a1, $s1, 2
    /* A56D0 800B4ED0 1480013C */  lui        $at, %hi(Input_gSim)
    /* A56D4 800B4ED4 2CD220A0 */  sb         $zero, %lo(Input_gSim)($at)
    /* A56D8 800B4ED8 1480013C */  lui        $at, %hi(D_8013D22D)
    /* A56DC 800B4EDC 2DD220A0 */  sb         $zero, %lo(D_8013D22D)($at)
    /* A56E0 800B4EE0 1480013C */  lui        $at, %hi(D_8013D22E)
    /* A56E4 800B4EE4 2ED220A0 */  sb         $zero, %lo(D_8013D22E)($at)
    /* A56E8 800B4EE8 1480013C */  lui        $at, %hi(D_8013D22F)
    /* A56EC 800B4EEC 2FD220A0 */  sb         $zero, %lo(D_8013D22F)($at)
  .L800B4EF0:
    /* A56F0 800B4EF0 1480023C */  lui        $v0, %hi(Replay_ReplayCounter)
    /* A56F4 800B4EF4 00D44224 */  addiu      $v0, $v0, %lo(Replay_ReplayCounter)
    /* A56F8 800B4EF8 2110A200 */  addu       $v0, $a1, $v0
    /* A56FC 800B4EFC 0000438C */  lw         $v1, 0x0($v0)
    /* A5700 800B4F00 A40E848F */  lw         $a0, %gp_rel(numValidCams)($gp)
    /* A5704 800B4F04 01006324 */  addiu      $v1, $v1, 0x1
    /* A5708 800B4F08 15008010 */  beqz       $a0, .L800B4F60
    /* A570C 800B4F0C 000043AC */   sw        $v1, 0x0($v0)
    /* A5710 800B4F10 1180033C */  lui        $v1, %hi(Replay_ReplayCamera)
    /* A5714 800B4F14 4C706324 */  addiu      $v1, $v1, %lo(Replay_ReplayCamera)
    /* A5718 800B4F18 00111100 */  sll        $v0, $s1, 4
    /* A571C 800B4F1C 21104300 */  addu       $v0, $v0, $v1
    /* A5720 800B4F20 0800438C */  lw         $v1, 0x8($v0)
    /* A5724 800B4F24 13000224 */  addiu      $v0, $zero, 0x13
    /* A5728 800B4F28 0E006214 */  bne        $v1, $v0, .L800B4F64
    /* A572C 800B4F2C 80181100 */   sll       $v1, $s1, 2
    /* A5730 800B4F30 1280023C */  lui        $v0, %hi(simGlobal)
    /* A5734 800B4F34 ACE0428C */  lw         $v0, %lo(simGlobal)($v0)
    /* A5738 800B4F38 00000000 */  nop
    /* A573C 800B4F3C 09004010 */  beqz       $v0, .L800B4F64
    /* A5740 800B4F40 1180023C */   lui       $v0, %hi(Cars_gHumanRaceCarList)
    /* A5744 800B4F44 48FA4224 */  addiu      $v0, $v0, %lo(Cars_gHumanRaceCarList)
    /* A5748 800B4F48 2110A200 */  addu       $v0, $a1, $v0
    /* A574C 800B4F4C 0000428C */  lw         $v0, 0x0($v0)
    /* A5750 800B4F50 00000000 */  nop
    /* A5754 800B4F54 08004584 */  lh         $a1, 0x8($v0)
    /* A5758 800B4F58 1BD6020C */  jal        Replay_ReplayChooseCamera__Fii
    /* A575C 800B4F5C 21202002 */   addu      $a0, $s1, $zero
  .L800B4F60:
    /* A5760 800B4F60 80181100 */  sll        $v1, $s1, 2
  .L800B4F64:
    /* A5764 800B4F64 1480023C */  lui        $v0, %hi(Replay_ReplayCounter)
    /* A5768 800B4F68 00D44224 */  addiu      $v0, $v0, %lo(Replay_ReplayCounter)
    /* A576C 800B4F6C 21206200 */  addu       $a0, $v1, $v0
    /* A5770 800B4F70 0000838C */  lw         $v1, 0x0($a0)
    /* A5774 800B4F74 20000224 */  addiu      $v0, $zero, 0x20
    /* A5778 800B4F78 02006214 */  bne        $v1, $v0, .L800B4F84
    /* A577C 800B4F7C 00000000 */   nop
    /* A5780 800B4F80 000080AC */  sw         $zero, 0x0($a0)
  .L800B4F84:
    /* A5784 800B4F84 9800BF8F */  lw         $ra, 0x98($sp)
    /* A5788 800B4F88 9400B18F */  lw         $s1, 0x94($sp)
    /* A578C 800B4F8C 9000B08F */  lw         $s0, 0x90($sp)
    /* A5790 800B4F90 0800E003 */  jr         $ra
    /* A5794 800B4F94 A000BD27 */   addiu     $sp, $sp, 0xA0
endlabel Replay_GetInput__Fi
