.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching readfile_systask, 0xA0

glabel readfile_systask
    /* E4780 800F3F80 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* E4784 800F3F84 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* E4788 800F3F88 1800B2AF */  sw         $s2, 0x18($sp)
    /* E478C 800F3F8C 1400B1AF */  sw         $s1, 0x14($sp)
    /* E4790 800F3F90 1000B0AF */  sw         $s0, 0x10($sp)
    /* E4794 800F3F94 00601240 */  mfc0       $s2, $12 /* handwritten instruction */
    /* E4798 800F3F98 00000000 */  nop
    /* E479C 800F3F9C FEFB0124 */  addiu      $at, $zero, -0x402
    /* E47A0 800F3FA0 24404102 */  and        $t0, $s2, $at
    /* E47A4 800F3FA4 00608840 */  mtc0       $t0, $12 /* handwritten instruction */
    /* E47A8 800F3FA8 00000000 */  nop
    /* E47AC 800F3FAC 00000000 */  nop
    /* E47B0 800F3FB0 00000000 */  nop
    /* E47B4 800F3FB4 1480113C */  lui        $s1, %hi(readcmd)
    /* E47B8 800F3FB8 0004228E */  lw         $v0, %lo(readcmd)($s1)
    /* E47BC 800F3FBC 00000000 */  nop
    /* E47C0 800F3FC0 0F004010 */  beqz       $v0, .L800F4000
    /* E47C4 800F3FC4 00043026 */   addiu     $s0, $s1, %lo(readcmd)
    /* E47C8 800F3FC8 0400048E */  lw         $a0, 0x4($s0)
    /* E47CC 800F3FCC 0C00058E */  lw         $a1, 0xC($s0)
    /* E47D0 800F3FD0 471B040C */  jal        PClseek
    /* E47D4 800F3FD4 21300000 */   addu      $a2, $zero, $zero
    /* E47D8 800F3FD8 0400048E */  lw         $a0, 0x4($s0)
    /* E47DC 800F3FDC 0800058E */  lw         $a1, 0x8($s0)
    /* E47E0 800F3FE0 1000068E */  lw         $a2, 0x10($s0)
    /* E47E4 800F3FE4 F91A040C */  jal        PCread
    /* E47E8 800F3FE8 00000000 */   nop
    /* E47EC 800F3FEC 1000038E */  lw         $v1, 0x10($s0)
    /* E47F0 800F3FF0 000420AE */  sw         $zero, %lo(readcmd)($s1)
    /* E47F4 800F3FF4 26104300 */  xor        $v0, $v0, $v1
    /* E47F8 800F3FF8 08B4030C */  jal        iFILE_CommandCompleteCallback
    /* E47FC 800F3FFC 0100442C */   sltiu     $a0, $v0, 0x1
  .L800F4000:
    /* E4800 800F4000 00609240 */  mtc0       $s2, $12 /* handwritten instruction */
    /* E4804 800F4004 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* E4808 800F4008 1800B28F */  lw         $s2, 0x18($sp)
    /* E480C 800F400C 1400B18F */  lw         $s1, 0x14($sp)
    /* E4810 800F4010 1000B08F */  lw         $s0, 0x10($sp)
    /* E4814 800F4014 21100000 */  addu       $v0, $zero, $zero
    /* E4818 800F4018 0800E003 */  jr         $ra
    /* E481C 800F401C 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel readfile_systask
