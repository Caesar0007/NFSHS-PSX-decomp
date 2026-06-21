.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _cd_intr_dispatch, 0xD8

glabel _cd_intr_dispatch
    /* F8E80 80108680 1480023C */  lui        $v0, %hi(D_8013C20C)
    /* F8E84 80108684 0CC2428C */  lw         $v0, %lo(D_8013C20C)($v0)
    /* F8E88 80108688 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* F8E8C 8010868C 1400B1AF */  sw         $s1, 0x14($sp)
    /* F8E90 80108690 1480113C */  lui        $s1, %hi(D_8013C225)
    /* F8E94 80108694 25C23126 */  addiu      $s1, $s1, %lo(D_8013C225)
    /* F8E98 80108698 2000BFAF */  sw         $ra, 0x20($sp)
    /* F8E9C 8010869C 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* F8EA0 801086A0 1800B2AF */  sw         $s2, 0x18($sp)
    /* F8EA4 801086A4 1000B0AF */  sw         $s0, 0x10($sp)
    /* F8EA8 801086A8 00004290 */  lbu        $v0, 0x0($v0)
    /* F8EAC 801086AC FFFF3326 */  addiu      $s3, $s1, -0x1
    /* F8EB0 801086B0 03005230 */  andi       $s2, $v0, 0x3
  .L801086B4:
    /* F8EB4 801086B4 201C040C */  jal        func_80107080
    /* F8EB8 801086B8 00000000 */   nop
    /* F8EBC 801086BC 21804000 */  addu       $s0, $v0, $zero
    /* F8EC0 801086C0 1A000012 */  beqz       $s0, .L8010872C
    /* F8EC4 801086C4 04000232 */   andi      $v0, $s0, 0x4
    /* F8EC8 801086C8 0B004010 */  beqz       $v0, .L801086F8
    /* F8ECC 801086CC 02000232 */   andi      $v0, $s0, 0x2
    /* F8ED0 801086D0 1480023C */  lui        $v0, %hi(CD_cbready)
    /* F8ED4 801086D4 4CBF428C */  lw         $v0, %lo(CD_cbready)($v0)
    /* F8ED8 801086D8 00000000 */  nop
    /* F8EDC 801086DC 05004010 */  beqz       $v0, .L801086F4
    /* F8EE0 801086E0 00000000 */   nop
    /* F8EE4 801086E4 00002492 */  lbu        $a0, 0x0($s1)
    /* F8EE8 801086E8 1580053C */  lui        $a1, %hi(D_801489A4)
    /* F8EEC 801086EC 09F84000 */  jalr       $v0
    /* F8EF0 801086F0 A489A524 */   addiu     $a1, $a1, %lo(D_801489A4)
  .L801086F4:
    /* F8EF4 801086F4 02000232 */  andi       $v0, $s0, 0x2
  .L801086F8:
    /* F8EF8 801086F8 EEFF4010 */  beqz       $v0, .L801086B4
    /* F8EFC 801086FC 00000000 */   nop
    /* F8F00 80108700 1480023C */  lui        $v0, %hi(CD_cbsync)
    /* F8F04 80108704 48BF428C */  lw         $v0, %lo(CD_cbsync)($v0)
    /* F8F08 80108708 00000000 */  nop
    /* F8F0C 8010870C E9FF4010 */  beqz       $v0, .L801086B4
    /* F8F10 80108710 00000000 */   nop
    /* F8F14 80108714 00006492 */  lbu        $a0, 0x0($s3)
    /* F8F18 80108718 1580053C */  lui        $a1, %hi(D_8014899C)
    /* F8F1C 8010871C 09F84000 */  jalr       $v0
    /* F8F20 80108720 9C89A524 */   addiu     $a1, $a1, %lo(D_8014899C)
    /* F8F24 80108724 AD210408 */  j          .L801086B4
    /* F8F28 80108728 00000000 */   nop
  .L8010872C:
    /* F8F2C 8010872C 1480023C */  lui        $v0, %hi(D_8013C20C)
    /* F8F30 80108730 0CC2428C */  lw         $v0, %lo(D_8013C20C)($v0)
    /* F8F34 80108734 00000000 */  nop
    /* F8F38 80108738 000052A0 */  sb         $s2, 0x0($v0)
    /* F8F3C 8010873C 2000BF8F */  lw         $ra, 0x20($sp)
    /* F8F40 80108740 1C00B38F */  lw         $s3, 0x1C($sp)
    /* F8F44 80108744 1800B28F */  lw         $s2, 0x18($sp)
    /* F8F48 80108748 1400B18F */  lw         $s1, 0x14($sp)
    /* F8F4C 8010874C 1000B08F */  lw         $s0, 0x10($sp)
    /* F8F50 80108750 0800E003 */  jr         $ra
    /* F8F54 80108754 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel _cd_intr_dispatch
