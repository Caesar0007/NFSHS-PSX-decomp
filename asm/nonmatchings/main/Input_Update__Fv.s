.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Input_Update__Fv, 0xD90

glabel Input_Update__Fv
    /* 8CC78 8009C478 48FFBD27 */  addiu      $sp, $sp, -0xB8
    /* 8CC7C 8009C47C B400BFAF */  sw         $ra, 0xB4($sp)
    /* 8CC80 8009C480 B000BEAF */  sw         $fp, 0xB0($sp)
    /* 8CC84 8009C484 AC00B7AF */  sw         $s7, 0xAC($sp)
    /* 8CC88 8009C488 A800B6AF */  sw         $s6, 0xA8($sp)
    /* 8CC8C 8009C48C A400B5AF */  sw         $s5, 0xA4($sp)
    /* 8CC90 8009C490 A000B4AF */  sw         $s4, 0xA0($sp)
    /* 8CC94 8009C494 9C00B3AF */  sw         $s3, 0x9C($sp)
    /* 8CC98 8009C498 9800B2AF */  sw         $s2, 0x98($sp)
    /* 8CC9C 8009C49C 9400B1AF */  sw         $s1, 0x94($sp)
    /* 8CCA0 8009C4A0 36F5020C */  jal        Device_Update__Fv
    /* 8CCA4 8009C4A4 9000B0AF */   sw        $s0, 0x90($sp)
    /* 8CCA8 8009C4A8 01000324 */  addiu      $v1, $zero, 0x1
    /* 8CCAC 8009C4AC 1F001E24 */  addiu      $fp, $zero, 0x1F
    /* 8CCB0 8009C4B0 2F00A227 */  addiu      $v0, $sp, 0x2F
  .L8009C4B4:
    /* 8CCB4 8009C4B4 000043A0 */  sb         $v1, 0x0($v0)
    /* 8CCB8 8009C4B8 FFFFDE27 */  addiu      $fp, $fp, -0x1
    /* 8CCBC 8009C4BC FDFFC107 */  bgez       $fp, .L8009C4B4
    /* 8CCC0 8009C4C0 FFFF4224 */   addiu     $v0, $v0, -0x1
    /* 8CCC4 8009C4C4 1180023C */  lui        $v0, %hi(Input_gHandler)
    /* 8CCC8 8009C4C8 143C5224 */  addiu      $s2, $v0, %lo(Input_gHandler)
    /* 8CCCC 8009C4CC 14800B3C */  lui        $t3, %hi(Input_gResults)
    /* 8CCD0 8009C4D0 24D26B25 */  addiu      $t3, $t3, %lo(Input_gResults)
    /* 8CCD4 8009C4D4 21F00000 */  addu       $fp, $zero, $zero
    /* 8CCD8 8009C4D8 01001624 */  addiu      $s6, $zero, 0x1
    /* 8CCDC 8009C4DC 7000ABAF */  sw         $t3, 0x70($sp)
    /* 8CCE0 8009C4E0 3000AB27 */  addiu      $t3, $sp, 0x30
    /* 8CCE4 8009C4E4 1180023C */  lui        $v0, %hi(Input_gDBFlags)
    /* 8CCE8 8009C4E8 F43E4224 */  addiu      $v0, $v0, %lo(Input_gDBFlags)
    /* 8CCEC 8009C4EC 1480143C */  lui        $s4, %hi(Input_gResults + 0x3)
    /* 8CCF0 8009C4F0 27D29426 */  addiu      $s4, $s4, %lo(Input_gResults + 0x3)
    /* 8CCF4 8009C4F4 7400A0AF */  sw         $zero, 0x74($sp)
    /* 8CCF8 8009C4F8 7800ABAF */  sw         $t3, 0x78($sp)
    /* 8CCFC 8009C4FC 7C00A2AF */  sw         $v0, 0x7C($sp)
    /* 8CD00 8009C500 8000A0AF */  sw         $zero, 0x80($sp)
    /* 8CD04 8009C504 8400A0AF */  sw         $zero, 0x84($sp)
  .L8009C508:
    /* 8CD08 8009C508 0200C22B */  slti       $v0, $fp, 0x2
    /* 8CD0C 8009C50C 02034010 */  beqz       $v0, .L8009D118
    /* 8CD10 8009C510 21B80000 */   addu      $s7, $zero, $zero
    /* 8CD14 8009C514 2180E002 */  addu       $s0, $s7, $zero
  .L8009C518:
    /* 8CD18 8009C518 0000448E */  lw         $a0, 0x0($s2)
    /* 8CD1C 8009C51C 00000000 */  nop
    /* 8CD20 8009C520 0F008010 */  beqz       $a0, .L8009C560
    /* 8CD24 8009C524 FF008330 */   andi      $v1, $a0, 0xFF
    /* 8CD28 8009C528 40100300 */  sll        $v0, $v1, 1
    /* 8CD2C 8009C52C 21104300 */  addu       $v0, $v0, $v1
    /* 8CD30 8009C530 80100200 */  sll        $v0, $v0, 2
    /* 8CD34 8009C534 12800B3C */  lui        $t3, %hi(Device_gDeviceList)
    /* 8CD38 8009C538 18EC6B25 */  addiu      $t3, $t3, %lo(Device_gDeviceList)
    /* 8CD3C 8009C53C 21104B00 */  addu       $v0, $v0, $t3
    /* 8CD40 8009C540 0400428C */  lw         $v0, 0x4($v0)
    /* 8CD44 8009C544 00000000 */  nop
    /* 8CD48 8009C548 09F84000 */  jalr       $v0
    /* 8CD4C 8009C54C 03220400 */   sra       $a0, $a0, 8
    /* 8CD50 8009C550 41004228 */  slti       $v0, $v0, 0x41
    /* 8CD54 8009C554 02004014 */  bnez       $v0, .L8009C560
    /* 8CD58 8009C558 00000000 */   nop
    /* 8CD5C 8009C55C 01001726 */  addiu      $s7, $s0, 0x1
  .L8009C560:
    /* 8CD60 8009C560 01001026 */  addiu      $s0, $s0, 0x1
    /* 8CD64 8009C564 0200022A */  slti       $v0, $s0, 0x2
    /* 8CD68 8009C568 EBFF4014 */  bnez       $v0, .L8009C518
    /* 8CD6C 8009C56C 04005226 */   addiu     $s2, $s2, 0x4
    /* 8CD70 8009C570 8000AB8F */  lw         $t3, 0x80($sp)
    /* 8CD74 8009C574 1480023C */  lui        $v0, %hi(Input_gMode)
    /* 8CD78 8009C578 38D24224 */  addiu      $v0, $v0, %lo(Input_gMode)
    /* 8CD7C 8009C57C 21106201 */  addu       $v0, $t3, $v0
    /* 8CD80 8009C580 2001E016 */  bnez       $s7, .L8009CA04
    /* 8CD84 8009C584 000057AC */   sw        $s7, 0x0($v0)
    /* 8CD88 8009C588 0000448E */  lw         $a0, 0x0($s2)
    /* 8CD8C 8009C58C 04005226 */  addiu      $s2, $s2, 0x4
    /* 8CD90 8009C590 21800000 */  addu       $s0, $zero, $zero
    /* 8CD94 8009C594 12800B3C */  lui        $t3, %hi(Device_gDeviceList)
    /* 8CD98 8009C598 18EC6B25 */  addiu      $t3, $t3, %lo(Device_gDeviceList)
    /* 8CD9C 8009C59C FF008330 */  andi       $v1, $a0, 0xFF
    /* 8CDA0 8009C5A0 40100300 */  sll        $v0, $v1, 1
    /* 8CDA4 8009C5A4 21104300 */  addu       $v0, $v0, $v1
    /* 8CDA8 8009C5A8 80100200 */  sll        $v0, $v0, 2
    /* 8CDAC 8009C5AC 21104B00 */  addu       $v0, $v0, $t3
    /* 8CDB0 8009C5B0 0400428C */  lw         $v0, 0x4($v0)
    /* 8CDB4 8009C5B4 00000000 */  nop
    /* 8CDB8 8009C5B8 09F84000 */  jalr       $v0
    /* 8CDBC 8009C5BC 03220400 */   sra       $a0, $a0, 8
    /* 8CDC0 8009C5C0 21884000 */  addu       $s1, $v0, $zero
    /* 8CDC4 8009C5C4 0000448E */  lw         $a0, 0x0($s2)
    /* 8CDC8 8009C5C8 04005226 */  addiu      $s2, $s2, 0x4
    /* 8CDCC 8009C5CC 12800B3C */  lui        $t3, %hi(Device_gDeviceList)
    /* 8CDD0 8009C5D0 18EC6B25 */  addiu      $t3, $t3, %lo(Device_gDeviceList)
    /* 8CDD4 8009C5D4 FF008330 */  andi       $v1, $a0, 0xFF
    /* 8CDD8 8009C5D8 40100300 */  sll        $v0, $v1, 1
    /* 8CDDC 8009C5DC 21104300 */  addu       $v0, $v0, $v1
    /* 8CDE0 8009C5E0 80100200 */  sll        $v0, $v0, 2
    /* 8CDE4 8009C5E4 21104B00 */  addu       $v0, $v0, $t3
    /* 8CDE8 8009C5E8 0400428C */  lw         $v0, 0x4($v0)
    /* 8CDEC 8009C5EC 00000000 */  nop
    /* 8CDF0 8009C5F0 09F84000 */  jalr       $v0
    /* 8CDF4 8009C5F4 03220400 */   sra       $a0, $a0, 8
    /* 8CDF8 8009C5F8 23105100 */  subu       $v0, $v0, $s1
    /* 8CDFC 8009C5FC C21F0200 */  srl        $v1, $v0, 31
    /* 8CE00 8009C600 21104300 */  addu       $v0, $v0, $v1
    /* 8CE04 8009C604 7000AB8F */  lw         $t3, 0x70($sp)
    /* 8CE08 8009C608 43100200 */  sra        $v0, $v0, 1
    /* 8CE0C 8009C60C 000062A1 */  sb         $v0, 0x0($t3)
    /* 8CE10 8009C610 0000448E */  lw         $a0, 0x0($s2)
    /* 8CE14 8009C614 04005226 */  addiu      $s2, $s2, 0x4
    /* 8CE18 8009C618 12800B3C */  lui        $t3, %hi(Device_gDeviceList)
    /* 8CE1C 8009C61C 18EC6B25 */  addiu      $t3, $t3, %lo(Device_gDeviceList)
    /* 8CE20 8009C620 FF008330 */  andi       $v1, $a0, 0xFF
    /* 8CE24 8009C624 40100300 */  sll        $v0, $v1, 1
    /* 8CE28 8009C628 21104300 */  addu       $v0, $v0, $v1
    /* 8CE2C 8009C62C 80100200 */  sll        $v0, $v0, 2
    /* 8CE30 8009C630 21104B00 */  addu       $v0, $v0, $t3
    /* 8CE34 8009C634 0400428C */  lw         $v0, 0x4($v0)
    /* 8CE38 8009C638 00000000 */  nop
    /* 8CE3C 8009C63C 09F84000 */  jalr       $v0
    /* 8CE40 8009C640 03220400 */   sra       $a0, $a0, 8
    /* 8CE44 8009C644 FEFF82A2 */  sb         $v0, -0x2($s4)
    /* 8CE48 8009C648 0000448E */  lw         $a0, 0x0($s2)
    /* 8CE4C 8009C64C 04005226 */  addiu      $s2, $s2, 0x4
    /* 8CE50 8009C650 12800B3C */  lui        $t3, %hi(Device_gDeviceList)
    /* 8CE54 8009C654 18EC6B25 */  addiu      $t3, $t3, %lo(Device_gDeviceList)
    /* 8CE58 8009C658 FF008330 */  andi       $v1, $a0, 0xFF
    /* 8CE5C 8009C65C 40100300 */  sll        $v0, $v1, 1
    /* 8CE60 8009C660 21104300 */  addu       $v0, $v0, $v1
    /* 8CE64 8009C664 80100200 */  sll        $v0, $v0, 2
    /* 8CE68 8009C668 21104B00 */  addu       $v0, $v0, $t3
    /* 8CE6C 8009C66C 0400428C */  lw         $v0, 0x4($v0)
    /* 8CE70 8009C670 00000000 */  nop
    /* 8CE74 8009C674 09F84000 */  jalr       $v0
    /* 8CE78 8009C678 03220400 */   sra       $a0, $a0, 8
    /* 8CE7C 8009C67C FFFF82A2 */  sb         $v0, -0x1($s4)
  .L8009C680:
    /* 8CE80 8009C680 0000448E */  lw         $a0, 0x0($s2)
    /* 8CE84 8009C684 00000000 */  nop
    /* 8CE88 8009C688 13008010 */  beqz       $a0, .L8009C6D8
    /* 8CE8C 8009C68C FF008330 */   andi      $v1, $a0, 0xFF
    /* 8CE90 8009C690 40100300 */  sll        $v0, $v1, 1
    /* 8CE94 8009C694 21104300 */  addu       $v0, $v0, $v1
    /* 8CE98 8009C698 80100200 */  sll        $v0, $v0, 2
    /* 8CE9C 8009C69C 12800B3C */  lui        $t3, %hi(Device_gDeviceList)
    /* 8CEA0 8009C6A0 18EC6B25 */  addiu      $t3, $t3, %lo(Device_gDeviceList)
    /* 8CEA4 8009C6A4 21104B00 */  addu       $v0, $v0, $t3
    /* 8CEA8 8009C6A8 0400428C */  lw         $v0, 0x4($v0)
    /* 8CEAC 8009C6AC 00000000 */  nop
    /* 8CEB0 8009C6B0 09F84000 */  jalr       $v0
    /* 8CEB4 8009C6B4 03220400 */   sra       $a0, $a0, 8
    /* 8CEB8 8009C6B8 41004228 */  slti       $v0, $v0, 0x41
    /* 8CEBC 8009C6BC 07004014 */  bnez       $v0, .L8009C6DC
    /* 8CEC0 8009C6C0 04101602 */   sllv      $v0, $s6, $s0
    /* 8CEC4 8009C6C4 00008292 */  lbu        $v0, 0x0($s4)
    /* 8CEC8 8009C6C8 04181602 */  sllv       $v1, $s6, $s0
    /* 8CECC 8009C6CC 25104300 */  or         $v0, $v0, $v1
    /* 8CED0 8009C6D0 BB710208 */  j          .L8009C6EC
    /* 8CED4 8009C6D4 000082A2 */   sb        $v0, 0x0($s4)
  .L8009C6D8:
    /* 8CED8 8009C6D8 04101602 */  sllv       $v0, $s6, $s0
  .L8009C6DC:
    /* 8CEDC 8009C6DC 00008392 */  lbu        $v1, 0x0($s4)
    /* 8CEE0 8009C6E0 27100200 */  nor        $v0, $zero, $v0
    /* 8CEE4 8009C6E4 24186200 */  and        $v1, $v1, $v0
    /* 8CEE8 8009C6E8 000083A2 */  sb         $v1, 0x0($s4)
  .L8009C6EC:
    /* 8CEEC 8009C6EC 01001026 */  addiu      $s0, $s0, 0x1
    /* 8CEF0 8009C6F0 0200022A */  slti       $v0, $s0, 0x2
    /* 8CEF4 8009C6F4 E2FF4014 */  bnez       $v0, .L8009C680
    /* 8CEF8 8009C6F8 04005226 */   addiu     $s2, $s2, 0x4
    /* 8CEFC 8009C6FC 21A80000 */  addu       $s5, $zero, $zero
    /* 8CF00 8009C700 10000424 */  addiu      $a0, $zero, 0x10
    /* 8CF04 8009C704 7800AB8F */  lw         $t3, 0x78($sp)
    /* 8CF08 8009C708 00008292 */  lbu        $v0, 0x0($s4)
    /* 8CF0C 8009C70C 21186401 */  addu       $v1, $t3, $a0
    /* 8CF10 8009C710 07004230 */  andi       $v0, $v0, 0x7
    /* 8CF14 8009C714 000082A2 */  sb         $v0, 0x0($s4)
  .L8009C718:
    /* 8CF18 8009C718 000076A0 */  sb         $s6, 0x0($v1)
    /* 8CF1C 8009C71C FFFF8424 */  addiu      $a0, $a0, -0x1
    /* 8CF20 8009C720 FDFF8104 */  bgez       $a0, .L8009C718
    /* 8CF24 8009C724 FFFF6324 */   addiu     $v1, $v1, -0x1
    /* 8CF28 8009C728 21800000 */  addu       $s0, $zero, $zero
    /* 8CF2C 8009C72C 8400B78F */  lw         $s7, 0x84($sp)
    /* 8CF30 8009C730 7C00B38F */  lw         $s3, 0x7C($sp)
    /* 8CF34 8009C734 2188E002 */  addu       $s1, $s7, $zero
  .L8009C738:
    /* 8CF38 8009C738 1100022A */  slti       $v0, $s0, 0x11
    /* 8CF3C 8009C73C 4C004010 */  beqz       $v0, .L8009C870
    /* 8CF40 8009C740 00000000 */   nop
    /* 8CF44 8009C744 0000448E */  lw         $a0, 0x0($s2)
    /* 8CF48 8009C748 00000000 */  nop
    /* 8CF4C 8009C74C 44008010 */  beqz       $a0, .L8009C860
    /* 8CF50 8009C750 FF008330 */   andi      $v1, $a0, 0xFF
    /* 8CF54 8009C754 40100300 */  sll        $v0, $v1, 1
    /* 8CF58 8009C758 21104300 */  addu       $v0, $v0, $v1
    /* 8CF5C 8009C75C 80100200 */  sll        $v0, $v0, 2
    /* 8CF60 8009C760 12800B3C */  lui        $t3, %hi(Device_gDeviceList)
    /* 8CF64 8009C764 18EC6B25 */  addiu      $t3, $t3, %lo(Device_gDeviceList)
    /* 8CF68 8009C768 21104B00 */  addu       $v0, $v0, $t3
    /* 8CF6C 8009C76C 0400428C */  lw         $v0, 0x4($v0)
    /* 8CF70 8009C770 00000000 */  nop
    /* 8CF74 8009C774 09F84000 */  jalr       $v0
    /* 8CF78 8009C778 03220400 */   sra       $a0, $a0, 8
    /* 8CF7C 8009C77C 41004228 */  slti       $v0, $v0, 0x41
    /* 8CF80 8009C780 2F004014 */  bnez       $v0, .L8009C840
    /* 8CF84 8009C784 04101602 */   sllv      $v0, $s6, $s0
    /* 8CF88 8009C788 11800B3C */  lui        $t3, %hi(Input_gPressTime)
    /* 8CF8C 8009C78C 943F6B25 */  addiu      $t3, $t3, %lo(Input_gPressTime)
    /* 8CF90 8009C790 21182B02 */  addu       $v1, $s1, $t3
    /* 8CF94 8009C794 0000628C */  lw         $v0, 0x0($v1)
    /* 8CF98 8009C798 00000000 */  nop
    /* 8CF9C 8009C79C 01004224 */  addiu      $v0, $v0, 0x1
    /* 8CFA0 8009C7A0 000062AC */  sw         $v0, 0x0($v1)
    /* 8CFA4 8009C7A4 06004228 */  slti       $v0, $v0, 0x6
    /* 8CFA8 8009C7A8 09004014 */  bnez       $v0, .L8009C7D0
    /* 8CFAC 8009C7AC 21200000 */   addu      $a0, $zero, $zero
    /* 8CFB0 8009C7B0 0000648E */  lw         $a0, 0x0($s3)
    /* 8CFB4 8009C7B4 04181602 */  sllv       $v1, $s6, $s0
    /* 8CFB8 8009C7B8 24108300 */  and        $v0, $a0, $v1
    /* 8CFBC 8009C7BC 03004014 */  bnez       $v0, .L8009C7CC
    /* 8CFC0 8009C7C0 25108300 */   or        $v0, $a0, $v1
    /* 8CFC4 8009C7C4 01001526 */  addiu      $s5, $s0, 0x1
    /* 8CFC8 8009C7C8 000062AE */  sw         $v0, 0x0($s3)
  .L8009C7CC:
    /* 8CFCC 8009C7CC 21200000 */  addu       $a0, $zero, $zero
  .L8009C7D0:
    /* 8CFD0 8009C7D0 EFFF0726 */  addiu      $a3, $s0, -0x11
    /* 8CFD4 8009C7D4 11800B3C */  lui        $t3, %hi(Input_gPressTime)
    /* 8CFD8 8009C7D8 943F6B25 */  addiu      $t3, $t3, %lo(Input_gPressTime)
    /* 8CFDC 8009C7DC 21302B02 */  addu       $a2, $s1, $t3
    /* 8CFE0 8009C7E0 2128E002 */  addu       $a1, $s7, $zero
  .L8009C7E4:
    /* 8CFE4 8009C7E4 23108700 */  subu       $v0, $a0, $a3
    /* 8CFE8 8009C7E8 80100200 */  sll        $v0, $v0, 2
    /* 8CFEC 8009C7EC 21105200 */  addu       $v0, $v0, $s2
    /* 8CFF0 8009C7F0 0000438C */  lw         $v1, 0x0($v0)
    /* 8CFF4 8009C7F4 0000428E */  lw         $v0, 0x0($s2)
    /* 8CFF8 8009C7F8 00000000 */  nop
    /* 8CFFC 8009C7FC 0A006214 */  bne        $v1, $v0, .L8009C828
    /* 8D000 8009C800 00000000 */   nop
    /* 8D004 8009C804 7800AB8F */  lw         $t3, 0x78($sp)
    /* 8D008 8009C808 00000000 */  nop
    /* 8D00C 8009C80C 21106401 */  addu       $v0, $t3, $a0
    /* 8D010 8009C810 11800B3C */  lui        $t3, %hi(Input_gPressTime)
    /* 8D014 8009C814 943F6B25 */  addiu      $t3, $t3, %lo(Input_gPressTime)
    /* 8D018 8009C818 000040A0 */  sb         $zero, 0x0($v0)
    /* 8D01C 8009C81C 0000C38C */  lw         $v1, 0x0($a2)
    /* 8D020 8009C820 2110AB00 */  addu       $v0, $a1, $t3
    /* 8D024 8009C824 000043AC */  sw         $v1, 0x0($v0)
  .L8009C828:
    /* 8D028 8009C828 01008424 */  addiu      $a0, $a0, 0x1
    /* 8D02C 8009C82C 11008228 */  slti       $v0, $a0, 0x11
    /* 8D030 8009C830 ECFF4014 */  bnez       $v0, .L8009C7E4
    /* 8D034 8009C834 0400A524 */   addiu     $a1, $a1, 0x4
    /* 8D038 8009C838 19720208 */  j          .L8009C864
    /* 8D03C 8009C83C 04005226 */   addiu     $s2, $s2, 0x4
  .L8009C840:
    /* 8D040 8009C840 27100200 */  nor        $v0, $zero, $v0
    /* 8D044 8009C844 11800B3C */  lui        $t3, %hi(Input_gPressTime)
    /* 8D048 8009C848 0000638E */  lw         $v1, 0x0($s3)
    /* 8D04C 8009C84C 943F6B25 */  addiu      $t3, $t3, %lo(Input_gPressTime)
    /* 8D050 8009C850 24186200 */  and        $v1, $v1, $v0
    /* 8D054 8009C854 21102B02 */  addu       $v0, $s1, $t3
    /* 8D058 8009C858 000063AE */  sw         $v1, 0x0($s3)
    /* 8D05C 8009C85C 000040AC */  sw         $zero, 0x0($v0)
  .L8009C860:
    /* 8D060 8009C860 04005226 */  addiu      $s2, $s2, 0x4
  .L8009C864:
    /* 8D064 8009C864 04003126 */  addiu      $s1, $s1, 0x4
    /* 8D068 8009C868 CE710208 */  j          .L8009C738
    /* 8D06C 8009C86C 01001026 */   addiu     $s0, $s0, 0x1
  .L8009C870:
    /* 8D070 8009C870 21800000 */  addu       $s0, $zero, $zero
    /* 8D074 8009C874 7C00B18F */  lw         $s1, 0x7C($sp)
  .L8009C878:
    /* 8D078 8009C878 0000448E */  lw         $a0, 0x0($s2)
    /* 8D07C 8009C87C 00000000 */  nop
    /* 8D080 8009C880 37008010 */  beqz       $a0, .L8009C960
    /* 8D084 8009C884 FF008330 */   andi      $v1, $a0, 0xFF
    /* 8D088 8009C888 40100300 */  sll        $v0, $v1, 1
    /* 8D08C 8009C88C 21104300 */  addu       $v0, $v0, $v1
    /* 8D090 8009C890 80100200 */  sll        $v0, $v0, 2
    /* 8D094 8009C894 12800B3C */  lui        $t3, %hi(Device_gDeviceList)
    /* 8D098 8009C898 18EC6B25 */  addiu      $t3, $t3, %lo(Device_gDeviceList)
    /* 8D09C 8009C89C 21104B00 */  addu       $v0, $v0, $t3
    /* 8D0A0 8009C8A0 0400428C */  lw         $v0, 0x4($v0)
    /* 8D0A4 8009C8A4 00000000 */  nop
    /* 8D0A8 8009C8A8 09F84000 */  jalr       $v0
    /* 8D0AC 8009C8AC 03220400 */   sra       $a0, $a0, 8
    /* 8D0B0 8009C8B0 41004228 */  slti       $v0, $v0, 0x41
    /* 8D0B4 8009C8B4 10004014 */  bnez       $v0, .L8009C8F8
    /* 8D0B8 8009C8B8 80101000 */   sll       $v0, $s0, 2
    /* 8D0BC 8009C8BC 7800AB8F */  lw         $t3, 0x78($sp)
    /* 8D0C0 8009C8C0 00000000 */  nop
    /* 8D0C4 8009C8C4 21107001 */  addu       $v0, $t3, $s0
    /* 8D0C8 8009C8C8 00004290 */  lbu        $v0, 0x0($v0)
    /* 8D0CC 8009C8CC 00000000 */  nop
    /* 8D0D0 8009C8D0 23004010 */  beqz       $v0, .L8009C960
    /* 8D0D4 8009C8D4 04181602 */   sllv      $v1, $s6, $s0
    /* 8D0D8 8009C8D8 0000248E */  lw         $a0, 0x0($s1)
    /* 8D0DC 8009C8DC 00000000 */  nop
    /* 8D0E0 8009C8E0 24108300 */  and        $v0, $a0, $v1
    /* 8D0E4 8009C8E4 1E004014 */  bnez       $v0, .L8009C960
    /* 8D0E8 8009C8E8 25108300 */   or        $v0, $a0, $v1
    /* 8D0EC 8009C8EC 01001526 */  addiu      $s5, $s0, 0x1
    /* 8D0F0 8009C8F0 58720208 */  j          .L8009C960
    /* 8D0F4 8009C8F4 000022AE */   sw        $v0, 0x0($s1)
  .L8009C8F8:
    /* 8D0F8 8009C8F8 8400AB8F */  lw         $t3, 0x84($sp)
    /* 8D0FC 8009C8FC 00000000 */  nop
    /* 8D100 8009C900 21104B00 */  addu       $v0, $v0, $t3
    /* 8D104 8009C904 11800B3C */  lui        $t3, %hi(Input_gPressTime)
    /* 8D108 8009C908 943F6B25 */  addiu      $t3, $t3, %lo(Input_gPressTime)
    /* 8D10C 8009C90C 21284B00 */  addu       $a1, $v0, $t3
    /* 8D110 8009C910 0000A28C */  lw         $v0, 0x0($a1)
    /* 8D114 8009C914 00000000 */  nop
    /* 8D118 8009C918 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* 8D11C 8009C91C 0500422C */  sltiu      $v0, $v0, 0x5
    /* 8D120 8009C920 0A004010 */  beqz       $v0, .L8009C94C
    /* 8D124 8009C924 04181602 */   sllv      $v1, $s6, $s0
    /* 8D128 8009C928 0000248E */  lw         $a0, 0x0($s1)
    /* 8D12C 8009C92C 00000000 */  nop
    /* 8D130 8009C930 24108300 */  and        $v0, $a0, $v1
    /* 8D134 8009C934 03004014 */  bnez       $v0, .L8009C944
    /* 8D138 8009C938 25108300 */   or        $v0, $a0, $v1
    /* 8D13C 8009C93C 01001526 */  addiu      $s5, $s0, 0x1
    /* 8D140 8009C940 000022AE */  sw         $v0, 0x0($s1)
  .L8009C944:
    /* 8D144 8009C944 58720208 */  j          .L8009C960
    /* 8D148 8009C948 0000A0AC */   sw        $zero, 0x0($a1)
  .L8009C94C:
    /* 8D14C 8009C94C 04101602 */  sllv       $v0, $s6, $s0
    /* 8D150 8009C950 0000238E */  lw         $v1, 0x0($s1)
    /* 8D154 8009C954 27100200 */  nor        $v0, $zero, $v0
    /* 8D158 8009C958 24186200 */  and        $v1, $v1, $v0
    /* 8D15C 8009C95C 000023AE */  sw         $v1, 0x0($s1)
  .L8009C960:
    /* 8D160 8009C960 01001026 */  addiu      $s0, $s0, 0x1
    /* 8D164 8009C964 1100022A */  slti       $v0, $s0, 0x11
    /* 8D168 8009C968 C3FF4014 */  bnez       $v0, .L8009C878
    /* 8D16C 8009C96C 04005226 */   addiu     $s2, $s2, 0x4
    /* 8D170 8009C970 21980000 */  addu       $s3, $zero, $zero
    /* 8D174 8009C974 7C00B18F */  lw         $s1, 0x7C($sp)
    /* 8D178 8009C978 21800000 */  addu       $s0, $zero, $zero
  .L8009C97C:
    /* 8D17C 8009C97C 0000448E */  lw         $a0, 0x0($s2)
    /* 8D180 8009C980 00000000 */  nop
    /* 8D184 8009C984 15008010 */  beqz       $a0, .L8009C9DC
    /* 8D188 8009C988 FF008330 */   andi      $v1, $a0, 0xFF
    /* 8D18C 8009C98C 40100300 */  sll        $v0, $v1, 1
    /* 8D190 8009C990 21104300 */  addu       $v0, $v0, $v1
    /* 8D194 8009C994 80100200 */  sll        $v0, $v0, 2
    /* 8D198 8009C998 12800B3C */  lui        $t3, %hi(Device_gDeviceList)
    /* 8D19C 8009C99C 18EC6B25 */  addiu      $t3, $t3, %lo(Device_gDeviceList)
    /* 8D1A0 8009C9A0 21104B00 */  addu       $v0, $v0, $t3
    /* 8D1A4 8009C9A4 0400428C */  lw         $v0, 0x4($v0)
    /* 8D1A8 8009C9A8 00000000 */  nop
    /* 8D1AC 8009C9AC 09F84000 */  jalr       $v0
    /* 8D1B0 8009C9B0 03220400 */   sra       $a0, $a0, 8
    /* 8D1B4 8009C9B4 41004228 */  slti       $v0, $v0, 0x41
    /* 8D1B8 8009C9B8 04004014 */  bnez       $v0, .L8009C9CC
    /* 8D1BC 8009C9BC 04101602 */   sllv      $v0, $s6, $s0
    /* 8D1C0 8009C9C0 0000238E */  lw         $v1, 0x0($s1)
    /* 8D1C4 8009C9C4 76720208 */  j          .L8009C9D8
    /* 8D1C8 8009C9C8 25186200 */   or        $v1, $v1, $v0
  .L8009C9CC:
    /* 8D1CC 8009C9CC 0000238E */  lw         $v1, 0x0($s1)
    /* 8D1D0 8009C9D0 27100200 */  nor        $v0, $zero, $v0
    /* 8D1D4 8009C9D4 24186200 */  and        $v1, $v1, $v0
  .L8009C9D8:
    /* 8D1D8 8009C9D8 000023AE */  sw         $v1, 0x0($s1)
  .L8009C9DC:
    /* 8D1DC 8009C9DC 01001026 */  addiu      $s0, $s0, 0x1
    /* 8D1E0 8009C9E0 1100022A */  slti       $v0, $s0, 0x11
    /* 8D1E4 8009C9E4 E5FF4014 */  bnez       $v0, .L8009C97C
    /* 8D1E8 8009C9E8 04005226 */   addiu     $s2, $s2, 0x4
    /* 8D1EC 8009C9EC 01007326 */  addiu      $s3, $s3, 0x1
    /* 8D1F0 8009C9F0 0200622A */  slti       $v0, $s3, 0x2
    /* 8D1F4 8009C9F4 86014010 */  beqz       $v0, .L8009D010
    /* 8D1F8 8009C9F8 00000000 */   nop
    /* 8D1FC 8009C9FC 5F720208 */  j          .L8009C97C
    /* 8D200 8009CA00 21800000 */   addu      $s0, $zero, $zero
  .L8009CA04:
    /* 8D204 8009CA04 27001024 */  addiu      $s0, $zero, 0x27
    /* 8D208 8009CA08 6F00A227 */  addiu      $v0, $sp, 0x6F
  .L8009CA0C:
    /* 8D20C 8009CA0C 000056A0 */  sb         $s6, 0x0($v0)
    /* 8D210 8009CA10 FFFF1026 */  addiu      $s0, $s0, -0x1
    /* 8D214 8009CA14 FDFF0106 */  bgez       $s0, .L8009CA0C
    /* 8D218 8009CA18 FFFF4224 */   addiu     $v0, $v0, -0x1
    /* 8D21C 8009CA1C 21800000 */  addu       $s0, $zero, $zero
    /* 8D220 8009CA20 00111700 */  sll        $v0, $s7, 4
    /* 8D224 8009CA24 21405700 */  addu       $t0, $v0, $s7
    /* 8D228 8009CA28 4800A927 */  addiu      $t1, $sp, 0x48
    /* 8D22C 8009CA2C 21284002 */  addu       $a1, $s2, $zero
  .L8009CA30:
    /* 8D230 8009CA30 21200000 */  addu       $a0, $zero, $zero
    /* 8D234 8009CA34 2138A000 */  addu       $a3, $a1, $zero
    /* 8D238 8009CA38 21303001 */  addu       $a2, $t1, $s0
    /* 8D23C 8009CA3C 21100401 */  addu       $v0, $t0, $a0
  .L8009CA40:
    /* 8D240 8009CA40 80100200 */  sll        $v0, $v0, 2
    /* 8D244 8009CA44 21105200 */  addu       $v0, $v0, $s2
    /* 8D248 8009CA48 0000E38C */  lw         $v1, 0x0($a3)
    /* 8D24C 8009CA4C 5C00428C */  lw         $v0, 0x5C($v0)
    /* 8D250 8009CA50 00000000 */  nop
    /* 8D254 8009CA54 02006214 */  bne        $v1, $v0, .L8009CA60
    /* 8D258 8009CA58 00000000 */   nop
    /* 8D25C 8009CA5C 0000C0A0 */  sb         $zero, 0x0($a2)
  .L8009CA60:
    /* 8D260 8009CA60 01008424 */  addiu      $a0, $a0, 0x1
    /* 8D264 8009CA64 11008228 */  slti       $v0, $a0, 0x11
    /* 8D268 8009CA68 F5FF4014 */  bnez       $v0, .L8009CA40
    /* 8D26C 8009CA6C 21100401 */   addu      $v0, $t0, $a0
    /* 8D270 8009CA70 01001026 */  addiu      $s0, $s0, 0x1
    /* 8D274 8009CA74 2800022A */  slti       $v0, $s0, 0x28
    /* 8D278 8009CA78 EDFF4014 */  bnez       $v0, .L8009CA30
    /* 8D27C 8009CA7C 0400A524 */   addiu     $a1, $a1, 0x4
    /* 8D280 8009CA80 21800000 */  addu       $s0, $zero, $zero
    /* 8D284 8009CA84 1180023C */  lui        $v0, %hi(Input_gHandler)
    /* 8D288 8009CA88 143C4A24 */  addiu      $t2, $v0, %lo(Input_gHandler)
    /* 8D28C 8009CA8C 00111700 */  sll        $v0, $s7, 4
    /* 8D290 8009CA90 21405700 */  addu       $t0, $v0, $s7
    /* 8D294 8009CA94 1000A927 */  addiu      $t1, $sp, 0x10
    /* 8D298 8009CA98 60020524 */  addiu      $a1, $zero, 0x260
  .L8009CA9C:
    /* 8D29C 8009CA9C 21200000 */  addu       $a0, $zero, $zero
    /* 8D2A0 8009CAA0 2138AA00 */  addu       $a3, $a1, $t2
    /* 8D2A4 8009CAA4 21303001 */  addu       $a2, $t1, $s0
    /* 8D2A8 8009CAA8 21100401 */  addu       $v0, $t0, $a0
  .L8009CAAC:
    /* 8D2AC 8009CAAC 80100200 */  sll        $v0, $v0, 2
    /* 8D2B0 8009CAB0 21105200 */  addu       $v0, $v0, $s2
    /* 8D2B4 8009CAB4 0000E38C */  lw         $v1, 0x0($a3)
    /* 8D2B8 8009CAB8 5C00428C */  lw         $v0, 0x5C($v0)
    /* 8D2BC 8009CABC 00000000 */  nop
    /* 8D2C0 8009CAC0 02006214 */  bne        $v1, $v0, .L8009CACC
    /* 8D2C4 8009CAC4 00000000 */   nop
    /* 8D2C8 8009CAC8 0000C0A0 */  sb         $zero, 0x0($a2)
  .L8009CACC:
    /* 8D2CC 8009CACC 01008424 */  addiu      $a0, $a0, 0x1
    /* 8D2D0 8009CAD0 11008228 */  slti       $v0, $a0, 0x11
    /* 8D2D4 8009CAD4 F5FF4014 */  bnez       $v0, .L8009CAAC
    /* 8D2D8 8009CAD8 21100401 */   addu      $v0, $t0, $a0
    /* 8D2DC 8009CADC 01001026 */  addiu      $s0, $s0, 0x1
    /* 8D2E0 8009CAE0 2000022A */  slti       $v0, $s0, 0x20
    /* 8D2E4 8009CAE4 EDFF4014 */  bnez       $v0, .L8009CA9C
    /* 8D2E8 8009CAE8 0400A524 */   addiu     $a1, $a1, 0x4
    /* 8D2EC 8009CAEC 0000448E */  lw         $a0, 0x0($s2)
    /* 8D2F0 8009CAF0 04005226 */  addiu      $s2, $s2, 0x4
    /* 8D2F4 8009CAF4 12800B3C */  lui        $t3, %hi(Device_gDeviceList)
    /* 8D2F8 8009CAF8 18EC6B25 */  addiu      $t3, $t3, %lo(Device_gDeviceList)
    /* 8D2FC 8009CAFC FF008330 */  andi       $v1, $a0, 0xFF
    /* 8D300 8009CB00 40100300 */  sll        $v0, $v1, 1
    /* 8D304 8009CB04 21104300 */  addu       $v0, $v0, $v1
    /* 8D308 8009CB08 80100200 */  sll        $v0, $v0, 2
    /* 8D30C 8009CB0C 21104B00 */  addu       $v0, $v0, $t3
    /* 8D310 8009CB10 0400428C */  lw         $v0, 0x4($v0)
    /* 8D314 8009CB14 00000000 */  nop
    /* 8D318 8009CB18 09F84000 */  jalr       $v0
    /* 8D31C 8009CB1C 03220400 */   sra       $a0, $a0, 8
    /* 8D320 8009CB20 21884000 */  addu       $s1, $v0, $zero
    /* 8D324 8009CB24 0000448E */  lw         $a0, 0x0($s2)
    /* 8D328 8009CB28 04005226 */  addiu      $s2, $s2, 0x4
    /* 8D32C 8009CB2C 12800B3C */  lui        $t3, %hi(Device_gDeviceList)
    /* 8D330 8009CB30 18EC6B25 */  addiu      $t3, $t3, %lo(Device_gDeviceList)
    /* 8D334 8009CB34 FF008330 */  andi       $v1, $a0, 0xFF
    /* 8D338 8009CB38 40100300 */  sll        $v0, $v1, 1
    /* 8D33C 8009CB3C 21104300 */  addu       $v0, $v0, $v1
    /* 8D340 8009CB40 80100200 */  sll        $v0, $v0, 2
    /* 8D344 8009CB44 21104B00 */  addu       $v0, $v0, $t3
    /* 8D348 8009CB48 0400428C */  lw         $v0, 0x4($v0)
    /* 8D34C 8009CB4C 00000000 */  nop
    /* 8D350 8009CB50 09F84000 */  jalr       $v0
    /* 8D354 8009CB54 03220400 */   sra       $a0, $a0, 8
    /* 8D358 8009CB58 4800A393 */  lbu        $v1, 0x48($sp)
    /* 8D35C 8009CB5C 00000000 */  nop
    /* 8D360 8009CB60 0A006010 */  beqz       $v1, .L8009CB8C
    /* 8D364 8009CB64 21204000 */   addu      $a0, $v0, $zero
    /* 8D368 8009CB68 4900A293 */  lbu        $v0, 0x49($sp)
    /* 8D36C 8009CB6C 00000000 */  nop
    /* 8D370 8009CB70 06004010 */  beqz       $v0, .L8009CB8C
    /* 8D374 8009CB74 23109100 */   subu      $v0, $a0, $s1
    /* 8D378 8009CB78 C21F0200 */  srl        $v1, $v0, 31
    /* 8D37C 8009CB7C 21104300 */  addu       $v0, $v0, $v1
    /* 8D380 8009CB80 7000AB8F */  lw         $t3, 0x70($sp)
    /* 8D384 8009CB84 43100200 */  sra        $v0, $v0, 1
    /* 8D388 8009CB88 000062A1 */  sb         $v0, 0x0($t3)
  .L8009CB8C:
    /* 8D38C 8009CB8C 4A00A293 */  lbu        $v0, 0x4A($sp)
    /* 8D390 8009CB90 00000000 */  nop
    /* 8D394 8009CB94 0D004010 */  beqz       $v0, .L8009CBCC
    /* 8D398 8009CB98 12800B3C */   lui       $t3, %hi(Device_gDeviceList)
    /* 8D39C 8009CB9C 0000448E */  lw         $a0, 0x0($s2)
    /* 8D3A0 8009CBA0 18EC6B25 */  addiu      $t3, $t3, %lo(Device_gDeviceList)
    /* 8D3A4 8009CBA4 FF008330 */  andi       $v1, $a0, 0xFF
    /* 8D3A8 8009CBA8 40100300 */  sll        $v0, $v1, 1
    /* 8D3AC 8009CBAC 21104300 */  addu       $v0, $v0, $v1
    /* 8D3B0 8009CBB0 80100200 */  sll        $v0, $v0, 2
    /* 8D3B4 8009CBB4 21104B00 */  addu       $v0, $v0, $t3
    /* 8D3B8 8009CBB8 0400428C */  lw         $v0, 0x4($v0)
    /* 8D3BC 8009CBBC 00000000 */  nop
    /* 8D3C0 8009CBC0 09F84000 */  jalr       $v0
    /* 8D3C4 8009CBC4 03220400 */   sra       $a0, $a0, 8
    /* 8D3C8 8009CBC8 FEFF82A2 */  sb         $v0, -0x2($s4)
  .L8009CBCC:
    /* 8D3CC 8009CBCC 4B00A293 */  lbu        $v0, 0x4B($sp)
    /* 8D3D0 8009CBD0 00000000 */  nop
    /* 8D3D4 8009CBD4 0E004010 */  beqz       $v0, .L8009CC10
    /* 8D3D8 8009CBD8 04005226 */   addiu     $s2, $s2, 0x4
    /* 8D3DC 8009CBDC 12800B3C */  lui        $t3, %hi(Device_gDeviceList)
    /* 8D3E0 8009CBE0 0000448E */  lw         $a0, 0x0($s2)
    /* 8D3E4 8009CBE4 18EC6B25 */  addiu      $t3, $t3, %lo(Device_gDeviceList)
    /* 8D3E8 8009CBE8 FF008330 */  andi       $v1, $a0, 0xFF
    /* 8D3EC 8009CBEC 40100300 */  sll        $v0, $v1, 1
    /* 8D3F0 8009CBF0 21104300 */  addu       $v0, $v0, $v1
    /* 8D3F4 8009CBF4 80100200 */  sll        $v0, $v0, 2
    /* 8D3F8 8009CBF8 21104B00 */  addu       $v0, $v0, $t3
    /* 8D3FC 8009CBFC 0400428C */  lw         $v0, 0x4($v0)
    /* 8D400 8009CC00 00000000 */  nop
    /* 8D404 8009CC04 09F84000 */  jalr       $v0
    /* 8D408 8009CC08 03220400 */   sra       $a0, $a0, 8
    /* 8D40C 8009CC0C FFFF82A2 */  sb         $v0, -0x1($s4)
  .L8009CC10:
    /* 8D410 8009CC10 04005226 */  addiu      $s2, $s2, 0x4
    /* 8D414 8009CC14 21800000 */  addu       $s0, $zero, $zero
  .L8009CC18:
    /* 8D418 8009CC18 21101D02 */  addu       $v0, $s0, $sp
    /* 8D41C 8009CC1C 4C004290 */  lbu        $v0, 0x4C($v0)
    /* 8D420 8009CC20 00000000 */  nop
    /* 8D424 8009CC24 1C004010 */  beqz       $v0, .L8009CC98
    /* 8D428 8009CC28 00000000 */   nop
    /* 8D42C 8009CC2C 0000448E */  lw         $a0, 0x0($s2)
    /* 8D430 8009CC30 00000000 */  nop
    /* 8D434 8009CC34 13008010 */  beqz       $a0, .L8009CC84
    /* 8D438 8009CC38 FF008330 */   andi      $v1, $a0, 0xFF
    /* 8D43C 8009CC3C 40100300 */  sll        $v0, $v1, 1
    /* 8D440 8009CC40 21104300 */  addu       $v0, $v0, $v1
    /* 8D444 8009CC44 80100200 */  sll        $v0, $v0, 2
    /* 8D448 8009CC48 12800B3C */  lui        $t3, %hi(Device_gDeviceList)
    /* 8D44C 8009CC4C 18EC6B25 */  addiu      $t3, $t3, %lo(Device_gDeviceList)
    /* 8D450 8009CC50 21104B00 */  addu       $v0, $v0, $t3
    /* 8D454 8009CC54 0400428C */  lw         $v0, 0x4($v0)
    /* 8D458 8009CC58 00000000 */  nop
    /* 8D45C 8009CC5C 09F84000 */  jalr       $v0
    /* 8D460 8009CC60 03220400 */   sra       $a0, $a0, 8
    /* 8D464 8009CC64 41004228 */  slti       $v0, $v0, 0x41
    /* 8D468 8009CC68 07004014 */  bnez       $v0, .L8009CC88
    /* 8D46C 8009CC6C 04101602 */   sllv      $v0, $s6, $s0
    /* 8D470 8009CC70 00008292 */  lbu        $v0, 0x0($s4)
    /* 8D474 8009CC74 04181602 */  sllv       $v1, $s6, $s0
    /* 8D478 8009CC78 25104300 */  or         $v0, $v0, $v1
    /* 8D47C 8009CC7C 26730208 */  j          .L8009CC98
    /* 8D480 8009CC80 000082A2 */   sb        $v0, 0x0($s4)
  .L8009CC84:
    /* 8D484 8009CC84 04101602 */  sllv       $v0, $s6, $s0
  .L8009CC88:
    /* 8D488 8009CC88 00008392 */  lbu        $v1, 0x0($s4)
    /* 8D48C 8009CC8C 27100200 */  nor        $v0, $zero, $v0
    /* 8D490 8009CC90 24186200 */  and        $v1, $v1, $v0
    /* 8D494 8009CC94 000083A2 */  sb         $v1, 0x0($s4)
  .L8009CC98:
    /* 8D498 8009CC98 01001026 */  addiu      $s0, $s0, 0x1
    /* 8D49C 8009CC9C 0200022A */  slti       $v0, $s0, 0x2
    /* 8D4A0 8009CCA0 DDFF4014 */  bnez       $v0, .L8009CC18
    /* 8D4A4 8009CCA4 04005226 */   addiu     $s2, $s2, 0x4
    /* 8D4A8 8009CCA8 21A80000 */  addu       $s5, $zero, $zero
    /* 8D4AC 8009CCAC 10000424 */  addiu      $a0, $zero, 0x10
    /* 8D4B0 8009CCB0 7800AB8F */  lw         $t3, 0x78($sp)
    /* 8D4B4 8009CCB4 00008292 */  lbu        $v0, 0x0($s4)
    /* 8D4B8 8009CCB8 21186401 */  addu       $v1, $t3, $a0
    /* 8D4BC 8009CCBC 07004230 */  andi       $v0, $v0, 0x7
    /* 8D4C0 8009CCC0 000082A2 */  sb         $v0, 0x0($s4)
  .L8009CCC4:
    /* 8D4C4 8009CCC4 000076A0 */  sb         $s6, 0x0($v1)
    /* 8D4C8 8009CCC8 FFFF8424 */  addiu      $a0, $a0, -0x1
    /* 8D4CC 8009CCCC FDFF8104 */  bgez       $a0, .L8009CCC4
    /* 8D4D0 8009CCD0 FFFF6324 */   addiu     $v1, $v1, -0x1
    /* 8D4D4 8009CCD4 21800000 */  addu       $s0, $zero, $zero
    /* 8D4D8 8009CCD8 8400A88F */  lw         $t0, 0x84($sp)
    /* 8D4DC 8009CCDC 7C00B38F */  lw         $s3, 0x7C($sp)
    /* 8D4E0 8009CCE0 21880001 */  addu       $s1, $t0, $zero
  .L8009CCE4:
    /* 8D4E4 8009CCE4 1100022A */  slti       $v0, $s0, 0x11
    /* 8D4E8 8009CCE8 52004010 */  beqz       $v0, .L8009CE34
    /* 8D4EC 8009CCEC 00000000 */   nop
    /* 8D4F0 8009CCF0 0000448E */  lw         $a0, 0x0($s2)
    /* 8D4F4 8009CCF4 00000000 */  nop
    /* 8D4F8 8009CCF8 4A008010 */  beqz       $a0, .L8009CE24
    /* 8D4FC 8009CCFC 21101D02 */   addu      $v0, $s0, $sp
    /* 8D500 8009CD00 4E004290 */  lbu        $v0, 0x4E($v0)
    /* 8D504 8009CD04 00000000 */  nop
    /* 8D508 8009CD08 3D004010 */  beqz       $v0, .L8009CE00
    /* 8D50C 8009CD0C FF008330 */   andi      $v1, $a0, 0xFF
    /* 8D510 8009CD10 40100300 */  sll        $v0, $v1, 1
    /* 8D514 8009CD14 21104300 */  addu       $v0, $v0, $v1
    /* 8D518 8009CD18 80100200 */  sll        $v0, $v0, 2
    /* 8D51C 8009CD1C 12800B3C */  lui        $t3, %hi(Device_gDeviceList)
    /* 8D520 8009CD20 18EC6B25 */  addiu      $t3, $t3, %lo(Device_gDeviceList)
    /* 8D524 8009CD24 21104B00 */  addu       $v0, $v0, $t3
    /* 8D528 8009CD28 0400428C */  lw         $v0, 0x4($v0)
    /* 8D52C 8009CD2C 03220400 */  sra        $a0, $a0, 8
    /* 8D530 8009CD30 09F84000 */  jalr       $v0
    /* 8D534 8009CD34 8800A8AF */   sw        $t0, 0x88($sp)
    /* 8D538 8009CD38 41004228 */  slti       $v0, $v0, 0x41
    /* 8D53C 8009CD3C 8800A88F */  lw         $t0, 0x88($sp)
    /* 8D540 8009CD40 30004014 */  bnez       $v0, .L8009CE04
    /* 8D544 8009CD44 04101602 */   sllv      $v0, $s6, $s0
    /* 8D548 8009CD48 11800B3C */  lui        $t3, %hi(Input_gPressTime)
    /* 8D54C 8009CD4C 943F6B25 */  addiu      $t3, $t3, %lo(Input_gPressTime)
    /* 8D550 8009CD50 21182B02 */  addu       $v1, $s1, $t3
    /* 8D554 8009CD54 0000628C */  lw         $v0, 0x0($v1)
    /* 8D558 8009CD58 00000000 */  nop
    /* 8D55C 8009CD5C 01004224 */  addiu      $v0, $v0, 0x1
    /* 8D560 8009CD60 000062AC */  sw         $v0, 0x0($v1)
    /* 8D564 8009CD64 06004228 */  slti       $v0, $v0, 0x6
    /* 8D568 8009CD68 09004014 */  bnez       $v0, .L8009CD90
    /* 8D56C 8009CD6C 21200000 */   addu      $a0, $zero, $zero
    /* 8D570 8009CD70 0000648E */  lw         $a0, 0x0($s3)
    /* 8D574 8009CD74 04181602 */  sllv       $v1, $s6, $s0
    /* 8D578 8009CD78 24108300 */  and        $v0, $a0, $v1
    /* 8D57C 8009CD7C 03004014 */  bnez       $v0, .L8009CD8C
    /* 8D580 8009CD80 25108300 */   or        $v0, $a0, $v1
    /* 8D584 8009CD84 01001526 */  addiu      $s5, $s0, 0x1
    /* 8D588 8009CD88 000062AE */  sw         $v0, 0x0($s3)
  .L8009CD8C:
    /* 8D58C 8009CD8C 21200000 */  addu       $a0, $zero, $zero
  .L8009CD90:
    /* 8D590 8009CD90 EFFF0726 */  addiu      $a3, $s0, -0x11
    /* 8D594 8009CD94 11800B3C */  lui        $t3, %hi(Input_gPressTime)
    /* 8D598 8009CD98 943F6B25 */  addiu      $t3, $t3, %lo(Input_gPressTime)
    /* 8D59C 8009CD9C 21302B02 */  addu       $a2, $s1, $t3
    /* 8D5A0 8009CDA0 21280001 */  addu       $a1, $t0, $zero
  .L8009CDA4:
    /* 8D5A4 8009CDA4 23108700 */  subu       $v0, $a0, $a3
    /* 8D5A8 8009CDA8 80100200 */  sll        $v0, $v0, 2
    /* 8D5AC 8009CDAC 21105200 */  addu       $v0, $v0, $s2
    /* 8D5B0 8009CDB0 0000438C */  lw         $v1, 0x0($v0)
    /* 8D5B4 8009CDB4 0000428E */  lw         $v0, 0x0($s2)
    /* 8D5B8 8009CDB8 00000000 */  nop
    /* 8D5BC 8009CDBC 0A006214 */  bne        $v1, $v0, .L8009CDE8
    /* 8D5C0 8009CDC0 00000000 */   nop
    /* 8D5C4 8009CDC4 7800AB8F */  lw         $t3, 0x78($sp)
    /* 8D5C8 8009CDC8 00000000 */  nop
    /* 8D5CC 8009CDCC 21106401 */  addu       $v0, $t3, $a0
    /* 8D5D0 8009CDD0 11800B3C */  lui        $t3, %hi(Input_gPressTime)
    /* 8D5D4 8009CDD4 943F6B25 */  addiu      $t3, $t3, %lo(Input_gPressTime)
    /* 8D5D8 8009CDD8 000040A0 */  sb         $zero, 0x0($v0)
    /* 8D5DC 8009CDDC 0000C38C */  lw         $v1, 0x0($a2)
    /* 8D5E0 8009CDE0 2110AB00 */  addu       $v0, $a1, $t3
    /* 8D5E4 8009CDE4 000043AC */  sw         $v1, 0x0($v0)
  .L8009CDE8:
    /* 8D5E8 8009CDE8 01008424 */  addiu      $a0, $a0, 0x1
    /* 8D5EC 8009CDEC 11008228 */  slti       $v0, $a0, 0x11
    /* 8D5F0 8009CDF0 ECFF4014 */  bnez       $v0, .L8009CDA4
    /* 8D5F4 8009CDF4 0400A524 */   addiu     $a1, $a1, 0x4
    /* 8D5F8 8009CDF8 8A730208 */  j          .L8009CE28
    /* 8D5FC 8009CDFC 04005226 */   addiu     $s2, $s2, 0x4
  .L8009CE00:
    /* 8D600 8009CE00 04101602 */  sllv       $v0, $s6, $s0
  .L8009CE04:
    /* 8D604 8009CE04 27100200 */  nor        $v0, $zero, $v0
    /* 8D608 8009CE08 11800B3C */  lui        $t3, %hi(Input_gPressTime)
    /* 8D60C 8009CE0C 0000638E */  lw         $v1, 0x0($s3)
    /* 8D610 8009CE10 943F6B25 */  addiu      $t3, $t3, %lo(Input_gPressTime)
    /* 8D614 8009CE14 24186200 */  and        $v1, $v1, $v0
    /* 8D618 8009CE18 21102B02 */  addu       $v0, $s1, $t3
    /* 8D61C 8009CE1C 000063AE */  sw         $v1, 0x0($s3)
    /* 8D620 8009CE20 000040AC */  sw         $zero, 0x0($v0)
  .L8009CE24:
    /* 8D624 8009CE24 04005226 */  addiu      $s2, $s2, 0x4
  .L8009CE28:
    /* 8D628 8009CE28 04003126 */  addiu      $s1, $s1, 0x4
    /* 8D62C 8009CE2C 39730208 */  j          .L8009CCE4
    /* 8D630 8009CE30 01001026 */   addiu     $s0, $s0, 0x1
  .L8009CE34:
    /* 8D634 8009CE34 21800000 */  addu       $s0, $zero, $zero
    /* 8D638 8009CE38 7C00B38F */  lw         $s3, 0x7C($sp)
  .L8009CE3C:
    /* 8D63C 8009CE3C 0000448E */  lw         $a0, 0x0($s2)
    /* 8D640 8009CE40 00000000 */  nop
    /* 8D644 8009CE44 40008010 */  beqz       $a0, .L8009CF48
    /* 8D648 8009CE48 21101D02 */   addu      $v0, $s0, $sp
    /* 8D64C 8009CE4C 5F005124 */  addiu      $s1, $v0, 0x5F
    /* 8D650 8009CE50 00002292 */  lbu        $v0, 0x0($s1)
    /* 8D654 8009CE54 00000000 */  nop
    /* 8D658 8009CE58 36004010 */  beqz       $v0, .L8009CF34
    /* 8D65C 8009CE5C FF008330 */   andi      $v1, $a0, 0xFF
    /* 8D660 8009CE60 40100300 */  sll        $v0, $v1, 1
    /* 8D664 8009CE64 21104300 */  addu       $v0, $v0, $v1
    /* 8D668 8009CE68 80100200 */  sll        $v0, $v0, 2
    /* 8D66C 8009CE6C 12800B3C */  lui        $t3, %hi(Device_gDeviceList)
    /* 8D670 8009CE70 18EC6B25 */  addiu      $t3, $t3, %lo(Device_gDeviceList)
    /* 8D674 8009CE74 21104B00 */  addu       $v0, $v0, $t3
    /* 8D678 8009CE78 0400428C */  lw         $v0, 0x4($v0)
    /* 8D67C 8009CE7C 00000000 */  nop
    /* 8D680 8009CE80 09F84000 */  jalr       $v0
    /* 8D684 8009CE84 03220400 */   sra       $a0, $a0, 8
    /* 8D688 8009CE88 41004228 */  slti       $v0, $v0, 0x41
    /* 8D68C 8009CE8C 10004014 */  bnez       $v0, .L8009CED0
    /* 8D690 8009CE90 04181602 */   sllv      $v1, $s6, $s0
    /* 8D694 8009CE94 0000648E */  lw         $a0, 0x0($s3)
    /* 8D698 8009CE98 00000000 */  nop
    /* 8D69C 8009CE9C 24108300 */  and        $v0, $a0, $v1
    /* 8D6A0 8009CEA0 29004014 */  bnez       $v0, .L8009CF48
    /* 8D6A4 8009CEA4 00000000 */   nop
    /* 8D6A8 8009CEA8 7800AB8F */  lw         $t3, 0x78($sp)
    /* 8D6AC 8009CEAC 00000000 */  nop
    /* 8D6B0 8009CEB0 21107001 */  addu       $v0, $t3, $s0
    /* 8D6B4 8009CEB4 00004290 */  lbu        $v0, 0x0($v0)
    /* 8D6B8 8009CEB8 00000000 */  nop
    /* 8D6BC 8009CEBC 22004010 */  beqz       $v0, .L8009CF48
    /* 8D6C0 8009CEC0 25108300 */   or        $v0, $a0, $v1
    /* 8D6C4 8009CEC4 01001526 */  addiu      $s5, $s0, 0x1
    /* 8D6C8 8009CEC8 D2730208 */  j          .L8009CF48
    /* 8D6CC 8009CECC 000062AE */   sw        $v0, 0x0($s3)
  .L8009CED0:
    /* 8D6D0 8009CED0 00002292 */  lbu        $v0, 0x0($s1)
    /* 8D6D4 8009CED4 00000000 */  nop
    /* 8D6D8 8009CED8 16004010 */  beqz       $v0, .L8009CF34
    /* 8D6DC 8009CEDC 80101000 */   sll       $v0, $s0, 2
    /* 8D6E0 8009CEE0 8400AB8F */  lw         $t3, 0x84($sp)
    /* 8D6E4 8009CEE4 00000000 */  nop
    /* 8D6E8 8009CEE8 21104B00 */  addu       $v0, $v0, $t3
    /* 8D6EC 8009CEEC 11800B3C */  lui        $t3, %hi(Input_gPressTime)
    /* 8D6F0 8009CEF0 943F6B25 */  addiu      $t3, $t3, %lo(Input_gPressTime)
    /* 8D6F4 8009CEF4 21284B00 */  addu       $a1, $v0, $t3
    /* 8D6F8 8009CEF8 0000A28C */  lw         $v0, 0x0($a1)
    /* 8D6FC 8009CEFC 00000000 */  nop
    /* 8D700 8009CF00 0C004018 */  blez       $v0, .L8009CF34
    /* 8D704 8009CF04 06004228 */   slti      $v0, $v0, 0x6
    /* 8D708 8009CF08 0A004010 */  beqz       $v0, .L8009CF34
    /* 8D70C 8009CF0C 04181602 */   sllv      $v1, $s6, $s0
    /* 8D710 8009CF10 0000648E */  lw         $a0, 0x0($s3)
    /* 8D714 8009CF14 00000000 */  nop
    /* 8D718 8009CF18 24108300 */  and        $v0, $a0, $v1
    /* 8D71C 8009CF1C 03004014 */  bnez       $v0, .L8009CF2C
    /* 8D720 8009CF20 25108300 */   or        $v0, $a0, $v1
    /* 8D724 8009CF24 01001526 */  addiu      $s5, $s0, 0x1
    /* 8D728 8009CF28 000062AE */  sw         $v0, 0x0($s3)
  .L8009CF2C:
    /* 8D72C 8009CF2C D2730208 */  j          .L8009CF48
    /* 8D730 8009CF30 0000A0AC */   sw        $zero, 0x0($a1)
  .L8009CF34:
    /* 8D734 8009CF34 04101602 */  sllv       $v0, $s6, $s0
    /* 8D738 8009CF38 0000638E */  lw         $v1, 0x0($s3)
    /* 8D73C 8009CF3C 27100200 */  nor        $v0, $zero, $v0
    /* 8D740 8009CF40 24186200 */  and        $v1, $v1, $v0
    /* 8D744 8009CF44 000063AE */  sw         $v1, 0x0($s3)
  .L8009CF48:
    /* 8D748 8009CF48 01001026 */  addiu      $s0, $s0, 0x1
    /* 8D74C 8009CF4C 1100022A */  slti       $v0, $s0, 0x11
    /* 8D750 8009CF50 BAFF4014 */  bnez       $v0, .L8009CE3C
    /* 8D754 8009CF54 04005226 */   addiu     $s2, $s2, 0x4
    /* 8D758 8009CF58 FFFFE326 */  addiu      $v1, $s7, -0x1
    /* 8D75C 8009CF5C 00110300 */  sll        $v0, $v1, 4
    /* 8D760 8009CF60 21104300 */  addu       $v0, $v0, $v1
    /* 8D764 8009CF64 80100200 */  sll        $v0, $v0, 2
    /* 8D768 8009CF68 21904202 */  addu       $s2, $s2, $v0
    /* 8D76C 8009CF6C 21800000 */  addu       $s0, $zero, $zero
    /* 8D770 8009CF70 7C00B18F */  lw         $s1, 0x7C($sp)
  .L8009CF74:
    /* 8D774 8009CF74 0000448E */  lw         $a0, 0x0($s2)
    /* 8D778 8009CF78 00000000 */  nop
    /* 8D77C 8009CF7C 1A008010 */  beqz       $a0, .L8009CFE8
    /* 8D780 8009CF80 FF008330 */   andi      $v1, $a0, 0xFF
    /* 8D784 8009CF84 40100300 */  sll        $v0, $v1, 1
    /* 8D788 8009CF88 21104300 */  addu       $v0, $v0, $v1
    /* 8D78C 8009CF8C 80100200 */  sll        $v0, $v0, 2
    /* 8D790 8009CF90 12800B3C */  lui        $t3, %hi(Device_gDeviceList)
    /* 8D794 8009CF94 18EC6B25 */  addiu      $t3, $t3, %lo(Device_gDeviceList)
    /* 8D798 8009CF98 21104B00 */  addu       $v0, $v0, $t3
    /* 8D79C 8009CF9C 0400428C */  lw         $v0, 0x4($v0)
    /* 8D7A0 8009CFA0 00000000 */  nop
    /* 8D7A4 8009CFA4 09F84000 */  jalr       $v0
    /* 8D7A8 8009CFA8 03220400 */   sra       $a0, $a0, 8
    /* 8D7AC 8009CFAC 41004228 */  slti       $v0, $v0, 0x41
    /* 8D7B0 8009CFB0 09004014 */  bnez       $v0, .L8009CFD8
    /* 8D7B4 8009CFB4 04101602 */   sllv      $v0, $s6, $s0
    /* 8D7B8 8009CFB8 0000248E */  lw         $a0, 0x0($s1)
    /* 8D7BC 8009CFBC 04181602 */  sllv       $v1, $s6, $s0
    /* 8D7C0 8009CFC0 24108300 */  and        $v0, $a0, $v1
    /* 8D7C4 8009CFC4 08004014 */  bnez       $v0, .L8009CFE8
    /* 8D7C8 8009CFC8 25108300 */   or        $v0, $a0, $v1
    /* 8D7CC 8009CFCC 01001526 */  addiu      $s5, $s0, 0x1
    /* 8D7D0 8009CFD0 FA730208 */  j          .L8009CFE8
    /* 8D7D4 8009CFD4 000022AE */   sw        $v0, 0x0($s1)
  .L8009CFD8:
    /* 8D7D8 8009CFD8 0000238E */  lw         $v1, 0x0($s1)
    /* 8D7DC 8009CFDC 27100200 */  nor        $v0, $zero, $v0
    /* 8D7E0 8009CFE0 24186200 */  and        $v1, $v1, $v0
    /* 8D7E4 8009CFE4 000023AE */  sw         $v1, 0x0($s1)
  .L8009CFE8:
    /* 8D7E8 8009CFE8 01001026 */  addiu      $s0, $s0, 0x1
    /* 8D7EC 8009CFEC 1100022A */  slti       $v0, $s0, 0x11
    /* 8D7F0 8009CFF0 E0FF4014 */  bnez       $v0, .L8009CF74
    /* 8D7F4 8009CFF4 04005226 */   addiu     $s2, $s2, 0x4
    /* 8D7F8 8009CFF8 02000324 */  addiu      $v1, $zero, 0x2
    /* 8D7FC 8009CFFC 23187700 */  subu       $v1, $v1, $s7
    /* 8D800 8009D000 00110300 */  sll        $v0, $v1, 4
    /* 8D804 8009D004 21104300 */  addu       $v0, $v0, $v1
    /* 8D808 8009D008 80100200 */  sll        $v0, $v0, 2
    /* 8D80C 8009D00C 21904202 */  addu       $s2, $s2, $v0
  .L8009D010:
    /* 8D810 8009D010 00008292 */  lbu        $v0, 0x0($s4)
    /* 8D814 8009D014 C0181500 */  sll        $v1, $s5, 3
    /* 8D818 8009D018 25104300 */  or         $v0, $v0, $v1
    /* 8D81C 8009D01C 000082A2 */  sb         $v0, 0x0($s4)
    /* 8D820 8009D020 00008492 */  lbu        $a0, 0x0($s4)
    /* 8D824 8009D024 10000224 */  addiu      $v0, $zero, 0x10
    /* 8D828 8009D028 C2180400 */  srl        $v1, $a0, 3
    /* 8D82C 8009D02C 11006210 */  beq        $v1, $v0, .L8009D074
    /* 8D830 8009D030 07008230 */   andi      $v0, $a0, 0x7
    /* 8D834 8009D034 11006228 */  slti       $v0, $v1, 0x11
    /* 8D838 8009D038 05004010 */  beqz       $v0, .L8009D050
    /* 8D83C 8009D03C 0F000224 */   addiu     $v0, $zero, 0xF
    /* 8D840 8009D040 08006210 */  beq        $v1, $v0, .L8009D064
    /* 8D844 8009D044 07008230 */   andi      $v0, $a0, 0x7
    /* 8D848 8009D048 27740208 */  j          .L8009D09C
    /* 8D84C 8009D04C 04009426 */   addiu     $s4, $s4, 0x4
  .L8009D050:
    /* 8D850 8009D050 11000224 */  addiu      $v0, $zero, 0x11
    /* 8D854 8009D054 0A006210 */  beq        $v1, $v0, .L8009D080
    /* 8D858 8009D058 07008230 */   andi      $v0, $a0, 0x7
    /* 8D85C 8009D05C 27740208 */  j          .L8009D09C
    /* 8D860 8009D060 04009426 */   addiu     $s4, $s4, 0x4
  .L8009D064:
    /* 8D864 8009D064 000082A2 */  sb         $v0, 0x0($s4)
    /* 8D868 8009D068 7400AB8F */  lw         $t3, 0x74($sp)
    /* 8D86C 8009D06C 24740208 */  j          .L8009D090
    /* 8D870 8009D070 2000023C */   lui       $v0, (0x200000 >> 16)
  .L8009D074:
    /* 8D874 8009D074 000082A2 */  sb         $v0, 0x0($s4)
    /* 8D878 8009D078 22740208 */  j          .L8009D088
    /* 8D87C 8009D07C 1A00C227 */   addiu     $v0, $fp, 0x1A
  .L8009D080:
    /* 8D880 8009D080 000082A2 */  sb         $v0, 0x0($s4)
    /* 8D884 8009D084 1C00C227 */  addiu      $v0, $fp, 0x1C
  .L8009D088:
    /* 8D888 8009D088 7400AB8F */  lw         $t3, 0x74($sp)
    /* 8D88C 8009D08C 04105600 */  sllv       $v0, $s6, $v0
  .L8009D090:
    /* 8D890 8009D090 25586201 */  or         $t3, $t3, $v0
    /* 8D894 8009D094 7400ABAF */  sw         $t3, 0x74($sp)
    /* 8D898 8009D098 04009426 */  addiu      $s4, $s4, 0x4
  .L8009D09C:
    /* 8D89C 8009D09C 1180023C */  lui        $v0, %hi(D_801135B4)
    /* 8D8A0 8009D0A0 7000AB8F */  lw         $t3, 0x70($sp)
    /* 8D8A4 8009D0A4 B435428C */  lw         $v0, %lo(D_801135B4)($v0)
    /* 8D8A8 8009D0A8 04006B25 */  addiu      $t3, $t3, 0x4
    /* 8D8AC 8009D0AC 0D005614 */  bne        $v0, $s6, .L8009D0E4
    /* 8D8B0 8009D0B0 7000ABAF */   sw        $t3, 0x70($sp)
    /* 8D8B4 8009D0B4 7C00AB8F */  lw         $t3, 0x7C($sp)
    /* 8D8B8 8009D0B8 00000000 */  nop
    /* 8D8BC 8009D0BC 04006B25 */  addiu      $t3, $t3, 0x4
    /* 8D8C0 8009D0C0 7C00ABAF */  sw         $t3, 0x7C($sp)
    /* 8D8C4 8009D0C4 8000AB8F */  lw         $t3, 0x80($sp)
    /* 8D8C8 8009D0C8 30015226 */  addiu      $s2, $s2, 0x130
    /* 8D8CC 8009D0CC 04006B25 */  addiu      $t3, $t3, 0x4
    /* 8D8D0 8009D0D0 8000ABAF */  sw         $t3, 0x80($sp)
    /* 8D8D4 8009D0D4 8400AB8F */  lw         $t3, 0x84($sp)
    /* 8D8D8 8009D0D8 0100DE27 */  addiu      $fp, $fp, 0x1
    /* 8D8DC 8009D0DC 44006B25 */  addiu      $t3, $t3, 0x44
    /* 8D8E0 8009D0E0 8400ABAF */  sw         $t3, 0x84($sp)
  .L8009D0E4:
    /* 8D8E4 8009D0E4 7C00AB8F */  lw         $t3, 0x7C($sp)
    /* 8D8E8 8009D0E8 00000000 */  nop
    /* 8D8EC 8009D0EC 04006B25 */  addiu      $t3, $t3, 0x4
    /* 8D8F0 8009D0F0 7C00ABAF */  sw         $t3, 0x7C($sp)
    /* 8D8F4 8009D0F4 8000AB8F */  lw         $t3, 0x80($sp)
    /* 8D8F8 8009D0F8 00000000 */  nop
    /* 8D8FC 8009D0FC 04006B25 */  addiu      $t3, $t3, 0x4
    /* 8D900 8009D100 8000ABAF */  sw         $t3, 0x80($sp)
    /* 8D904 8009D104 8400AB8F */  lw         $t3, 0x84($sp)
    /* 8D908 8009D108 0100DE27 */  addiu      $fp, $fp, 0x1
    /* 8D90C 8009D10C 44006B25 */  addiu      $t3, $t3, 0x44
    /* 8D910 8009D110 42710208 */  j          .L8009C508
    /* 8D914 8009D114 8400ABAF */   sw        $t3, 0x84($sp)
  .L8009D118:
    /* 8D918 8009D118 21F00000 */  addu       $fp, $zero, $zero
    /* 8D91C 8009D11C 1000B027 */  addiu      $s0, $sp, 0x10
    /* 8D920 8009D120 01001124 */  addiu      $s1, $zero, 0x1
  .L8009D124:
    /* 8D924 8009D124 21101E02 */  addu       $v0, $s0, $fp
    /* 8D928 8009D128 00004290 */  lbu        $v0, 0x0($v0)
    /* 8D92C 8009D12C 00000000 */  nop
    /* 8D930 8009D130 16004010 */  beqz       $v0, .L8009D18C
    /* 8D934 8009D134 00000000 */   nop
    /* 8D938 8009D138 0000448E */  lw         $a0, 0x0($s2)
    /* 8D93C 8009D13C 00000000 */  nop
    /* 8D940 8009D140 12008010 */  beqz       $a0, .L8009D18C
    /* 8D944 8009D144 FF008330 */   andi      $v1, $a0, 0xFF
    /* 8D948 8009D148 40100300 */  sll        $v0, $v1, 1
    /* 8D94C 8009D14C 21104300 */  addu       $v0, $v0, $v1
    /* 8D950 8009D150 80100200 */  sll        $v0, $v0, 2
    /* 8D954 8009D154 12800B3C */  lui        $t3, %hi(Device_gDeviceList)
    /* 8D958 8009D158 18EC6B25 */  addiu      $t3, $t3, %lo(Device_gDeviceList)
    /* 8D95C 8009D15C 21104B00 */  addu       $v0, $v0, $t3
    /* 8D960 8009D160 0400428C */  lw         $v0, 0x4($v0)
    /* 8D964 8009D164 00000000 */  nop
    /* 8D968 8009D168 09F84000 */  jalr       $v0
    /* 8D96C 8009D16C 03220400 */   sra       $a0, $a0, 8
    /* 8D970 8009D170 41004228 */  slti       $v0, $v0, 0x41
    /* 8D974 8009D174 05004014 */  bnez       $v0, .L8009D18C
    /* 8D978 8009D178 0410D103 */   sllv      $v0, $s1, $fp
    /* 8D97C 8009D17C 7400AB8F */  lw         $t3, 0x74($sp)
    /* 8D980 8009D180 00000000 */  nop
    /* 8D984 8009D184 25586201 */  or         $t3, $t3, $v0
    /* 8D988 8009D188 7400ABAF */  sw         $t3, 0x74($sp)
  .L8009D18C:
    /* 8D98C 8009D18C 0100DE27 */  addiu      $fp, $fp, 0x1
    /* 8D990 8009D190 2000C22B */  slti       $v0, $fp, 0x20
    /* 8D994 8009D194 E3FF4014 */  bnez       $v0, .L8009D124
    /* 8D998 8009D198 04005226 */   addiu     $s2, $s2, 0x4
    /* 8D99C 8009D19C 1180043C */  lui        $a0, %hi(Input_gInterfaceResults)
    /* 8D9A0 8009D1A0 143F8424 */  addiu      $a0, $a0, %lo(Input_gInterfaceResults)
    /* 8D9A4 8009D1A4 D40C828F */  lw         $v0, %gp_rel(Input_gTime)($gp)
    /* 8D9A8 8009D1A8 7400AB8F */  lw         $t3, 0x74($sp)
    /* 8D9AC 8009D1AC 02004324 */  addiu      $v1, $v0, 0x2
    /* 8D9B0 8009D1B0 D40C83AF */  sw         $v1, %gp_rel(Input_gTime)($gp)
    /* 8D9B4 8009D1B4 1F006330 */  andi       $v1, $v1, 0x1F
    /* 8D9B8 8009D1B8 80180300 */  sll        $v1, $v1, 2
    /* 8D9BC 8009D1BC 21186400 */  addu       $v1, $v1, $a0
    /* 8D9C0 8009D1C0 03004224 */  addiu      $v0, $v0, 0x3
    /* 8D9C4 8009D1C4 1F004230 */  andi       $v0, $v0, 0x1F
    /* 8D9C8 8009D1C8 80100200 */  sll        $v0, $v0, 2
    /* 8D9CC 8009D1CC 21104400 */  addu       $v0, $v0, $a0
    /* 8D9D0 8009D1D0 00006BAC */  sw         $t3, 0x0($v1)
    /* 8D9D4 8009D1D4 00004BAC */  sw         $t3, 0x0($v0)
    /* 8D9D8 8009D1D8 B400BF8F */  lw         $ra, 0xB4($sp)
    /* 8D9DC 8009D1DC B000BE8F */  lw         $fp, 0xB0($sp)
    /* 8D9E0 8009D1E0 AC00B78F */  lw         $s7, 0xAC($sp)
    /* 8D9E4 8009D1E4 A800B68F */  lw         $s6, 0xA8($sp)
    /* 8D9E8 8009D1E8 A400B58F */  lw         $s5, 0xA4($sp)
    /* 8D9EC 8009D1EC A000B48F */  lw         $s4, 0xA0($sp)
    /* 8D9F0 8009D1F0 9C00B38F */  lw         $s3, 0x9C($sp)
    /* 8D9F4 8009D1F4 9800B28F */  lw         $s2, 0x98($sp)
    /* 8D9F8 8009D1F8 9400B18F */  lw         $s1, 0x94($sp)
    /* 8D9FC 8009D1FC 9000B08F */  lw         $s0, 0x90($sp)
    /* 8DA00 8009D200 0800E003 */  jr         $ra
    /* 8DA04 8009D204 B800BD27 */   addiu     $sp, $sp, 0xB8
endlabel Input_Update__Fv
