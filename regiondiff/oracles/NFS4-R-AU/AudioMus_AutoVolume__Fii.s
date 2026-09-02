.set noat
.set noreorder

glabel func_8007BE00
/* 8007BE00 8f8201d8 */  lw       $v0,472($gp)
/* 8007BE04 27bdffe0 */  addiu    $sp,$sp,-32
/* 8007BE08 afb10014 */  sw       $s1,20($sp)
/* 8007BE0C 00808821 */  move     $s1,$a0
/* 8007BE10 afb00010 */  sw       $s0,16($sp)
/* 8007BE14 00a08021 */  move     $s0,$a1
/* 8007BE18 10400024 */  beqz     $v0,.L8007BEAC
/* 8007BE1C afbf0018 */  sw       $ra,24($sp)
/* 8007BE20 8c430000 */  lw       $v1,0($v0)
/* 8007BE24 00000000 */  nop      
/* 8007BE28 10700020 */  beq      $v1,$s0,.L8007BEAC
/* 8007BE2C 00000000 */  nop      
/* 8007BE30 16000006 */  bnez     $s0,.L8007BE4C
/* 8007BE34 00000000 */  nop      
/* 8007BE38 ac400000 */  sw       $zero,0($v0)
/* 8007BE3C 0c01ede6 */  jal      func_8007B798
/* 8007BE40 00002021 */  move     $a0,$zero
/* 8007BE44 0801efab */  j        .L8007BEAC
/* 8007BE48 00000000 */  nop      
.L8007BE4C:
/* 8007BE4C 14600006 */  bnez     $v1,.L8007BE68
/* 8007BE50 00000000 */  nop      
/* 8007BE54 ac500000 */  sw       $s0,0($v0)
/* 8007BE58 0c01ee71 */  jal      func_8007B9C4
/* 8007BE5C 00002021 */  move     $a0,$zero
/* 8007BE60 0801ef9b */  j        .L8007BE6C
/* 8007BE64 00000000 */  nop      
.L8007BE68:
/* 8007BE68 ac500000 */  sw       $s0,0($v0)
.L8007BE6C:
/* 8007BE6C 8f8401d8 */  lw       $a0,472($gp)
/* 8007BE70 00000000 */  nop      
/* 8007BE74 8c830014 */  lw       $v1,20($a0)
/* 8007BE78 24020002 */  li       $v0,2
/* 8007BE7C 1062000b */  beq      $v1,$v0,.L8007BEAC
/* 8007BE80 00000000 */  nop      
/* 8007BE84 8c820020 */  lw       $v0,32($a0)
/* 8007BE88 00000000 */  nop      
/* 8007BE8C 14400007 */  bnez     $v0,.L8007BEAC
/* 8007BE90 00000000 */  nop      
/* 8007BE94 8c840070 */  lw       $a0,112($a0)
/* 8007BE98 00000000 */  nop      
/* 8007BE9C 04800003 */  bltz     $a0,.L8007BEAC
/* 8007BEA0 02202821 */  move     $a1,$s1
/* 8007BEA4 0c03a9cc */  jal      func_800EA730
/* 8007BEA8 02003021 */  move     $a2,$s0
.L8007BEAC:
/* 8007BEAC 8fbf0018 */  lw       $ra,24($sp)
/* 8007BEB0 8fb10014 */  lw       $s1,20($sp)
/* 8007BEB4 8fb00010 */  lw       $s0,16($sp)
/* 8007BEB8 03e00008 */  jr       $ra
/* 8007BEBC 27bd0020 */  addiu    $sp,$sp,32
