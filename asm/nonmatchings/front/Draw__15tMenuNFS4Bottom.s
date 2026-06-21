.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Draw__15tMenuNFS4Bottom, 0xC0

glabel Draw__15tMenuNFS4Bottom
    /* BFD8 8001B7D8 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* BFDC 8001B7DC 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* BFE0 8001B7E0 21888000 */  addu       $s1, $a0, $zero
    /* BFE4 8001B7E4 1000A427 */  addiu      $a0, $sp, 0x10
    /* BFE8 8001B7E8 39000224 */  addiu      $v0, $zero, 0x39
    /* BFEC 8001B7EC 1000A2A7 */  sh         $v0, 0x10($sp)
    /* BFF0 8001B7F0 C6000224 */  addiu      $v0, $zero, 0xC6
    /* BFF4 8001B7F4 1200A2A7 */  sh         $v0, 0x12($sp)
    /* BFF8 8001B7F8 72000224 */  addiu      $v0, $zero, 0x72
    /* BFFC 8001B7FC 1400A2A7 */  sh         $v0, 0x14($sp)
    /* C000 8001B800 0B000224 */  addiu      $v0, $zero, 0xB
    /* C004 8001B804 2000BFAF */  sw         $ra, 0x20($sp)
    /* C008 8001B808 1800B0AF */  sw         $s0, 0x18($sp)
    /* C00C 8001B80C FA67000C */  jal        func_80019FE8
    /* C010 8001B810 1600A2A7 */   sh        $v0, 0x16($sp)
    /* C014 8001B814 1000228E */  lw         $v0, 0x10($s1)
    /* C018 8001B818 00000000 */  nop
    /* C01C 8001B81C 19004010 */  beqz       $v0, .L8001B884
    /* C020 8001B820 21800000 */   addu      $s0, $zero, $zero
  .L8001B824:
    /* C024 8001B824 003C1000 */  sll        $a3, $s0, 16
    /* C028 8001B828 033C0700 */  sra        $a3, $a3, 16
    /* C02C 8001B82C 80100700 */  sll        $v0, $a3, 2
    /* C030 8001B830 21102202 */  addu       $v0, $s1, $v0
    /* C034 8001B834 21280000 */  addu       $a1, $zero, $zero
    /* C038 8001B838 1000438C */  lw         $v1, 0x10($v0)
    /* C03C 8001B83C 0800228E */  lw         $v0, 0x8($s1)
    /* C040 8001B840 2130A000 */  addu       $a2, $a1, $zero
    /* C044 8001B844 2638E200 */  xor        $a3, $a3, $v0
    /* C048 8001B848 1800688C */  lw         $t0, 0x18($v1)
    /* C04C 8001B84C 0100E72C */  sltiu      $a3, $a3, 0x1
    /* C050 8001B850 28000485 */  lh         $a0, 0x28($t0)
    /* C054 8001B854 2C00028D */  lw         $v0, 0x2C($t0)
    /* C058 8001B858 00000000 */  nop
    /* C05C 8001B85C 09F84000 */  jalr       $v0
    /* C060 8001B860 21206400 */   addu      $a0, $v1, $a0
    /* C064 8001B864 01000326 */  addiu      $v1, $s0, 0x1
    /* C068 8001B868 00140300 */  sll        $v0, $v1, 16
    /* C06C 8001B86C 83130200 */  sra        $v0, $v0, 14
    /* C070 8001B870 21102202 */  addu       $v0, $s1, $v0
    /* C074 8001B874 1000428C */  lw         $v0, 0x10($v0)
    /* C078 8001B878 00000000 */  nop
    /* C07C 8001B87C E9FF4014 */  bnez       $v0, .L8001B824
    /* C080 8001B880 21806000 */   addu      $s0, $v1, $zero
  .L8001B884:
    /* C084 8001B884 2000BF8F */  lw         $ra, 0x20($sp)
    /* C088 8001B888 1C00B18F */  lw         $s1, 0x1C($sp)
    /* C08C 8001B88C 1800B08F */  lw         $s0, 0x18($sp)
    /* C090 8001B890 0800E003 */  jr         $ra
    /* C094 8001B894 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel Draw__15tMenuNFS4Bottom
