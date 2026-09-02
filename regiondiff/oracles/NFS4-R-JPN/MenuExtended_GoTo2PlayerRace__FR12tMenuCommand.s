.set noat
.set noreorder

glabel func_8002CABC
/* 8002CABC 27bdff08 */  addiu    $sp,$sp,-248
/* 8002CAC0 afb300ec */  sw       $s3,236($sp)
/* 8002CAC4 00809821 */  move     $s3,$a0
/* 8002CAC8 3c038005 */  lui      $v1,0x8005
/* 8002CACC 3c028011 */  lui      $v0,0x8011
/* 8002CAD0 afb100e4 */  sw       $s1,228($sp)
/* 8002CAD4 245156a4 */  addiu    $s1,$v0,22180
/* 8002CAD8 8c621470 */  lw       $v0,5232($v1)
/* 8002CADC 24040006 */  li       $a0,6
/* 8002CAE0 afbf00f0 */  sw       $ra,240($sp)
/* 8002CAE4 afb200e8 */  sw       $s2,232($sp)
/* 8002CAE8 afb000e0 */  sw       $s0,224($sp)
/* 8002CAEC ae640000 */  sw       $a0,0($s3)
/* 8002CAF0 92230004 */  lbu      $v1,4($s1)
/* 8002CAF4 00000000 */  nop      
/* 8002CAF8 1064003c */  beq      $v1,$a0,.L8002CBEC
/* 8002CAFC 2452002c */  addiu    $s2,$v0,44
/* 8002CB00 9230012a */  lbu      $s0,298($s1)
/* 8002CB04 24020001 */  li       $v0,1
/* 8002CB08 1602000d */  bne      $s0,$v0,.L8002CB40
/* 8002CB0C 3c028011 */  lui      $v0,0x8011
/* 8002CB10 3c048011 */  lui      $a0,0x8011
/* 8002CB14 24845318 */  addiu    $a0,$a0,21272
/* 8002CB18 0c005cb1 */  jal      func_800172C4
/* 8002CB1C 00002821 */  move     $a1,$zero
/* 8002CB20 00021400 */  sll      $v0,$v0,0x10
/* 8002CB24 1c400006 */  bgtz     $v0,.L8002CB40
/* 8002CB28 3c028011 */  lui      $v0,0x8011
/* 8002CB2C 92220004 */  lbu      $v0,4($s1)
/* 8002CB30 00000000 */  nop      
/* 8002CB34 14500027 */  bne      $v0,$s0,.L8002CBD4
/* 8002CB38 240400ab */  li       $a0,171
/* 8002CB3C 3c028011 */  lui      $v0,0x8011
.L8002CB40:
/* 8002CB40 244356a4 */  addiu    $v1,$v0,22180
/* 8002CB44 9062012a */  lbu      $v0,298($v1)
/* 8002CB48 00000000 */  nop      
/* 8002CB4C 14400010 */  bnez     $v0,.L8002CB90
/* 8002CB50 3c028011 */  lui      $v0,0x8011
/* 8002CB54 3c028005 */  lui      $v0,0x8005
/* 8002CB58 8c421470 */  lw       $v0,5232($v0)
/* 8002CB5C 3c048011 */  lui      $a0,0x8011
/* 8002CB60 9042022c */  lbu      $v0,556($v0)
/* 8002CB64 24845318 */  addiu    $a0,$a0,21272
/* 8002CB68 00431021 */  addu     $v0,$v0,$v1
/* 8002CB6C 9045005c */  lbu      $a1,92($v0)
/* 8002CB70 0c005b88 */  jal      func_80016E20
/* 8002CB74 27a60010 */  addiu    $a2,$sp,16
/* 8002CB78 93a20017 */  lbu      $v0,23($sp)
/* 8002CB7C 00000000 */  nop      
/* 8002CB80 14400003 */  bnez     $v0,.L8002CB90
/* 8002CB84 3c028011 */  lui      $v0,0x8011
/* 8002CB88 0800b2f5 */  j        .L8002CBD4
/* 8002CB8C 240400f4 */  li       $a0,244
.L8002CB90:
/* 8002CB90 244556a4 */  addiu    $a1,$v0,22180
/* 8002CB94 90a30004 */  lbu      $v1,4($a1)
/* 8002CB98 24020001 */  li       $v0,1
/* 8002CB9C 14620013 */  bne      $v1,$v0,.L8002CBEC
/* 8002CBA0 3c028005 */  lui      $v0,0x8005
/* 8002CBA4 8c421470 */  lw       $v0,5232($v0)
/* 8002CBA8 3c048011 */  lui      $a0,0x8011
/* 8002CBAC 9042022c */  lbu      $v0,556($v0)
/* 8002CBB0 24845318 */  addiu    $a0,$a0,21272
/* 8002CBB4 00451021 */  addu     $v0,$v0,$a1
/* 8002CBB8 9045005c */  lbu      $a1,92($v0)
/* 8002CBBC 0c005b88 */  jal      func_80016E20
/* 8002CBC0 27a60010 */  addiu    $a2,$sp,16
/* 8002CBC4 93a200cf */  lbu      $v0,207($sp)
/* 8002CBC8 00000000 */  nop      
/* 8002CBCC 14400007 */  bnez     $v0,.L8002CBEC
/* 8002CBD0 240400f3 */  li       $a0,243
.L8002CBD4:
/* 8002CBD4 0c02e733 */  jal      func_800B9CCC
/* 8002CBD8 00000000 */  nop      
/* 8002CBDC 02402021 */  move     $a0,$s2
/* 8002CBE0 0c0061f2 */  jal      func_800187C8
/* 8002CBE4 ac820090 */  sw       $v0,144($a0)
/* 8002CBE8 ae600000 */  sw       $zero,0($s3)
.L8002CBEC:
/* 8002CBEC 8fbf00f0 */  lw       $ra,240($sp)
/* 8002CBF0 8fb300ec */  lw       $s3,236($sp)
/* 8002CBF4 8fb200e8 */  lw       $s2,232($sp)
/* 8002CBF8 8fb100e4 */  lw       $s1,228($sp)
/* 8002CBFC 8fb000e0 */  lw       $s0,224($sp)
/* 8002CC00 03e00008 */  jr       $ra
/* 8002CC04 27bd00f8 */  addiu    $sp,$sp,248
