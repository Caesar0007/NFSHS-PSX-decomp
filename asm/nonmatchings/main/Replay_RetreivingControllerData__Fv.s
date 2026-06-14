.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Replay_RetreivingControllerData__Fv, 0x39C

glabel Replay_RetreivingControllerData__Fv
    /* A4C88 800B4488 30FFBD27 */  addiu      $sp, $sp, -0xD0
    /* A4C8C 800B448C C400B3AF */  sw         $s3, 0xC4($sp)
    /* A4C90 800B4490 21988000 */  addu       $s3, $a0, $zero
    /* A4C94 800B4494 C000B2AF */  sw         $s2, 0xC0($sp)
    /* A4C98 800B4498 9000B227 */  addiu      $s2, $sp, 0x90
    /* A4C9C 800B449C 21204002 */  addu       $a0, $s2, $zero
    /* A4CA0 800B44A0 B800B0AF */  sw         $s0, 0xB8($sp)
    /* A4CA4 800B44A4 1180103C */  lui        $s0, %hi(D_80117B98)
    /* A4CA8 800B44A8 B00E858F */  lw         $a1, %gp_rel(Replay_ReplayGetPtr)($gp)
    /* A4CAC 800B44AC 987B1026 */  addiu      $s0, $s0, %lo(D_80117B98)
    /* A4CB0 800B44B0 BC00B1AF */  sw         $s1, 0xBC($sp)
    /* A4CB4 800B44B4 D4F51126 */  addiu      $s1, $s0, -0xA2C
    /* A4CB8 800B44B8 C800BFAF */  sw         $ra, 0xC8($sp)
    /* A4CBC 800B44BC 2110B100 */  addu       $v0, $a1, $s1
    /* A4CC0 800B44C0 2C0A4690 */  lbu        $a2, 0xA2C($v0)
    /* A4CC4 800B44C4 B1AA030C */  jal        memcpy
    /* A4CC8 800B44C8 2128B000 */   addu      $a1, $a1, $s0
    /* A4CCC 800B44CC 44CF020C */  jal        Replay_Decompress__FPc
    /* A4CD0 800B44D0 21204002 */   addu      $a0, $s2, $zero
    /* A4CD4 800B44D4 03004788 */  lwl        $a3, 0x3($v0)
    /* A4CD8 800B44D8 00004798 */  lwr        $a3, 0x0($v0)
    /* A4CDC 800B44DC 07004888 */  lwl        $t0, 0x7($v0)
    /* A4CE0 800B44E0 04004898 */  lwr        $t0, 0x4($v0)
    /* A4CE4 800B44E4 0B004988 */  lwl        $t1, 0xB($v0)
    /* A4CE8 800B44E8 08004998 */  lwr        $t1, 0x8($v0)
    /* A4CEC 800B44EC 0F004A88 */  lwl        $t2, 0xF($v0)
    /* A4CF0 800B44F0 0C004A98 */  lwr        $t2, 0xC($v0)
    /* A4CF4 800B44F4 1300A7AB */  swl        $a3, 0x13($sp)
    /* A4CF8 800B44F8 1000A7BB */  swr        $a3, 0x10($sp)
    /* A4CFC 800B44FC 1700A8AB */  swl        $t0, 0x17($sp)
    /* A4D00 800B4500 1400A8BB */  swr        $t0, 0x14($sp)
    /* A4D04 800B4504 1B00A9AB */  swl        $t1, 0x1B($sp)
    /* A4D08 800B4508 1800A9BB */  swr        $t1, 0x18($sp)
    /* A4D0C 800B450C 1F00AAAB */  swl        $t2, 0x1F($sp)
    /* A4D10 800B4510 1C00AABB */  swr        $t2, 0x1C($sp)
    /* A4D14 800B4514 13004788 */  lwl        $a3, 0x13($v0)
    /* A4D18 800B4518 10004798 */  lwr        $a3, 0x10($v0)
    /* A4D1C 800B451C 17004888 */  lwl        $t0, 0x17($v0)
    /* A4D20 800B4520 14004898 */  lwr        $t0, 0x14($v0)
    /* A4D24 800B4524 1B004988 */  lwl        $t1, 0x1B($v0)
    /* A4D28 800B4528 18004998 */  lwr        $t1, 0x18($v0)
    /* A4D2C 800B452C 1F004A88 */  lwl        $t2, 0x1F($v0)
    /* A4D30 800B4530 1C004A98 */  lwr        $t2, 0x1C($v0)
    /* A4D34 800B4534 2300A7AB */  swl        $a3, 0x23($sp)
    /* A4D38 800B4538 2000A7BB */  swr        $a3, 0x20($sp)
    /* A4D3C 800B453C 2700A8AB */  swl        $t0, 0x27($sp)
    /* A4D40 800B4540 2400A8BB */  swr        $t0, 0x24($sp)
    /* A4D44 800B4544 2B00A9AB */  swl        $t1, 0x2B($sp)
    /* A4D48 800B4548 2800A9BB */  swr        $t1, 0x28($sp)
    /* A4D4C 800B454C 2F00AAAB */  swl        $t2, 0x2F($sp)
    /* A4D50 800B4550 2C00AABB */  swr        $t2, 0x2C($sp)
    /* A4D54 800B4554 9000A293 */  lbu        $v0, 0x90($sp)
    /* A4D58 800B4558 B00E858F */  lw         $a1, %gp_rel(Replay_ReplayGetPtr)($gp)
    /* A4D5C 800B455C 21204002 */  addu       $a0, $s2, $zero
    /* A4D60 800B4560 2128A200 */  addu       $a1, $a1, $v0
    /* A4D64 800B4564 2110B100 */  addu       $v0, $a1, $s1
    /* A4D68 800B4568 B00E85AF */  sw         $a1, %gp_rel(Replay_ReplayGetPtr)($gp)
    /* A4D6C 800B456C 2C0A4690 */  lbu        $a2, 0xA2C($v0)
    /* A4D70 800B4570 B1AA030C */  jal        memcpy
    /* A4D74 800B4574 2128B000 */   addu      $a1, $a1, $s0
    /* A4D78 800B4578 44CF020C */  jal        Replay_Decompress__FPc
    /* A4D7C 800B457C 21204002 */   addu      $a0, $s2, $zero
    /* A4D80 800B4580 03004788 */  lwl        $a3, 0x3($v0)
    /* A4D84 800B4584 00004798 */  lwr        $a3, 0x0($v0)
    /* A4D88 800B4588 07004888 */  lwl        $t0, 0x7($v0)
    /* A4D8C 800B458C 04004898 */  lwr        $t0, 0x4($v0)
    /* A4D90 800B4590 0B004988 */  lwl        $t1, 0xB($v0)
    /* A4D94 800B4594 08004998 */  lwr        $t1, 0x8($v0)
    /* A4D98 800B4598 0F004A88 */  lwl        $t2, 0xF($v0)
    /* A4D9C 800B459C 0C004A98 */  lwr        $t2, 0xC($v0)
    /* A4DA0 800B45A0 3300A7AB */  swl        $a3, 0x33($sp)
    /* A4DA4 800B45A4 3000A7BB */  swr        $a3, 0x30($sp)
    /* A4DA8 800B45A8 3700A8AB */  swl        $t0, 0x37($sp)
    /* A4DAC 800B45AC 3400A8BB */  swr        $t0, 0x34($sp)
    /* A4DB0 800B45B0 3B00A9AB */  swl        $t1, 0x3B($sp)
    /* A4DB4 800B45B4 3800A9BB */  swr        $t1, 0x38($sp)
    /* A4DB8 800B45B8 3F00AAAB */  swl        $t2, 0x3F($sp)
    /* A4DBC 800B45BC 3C00AABB */  swr        $t2, 0x3C($sp)
    /* A4DC0 800B45C0 13004788 */  lwl        $a3, 0x13($v0)
    /* A4DC4 800B45C4 10004798 */  lwr        $a3, 0x10($v0)
    /* A4DC8 800B45C8 17004888 */  lwl        $t0, 0x17($v0)
    /* A4DCC 800B45CC 14004898 */  lwr        $t0, 0x14($v0)
    /* A4DD0 800B45D0 1B004988 */  lwl        $t1, 0x1B($v0)
    /* A4DD4 800B45D4 18004998 */  lwr        $t1, 0x18($v0)
    /* A4DD8 800B45D8 1F004A88 */  lwl        $t2, 0x1F($v0)
    /* A4DDC 800B45DC 1C004A98 */  lwr        $t2, 0x1C($v0)
    /* A4DE0 800B45E0 4300A7AB */  swl        $a3, 0x43($sp)
    /* A4DE4 800B45E4 4000A7BB */  swr        $a3, 0x40($sp)
    /* A4DE8 800B45E8 4700A8AB */  swl        $t0, 0x47($sp)
    /* A4DEC 800B45EC 4400A8BB */  swr        $t0, 0x44($sp)
    /* A4DF0 800B45F0 4B00A9AB */  swl        $t1, 0x4B($sp)
    /* A4DF4 800B45F4 4800A9BB */  swr        $t1, 0x48($sp)
    /* A4DF8 800B45F8 4F00AAAB */  swl        $t2, 0x4F($sp)
    /* A4DFC 800B45FC 4C00AABB */  swr        $t2, 0x4C($sp)
    /* A4E00 800B4600 9000A293 */  lbu        $v0, 0x90($sp)
    /* A4E04 800B4604 B00E858F */  lw         $a1, %gp_rel(Replay_ReplayGetPtr)($gp)
    /* A4E08 800B4608 21204002 */  addu       $a0, $s2, $zero
    /* A4E0C 800B460C 2128A200 */  addu       $a1, $a1, $v0
    /* A4E10 800B4610 2110B100 */  addu       $v0, $a1, $s1
    /* A4E14 800B4614 B00E85AF */  sw         $a1, %gp_rel(Replay_ReplayGetPtr)($gp)
    /* A4E18 800B4618 2C0A4690 */  lbu        $a2, 0xA2C($v0)
    /* A4E1C 800B461C B1AA030C */  jal        memcpy
    /* A4E20 800B4620 2128B000 */   addu      $a1, $a1, $s0
    /* A4E24 800B4624 44CF020C */  jal        Replay_Decompress__FPc
    /* A4E28 800B4628 21204002 */   addu      $a0, $s2, $zero
    /* A4E2C 800B462C 03004788 */  lwl        $a3, 0x3($v0)
    /* A4E30 800B4630 00004798 */  lwr        $a3, 0x0($v0)
    /* A4E34 800B4634 07004888 */  lwl        $t0, 0x7($v0)
    /* A4E38 800B4638 04004898 */  lwr        $t0, 0x4($v0)
    /* A4E3C 800B463C 0B004988 */  lwl        $t1, 0xB($v0)
    /* A4E40 800B4640 08004998 */  lwr        $t1, 0x8($v0)
    /* A4E44 800B4644 0F004A88 */  lwl        $t2, 0xF($v0)
    /* A4E48 800B4648 0C004A98 */  lwr        $t2, 0xC($v0)
    /* A4E4C 800B464C 5300A7AB */  swl        $a3, 0x53($sp)
    /* A4E50 800B4650 5000A7BB */  swr        $a3, 0x50($sp)
    /* A4E54 800B4654 5700A8AB */  swl        $t0, 0x57($sp)
    /* A4E58 800B4658 5400A8BB */  swr        $t0, 0x54($sp)
    /* A4E5C 800B465C 5B00A9AB */  swl        $t1, 0x5B($sp)
    /* A4E60 800B4660 5800A9BB */  swr        $t1, 0x58($sp)
    /* A4E64 800B4664 5F00AAAB */  swl        $t2, 0x5F($sp)
    /* A4E68 800B4668 5C00AABB */  swr        $t2, 0x5C($sp)
    /* A4E6C 800B466C 13004788 */  lwl        $a3, 0x13($v0)
    /* A4E70 800B4670 10004798 */  lwr        $a3, 0x10($v0)
    /* A4E74 800B4674 17004888 */  lwl        $t0, 0x17($v0)
    /* A4E78 800B4678 14004898 */  lwr        $t0, 0x14($v0)
    /* A4E7C 800B467C 1B004988 */  lwl        $t1, 0x1B($v0)
    /* A4E80 800B4680 18004998 */  lwr        $t1, 0x18($v0)
    /* A4E84 800B4684 1F004A88 */  lwl        $t2, 0x1F($v0)
    /* A4E88 800B4688 1C004A98 */  lwr        $t2, 0x1C($v0)
    /* A4E8C 800B468C 6300A7AB */  swl        $a3, 0x63($sp)
    /* A4E90 800B4690 6000A7BB */  swr        $a3, 0x60($sp)
    /* A4E94 800B4694 6700A8AB */  swl        $t0, 0x67($sp)
    /* A4E98 800B4698 6400A8BB */  swr        $t0, 0x64($sp)
    /* A4E9C 800B469C 6B00A9AB */  swl        $t1, 0x6B($sp)
    /* A4EA0 800B46A0 6800A9BB */  swr        $t1, 0x68($sp)
    /* A4EA4 800B46A4 6F00AAAB */  swl        $t2, 0x6F($sp)
    /* A4EA8 800B46A8 6C00AABB */  swr        $t2, 0x6C($sp)
    /* A4EAC 800B46AC 9000A293 */  lbu        $v0, 0x90($sp)
    /* A4EB0 800B46B0 B00E858F */  lw         $a1, %gp_rel(Replay_ReplayGetPtr)($gp)
    /* A4EB4 800B46B4 21204002 */  addu       $a0, $s2, $zero
    /* A4EB8 800B46B8 2128A200 */  addu       $a1, $a1, $v0
    /* A4EBC 800B46BC 2188B100 */  addu       $s1, $a1, $s1
    /* A4EC0 800B46C0 B00E85AF */  sw         $a1, %gp_rel(Replay_ReplayGetPtr)($gp)
    /* A4EC4 800B46C4 2C0A2692 */  lbu        $a2, 0xA2C($s1)
    /* A4EC8 800B46C8 B1AA030C */  jal        memcpy
    /* A4ECC 800B46CC 2128B000 */   addu      $a1, $a1, $s0
    /* A4ED0 800B46D0 44CF020C */  jal        Replay_Decompress__FPc
    /* A4ED4 800B46D4 21204002 */   addu      $a0, $s2, $zero
    /* A4ED8 800B46D8 21286002 */  addu       $a1, $s3, $zero
    /* A4EDC 800B46DC 03004788 */  lwl        $a3, 0x3($v0)
    /* A4EE0 800B46E0 00004798 */  lwr        $a3, 0x0($v0)
    /* A4EE4 800B46E4 07004888 */  lwl        $t0, 0x7($v0)
    /* A4EE8 800B46E8 04004898 */  lwr        $t0, 0x4($v0)
    /* A4EEC 800B46EC 0B004988 */  lwl        $t1, 0xB($v0)
    /* A4EF0 800B46F0 08004998 */  lwr        $t1, 0x8($v0)
    /* A4EF4 800B46F4 0F004A88 */  lwl        $t2, 0xF($v0)
    /* A4EF8 800B46F8 0C004A98 */  lwr        $t2, 0xC($v0)
    /* A4EFC 800B46FC 7300A7AB */  swl        $a3, 0x73($sp)
    /* A4F00 800B4700 7000A7BB */  swr        $a3, 0x70($sp)
    /* A4F04 800B4704 7700A8AB */  swl        $t0, 0x77($sp)
    /* A4F08 800B4708 7400A8BB */  swr        $t0, 0x74($sp)
    /* A4F0C 800B470C 7B00A9AB */  swl        $t1, 0x7B($sp)
    /* A4F10 800B4710 7800A9BB */  swr        $t1, 0x78($sp)
    /* A4F14 800B4714 7F00AAAB */  swl        $t2, 0x7F($sp)
    /* A4F18 800B4718 7C00AABB */  swr        $t2, 0x7C($sp)
    /* A4F1C 800B471C 13004788 */  lwl        $a3, 0x13($v0)
    /* A4F20 800B4720 10004798 */  lwr        $a3, 0x10($v0)
    /* A4F24 800B4724 17004888 */  lwl        $t0, 0x17($v0)
    /* A4F28 800B4728 14004898 */  lwr        $t0, 0x14($v0)
    /* A4F2C 800B472C 1B004988 */  lwl        $t1, 0x1B($v0)
    /* A4F30 800B4730 18004998 */  lwr        $t1, 0x18($v0)
    /* A4F34 800B4734 1F004A88 */  lwl        $t2, 0x1F($v0)
    /* A4F38 800B4738 1C004A98 */  lwr        $t2, 0x1C($v0)
    /* A4F3C 800B473C 8300A7AB */  swl        $a3, 0x83($sp)
    /* A4F40 800B4740 8000A7BB */  swr        $a3, 0x80($sp)
    /* A4F44 800B4744 8700A8AB */  swl        $t0, 0x87($sp)
    /* A4F48 800B4748 8400A8BB */  swr        $t0, 0x84($sp)
    /* A4F4C 800B474C 8B00A9AB */  swl        $t1, 0x8B($sp)
    /* A4F50 800B4750 8800A9BB */  swr        $t1, 0x88($sp)
    /* A4F54 800B4754 8F00AAAB */  swl        $t2, 0x8F($sp)
    /* A4F58 800B4758 8C00AABB */  swr        $t2, 0x8C($sp)
    /* A4F5C 800B475C 9000A493 */  lbu        $a0, 0x90($sp)
    /* A4F60 800B4760 B00E828F */  lw         $v0, %gp_rel(Replay_ReplayGetPtr)($gp)
    /* A4F64 800B4764 00000000 */  nop
    /* A4F68 800B4768 21104400 */  addu       $v0, $v0, $a0
    /* A4F6C 800B476C B00E82AF */  sw         $v0, %gp_rel(Replay_ReplayGetPtr)($gp)
    /* A4F70 800B4770 03006232 */  andi       $v0, $s3, 0x3
    /* A4F74 800B4774 17004010 */  beqz       $v0, .L800B47D4
    /* A4F78 800B4778 1000A327 */   addiu     $v1, $sp, 0x10
    /* A4F7C 800B477C 21204002 */  addu       $a0, $s2, $zero
  .L800B4780:
    /* A4F80 800B4780 03006788 */  lwl        $a3, 0x3($v1)
    /* A4F84 800B4784 00006798 */  lwr        $a3, 0x0($v1)
    /* A4F88 800B4788 07006888 */  lwl        $t0, 0x7($v1)
    /* A4F8C 800B478C 04006898 */  lwr        $t0, 0x4($v1)
    /* A4F90 800B4790 0B006988 */  lwl        $t1, 0xB($v1)
    /* A4F94 800B4794 08006998 */  lwr        $t1, 0x8($v1)
    /* A4F98 800B4798 0F006A88 */  lwl        $t2, 0xF($v1)
    /* A4F9C 800B479C 0C006A98 */  lwr        $t2, 0xC($v1)
    /* A4FA0 800B47A0 0300A7A8 */  swl        $a3, 0x3($a1)
    /* A4FA4 800B47A4 0000A7B8 */  swr        $a3, 0x0($a1)
    /* A4FA8 800B47A8 0700A8A8 */  swl        $t0, 0x7($a1)
    /* A4FAC 800B47AC 0400A8B8 */  swr        $t0, 0x4($a1)
    /* A4FB0 800B47B0 0B00A9A8 */  swl        $t1, 0xB($a1)
    /* A4FB4 800B47B4 0800A9B8 */  swr        $t1, 0x8($a1)
    /* A4FB8 800B47B8 0F00AAA8 */  swl        $t2, 0xF($a1)
    /* A4FBC 800B47BC 0C00AAB8 */  swr        $t2, 0xC($a1)
    /* A4FC0 800B47C0 10006324 */  addiu      $v1, $v1, 0x10
    /* A4FC4 800B47C4 EEFF6414 */  bne        $v1, $a0, .L800B4780
    /* A4FC8 800B47C8 1000A524 */   addiu     $a1, $a1, 0x10
    /* A4FCC 800B47CC 02D20208 */  j          .L800B4808
    /* A4FD0 800B47D0 21106002 */   addu      $v0, $s3, $zero
  .L800B47D4:
    /* A4FD4 800B47D4 21204002 */  addu       $a0, $s2, $zero
  .L800B47D8:
    /* A4FD8 800B47D8 0000678C */  lw         $a3, 0x0($v1)
    /* A4FDC 800B47DC 0400688C */  lw         $t0, 0x4($v1)
    /* A4FE0 800B47E0 0800698C */  lw         $t1, 0x8($v1)
    /* A4FE4 800B47E4 0C006A8C */  lw         $t2, 0xC($v1)
    /* A4FE8 800B47E8 0000A7AC */  sw         $a3, 0x0($a1)
    /* A4FEC 800B47EC 0400A8AC */  sw         $t0, 0x4($a1)
    /* A4FF0 800B47F0 0800A9AC */  sw         $t1, 0x8($a1)
    /* A4FF4 800B47F4 0C00AAAC */  sw         $t2, 0xC($a1)
    /* A4FF8 800B47F8 10006324 */  addiu      $v1, $v1, 0x10
    /* A4FFC 800B47FC F6FF6414 */  bne        $v1, $a0, .L800B47D8
    /* A5000 800B4800 1000A524 */   addiu     $a1, $a1, 0x10
    /* A5004 800B4804 21106002 */  addu       $v0, $s3, $zero
  .L800B4808:
    /* A5008 800B4808 C800BF8F */  lw         $ra, 0xC8($sp)
    /* A500C 800B480C C400B38F */  lw         $s3, 0xC4($sp)
    /* A5010 800B4810 C000B28F */  lw         $s2, 0xC0($sp)
    /* A5014 800B4814 BC00B18F */  lw         $s1, 0xBC($sp)
    /* A5018 800B4818 B800B08F */  lw         $s0, 0xB8($sp)
    /* A501C 800B481C 0800E003 */  jr         $ra
    /* A5020 800B4820 D000BD27 */   addiu     $sp, $sp, 0xD0
endlabel Replay_RetreivingControllerData__Fv
