.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SND3dpos, 0xC4

glabel SND3dpos
    /* D88E4 800E80E4 1480023C */  lui        $v0, %hi(D_8014789C)
    /* D88E8 800E80E8 9C784280 */  lb         $v0, %lo(D_8014789C)($v0)
    /* D88EC 800E80EC D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* D88F0 800E80F0 1800B0AF */  sw         $s0, 0x18($sp)
    /* D88F4 800E80F4 21808000 */  addu       $s0, $a0, $zero
    /* D88F8 800E80F8 2000B2AF */  sw         $s2, 0x20($sp)
    /* D88FC 800E80FC 2190A000 */  addu       $s2, $a1, $zero
    /* D8900 800E8100 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* D8904 800E8104 2188C000 */  addu       $s1, $a2, $zero
    /* D8908 800E8108 03004014 */  bnez       $v0, .L800E8118
    /* D890C 800E810C 2400BFAF */   sw        $ra, 0x24($sp)
    /* D8910 800E8110 64A00308 */  j          .L800E8190
    /* D8914 800E8114 F6FF0224 */   addiu     $v0, $zero, -0xA
  .L800E8118:
    /* D8918 800E8118 0040222A */  slti       $v0, $s1, 0x4000
    /* D891C 800E811C 03004014 */  bnez       $v0, .L800E812C
    /* D8920 800E8120 FFFF5232 */   andi      $s2, $s2, 0xFFFF
    /* D8924 800E8124 4FA00308 */  j          .L800E813C
    /* D8928 800E8128 FF3F1124 */   addiu     $s1, $zero, 0x3FFF
  .L800E812C:
    /* D892C 800E812C 00C0222A */  slti       $v0, $s1, -0x4000
    /* D8930 800E8130 02004010 */  beqz       $v0, .L800E813C
    /* D8934 800E8134 00000000 */   nop
    /* D8938 800E8138 00C01124 */  addiu      $s1, $zero, -0x4000
  .L800E813C:
    /* D893C 800E813C 4DA9030C */  jal        iSNDenteraudio
    /* D8940 800E8140 00000000 */   nop
    /* D8944 800E8144 71FB030C */  jal        iSNDgetchan
    /* D8948 800E8148 21200002 */   addu      $a0, $s0, $zero
    /* D894C 800E814C 21804000 */  addu       $s0, $v0, $zero
    /* D8950 800E8150 0C000006 */  bltz       $s0, .L800E8184
    /* D8954 800E8154 FFFF0224 */   addiu     $v0, $zero, -0x1
    /* D8958 800E8158 1000A2AF */  sw         $v0, 0x10($sp)
    /* D895C 800E815C 21200002 */  addu       $a0, $s0, $zero
  .L800E8160:
    /* D8960 800E8160 D3FB030C */  jal        iSNDpatchkey
    /* D8964 800E8164 1000A527 */   addiu     $a1, $sp, 0x10
    /* D8968 800E8168 06004010 */  beqz       $v0, .L800E8184
    /* D896C 800E816C 21284002 */   addu      $a1, $s2, $zero
    /* D8970 800E8170 1000A48F */  lw         $a0, 0x10($sp)
    /* D8974 800E8174 8CFB030C */  jal        iSNDplatform3dpos
    /* D8978 800E8178 21302002 */   addu      $a2, $s1, $zero
    /* D897C 800E817C 58A00308 */  j          .L800E8160
    /* D8980 800E8180 21200002 */   addu      $a0, $s0, $zero
  .L800E8184:
    /* D8984 800E8184 5BA9030C */  jal        iSNDleaveaudio
    /* D8988 800E8188 00000000 */   nop
    /* D898C 800E818C 21100002 */  addu       $v0, $s0, $zero
  .L800E8190:
    /* D8990 800E8190 2400BF8F */  lw         $ra, 0x24($sp)
    /* D8994 800E8194 2000B28F */  lw         $s2, 0x20($sp)
    /* D8998 800E8198 1C00B18F */  lw         $s1, 0x1C($sp)
    /* D899C 800E819C 1800B08F */  lw         $s0, 0x18($sp)
    /* D89A0 800E81A0 0800E003 */  jr         $ra
    /* D89A4 800E81A4 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel SND3dpos
