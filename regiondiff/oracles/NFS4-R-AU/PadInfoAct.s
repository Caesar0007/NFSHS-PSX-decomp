.set noat
.set noreorder

glabel func_800F09E0
/* 800F09E0 3c028014 */  lui      $v0,0x8014
/* 800F09E4 8c428fa8 */  lw       $v0,-28760($v0)
/* 800F09E8 27bdffe0 */  addiu    $sp,$sp,-32
/* 800F09EC afb00010 */  sw       $s0,16($sp)
/* 800F09F0 00a08021 */  move     $s0,$a1
/* 800F09F4 afb10014 */  sw       $s1,20($sp)
/* 800F09F8 afbf0018 */  sw       $ra,24($sp)
/* 800F09FC 0040f809 */  jalr     $v0
/* 800F0A00 00c08821 */  move     $s1,$a2
/* 800F0A04 06010004 */  bgez     $s0,.L800F0A18
/* 800F0A08 00401821 */  move     $v1,$v0
/* 800F0A0C 906200e9 */  lbu      $v0,233($v1)
/* 800F0A10 0803c2a8 */  j        .L800F0AA0
/* 800F0A14 00000000 */  nop      
.L800F0A18:
/* 800F0A18 906200e9 */  lbu      $v0,233($v1)
/* 800F0A1C 00000000 */  nop      
/* 800F0A20 0202102a */  slt      $v0,$s0,$v0
/* 800F0A24 1040001d */  beqz     $v0,.L800F0A9C
/* 800F0A28 00101080 */  sll      $v0,$s0,0x2
/* 800F0A2C 8c630004 */  lw       $v1,4($v1)
/* 800F0A30 00501021 */  addu     $v0,$v0,$s0
/* 800F0A34 2626ffff */  addiu    $a2,$s1,-1
/* 800F0A38 00621821 */  addu     $v1,$v1,$v0
/* 800F0A3C 2cc20005 */  sltiu    $v0,$a2,5
/* 800F0A40 10400016 */  beqz     $v0,.L800F0A9C
/* 800F0A44 00061080 */  sll      $v0,$a2,0x2
/* 800F0A48 3c018005 */  lui      $at,%hi(jtbl_8005767C)
/* 800F0A4C 00220821 */  addu     $at,$at,$v0
/* 800F0A50 8c22767c */  lw       $v0,%lo(jtbl_8005767C)($at)
/* 800F0A54 00000000 */  nop      
/* 800F0A58 00400008 */  jr       $v0
/* 800F0A5C 00000000 */  nop      
.L800F0A60:
/* 800F0A60 90620000 */  lbu      $v0,0($v1)
/* 800F0A64 0803c2a8 */  j        .L800F0AA0
/* 800F0A68 00000000 */  nop      
.L800F0A6C:
/* 800F0A6C 90620001 */  lbu      $v0,1($v1)
/* 800F0A70 0803c2a8 */  j        .L800F0AA0
/* 800F0A74 00000000 */  nop      
.L800F0A78:
/* 800F0A78 90620002 */  lbu      $v0,2($v1)
/* 800F0A7C 0803c2a8 */  j        .L800F0AA0
/* 800F0A80 00000000 */  nop      
.L800F0A84:
/* 800F0A84 90620003 */  lbu      $v0,3($v1)
/* 800F0A88 0803c2a8 */  j        .L800F0AA0
/* 800F0A8C 00000000 */  nop      
.L800F0A90:
/* 800F0A90 90620004 */  lbu      $v0,4($v1)
/* 800F0A94 0803c2a8 */  j        .L800F0AA0
/* 800F0A98 00000000 */  nop      
.L800F0A9C:
/* 800F0A9C 00001021 */  move     $v0,$zero
.L800F0AA0:
/* 800F0AA0 8fbf0018 */  lw       $ra,24($sp)
/* 800F0AA4 8fb10014 */  lw       $s1,20($sp)
/* 800F0AA8 8fb00010 */  lw       $s0,16($sp)
/* 800F0AAC 03e00008 */  jr       $ra
/* 800F0AB0 27bd0020 */  addiu    $sp,$sp,32

.section .rodata
glabel jtbl_8005767C
.word .L800F0A60
.word .L800F0A6C
.word .L800F0A78
.word .L800F0A84
.word .L800F0A90
