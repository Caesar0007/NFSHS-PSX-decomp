.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iFILE_CommandCompleteCallback, 0xB4

glabel iFILE_CommandCompleteCallback
    /* DD820 800ED020 1480023C */  lui        $v0, %hi(D_8013EA9C)
    /* DD824 800ED024 9CEA468C */  lw         $a2, %lo(D_8013EA9C)($v0)
    /* DD828 800ED028 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* DD82C 800ED02C 1400BFAF */  sw         $ra, 0x14($sp)
    /* DD830 800ED030 2400C010 */  beqz       $a2, .L800ED0C4
    /* DD834 800ED034 1000B0AF */   sw        $s0, 0x10($sp)
    /* DD838 800ED038 0400C28C */  lw         $v0, 0x4($a2)
    /* DD83C 800ED03C 0800C38C */  lw         $v1, 0x8($a2)
    /* DD840 800ED040 04004014 */  bnez       $v0, .L800ED054
    /* DD844 800ED044 FFFF0224 */   addiu     $v0, $zero, -0x1
    /* DD848 800ED048 02008010 */  beqz       $a0, .L800ED054
    /* DD84C 800ED04C FEFF0224 */   addiu     $v0, $zero, -0x2
    /* DD850 800ED050 01000224 */  addiu      $v0, $zero, 0x1
  .L800ED054:
    /* DD854 800ED054 0800C2AC */  sw         $v0, 0x8($a2)
    /* DD858 800ED058 1480023C */  lui        $v0, %hi(gFileDevice)
    /* DD85C 800ED05C 88EA5024 */  addiu      $s0, $v0, %lo(gFileDevice)
    /* DD860 800ED060 140000AE */  sw         $zero, 0x14($s0)
    /* DD864 800ED064 2800C28C */  lw         $v0, 0x28($a2)
    /* DD868 800ED068 00000000 */  nop
    /* DD86C 800ED06C 0F004010 */  beqz       $v0, .L800ED0AC
    /* DD870 800ED070 00000000 */   nop
    /* DD874 800ED074 1000028E */  lw         $v0, 0x10($s0)
    /* DD878 800ED078 00000000 */  nop
    /* DD87C 800ED07C 01004224 */  addiu      $v0, $v0, 0x1
    /* DD880 800ED080 100002AE */  sw         $v0, 0x10($s0)
    /* DD884 800ED084 0000C48C */  lw         $a0, 0x0($a2)
    /* DD888 800ED088 2800C28C */  lw         $v0, 0x28($a2)
    /* DD88C 800ED08C 0800C58C */  lw         $a1, 0x8($a2)
    /* DD890 800ED090 1400C68C */  lw         $a2, 0x14($a2)
    /* DD894 800ED094 09F84000 */  jalr       $v0
    /* DD898 800ED098 00000000 */   nop
    /* DD89C 800ED09C 1000028E */  lw         $v0, 0x10($s0)
    /* DD8A0 800ED0A0 00000000 */  nop
    /* DD8A4 800ED0A4 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* DD8A8 800ED0A8 100002AE */  sw         $v0, 0x10($s0)
  .L800ED0AC:
    /* DD8AC 800ED0AC 1000028E */  lw         $v0, 0x10($s0)
    /* DD8B0 800ED0B0 00000000 */  nop
    /* DD8B4 800ED0B4 03004014 */  bnez       $v0, .L800ED0C4
    /* DD8B8 800ED0B8 00000000 */   nop
    /* DD8BC 800ED0BC E6B2030C */  jal        iFILE_ExecCommand
    /* DD8C0 800ED0C0 21200000 */   addu      $a0, $zero, $zero
  .L800ED0C4:
    /* DD8C4 800ED0C4 1400BF8F */  lw         $ra, 0x14($sp)
    /* DD8C8 800ED0C8 1000B08F */  lw         $s0, 0x10($sp)
    /* DD8CC 800ED0CC 0800E003 */  jr         $ra
    /* DD8D0 800ED0D0 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel iFILE_CommandCompleteCallback
