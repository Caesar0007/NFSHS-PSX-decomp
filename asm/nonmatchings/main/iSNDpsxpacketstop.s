.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDpsxpacketstop, 0xD4

glabel iSNDpsxpacketstop
    /* F4EC8 801046C8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* F4ECC 801046CC 21280000 */  addu       $a1, $zero, $zero
    /* F4ED0 801046D0 1480033C */  lui        $v1, %hi(sndpd)
    /* F4ED4 801046D4 1400BFAF */  sw         $ra, 0x14($sp)
    /* F4ED8 801046D8 1000B0AF */  sw         $s0, 0x10($sp)
    /* F4EDC 801046DC 27008290 */  lbu        $v0, 0x27($a0)
    /* F4EE0 801046E0 18796724 */  addiu      $a3, $v1, %lo(sndpd)
    /* F4EE4 801046E4 00160200 */  sll        $v0, $v0, 24
    /* F4EE8 801046E8 83150200 */  sra        $v0, $v0, 22
    /* F4EEC 801046EC 21104700 */  addu       $v0, $v0, $a3
    /* F4EF0 801046F0 F804438C */  lw         $v1, 0x4F8($v0)
    /* F4EF4 801046F4 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* F4EF8 801046F8 420062A0 */  sb         $v0, 0x42($v1)
    /* F4EFC 801046FC 270082A0 */  sb         $v0, 0x27($a0)
    /* F4F00 80104700 1480023C */  lui        $v0, %hi(D_80147871)
    /* F4F04 80104704 71784290 */  lbu        $v0, %lo(D_80147871)($v0)
    /* F4F08 80104708 00000000 */  nop
    /* F4F0C 8010470C 0D004010 */  beqz       $v0, .L80104744
    /* F4F10 80104710 2120A000 */   addu      $a0, $a1, $zero
    /* F4F14 80104714 21304000 */  addu       $a2, $v0, $zero
    /* F4F18 80104718 2118E000 */  addu       $v1, $a3, $zero
  .L8010471C:
    /* F4F1C 8010471C FF006290 */  lbu        $v0, 0xFF($v1)
    /* F4F20 80104720 00000000 */  nop
    /* F4F24 80104724 00160200 */  sll        $v0, $v0, 24
    /* F4F28 80104728 02004004 */  bltz       $v0, .L80104734
    /* F4F2C 8010472C 00000000 */   nop
    /* F4F30 80104730 01008424 */  addiu      $a0, $a0, 0x1
  .L80104734:
    /* F4F34 80104734 0100A524 */  addiu      $a1, $a1, 0x1
    /* F4F38 80104738 2A10A600 */  slt        $v0, $a1, $a2
    /* F4F3C 8010473C F7FF4014 */  bnez       $v0, .L8010471C
    /* F4F40 80104740 2C006324 */   addiu     $v1, $v1, 0x2C
  .L80104744:
    /* F4F44 80104744 06008014 */  bnez       $a0, .L80104760
    /* F4F48 80104748 1480033C */   lui       $v1, %hi(sndpd)
    /* F4F4C 8010474C 18796324 */  addiu      $v1, $v1, %lo(sndpd)
    /* F4F50 80104750 1080023C */  lui        $v0, %hi(iSNDpacketsetirq)
    /* F4F54 80104754 BC384224 */  addiu      $v0, $v0, %lo(iSNDpacketsetirq)
    /* F4F58 80104758 200760AC */  sw         $zero, 0x720($v1)
    /* F4F5C 8010475C 280762AC */  sw         $v0, 0x728($v1)
  .L80104760:
    /* F4F60 80104760 00601040 */  mfc0       $s0, $12 /* handwritten instruction */
    /* F4F64 80104764 00000000 */  nop
    /* F4F68 80104768 FEFB0124 */  addiu      $at, $zero, -0x402
    /* F4F6C 8010476C 24400102 */  and        $t0, $s0, $at
    /* F4F70 80104770 00608840 */  mtc0       $t0, $12 /* handwritten instruction */
    /* F4F74 80104774 00000000 */  nop
    /* F4F78 80104778 00000000 */  nop
    /* F4F7C 8010477C 00000000 */  nop
    /* F4F80 80104780 2F0E040C */  jal        iSNDpacketsetirq
    /* F4F84 80104784 00000000 */   nop
    /* F4F88 80104788 00609040 */  mtc0       $s0, $12 /* handwritten instruction */
    /* F4F8C 8010478C 1400BF8F */  lw         $ra, 0x14($sp)
    /* F4F90 80104790 1000B08F */  lw         $s0, 0x10($sp)
    /* F4F94 80104794 0800E003 */  jr         $ra
    /* F4F98 80104798 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel iSNDpsxpacketstop
