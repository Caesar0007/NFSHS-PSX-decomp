.set noat
.set noreorder

glabel func_8002CB3C
/* 8002CB3C 27bdff38 */  addiu    $sp,$sp,-200
/* 8002CB40 afbf00c0 */  sw       $ra,192($sp)
/* 8002CB44 afb100bc */  sw       $s1,188($sp)
/* 8002CB48 0c008dfc */  jal      func_800237F0
/* 8002CB4C afb000b8 */  sw       $s0,184($sp)
/* 8002CB50 38420001 */  xori     $v0,$v0,0x1
/* 8002CB54 10400025 */  beqz     $v0,.L8002CBEC
/* 8002CB58 24110001 */  li       $s1,1
/* 8002CB5C 27b00010 */  addiu    $s0,$sp,16
/* 8002CB60 0c0066f3 */  jal      func_80019BCC
/* 8002CB64 02002021 */  move     $a0,$s0
/* 8002CB68 24040274 */  li       $a0,628
/* 8002CB6C 3c028001 */  lui      $v0,0x8001
/* 8002CB70 244202a8 */  addiu    $v0,$v0,680
/* 8002CB74 0c02e7c6 */  jal      func_800B9F18
/* 8002CB78 ae020060 */  sw       $v0,96($s0)
/* 8002CB7C 02002021 */  move     $a0,$s0
/* 8002CB80 ae020090 */  sw       $v0,144($s0)
/* 8002CB84 24020322 */  li       $v0,802
/* 8002CB88 ae0200a0 */  sw       $v0,160($s0)
/* 8002CB8C 24020323 */  li       $v0,803
/* 8002CB90 ae0200a4 */  sw       $v0,164($s0)
/* 8002CB94 0c00664a */  jal      func_80019928
/* 8002CB98 a6000088 */  sh       $zero,136($s0)
/* 8002CB9C 00021400 */  sll      $v0,$v0,0x10
/* 8002CBA0 00021c03 */  sra      $v1,$v0,0x10
/* 8002CBA4 10710009 */  beq      $v1,$s1,.L8002CBCC
/* 8002CBA8 00000000 */  nop      
/* 8002CBAC 2402ffff */  li       $v0,-1
/* 8002CBB0 1462000a */  bne      $v1,$v0,.L8002CBDC
/* 8002CBB4 27a40010 */  addiu    $a0,$sp,16
/* 8002CBB8 02002021 */  move     $a0,$s0
/* 8002CBBC 0c009826 */  jal      func_80026098
/* 8002CBC0 24050002 */  li       $a1,2
/* 8002CBC4 0800b2fc */  j        .L8002CBF0
/* 8002CBC8 00001021 */  move     $v0,$zero
.L8002CBCC:
/* 8002CBCC 0c00b288 */  jal      func_8002CA20
/* 8002CBD0 24040001 */  li       $a0,1
/* 8002CBD4 00408821 */  move     $s1,$v0
/* 8002CBD8 27a40010 */  addiu    $a0,$sp,16
.L8002CBDC:
/* 8002CBDC 0c009826 */  jal      func_80026098
/* 8002CBE0 24050002 */  li       $a1,2
/* 8002CBE4 0800b2fc */  j        .L8002CBF0
/* 8002CBE8 02201021 */  move     $v0,$s1
.L8002CBEC:
/* 8002CBEC 24020001 */  li       $v0,1
.L8002CBF0:
/* 8002CBF0 8fbf00c0 */  lw       $ra,192($sp)
/* 8002CBF4 8fb100bc */  lw       $s1,188($sp)
/* 8002CBF8 8fb000b8 */  lw       $s0,184($sp)
/* 8002CBFC 03e00008 */  jr       $ra
/* 8002CC00 27bd00c8 */  addiu    $sp,$sp,200
