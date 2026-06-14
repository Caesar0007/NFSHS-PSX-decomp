.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SNDfxmasterlevel, 0xB8

glabel SNDfxmasterlevel
    /* D75D0 800E6DD0 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* D75D4 800E6DD4 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* D75D8 800E6DD8 21988000 */  addu       $s3, $a0, $zero
    /* D75DC 800E6DDC 1480023C */  lui        $v0, %hi(sndgs)
    /* D75E0 800E6DE0 1400B1AF */  sw         $s1, 0x14($sp)
    /* D75E4 800E6DE4 60785124 */  addiu      $s1, $v0, %lo(sndgs)
    /* D75E8 800E6DE8 00111300 */  sll        $v0, $s3, 4
    /* D75EC 800E6DEC 21105100 */  addu       $v0, $v0, $s1
    /* D75F0 800E6DF0 2000BFAF */  sw         $ra, 0x20($sp)
    /* D75F4 800E6DF4 1800B2AF */  sw         $s2, 0x18($sp)
    /* D75F8 800E6DF8 1000B0AF */  sw         $s0, 0x10($sp)
    /* D75FC 800E6DFC 6F01040C */  jal        iSNDplatformfxmasterlevel
    /* D7600 800E6E00 A00045AC */   sw        $a1, 0xA0($v0)
    /* D7604 800E6E04 19004004 */  bltz       $v0, .L800E6E6C
    /* D7608 800E6E08 00000000 */   nop
    /* D760C 800E6E0C 3C002282 */  lb         $v0, 0x3C($s1)
    /* D7610 800E6E10 00000000 */  nop
    /* D7614 800E6E14 15004010 */  beqz       $v0, .L800E6E6C
    /* D7618 800E6E18 21100000 */   addu      $v0, $zero, $zero
    /* D761C 800E6E1C 11002292 */  lbu        $v0, 0x11($s1)
    /* D7620 800E6E20 00000000 */  nop
    /* D7624 800E6E24 10004010 */  beqz       $v0, .L800E6E68
    /* D7628 800E6E28 21800000 */   addu      $s0, $zero, $zero
    /* D762C 800E6E2C 21902002 */  addu       $s2, $s1, $zero
    /* D7630 800E6E30 21880002 */  addu       $s1, $s0, $zero
  .L800E6E34:
    /* D7634 800E6E34 9400428E */  lw         $v0, 0x94($s2)
    /* D7638 800E6E38 21286002 */  addu       $a1, $s3, $zero
    /* D763C 800E6E3C 21102202 */  addu       $v0, $s1, $v0
    /* D7640 800E6E40 0000448C */  lw         $a0, 0x0($v0)
    /* D7644 800E6E44 21105300 */  addu       $v0, $v0, $s3
    /* D7648 800E6E48 35004680 */  lb         $a2, 0x35($v0)
    /* D764C 800E6E4C 7A01040C */  jal        SNDfxlevel
    /* D7650 800E6E50 01001026 */   addiu     $s0, $s0, 0x1
    /* D7654 800E6E54 11004292 */  lbu        $v0, 0x11($s2)
    /* D7658 800E6E58 00000000 */  nop
    /* D765C 800E6E5C 2A100202 */  slt        $v0, $s0, $v0
    /* D7660 800E6E60 F4FF4014 */  bnez       $v0, .L800E6E34
    /* D7664 800E6E64 64003126 */   addiu     $s1, $s1, 0x64
  .L800E6E68:
    /* D7668 800E6E68 21100000 */  addu       $v0, $zero, $zero
  .L800E6E6C:
    /* D766C 800E6E6C 2000BF8F */  lw         $ra, 0x20($sp)
    /* D7670 800E6E70 1C00B38F */  lw         $s3, 0x1C($sp)
    /* D7674 800E6E74 1800B28F */  lw         $s2, 0x18($sp)
    /* D7678 800E6E78 1400B18F */  lw         $s1, 0x14($sp)
    /* D767C 800E6E7C 1000B08F */  lw         $s0, 0x10($sp)
    /* D7680 800E6E80 0800E003 */  jr         $ra
    /* D7684 800E6E84 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel SNDfxmasterlevel
