.set noat
.set noreorder

glabel func_8002CAF0
/* 8002CAF0 27bdffe0 */  addiu    $sp,$sp,-32
/* 8002CAF4 afb00010 */  sw       $s0,16($sp)
/* 8002CAF8 00808021 */  move     $s0,$a0
/* 8002CAFC afb10014 */  sw       $s1,20($sp)
/* 8002CB00 3c118005 */  lui      $s1,0x8005
/* 8002CB04 3c028005 */  lui      $v0,0x8005
/* 8002CB08 8e241d70 */  lw       $a0,7536($s1)
/* 8002CB0C 8c433148 */  lw       $v1,12616($v0)
/* 8002CB10 2402027f */  li       $v0,639
/* 8002CB14 afbf001c */  sw       $ra,28($sp)
/* 8002CB18 afb20018 */  sw       $s2,24($sp)
/* 8002CB1C 0c004e43 */  jal      func_8001390C
/* 8002CB20 ac620584 */  sw       $v0,1412($v1)
/* 8002CB24 3c028005 */  lui      $v0,0x8005
/* 8002CB28 8c4222d0 */  lw       $v0,8912($v0)
/* 8002CB2C 00000000 */  nop      
/* 8002CB30 10400003 */  beqz     $v0,.L8002CB40
/* 8002CB34 00009021 */  move     $s2,$zero
/* 8002CB38 1200001f */  beqz     $s0,.L8002CBB8
/* 8002CB3C 00000000 */  nop      
.L8002CB40:
/* 8002CB40 8e301d70 */  lw       $s0,7536($s1)
/* 8002CB44 24040283 */  li       $a0,643
/* 8002CB48 0c02e7c7 */  jal      func_800B9F1C
/* 8002CB4C 261002d0 */  addiu    $s0,$s0,720
/* 8002CB50 8e241d70 */  lw       $a0,7536($s1)
/* 8002CB54 ae020090 */  sw       $v0,144($s0)
/* 8002CB58 0c006280 */  jal      func_80018A00
/* 8002CB5C 248402d0 */  addiu    $a0,$a0,720
.L8002CB60:
/* 8002CB60 8e241d70 */  lw       $a0,7536($s1)
/* 8002CB64 00000000 */  nop      
/* 8002CB68 8c820354 */  lw       $v0,852($a0)
/* 8002CB6C 00000000 */  nop      
/* 8002CB70 38420001 */  xori     $v0,$v0,0x1
/* 8002CB74 10400005 */  beqz     $v0,.L8002CB8C
/* 8002CB78 00000000 */  nop      
/* 8002CB7C 0c004e43 */  jal      func_8001390C
/* 8002CB80 00000000 */  nop      
/* 8002CB84 0800b2d8 */  j        .L8002CB60
/* 8002CB88 00000000 */  nop      
.L8002CB8C:
/* 8002CB8C 0c004e43 */  jal      func_8001390C
/* 8002CB90 00000000 */  nop      
/* 8002CB94 3c028005 */  lui      $v0,0x8005
/* 8002CB98 8c4222d0 */  lw       $v0,8912($v0)
/* 8002CB9C 00000000 */  nop      
/* 8002CBA0 14400005 */  bnez     $v0,.L8002CBB8
/* 8002CBA4 00000000 */  nop      
/* 8002CBA8 24120001 */  li       $s2,1
/* 8002CBAC 02402021 */  move     $a0,$s2
/* 8002CBB0 0c00d229 */  jal      func_800348A4
/* 8002CBB4 00002821 */  move     $a1,$zero
.L8002CBB8:
/* 8002CBB8 0c00d2cd */  jal      func_80034B34
/* 8002CBBC 00002021 */  move     $a0,$zero
/* 8002CBC0 3c038005 */  lui      $v1,0x8005
/* 8002CBC4 8c643148 */  lw       $a0,12616($v1)
/* 8002CBC8 2403ffff */  li       $v1,-1
/* 8002CBCC 00408021 */  move     $s0,$v0
/* 8002CBD0 12400003 */  beqz     $s2,.L8002CBE0
/* 8002CBD4 ac830584 */  sw       $v1,1412($a0)
/* 8002CBD8 0c00d283 */  jal      func_80034A0C
/* 8002CBDC 00000000 */  nop      
.L8002CBE0:
/* 8002CBE0 3c028005 */  lui      $v0,0x8005
/* 8002CBE4 8c441d70 */  lw       $a0,7536($v0)
/* 8002CBE8 0c0062b1 */  jal      func_80018AC4
/* 8002CBEC 248402d0 */  addiu    $a0,$a0,720
/* 8002CBF0 02001021 */  move     $v0,$s0
/* 8002CBF4 8fbf001c */  lw       $ra,28($sp)
/* 8002CBF8 8fb20018 */  lw       $s2,24($sp)
/* 8002CBFC 8fb10014 */  lw       $s1,20($sp)
/* 8002CC00 8fb00010 */  lw       $s0,16($sp)
/* 8002CC04 03e00008 */  jr       $ra
/* 8002CC08 27bd0020 */  addiu    $sp,$sp,32
