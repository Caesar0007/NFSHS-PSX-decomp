.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CdGetDiskType, 0x148

glabel CdGetDiskType
    /* D8D84 800E8584 D0F7BD27 */  addiu      $sp, $sp, -0x830
    /* D8D88 800E8588 01000424 */  addiu      $a0, $zero, 0x1
    /* D8D8C 800E858C 21280000 */  addu       $a1, $zero, $zero
    /* D8D90 800E8590 1808A627 */  addiu      $a2, $sp, 0x818
    /* D8D94 800E8594 2808BFAF */  sw         $ra, 0x828($sp)
    /* D8D98 800E8598 2408B1AF */  sw         $s1, 0x824($sp)
    /* D8D9C 800E859C 2DDE030C */  jal        CdControl
    /* D8DA0 800E85A0 2008B0AF */   sw        $s0, 0x820($sp)
    /* D8DA4 800E85A4 1808A293 */  lbu        $v0, 0x818($sp)
    /* D8DA8 800E85A8 00000000 */  nop
    /* D8DAC 800E85AC 10004230 */  andi       $v0, $v0, 0x10
    /* D8DB0 800E85B0 41004014 */  bnez       $v0, .L800E86B8
    /* D8DB4 800E85B4 10000224 */   addiu     $v0, $zero, 0x10
    /* D8DB8 800E85B8 10000424 */  addiu      $a0, $zero, 0x10
    /* D8DBC 800E85BC 3DDF030C */  jal        CdIntToPos
    /* D8DC0 800E85C0 1000A527 */   addiu     $a1, $sp, 0x10
    /* D8DC4 800E85C4 1B000424 */  addiu      $a0, $zero, 0x1B
    /* D8DC8 800E85C8 1000A527 */  addiu      $a1, $sp, 0x10
    /* D8DCC 800E85CC 2DDE030C */  jal        CdControl
    /* D8DD0 800E85D0 21300000 */   addu      $a2, $zero, $zero
    /* D8DD4 800E85D4 21800000 */  addu       $s0, $zero, $zero
    /* D8DD8 800E85D8 01001124 */  addiu      $s1, $zero, 0x1
    /* D8DDC 800E85DC 21200000 */  addu       $a0, $zero, $zero
  .L800E85E0:
    /* D8DE0 800E85E0 1BDE030C */  jal        CdReady
    /* D8DE4 800E85E4 1808A527 */   addiu     $a1, $sp, 0x818
    /* D8DE8 800E85E8 21184000 */  addu       $v1, $v0, $zero
    /* D8DEC 800E85EC 09007110 */  beq        $v1, $s1, .L800E8614
    /* D8DF0 800E85F0 01001026 */   addiu     $s0, $s0, 0x1
    /* D8DF4 800E85F4 0A00022A */  slti       $v0, $s0, 0xA
    /* D8DF8 800E85F8 06004010 */  beqz       $v0, .L800E8614
    /* D8DFC 800E85FC 1B000424 */   addiu     $a0, $zero, 0x1B
    /* D8E00 800E8600 1000A527 */  addiu      $a1, $sp, 0x10
    /* D8E04 800E8604 2DDE030C */  jal        CdControl
    /* D8E08 800E8608 21300000 */   addu      $a2, $zero, $zero
    /* D8E0C 800E860C 78A10308 */  j          .L800E85E0
    /* D8E10 800E8610 21200000 */   addu      $a0, $zero, $zero
  .L800E8614:
    /* D8E14 800E8614 01000224 */  addiu      $v0, $zero, 0x1
    /* D8E18 800E8618 18006210 */  beq        $v1, $v0, .L800E867C
    /* D8E1C 800E861C 09000424 */   addiu     $a0, $zero, 0x9
    /* D8E20 800E8620 1808A393 */  lbu        $v1, 0x818($sp)
    /* D8E24 800E8624 00000000 */  nop
    /* D8E28 800E8628 10006230 */  andi       $v0, $v1, 0x10
    /* D8E2C 800E862C 22004014 */  bnez       $v0, .L800E86B8
    /* D8E30 800E8630 10000224 */   addiu     $v0, $zero, 0x10
    /* D8E34 800E8634 01006230 */  andi       $v0, $v1, 0x1
    /* D8E38 800E8638 0B004010 */  beqz       $v0, .L800E8668
    /* D8E3C 800E863C 00000000 */   nop
    /* D8E40 800E8640 1908A293 */  lbu        $v0, 0x819($sp)
    /* D8E44 800E8644 00000000 */  nop
    /* D8E48 800E8648 40004230 */  andi       $v0, $v0, 0x40
    /* D8E4C 800E864C 06004010 */  beqz       $v0, .L800E8668
    /* D8E50 800E8650 00000000 */   nop
    /* D8E54 800E8654 0580043C */  lui        $a0, %hi(D_80056C18)
    /* D8E58 800E8658 2B0A040C */  jal        printf
    /* D8E5C 800E865C 186C8424 */   addiu     $a0, $a0, %lo(D_80056C18)
    /* D8E60 800E8660 AEA10308 */  j          .L800E86B8
    /* D8E64 800E8664 01000224 */   addiu     $v0, $zero, 0x1
  .L800E8668:
    /* D8E68 800E8668 1808A293 */  lbu        $v0, 0x818($sp)
    /* D8E6C 800E866C 00000000 */  nop
    /* D8E70 800E8670 02004230 */  andi       $v0, $v0, 0x2
    /* D8E74 800E8674 AEA10308 */  j          .L800E86B8
    /* D8E78 800E8678 2B100200 */   sltu      $v0, $zero, $v0
  .L800E867C:
    /* D8E7C 800E867C 21280000 */  addu       $a1, $zero, $zero
    /* D8E80 800E8680 2DDE030C */  jal        CdControl
    /* D8E84 800E8684 21300000 */   addu      $a2, $zero, $zero
    /* D8E88 800E8688 1800A427 */  addiu      $a0, $sp, 0x18
    /* D8E8C 800E868C 1CDF030C */  jal        CdGetSector
    /* D8E90 800E8690 00020524 */   addiu     $a1, $zero, 0x200
    /* D8E94 800E8694 1900A427 */  addiu      $a0, $sp, 0x19
    /* D8E98 800E8698 0580053C */  lui        $a1, %hi(D_80056C28)
    /* D8E9C 800E869C 286CA524 */  addiu      $a1, $a1, %lo(D_80056C28)
    /* D8EA0 800E86A0 74AC030C */  jal        strncmp
    /* D8EA4 800E86A4 05000624 */   addiu     $a2, $zero, 0x5
    /* D8EA8 800E86A8 21184000 */  addu       $v1, $v0, $zero
    /* D8EAC 800E86AC 02006014 */  bnez       $v1, .L800E86B8
    /* D8EB0 800E86B0 01000224 */   addiu     $v0, $zero, 0x1
    /* D8EB4 800E86B4 02000224 */  addiu      $v0, $zero, 0x2
  .L800E86B8:
    /* D8EB8 800E86B8 2808BF8F */  lw         $ra, 0x828($sp)
    /* D8EBC 800E86BC 2408B18F */  lw         $s1, 0x824($sp)
    /* D8EC0 800E86C0 2008B08F */  lw         $s0, 0x820($sp)
    /* D8EC4 800E86C4 0800E003 */  jr         $ra
    /* D8EC8 800E86C8 3008BD27 */   addiu     $sp, $sp, 0x830
endlabel CdGetDiskType
    /* D8ECC 800E86CC 00000000 */  nop
    /* D8ED0 800E86D0 00000000 */  nop
    /* D8ED4 800E86D4 00000000 */  nop
