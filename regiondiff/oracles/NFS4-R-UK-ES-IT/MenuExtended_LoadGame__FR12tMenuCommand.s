.set noat
.set noreorder

glabel func_8002DA38
/* 8002DA38 3c028005 */  lui      $v0,0x8005
/* 8002DA3C 8c4222e8 */  lw       $v0,8936($v0)
/* 8002DA40 27bdff30 */  addiu    $sp,$sp,-208
/* 8002DA44 afbf00c8 */  sw       $ra,200($sp)
/* 8002DA48 afb100c4 */  sw       $s1,196($sp)
/* 8002DA4C afb000c0 */  sw       $s0,192($sp)
/* 8002DA50 8c423080 */  lw       $v0,12416($v0)
/* 8002DA54 00000000 */  nop      
/* 8002DA58 30420001 */  andi     $v0,$v0,0x1
/* 8002DA5C 14400027 */  bnez     $v0,.L8002DAFC
/* 8002DA60 27b00010 */  addiu    $s0,$sp,16
/* 8002DA64 0c006719 */  jal      func_80019C64
/* 8002DA68 02002021 */  move     $a0,$s0
/* 8002DA6C 240402c1 */  li       $a0,705
/* 8002DA70 3c028001 */  lui      $v0,0x8001
/* 8002DA74 3c118005 */  lui      $s1,0x8005
/* 8002DA78 8e233188 */  lw       $v1,12680($s1)
/* 8002DA7C 24420308 */  addiu    $v0,$v0,776
/* 8002DA80 ae020060 */  sw       $v0,96($s0)
/* 8002DA84 8463059c */  lh       $v1,1436($v1)
/* 8002DA88 24020322 */  li       $v0,802
/* 8002DA8C ae0200a0 */  sw       $v0,160($s0)
/* 8002DA90 24020323 */  li       $v0,803
/* 8002DA94 ae0200a4 */  sw       $v0,164($s0)
/* 8002DA98 3c028005 */  lui      $v0,0x8005
/* 8002DA9C a6000088 */  sh       $zero,136($s0)
/* 8002DAA0 0c02e7c7 */  jal      func_800B9F1C
/* 8002DAA4 ac4322f8 */  sw       $v1,8952($v0)
/* 8002DAA8 02002021 */  move     $a0,$s0
/* 8002DAAC 0c006670 */  jal      func_800199C0
/* 8002DAB0 ac820090 */  sw       $v0,144($a0)
/* 8002DAB4 00021400 */  sll      $v0,$v0,0x10
/* 8002DAB8 00021403 */  sra      $v0,$v0,0x10
/* 8002DABC 24030001 */  li       $v1,1
/* 8002DAC0 14430008 */  bne      $v0,$v1,.L8002DAE4
/* 8002DAC4 3c028005 */  lui      $v0,0x8005
/* 8002DAC8 8e223188 */  lw       $v0,12680($s1)
/* 8002DACC 00000000 */  nop      
/* 8002DAD0 8444059c */  lh       $a0,1436($v0)
/* 8002DAD4 0c00b669 */  jal      func_8002D9A4
/* 8002DAD8 00000000 */  nop      
/* 8002DADC 0800b6bd */  j        .L8002DAF4
/* 8002DAE0 27a40010 */  addiu    $a0,$sp,16
.L8002DAE4:
/* 8002DAE4 8c441db0 */  lw       $a0,7600($v0)
/* 8002DAE8 0c0062b7 */  jal      func_80018ADC
/* 8002DAEC 24840238 */  addiu    $a0,$a0,568
/* 8002DAF0 27a40010 */  addiu    $a0,$sp,16
.L8002DAF4:
/* 8002DAF4 0c00984f */  jal      func_8002613C
/* 8002DAF8 24050002 */  li       $a1,2
.L8002DAFC:
/* 8002DAFC 8fbf00c8 */  lw       $ra,200($sp)
/* 8002DB00 8fb100c4 */  lw       $s1,196($sp)
/* 8002DB04 8fb000c0 */  lw       $s0,192($sp)
/* 8002DB08 03e00008 */  jr       $ra
/* 8002DB0C 27bd00d0 */  addiu    $sp,$sp,208
