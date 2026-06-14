.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawW_SetUpSubdividFacet__FiP25Draw_tGiveShelbyMoreCache, 0x338

glabel DrawW_SetUpSubdividFacet__FiP25Draw_tGiveShelbyMoreCache
    /* B63E0 800C5BE0 C0FFBD27 */  addiu      $sp, $sp, -0x40
    /* B63E4 800C5BE4 3400B5AF */  sw         $s5, 0x34($sp)
    /* B63E8 800C5BE8 21A88000 */  addu       $s5, $a0, $zero
    /* B63EC 800C5BEC 2000B0AF */  sw         $s0, 0x20($sp)
    /* B63F0 800C5BF0 2180A000 */  addu       $s0, $a1, $zero
    /* B63F4 800C5BF4 3000B4AF */  sw         $s4, 0x30($sp)
    /* B63F8 800C5BF8 4C011426 */  addiu      $s4, $s0, 0x14C
    /* B63FC 800C5BFC 21208002 */  addu       $a0, $s4, $zero
    /* B6400 800C5C00 98000526 */  addiu      $a1, $s0, 0x98
    /* B6404 800C5C04 2C00B3AF */  sw         $s3, 0x2C($sp)
    /* B6408 800C5C08 5C011326 */  addiu      $s3, $s0, 0x15C
    /* B640C 800C5C0C 2400B1AF */  sw         $s1, 0x24($sp)
    /* B6410 800C5C10 6C011126 */  addiu      $s1, $s0, 0x16C
    /* B6414 800C5C14 2800B2AF */  sw         $s2, 0x28($sp)
    /* B6418 800C5C18 3800BFAF */  sw         $ra, 0x38($sp)
    /* B641C 800C5C1C ED16030C */  jal        DrawW_LoadPrecVECTOR__FP12Draw_SVertexP6VECTOR
    /* B6420 800C5C20 7C011226 */   addiu     $s2, $s0, 0x17C
    /* B6424 800C5C24 21206002 */  addu       $a0, $s3, $zero
    /* B6428 800C5C28 ED16030C */  jal        DrawW_LoadPrecVECTOR__FP12Draw_SVertexP6VECTOR
    /* B642C 800C5C2C A8000526 */   addiu     $a1, $s0, 0xA8
    /* B6430 800C5C30 21202002 */  addu       $a0, $s1, $zero
    /* B6434 800C5C34 ED16030C */  jal        DrawW_LoadPrecVECTOR__FP12Draw_SVertexP6VECTOR
    /* B6438 800C5C38 B8000526 */   addiu     $a1, $s0, 0xB8
    /* B643C 800C5C3C 21204002 */  addu       $a0, $s2, $zero
    /* B6440 800C5C40 ED16030C */  jal        DrawW_LoadPrecVECTOR__FP12Draw_SVertexP6VECTOR
    /* B6444 800C5C44 C8000526 */   addiu     $a1, $s0, 0xC8
    /* B6448 800C5C48 10010626 */  addiu      $a2, $s0, 0x110
    /* B644C 800C5C4C 0800C28C */  lw         $v0, 0x8($a2)
    /* B6450 800C5C50 1400C38C */  lw         $v1, 0x14($a2)
    /* B6454 800C5C54 2C00C48C */  lw         $a0, 0x2C($a2)
    /* B6458 800C5C58 2000C58C */  lw         $a1, 0x20($a2)
    /* B645C 800C5C5C 080082AE */  sw         $v0, 0x8($s4)
    /* B6460 800C5C60 080063AE */  sw         $v1, 0x8($s3)
    /* B6464 800C5C64 080024AE */  sw         $a0, 0x8($s1)
    /* B6468 800C5C68 080045AE */  sw         $a1, 0x8($s2)
    /* B646C 800C5C6C A000028E */  lw         $v0, 0xA0($s0)
    /* B6470 800C5C70 00000000 */  nop
    /* B6474 800C5C74 40014228 */  slti       $v0, $v0, 0x140
    /* B6478 800C5C78 08004010 */  beqz       $v0, .L800C5C9C
    /* B647C 800C5C7C 00000000 */   nop
    /* B6480 800C5C80 000080CA */  lwc2       $0, 0x0($s4)
    /* B6484 800C5C84 040081CA */  lwc2       $1, 0x4($s4)
    /* B6488 800C5C88 00000000 */  nop
    /* B648C 800C5C8C 00000000 */  nop
    /* B6490 800C5C90 0100184A */  .word 0x4A180001  /* rtps */
    /* B6494 800C5C94 54010226 */  addiu      $v0, $s0, 0x154
    /* B6498 800C5C98 00004EE8 */  swc2       $14, 0x0($v0)
  .L800C5C9C:
    /* B649C 800C5C9C B000028E */  lw         $v0, 0xB0($s0)
    /* B64A0 800C5CA0 00000000 */  nop
    /* B64A4 800C5CA4 40014228 */  slti       $v0, $v0, 0x140
    /* B64A8 800C5CA8 08004010 */  beqz       $v0, .L800C5CCC
    /* B64AC 800C5CAC 00000000 */   nop
    /* B64B0 800C5CB0 000060CA */  lwc2       $0, 0x0($s3)
    /* B64B4 800C5CB4 040061CA */  lwc2       $1, 0x4($s3)
    /* B64B8 800C5CB8 00000000 */  nop
    /* B64BC 800C5CBC 00000000 */  nop
    /* B64C0 800C5CC0 0100184A */  .word 0x4A180001  /* rtps */
    /* B64C4 800C5CC4 64010226 */  addiu      $v0, $s0, 0x164
    /* B64C8 800C5CC8 00004EE8 */  swc2       $14, 0x0($v0)
  .L800C5CCC:
    /* B64CC 800C5CCC C000028E */  lw         $v0, 0xC0($s0)
    /* B64D0 800C5CD0 00000000 */  nop
    /* B64D4 800C5CD4 40014228 */  slti       $v0, $v0, 0x140
    /* B64D8 800C5CD8 08004010 */  beqz       $v0, .L800C5CFC
    /* B64DC 800C5CDC 00000000 */   nop
    /* B64E0 800C5CE0 000020CA */  lwc2       $0, 0x0($s1)
    /* B64E4 800C5CE4 040021CA */  lwc2       $1, 0x4($s1)
    /* B64E8 800C5CE8 00000000 */  nop
    /* B64EC 800C5CEC 00000000 */  nop
    /* B64F0 800C5CF0 0100184A */  .word 0x4A180001  /* rtps */
    /* B64F4 800C5CF4 74010226 */  addiu      $v0, $s0, 0x174
    /* B64F8 800C5CF8 00004EE8 */  swc2       $14, 0x0($v0)
  .L800C5CFC:
    /* B64FC 800C5CFC D000028E */  lw         $v0, 0xD0($s0)
    /* B6500 800C5D00 00000000 */  nop
    /* B6504 800C5D04 40014228 */  slti       $v0, $v0, 0x140
    /* B6508 800C5D08 08004010 */  beqz       $v0, .L800C5D2C
    /* B650C 800C5D0C 00000000 */   nop
    /* B6510 800C5D10 000040CA */  lwc2       $0, 0x0($s2)
    /* B6514 800C5D14 040041CA */  lwc2       $1, 0x4($s2)
    /* B6518 800C5D18 00000000 */  nop
    /* B651C 800C5D1C 00000000 */  nop
    /* B6520 800C5D20 0100184A */  .word 0x4A180001  /* rtps */
    /* B6524 800C5D24 84010226 */  addiu      $v0, $s0, 0x184
    /* B6528 800C5D28 00004EE8 */  swc2       $14, 0x0($v0)
  .L800C5D2C:
    /* B652C 800C5D2C 0400C28C */  lw         $v0, 0x4($a2)
    /* B6530 800C5D30 1000C38C */  lw         $v1, 0x10($a2)
    /* B6534 800C5D34 2800C48C */  lw         $a0, 0x28($a2)
    /* B6538 800C5D38 1C00C58C */  lw         $a1, 0x1C($a2)
    /* B653C 800C5D3C 0C0082AE */  sw         $v0, 0xC($s4)
    /* B6540 800C5D40 0C0063AE */  sw         $v1, 0xC($s3)
    /* B6544 800C5D44 0C0024AE */  sw         $a0, 0xC($s1)
    /* B6548 800C5D48 0C0045AE */  sw         $a1, 0xC($s2)
    /* B654C 800C5D4C 0C00C394 */  lhu        $v1, 0xC($a2)
    /* B6550 800C5D50 1800C494 */  lhu        $a0, 0x18($a2)
    /* B6554 800C5D54 2400C594 */  lhu        $a1, 0x24($a2)
    /* B6558 800C5D58 3000C294 */  lhu        $v0, 0x30($a2)
    /* B655C 800C5D5C 060083A6 */  sh         $v1, 0x6($s4)
    /* B6560 800C5D60 060064A6 */  sh         $a0, 0x6($s3)
    /* B6564 800C5D64 060022A6 */  sh         $v0, 0x6($s1)
    /* B6568 800C5D68 060045A6 */  sh         $a1, 0x6($s2)
    /* B656C 800C5D6C 08008486 */  lh         $a0, 0x8($s4)
    /* B6570 800C5D70 00000000 */  nop
    /* B6574 800C5D74 E9038228 */  slti       $v0, $a0, 0x3E9
    /* B6578 800C5D78 10004010 */  beqz       $v0, .L800C5DBC
    /* B657C 800C5D7C 0F0080A2 */   sb        $zero, 0xF($s4)
    /* B6580 800C5D80 0A008386 */  lh         $v1, 0xA($s4)
    /* B6584 800C5D84 00000000 */  nop
    /* B6588 800C5D88 E9036228 */  slti       $v0, $v1, 0x3E9
    /* B658C 800C5D8C 0B004010 */  beqz       $v0, .L800C5DBC
    /* B6590 800C5D90 18FC8228 */   slti      $v0, $a0, -0x3E8
    /* B6594 800C5D94 0A004014 */  bnez       $v0, .L800C5DC0
    /* B6598 800C5D98 01000224 */   addiu     $v0, $zero, 0x1
    /* B659C 800C5D9C 18FC6228 */  slti       $v0, $v1, -0x3E8
    /* B65A0 800C5DA0 07004014 */  bnez       $v0, .L800C5DC0
    /* B65A4 800C5DA4 01000224 */   addiu     $v0, $zero, 0x1
    /* B65A8 800C5DA8 04008286 */  lh         $v0, 0x4($s4)
    /* B65AC 800C5DAC 00000000 */  nop
    /* B65B0 800C5DB0 65004228 */  slti       $v0, $v0, 0x65
    /* B65B4 800C5DB4 03004010 */  beqz       $v0, .L800C5DC4
    /* B65B8 800C5DB8 00000000 */   nop
  .L800C5DBC:
    /* B65BC 800C5DBC 01000224 */  addiu      $v0, $zero, 0x1
  .L800C5DC0:
    /* B65C0 800C5DC0 0F0082A2 */  sb         $v0, 0xF($s4)
  .L800C5DC4:
    /* B65C4 800C5DC4 08006486 */  lh         $a0, 0x8($s3)
    /* B65C8 800C5DC8 00000000 */  nop
    /* B65CC 800C5DCC E9038228 */  slti       $v0, $a0, 0x3E9
    /* B65D0 800C5DD0 10004010 */  beqz       $v0, .L800C5E14
    /* B65D4 800C5DD4 0F0060A2 */   sb        $zero, 0xF($s3)
    /* B65D8 800C5DD8 0A006386 */  lh         $v1, 0xA($s3)
    /* B65DC 800C5DDC 00000000 */  nop
    /* B65E0 800C5DE0 E9036228 */  slti       $v0, $v1, 0x3E9
    /* B65E4 800C5DE4 0B004010 */  beqz       $v0, .L800C5E14
    /* B65E8 800C5DE8 18FC8228 */   slti      $v0, $a0, -0x3E8
    /* B65EC 800C5DEC 0A004014 */  bnez       $v0, .L800C5E18
    /* B65F0 800C5DF0 01000224 */   addiu     $v0, $zero, 0x1
    /* B65F4 800C5DF4 18FC6228 */  slti       $v0, $v1, -0x3E8
    /* B65F8 800C5DF8 07004014 */  bnez       $v0, .L800C5E18
    /* B65FC 800C5DFC 01000224 */   addiu     $v0, $zero, 0x1
    /* B6600 800C5E00 04006286 */  lh         $v0, 0x4($s3)
    /* B6604 800C5E04 00000000 */  nop
    /* B6608 800C5E08 65004228 */  slti       $v0, $v0, 0x65
    /* B660C 800C5E0C 03004010 */  beqz       $v0, .L800C5E1C
    /* B6610 800C5E10 00000000 */   nop
  .L800C5E14:
    /* B6614 800C5E14 01000224 */  addiu      $v0, $zero, 0x1
  .L800C5E18:
    /* B6618 800C5E18 0F0062A2 */  sb         $v0, 0xF($s3)
  .L800C5E1C:
    /* B661C 800C5E1C 08002486 */  lh         $a0, 0x8($s1)
    /* B6620 800C5E20 00000000 */  nop
    /* B6624 800C5E24 E9038228 */  slti       $v0, $a0, 0x3E9
    /* B6628 800C5E28 10004010 */  beqz       $v0, .L800C5E6C
    /* B662C 800C5E2C 0F0020A2 */   sb        $zero, 0xF($s1)
    /* B6630 800C5E30 0A002386 */  lh         $v1, 0xA($s1)
    /* B6634 800C5E34 00000000 */  nop
    /* B6638 800C5E38 E9036228 */  slti       $v0, $v1, 0x3E9
    /* B663C 800C5E3C 0B004010 */  beqz       $v0, .L800C5E6C
    /* B6640 800C5E40 18FC8228 */   slti      $v0, $a0, -0x3E8
    /* B6644 800C5E44 0A004014 */  bnez       $v0, .L800C5E70
    /* B6648 800C5E48 01000224 */   addiu     $v0, $zero, 0x1
    /* B664C 800C5E4C 18FC6228 */  slti       $v0, $v1, -0x3E8
    /* B6650 800C5E50 07004014 */  bnez       $v0, .L800C5E70
    /* B6654 800C5E54 01000224 */   addiu     $v0, $zero, 0x1
    /* B6658 800C5E58 04002286 */  lh         $v0, 0x4($s1)
    /* B665C 800C5E5C 00000000 */  nop
    /* B6660 800C5E60 65004228 */  slti       $v0, $v0, 0x65
    /* B6664 800C5E64 03004010 */  beqz       $v0, .L800C5E74
    /* B6668 800C5E68 00000000 */   nop
  .L800C5E6C:
    /* B666C 800C5E6C 01000224 */  addiu      $v0, $zero, 0x1
  .L800C5E70:
    /* B6670 800C5E70 0F0022A2 */  sb         $v0, 0xF($s1)
  .L800C5E74:
    /* B6674 800C5E74 08004486 */  lh         $a0, 0x8($s2)
    /* B6678 800C5E78 00000000 */  nop
    /* B667C 800C5E7C E9038228 */  slti       $v0, $a0, 0x3E9
    /* B6680 800C5E80 10004010 */  beqz       $v0, .L800C5EC4
    /* B6684 800C5E84 0F0040A2 */   sb        $zero, 0xF($s2)
    /* B6688 800C5E88 0A004386 */  lh         $v1, 0xA($s2)
    /* B668C 800C5E8C 00000000 */  nop
    /* B6690 800C5E90 E9036228 */  slti       $v0, $v1, 0x3E9
    /* B6694 800C5E94 0B004010 */  beqz       $v0, .L800C5EC4
    /* B6698 800C5E98 18FC8228 */   slti      $v0, $a0, -0x3E8
    /* B669C 800C5E9C 0A004014 */  bnez       $v0, .L800C5EC8
    /* B66A0 800C5EA0 01000224 */   addiu     $v0, $zero, 0x1
    /* B66A4 800C5EA4 18FC6228 */  slti       $v0, $v1, -0x3E8
    /* B66A8 800C5EA8 07004014 */  bnez       $v0, .L800C5EC8
    /* B66AC 800C5EAC 01000224 */   addiu     $v0, $zero, 0x1
    /* B66B0 800C5EB0 04004286 */  lh         $v0, 0x4($s2)
    /* B66B4 800C5EB4 00000000 */  nop
    /* B66B8 800C5EB8 65004228 */  slti       $v0, $v0, 0x65
    /* B66BC 800C5EBC 04004010 */  beqz       $v0, .L800C5ED0
    /* B66C0 800C5EC0 21200002 */   addu      $a0, $s0, $zero
  .L800C5EC4:
    /* B66C4 800C5EC4 01000224 */  addiu      $v0, $zero, 0x1
  .L800C5EC8:
    /* B66C8 800C5EC8 0F0042A2 */  sb         $v0, 0xF($s2)
    /* B66CC 800C5ECC 21200002 */  addu       $a0, $s0, $zero
  .L800C5ED0:
    /* B66D0 800C5ED0 21280000 */  addu       $a1, $zero, $zero
    /* B66D4 800C5ED4 0100A22E */  sltiu      $v0, $s5, 0x1
    /* B66D8 800C5ED8 21308002 */  addu       $a2, $s4, $zero
    /* B66DC 800C5EDC 21386002 */  addu       $a3, $s3, $zero
    /* B66E0 800C5EE0 1000B1AF */  sw         $s1, 0x10($sp)
    /* B66E4 800C5EE4 1400B2AF */  sw         $s2, 0x14($sp)
    /* B66E8 800C5EE8 1800A0AF */  sw         $zero, 0x18($sp)
    /* B66EC 800C5EEC A114030C */  jal        DrawW_SubdividFacet__FP25Draw_tGiveShelbyMoreCacheiP12Draw_SVertexN32ss
    /* B66F0 800C5EF0 1C00A2AF */   sw        $v0, 0x1C($sp)
    /* B66F4 800C5EF4 3800BF8F */  lw         $ra, 0x38($sp)
    /* B66F8 800C5EF8 3400B58F */  lw         $s5, 0x34($sp)
    /* B66FC 800C5EFC 3000B48F */  lw         $s4, 0x30($sp)
    /* B6700 800C5F00 2C00B38F */  lw         $s3, 0x2C($sp)
    /* B6704 800C5F04 2800B28F */  lw         $s2, 0x28($sp)
    /* B6708 800C5F08 2400B18F */  lw         $s1, 0x24($sp)
    /* B670C 800C5F0C 2000B08F */  lw         $s0, 0x20($sp)
    /* B6710 800C5F10 0800E003 */  jr         $ra
    /* B6714 800C5F14 4000BD27 */   addiu     $sp, $sp, 0x40
endlabel DrawW_SetUpSubdividFacet__FiP25Draw_tGiveShelbyMoreCache
