.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Souffle_Add__FP8coorddefiT0iii, 0x1E0

glabel Souffle_Add__FP8coorddefiT0iii
    /* A7F0C 800B770C D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* A7F10 800B7710 21580000 */  addu       $t3, $zero, $zero
    /* A7F14 800B7714 000F838F */  lw         $v1, %gp_rel(gCISouffle)($gp)
    /* A7F18 800B7718 3C000224 */  addiu      $v0, $zero, 0x3C
    /* A7F1C 800B771C 2400BFAF */  sw         $ra, 0x24($sp)
    /* A7F20 800B7720 13006214 */  bne        $v1, $v0, .L800B7770
    /* A7F24 800B7724 2000B0AF */   sw        $s0, 0x20($sp)
    /* A7F28 800B7728 01000824 */  addiu      $t0, $zero, 0x1
    /* A7F2C 800B772C FC0E828F */  lw         $v0, %gp_rel(gISouffle)($gp)
    /* A7F30 800B7730 3C000C24 */  addiu      $t4, $zero, 0x3C
    /* A7F34 800B7734 44004924 */  addiu      $t1, $v0, 0x44
    /* A7F38 800B7738 03004A90 */  lbu        $t2, 0x3($v0)
  .L800B773C:
    /* A7F3C 800B773C 03002391 */  lbu        $v1, 0x3($t1)
    /* A7F40 800B7740 00000000 */  nop
    /* A7F44 800B7744 2A106A00 */  slt        $v0, $v1, $t2
    /* A7F48 800B7748 03004010 */  beqz       $v0, .L800B7758
    /* A7F4C 800B774C 00000000 */   nop
    /* A7F50 800B7750 21580001 */  addu       $t3, $t0, $zero
    /* A7F54 800B7754 21506000 */  addu       $t2, $v1, $zero
  .L800B7758:
    /* A7F58 800B7758 01000825 */  addiu      $t0, $t0, 0x1
    /* A7F5C 800B775C 2A100C01 */  slt        $v0, $t0, $t4
    /* A7F60 800B7760 F6FF4014 */  bnez       $v0, .L800B773C
    /* A7F64 800B7764 44002925 */   addiu     $t1, $t1, 0x44
    /* A7F68 800B7768 E0DD0208 */  j          .L800B7780
    /* A7F6C 800B776C 00110B00 */   sll       $v0, $t3, 4
  .L800B7770:
    /* A7F70 800B7770 21586000 */  addu       $t3, $v1, $zero
    /* A7F74 800B7774 01006225 */  addiu      $v0, $t3, 0x1
    /* A7F78 800B7778 000F82AF */  sw         $v0, %gp_rel(gCISouffle)($gp)
    /* A7F7C 800B777C 00110B00 */  sll        $v0, $t3, 4
  .L800B7780:
    /* A7F80 800B7780 21104B00 */  addu       $v0, $v0, $t3
    /* A7F84 800B7784 FC0E838F */  lw         $v1, %gp_rel(gISouffle)($gp)
    /* A7F88 800B7788 80100200 */  sll        $v0, $v0, 2
    /* A7F8C 800B778C 21806200 */  addu       $s0, $v1, $v0
    /* A7F90 800B7790 00008D8C */  lw         $t5, 0x0($a0)
    /* A7F94 800B7794 04008E8C */  lw         $t6, 0x4($a0)
    /* A7F98 800B7798 08008F8C */  lw         $t7, 0x8($a0)
    /* A7F9C 800B779C 0C000DAE */  sw         $t5, 0xC($s0)
    /* A7FA0 800B77A0 10000EAE */  sw         $t6, 0x10($s0)
    /* A7FA4 800B77A4 14000FAE */  sw         $t7, 0x14($s0)
    /* A7FA8 800B77A8 030000A2 */  sb         $zero, 0x3($s0)
    /* A7FAC 800B77AC 000005A2 */  sb         $a1, 0x0($s0)
    /* A7FB0 800B77B0 01000BA2 */  sb         $t3, 0x1($s0)
    /* A7FB4 800B77B4 3800A28F */  lw         $v0, 0x38($sp)
    /* A7FB8 800B77B8 00000000 */  nop
    /* A7FBC 800B77BC 3C0002AE */  sw         $v0, 0x3C($s0)
    /* A7FC0 800B77C0 3C00A28F */  lw         $v0, 0x3C($sp)
    /* A7FC4 800B77C4 0500C014 */  bnez       $a2, .L800B77DC
    /* A7FC8 800B77C8 400002AE */   sw        $v0, 0x40($s0)
    /* A7FCC 800B77CC 1000A627 */  addiu      $a2, $sp, 0x10
    /* A7FD0 800B77D0 1000A0AF */  sw         $zero, 0x10($sp)
    /* A7FD4 800B77D4 1400A0AF */  sw         $zero, 0x14($sp)
    /* A7FD8 800B77D8 1800A0AF */  sw         $zero, 0x18($sp)
  .L800B77DC:
    /* A7FDC 800B77DC 09000224 */  addiu      $v0, $zero, 0x9
    /* A7FE0 800B77E0 2C00A210 */  beq        $a1, $v0, .L800B7894
    /* A7FE4 800B77E4 0A00A228 */   slti      $v0, $a1, 0xA
    /* A7FE8 800B77E8 11004010 */  beqz       $v0, .L800B7830
    /* A7FEC 800B77EC 04000224 */   addiu     $v0, $zero, 0x4
    /* A7FF0 800B77F0 2700A210 */  beq        $a1, $v0, .L800B7890
    /* A7FF4 800B77F4 0500A228 */   slti      $v0, $a1, 0x5
    /* A7FF8 800B77F8 05004010 */  beqz       $v0, .L800B7810
    /* A7FFC 800B77FC 07000224 */   addiu     $v0, $zero, 0x7
    /* A8000 800B7800 3300A018 */  blez       $a1, .L800B78D0
    /* A8004 800B7804 00000000 */   nop
    /* A8008 800B7808 1EDE0208 */  j          .L800B7878
    /* A800C 800B780C 00000000 */   nop
  .L800B7810:
    /* A8010 800B7810 2000A210 */  beq        $a1, $v0, .L800B7894
    /* A8014 800B7814 0800A228 */   slti      $v0, $a1, 0x8
    /* A8018 800B7818 1D004010 */  beqz       $v0, .L800B7890
    /* A801C 800B781C 06000224 */   addiu     $v0, $zero, 0x6
    /* A8020 800B7820 1500A210 */  beq        $a1, $v0, .L800B7878
    /* A8024 800B7824 00000000 */   nop
    /* A8028 800B7828 34DE0208 */  j          .L800B78D0
    /* A802C 800B782C 00000000 */   nop
  .L800B7830:
    /* A8030 800B7830 0C000224 */  addiu      $v0, $zero, 0xC
    /* A8034 800B7834 1600A210 */  beq        $a1, $v0, .L800B7890
    /* A8038 800B7838 0D00A228 */   slti      $v0, $a1, 0xD
    /* A803C 800B783C 07004010 */  beqz       $v0, .L800B785C
    /* A8040 800B7840 0A000224 */   addiu     $v0, $zero, 0xA
    /* A8044 800B7844 1200A210 */  beq        $a1, $v0, .L800B7890
    /* A8048 800B7848 0B000224 */   addiu     $v0, $zero, 0xB
    /* A804C 800B784C 1100A210 */  beq        $a1, $v0, .L800B7894
    /* A8050 800B7850 00000000 */   nop
    /* A8054 800B7854 34DE0208 */  j          .L800B78D0
    /* A8058 800B7858 00000000 */   nop
  .L800B785C:
    /* A805C 800B785C 0F00A228 */  slti       $v0, $a1, 0xF
    /* A8060 800B7860 0C004014 */  bnez       $v0, .L800B7894
    /* A8064 800B7864 01010224 */   addiu     $v0, $zero, 0x101
    /* A8068 800B7868 0A00A210 */  beq        $a1, $v0, .L800B7894
    /* A806C 800B786C 00000000 */   nop
    /* A8070 800B7870 34DE0208 */  j          .L800B78D0
    /* A8074 800B7874 00000000 */   nop
  .L800B7878:
    /* A8078 800B7878 93DD020C */  jal        GetGustWind__FP17Souffle_tISouffle
    /* A807C 800B787C 21200002 */   addu      $a0, $s0, $zero
    /* A8080 800B7880 01000224 */  addiu      $v0, $zero, 0x1
    /* A8084 800B7884 020002A2 */  sb         $v0, 0x2($s0)
    /* A8088 800B7888 32DE0208 */  j          .L800B78C8
    /* A808C 800B788C 21200002 */   addu      $a0, $s0, $zero
  .L800B7890:
    /* A8090 800B7890 380007AE */  sw         $a3, 0x38($s0)
  .L800B7894:
    /* A8094 800B7894 0000C28C */  lw         $v0, 0x0($a2)
    /* A8098 800B7898 00000000 */  nop
    /* A809C 800B789C 43110200 */  sra        $v0, $v0, 5
    /* A80A0 800B78A0 180002AE */  sw         $v0, 0x18($s0)
    /* A80A4 800B78A4 0400C28C */  lw         $v0, 0x4($a2)
    /* A80A8 800B78A8 00000000 */  nop
    /* A80AC 800B78AC 83110200 */  sra        $v0, $v0, 6
    /* A80B0 800B78B0 1C0002AE */  sw         $v0, 0x1C($s0)
    /* A80B4 800B78B4 0800C28C */  lw         $v0, 0x8($a2)
    /* A80B8 800B78B8 21200002 */  addu       $a0, $s0, $zero
    /* A80BC 800B78BC 020000A2 */  sb         $zero, 0x2($s0)
    /* A80C0 800B78C0 43110200 */  sra        $v0, $v0, 5
    /* A80C4 800B78C4 200002AE */  sw         $v0, 0x20($s0)
  .L800B78C8:
    /* A80C8 800B78C8 A5DD020C */  jal        GetAngleWind__FP17Souffle_tISouffle
    /* A80CC 800B78CC 00000000 */   nop
  .L800B78D0:
    /* A80D0 800B78D0 8E79030C */  jal        Sfx_Add__FP17Souffle_tISouffle
    /* A80D4 800B78D4 21200002 */   addu      $a0, $s0, $zero
    /* A80D8 800B78D8 21100002 */  addu       $v0, $s0, $zero
    /* A80DC 800B78DC 2400BF8F */  lw         $ra, 0x24($sp)
    /* A80E0 800B78E0 2000B08F */  lw         $s0, 0x20($sp)
    /* A80E4 800B78E4 0800E003 */  jr         $ra
    /* A80E8 800B78E8 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel Souffle_Add__FP8coorddefiT0iii
