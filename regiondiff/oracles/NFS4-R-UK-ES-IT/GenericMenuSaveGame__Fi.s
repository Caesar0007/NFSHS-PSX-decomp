.set noat
.set noreorder

glabel func_8002CB08
/* 8002CB08 27bdffe0 */  addiu    $sp,$sp,-32
/* 8002CB0C afb00010 */  sw       $s0,16($sp)
/* 8002CB10 00808021 */  move     $s0,$a0
/* 8002CB14 afb10014 */  sw       $s1,20($sp)
/* 8002CB18 3c118005 */  lui      $s1,0x8005
/* 8002CB1C 3c028005 */  lui      $v0,0x8005
/* 8002CB20 8e241db0 */  lw       $a0,7600($s1)
/* 8002CB24 8c433188 */  lw       $v1,12680($v0)
/* 8002CB28 2402027f */  li       $v0,639
/* 8002CB2C afbf001c */  sw       $ra,28($sp)
/* 8002CB30 afb20018 */  sw       $s2,24($sp)
/* 8002CB34 0c004e49 */  jal      func_80013924
/* 8002CB38 ac620584 */  sw       $v0,1412($v1)
/* 8002CB3C 3c028005 */  lui      $v0,0x8005
/* 8002CB40 8c422310 */  lw       $v0,8976($v0)
/* 8002CB44 00000000 */  nop      
/* 8002CB48 10400003 */  beqz     $v0,.L8002CB58
/* 8002CB4C 00009021 */  move     $s2,$zero
/* 8002CB50 1200001f */  beqz     $s0,.L8002CBD0
/* 8002CB54 00000000 */  nop      
.L8002CB58:
/* 8002CB58 8e301db0 */  lw       $s0,7600($s1)
/* 8002CB5C 24040283 */  li       $a0,643
/* 8002CB60 0c02e7c7 */  jal      func_800B9F1C
/* 8002CB64 261002d0 */  addiu    $s0,$s0,720
/* 8002CB68 8e241db0 */  lw       $a0,7600($s1)
/* 8002CB6C ae020090 */  sw       $v0,144($s0)
/* 8002CB70 0c006286 */  jal      func_80018A18
/* 8002CB74 248402d0 */  addiu    $a0,$a0,720
.L8002CB78:
/* 8002CB78 8e241db0 */  lw       $a0,7600($s1)
/* 8002CB7C 00000000 */  nop      
/* 8002CB80 8c820354 */  lw       $v0,852($a0)
/* 8002CB84 00000000 */  nop      
/* 8002CB88 38420001 */  xori     $v0,$v0,0x1
/* 8002CB8C 10400005 */  beqz     $v0,.L8002CBA4
/* 8002CB90 00000000 */  nop      
/* 8002CB94 0c004e49 */  jal      func_80013924
/* 8002CB98 00000000 */  nop      
/* 8002CB9C 0800b2de */  j        .L8002CB78
/* 8002CBA0 00000000 */  nop      
.L8002CBA4:
/* 8002CBA4 0c004e49 */  jal      func_80013924
/* 8002CBA8 00000000 */  nop      
/* 8002CBAC 3c028005 */  lui      $v0,0x8005
/* 8002CBB0 8c422310 */  lw       $v0,8976($v0)
/* 8002CBB4 00000000 */  nop      
/* 8002CBB8 14400005 */  bnez     $v0,.L8002CBD0
/* 8002CBBC 00000000 */  nop      
/* 8002CBC0 24120001 */  li       $s2,1
/* 8002CBC4 02402021 */  move     $a0,$s2
/* 8002CBC8 0c00d22f */  jal      func_800348BC
/* 8002CBCC 00002821 */  move     $a1,$zero
.L8002CBD0:
/* 8002CBD0 0c00d2d3 */  jal      func_80034B4C
/* 8002CBD4 00002021 */  move     $a0,$zero
/* 8002CBD8 3c038005 */  lui      $v1,0x8005
/* 8002CBDC 8c643188 */  lw       $a0,12680($v1)
/* 8002CBE0 2403ffff */  li       $v1,-1
/* 8002CBE4 00408021 */  move     $s0,$v0
/* 8002CBE8 12400003 */  beqz     $s2,.L8002CBF8
/* 8002CBEC ac830584 */  sw       $v1,1412($a0)
/* 8002CBF0 0c00d289 */  jal      func_80034A24
/* 8002CBF4 00000000 */  nop      
.L8002CBF8:
/* 8002CBF8 3c028005 */  lui      $v0,0x8005
/* 8002CBFC 8c441db0 */  lw       $a0,7600($v0)
/* 8002CC00 0c0062b7 */  jal      func_80018ADC
/* 8002CC04 248402d0 */  addiu    $a0,$a0,720
/* 8002CC08 02001021 */  move     $v0,$s0
/* 8002CC0C 8fbf001c */  lw       $ra,28($sp)
/* 8002CC10 8fb20018 */  lw       $s2,24($sp)
/* 8002CC14 8fb10014 */  lw       $s1,20($sp)
/* 8002CC18 8fb00010 */  lw       $s0,16($sp)
/* 8002CC1C 03e00008 */  jr       $ra
/* 8002CC20 27bd0020 */  addiu    $sp,$sp,32
