.set noat
.set noreorder

glabel func_8003EB88
/* 8003EB88 3c028005 */  lui      $v0,0x8005
/* 8003EB8C 8c421470 */  lw       $v0,5232($v0)
/* 8003EB90 27bdffe0 */  addiu    $sp,$sp,-32
/* 8003EB94 afb10014 */  sw       $s1,20($sp)
/* 8003EB98 00808821 */  move     $s1,$a0
/* 8003EB9C afbf001c */  sw       $ra,28($sp)
/* 8003EBA0 afb20018 */  sw       $s2,24($sp)
/* 8003EBA4 afb00010 */  sw       $s0,16($sp)
/* 8003EBA8 9044022c */  lbu      $a0,556($v0)
/* 8003EBAC 00000000 */  nop      
/* 8003EBB0 00041880 */  sll      $v1,$a0,0x2
/* 8003EBB4 00431021 */  addu     $v0,$v0,$v1
/* 8003EBB8 8c420230 */  lw       $v0,560($v0)
/* 8003EBBC 00000000 */  nop      
/* 8003EBC0 10400019 */  beqz     $v0,.L8003EC28
/* 8003EBC4 00808021 */  move     $s0,$a0
/* 8003EBC8 14800002 */  bnez     $a0,.L8003EBD4
/* 8003EBCC 2402003c */  li       $v0,60
/* 8003EBD0 2402ffc4 */  li       $v0,-60
.L8003EBD4:
/* 8003EBD4 240402a9 */  li       $a0,681
/* 8003EBD8 263103a0 */  addiu    $s1,$s1,928
/* 8003EBDC a620007c */  sh       $zero,124($s1)
/* 8003EBE0 a622007e */  sh       $v0,126($s1)
/* 8003EBE4 0c02e733 */  jal      func_800B9CCC
/* 8003EBE8 a6300064 */  sh       $s0,100($s1)
/* 8003EBEC 24040001 */  li       $a0,1
/* 8003EBF0 00902023 */  subu     $a0,$a0,$s0
/* 8003EBF4 0c00adb1 */  jal      func_8002B6C4
/* 8003EBF8 00409021 */  move     $s2,$v0
/* 8003EBFC 3c108005 */  lui      $s0,0x8005
/* 8003EC00 26102bb0 */  addiu    $s0,$s0,11184
/* 8003EC04 02002021 */  move     $a0,$s0
/* 8003EC08 02402821 */  move     $a1,$s2
/* 8003EC0C 0c0393a5 */  jal      func_800E4E94
/* 8003EC10 00403021 */  move     $a2,$v0
/* 8003EC14 02202021 */  move     $a0,$s1
/* 8003EC18 0c0061f2 */  jal      func_800187C8
/* 8003EC1C ac900090 */  sw       $s0,144($a0)
/* 8003EC20 0800fb0c */  j        .L8003EC30
/* 8003EC24 00000000 */  nop      
.L8003EC28:
/* 8003EC28 0c006223 */  jal      func_8001888C
/* 8003EC2C 262403a0 */  addiu    $a0,$s1,928
.L8003EC30:
/* 8003EC30 8fbf001c */  lw       $ra,28($sp)
/* 8003EC34 8fb20018 */  lw       $s2,24($sp)
/* 8003EC38 8fb10014 */  lw       $s1,20($sp)
/* 8003EC3C 8fb00010 */  lw       $s0,16($sp)
/* 8003EC40 03e00008 */  jr       $ra
/* 8003EC44 27bd0020 */  addiu    $sp,$sp,32
