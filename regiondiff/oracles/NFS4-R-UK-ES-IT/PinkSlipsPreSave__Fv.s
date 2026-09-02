.set noat
.set noreorder

glabel func_8002CC24
/* 8002CC24 27bdff38 */  addiu    $sp,$sp,-200
/* 8002CC28 afbf00c0 */  sw       $ra,192($sp)
/* 8002CC2C afb100bc */  sw       $s1,188($sp)
/* 8002CC30 0c008e26 */  jal      func_80023898
/* 8002CC34 afb000b8 */  sw       $s0,184($sp)
/* 8002CC38 38420001 */  xori     $v0,$v0,0x1
/* 8002CC3C 10400025 */  beqz     $v0,.L8002CCD4
/* 8002CC40 24110001 */  li       $s1,1
/* 8002CC44 27b00010 */  addiu    $s0,$sp,16
/* 8002CC48 0c006719 */  jal      func_80019C64
/* 8002CC4C 02002021 */  move     $a0,$s0
/* 8002CC50 24040274 */  li       $a0,628
/* 8002CC54 3c028001 */  lui      $v0,0x8001
/* 8002CC58 244202a8 */  addiu    $v0,$v0,680
/* 8002CC5C 0c02e7c7 */  jal      func_800B9F1C
/* 8002CC60 ae020060 */  sw       $v0,96($s0)
/* 8002CC64 02002021 */  move     $a0,$s0
/* 8002CC68 ae020090 */  sw       $v0,144($s0)
/* 8002CC6C 24020322 */  li       $v0,802
/* 8002CC70 ae0200a0 */  sw       $v0,160($s0)
/* 8002CC74 24020323 */  li       $v0,803
/* 8002CC78 ae0200a4 */  sw       $v0,164($s0)
/* 8002CC7C 0c006670 */  jal      func_800199C0
/* 8002CC80 a6000088 */  sh       $zero,136($s0)
/* 8002CC84 00021400 */  sll      $v0,$v0,0x10
/* 8002CC88 00021c03 */  sra      $v1,$v0,0x10
/* 8002CC8C 10710009 */  beq      $v1,$s1,.L8002CCB4
/* 8002CC90 00000000 */  nop      
/* 8002CC94 2402ffff */  li       $v0,-1
/* 8002CC98 1462000a */  bne      $v1,$v0,.L8002CCC4
/* 8002CC9C 27a40010 */  addiu    $a0,$sp,16
/* 8002CCA0 02002021 */  move     $a0,$s0
/* 8002CCA4 0c00984f */  jal      func_8002613C
/* 8002CCA8 24050002 */  li       $a1,2
/* 8002CCAC 0800b336 */  j        .L8002CCD8
/* 8002CCB0 00001021 */  move     $v0,$zero
.L8002CCB4:
/* 8002CCB4 0c00b2c2 */  jal      func_8002CB08
/* 8002CCB8 24040001 */  li       $a0,1
/* 8002CCBC 00408821 */  move     $s1,$v0
/* 8002CCC0 27a40010 */  addiu    $a0,$sp,16
.L8002CCC4:
/* 8002CCC4 0c00984f */  jal      func_8002613C
/* 8002CCC8 24050002 */  li       $a1,2
/* 8002CCCC 0800b336 */  j        .L8002CCD8
/* 8002CCD0 02201021 */  move     $v0,$s1
.L8002CCD4:
/* 8002CCD4 24020001 */  li       $v0,1
.L8002CCD8:
/* 8002CCD8 8fbf00c0 */  lw       $ra,192($sp)
/* 8002CCDC 8fb100bc */  lw       $s1,188($sp)
/* 8002CCE0 8fb000b8 */  lw       $s0,184($sp)
/* 8002CCE4 03e00008 */  jr       $ra
/* 8002CCE8 27bd00c8 */  addiu    $sp,$sp,200
