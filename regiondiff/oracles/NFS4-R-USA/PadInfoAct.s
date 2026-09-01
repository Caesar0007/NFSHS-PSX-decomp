.set noat
.set noreorder

glabel func_800F09B4
/* 800F09B4 3c028014 */  lui      $v0,0x8014
/* 800F09B8 8c428f7c */  lw       $v0,-28804($v0)
/* 800F09BC 27bdffe0 */  addiu    $sp,$sp,-32
/* 800F09C0 afb00010 */  sw       $s0,16($sp)
/* 800F09C4 00a08021 */  move     $s0,$a1
/* 800F09C8 afb10014 */  sw       $s1,20($sp)
/* 800F09CC afbf0018 */  sw       $ra,24($sp)
/* 800F09D0 0040f809 */  jalr     $v0
/* 800F09D4 00c08821 */  move     $s1,$a2
/* 800F09D8 06010004 */  bgez     $s0,.L800F09EC
/* 800F09DC 00401821 */  move     $v1,$v0
/* 800F09E0 906200e9 */  lbu      $v0,233($v1)
/* 800F09E4 0803c29d */  j        .L800F0A74
/* 800F09E8 00000000 */  nop      
.L800F09EC:
/* 800F09EC 906200e9 */  lbu      $v0,233($v1)
/* 800F09F0 00000000 */  nop      
/* 800F09F4 0202102a */  slt      $v0,$s0,$v0
/* 800F09F8 1040001d */  beqz     $v0,.L800F0A70
/* 800F09FC 00101080 */  sll      $v0,$s0,0x2
/* 800F0A00 8c630004 */  lw       $v1,4($v1)
/* 800F0A04 00501021 */  addu     $v0,$v0,$s0
/* 800F0A08 2626ffff */  addiu    $a2,$s1,-1
/* 800F0A0C 00621821 */  addu     $v1,$v1,$v0
/* 800F0A10 2cc20005 */  sltiu    $v0,$a2,5
/* 800F0A14 10400016 */  beqz     $v0,.L800F0A70
/* 800F0A18 00061080 */  sll      $v0,$a2,0x2
/* 800F0A1C 3c018005 */  lui      $at,%hi(jtbl_8005767C)
/* 800F0A20 00220821 */  addu     $at,$at,$v0
/* 800F0A24 8c22767c */  lw       $v0,%lo(jtbl_8005767C)($at)
/* 800F0A28 00000000 */  nop      
/* 800F0A2C 00400008 */  jr       $v0
/* 800F0A30 00000000 */  nop      
.L800F0A34:
/* 800F0A34 90620000 */  lbu      $v0,0($v1)
/* 800F0A38 0803c29d */  j        .L800F0A74
/* 800F0A3C 00000000 */  nop      
.L800F0A40:
/* 800F0A40 90620001 */  lbu      $v0,1($v1)
/* 800F0A44 0803c29d */  j        .L800F0A74
/* 800F0A48 00000000 */  nop      
.L800F0A4C:
/* 800F0A4C 90620002 */  lbu      $v0,2($v1)
/* 800F0A50 0803c29d */  j        .L800F0A74
/* 800F0A54 00000000 */  nop      
.L800F0A58:
/* 800F0A58 90620003 */  lbu      $v0,3($v1)
/* 800F0A5C 0803c29d */  j        .L800F0A74
/* 800F0A60 00000000 */  nop      
.L800F0A64:
/* 800F0A64 90620004 */  lbu      $v0,4($v1)
/* 800F0A68 0803c29d */  j        .L800F0A74
/* 800F0A6C 00000000 */  nop      
.L800F0A70:
/* 800F0A70 00001021 */  move     $v0,$zero
.L800F0A74:
/* 800F0A74 8fbf0018 */  lw       $ra,24($sp)
/* 800F0A78 8fb10014 */  lw       $s1,20($sp)
/* 800F0A7C 8fb00010 */  lw       $s0,16($sp)
/* 800F0A80 03e00008 */  jr       $ra
/* 800F0A84 27bd0020 */  addiu    $sp,$sp,32

.section .rodata
glabel jtbl_8005767C
.word .L800F0A34
.word .L800F0A40
.word .L800F0A4C
.word .L800F0A58
.word .L800F0A64
