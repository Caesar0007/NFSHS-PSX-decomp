.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching firstfile, 0x19C

glabel firstfile
    /* FA5C0 80109DC0 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* FA5C4 80109DC4 1800B2AF */  sw         $s2, 0x18($sp)
    /* FA5C8 80109DC8 21908000 */  addu       $s2, $a0, $zero
    /* FA5CC 80109DCC 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* FA5D0 80109DD0 2198A000 */  addu       $s3, $a1, $zero
    /* FA5D4 80109DD4 2000BFAF */  sw         $ra, 0x20($sp)
    /* FA5D8 80109DD8 1400B1AF */  sw         $s1, 0x14($sp)
    /* FA5DC 80109DDC 1000B0AF */  sw         $s0, 0x10($sp)
    /* FA5E0 80109DE0 00004282 */  lb         $v0, 0x0($s2)
    /* FA5E4 80109DE4 1580043C */  lui        $a0, %hi(D_80148A84)
    /* FA5E8 80109DE8 848A8424 */  addiu      $a0, $a0, %lo(D_80148A84)
    /* FA5EC 80109DEC 3B004228 */  slti       $v0, $v0, 0x3B
    /* FA5F0 80109DF0 09004014 */  bnez       $v0, .L80109E18
    /* FA5F4 80109DF4 21184002 */   addu      $v1, $s2, $zero
  .L80109DF8:
    /* FA5F8 80109DF8 00006290 */  lbu        $v0, 0x0($v1)
    /* FA5FC 80109DFC 01006324 */  addiu      $v1, $v1, 0x1
    /* FA600 80109E00 000082A0 */  sb         $v0, 0x0($a0)
    /* FA604 80109E04 00006280 */  lb         $v0, 0x0($v1)
    /* FA608 80109E08 00000000 */  nop
    /* FA60C 80109E0C 3B004228 */  slti       $v0, $v0, 0x3B
    /* FA610 80109E10 F9FF4010 */  beqz       $v0, .L80109DF8
    /* FA614 80109E14 01008424 */   addiu     $a0, $a0, 0x1
  .L80109E18:
    /* FA618 80109E18 000080A0 */  sb         $zero, 0x0($a0)
    /* FA61C 80109E1C 5401038C */  lw         $v1, 0x154($zero)
    /* FA620 80109E20 CCCC023C */  lui        $v0, (0xCCCCCCCD >> 16)
    /* FA624 80109E24 CDCC4234 */  ori        $v0, $v0, (0xCCCCCCCD & 0xFFFF)
    /* FA628 80109E28 19006200 */  multu      $v1, $v0
    /* FA62C 80109E2C 5001108C */  lw         $s0, 0x150($zero)
    /* FA630 80109E30 10300000 */  mfhi       $a2
    /* FA634 80109E34 82190600 */  srl        $v1, $a2, 6
    /* FA638 80109E38 80100300 */  sll        $v0, $v1, 2
    /* FA63C 80109E3C 21104300 */  addu       $v0, $v0, $v1
    /* FA640 80109E40 00110200 */  sll        $v0, $v0, 4
    /* FA644 80109E44 21180202 */  addu       $v1, $s0, $v0
    /* FA648 80109E48 2B100302 */  sltu       $v0, $s0, $v1
    /* FA64C 80109E4C 0F004010 */  beqz       $v0, .L80109E8C
    /* FA650 80109E50 00000000 */   nop
    /* FA654 80109E54 21886000 */  addu       $s1, $v1, $zero
  .L80109E58:
    /* FA658 80109E58 0000048E */  lw         $a0, 0x0($s0)
    /* FA65C 80109E5C 00000000 */  nop
    /* FA660 80109E60 06008010 */  beqz       $a0, .L80109E7C
    /* FA664 80109E64 00000000 */   nop
    /* FA668 80109E68 1580053C */  lui        $a1, %hi(D_80148A84)
    /* FA66C 80109E6C 5F97030C */  jal        strcmp
    /* FA670 80109E70 848AA524 */   addiu     $a1, $a1, %lo(D_80148A84)
    /* FA674 80109E74 0A004010 */  beqz       $v0, .L80109EA0
    /* FA678 80109E78 00000000 */   nop
  .L80109E7C:
    /* FA67C 80109E7C 50001026 */  addiu      $s0, $s0, 0x50
    /* FA680 80109E80 2B101102 */  sltu       $v0, $s0, $s1
    /* FA684 80109E84 F4FF4014 */  bnez       $v0, .L80109E58
    /* FA688 80109E88 00000000 */   nop
  .L80109E8C:
    /* FA68C 80109E8C 21180000 */  addu       $v1, $zero, $zero
  .L80109E90:
    /* FA690 80109E90 0C006014 */  bnez       $v1, .L80109EC4
    /* FA694 80109E94 21100000 */   addu      $v0, $zero, $zero
    /* FA698 80109E98 D0270408 */  j          .L80109F40
    /* FA69C 80109E9C 00000000 */   nop
  .L80109EA0:
    /* FA6A0 80109EA0 3400028E */  lw         $v0, 0x34($s0)
    /* FA6A4 80109EA4 1580013C */  lui        $at, %hi(D_80148A7C)
    /* FA6A8 80109EA8 7C8A22AC */  sw         $v0, %lo(D_80148A7C)($at)
    /* FA6AC 80109EAC A4270408 */  j          .L80109E90
    /* FA6B0 80109EB0 01000324 */   addiu     $v1, $zero, 0x1
  .L80109EB4:
    /* FA6B4 80109EB4 1180023C */  lui        $v0, %hi(_first_patch)
    /* FA6B8 80109EB8 5C9F4224 */  addiu      $v0, $v0, %lo(_first_patch)
    /* FA6BC 80109EBC CD270408 */  j          .L80109F34
    /* FA6C0 80109EC0 340002AE */   sw        $v0, 0x34($s0)
  .L80109EC4:
    /* FA6C4 80109EC4 5401038C */  lw         $v1, 0x154($zero)
    /* FA6C8 80109EC8 CCCC023C */  lui        $v0, (0xCCCCCCCD >> 16)
    /* FA6CC 80109ECC CDCC4234 */  ori        $v0, $v0, (0xCCCCCCCD & 0xFFFF)
    /* FA6D0 80109ED0 19006200 */  multu      $v1, $v0
    /* FA6D4 80109ED4 5001108C */  lw         $s0, 0x150($zero)
    /* FA6D8 80109ED8 10300000 */  mfhi       $a2
    /* FA6DC 80109EDC 82190600 */  srl        $v1, $a2, 6
    /* FA6E0 80109EE0 80100300 */  sll        $v0, $v1, 2
    /* FA6E4 80109EE4 21104300 */  addu       $v0, $v0, $v1
    /* FA6E8 80109EE8 00110200 */  sll        $v0, $v0, 4
    /* FA6EC 80109EEC 21180202 */  addu       $v1, $s0, $v0
    /* FA6F0 80109EF0 2B100302 */  sltu       $v0, $s0, $v1
    /* FA6F4 80109EF4 10004010 */  beqz       $v0, .L80109F38
    /* FA6F8 80109EF8 21204002 */   addu      $a0, $s2, $zero
    /* FA6FC 80109EFC 21886000 */  addu       $s1, $v1, $zero
  .L80109F00:
    /* FA700 80109F00 0000048E */  lw         $a0, 0x0($s0)
    /* FA704 80109F04 00000000 */  nop
    /* FA708 80109F08 06008010 */  beqz       $a0, .L80109F24
    /* FA70C 80109F0C 00000000 */   nop
    /* FA710 80109F10 1580053C */  lui        $a1, %hi(D_80148A84)
    /* FA714 80109F14 5F97030C */  jal        strcmp
    /* FA718 80109F18 848AA524 */   addiu     $a1, $a1, %lo(D_80148A84)
    /* FA71C 80109F1C E5FF4010 */  beqz       $v0, .L80109EB4
    /* FA720 80109F20 00000000 */   nop
  .L80109F24:
    /* FA724 80109F24 50001026 */  addiu      $s0, $s0, 0x50
    /* FA728 80109F28 2B101102 */  sltu       $v0, $s0, $s1
    /* FA72C 80109F2C F4FF4014 */  bnez       $v0, .L80109F00
    /* FA730 80109F30 00000000 */   nop
  .L80109F34:
    /* FA734 80109F34 21204002 */  addu       $a0, $s2, $zero
  .L80109F38:
    /* FA738 80109F38 2132040C */  jal        firstfile2
    /* FA73C 80109F3C 21286002 */   addu      $a1, $s3, $zero
  .L80109F40:
    /* FA740 80109F40 2000BF8F */  lw         $ra, 0x20($sp)
    /* FA744 80109F44 1C00B38F */  lw         $s3, 0x1C($sp)
    /* FA748 80109F48 1800B28F */  lw         $s2, 0x18($sp)
    /* FA74C 80109F4C 1400B18F */  lw         $s1, 0x14($sp)
    /* FA750 80109F50 1000B08F */  lw         $s0, 0x10($sp)
    /* FA754 80109F54 0800E003 */  jr         $ra
    /* FA758 80109F58 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel firstfile
