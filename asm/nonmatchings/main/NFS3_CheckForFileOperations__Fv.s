.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching NFS3_CheckForFileOperations__Fv, 0x54

glabel NFS3_CheckForFileOperations__Fv
    /* 94EDC 800A46DC 1480023C */  lui        $v0, %hi(gFileDevice)
    /* 94EE0 800A46E0 88EA4224 */  addiu      $v0, $v0, %lo(gFileDevice)
    /* 94EE4 800A46E4 1800438C */  lw         $v1, 0x18($v0)
    /* 94EE8 800A46E8 1C00448C */  lw         $a0, 0x1C($v0)
    /* 94EEC 800A46EC 00000000 */  nop
    /* 94EF0 800A46F0 2B106400 */  sltu       $v0, $v1, $a0
    /* 94EF4 800A46F4 0C004010 */  beqz       $v0, .L800A4728
    /* 94EF8 800A46F8 21288000 */   addu      $a1, $a0, $zero
  .L800A46FC:
    /* 94EFC 800A46FC 0000628C */  lw         $v0, 0x0($v1)
    /* 94F00 800A4700 00000000 */  nop
    /* 94F04 800A4704 04004010 */  beqz       $v0, .L800A4718
    /* 94F08 800A4708 21300000 */   addu      $a2, $zero, $zero
    /* 94F0C 800A470C 2120C000 */  addu       $a0, $a2, $zero
    /* 94F10 800A4710 8D990100 */  break      1, 614
    /* 94F14 800A4714 00000000 */  nop
  .L800A4718:
    /* 94F18 800A4718 04006324 */  addiu      $v1, $v1, 0x4
    /* 94F1C 800A471C 2B106500 */  sltu       $v0, $v1, $a1
    /* 94F20 800A4720 F6FF4014 */  bnez       $v0, .L800A46FC
    /* 94F24 800A4724 00000000 */   nop
  .L800A4728:
    /* 94F28 800A4728 0800E003 */  jr         $ra
    /* 94F2C 800A472C 00000000 */   nop
endlabel NFS3_CheckForFileOperations__Fv
