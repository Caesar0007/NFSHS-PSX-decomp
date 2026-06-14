.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawSync, 0x68

glabel DrawSync
    /* DE07C 800ED87C 1280023C */  lui        $v0, %hi(D_8012369E)
    /* DE080 800ED880 9E364290 */  lbu        $v0, %lo(D_8012369E)($v0)
    /* DE084 800ED884 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* DE088 800ED888 1000B0AF */  sw         $s0, 0x10($sp)
    /* DE08C 800ED88C 21808000 */  addu       $s0, $a0, $zero
    /* DE090 800ED890 0200422C */  sltiu      $v0, $v0, 0x2
    /* DE094 800ED894 08004014 */  bnez       $v0, .L800ED8B8
    /* DE098 800ED898 1400BFAF */   sw        $ra, 0x14($sp)
    /* DE09C 800ED89C 0580043C */  lui        $a0, %hi(D_80056DB4)
    /* DE0A0 800ED8A0 B46D8424 */  addiu      $a0, $a0, %lo(D_80056DB4)
    /* DE0A4 800ED8A4 1280023C */  lui        $v0, %hi(GPU_printf)
    /* DE0A8 800ED8A8 9836428C */  lw         $v0, %lo(GPU_printf)($v0)
    /* DE0AC 800ED8AC 00000000 */  nop
    /* DE0B0 800ED8B0 09F84000 */  jalr       $v0
    /* DE0B4 800ED8B4 21280002 */   addu      $a1, $s0, $zero
  .L800ED8B8:
    /* DE0B8 800ED8B8 1280023C */  lui        $v0, %hi(D_80123694)
    /* DE0BC 800ED8BC 9436428C */  lw         $v0, %lo(D_80123694)($v0)
    /* DE0C0 800ED8C0 00000000 */  nop
    /* DE0C4 800ED8C4 3C00428C */  lw         $v0, 0x3C($v0)
    /* DE0C8 800ED8C8 00000000 */  nop
    /* DE0CC 800ED8CC 09F84000 */  jalr       $v0
    /* DE0D0 800ED8D0 21200002 */   addu      $a0, $s0, $zero
    /* DE0D4 800ED8D4 1400BF8F */  lw         $ra, 0x14($sp)
    /* DE0D8 800ED8D8 1000B08F */  lw         $s0, 0x10($sp)
    /* DE0DC 800ED8DC 0800E003 */  jr         $ra
    /* DE0E0 800ED8E0 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel DrawSync
