.set noat
.set noreorder

glabel func_8002CBB4
/* 8002CBB4 27bdff38 */  addiu    $sp,$sp,-200
/* 8002CBB8 afbf00c0 */  sw       $ra,192($sp)
/* 8002CBBC afb100bc */  sw       $s1,188($sp)
/* 8002CBC0 0c008e0a */  jal      func_80023828
/* 8002CBC4 afb000b8 */  sw       $s0,184($sp)
/* 8002CBC8 38420001 */  xori     $v0,$v0,0x1
/* 8002CBCC 10400025 */  beqz     $v0,.L8002CC64
/* 8002CBD0 24110001 */  li       $s1,1
/* 8002CBD4 27b00010 */  addiu    $s0,$sp,16
/* 8002CBD8 0c0066fd */  jal      func_80019BF4
/* 8002CBDC 02002021 */  move     $a0,$s0
/* 8002CBE0 24040274 */  li       $a0,628
/* 8002CBE4 3c028001 */  lui      $v0,0x8001
/* 8002CBE8 244202a8 */  addiu    $v0,$v0,680
/* 8002CBEC 0c02e7c7 */  jal      func_800B9F1C
/* 8002CBF0 ae020060 */  sw       $v0,96($s0)
/* 8002CBF4 02002021 */  move     $a0,$s0
/* 8002CBF8 ae020090 */  sw       $v0,144($s0)
/* 8002CBFC 24020322 */  li       $v0,802
/* 8002CC00 ae0200a0 */  sw       $v0,160($s0)
/* 8002CC04 24020323 */  li       $v0,803
/* 8002CC08 ae0200a4 */  sw       $v0,164($s0)
/* 8002CC0C 0c006654 */  jal      func_80019950
/* 8002CC10 a6000088 */  sh       $zero,136($s0)
/* 8002CC14 00021400 */  sll      $v0,$v0,0x10
/* 8002CC18 00021c03 */  sra      $v1,$v0,0x10
/* 8002CC1C 10710009 */  beq      $v1,$s1,.L8002CC44
/* 8002CC20 00000000 */  nop      
/* 8002CC24 2402ffff */  li       $v0,-1
/* 8002CC28 1462000a */  bne      $v1,$v0,.L8002CC54
/* 8002CC2C 27a40010 */  addiu    $a0,$sp,16
/* 8002CC30 02002021 */  move     $a0,$s0
/* 8002CC34 0c009833 */  jal      func_800260CC
/* 8002CC38 24050002 */  li       $a1,2
/* 8002CC3C 0800b31a */  j        .L8002CC68
/* 8002CC40 00001021 */  move     $v0,$zero
.L8002CC44:
/* 8002CC44 0c00b2a6 */  jal      func_8002CA98
/* 8002CC48 24040001 */  li       $a0,1
/* 8002CC4C 00408821 */  move     $s1,$v0
/* 8002CC50 27a40010 */  addiu    $a0,$sp,16
.L8002CC54:
/* 8002CC54 0c009833 */  jal      func_800260CC
/* 8002CC58 24050002 */  li       $a1,2
/* 8002CC5C 0800b31a */  j        .L8002CC68
/* 8002CC60 02201021 */  move     $v0,$s1
.L8002CC64:
/* 8002CC64 24020001 */  li       $v0,1
.L8002CC68:
/* 8002CC68 8fbf00c0 */  lw       $ra,192($sp)
/* 8002CC6C 8fb100bc */  lw       $s1,188($sp)
/* 8002CC70 8fb000b8 */  lw       $s0,184($sp)
/* 8002CC74 03e00008 */  jr       $ra
/* 8002CC78 27bd00c8 */  addiu    $sp,$sp,200
