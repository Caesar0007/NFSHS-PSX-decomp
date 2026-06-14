.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SNDSTRM_requeststatus, 0x170

glabel SNDSTRM_requeststatus
    /* D8FD0 800E87D0 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* D8FD4 800E87D4 2000B2AF */  sw         $s2, 0x20($sp)
    /* D8FD8 800E87D8 2190A000 */  addu       $s2, $a1, $zero
    /* D8FDC 800E87DC 1480023C */  lui        $v0, %hi(D_8014789C)
    /* D8FE0 800E87E0 2400BFAF */  sw         $ra, 0x24($sp)
    /* D8FE4 800E87E4 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* D8FE8 800E87E8 1800B0AF */  sw         $s0, 0x18($sp)
    /* D8FEC 800E87EC 000040AE */  sw         $zero, 0x0($s2)
    /* D8FF0 800E87F0 040040AE */  sw         $zero, 0x4($s2)
    /* D8FF4 800E87F4 080040AE */  sw         $zero, 0x8($s2)
    /* D8FF8 800E87F8 0C0040AE */  sw         $zero, 0xC($s2)
    /* D8FFC 800E87FC 9C784280 */  lb         $v0, %lo(D_8014789C)($v0)
    /* D9000 800E8800 00000000 */  nop
    /* D9004 800E8804 03004014 */  bnez       $v0, .L800E8814
    /* D9008 800E8808 21808000 */   addu      $s0, $a0, $zero
    /* D900C 800E880C 4AA20308 */  j          .L800E8928
    /* D9010 800E8810 F6FF0224 */   addiu     $v0, $zero, -0xA
  .L800E8814:
    /* D9014 800E8814 44000006 */  bltz       $s0, .L800E8928
    /* D9018 800E8818 F8FF0224 */   addiu     $v0, $zero, -0x8
    /* D901C 800E881C 12A3030C */  jal        iSNDstreamgetstreamptr
    /* D9020 800E8820 FF000432 */   andi      $a0, $s0, 0xFF
    /* D9024 800E8824 21884000 */  addu       $s1, $v0, $zero
    /* D9028 800E8828 3F002012 */  beqz       $s1, .L800E8928
    /* D902C 800E882C F8FF0224 */   addiu     $v0, $zero, -0x8
    /* D9030 800E8830 4DA9030C */  jal        iSNDenteraudio
    /* D9034 800E8834 00000000 */   nop
    /* D9038 800E8838 420D040C */  jal        iSNDstreamgetrequestptr
    /* D903C 800E883C 21200002 */   addu      $a0, $s0, $zero
    /* D9040 800E8840 21804000 */  addu       $s0, $v0, $zero
    /* D9044 800E8844 34000012 */  beqz       $s0, .L800E8918
    /* D9048 800E8848 03000224 */   addiu     $v0, $zero, 0x3
    /* D904C 800E884C 0800028E */  lw         $v0, 0x8($s0)
    /* D9050 800E8850 00000000 */  nop
    /* D9054 800E8854 03004104 */  bgez       $v0, .L800E8864
    /* D9058 800E8858 00000000 */   nop
    /* D905C 800E885C 47A20308 */  j          .L800E891C
    /* D9060 800E8860 000040AE */   sw        $zero, 0x0($s2)
  .L800E8864:
    /* D9064 800E8864 0000228E */  lw         $v0, 0x0($s1)
    /* D9068 800E8868 00000000 */  nop
    /* D906C 800E886C 06005014 */  bne        $v0, $s0, .L800E8888
    /* D9070 800E8870 01000224 */   addiu     $v0, $zero, 0x1
    /* D9074 800E8874 02000224 */  addiu      $v0, $zero, 0x2
    /* D9078 800E8878 000042AE */  sw         $v0, 0x0($s2)
    /* D907C 800E887C 1C003196 */  lhu        $s1, 0x1C($s1)
    /* D9080 800E8880 25A20308 */  j          .L800E8894
    /* D9084 800E8884 1000A427 */   addiu     $a0, $sp, 0x10
  .L800E8888:
    /* D9088 800E8888 000042AE */  sw         $v0, 0x0($s2)
    /* D908C 800E888C 20003196 */  lhu        $s1, 0x20($s1)
    /* D9090 800E8890 1000A427 */  addiu      $a0, $sp, 0x10
  .L800E8894:
    /* D9094 800E8894 1400058E */  lw         $a1, 0x14($s0)
    /* D9098 800E8898 090D040C */  jal        iSNDmulu64
    /* D909C 800E889C E8030624 */   addiu     $a2, $zero, 0x3E8
    /* D90A0 800E88A0 1000A48F */  lw         $a0, 0x10($sp)
    /* D90A4 800E88A4 1400A58F */  lw         $a1, 0x14($sp)
    /* D90A8 800E88A8 300D040C */  jal        iSNDdivu64
    /* D90AC 800E88AC 21302002 */   addu      $a2, $s1, $zero
    /* D90B0 800E88B0 1000A427 */  addiu      $a0, $sp, 0x10
    /* D90B4 800E88B4 040042AE */  sw         $v0, 0x4($s2)
    /* D90B8 800E88B8 1800028E */  lw         $v0, 0x18($s0)
    /* D90BC 800E88BC 1400058E */  lw         $a1, 0x14($s0)
    /* D90C0 800E88C0 E8030624 */  addiu      $a2, $zero, 0x3E8
    /* D90C4 800E88C4 090D040C */  jal        iSNDmulu64
    /* D90C8 800E88C8 23284500 */   subu      $a1, $v0, $a1
    /* D90CC 800E88CC 1000A48F */  lw         $a0, 0x10($sp)
    /* D90D0 800E88D0 1400A58F */  lw         $a1, 0x14($sp)
    /* D90D4 800E88D4 300D040C */  jal        iSNDdivu64
    /* D90D8 800E88D8 21302002 */   addu      $a2, $s1, $zero
    /* D90DC 800E88DC 080042AE */  sw         $v0, 0x8($s2)
    /* D90E0 800E88E0 1C00038E */  lw         $v1, 0x1C($s0)
    /* D90E4 800E88E4 00000000 */  nop
    /* D90E8 800E88E8 40110300 */  sll        $v0, $v1, 5
    /* D90EC 800E88EC 23104300 */  subu       $v0, $v0, $v1
    /* D90F0 800E88F0 80100200 */  sll        $v0, $v0, 2
    /* D90F4 800E88F4 21104300 */  addu       $v0, $v0, $v1
    /* D90F8 800E88F8 C0100200 */  sll        $v0, $v0, 3
    /* D90FC 800E88FC 1B005100 */  divu       $zero, $v0, $s1
    /* D9100 800E8900 02002016 */  bnez       $s1, .L800E890C
    /* D9104 800E8904 00000000 */   nop
    /* D9108 800E8908 0D000700 */  break      7
  .L800E890C:
    /* D910C 800E890C 12100000 */  mflo       $v0
    /* D9110 800E8910 47A20308 */  j          .L800E891C
    /* D9114 800E8914 0C0042AE */   sw        $v0, 0xC($s2)
  .L800E8918:
    /* D9118 800E8918 000042AE */  sw         $v0, 0x0($s2)
  .L800E891C:
    /* D911C 800E891C 5BA9030C */  jal        iSNDleaveaudio
    /* D9120 800E8920 00000000 */   nop
    /* D9124 800E8924 21100000 */  addu       $v0, $zero, $zero
  .L800E8928:
    /* D9128 800E8928 2400BF8F */  lw         $ra, 0x24($sp)
    /* D912C 800E892C 2000B28F */  lw         $s2, 0x20($sp)
    /* D9130 800E8930 1C00B18F */  lw         $s1, 0x1C($sp)
    /* D9134 800E8934 1800B08F */  lw         $s0, 0x18($sp)
    /* D9138 800E8938 0800E003 */  jr         $ra
    /* D913C 800E893C 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel SNDSTRM_requeststatus
