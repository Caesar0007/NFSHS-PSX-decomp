.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDpsxzerospu, 0x38

glabel iSNDpsxzerospu
    /* F41C4 801039C4 83280500 */  sra        $a1, $a1, 2
    /* F41C8 801039C8 0A00A018 */  blez       $a1, .L801039F4
    /* F41CC 801039CC 21180000 */   addu      $v1, $zero, $zero
    /* F41D0 801039D0 00020624 */  addiu      $a2, $zero, 0x200
  .L801039D4:
    /* F41D4 801039D4 000086AC */  sw         $a2, 0x0($a0)
    /* F41D8 801039D8 040080AC */  sw         $zero, 0x4($a0)
    /* F41DC 801039DC 080080AC */  sw         $zero, 0x8($a0)
    /* F41E0 801039E0 0C0080AC */  sw         $zero, 0xC($a0)
    /* F41E4 801039E4 04006324 */  addiu      $v1, $v1, 0x4
    /* F41E8 801039E8 2A106500 */  slt        $v0, $v1, $a1
    /* F41EC 801039EC F9FF4014 */  bnez       $v0, .L801039D4
    /* F41F0 801039F0 10008424 */   addiu     $a0, $a0, 0x10
  .L801039F4:
    /* F41F4 801039F4 0800E003 */  jr         $ra
    /* F41F8 801039F8 00000000 */   nop
endlabel iSNDpsxzerospu
