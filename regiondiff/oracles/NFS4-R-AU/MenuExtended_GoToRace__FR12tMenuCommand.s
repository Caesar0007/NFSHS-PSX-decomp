.set noat
.set noreorder

glabel func_8002CD90
/* 8002CD90 27bdff08 */  addiu    $sp,$sp,-248
/* 8002CD94 afb300ec */  sw       $s3,236($sp)
/* 8002CD98 00809821 */  move     $s3,$a0
/* 8002CD9C 3c028005 */  lui      $v0,0x8005
/* 8002CDA0 8c431a60 */  lw       $v1,6752($v0)
/* 8002CDA4 24020005 */  li       $v0,5
/* 8002CDA8 afbf00f0 */  sw       $ra,240($sp)
/* 8002CDAC afb200e8 */  sw       $s2,232($sp)
/* 8002CDB0 afb100e4 */  sw       $s1,228($sp)
/* 8002CDB4 afb000e0 */  sw       $s0,224($sp)
/* 8002CDB8 ae620000 */  sw       $v0,0($s3)
/* 8002CDBC 3c028011 */  lui      $v0,0x8011
/* 8002CDC0 245258e4 */  addiu    $s2,$v0,22756
/* 8002CDC4 24020001 */  li       $v0,1
/* 8002CDC8 9250012a */  lbu      $s0,298($s2)
/* 8002CDCC 00000000 */  nop      
/* 8002CDD0 1602000e */  bne      $s0,$v0,.L8002CE0C
/* 8002CDD4 2471002c */  addiu    $s1,$v1,44
/* 8002CDD8 3c048011 */  lui      $a0,0x8011
/* 8002CDDC 24845558 */  addiu    $a0,$a0,21848
/* 8002CDE0 0c005d29 */  jal      func_800174A4
/* 8002CDE4 00002821 */  move     $a1,$zero
/* 8002CDE8 00021400 */  sll      $v0,$v0,0x10
/* 8002CDEC 1c400008 */  bgtz     $v0,.L8002CE10
/* 8002CDF0 3c028011 */  lui      $v0,0x8011
/* 8002CDF4 92430004 */  lbu      $v1,4($s2)
/* 8002CDF8 00000000 */  nop      
/* 8002CDFC 10700003 */  beq      $v1,$s0,.L8002CE0C
/* 8002CE00 24020006 */  li       $v0,6
/* 8002CE04 1462002c */  bne      $v1,$v0,.L8002CEB8
/* 8002CE08 240400ab */  li       $a0,171
.L8002CE0C:
/* 8002CE0C 3c028011 */  lui      $v0,0x8011
.L8002CE10:
/* 8002CE10 904358e8 */  lbu      $v1,22760($v0)
/* 8002CE14 24020002 */  li       $v0,2
/* 8002CE18 1462000a */  bne      $v1,$v0,.L8002CE44
/* 8002CE1C 3c028011 */  lui      $v0,0x8011
/* 8002CE20 3c048011 */  lui      $a0,0x8011
/* 8002CE24 24845558 */  addiu    $a0,$a0,21848
/* 8002CE28 0c005d3a */  jal      func_800174E8
/* 8002CE2C 00002821 */  move     $a1,$zero
/* 8002CE30 00021400 */  sll      $v0,$v0,0x10
/* 8002CE34 1c400003 */  bgtz     $v0,.L8002CE44
/* 8002CE38 3c028011 */  lui      $v0,0x8011
/* 8002CE3C 0800b3ae */  j        .L8002CEB8
/* 8002CE40 240400f2 */  li       $a0,242
.L8002CE44:
/* 8002CE44 244558e4 */  addiu    $a1,$v0,22756
/* 8002CE48 90a30004 */  lbu      $v1,4($a1)
/* 8002CE4C 24020001 */  li       $v0,1
/* 8002CE50 1462000c */  bne      $v1,$v0,.L8002CE84
/* 8002CE54 3c028011 */  lui      $v0,0x8011
/* 8002CE58 3c048011 */  lui      $a0,0x8011
/* 8002CE5C 24845558 */  addiu    $a0,$a0,21848
/* 8002CE60 90a5005c */  lbu      $a1,92($a1)
/* 8002CE64 0c005c00 */  jal      func_80017000
/* 8002CE68 27a60010 */  addiu    $a2,$sp,16
/* 8002CE6C 93a200cf */  lbu      $v0,207($sp)
/* 8002CE70 00000000 */  nop      
/* 8002CE74 14400003 */  bnez     $v0,.L8002CE84
/* 8002CE78 3c028011 */  lui      $v0,0x8011
/* 8002CE7C 0800b3ae */  j        .L8002CEB8
/* 8002CE80 240400f3 */  li       $a0,243
.L8002CE84:
/* 8002CE84 244358e4 */  addiu    $v1,$v0,22756
/* 8002CE88 9062012a */  lbu      $v0,298($v1)
/* 8002CE8C 00000000 */  nop      
/* 8002CE90 1440000f */  bnez     $v0,.L8002CED0
/* 8002CE94 3c048011 */  lui      $a0,0x8011
/* 8002CE98 24845558 */  addiu    $a0,$a0,21848
/* 8002CE9C 9065005c */  lbu      $a1,92($v1)
/* 8002CEA0 0c005c00 */  jal      func_80017000
/* 8002CEA4 27a60010 */  addiu    $a2,$sp,16
/* 8002CEA8 93a20017 */  lbu      $v0,23($sp)
/* 8002CEAC 00000000 */  nop      
/* 8002CEB0 14400007 */  bnez     $v0,.L8002CED0
/* 8002CEB4 240400f4 */  li       $a0,244
.L8002CEB8:
/* 8002CEB8 0c02e7c7 */  jal      func_800B9F1C
/* 8002CEBC 00000000 */  nop      
/* 8002CEC0 02202021 */  move     $a0,$s1
/* 8002CEC4 0c00626a */  jal      func_800189A8
/* 8002CEC8 ac820090 */  sw       $v0,144($a0)
/* 8002CECC ae600000 */  sw       $zero,0($s3)
.L8002CED0:
/* 8002CED0 8fbf00f0 */  lw       $ra,240($sp)
/* 8002CED4 8fb300ec */  lw       $s3,236($sp)
/* 8002CED8 8fb200e8 */  lw       $s2,232($sp)
/* 8002CEDC 8fb100e4 */  lw       $s1,228($sp)
/* 8002CEE0 8fb000e0 */  lw       $s0,224($sp)
/* 8002CEE4 03e00008 */  jr       $ra
/* 8002CEE8 27bd00f8 */  addiu    $sp,$sp,248
