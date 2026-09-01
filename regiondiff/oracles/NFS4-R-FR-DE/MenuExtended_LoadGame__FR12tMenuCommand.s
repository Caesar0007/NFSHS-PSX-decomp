.set noat
.set noreorder

glabel func_8002DA20
/* 8002DA20 3c028005 */  lui      $v0,0x8005
/* 8002DA24 8c4222a8 */  lw       $v0,8872($v0)
/* 8002DA28 27bdff30 */  addiu    $sp,$sp,-208
/* 8002DA2C afbf00c8 */  sw       $ra,200($sp)
/* 8002DA30 afb100c4 */  sw       $s1,196($sp)
/* 8002DA34 afb000c0 */  sw       $s0,192($sp)
/* 8002DA38 8c423080 */  lw       $v0,12416($v0)
/* 8002DA3C 00000000 */  nop      
/* 8002DA40 30420001 */  andi     $v0,$v0,0x1
/* 8002DA44 14400027 */  bnez     $v0,.L8002DAE4
/* 8002DA48 27b00010 */  addiu    $s0,$sp,16
/* 8002DA4C 0c006713 */  jal      func_80019C4C
/* 8002DA50 02002021 */  move     $a0,$s0
/* 8002DA54 240402c1 */  li       $a0,705
/* 8002DA58 3c028001 */  lui      $v0,0x8001
/* 8002DA5C 3c118005 */  lui      $s1,0x8005
/* 8002DA60 8e233148 */  lw       $v1,12616($s1)
/* 8002DA64 24420308 */  addiu    $v0,$v0,776
/* 8002DA68 ae020060 */  sw       $v0,96($s0)
/* 8002DA6C 8463059c */  lh       $v1,1436($v1)
/* 8002DA70 24020322 */  li       $v0,802
/* 8002DA74 ae0200a0 */  sw       $v0,160($s0)
/* 8002DA78 24020323 */  li       $v0,803
/* 8002DA7C ae0200a4 */  sw       $v0,164($s0)
/* 8002DA80 3c028005 */  lui      $v0,0x8005
/* 8002DA84 a6000088 */  sh       $zero,136($s0)
/* 8002DA88 0c02e7c7 */  jal      func_800B9F1C
/* 8002DA8C ac4322b8 */  sw       $v1,8888($v0)
/* 8002DA90 02002021 */  move     $a0,$s0
/* 8002DA94 0c00666a */  jal      func_800199A8
/* 8002DA98 ac820090 */  sw       $v0,144($a0)
/* 8002DA9C 00021400 */  sll      $v0,$v0,0x10
/* 8002DAA0 00021403 */  sra      $v0,$v0,0x10
/* 8002DAA4 24030001 */  li       $v1,1
/* 8002DAA8 14430008 */  bne      $v0,$v1,.L8002DACC
/* 8002DAAC 3c028005 */  lui      $v0,0x8005
/* 8002DAB0 8e223148 */  lw       $v0,12616($s1)
/* 8002DAB4 00000000 */  nop      
/* 8002DAB8 8444059c */  lh       $a0,1436($v0)
/* 8002DABC 0c00b663 */  jal      func_8002D98C
/* 8002DAC0 00000000 */  nop      
/* 8002DAC4 0800b6b7 */  j        .L8002DADC
/* 8002DAC8 27a40010 */  addiu    $a0,$sp,16
.L8002DACC:
/* 8002DACC 8c441d70 */  lw       $a0,7536($v0)
/* 8002DAD0 0c0062b1 */  jal      func_80018AC4
/* 8002DAD4 24840238 */  addiu    $a0,$a0,568
/* 8002DAD8 27a40010 */  addiu    $a0,$sp,16
.L8002DADC:
/* 8002DADC 0c009849 */  jal      func_80026124
/* 8002DAE0 24050002 */  li       $a1,2
.L8002DAE4:
/* 8002DAE4 8fbf00c8 */  lw       $ra,200($sp)
/* 8002DAE8 8fb100c4 */  lw       $s1,196($sp)
/* 8002DAEC 8fb000c0 */  lw       $s0,192($sp)
/* 8002DAF0 03e00008 */  jr       $ra
/* 8002DAF4 27bd00d0 */  addiu    $sp,$sp,208
