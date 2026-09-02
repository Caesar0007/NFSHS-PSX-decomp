.set noat
.set noreorder

glabel func_8002CC0C
/* 8002CC0C 27bdff38 */  addiu    $sp,$sp,-200
/* 8002CC10 afbf00c0 */  sw       $ra,192($sp)
/* 8002CC14 afb100bc */  sw       $s1,188($sp)
/* 8002CC18 0c008e20 */  jal      func_80023880
/* 8002CC1C afb000b8 */  sw       $s0,184($sp)
/* 8002CC20 38420001 */  xori     $v0,$v0,0x1
/* 8002CC24 10400025 */  beqz     $v0,.L8002CCBC
/* 8002CC28 24110001 */  li       $s1,1
/* 8002CC2C 27b00010 */  addiu    $s0,$sp,16
/* 8002CC30 0c006713 */  jal      func_80019C4C
/* 8002CC34 02002021 */  move     $a0,$s0
/* 8002CC38 24040274 */  li       $a0,628
/* 8002CC3C 3c028001 */  lui      $v0,0x8001
/* 8002CC40 244202a8 */  addiu    $v0,$v0,680
/* 8002CC44 0c02e7c7 */  jal      func_800B9F1C
/* 8002CC48 ae020060 */  sw       $v0,96($s0)
/* 8002CC4C 02002021 */  move     $a0,$s0
/* 8002CC50 ae020090 */  sw       $v0,144($s0)
/* 8002CC54 24020322 */  li       $v0,802
/* 8002CC58 ae0200a0 */  sw       $v0,160($s0)
/* 8002CC5C 24020323 */  li       $v0,803
/* 8002CC60 ae0200a4 */  sw       $v0,164($s0)
/* 8002CC64 0c00666a */  jal      func_800199A8
/* 8002CC68 a6000088 */  sh       $zero,136($s0)
/* 8002CC6C 00021400 */  sll      $v0,$v0,0x10
/* 8002CC70 00021c03 */  sra      $v1,$v0,0x10
/* 8002CC74 10710009 */  beq      $v1,$s1,.L8002CC9C
/* 8002CC78 00000000 */  nop      
/* 8002CC7C 2402ffff */  li       $v0,-1
/* 8002CC80 1462000a */  bne      $v1,$v0,.L8002CCAC
/* 8002CC84 27a40010 */  addiu    $a0,$sp,16
/* 8002CC88 02002021 */  move     $a0,$s0
/* 8002CC8C 0c009849 */  jal      func_80026124
/* 8002CC90 24050002 */  li       $a1,2
/* 8002CC94 0800b330 */  j        .L8002CCC0
/* 8002CC98 00001021 */  move     $v0,$zero
.L8002CC9C:
/* 8002CC9C 0c00b2bc */  jal      func_8002CAF0
/* 8002CCA0 24040001 */  li       $a0,1
/* 8002CCA4 00408821 */  move     $s1,$v0
/* 8002CCA8 27a40010 */  addiu    $a0,$sp,16
.L8002CCAC:
/* 8002CCAC 0c009849 */  jal      func_80026124
/* 8002CCB0 24050002 */  li       $a1,2
/* 8002CCB4 0800b330 */  j        .L8002CCC0
/* 8002CCB8 02201021 */  move     $v0,$s1
.L8002CCBC:
/* 8002CCBC 24020001 */  li       $v0,1
.L8002CCC0:
/* 8002CCC0 8fbf00c0 */  lw       $ra,192($sp)
/* 8002CCC4 8fb100bc */  lw       $s1,188($sp)
/* 8002CCC8 8fb000b8 */  lw       $s0,184($sp)
/* 8002CCCC 03e00008 */  jr       $ra
/* 8002CCD0 27bd00c8 */  addiu    $sp,$sp,200
