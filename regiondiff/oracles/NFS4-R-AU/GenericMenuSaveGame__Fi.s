.set noat
.set noreorder

glabel func_8002CA98
/* 8002CA98 27bdffe0 */  addiu    $sp,$sp,-32
/* 8002CA9C afb00010 */  sw       $s0,16($sp)
/* 8002CAA0 00808021 */  move     $s0,$a0
/* 8002CAA4 afb10014 */  sw       $s1,20($sp)
/* 8002CAA8 3c118005 */  lui      $s1,0x8005
/* 8002CAAC 3c028005 */  lui      $v0,0x8005
/* 8002CAB0 8e241a60 */  lw       $a0,6752($s1)
/* 8002CAB4 8c432e40 */  lw       $v1,11840($v0)
/* 8002CAB8 2402027f */  li       $v0,639
/* 8002CABC afbf001c */  sw       $ra,28($sp)
/* 8002CAC0 afb20018 */  sw       $s2,24($sp)
/* 8002CAC4 0c004e2d */  jal      func_800138B4
/* 8002CAC8 ac620584 */  sw       $v0,1412($v1)
/* 8002CACC 3c028005 */  lui      $v0,0x8005
/* 8002CAD0 8c421fc0 */  lw       $v0,8128($v0)
/* 8002CAD4 00000000 */  nop      
/* 8002CAD8 10400003 */  beqz     $v0,.L8002CAE8
/* 8002CADC 00009021 */  move     $s2,$zero
/* 8002CAE0 1200001f */  beqz     $s0,.L8002CB60
/* 8002CAE4 00000000 */  nop      
.L8002CAE8:
/* 8002CAE8 8e301a60 */  lw       $s0,6752($s1)
/* 8002CAEC 24040283 */  li       $a0,643
/* 8002CAF0 0c02e7c7 */  jal      func_800B9F1C
/* 8002CAF4 261002d0 */  addiu    $s0,$s0,720
/* 8002CAF8 8e241a60 */  lw       $a0,6752($s1)
/* 8002CAFC ae020090 */  sw       $v0,144($s0)
/* 8002CB00 0c00626a */  jal      func_800189A8
/* 8002CB04 248402d0 */  addiu    $a0,$a0,720
.L8002CB08:
/* 8002CB08 8e241a60 */  lw       $a0,6752($s1)
/* 8002CB0C 00000000 */  nop      
/* 8002CB10 8c820354 */  lw       $v0,852($a0)
/* 8002CB14 00000000 */  nop      
/* 8002CB18 38420001 */  xori     $v0,$v0,0x1
/* 8002CB1C 10400005 */  beqz     $v0,.L8002CB34
/* 8002CB20 00000000 */  nop      
/* 8002CB24 0c004e2d */  jal      func_800138B4
/* 8002CB28 00000000 */  nop      
/* 8002CB2C 0800b2c2 */  j        .L8002CB08
/* 8002CB30 00000000 */  nop      
.L8002CB34:
/* 8002CB34 0c004e2d */  jal      func_800138B4
/* 8002CB38 00000000 */  nop      
/* 8002CB3C 3c028005 */  lui      $v0,0x8005
/* 8002CB40 8c421fc0 */  lw       $v0,8128($v0)
/* 8002CB44 00000000 */  nop      
/* 8002CB48 14400005 */  bnez     $v0,.L8002CB60
/* 8002CB4C 00000000 */  nop      
/* 8002CB50 24120001 */  li       $s2,1
/* 8002CB54 02402021 */  move     $a0,$s2
/* 8002CB58 0c00d213 */  jal      func_8003484C
/* 8002CB5C 00002821 */  move     $a1,$zero
.L8002CB60:
/* 8002CB60 0c00d2b7 */  jal      func_80034ADC
/* 8002CB64 00002021 */  move     $a0,$zero
/* 8002CB68 3c038005 */  lui      $v1,0x8005
/* 8002CB6C 8c642e40 */  lw       $a0,11840($v1)
/* 8002CB70 2403ffff */  li       $v1,-1
/* 8002CB74 00408021 */  move     $s0,$v0
/* 8002CB78 12400003 */  beqz     $s2,.L8002CB88
/* 8002CB7C ac830584 */  sw       $v1,1412($a0)
/* 8002CB80 0c00d26d */  jal      func_800349B4
/* 8002CB84 00000000 */  nop      
.L8002CB88:
/* 8002CB88 3c028005 */  lui      $v0,0x8005
/* 8002CB8C 8c441a60 */  lw       $a0,6752($v0)
/* 8002CB90 0c00629b */  jal      func_80018A6C
/* 8002CB94 248402d0 */  addiu    $a0,$a0,720
/* 8002CB98 02001021 */  move     $v0,$s0
/* 8002CB9C 8fbf001c */  lw       $ra,28($sp)
/* 8002CBA0 8fb20018 */  lw       $s2,24($sp)
/* 8002CBA4 8fb10014 */  lw       $s1,20($sp)
/* 8002CBA8 8fb00010 */  lw       $s0,16($sp)
/* 8002CBAC 03e00008 */  jr       $ra
/* 8002CBB0 27bd0020 */  addiu    $sp,$sp,32
